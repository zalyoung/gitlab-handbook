---
title: "Encryption keys rotation"
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

We need a solution to rotate [encryption keys](https://docs.gitlab.com/ee/development/application_secrets.html)
without having to put GitLab offline.

## Motivation

[The `db_key_base`/`active_record_encryption_primary_key`/`active_record_encryption_deterministic_key` keys](https://docs.gitlab.com/ee/development/application_secrets.html)
are used to encrypt data at rest in the GitLab database (`db_key_base` is used by the `attr_encrypted` gem and the
`TokenAuthenticatable` framework, while `active_record_encryption_primary_key` &
`active_record_encryption_deterministic_key` are used by Active Record Encryption, which is Rails' native encryption
framework).
Their rotation is currently not possible without downtime, and there's no automation, script or even process for it.
Given the criticality of these secrets, the goal is to design a solution that allows these secrets to be rotated while
GitLab stays online.

With the Dedicated and Cells effort, the criticality of this secret and its rotation is multiplied by the increasing
number of instances deployed, for two reasons:

- The likelihood of a secret leak (through accidental or malicious means) increases with the number of instances deployed
- The amount of work needed to rotate a secret increases with the number of instances deployed

A lot of discussions happened to discuss the problem and potential solutions but no formal proposal was ever made.
The main issue where this was discussed is <https://gitlab.com/gitlab-org/gitlab/-/issues/25332>.

### Goals

Provide GitLab administrators with a way to:

- Introduce a new encryption key with an explicit enablement toggling (through UI, API, or rake task) to ensure all
  nodes have the new key before it's used to encrypt new/updated records with it.
  This is important in the scenario where an administrator adds a new key to `config/secrets.yml`, and then kicks off a
  new deployment. During the deployment phase, some of the pods/VMs will not have the new key. It's critical that the
  new pods/VMs don't start re-encrypting using the new key until the deployment is completed.
  When the deployment completes successfully, all pods/VMs now have the new key and the administrator can transition
  the new key to `active`.
- Introduce an always-running background process (with automated throttling to avoid degrading database performance) to take
  care of progressive re-encryption while GitLab stays online. The process would look up and re-encrypt any data
  encrypted with the non-current encryption key.
- Monitor the progress for the re-encryption of data encrypted with legacy keys, and overall usage of each key.
- Manage keys:
  - Enable a newly introduced key.
  - Disable a legacy key once no data is encrypted with it anymore.

#### Use cases

- An encryption key leaked and needs to be rotated.
- A security policy enforce a regular rotation of encryption keys.

### Non-goals

This blueprint does not cover the following:

- Introduce scripts to re-encrypt all the data while GitLab is offline. While there might be customer use-cases for
  this, we won't implement this initially.
- Other keys & secrets such as `secret_key_base`, `otp_key_base`, `openid_connect_signing_key`, and
  `encrypted_settings_key_base`, but ideally it should describe a solution that's generic enough to be applied to other
  secrets without too much changes in the future.
- Possibility to rotate the encryption keys from the Admin UI (this would require writing to the `config/secrets.yml`
  at runtime, which is impossible with most deployment strategies).
- Possibility to pull encryption keys from an external secrets manager (e.g. GCP and AWS KMS).
  While this is related and more secure, it should be solved with a dedicated proposal.
- Decision to use [envelope encryption or not](https://cloud.google.com/kms/docs/envelope-encryption).
  While envelope encryption has many benefits and is supported natively by Active Record Encryption, the decision to
  use it is independent from this proposal, and should be solved with a dedicated proposal.

## Proposal

The idea is based on 2 pre-requisites:

1. Support for multiple encryption keys: this allows online rotation of the secret
1. Ability to know what key was used to encrypt an attribute: this allows to re-encrypt data encrypted with a legacy key

The high-level proposal is as follows:

1. When a key need to be rotated, just add a new one last to the
   `db_key_base` / `active_record_encryption_primary_key` / `active_record_encryption_deterministic_key` arrays in
   `config/secrets.yml`, and restart GitLab.
1. Once the new secret is deployed to all nodes, the new key should be explicitely enabled, so that from now on, data
   is encrypted with this new key.
1. The decryption process uses the key that was used to encrypt the data.
   In the case the encryption key fingerprint isn't stored alongside the encrypted data, the decryption process tries
   each key (in the order they appear in the key arrays), until it can decrypt the data.
   That way, there's no need to bring GitLab down to mass-re-encrypt all data.
1. A background process continuously runs to re-encrypt any data that was encrypted with the non-current encryption key.
   The whole re-encryption process would likely take a long time on big instances (e.g. GitLab.com), but as long as we
   have a limiting/throttling mechanism in place, it shouldn't impact the database stability.
   The background process becomes a no-op as soon as all the data is re-encrypted with the current encryption key.
1. A new dedicated admin page allows to manage and monitor the encryption key usage:
   - What percentage of data is encrypted with each active encryption/decryption keys?
   - What's the expected ETA for everything to be re-encrypted with the current encryption key?
   - What keys can be removed (i.e. no data is encrypted with this key and the key is `retired` already)?

### "Encryption keys" admin page

!["Encryption keys" admin page](/images/handbook/engineering/architecture/design-documents/encryption_keys_rotation/encryption-keys-admin-page.png)

### Technical details

#### Keys management

Keys lifecycle information will be stored in a new `encryption_keys` table, including:

- Key type `key_type`, an enum:
  - `db_key_base`
  - `active_record_encryption_primary_key`
  - `active_record_encryption_deterministic_key`
- Key fingerprint (4 hex chars), (inspired by
  <https://github.com/rails/rails/blob/v7.0.8.6/activerecord/lib/active_record/encryption/key.rb#L24>).
- Key status `status`: `inactive`, `active`, `retired`, `removed`.
  - At first a new key is `inactive`.
  - The new key will need to be explicitely enabled and will transition to `active` to become the current encryption key.
  - The current encryption key is always the `active` record with the highest `id`.
  - All keys from `config/secrets.yml` are available for decryption purpose. The encryption key fingerprint should be stored alongside
    encrypted data so that the decryption key doesn't have to be guessed from the active keys.
  - Once no data is encrypted with an `active` key anymore, it can be retired (in which case its status transitions to `retired`).
  - When the key is actually removed from the `config/secrets.yml` file, its corresponding record transitions to
    `removed` (see "During initialization" below).
- Key creation time `created_at`: the first time it appeared in a `config/secrets.yml` file.
- Key activation time `activated_at`: the time when the key transitioned to `active`.
- Key retirement time `retired_at`: the time when the key transitioned to `retired`.
- Key deletion time `removed_at`: the time when the key transitioned to `removed`.

Key statuses state diagram:

```mermaid
stateDiagram-v2
    [*] --> Inactive
    Inactive --> [*]
    Inactive --> Active
    Inactive --> Retired
    Active --> Retired
    Inactive --> Removed
    Active --> Removed
    Retired --> Removed
    Removed --> [*]
```

Keeping track of these information in the database gives the following abilities:

- Ability to explicitely enable a key once it's been deployed to all nodes. Otherwise, a key could be used on a node to
  encrypt data, but another node could be unable to read the data until it's deployed with the new key.
- Ability to build complex features around keys management and rotation.
- Ability to keep a history of keys and their status.

Later on, we could also keep statistics about keys usage in a separate table.

Note: The actual keys used to encrypt/decrypt data would still come from the `config/secrets.yml` file. Until the keys status is
read from the database, the oldest key would be used to encrypt/decrypt data. Hopefully, this would only mean during
the initialization of the application (i.e. before the database is ready).

##### During initialization

During initialization, if a new key is discovered in `config/secrets.yml`, the following 3 steps happens:

1. A record for the new key is created in the `encryption_keys` table (the status of the new key is `inactive`).
   - If its fingerprint collides with an existing non-`removed` key fingerprint, a warning is shown and the key cannot be transitioned to `active`.
     In that case, the key should be removed and replaced with another key.
     Note that a rake task will be provided to perform this collision check before the key is actually added to `config/secrets.yml`.
1. If a key is present in `encryption_keys` but not in `config/secrets.yml` anymore, the record is transitioned from
`inactive` or `retired` to `removed` and `removed_at` is set.
   - If the key was in the `active` state, it's problematic as it means the key was still in use (we can detect such cases
     with `state == "removed" && activated_at != nil && retired_at == nil`).
     The only remediation is to re-add the removed key from a backup. In that case, a new record would be created (and its
     fingerprint wouldn't collide since the previous record would be in the `removed` state).
1. For each key type, if no key is currently active, the latest inactive key is automatically activated.

#### Encryption key selection

The encryption key needs to be dynamically selected based on the `encryption_keys` table.

For `ActiveRecord::Encryption` attributes, we will introduce a
[`GitlabPrimaryKeyProvider` custom key provider](https://guides.rubyonrails.org/active_record_encryption.html#custom-key-providers).

For `attr_encrypted` and `TokenAuthenticatable`, we'll implement the methods in `EncryptionKey`.

##### `GitlabPrimaryKeyProvider` implementation

```ruby
# frozen_string_literal: true

# rubocop:disable Gitlab/BoundedContexts -- Not sure yet
# rubocop:disable Gitlab/NamespacedClass -- Not sure yet
class GitlabPrimaryKeyProvider < ActiveRecord::Encryption::DerivedSecretKeyProvider
  KEY_TYPE = :active_record_encryption_primary_key
  DEFAULT_KEYS = ActiveRecord::Encryption.config.primary_key

  def initialize(passwords = nil)
    if passwords.nil?
      fingerprints = EncryptionKey.active_keys_fingerprints_for_type(key_type)
      passwords = DEFAULT_KEYS.select do |key|
        fingerprints.include?(EncryptionKey.key_fingerprint(key_type: :active_record_encryption_primary_key, key: key))
      end
    end

    super
  end

  def last_key_fingerprint
    @keys.last.id
  end

  # TODO: Cache
  def current_key_fingerprint
    EncryptionKey.latest_active_key_for_type(KEY_TYPE).fingerprint
  end

  def encryption_key
    fingerprint = current_key_fingerprint
    @encryption_key ||= @keys.find do |key|
      key.id == fingerprint
    end

    return unless @encryption_key

    @encryption_key.tap do |key|
      key.public_tags.encrypted_data_key_id = key.id if ActiveRecord::Encryption.config.store_key_references
    end
  end
end
# rubocop:enable Gitlab/BoundedContexts
# rubocop:enable Gitlab/NamespacedClass
```

Notes on caching:

- `GitlabPrimaryKeyProvider#current_key_fingerprint` & `GitlabPrimaryKeyProvider#encryption_key`
  should be cached appropriately to avoid issuing DB queries each time they're called (given encryption is a very
  common and low-level flow).
- For encryption key, caching isn't a problem since it would only delay the usage of a newly-activated encryption key.

##### `GitlabDeterministicKeyProvider` implementation

```ruby
# frozen_string_literal: true

# rubocop:disable Gitlab/BoundedContexts -- Not sure yet
# rubocop:disable Gitlab/NamespacedClass -- Not sure yet
class GitlabDeterministicKeyProvider < GitlabPrimaryKeyProvider
  KEY_TYPE = :active_record_encryption_deterministic_key
  DEFAULT_KEYS = ActiveRecord::Encryption.config.deterministic_key
end
# rubocop:enable Gitlab/BoundedContexts
# rubocop:enable Gitlab/NamespacedClass
```

##### `attr_encrypted` and `TokenAuthenticatable` implementation

The `EncryptionKey.current_db_key_base_encryption_key` and `EncryptionKey.current_db_key_base_decryption_keys` method would
be implemented as follows:

```ruby
  def self.current_db_key_base_encryption_key_fingerprint
    active.where(key_type: :db_key_base).order(activated_at: :desc).limit(1).pick(:fingerprint)
  end

  def self.find_key_from_fingerprint(fingerprint)
    Settings.attr_encrypted_db_key_base_32.find do |key|
      ActiveRecord::Encryption::Key.new(key).id == fingerprint
    end
  end

  def self.current_db_key_base_encryption_key
    find_key_from_fingerprint(current_db_key_base_encryption_key_fingerprint)
  end

  def self.current_db_key_base_decryption_keys(record = nil)
    if record && record.respond_to?(:encryption_key_fingerprint)
      [find_key_from_fingerprint(record.encryption_key_fingerprint)]
    else
      # Select the first key for each fingerprint in normal order (i.e. old to new), to avoid conflicting keys.
      # This allows decryption to use a key that's not yet `active` in the case it became active in another process
      # and data already started to be encrypted with the newly active key. In that case, decryption should be possible
      # right away (i.e. we cannot cache decryption keys otherwise we'd have decryption errors until the cache is
      # expired).
      existing_fingerprints = Set.new
      Settings.attr_encrypted_db_key_base_32.each_with_object([]) do |key, memo|
        fingerprint = ActiveRecord::Encryption::Key.new(key).id
        next if existing_fingerprints.include?(fingerprint)

        existing_fingerprints.add(fingerprint)
        memo << key
      end
    end
  end
```

Notes on caching:

- Same remarks on caching for `EncryptionKey.current_db_key_base_encryption_key` key methods as for `GitlabPrimaryKeyProvider`.
- Caching of `EncryptionKey.current_db_key_base_decryption_keys` would be a problem if a newly-activated key is used for
  encryption, before it's used for decryption. To solve that, all the keys from `config/secrets.yml` should be
  available for decryption at any time (except the ones that would conflict with previous keys, see inline code
  comments above).
  It shouldn't introduce performance issues since we're storing the key fingerprint alongside with the encrypted data,
  and since we shouldn't have more than a handful of keys in `config/secrets.yml` at any time.

##### Changes to `attr_encrypted` calls

The `attr_encrypted` gem supports dynamic key by passing a method name as the `key:` option, e.g.

```ruby
attr_encrypted :email, key: :dynamic_encryption_key

def dynamic_encryption_key
  operation = attr_encrypted_attributes[attribute.to_sym][:operation]

  if operation == :encrypting
    EncryptionKey.current_db_key_base_encryption_key
  else
    EncryptionKey.current_db_key_base_decryption_keys(self)
  end
end
```

##### Changes required for `TokenAuthenticatable`

A few changes would need to be made in `lib/gitlab/crypto_helper.rb`:

```ruby
AES256_GCM_OPTIONS = {
  algorithm: 'aes-256-gcm',
  key: EncryptionKey.current_db_key_base_encryption_key
}.freeze

def aes256_gcm_decrypt(value, nonce: AES256_GCM_IV_STATIC, owner_record: nil)
  return unless value

  encrypted_token = Base64.decode64(value)

  # Try to decrypt with all keys, from oldest to newest
  keys = EncryptionKey.current_db_key_base_decryption_keys(owner_record)
  keys.with_index do |key, index|
    return Encryptor.decrypt( # rubocop:disable Cop/AvoidReturnFromBlocks -- next doesn't work the same here
      AES256_GCM_OPTIONS.merge(value: encrypted_token, key: key, iv: nonce)
    )
  rescue OpenSSL::Cipher::CipherError
    raise if index == keys.length - 1
  end
end
```

#### Background re-encryption process

Following is a naive implementation of what the background re-encryption process would roughly do.

```ruby
# ActiveRecord::Encryption
current_key_fingerprint = GitlabKeyProvider.new.encryption_key.id
ApplicationRecord.descendants.select { |d| d.encrypted_attributes.present? }.each do |model|
  model.where("NOT (#{attr}->'h'->'i') ? :value", value: ::Base64.strict_encode64(current_key_fingerprint)).find_in_batches do |batch|
    batch.each do |record|
      record.encrypt # this forces the re-encryption of all encrypted attribute
    end
  end
end

# TokenAuthenticatable
current_key_fingerprint = EncryptionKey.current_db_key_base_encryption_key_fingerprint
ApplicationRecord.descendants.select { |d| d.include?(TokenAuthenticatable) && d.encrypted_token_authenticatable_fields.present? }.each do |model|
  encrypted_fields = model.encrypted_token_authenticatable_fields

  model.where.not(encryption_key_fingerprint: current_key_fingerprint).find_in_batches do |batch|
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

  model.where.not(encryption_key_fingerprint: current_key_fingerprint).find_in_batches do |batch|
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
but we might work around that, or even implement proper support for it).

### Data encrypted through `attr_encrypted` and `TokenAuthenticatable`

Currently, `attr_encrypted` and `TokenAuthenticatable` don't store the fingerprint of the key used to encrypt an attribute.
We could introduce a new `encryption_key_fingerprint` column (4 chars) to tables that include encrypted columns.

A single `encryption_key_fingerprint` column per table is enough since the same key is used to encrypt all encrypted attributes
for a given record.

The key fingerprint can be computed with
[`ActiveRecord::Encryption::Key.new(key).id`](https://github.com/rails/rails/blob/v7.0.8.6/activerecord/lib/active_record/encryption/key.rb#L24)
(which is implemented as `Digest::SHA1.hexdigest(secret).first(4)` under the hood).

Once introduced, a post-deploy migration should populate all rows with the current key fingerprint.

The implementation of `attr_encrypted` and `TokenAuthenticatable` would need to be modified to populate the
`encryption_key_fingerprint` attribute.

**In the future, we should progressively migrate all the usage of `attr_encrypted` and `TokenAuthenticatable` to
`ActiveRecord::Encryption`.**

## Challenges

### Rotation of deterministic key

Deterministic encryption allows to query a table for a specific column value (e.g. personal access tokens are currently
queried by their digest, but we should migrate them to be encrypted instead so that we can rotate the key without
invalidating all the tokens).

`ActiveRecord::Encryption` doesn't support deterministic keys rotation at the moment, support for it should be
implemented either in GitLab, or in Rails directly.

That said, we might be able to work around this limitation by specifying a custom `GitlabDeterministicKeyProvider` key
provider so that under the hood it uses the logic from `DerivedSecretKeyProvider` but with the
`deterministic: true` option which makes the encryption process generate the initialization vector based on
the encrypted content instead of being random, i.e.

```ruby
encrypts :attr, deterministic: true, key_provider: GitlabDeterministicKeyProvider.new
```

## Proof of Concept

A Proof of Concept merge request was created to show that support of multiple encryption keys is possible today for
both `attr_encrypted` and `TokenAuthenticatable`: <https://gitlab.com/gitlab-org/gitlab/-/merge_requests/167067>.

What's missing from this PoC is the second pre-requisite [from the above proposal](#proposal): the ability to know
what key was used to encrypt an attribute. It's possible to add support for this with the introduction of a new
`encryption_key_fingerprint` column per table (except for some cases where different keys are used for different encrypted
attribtues in the same table).

## Iteration plan

### Iteration 1: Foundation and Key Management

1. Implement the key management system in the database
   - Create a new table to store key information (id, fingerprint, status, created_at, etc.)
   - Implement initializer to read keys from `config/secrets.yml` and populate/update the database
   - Add collision detection to prevent `inactive` -> `active` transition
1. Develop the key selection mechanism
   - Implement caching for active keys to ensure good performance
   - Create logic to select the appropriate key based on the encryption framework used
1. Add fingerprint generation for keys
   - Implement SHA1 hashing for key fingerprints

### Iteration 2: Framework-specific Implementations

1. Implement support for `ActiveRecord::Encryption`
   - Modify existing `ActiveRecord::Encryption` usage to work with new multiple keys management
1. Implement support for `attr_encrypted`
   - Modify existing `attr_encrypted` usage to work with new multiple keys management
1. Implement support for `TokenAuthenticatable`
   - Modify existing `TokenAuthenticatable` usage to work with new multiple keys management

### Iteration 3: Admin Interface and Key Lifecycle

1. Create the admin interface for key management
   - Develop the UI for viewing key status, usage statistics, and controls
   - Implement key activation/retirement functionality

### Iteration 4: Re-encryption Process

1. Implement background re-encryption process
   - Build on top of background migration framework
   - Ensure database load is under control during re-encryption
   - Support `ActiveRecord::Encryption`, `attr_encrypted`, and `TokenAuthenticatable`
1. Develop progress tracking for re-encryption
   - Add database columns to track re-encryption progress
   - Update admin interface to display re-encryption status

### Iteration 5: Additional tooling

1. Create rake task to detect key collision in advance
1. Allow to disable actions in the admin UI (useful for Dedicated)
1. Create rake task to enable a new key
1. Develop safeguards against accidental key deletion

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
