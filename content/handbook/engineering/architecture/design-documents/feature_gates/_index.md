---
title: "Feature Gates - A unified solution for feature release control"
status: proposed
creation-date: "2025-06-25"
authors: [ "@splattael", "@nao.hashizume", "@mgamea" ]
coaches: [ "@rymai" ]
dris: []
owning-stage: "~group::developer tooling"
participating-stages: []
toc_hide: true
---

{{< engineering/design-document-header >}}

## Executive Summary

Feature Gates is a unified solution for controlling feature releases across
all GitLab environments - GitLab.com, Dedicated, and self-managed instances.
This solution replaces the current fragmented feature flag approach with a
standardized system that provides better lifecycle management, monitoring and
operational control.

The solution introduces coarse-grained feature gates (one per product feature)
instead of fine-grained feature flags, with mandatory lifecycle management,
automated workflows, and comprehensive monitoring. It addresses critical
challenges including the lack of kill switches for stable features, complex
rollouts across different environments, and the growing technical debt from
over 700 feature flags in the codebase.

## Problem Statement

GitLab's current feature flag implementation has served us well but faces
significant challenges at scale. With over 700 feature flags in production and
multiple deployment environments, we need a more structured approach to feature
release control.
### Status Quo
TBD
### Challenges

The current feature flag system creates several critical issues:

- **No kill switches for stable features**: Once features reach general
  availability, we lose the ability to quickly disable them during incidents.
- **Complex cross-environment management**: Different configurations across
  gitlab.com, staging, and self-managed installations create confusion and
errors.
- **Technical debt accumulation**: Feature flags persist long after they should
  be removed, creating a complex matrix of configurations.
- **Poor auditing**: Engineers, product managers, and SREs struggle to
  keep track of feature flag states across environments.
- **Manual processes**: Flag creation, rollout, and cleanup require significant
  manual effort and coordination.

### Objectives

- **Complete separation** of gitlab.com and self-managed feature release
  processes.
- **Gradual rollout strategies** for gitlab.com supporting both stability and
  growth objectives.
- **Faster incident resolution** through instant feature disabling without
  rollbacks.
- **Improved velocity** by isolating feature issues without affecting entire
  deployments.
- **Better resilience** to handle features that develop issues hours or days
  after deployment.

### Out of Scope

- Migrating existing feature flags to the new system: these will be evaluated and either get cleaned up or converted to settings if needed be by owning groups.
- Building feature gates for commercial use: this solution is scoped to GitLab internal development and release control only.

## Proposal

Feature Gates is a standalone system for feature flag and remote confirguation management, enabing various stakeholders across GitLab to contribute to the release lifecycle safely and efficiently.

## Capablities List

### Feature Gate Definition
- The system offer the following gate types:
  - **Boolean**: simply true or false.
    - **Suitable for**: Kill switches, dis/enabling changes in UI or feature behavior, or operational workflow, etc.
  - **Multivariate**: have more than two variations. Values can be String, Number, or JSON.
    - **Suitable for**: A/B/n Testing, Attribute targeting or Incremental rollouts.
- **Decision making considerations**
  - Some factors to consider when deciding to use or skip feature gates:
     - Blast radius of change
     - Impacted user segments
     - Complexity of change
     - Test coverage of change (and Test stability)
     - Performance of change
     - Roll back cost for failures (Think twice)
  - Depending on the use case at hand and what the teams are aiming to accomplish, they can decide which gate type(s) to use.
  - While It's a team's decision whether to use gates when rolling out changes or not, it's highly recommended to design features against failures with consideration to the impact on the overall user journey(s) in mind and take measures such using feature gates for faster disaster recovery.
  - Change Roll out decisions should be documented in the feature gates decision log.
- Creating feature gates is easily done either in UI or via APIs.

### Feature Development workflow

#### SDK Implementation

The system offers client SDKs which provide consistent interfaces across all supported languages
(i.e. Ruby, Go, Python, and JavaScript). 
Client SDKs handle gate evaluation, caching, and
fallback behavior transparently, allowing developers to check gate status with
simple boolean checks while the complex logic remains abstracted.

#### Backend Architecture

The Feature Gates backend provides:

1. **High-performance caching**: Sub-millisecond gate evaluation
2. **Resilient fallbacks**: Local caching when backend unavailable
3. **Real-time updates**: WebSocket connections for instant changes
4. **Audit logging**: Complete history of all gate changes

### Integration Points

#### CI/CD Pipeline Integration

- Automated testing with feature gates in different states.
- Feature Gate state validation in merge requests.
- Deployment markers for gate changes.

#### Monitoring Integration

- Automatic correlation of functional errors with feature gate state changes.
- Performance impact tracking per feature gate.
- Alerting on anomalous behavior after feature gate state changes.

#### Incident Response Integration

- Incident.io integration for emergency disabling.
- Automated rollback suggestions based on error patterns and defined error budgets.
- Slack notifications for feature gate state changes.

### Release Management

#### GitLab.com Rollout

1. Internal testing (employees only)
2. Ring 0 deployment (10% of organizations)
3. Ring 1 deployment (50% of organizations)
4. Ring 2 deployment (100% of organizations)
5. Gate removal after stability period

#### Dedicated Rollout

1. Feature available in admin panel
2. Customer opts in at their discretion
3. Support team can disable if issues arise

#### Self-managed Rollout

1. Feature ships disabled by default
2. Admins enable through feature preview panel
3. Can be disabled without GitLab support

### Lifecycle Management and Governonace

#### Automated Gate Creation

- Danger bot suggests gate creation for new features
- Pre-filled metadata from MR context
- Automatic rollout issue creation
- Feature gates are disabled by default upon creation.

#### Automated Cleanup

- Removing feature gates after full rollout + stability period.
- Archiving feature gate history for analysis.
- Updating documentation automatically.

#### Auditing
TBD

### Observability and Monitoring

- Tracking usage metrics from feature gate introduction.
- Alerting on gates nearing maximum lifespan.

### System Architecture
Feature Gates introduces a three-tier architecture:

1. **Unified Backend Service**: A centralized service managing all feature gate
   states across environments.
2. **Multi-Language SDKs**: Native SDKs for Ruby, Go, Python, and Javascript with
   consistent APIs.
3. **Management Dashboard**: Comprehensive UI for viewing and controlling feature gates
   across all environments.

#### High-Level Architectural Design

TBD mermaid chart


#### Key Components

TBD

## Implementation Approach

### Option 1: Enhance Current Feature Flags

### Option 2: Third-Party Feature Flag Solution

## Success Metrics


## Conclusion

With a robust architecture, well-defined governance and lifecycle management framework, and scalable infrastructure, the Feature Gates System is poised to support our business through 2026 and beyond. Ongoing updates and maintenance will ensure the system remains aligned with technological advancements and evolving business requirements.

## References
TBD