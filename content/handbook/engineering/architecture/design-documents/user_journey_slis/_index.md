---
title: User Journey Service Level Indicators Architecture
status: proposed
creation-date: "2025-02-03"
authors: [ "@hmerscher" ]
coaches: [ "@reprazent", "@andrewn" ]
dris: []
owning-stage: "~team::Observability"
participating-stages: []
toc_hide: true
---

<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< design-document-header >}}

## Summary

This design document proposes a new architecture for measuring and tracking user journeys across GitLab services. A user journey represents an end-to-end flow of user interactions that may span multiple services (e.g., from receiving a git push in GitLab Shell to updating a merge request). The proposal includes creating a new service for maintaining journey state, developing an SDK within LabKit for instrumenting journeys, and establishing a framework for product teams to define and monitor critical user journeys.

The system will help measure the reliability and performance of key user interactions and provide valuable data for both operational excellence and product decisions.

## Motivation

While GitLab has robust service-level metrics through our SLI framework, we currently lack a systematic way to track and measure complete user journeys that span multiple services. Our existing SLIs excel at measuring individual service performance but cannot effectively track the success/failure rate and performance of end-to-end user interactions. This gap makes it challenging to:

- Understand the true user experience across service boundaries
- Set and monitor meaningful SLOs for complex user interactions
- Identify bottlenecks in multi-service flows
- Ensure critical user paths are well-tested and monitored

### Goals

- Create a framework for product teams to define important user journeys in a structured way
- Develop an SDK that makes it easy for engineers to instrument user journey start/end points
- Build a service to track journey state and emit relevant metrics/logs
- Support both GitLab.com and self-managed/dedicated deployments
- Enable measurement of journey success/failure rates and durations through SLIs
- Provide data that can help identify test coverage gaps for critical user paths

### Non-Goals

- Building a general-purpose distributed tracing solution
- Supporting user journeys that originate outside GitLab services (e.g., client-side only flows)
- Real-time journey visualization or debugging tools
- Initial support for languages other than Ruby

## Proposal

The core proposal consists of three main components:

1. Journey Definition Framework
    - YAML-based journey definitions authored by product teams
    - Support for specifying success criteria and SLO targets
    - Integration with test coverage reporting

2. LabKit SDK
    - DSL for marking journey start/end points
    - Journey ID generation and propagation
    - Automatic state management and metric emission
    - Built-in retry and backoff mechanisms

3. Journey State Service
    - Centralized journey state tracking
    - Metric aggregation and SLI calculation
    - Support for both Runway and self-managed deployments
    - Sensible time to live (TTL) threshold for journey duration

## Design and implementation details

### Journey Definition

TBD

### SDK Design

- Implementation in LabKit focusing on Ruby support initially
- Journey ID generation
- Automatic retries with exponential backoff
- Batch operation support

### User Journey State Management Service

TBD

### Service Architecture

- Runway service for GitLab.com
- Kubernetes deployment for self-managed instances
- Redis for state storage?

### Failure Modes

- Journey timeout after configured threshold (default 5 minutes)
- Automatic cleanup of stale journeys
- Retry mechanisms for state updates

### Initial Implementation Scope

- Ruby-only support targeting Rails application
- Focus on web request and Sidekiq job flows
- Batching support
- Success/failure tracking measurements

## Alternative Solutions

1. Distributed Tracing
   Pros:
   - Existing solutions available

   Cons:
   - Different cardinality requirements -- one trace per request
   - Lack of business-level success criteria
   - More complex to implement and maintain

2. Do Nothing
   Pros:
   - No implementation cost

   Cons:
   - Continue lacking end-to-end user journey visibility
   - Harder to set meaningful SLOs
   - Miss opportunities for better capturing perceived user experience and testing coverage
