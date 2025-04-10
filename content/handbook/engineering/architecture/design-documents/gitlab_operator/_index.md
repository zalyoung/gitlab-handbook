---
title: GitLab Operator
status: proposed
creation-date: "2025-03-21"
authors: [ "@pursultani" ]
coaches: [ "@username" ]
dris: [ "@plu8" ]
owning-stage: "~devops::systems"
participating-stages: []
toc_hide: true
---

# GitLab Operator

[[_TOC_]]

## Terminology

| Term | Definition |
|------|------------|
| _[GitLab]_ component | A software module developed by the GitLab community, part of the broader GitLab solution, designed to work with other GitLab components to provide specific functionalities. |
| _[GitLab]_ instance | A complete, operational deployment of the GitLab platform, comprising multiple _components_ configured to work together as a unified system. |
| _[GitLab]_ dependency | An external component or service essential for a GitLab instance to function, not developed by GitLab. For examples databases or caching systems. |
| _[Kubernetes]_ [operator][kube_operator] | A Kubernetes extension that uses [custom resources][kube_cr] to automate the deployment, scaling, and management of complex applications. |
| _[[Helm][helm]]_ chart | A Kubernetes package that contains all the necessary manifests to create an application in Kubernetes. |
| _[GitLab]_ Chart | Helm-based Kubernetes manifests that [deploy GitLab in Kubernetes][gitlab_chart]. |
| Chart-based _[GitLab]_ Operator | Also known as [Operator V1][gitlab_operator_v1], is the current GitLab Operator that is based on a GitLab Chart. |
| _[GitLab]_ Operator | Also known as [Operator V2][gitlab_operator_v2], is the new self-contained GitLab Operator that is being developed to address the limitations of the GitLab Chart. **This blueprint is about this operator.** |
| GitLab Environment Toolkit (GET) | A [set of scripts][gitlab_get] to assist with deploying scaled GitLab environments following the [Reference Architectures][gitlab_ref_arch]. |

## Context

The [GitLab Chart][gitlab_chart] has long been the established method for installing and upgrading cloud-native GitLab
instances. While its maturity is a testament to its reliability, it also presents challenges in terms of feature
saturation and adaptability. The Chart's architecture, constrained by Helm's limitations, struggles to accommodate the
evolving needs of a complex service like GitLab and modernization practices in cloud-native environments.

Our current [Chart-based Operator][gitlab_operator_v1] (a.k.a V1), despite its name, inherits these limitations due to
its reliance on Helm. A more robust, GitLab-specific Kubernetes Operator that can overcome these constraints and provide
enhanced operational capabilities.

Adopting a modern Kubernetes operator with advanced capabilities for GitLab deployment can go beyond the traditional
install and upgrade experiences, and is a strategic move towards a fully cloud-native architecture.

This shift promises:

- Hands-off, automated lifecycle management and superior upgrade experience
- Significantly reduced operational complexity
- Enhanced adaptability to cloud-native environments and efficient scaling

The result is a more robust, self-managing deployment solution that can keep pace with GitLab's evolving features,
requirements, and environment.

## Problem

The current GitLab Chart and Chart-based Operator have significant limitations that hinder our ability to deliver an
optimal cloud-native experience:

1. Lack of real-time adaptability: Any change requires manual full reconfiguration and possibly redeployment of the
   GitLab instance.
1. Limited operational intelligence: Unable to automate complex operations like database migrations or failover.
1. Dependency on generic Kubernetes self-healing: Lacks application-specific healing capabilities.
1. Insufficient stateful component management: Cannot fully support the lifecycle of stateful components.

These limitations impede GitLab's potential in cloud-native environments, particularly for complex deployments with
stateful components and those requiring frequent scaling or minimal manual intervention.

### Business impacts

1. Suboptimal cloud-native experience for users, especially when it comes to upgrading GitLab instances. The friction
   increase the support cost for GitLab.
1. Increased operational overhead for deploying and managing GitLab instances, resulting in higher TCO for customers
   and increased internal operational costs for our support teams.
1. Slower pace of adoption of upstream changes, making it costly to add new cloud-native features and addressing future
   changes.
1. Limited ability to leverage full cloud-native architecture benefits.

## Goals

### Enhanced cloud-native experience and operational efficiency

The GitLab Operator aims to provide essential building blocks for deploying cloud-native GitLab instances, significantly
improving the user experience and operational efficiency. It will enable real-time adaptability, automate complex
operations such as GitLab upgrades, and optimize the management of stateful components.

