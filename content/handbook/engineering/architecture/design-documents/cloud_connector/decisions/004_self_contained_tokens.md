---
title: "ADR 004: Self-contained tokens"
toc_hide: true
---

## Context

Cloud Connector allows clients (GitLab instances & IDEs) to make requests into GitLab's cloud infrastructure
by sending cryptographically signed [JSON Web Tokens (JWTs)](https://www.rfc-editor.org/rfc/rfc7519.html).
These tokens are validated by backend services using a public key.
Trust is established by fetching these keys from well-known endpoints that GitLab Inc. controls:

- gitlab.com, holding a private key to mint tokens for multi-tenant customers
- customers.gitlab.com, holding a private key to mint tokens for single-tenant customers

Validators such as the AI gateway and other Cloud Connector backends then implement the
[OpenID Connect Discovery protocol (OIDC-D)](https://openid.net/specs/openid-connect-discovery-1_0.html)
to refresh these keys regularly.

While this paved the way for our team to iterate quickly, as OIDC-D was something GitLab supported prior to
building Cloud Connector, it has turned into a liability for us and slows progress for the reasons
outlined below.

OIDC-D solves the problem of multiple, unrelated network endpoints on the public
internet to discover and exchange identity information. To that end, it specifies that two
requests should be made: one to discover metadata about an identity provider (IdP) such as where validation
keys are located, and a second request to fetch keys at the given address. With two IdPs in our case, that's
4 requests per Cloud Connector backend to "discover" entities we already know where to find. Since discovery requests
never leave GitLab Inc's sphere of control, this is entirely unncessary since backend services could instead dial
a well-known keys endpoint directly.

Fetching keys over the network leads to increased implementation and operational complexity, discussed next.

### Implementation complexity

Since it is infeasible to fetch keys over a network each time a token needs to be validated,
backend services must cache these keys. However, the standard makes no mention of how this
should be accomplished, opening the doors for state management issues like stale caches and inconsistencies between
implementation choices made by library and/or service developers.

At the time of this writing, we are maintaining 3 independent implementations of OIDC-D
(2 in Golang, 1 in Python) that were all built by different teams or use different 3rd-party libraries
and exhibit different behaviors as regards key management.
This makes even routine tasks such as key rotations risky events. Failure to correctly maintain keys
or matching them to tokens results in a complete service outage from the user's perspective.

This results in [bugs](https://gitlab.com/gitlab-org/gitlab/-/merge_requests/173689),
[availability problems](https://gitlab.com/gitlab-com/gl-infra/production/-/issues/18349),
and ultimately maintenance overhead.

### Operational complexity

The necessity to make network calls into IdPs for token validation creates complexity in the
system and network architecture.
It is common to develop and test using a GitLab instance which does not face the public internet but needs to make
requests into a live service using Cloud Connector. Since this backend service cannot discover keys
from a GitLab instance listening for requests on a development machine or a cloud VM that has no public
IP address, workarounds were introduced that bypass authentication entirely.

This [adds friction](https://gitlab.com/gitlab-org/cloud-connector/gitlab-cloud-connector/-/issues/33) and slows down development.

## Decision

We propose to resolve these problems by replacing OIDC-D for use in Cloud Connector with
[self-contained JWTs](https://curity.io/resources/learn/self-contained-jwts/) (SC-JWTs).

SC-JWTs remove the necessity for any sort of node discoverability or state management by making the verification process
stateless. This is accomplished by embedding validation keys in the tokens themselves and using traditional
Public Key Infrastructure (PKI) instead of well-known network endpoints to establish trust.

At a high level, SC-JWTs operate as outlined below.

### Key management

We create a self-signed root certificate (CA cert), the shared trust anchor, that we deploy backend services that validate tokens.
The key to this certificate will be held by GitLab offline, for example in a 1password vault. This key and certificate
can be long-lived, e.g. 5 years.

For each system that issues JWTs:

1. **Issue private keys with certificates linked to the CA cert.** These end-entity certificates (EE cert) are signed with the
CA private key, linking them to the CA cert that acts as the trust anchor. They should be rotated frequently, e.g. every
6 months and are deployed with gitlab.com and customers.gitlab.com.
1. **Issue tokens by including the EE cert.**. We use the [X.509 Certificate Chain claim (`x5c`)](https://www.rfc-editor.org/rfc/rfc7517.html#section-4.7)
to embed the EE cert in the JWT itself i.e. it is included in the bearer token in every request to a Cloud Connector
backend service.

For each system that validates JWTs:

1. **Deploy the CA cert with it.** This step makes the shared trust anchor available to a token validator as an
ordinary piece of configuratation. This can be done by embedding it in a Cloud Connector library artifact or Docker image.
1. **Verify the EE cert from the token.** This step parses and verifies the `x5c` claim by reconstructing the original
certificate from it and validating it against the CA cert. This tells us that the key can be trusted and used to
validate the token.
1. **Verify the JWT itself.** Certificates contain the public key that binds it to an identity. If 2 holds, we can
then use this key to perform ordinary JWT verification as we do today.

## Consequences

TODO
