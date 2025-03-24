---
title: Service accounts as the core machine identity
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

### User type definition

To enforce clearer security and permission boundaries, standardize types into
2 categories:

- human users
- service accounts (machine identities): non-human accounts used for automation,
  integrations, and machine-to-machine interactions.

All internal bot-related functionalities will be consolidated under service
account type.
This eliminates security inconsistencies by applying uniform authentication and
access control across all external and internal machine identities.

### Service accounts availability in the hierarchy

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

### Tiering

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

## Design and implementation details

<!--
This section should contain enough information that the specifics of your
change are understandable. This may include API specs (though not always
required) or even code snippets. If there's any ambiguity about HOW your
proposal will be implemented, this is the place to discuss them.

If you are not sure how many implementation details you should include in the
document, the rule of thumb here is to provide enough context for people to
understand the proposal. As you move forward with the implementation, you may
need to add more implementation details to the document, as those may become
valuable context for important technical decisions made along the way. A
document is also a register of such technical decisions. If a technical
decision requires additional context before it can be made, you probably should
document this context in a document. If it is a small technical decision that
can be made in a merge request by an author and a maintainer, you probably do
not need to document it here. The impact a technical decision will have is
another helpful information - if a technical decision is very impactful,
documenting it, along with associated implementation details, is advisable.

If it's helpful to include workflow diagrams or any other related images.
Diagrams authored in GitLab flavored markdown are preferred. In cases where
that is not feasible, images should be placed under `images/` in the same
directory as the `index.md` for the proposal.
-->

## Alternative Solutions

- Do nothing
  - Pros: requires no effort
  - Cons: existing issues remain unresolved
