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
building Cloud Connector, it has turned into a liability for us and slows progress.
Generally speaking, OIDC-D standardizes how multiple unrelated parties on the public internet
exchange configuration for OIDC participants in a standard way.
We only use [Section 4](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfig)
of the specification, and specifically only the `jwks_uri` field, which tells the caller where to fetch
token validation keys, because this is the only relevant bit for Cloud Connector, which does not use OAuth
or OIDC anywhere else in its design or implementation.

This means two requests should be made: one to fetch the configuration object from the identity provider (IdP)
and a second request to fetch keys at the given address. With two IdPs in our case, that's
4 requests per Cloud Connector backend to discover keys we already know where to find. Since discovery requests
never leave GitLab Inc's sphere of control, this is entirely unncessary since backend services could instead dial
a well-known keys endpoint directly.
Even then, discovering and fetching keys over the network opens us to undesirable failure modes and leads
to increased implementation and operational complexity:

1. **Network calls cause operational complexity.**
   It is common to develop and test using a GitLab instance which does not face the public internet but needs to make
   requests into a live service using Cloud Connector. Since this backend service cannot discover keys
   from a GitLab instance listening for requests on a development machine or a cloud VM that has no public
   IP address, workarounds were introduced that bypass authentication entirely.
   This [adds friction](https://gitlab.com/gitlab-org/cloud-connector/gitlab-cloud-connector/-/issues/33) and slows down development.
1. **Network endpoints can be down.** A Cloud Connector backend service can only operate if it is able
   to validate tokens. Without keys, it cannot validate tokens. During network partitions, backends must
   therefore be resilient to IdP outages. This has led to an [AI outage](https://gitlab.com/gitlab-org/gitlab/-/issues/483041)
   where CustomersDot was put into maintenance mode, making its own keys endpoint unavailable.
1. **Network requests are costly.** It is too costly for backend services to fetch keys on each request.
   Even if the IdP is reachable, it must maintain a cache, which needs to be
   invalidate whenever keys roll over. Unfortunately, OIDC-D does not at all address this problem and leaves it up to
   service maintainers and library developers to decide how this should be dealt with.
1. **Caches introduce a state management problem.** 2 and 3 mean we need to solve a state distribution
   problem where each participant (backend service) may decide on a different strategy on how this cache
   should be maintained. This makes key rotations a fragile and stressful process since it is unclear how
   or when each backend service will invalidate its key cache and re-fetch keys. This has led to an
   [AI outage](https://gitlab.com/gitlab-com/gl-infra/production/-/issues/18349) where a key was changed
   that backend services had not yet fetched into their caches.
1. **Unclear standards and complexity cause implementation drift.** At the time of this writing, we maintain
   3 independent implementations of OIDC-D (2 in Golang, 1 in Python) that were all built by different teams
   or use different 3rd-party libraries and that exhibit different behaviors as regards key management.
   This results in [bugs](https://gitlab.com/gitlab-org/gitlab/-/merge_requests/173689)
   and ultimately maintenance overhead. Had this bug made it into a production system, it would have been
   another total AI outage.

## Decision

We propose to resolve these problems by replacing OIDC-D for use in Cloud Connector with
[self-contained JWTs](https://curity.io/resources/learn/self-contained-jwts/) (SC-JWTs).

SC-JWTs remove the necessity for any sort of node discoverability or state management by making the verification process
stateless. This is accomplished by embedding validation keys in the tokens themselves and using traditional
Public Key Infrastructure (PKI) instead of well-known network endpoints to establish trust.

At a high level, SC-JWTs operate as outlined below.

### Key management

We create a self-signed root certificate (CA cert), the shared trust anchor, that we deploy with backend services that validate tokens.
The key to this certificate will be held by GitLab Inc. offline, for example in a 1password vault. This key and certificate
can be long-lived, e.g. 5 years.

For each system that issues JWTs:

1. **Issue private keys with certificates linked to the CA cert.** These end-entity certificates (EE cert) are signed with the
CA private key, linking them to the CA cert that acts as the trust anchor. They should be rotated frequently, e.g. every
6 months and are deployed with gitlab.com and customers.gitlab.com.
1. **Issue tokens with the EE cert embedded.** We use the [X.509 Certificate Chain claim (`x5c`)](https://www.rfc-editor.org/rfc/rfc7517.html#section-4.7)
to embed the EE cert in the JWT itself i.e. it is included in the bearer token in every request to a Cloud Connector
backend service.

For each system that validates JWTs:

1. **Deploy the CA cert with it.** This step makes the shared trust anchor available to a token validator as an
ordinary piece of configuratation. This can be done by embedding it in a Cloud Connector library artifact or Docker image
since it is not a secret.
1. **Verify the EE cert contained in the token.** This step parses and verifies the `x5c` claim by reconstructing the original
certificate from it and validating it against the CA cert. This tells us that the key can be trusted and used to
validate the token.
1. **Verify the JWT itself.** Certificates contain the public key that binds it to the sender identity. If 2 holds, we can
then use this key to perform ordinary JWT verification as we do today.

## Consequences

This approach affords us with the following benefits:

1. **Improves resilience and availability in face of network partitions.** Because keys are piggy-backed on each Cloud Connector request,
   no addition network calls need to be made, which removes all sorts of failure classes by design and improves
   the resilience and availability of Cloud Connector services.
1. **Reduces key rotation risk.** Since requests are self-descriptive, no additional state needs to be maintained in
   caches. Without a need for caches, no problems like cache invalidation need to be solved. This reduces risk when
   rotating keys since all verification is stateless. Tokens with remaining life-time will still be accepted, while
   newly minted tokens will carry the new key straight away.
1, **Removes implementation ambiguity.** Self-contained tokens are simple in nature and the `x5c` claim is well-defined.
   The rest is standard PKI functionality that is battle-tested and often shipped through standard language libraries
   we can lean on. This makes it far easier to provide implementations that exhibit consistent behavior even across
   language stacks.
1. **Removes development and testing friction.** Since backend services don't need to make callbacks into GitLab or
   CustomersDot, we can support scenarios where IdPs are not deployed on the public internet. They will simply send
   their keys with each request.

Drawbacks and unknowns:

1. **Increased HTTP payload size.** JWTs are Base64-encoded strings sent through the `Authorization` header as bearer tokens.
   Embedding certificates in a token claim will therefore grow the header field and the overall HTTP payload.
   The increase should be negligible, but we have not yet investigated the impact of this.
1. **More computational work in backend services.** Parsing and verifying the EE cert is a net-new step a backend service
   needs to perform on each request, potentially adding latency. The actual impact of this has yet to be established.
   A key cache may help remove this overhead while not being subjected to state drift as mentioned above, for example
   by caching key validity rather than the entire key. Any new keys arriving with a token would still need to be
   revalidated and other keys eventually discarded.
1. **An additional piece of configuration in IdPs.** IdPs currently only require a private key to mint tokens. Under this
   proposal, they would additionally need to be configured with the EE cert embedded in these tokens, i.e. 2 pieces of
   configuration instead of 1.
1. **Tokens cannot be invalidated quickly.** JWTs cannot be individually invalidated; they just expire. However, one can
   immediately invalidate _all_ tokens by rotating the keys used to sign them. Currently, this can be done fairly quickly
   since backend services would eventually converge onto the new keys automatically (after caches expire.)
   Under this proposal, tokens with longer life times of several days (as issued by CustomersDot) could only be invalidated
   by rotating the CA key, which will invalidate all tokens issued by all IdPs. This may not be big problem in practice
   but is worth highlighting.

## Status and next steps

We have completed a POC in [issue #499556](https://gitlab.com/gitlab-org/gitlab/-/issues/499556).
If there is consensus on moving forward with this, we will start working on implementation.
