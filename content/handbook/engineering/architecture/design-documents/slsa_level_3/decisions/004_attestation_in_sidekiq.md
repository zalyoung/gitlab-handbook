---
layout: handbook-page-toc
title: "ADR 004: Bundle cosign with GitLab Rails, perform attestation in GitLab Rails backend"
description: "Architecture Decision Record for changes in location for attestation and technical means for signing."
---

## Context

This ADR revises a decision made in [ADR 003](decisions/003_attest_sign_location.md) with regards to the signing location
for provenance statements. The decision to perform signing in that documentation
is further documented in the linked ADR, however as a summary, glgo was chosen
because it was a feasible mechanism to achieve SLSA Level 3 compliance, it
allowed delivery of attestation for gitlab.com customers and required no
additional services or infrastructure.

While discussing options for the integration between cosign and glgo concerns
were raised about the [number of dependencies](https://gitlab.com/gitlab-org/gitlab/-/issues/551210#note_2611268806)
that would be added to the glgo in the event that the cosign project was
directly imported.

Because of this, an alternative approach in the event integration with glgo was
not viable was evaluated. This ADR contains several possible options through
which the `cosign` binary can be embedded into Sidekiq workers, which would
allow for the generation of software attestations directly from them.

## Options Considered

### 1. Including cosign in the GitLab distribution

**Pros:**

* The simplest of available options in terms of development effort. The cosign binary is feature-complete (as opposed to sigstore-ruby, for example, which only supports verification)
* cosign is the most widely used mechanism through which to interact with sigstore, which means there will be ample documentation and support if we run into any issues.
* Shipping a binary means we can leverage existing tooling to maintain dependencies, such as Renovate.

**Cons**

* Even though distribution is feasible, it does have some complexity. CNG and Linux packages [need to be created](https://gitlab.com/gitlab-org/gitlab/-/issues/554600#note_2618812171).

### 2. Creating a ruby gem that would build cosign for the target platform

**Cons:**

* It is effectively a workaround to potential difficulties in distribution. Since distributing a well-known, small, go binary is [relatively easy](https://gitlab.com/gitlab-org/gitlab/-/issues/554600#note_2618812171) this is an unnecessary workaround.
* It is more complex.
* Need to deal with the intricacies of Ruby packaging.
* Would need to keep up with updates to the cosign binary and update it in the event there are security vulnerabilities within it. Because this is a security critical component this is likely to be a requirement.

### 3. Use a native Ruby implementation of cosign

**Pros:**

* Potentially a reduced number of dependencies
* Does not introduce distribution complexity.

**Cons:**

* The current version of [sigstore ruby](https://docs.sigstore.dev/language_clients/ruby/) offers a very small subset of the features provided by cosign.
* Seems like it would require significant development time.
* Requires non-trivial integration code with several third-party providers.
* Requires maintenance work to keep up with any changes to standards or integration.

## Decision

**We will move forward with Including cosign in the GitLab distribution.**

This option is the simplest in terms of infrastructure complexity, and provides
good support for all sigstore features through a widely used mechanism.

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
- Reduced distribution complexity as we remove the dependency on `glgo`. This service is not available for all kinds of GitLab installation at this stage.
- Existing tooling to maintain dependencies, such as [Renovate](https://handbook.gitlab.com/handbook/engineering/infrastructure-platforms/gitlab-delivery/build/maintenance/renovate/), can be used.

### Negative

- Interacting with a command-line tool is high-risk. Although initially the parameters we would pass to the tool are not user-controlled, this negative consequence can be mitigated by adhering to well-established procedures documented in the [Shell command development guidelines page](https://docs.gitlab.com/development/shell_commands/).

## Related Links

- [Evaluate options to bundle cosign with GitLab Rails](https://gitlab.com/gitlab-org/gitlab/-/issues/554600)
