---
title: Covered Experience SLIs
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

[TOC]

## Summary

This design document proposes a new architecture for measuring and tracking covered experiences across GitLab services. A covered experience SLI represents an end-to-end flow of user interactions that may span multiple services (e.g., from receiving a git push in GitLab Shell to updating a merge request). This proposal includes a design for instrumenting Covered Experience SLIs, and establishing a framework for product teams to define and monitor critical covered experiences.

The system will help measure the reliability and performance of key user interactions and provide valuable data for both operational excellence and product decisions.

We intend to have an aligned definition of User Journeys across the organization, with Covered Experience SLIs being a scoped set of steps from a User Journey that support the broader goal a user might be trying to accomplish. Read more [here](https://gitlab.com/groups/gitlab-com/gl-infra/-/epics/1524#are-these-related-to-covered-experiences-fka-user-journey-slis).

Here's a graph that illustrates how the different parties are connected to this idea:

![User Journeys Chart](/images/handbook/engineering/architecture/design-documents/covered_experience_slis/User%20Journeys%20for%20Quality.svg)

[graph src](https://lucid.app/lucidchart/e911c437-dbdf-4540-bf44-23962e048661/edit)

PS: The graph is still a work in progress. The image you see might be already outdated. Please refer to the src link to the up-to-date version.

## Glossary

Here's a list of words to disambiguate the terms we are going to use in the context of this document:

- **Application SLI**: https://docs.gitlab.com/ee/development/application_slis/ This is an SLI defined on the application side: the application decides what is “good” for apdex and error portion. The SLI is associated with a service for monitoring in the runbooks repository.
- **Apdex (Application Performance Index)**: At GitLab in the context of covered experience SLIs, it is the completion of something within an acceptable amount of time, for example, the changes of a push are visible on the merge request within 30 seconds.
- **User Journey**: A comprehensive visualization or map that illustrates all the steps, interactions, and emotions a customer experiences when engaging with a product, service, or brand, from initial awareness through purchase and beyond. In GitLab, it is the journey a user takes through the application. This can include multiple experiences. For example: Create a project -> Create an issue -> Create a merge request.
- **Covered experience**: An action that a user takes inside the application that is covered with an Indicator. A Covered Experience outlines the precise services, scenarios, and user interactions that establish clear performance expectations between a service provider and their client, some of which are covered by an SLI. Examples of experiences: “create a project”, “create an issue”, “create a merge request”.
- **Limited covered experience**: Refers to a restricted subset of services, scenarios, or user interactions that have defined performance standards in an SLA, with certain conditions, exceptions, or constraints that limit the provider's obligations or the scope of guaranteed service levels.
- **Multi-action experience**: A user journey that consists of multiple user interactions before completion, for example creating an issue consisting of 2 steps: render new, submit form. We will not support this in the first iteration of Covered Experience SLIs.
- **Single-action experience**: A user journey that consists of a single user interaction, for example “view an issue” or “add a comment to an issue”.
- **Multi-service experience**: A journey that depends on multiple services to successfully complete, for example: a push gets received by GitLab-shell, which calls out to Rails, Gitaly and Sidekiq. A multi-service experience could be a single-action experience, only a single user-action is required for the experience, but it spans multiple services to be completed.
- **Step**: A checkpoint in the experience for which we can emit an event, an event could be a failure or a success.
- **Criteria**: Each Experience can have one or more criteria that can be used to measure success. For example: “The issue is successfully created” AND “The issue is created fast enough”.

## Motivation

While GitLab has robust service-level metrics through our SLI framework, we currently lack a systematic way to track and measure covered experiences that span multiple services. Our existing SLIs excel at measuring individual service performance but cannot effectively track the success/failure rate and performance of end-to-end user interactions. This gap makes it challenging to:

- Understand the true user experience across service boundaries
- Set and monitor user-centric SLOs for complex user interactions
- Identify bottlenecks in multi-service flows
- Ensure critical user paths are well-tested and monitored (i.e. https://gitlab.com/groups/gitlab-org/quality/-/epics/144)
- Attribute availability and impact of incidents to customers or users

### Goals

- Create a framework for product teams to define important covered experiences in a structured way
- Develop an SDK that makes it easy for engineers to instrument covered experiences
- Build a service to track covered experience state and emit relevant metrics and structured logs with all the relevant context
- Support both GitLab.com and dedicated deployments
- Enable measurement of covered experience success/failure rates and durations through SLIs
- Provide data that can help identify test coverage gaps for critical user paths

### Non-Goals

- Building a general-purpose distributed tracing solution
- Tracking client side timings, and time on the wire to clients. In the future, we want to add support for clients we build (IDE-extensions, our frontend), but we're keeping this out of scope in the first iteration.
- Real-time covered experience visualization or debugging tools
- Logs and metrics will be emitted from self-managed, but it won't officially support ingesting information from those instances as we don't have control over such environments

## Proposal

The core proposal consists of three main components:

1. Covered Experience Definition Framework
   - YAML-based covered experience definitions authored by product teams
   - Support for specifying success criteria and SLO targets
   - Integration with test coverage reporting

2. LabKit SDK
   - DSL for marking covered experience start/end points
   - Covered Experience ID generation and propagation
   - Built-in retry and backoff mechanisms

3. Covered Experience Tracker Service
   - Centralized Covered Experience state tracking
   - Support for both Runway and self-managed deployments
   - Sensible time to live (TTL) threshold for journey duration
   - Authentication

## Design and implementation details

Here's a simplified flowchart to demonstrate how the communication will flow overall:

```mermaid
flowchart LR
    User((User))

    subgraph ServiceA
        subgraph Process
            LabKit
        end
    end
    subgraph ServiceB
        subgraph ProcessB
            LabKitB
        end
    end

    subgraph tracker[Covered Experience Tracker]
        missing_end[Missing end event]
        timeout_check{Timeout check}
        timeout_action[Timeout action]

        missing_end --> timeout_check
        timeout_check --no timeout--> missing_end
        timeout_check --timeout reached--> timeout_action
    end

    User --> ServiceA
    LabKit --emit message--> tracker
    ServiceA --Forward Request--> ServiceB
    LabKitB --emit message--> tracker
```

Below there are cases covering in detail synchronous, asynchronous, and batched requests.

### Synchronous workflow

```mermaid
sequenceDiagram
    participant User
    participant App as Service A
    participant AppB as Service B
    participant Tracker as Covered Experience Tracker
    participant Redis
    participant Metrics as Mimir

    User->>App: Request
    activate App

    App->>Tracker: Start Tracker
    Tracker->>Redis: Store Initial State

    App->>AppB: Forward Request
    activate AppB

    AppB->>Tracker: Checkpoint Event
    Tracker->>Redis: Update State

    AppB-->>App: Response
    deactivate AppB

    App->>Tracker: End Tracker
    Tracker->>Redis: Mark Complete
    Tracker->>Metrics: Emit Metrics

    App-->>User: Response
    deactivate App

    loop Expired Covered Experience
        Tracker->>Redis: Check for Missing End Events
        alt Timeout Reached
            Tracker->>Redis: Mark Failed
            Tracker->>Metrics: Emit Failure Metrics
        end
    end
```

### Asynchronous workflow

```mermaid
sequenceDiagram
    participant User
    participant Web as Web Service
    participant Tracker as Covered Experience Tracker
    participant Redis
    participant Sidekiq as Sidekiq Worker
    participant Metrics as Mimir

    User->>Web: Request
    activate Web

    Web->>Tracker: Start Covered Experience
    Tracker->>Redis: Store Covered Experience State

    Web->>Sidekiq: Enqueue Job
    Web-->>User: Response (202 Accepted)
    deactivate Web

    Note over Sidekiq: Job may wait in queue

    activate Sidekiq
    Sidekiq->>Tracker: Checkpoint Event
    Tracker->>Redis: Update State

    Note over Sidekiq: Process async work

    alt Success Case
        Sidekiq->>Tracker: End Covered Experience (Success)
        Tracker->>Redis: Mark Complete
        Tracker->>Metrics: Emit Success Metric
    else Failure Case
        Sidekiq->>Tracker: End Covered Experience (Failed)
        Tracker->>Redis: Mark Failed
        Tracker->>Metrics: Emit Failure Metric
    end
    deactivate Sidekiq

    loop Expired Covered Experiences
        Tracker->>Redis: Check for Missing End Events
        alt Timeout Reached
            Tracker->>Redis: Mark Failed
            Tracker->>Metrics: Emit Failure Metrics
        end
    end
```

### Batched workflow

```mermaid
sequenceDiagram
    participant Git as Git Client
    participant WH as Workhorse
    participant Tracker as Covered Experience Tracker
    participant Web as Web Service

    Note over Git, Web: First Request
    Git->>WH: Git HTTP Request
    WH-->>Git: Response 1
    Note over WH: Start collecting batch

    Note over Git, Web: More Requests...
    Git->>WH: Git HTTP Request
    WH-->>Git: Response 2
    Git->>WH: Git HTTP Request
    WH-->>Git: Response 3

    Note over Git,Web: Last Request
    Git->>WH: Git HTTP Request
    WH-->>Git: Response N

    Note over WH: Batch threshold met
    WH->>Tracker: Start Covered Experience with batch range
    WH->>Web: Forward batched requests
    Web-->>WH: Process batch response
    WH->>Tracker: End Covered Experience
```

### Covered Experience Definition Spec

The Covered Experience definition will contain the relevant details. For example:

| Field                              | Type    | Required | Default | Description                        | Example                        |
|------------------------------------|---------|----------|---------|------------------------------------|--------------------------------|
| id                                 | string  | Yes      | -       | Unique identifier for the journey  | `merge_request_creation`       |
| description                        | string  | Yes      | -       | Human readable description         | "User creates a merge request" |
| feature_category                   | string  | Yes      | -       | GitLab feature category            | `source_code_management`       |
| apdex_success_threshold_in_seconds | integer | Yes      | -       | Apdex success threshold in seconds | `30`                           |
| timeout_in_seconds                 | integer | Yes      | -       | Journey timeout in seconds.        | `300`                          |

Examples:

| id                     | description                         | feature_category       | apdex_success_threshold_in_seconds | timeout_in_seconds |
|------------------------|-------------------------------------|------------------------|------------------------------------|--------------------|
| merge_request_creation | User creates a merge request        | source_code_management | 30                                 | 300                |
| git_push               | User pushes commits to a repository | source_code_management | 10                                 | 60                 |

### SDK Requirements

- Implementation in LabKit
- Covered Experience ID generation
- Automatic retries with exponential backoff for sending reports to the Covered Experience Tracker
- Optional batching of requests before reporting to the Covered Experience Tracker

### Covered Experience Tracker

The Covered Experience Tracker will serve an endpoint that will respond to the client generated payload:

| Field             | Type              | Required             | Description                                       | Example                                        | Observations                                        |
|-------------------|-------------------|----------------------|---------------------------------------------------|------------------------------------------------|-----------------------------------------------------|
| journey_id        | string (UUID)     | Yes                  | Unique identifier for a specific journey instance | "f6587c32-6e2f-4586-a82e-8d73c335e8cd"         | Same ID must be used across all events in a journey |
| journey_name      | string            | Yes                  | Name of journey as defined in YAML config         | "http_request"                                 | Must match a journey definition                     |
| event_type        | string            | No                   | Type of event in journey lifecycle                | "start", "end", "checkpoint"                   | If omitted, event is considered a checkpoint        |
| component         | string            | Yes                  | Service/component generating the event            | "web", "database"                              | -                                                   |
| client_timestamp  | string (ISO-8601) | Yes                  | Timestamp when event occurred                     | "2025-02-06T14:30:00Z"                         | -                                                   |
| context           | object            | Yes                  | Additional journey context                        | {"feature_category": "source_code_management"} | -                                                   |
| server_timestamp  | string (ISO-8601) | No (Response only)   | Server processing timestamp                       | "2025-02-06T14:30:00.123Z"                     | Timestamp of the time of processing                 |
| batch_range       | object            | No                   | Time range for batched events                     | see below                                      | Used when events are batched together               |
| batch_range.start | string (ISO-8601) | Yes (if batch_range) | Start time of batch                               | "2025-02-07T10:00:00.123Z"                     | -                                                   |
| batch_range.end   | string (ISO-8601) | Yes (if batch_range) | End time of batch                                 | "2025-02-07T10:00:05.678Z"                     | -                                                   |

Batched operations collect the `start` and `end` timestamp of batched requests.

State is managed by Redis. Allowing the querying of stale covered experiences, timing out after configured threshold.

A background process verifies all stale covered experiences and clear them out, emitting failure metrics.

Deployments:

- Runway service for GitLab.com
- Runway hosted service for Dedicated

### Authentication

Authentication between the SDK and the Covered Experience Tracker is required to prevent malicious actors from injecting fake events that could distort the reliability metrics of GitLab features and cause DDoS.

TBD: implmentation details.

### Initial Implementation Scope

- Ruby-only support targeting Rails application
- Focus on web request and Sidekiq job flows
- Batching support
- Success/failure tracking measurements

## Alternative Solutions

1. Distributed Tracing
   Pros:
   - Existing solutions available
   - Opportunity to iterate towards a global tracing solution

   Cons:
   - Different cardinality requirements -- one trace per request
   - Asynchronous covered experiences not possible
   - Lack of business-level success criteria -- the tracing tool would not be self-sufficient
   - More complex to implement and maintain

   Unknowns:
   - How would queries perform to aggregate data for a wide timeframe? For example, the 28 days of error budgets
   - How much would it cost?
   - How sampling would impact the aggregations?

2. Do Nothing
   Pros:
   - No implementation cost

   Cons:
   - Continue lacking end-to-end covered experience visibility and measurement
   - Harder to set meaningful SLOs
   - Miss opportunities for better capturing perceived user experience and testing coverage
