---
title: "ADR 004: Provider-Based Entitlements"
toc_hide: true
---

## Context

### Problems with the Previous Entitlement Architecture

#### Unit primitives as the only dimension

Previously, the entitlement architecture in CloudConnector:

- treated **features (unit primitives)** as the sole dimension for entitlement decisions.
- lacked any concept of **platform-level (provider) entitlements** above individual features.
- enforced all entitlement logic:
    - purely at the unit primitive level
    - without context of which provider or platform was delivering the feature.

#### Limitations and technical debt

This created several limitations:

- **No way to combine add-ons per provider:**
    - Example: In Self-Hosted Models, all AI features were forced to require `duo_enterprise`.
    - It was impossible to support combinations like:
      > “Self-Hosted Models + Duo Pro”

    - Workarounds required:
        - overriding CloudConnector configuration at runtime
        - hardcoding:
          > “All features now require Duo Enterprise under Self-Hosted Models”

  Similar issues arose with:
    - Amazon Q
    - future third-party providers
    - any scenarios where providers might deliver the same unit primitives but with different licensing or monetization models.

- **No provider-level monetization strategies:**
    - Features could only be monetized as standalone entitlements.
    - It was impossible to package features differently under different providers.
        - Example: `duo_chat` might be free under `gitlab_duo`, but paid under `self_hosted_models`.

- **Workarounds increased technical debt:**
    - To support Self-Hosted Models or Amazon Q:
        - logic was introduced outside CloudConnector
        - entitlement checks were duplicated
    - CloudConnector data was overridden in memory, leading to inconsistencies and fragile code.


## Decision

We will introduce **provider-level entitlements as a first-class dimension** alongside unit primitives. This adds a new axis of flexibility to our entitlement model, enabling us to package and monetize the same features differently under different providers.

## The New Architecture: Provider + Unit Primitive

### Two-dimensional entitlements

Instead of simply asking:

> “Is feature X allowed?”

the new model evaluates:

> “Is provider Y allowed?”
> “Is feature X under provider Y allowed?”

### Provider entitlements

A **provider** (or platform):

- represents the higher-level integration layer.
- examples:
    - `gitlab_duo`
    - `self_hosted_models`
    - `amazon_q`

Each provider can define its own:

- required add-ons
- minimum GitLab version
- licensing constraint

### Unit primitives

A **unit primitive** remains:

- the granular capability:
    - e.g. `:duo_chat`
    - e.g. `:summarize_merge_request`

However, unit primitives are now:

- attached to one or more providers
- no longer bound to global, provider-agnostic entitlements

### Example of new flexibility

#### Self-Hosted Models

- **Before:**
    - all features under Self-Hosted Models forcibly required `duo_enterprise`.
    - no flexibility to allow `duo_pro` instead.

- **Now:**
    - Self-Hosted Models can:
        - accept either `duo_enterprise` or `self_hosted` add-ons.
        - optionally allow `duo_pro` for specific features.

#### GitLab Duo

- continues to offer:
    - some features for free
    - others requiring add-ons like `duo_pro`

However:

- the same unit primitives can now exist under both providers.

Example:

- `:duo_chat`:
    - free under `gitlab_duo` (duo_core)
    - paid under `self_hosted_models` (duo_pro or duo_enterprise only)

There is no longer a need to redefine features separately for each provider.

## Benefits

### Different monetization strategies per provider

- Self-hosted-models or amazon_q instances can monetize features individually.

### No need for runtime overrides

- All rules are stored in CloudConnector.
- Eliminates runtime patching or special-casing in entitlement logic.

### Supports cross-provider add-ons

- Add-ons like `duo_pro` can:
    - apply to both `gitlab_duo` and `self_hosted_models` providers.
- Add-on like  `duo_core` can:
    - apply only to  `gitlab_duo` provider

### Cleaner separation of concerns

- CloudConnector stores configuration data:
    - add-on requirements
    - cut-off dates
    - provider-feature mappings

Business logic and entitlement orchestration can then reliably consume this configuration without hardcoded overrides.

## Implementation Details

### CloudConnector data changes

#### New Provider configuration
Provider can explicitly define which add_ons and license_types are required

```yaml
---
name: self_hosted_models
add_ons:
    - self_hosted_modes
    - duo_enterprise
licence_types:
    - premium
    - ultimate
```

#### UnitPrimitive updates
Unit primitive now explicitly define which providers they support.

```yaml
---
name: duo_chat
add_ons:
  - duo_core
  - duo_pro
  - duo_enterprise
licence_types:
  - premium
  - ultimate
providers:
  - gitlab_duo
  - self_hosted_models
  - amazon_q
```

#### Addon updates
Add-ons now explicitly define which providers they support. This allows precise modeling of add-on availability across platforms.

Example:

```yaml
name: duo_core
providers:
  - gitlab_duo
```

```yaml
name: duo_pro
providers:
  - gitlab_duo
  - self_hosted_models
```

This means:

- If a customer has only `duo_core`, features like `duo_chat` would be available **only under `gitlab_duo`**.
- If the customer has `duo_pro`:
    - the same feature can also be available under `self_hosted_models`.
- The system can flexibly allow or restrict feature usage based on:
    - provider context
    - the specific add-ons the customer has purchased


## Migration Plan

We will incrementally migrate all entitlement checks to resolve entitlements in the order:

> provider → unit primitive

Legacy logic based on:
- AvailableServices
- runtime CloudConnector overrides

will be gradually removed.


## Future Direction

While this change focuses on **static entitlements**, the architecture lays the groundwork for future support of:

- new providers
- different packaging and pricing for custom models


## Consequences

### Positive

- **Flexible monetization**:
    - different monetization models per provider
    - ability to package features differently across platforms
- **Cleaner architecture**:
    - eliminates runtime overrides
    - removes fragile special-casing
- **Single source of truth**:
    - provider and unit primitive relationships fully captured in CloudConnector

### Negative

- **Increased complexity**:
    - introduces a new provider dimension into entitlement logic
- **Migration effort**:
    - existing entitlement checks must be updated to the new provider + feature model

## Next Steps

- Complete updates to CloudConnector to support provider mappings.
- Begin migrating entitlement checks in relevant services.
- Update documentation to reflect the new provider-based model.
- Remove legacy runtime overrides and AvailableServices once all checks are migrated.


## Useful Links

- [GitLab Cloud Connector - unit primitive config](https://gitlab.com/gitlab-org/cloud-connector/gitlab-cloud-connector)
- [Initial discussion on provider-based entitlements](https://gitlab.com/gitlab-org/gitlab/-/issues/502821)
- [Self-Hosted Models architectural constraints](https://gitlab.com/gitlab-org/gitlab/-/issues/503210)
