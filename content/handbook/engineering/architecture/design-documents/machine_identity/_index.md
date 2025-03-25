---
title: Standardized machine identity
status: proposed
creation-date: "2025-02-19"
authors: [ "@ifarkas", "@bdenkovych", "@dblessing" ]
coaches: [ "@grzesiek" ]
dris: [ "@hsutor", "@adil.farrukh" ]
owning-stage: "~devops::govern"
participating-stages: []
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< design-document-header >}}

## Summary

GitLab currently supports more than 10 different bot user account types, each managed by different teams with inconsistent permission policies and authentication methods. This fragmentation creates challenges in ownership clarity, potential security vulnerabilities, customer visibility issues, and significant maintenance overhead. This proposal establishes service accounts as the core machine identity. Service accounts provide capabilities similar to regular users while enforcing important security constraints like UI sign-in restrictions and implementing streamlined permission policies. As part of this excercise, we would also need to ensure service accounts can be introduced on the free tier of GitLab with appropriate abuse prevention controls.

## Motivation

A consolidated approach to machine identities through service accounts will:

- Simplify GitLab's machine access story by providing a unified interface and code path
- Enhance security through consistent authentication methods and access controls
- Reduce engineering overhead by centralizing bot-related code and policies
- Improve customer experience by allowing management of machine identities alongside other users
- Establish clear ownership and responsibility for machine identities
- Create proper isolation between human users and machine identities to facilitate easier ownership transfer and management.

### Goals

- Enhance service accounts with features to support all required use-cases (e.g., project/group allow lists)
- Standardize on service accounts for all new machine identities
- Create migration paths for existing bot user types
- Simplify permission policies for machine identities
- Develop a revised monetization strategy for service accounts in collaboration with product teams
- Bring service accounts to GitLab Free tier with appropriate abuse prevention controls

### Non-Goals

- Define a Token Exchange Service
- Create a low-privilege unified token as part of token consolidation

## Proposal

### Option 1 - using service accounts

#### User type definition

To enforce clearer security and permission boundaries, standardize types into
2 categories:

- human users
- service accounts (machine identities): non-human accounts used for automation,
  integrations, and machine-to-machine interactions.

All internal bot-related functionalities will be consolidated under service
account type.
This eliminates security inconsistencies by applying uniform authentication and
access control across all external and internal machine identities.

#### Service accounts availability in the hierarchy

Service accounts are currently available at the top-group level on .com, and at
the instance level for self-managed.

To provide flexibility and support a wider range of use cases, service accounts
should be available at all levels in the hierarchy:

- instance level
- groups and subgroups
- projects

Instance level service accounts enable global automation and system-wide
integrations. Group and project level service accounts allows granular control
and access over machine identities.

Service account ownership is indicated by the `User#provisioned_by_group`
attribute. To have support both at group and project level, this attribute
will be migrated to `User#bot_namespace`.
`User#bot_namespace` can reference to both levels - `Group` and
`Namespaces::ProjectNamespace` namespaces.

#### Tiering

Service accounts are currently a Premium / Ultimate feature.
To fully support machine identities, Service accounts need to be available in
the Free tier while preserving as much functionality as possible to prevent edge
cases and code fragmentation.
However, additional limits may be necessary to prevent abuse and security risks
in the Free tier. Token expiration for Personal access tokens:

- In Premium / Ultimate, token expiry for PATs of service accounts is not
  enforced. PATs can be created with optional expiration.
- In Free tier, expiration should always be required to prevent long-lived
  tokens from becoming a security risk. Keeping optional expiry as a Premium /
  Ultimate feature maintains a balance between flexibility and security
  controls.

#### System-generated service accounts

To support internal features and automation, some service accounts will be
created and managed automatically.
These system-generated service accounts differ from user-created service
accounts in terms of control and visibility.

To prevent accidental disruption of application flows, system-generated service
accounts will not be directly manageable by users or admins:

- they cannot be edited, deleted, or modified.
- their membership is automatically managed: the membership is added or removed
  based on the lifecycle of the feature or integration that depends on them.

This protects critical application flows from being broken due to
misconfigurations or malicious actions (eg. removing a necessary system account
from a project).

#### Creation and membership allowlists

Allowlists enable group or instance administrators to define and enforce
boundaries on where service accounts can be created and used.
They can restrict:

- Creation: Define which groups or projects are permitted to create new service
  accounts.
- Membership: Define which groups or projects a service account may be added to
  as a member.

This mechanism helps ensure that service accounts are not unintentionally or
maliciously created, or granted access to unrelated or sensitive parts of the
hierarchy.
It also allows top-level owners to retain control over the footprint of service
accounts created under their domain.

Note: these restrictions apply only to user-created service accounts.
System-generated service accounts can be created regardless of the allowlist to
avoid disrupting internal features and integrations.

### Option 2 - introduce a simplified user type

Service accounts have introduced significant complexity over time:

- It's a licensed feature
- They support multiple memberships, increasing the potential for accidental
  access sprawl.
- Ownership and membership are decoupled, with ownership limited to creation
  time and lacking visibility into access.

Option 1 adds further complexity:

- It introduces a distinction between user-created and system-generated service
  accounts.
- It relies on allowlists to partially mitigate the downsides of multiple
  memberships and limited visibility into access.

Since service accounts are already generally available, we cannot change their
behavior without disrupting existing user flows.
Instead:

- Preserve existing service accounts as-is for backward compatibility and as a
  machine identity option for users.
- Introduce a new user type (eg. service user) for all internal machine identity
  use cases, including token consolidation.

This service user would aligns more closely with the
[original proposal of service accounts](https://gitlab.com/gitlab-org/gitlab/-/issues/284393):

- Available in the `CE`
- Single membership: a service user can only belong to a single group or project
- No distinction between ownership and membership: the namespace that creates
  the service user retains full control.

This approach results in a significantly cleaner access model, avoids the
pitfalls of the existing service account implementation, and provides a
lightweight path forward for automation needs.

Via introducing breaking changes over time, we could be simplify the existing
service account model and eventually merge the two user types to reduce
maintenance overhead.

### Option 3 - some combination of 1 & 2

As an example: starting from a defined cutoff date, new memberships for service
accounts cannot be created.
This preserves current access while simplifying future behavior without
introducing a new user type.

## Alternative Solutions

- Do nothing
  - Pros: requires no effort
  - Cons: existing issues remain unresolved
