---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Token Consolidation
status: proposed
creation-date: "2025-02-23"
authors: [ "@ifarkas" ]
coaches: [ "@username" ]
dris: [ "@hsutor", "@adil.farrukh" ]
owning-stage: "~devops::software_supply_chain_security"
participating-stages: []
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< design-document-header >}}

## Summary

Token consolidation aims to transform our fragmented token landscape into a
unified framework, bringing consistent security and token management features
across all token types, while addressing critical security and operational
risks.

By implementing a standardized token framework, we will enhance security, reduce
maintenance overhead, and improve user experience.

The proposed approach consists of three phases:

1. Building the core framework and architecture.
2. Migrating existing token types to the unified framework.
3. Deprecating legacy user flows.

## Motivation

GitLab offers more than 20 different token types.
Rather than leveraging and adapting existing token types, teams have often
created new ones. This lead to a fragmented token landscape with inconsistent
security, and management features, resulting in security gaps, and overlapping
functionality, and increased complexity.

Despite our established token standards, many essential security features are
either missing, or inconsistently implemented across different token types,
including:

- encrypted storage
- support for the shortest reasonable expiration time
- fine-grained access controls
- logging, auditing, and visibility into token usage
- configurable token prefix
- rotation
- automatic reuse detection
- retention controls
- routability for Cells and Organizations
- expiration

This inconsistency across token implementations has resulted in greater system
complexity, making it difficult to enforce uniform security standards across the
organization.

Maintaining a large number of token types significantly increases the long-term
maintenance burden. When security updates or new features are required, each
token type must be individually modified, tested, and maintained — resulting in
ongoing maintenance challenges that slow down development and increase the risk
of inconsistencies, security gaps, and potential vulnerabilities.

### Goals

- Establish unified token as the foundational building block for all token types
- Standardize authentication and authorization model around tokens
- Enhance security by enabling consistent features across all token types
- Improve maintainability by eliminating redundant token implementations
- Improve user experience by simplifying token usage and management

### Non-Goals

- Define a Token Exchange Service

## Proposal

To standardize and simplify token management, a unified token will be introduced
as the foundation for all token types, supporting their respective features
while ensuring security, flexibility, and compatibility with existing
functionality.

### Unified token

The unified token will be a JWT-based token, similar to low-privilege CI job
token, with:

- custom claims that support flexible authorization
- digital signature to ensure authenticity and prevent tampering

By using a single standardized token format, security policies can be
consolidated, implementation simplified, redundant token management reduced.

#### Permissions

The token's permissions will be set based on its `scope` claim, ensuring
flexibility while maintaining least-privilege access when required.
Scopes can be generic, similar to the current `api` scope, or it can be
fine-grained for a specific use cases (eg. project-level access):

```json
"scope": {
  "read_project": ["gid://gitlab/Project/42"],
}
```

#### Expiration

The token must support wide range of expiration options to accommodate different
use cases, such as:

- short-lived tokens like OAuth access tokens (2-hour expiry)
- long-lived tokens like Personal access tokens (up to 1 year)
- non-expiring tokens, available as an optional Ultimate-tier feature, allowing
expiration enforcement to be disabled for service accounts

This flexibility ensures compatibility with existing token types, and allows a
broader range of expiry to be supported. Eg. Personal access tokens currently
cannot have an expiry shorter than a day.

#### Storage

To improve security and maintainability, the unified token will be stored
encrypted, enabling:

- portability - to support Org Mover, allowing organizations to be moved across
Cells
- encryption key rotation support - unlike current implementations, which do not
support key rotation, the unified token framework will enable key rotation to
enhance security.

#### Cells compatibility

The unified token will include routing metadata to enable efficient routing to
the owning Cell without additional lookup overhead.

#### Consolidation of existing tokens

A centralized interface for managing tokens will be introduced, providing a
unified way to create, monitor, and control token usage.

Existing tokens will be migrated to use the unified token as their backend,
standardizing their implementation.
The migration path for each token type will be evaluated independently, taking
into account feature parity, security implications, and user impact.
Once migrated, their management will be available through the unified interface.

As user workflows transition to the unified token model, original tokens and
legacy token flows can be deprecated and removed from the UI.
This phased approach will minimize disruption while ensuring seamless transition
to the new token framework.

## Alternative Solutions

- Do nothing
  - Pros: requires no effort
  - Cons: existing issues remain unresolved