By reducing manual intervention and lowering operational overhead, the Operator will allow users to leverage the full
benefits of cloud-native architecture while abstracting away the underlying complexities of GitLab deployment and
management in Kubernetes environments.

### First-class Kubernetes integration

A key goal of the GitLab Operator is to integrate GitLab seamlessly into the Kubernetes ecosystem. This integration will
adhere to Kubernetes conventions, best practices, and terminology, positioning _GitLab as a first-class citizen in
Kubernetes ecosystem_.

The Operator will implement application-specific self-healing capabilities that go beyond generic Kubernetes features,
ensuring a more robust and reliable GitLab deployment. Furthermore, it will maintain a consistent user experience even
as the Kubernetes API and GitLab applications evolve over time, providing stability and predictability for self-managed
GitLab instances.

### Standardized model for cloud-native deployment

The GitLab Operator project aims to establish a standardized, fully distributed development model. This approach will
encourage contributions from various feature teams, fostering a more collaborative and efficient development process.
By implementing consistent patterns and standards across the project, the Operator will create a solid foundation for
future enhancements and adaptations.

This standardization will not only improve the quality and consistency of the codebase but also facilitate easier
onboarding of new contributors and enable more rapid iteration on features and improvements. The goal is to create a
development ecosystem that is as robust and adaptable as the cloud-native environments the Operator is designed to
support.

## Non-Goals

### Orchestration and full configuration of GitLab components

GitLab Operator does not focus on orchestrating the building blocks it provides or handling the end-to-end configuration
required for a complete GitLab instance. For these aspects, the Operator relies on other projects such as GET and the
GitLab Helm Chart, which are better suited for comprehensive deployment and configuration tasks.

### Replacement of existing deployment tools

GitLab Operator is not intended to replace existing deployment methods such as GET or the GitLab Helm Chart. Instead, it
aims to complement these tools by providing Kubernetes-native resources that can be incorporated into various deployment
strategies.

### Management of non-Kubernetes deployments

GitLab Operator is specifically designed for Kubernetes environments and will not address deployment or management of
GitLab in non-Kubernetes contexts.

### Application-level feature development

GitLab Operator will focus on deployment and infrastructure-level concerns. It will not be responsible for developing or
implementing application-level features of GitLab components. As such, its features are bounded by the cloud-native
capabilities of GitLab components.

## Design approach

The GitLab Operator adopts a LEGO®-like approach to GitLab deployment and management. Instead of providing a monolithic
solution, it offers discrete building blocks that can be assembled according to specific requirements and desired
Reference Architecture.

The following table outlines the differences in design approach between GitLab Chart and GitLab Operator.

| Aspect | GitLab Chart | GitLab Operator |
|--------|--------------|-----------------|
| Primary Focus | Installation | Operation |
| Architecture | All-in-one, one-size-fits-all | Loosely coupled, strongly cohesive blocks |
| Dependencies | Batteries included | No dependencies included, integration-focused |
| Scope | Everything a typical GitLab needs are predefined | Modular components that can be assembled and configured in any form |
| Orchestration | Self-contained | No built-in orchestration, relies on other tools |

### Key design elements

#### Component-based architecture

1. Each GitLab component is represented as a separate [Kubernetes custom resource][kube_cr].
1. Components can be deployed, upgraded, and scaled independently.
1. Orchestrate components in various configurations to address different deployment scenarios and [reference architectures][gitlab_ref_arch].

#### Integration-first approach

1. Prefer integration over inclusion. Designed to integrate with existing infrastructure rather than bundling
   dependencies.
1. Connects with databases, object storage, and other services already present in the environment.

#### Orchestration through external tools

1. Rely on established tools for orchestration:
   - [GitLab Environment Toolkit][gitlab_get]
   - [Helm][helm]
   - [Kustomize][kustomize]

[gitlab_chart]: https://gitlab.com/gitlab-org/charts/gitlab
[gitlab_operator_v1]: https://gitlab.com/gitlab-org/cloud-native/gitlab-operator
[gitlab_operator_v2]: https://gitlab.com/gitlab-org/cloud-native/operator
[gitlab_get]: https://gitlab.com/gitlab-org/gitlab-environment-toolkit
[gitlab_ref_arch]: https://docs.gitlab.com/administration/reference_architectures
[kube_cr]: https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/
[kube_operator]: https://kubernetes.io/docs/concepts/extend-kubernetes/operator/
[helm]: https://helm.sh/
[kustomize]: https://kustomize.io/
