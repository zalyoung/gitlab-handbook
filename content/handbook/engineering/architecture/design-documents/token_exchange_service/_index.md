---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Token exchange service
status: proposed
creation-date: "2025-03-18"
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

<!--
Don't add a h1 headline. It'll be added automatically from the title front matter attribute.

For long pages, consider creating a table of contents.
-->

## Summary

This proposal defines a Token Exchange Service that supports 2 modes of
operation:

- An RFC 8693-like token exchange where client submits a token (eg.
  personal access token, ID token) and receives a short-lived unified token in
  return.
  This flow also support non-OAuth-compliant tokens, which are not are not
  covered by the RFC.
  By using custom token-type URIs, we keep a single RFC 8693-style model.
- A transparent proxy where requests carrying a long-lived, legacy token are
  automatically exchanged for an short-lived unified token, without explicit
  client interaction.

Both flows leverage the unified token introduced in the `Token consolidation`
blueprint.

Benefits of the Token Exchange Service:

- Reduces reliance on long-lived tokens, lowering the risk from credential leaks
  or misuse.
- Narrows token permissions, enables issuance of tokens with only the privileges
  needed for a specific operation or session.
- Enables workflows (eg. a Workload Identity Federation) where external
  OIDC-based identities can securely obtain short-lived access tokens.

## Motivation

GitLab currently suffers from a fragmented token ecosystem, as described in the
Token Consolidation design document.
Handling large number of token types leads to increased code complexity,
inconsistent security enforcement, and significant maintenance overhead within
the monolith.
In addition, long-lived tokens with broad permissions present a significant
security risk.

A unified token model would simplify token authentication, reduce duplication,
and allow a more consistent enforcement of security policies.
Standardizing authentication around a single token type would also improve
developer experience and reduces the risk of implementation errors.

However, the approach proposed in `Token consolidation` blueprint is expected
to take time to fully implement.
In the interim,  many of the same benefits can be achieved by introducing a
token exchange service that transparently replaces legacy token types with a
short-lived, unified token.

Additionally, supporting an explicit token exchange flow encourages users to
adopt security best practices: specifically, favoring short-lived tokens over
long-lived legacy tokens.

Finally, this service will also enable new workflows, such as allowing external
OIDC-based identities to securely retrieve short-lived access tokens - a
foundational requirement for Workload Identity Federation.

### Goals

- Unify token handling within the monolith by consolidating to a single token
  type, simplifying authentication logic and reducing code complexity.
- Enable consistent policy enforcement and auditing.
- RFC 8693-like token exchange: provide endpoints to support explicit token
  exchange of long-lived tokens to short-lived tokens.
- Transparent proxy: automatically replacing legacy tokens in incoming requests,
  and forwarding them in a unified way.
- Increased security by limiting the use of long-lived tokens with broad
  permissions, reducing the risk window in th event of token leak.
- No user disruption: ensure seamless user experience without disrupting
  existing workflows.
- Lay the foundation of new workflows, including support for external identities
  through mechanism like Workload Identity Federation.

### Non-Goals

- Full RFC 8693 compliance: while the service is inspired by the spec, it will
  also support non-OAuth tokens (e.g., personal access tokens), and therefore
  won't fully conform to the RFC
- Immediate deprecation of legacy tokens: providing a transparent proxy, we
  provide a transitional flows until token consolidation is completed.
- Extracting a token database, or independent token service out of the monolith.
  Tokens are continue to be stored in the monolith.

## Proposal

The token exchange service will support 2 modes of operation:

### Transparent proxy mode

The transparent proxy mode intercepts incoming requests that carry a recognized
token type (eg. a personal access token), automatically exchanges under the
hood for a short-lived token, and then forwards the request with the new unified
token in the Authorization header.
This enables to transparently standardize token usage without requiring users to
modify their existing code or tooling.

Flow:

1. Detection:
    - The proxy inspects the incoming request to identify if an known exchangeable
      token is included in the request.
    - If the token is exchangeable and not already a short-lived unified token,
      the service proceeds with an internal token exchange call.
2. Automatic exchange
    - A a short-lived unified token is generated based on the original legacy
      token.
3. Header replacement
    - The original token is stripped from the request
    - A new `Authorization: Bearer` header is added
    - The updated request is forwarded to the intended resource endpoint

### Explicit token exchange flow

Clients make token exchange requests to the exchange endpoint using the
`urn:ietf:params:oauth:grant-type:token-exchange` grant type.
The request includes a mandatory subject token (representing the identity of the
party on whose behalf the request is made).

Endpoint: `POST /auth/token`

Parameters:

- `grant_type`: Must be `urn:ietf:params:oauth:grant-type:token-exchange`.
- `subject_token`: The token being exchanged (eg. Personal Access Token, ID
  token).
- `subject_token_type`: A URI describing the token format. RFC 8693 includes
  URIs for standard OAuth tokens, but we add custom URIs for non-OAuth compliant
  tokens.
- `scope`: The permissions requested for the new token. This must not exceed the
  original token's privileges.

Response: If validation and scope checks pass, the service returns a
short-lived token with only the requested scope.

#### Custom Token-Type URIs

Because some existing token types do not map to standard OAuth 2.0 token types,
we define URIs like:

- `urn:gitlab:params:oauth:token-type:personal_access_token`
- `urn:gitlab:params:oauth:token-type:project_access_token`
- `urn:gitlab:params:oauth:token-type:ci_job_token`

These enable the exchange endpoint to process non-OAuth based tokens while
preserving RFC 8693 compatibility.

### Security controls

1. Integrity
   - For standard OAuth tokens (eg., ID tokens): standard OIDC checks (signature,
     issuer, audience).
   - For custom tokens: validated similar to existing logic (e.g., revocation
     status, ownership, expiry).
2. Scope restriction
   - The requested scope must be equal to or narrower than the subject token's
     privileges.
3. Short-lived expiry
   - The returned token conforms to the unified token format described in
     `Token consolidation` blueprint: JWT-based, signed, with a short expiry.
4. Auditing & Revocation
   - Each exchange is logged (subject token details, scope requested, user or
     service account ID).

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
