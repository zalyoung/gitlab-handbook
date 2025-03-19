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
| GitLab component | A software module developed by the GitLab community, part of the broader GitLab solution, designed to work with other GitLab components GitLab to provide specific functionalities. |
| GitLab instance | A complete, operational deployment of the GitLab platform, comprising multiple _components_ configured to work together as a unified system. |
| GitLab dependency | An external component or service essential for a GitLab instance to function, not developed by GitLab. For examples databases or caching systems. |
| Kubernetes operator | A Kubernetes extension that uses custom resources to automate the deployment, scaling, and management of complex applications. |
| GitLab Chart | Helm-based Kubernetes manifests that deploy GitLab in Kubernetes. |
| Chart-based GitLab operator | Also known as Operator V1, is the current GitLab Operator that is based on a GitLab Chart. |
| GitLab Operator | Also known as Operator V2, is the new self-contained GitLab Operator that is being developed to address the limitations of the GitLab Chart. |
| GitLab Environment Toolkit (GET) | A set of scripts to assist with deploying scaled GitLab environments following the Reference Architectures. |

## Context

The GitLab Chart has long been the established method for installing and upgrading cloud-native GitLab instances. While
its maturity is a testament to its reliability, it also presents challenges in terms of feature saturation and
adaptability. The Chart's architecture, constrained by Helm's limitations, struggles to accommodate the evolving needs
of a complex service like GitLab.

Our current Chart-based GitLab Operator (V1), despite its name, inherits these limitations due to its reliance on Helm.
A more robust, GitLab-specific Kubernetes Operator that can overcome these constraints and provide enhanced operational
capabilities.

Adopting a more advanced Kubernetes Operator for GitLab deployment is a strategic move towards a fully cloud-native
architecture.

It promises:

- Hands-off, automated lifecycle management and superior upgrade experience
- Significantly reduced operational complexity
- Enhanced adaptability to cloud-native environments and efficient scaling

The result is a more robust, self-managing deployment solution that can keep pace with GitLab's evolving features and
requirements.

## Problem

The current GitLab Chart and Chart-based Operator have significant limitations that hinder our ability to deliver an
optimal cloud-native experience:

1. Lack of real-time adaptability: Any change requires full re-deployment of the GitLab instance.
1. Limited operational intelligence: Unable to automate complex operations like migrations or failover.
1. Dependency on generic Kubernetes self-healing: Lacks application-specific healing capabilities.
1. Insufficient stateful component management: Cannot fully support the lifecycle of stateful components.

These limitations impede GitLab's potential in cloud-native environments, particularly for complex deployments with
stateful components and those requiring frequent scaling or minimal manual intervention.

### Business Impacts

1. Suboptimal cloud-native experience for users, especially when it comes to upgrading GitLab instances.
1. Higher operational overhead for lifecycle management.
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

1. Orchestration and full configuration of GitLab components: GitLab Operator does not focus on orchestrating the
   building blocks it provides or handling the end-to-end configuration required for a complete GitLab instance. For
   these aspects, the Operator relies on other projects such as GET and the GitLab Helm Chart, which are better suited
   for comprehensive deployment and configuration tasks.

1. Replacement of existing deployment tools: GitLab Operator is not intended to replace existing deployment methods such
   as GET or the GitLab Helm Chart. Instead, it aims to complement these tools by providing Kubernetes-native resources
   that can be incorporated into various deployment strategies.

1. Management of non-Kubernetes deployments: GitLab Operator is specifically designed for Kubernetes environments and
   will not address deployment or management of GitLab in non-Kubernetes contexts.

1. Application-level feature development: GitLab Operator will focus on deployment and infrastructure-level concerns. It
   will not be responsible for developing or implementing application-level features of GitLab components.

## Design approach

The GitLab Operator adopts a LEGO®-like approach to GitLab deployment and management. Instead of providing a monolithic
solution, it offers discrete building blocks that can be assembled according to specific requirements and desired
Reference Architecture.

### Key design elements

#### Component-based architecture

1. Each GitLab component is represented as a separate Kubernetes custom resource.
1. Components can be deployed, upgraded, and scaled independently.
1. Orchestrate components in various configurations to address different deployment scenarios.

#### Integration-first approach

1. Prefer integration over inclusion. Designed to integrate with existing infrastructure rather than bundling
   dependencies.
1. Connects with databases, object storage, and other services already present in the environment.

#### Orchestration through external tools

1. Rely on established tools for orchestration:
   - GitLab Environment Toolkit (GET)
   - Helm
   - Kustomize

### Comparison with GitLab Chart

| Aspect | GitLab Chart | GitLab Operator |
|--------|--------------|-----------------|
| Primary Focus | Installation | Operation |
| Architecture | All-in-one, one-size-fits-all | Loosely coupled, strongly cohesive blocks |
| Dependencies | Batteries included | No dependencies included, integration-focused |
| Scope | Everything a typical GitLab needs | Modular components that can be assembled and configured |
| Orchestration | Self-contained | No built-in orchestration, relies on external tools |
