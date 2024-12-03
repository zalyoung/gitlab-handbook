---
title: "Encryption key rotation"
status: proposed
creation-date: "2024-12-03"
authors: [ "@rymai" ]
coach: []
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
rest in the GitLab databse. Its rotation is currently not possible without downtime, and there's no automation nor
script for it. Given the criticality of this secret, the goal is to design a solution that allows the secret to be
rotated while GitLab stays online.

A lot of discussions happened to discuss the problem and potential solutions. The main issue where this was discussed
is <https://gitlab.com/gitlab-org/gitlab/-/issues/25332>. In this issue

### Goals

Provide GitLab administrators with a way to:

- Introduce a new encryption key so that new or updated records are encrypted with it
- Not have to worry about running automation or scripts to re-encrypt data with the new key
- Monitor the progress for the re-encryption of data encrypted with legacy keys

#### Use cases

#### Non-functional requirements

### Non-goals

This blueprint does not cover the following:

- Other secrets such as `secret_key_base`, `otp_key_base`, `openid_connect_signing_key`, and `encrypted_settings_key_base`.

## Decisions

## Proposal

The idea is simple but is based on 3 pre-requisites:

1. Support for multiple encryption keys
1. Ability to know what key was used to encrypt an attribute
1. Ability to list records encrypted with a specific key

These 3 pre-requisites would be fulfilled by using `ActiveRecord::Encryption` (except for rotating deterministic keys, but
support for it should be easy to add).

Once the pre-requisites are in place (i.e. `ActiveRecord::Encryption` is set up and usable), the high-level proposal is as follows:

1. When a key need to be rotated, just add it last to the `db_key_base` array in `config/secrets.yml`, and restart GitLab
  - From now on, data will be encrypted with this new key
1. The decryption process will try each key (in the order they appear in the `db_key_base` array), until it can decrypt the data
  - That way, there's no need to bring GitLab down to mass-re-encrypt all data
1. A background process continuously runs to re-encrypt any data that was encrypted with a legacy key (i.e. not the current key in the `db_key_base` array)
  - The background process becomes a no-op as soon as all the data is re-encrypted with the current key
1. A new dedicated Admin page allows to monitor the encrypted data status:
  - How many records are still encoded with a legacy key
  - What's the expected ETA for everything to be re-encoded with the current key
  - What keys can be deleted (i.e. no data is encrypted with this key)

### Pseudo code

```ruby
current_key_id = ActiveRecord::Encryption::DerivedSecretKeyProvider.new(ActiveRecord::Encryption.config.primary_key.last).encryption_key.id

ApplicationRecord.descendants.select { |d| d.encrypted_attributes.present? }.each do |model|
  model.where("NOT (#{attr}->'h'->'i') ? :value", value: ::Base64.strict_encode64(current_key_id)).find_in_batches do |record|
    record.encrypt # this forces the re-encryption of all encrypted attribute
  end
end
```

## Blockers

`ActiveRecord::Encryption` doesn't support deterministic keys rotation at the moment, support for it should be implemented either in GitLab, or in Rails directly.

### Use case studies

### Further investigations required

## Alternative solutions

## References

- <https://gitlab.com/gitlab-org/gitlab/-/issues/25332>

## Who

DRIs:

<!-- vale gitlab.Spelling = NO -->

| Role                | Who                                            |
|---------------------|------------------------------------------------|
| Author              | Rémy Coutable, Principal Engineer              |

<!-- vale gitlab.Spelling = YES -->
