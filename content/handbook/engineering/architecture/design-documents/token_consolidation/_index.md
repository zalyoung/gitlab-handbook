---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Token Consolidation
status: proposed
creation-date: "2025-02-23"
authors: [ "@ifarkas" ]
coaches: [ "@grzesiek" ]
dris: [ "@hsutor", "@adil.farrukh" ]
owning-stage: "~devops::software_supply_chain_security"
participating-stages: []
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< engineering/design-document-header >}}

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
maintenance burden.
When security updates or new features are required, each token type must be
individually modified, tested, and maintained — resulting in ongoing maintenance
challenges that slow down development and increase the risk of inconsistencies,
security gaps, and potential vulnerabilities.

### Goals

- Establish unified token(s) as the foundational building block for all token
  types
- Standardize authentication and authorization model around tokens
- Enhance security by enabling consistent features across all token types
- Improve maintainability by eliminating redundant token implementations
- Improve user experience by simplifying token usage and management

### Non-Goals

- Define a Token Exchange Service

## Proposal

To move forward, we need to make decisions in 3 critical, interconnected areas:

- where token metadata is stored
- how token metadata is encoded and structured
- what interface provides access to token-related functionality

Each decision will be documented as a separate ADR.

It's important to acknowledge that a single unified token may not be practical
across all systems:

- STS might issue an JWT, while `gitlab-rails` might consolidate around the
  existing, random string-based tokens.
- Different token purposes may require different formats: an ID token might
  require a different schema than an access token with fine-grained scopes.
- Encoding fine-grained scopes in a JWT might push the token size above the
  limits that are acceptable for request headers or parameters.

### Storage

Defines where token metadata is stored:

#### Single consolidated table

Pros:

- unified schema simplifies token management
- single source of truth for all tokens
- standardized implementation of token-related features

Cons:

- potential database performance concerns with a very large table
- complex migration for existing tokens

#### Multiple tables

Pros:

- smaller, easier-to-manage tables
- independent schema evolution for each token type
- reduced impact of table-level operations
- easier to implement features specific to a single token type

Cons:

- easier to implement features specific to a single token type as it's easier to
  diverge from the consolidation goal
- possibility of independent schema evolution for each token type
- inconsistent implementations of token-related features
- duplicate implementations of features
- increased maintenance overhead
- harder to enforce standards

#### No storage / minimal storage (JWT-based)

Pros:

- eliminates / minimizes database storage requirements dependent on token
  revocation support
- self-contained authentication and authorization mechanism
- potential performance gains

Cons:

- incompatible with many existing features
- limited revocation capabilities
- long-lived tokens pose security risks
- token size may exceed request header limits
- no ability to track token usage

### Token format

Defines how token metadata is encoded and structured:

#### Random string

Example: PAT - 20-byte random string with metadata (like scopes) stored in the database.

Pros:

- small token size
- opaque to users (no readable metadata)

Cons:

- database lookup required
- no built-in mechanism for routing, or authorization (like fine-grained scopes)
- size could still be significant. Routable tokens increases the size to a
  maximum of 333 bytes (plus prefix)
- relies on secrecy for security

#### JWT (signed)

Pros:

- built-in support for claims and other metadata
- digital signature ensure authenticity
- self-contained authentication and authorization data

Cons:

- readable metadata might not be desirable in all use-cases
- larger token size. It might not fit within the request header limits
- revocation requires additional infrastructure

#### Unsigned JWT

Pros:

- maintains all the flexibility of JWT
- lower computational overhead
- slightly smaller token size compared to signed JWT

Cons:

- token size could still be problematic for request header limits
- susceptible to tampering
- long-lived tokens could be a security concern
- relies on secrecy for security

### Code abstraction

Defines an interface for accessing token-related functionality:

#### Modular monolith

Pros:

- aligns with our current architectural approach
- familiar to engineers
- easier implementation in the short term
- lower implementation overhead
- fully integrated with `gitlab-rails`

Cons:

- more difficult to enforce strict service boundaries
- potential for tight coupling

#### Separate service with gRPC interface

Pros:

- accelerates evolution toward having token service as a separate service
- service boundaries are enforced

Cons:

- overhead of creating a new service and integrating it into our infrastructure
  and delivery pipelines
- additional infrastructure requirements
- latency caused by network overhead

## Alternative Solutions

- Do nothing
  - Pros: requires no effort
  - Cons: existing issues remain unresolved

### Single, JWT-based unified token

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
