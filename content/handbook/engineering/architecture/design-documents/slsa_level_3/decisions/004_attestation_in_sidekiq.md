---
layout: handbook-page-toc
title: "ADR 004: Bundle cosign with GitLab Rails, perform attestation in GitLab Rails backend"
description: "Architecture Decision Record for changes in location for attestation and technical means for signing."
---

## Context

This ADR revises a decision made in [ADR 003](decisions/003_attest_sign_location.md) with regards to the signing location
for provenance statements. The decision to perform signing in the glgo service
is further documented in the linked ADR. As a summary, glgo was chosen
because it was a feasible mechanism to achieve SLSA Level 3 compliance, it
allowed delivery of attestation for gitlab.com customers and required no
additional services or infrastructure.

While discussing options for the integration between cosign and glgo concerns
were raised about the [number of dependencies](https://gitlab.com/gitlab-org/gitlab/-/issues/551210#note_2611268806)
that would be added to glgo in the event that the cosign project was directly
imported.

An alternative approach in the event integration with glgo was
not viable was evaluated. This ADR contains several possible options through
which the `cosign` binary can be embedded into Sidekiq workers, which would
allow for the generation of software attestations within them.

## Options Considered

### 1. Including `cosign` in the GitLab distribution

`cosign` is a [Go project](https://github.com/sigstore/cosign) that is developed
as part of the sigstore project. It allows for signing OCI containers (and other
artifacts) using Sigstore. Cosign also has built-in support for [in-toto
attestations](https://github.com/sigstore/cosign?tab=readme-ov-file#in-toto-attestations).
A proof of concept attestation program is available [in this merge request.](https://gitlab.com/darbyfrey/demodemo/-/merge_requests/4/diffs#717ea309f1716e0f92cc07090402218cd8d142cc)

**Pros:**

* The simplest of available options in terms of development effort.
* The cosign binary is feature-complete. This is in contrast to [sigstore-ruby](https://github.com/sigstore/sigstore-ruby), for example, which only supports verification.
* `cosign` is the most widely used mechanism through which to interact with sigstore, which means there will be documentation and support if we run into any issues.
* Shipping a binary means we can leverage existing tooling to maintain dependencies, such as [Renovate](https://handbook.gitlab.com/handbook/engineering/infrastructure-platforms/gitlab-delivery/build/maintenance/renovate/)

**Cons**

* Even though distribution is feasible, it is not trivial. CNG and Linux packages [need to be created](https://gitlab.com/gitlab-org/gitlab/-/issues/554600#note_2618812171).

### 2. Creating a ruby gem that would build cosign for the target platform

**Cons:**

* It is effectively a workaround to potential difficulties in distribution. Since distributing a well-known, small, go binary is [relatively easy](https://gitlab.com/gitlab-org/gitlab/-/issues/554600#note_2618812171) this is not necessary.
* It is more complex than the alternatives.
* Need to deal with the intricacies of Ruby packaging.
* Would need to keep up with updates to the cosign binary and update it in the event there are security vulnerabilities within it. Because this is a security critical component this is likely to be a requirement.

### 3. Use a native Ruby implementation of cosign

**Pros:**

* Potentially a reduced number of dependencies.
* Does not introduce distribution complexity.

**Cons:**

* The current version of [sigstore ruby](https://docs.sigstore.dev/language_clients/ruby/) offers a very small subset of the features provided by cosign.
* It would require substantial development time.
* Requires non-trivial integration code with several third-party providers.
* Requires maintenance work to keep up with any changes to standards or third-parties.

## Decision

**We will move forward with Including cosign in the GitLab distribution.**

This option is the simplest in terms of infrastructure complexity, and provides
good support for all sigstore features through a widely used client.

Additionally, background workers are a good choice for this type of workload,
and avoiding interactions with an external service will mean that the points
where there could be a failure are significantly reduced. This will make the
implementation more available.

From a security perspective, we have a [well-established methodology](https://docs.gitlab.com/development/shell_commands/)
for dealing with interactions with external binaries in Rails, and we do not
have to ensure the integrity of the provenance statement is preserved between
the two services.

## Consequences

### Positive

- Reduced overall complexity.
- Because `cosign` is very widely used, we are likely to be able to easily support all required use cases, and use the exhaustive documentation available.
- Reduced distribution complexity as we remove the dependency on `glgo`. This service is not available for all kinds of GitLab installations at this stage.
- Existing tooling to maintain dependencies, such as [Renovate](https://handbook.gitlab.com/handbook/engineering/infrastructure-platforms/gitlab-delivery/build/maintenance/renovate/), can be used.

### Negative

- Interacting with a command-line tool is high-risk. Although initially the parameters we would pass to the tool are not user-controlled, this may change later on depending on requirements. This negative consequence can be mitigated by adhering to well-established procedures documented in the [Shell command development guidelines page](https://docs.gitlab.com/development/shell_commands/).

## Related Links

- [Evaluate options to bundle cosign with GitLab Rails](https://gitlab.com/gitlab-org/gitlab/-/issues/554600)
- [Evaluate options to limit dependencies or sandbox execution of cosign in glgo](https://gitlab.com/gitlab-org/gitlab/-/issues/554596)
