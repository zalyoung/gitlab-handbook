---
title: "Encryption key rotation"
status: proposed
creation-date: "2024-12-03"
authors: [ "@rymai" ]
coach: [ "@andrewn", "@grzesiek" ]
approvers: []
owning-stage: "~devops::tenant scale"
participating-stages: []
toc_hide: true
---

{{< design-document-header >}}

## Summary

We need a solution to rotate [the `db_key_base` secret](https://docs.gitlab.com/ee/development/application_secrets.html)
without having to put GitLab offline.

## Motivation

[The `db_key_base` secret](https://docs.gitlab.com/ee/development/application_secrets.html) is used to encrypt data at
rest in the GitLab databse. Its rotation is currently not possible without downtime, and there's no automation, script
or even process for it.
Given the criticality of this secret, the goal is to design a solution that allows the secret to be rotated while
GitLab stays online.

With the Dedicated and Cells effort, the criticality of this secret and its rotation is multiplied by the number of
instances deployed, for two reasons:

- The likelihood of a secret leak (through accidental or malicious means) increases with the number of instances deployed (and we expect to deploy more and more of these).
- The amount of work needed to rotate a secret increases with the number of instances deployed (and we expect to deploy more and more of these).

A lot of discussions happened to discuss the problem and potential solutions. The main issue where this was discussed
is <https://gitlab.com/gitlab-org/gitlab/-/issues/25332>. In this issue

### Goals

Provide GitLab administrators with a way to:

- Introduce a new encryption key with an explicit enablement toggling to ensure all nodes have the new key before it's
  used to encrypt new/updated records with it
- Introduce scripts to re-encrypt all the data while GitLab is offline
- Introduce an automated background process (with automated throttling to avoid degrading database performance) to take
  care of progressive re-encryption while GitLab is online
- Monitor the progress for the re-encryption of data encrypted with legacy keys, and overall usage of each key

#### Use cases

- The `db_key_base` secret leaked and needs to be rotated.
- A security policy advise to rotate the `db_key_base` secret regularly

### Non-goals

This blueprint does not cover the following:

- Other secrets such as `secret_key_base`, `otp_key_base`, `openid_connect_signing_key`, and
  `encrypted_settings_key_base`, but ideally it should describe a solution that's generic enough to be applied to other
  secrets without too much changes in the future.
- Possibility to rotate the secret from the Admin UI (this would require writing to the `secrets.yml` at runtime, which
  is impossible with most deployment strategies)
- Possibility to pull secrets from external secrets manager. While this is related, it should be solved with another proposal.

## Decisions

## Proposal

The idea is based on 2 pre-requisites:

1. Support for multiple encryption keys: this allows online rotation of the secret
1. Ability to know what key was used to encrypt an attribute: this allows to re-encrypt data encrypted with a legacy key

The high-level proposal is as follows:

1. When a key need to be rotated, just add a new one last to the `db_key_base` array in `config/secrets.yml`, and restart GitLab.
1. Once the new secret is deployed to all nodes, the new key should be explicitely enabled, so that from now on, data
   will be encrypted with this new key.
1. The decryption process will use the key that was used to encrypt the data.
   In the case the encryption key fingerprint isn't stored alongside the encrypted data, the decryption proceess will
   try each key (in the order they appear in the `db_key_base` array), until it can decrypt the data.
   That way, there's no need to bring GitLab down to mass-re-encrypt all data.
1. A background process continuously runs to re-encrypt any data that was encrypted with a legacy key (i.e. not the
   last item from the `db_key_base` array).
   The whole re-encryption process would likely take a long time on big instances (e.g. GitLab.com), but as long as we have a
   limiting/throttling mechanism in place, it shouldn't impact the database stability.
   The background process becomes a no-op as soon as all the data is re-encrypted with the current key.
1. A new dedicated Admin page allows to monitor the encrypted data status:
   - How many records are still encrypted with a legacy key?
   - What's the expected ETA for everything to be re-encrypted with the current key?
   - What keys can be deleted (i.e. no data is encrypted with this key)?

### New "Encryption keys" admin page

!["Encryption keys" admin page](/images/handbook/engineering/architecture/design-documents/encryption_key_rotation/encryption-keys-admin-page.png)

### Technical details

#### Keys tracking

Key fingerprints will be stored in the database, for different reasons:

- Ability to explicitely enable a key once it's been deployed to all nodes. Otherwise, a key could be used on a node to
  encrypt data, but another node could be unable to read the data until it's deployed with the new key.
- Ability to build complex features around keys management and rotation
- Ability to keep a history of deleted keys

NOTE:
The actual keys used to encrypt/decrypt would still come from the `config/secrets.yml` file. Until the keys status is
read from the database, the oldest key would be used to encrypt/decrypt data. Hopefully, this would only mean during
the initialization of the application (i.e. before the database is ready).

#### Background re-encryption process

Following is a naive implementation of what the background re-encryption process.

```ruby
current_key_id = ActiveRecord::Encryption::DerivedSecretKeyProvider.new(ActiveRecord::Encryption.config.primary_key.last).encryption_key.id

# ActiveRecord::Encryption
ApplicationRecord.descendants.select { |d| d.encrypted_attributes.present? }.each do |model|
  model.where("NOT (#{attr}->'h'->'i') ? :value", value: ::Base64.strict_encode64(current_key_id)).find_in_batches do |batch|
    batch.each do |record|
      record.encrypt # this forces the re-encryption of all encrypted attribute
    end
  end
end

# TokenAuthenticatable
ApplicationRecord.descendants.select { |d| d.include?(TokenAuthenticatable) && d.encrypted_token_authenticatable_fields.present? }.each do |model|
  encrypted_fields = model.encrypted_token_authenticatable_fields

  model.where.not(encryption_key_id: ::Base64.strict_encode64(current_key_id)).find_in_batches do |batch|
    batch.each do |record|
      encrypted_fields.each do |field|
        record.public_send(:"#{field}=", record.public_send(field))
      end
      record.save!
    end
  end
end

# attr_encrypted
ApplicationRecord.descendants.select { |d| d.attr_encrypted_attributes.present? }.each do |model|
  encrypted_fields = model.attr_encrypted_attributes

  model.where.not(encryption_key_id: ::Base64.strict_encode64(current_key_id)).find_in_batches do |batch|
    batch.each do |record|
      encrypted_fields.each do |field|
        record.public_send(:"#{field}=", record.public_send(field))
      end
      record.save!
    end
  end
end
```

The final implementation could build upon
[the Background migration framework, which includes a throttling mechanism](https://docs.gitlab.com/ee/development/database/batched_background_migrations.html#throttling-batched-migrations).

Also, using the Background migration framework, we could have one background migration per table to be re-encrypted,
and report [its progress](https://docs.gitlab.com/ee/development/database/batched_background_migrations.html#monitor-the-progress-and-status-of-a-batched-background-migration)
directly in the admin UI.

### Data encrypted through `ActiveRecord::Encryption`

The `ActiveRecord::Encryption` framework already fullfills the pre-requisites (except for rotating deterministic keys,
but we might work around that, or even implement proper support for it), so as soon as
[`ActiveRecord::Encryption` will be set up in the application](https://gitlab.com/gitlab-org/gitlab/-/issues/490590),
the implementation of the proposal will become possible.

### Data encrypted through `attr_encrypted` and `TokenAuthenticatable`

Currently, `attr_encrypted` and `TokenAuthenticatable` don't store the fingerprint of the key used to encrypt an attribute.
We could introduce a new `encryption_key_id` column (4 chars) to tables that include encrypted columns.

A single `encryption_key_id` column per table is enough since the same key is used to encrypt all encrypted attributes
for a given record.

The key ID can be computed with `Digest::SHA1.hexdigest(secret).first(4)`
(inspired by <https://github.com/rails/rails/blob/v7.0.8.6/activerecord/lib/active_record/encryption/key.rb#L24>).

Once introduced, a post-deploy migration should populate all rows with the current key fingerprint.

The implementation of `attr_encrypted` and `TokenAuthenticatable` would need to be modified to populate the
`encryption_key_id` attribute.

**In the future, we should progressively migrate all the usage of `attr_encrypted` and `TokenAuthenticatable` to
`ActiveRecord::Encryption`.**

## Challenges

### Rotation of deterministic key

Deterministic encryption allows to query a table for a specific column value (e.g. personal access tokens are currently
queried by their digest, but we should migrate them to be encrypted instead so that we can rotate the key without
invalidating all the tokens).

`ActiveRecord::Encryption` doesn't support deterministic keys rotation at the moment, support for it should be
implemented either in GitLab, or in Rails directly.

That said, we might be able to work around this limitation by specifying explicitly the key to use so that under the
hood it'll use the `DerivedSecretKeyProvider` with `deterministic: true` option, i.e.

```ruby
encrypts :token, key: ActiveRecord::Encryption.config.deterministic_key, deterministic: true
```

This would work because when the `key` is specified explicitely, the `DerivedSecretKeyProvider` is used which supports
multiple keys: https://github.com/rails/rails/blob/v7.0.8.6/activerecord/lib/active_record/encryption/scheme.rb#L91

## Proof of Concept

A Proof of Concept merge request was created to show that support of multiple encryption keys is possible today for
both `attr_encrypted` and `TokenAuthenticatable`: <https://gitlab.com/gitlab-org/gitlab/-/merge_requests/167067>.

What's missing from this PoC is the second pre-requisite [from the above proposal](#proposal): the ability to know
what key was used to encrypt an attribute. It's possible to add support for this with the introduction of a new
`encryption_key_id` column per table (except for some cases where different keys are used for different encrypted
attribtues in the same table).

## References

- <https://gitlab.com/gitlab-org/gitlab/-/issues/25332>
- <https://gitlab.com/gitlab-org/gitlab/-/issues/26243>
- <https://gitlab.com/groups/gitlab-org/-/epics/10193>
- <https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/team/-/issues/594> (confidential)
- <https://gitlab.com/gitlab-org/gitlab/-/issues/228663> (confidential)
- <https://gitlab.com/gitlab-com/gl-security/security-department-meta/-/issues/756> (confidential)
- <https://gitlab.com/gitlab-com/gl-infra/production-engineering/-/issues/12927> (confidential)
- <https://gitlab.com/gitlab-org/gitlab/-/issues/244855> (confidential)
- <https://gitlab.com/groups/gitlab-com/gl-infra/-/epics/443> (confidential)

## Who

DRIs:

<!-- vale gitlab.Spelling = NO -->

| Role                | Who                                            |
|---------------------|------------------------------------------------|
| Author              | Rémy Coutable, Principal Engineer              |

<!-- vale gitlab.Spelling = YES -->
