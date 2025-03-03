---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Notification system
status: proposed
creation-date: "2025-02-25"
authors: [ "@mksionek" ]
coaches: [ "@fabiopitino" ]
dris: [ "@jtucker_gl", "@samdbeckham" ]
owning-stage: "~group::personal productivity"
participating-stages: []
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< design-document-header >}}

<!--
Don't add a h1 headline. It'll be added automatically from the title front matter attribute.

For long pages, consider creating a table of contents.
-->

## Summary

Current notification system is based on emails, requiring user to move constantly between inbox and GitLab. At the same time we have system of to-dos, that partially overlap with notifications, but in general establish only a subset of those. To-dos are also not controlled by any user preferences. 

To improve user experience and create parity between to-dos and email notifications I propose creating notification system in GitLab itself, which will respect current notification settings for email notifications. 

## Motivation

Our goal is to create a system that allow users to receive information about activity in their groups and projects in GitLab itself, without need to go check their email inbox. Those notifications should be personalizable, it should be easy to filter and mark as done/read. We want to grow the usage of notifications (metric here?). 

Our internal motivation is to create a system that is easy to extend and loosly coupled with other parts of the codebase. We also want to create system with clear retention policies, allowing to have a mainainable database load. We also want to make sure that adding new notifications to the codebase is easy and feature teams can self-serve with it. 

### Goals

- Create a comprehensive experience for users, who will have one place to see everything they need to know to work 
- Improve MAU (Monthly Active Users) metric between current to-dos and new notification centre
- Refactor code to achieve higher cohesion and more extendable system

### Non-Goals

TBD

## Proposal

### Summary

We propose unifying our currently fragmented notification systems (email notifications and to-dos) into a single, cohesive notification center using an event-driven architecture. This will improve user experience, simplify code maintenance, and enable future extensibility.

### Proposed Solution

Create a unified notification center built on an event-driven architecture that:

- Uses our existing Event Store as the backbone for all notifications
- Establishes a single database model for all notification types
- Implements sensible retention policies (3-6 months by default)
- Allows users to save important notifications indefinitely
- Provides consistent API access for both internal and external integrations

#### Pros and Cons

##### Pros

1. Improved user experience:

- Single location for all notifications
- Consistent interface and behavior
- Greater control over notification preferences

1. Technical benefits:

- Decoupled architecture allows independent service development
- Centralized notification logic improves maintainability
- Event-driven design enables easy addition of new notification types
- Reduced code duplication and complexity

1. Future flexibility:

- Straightforward path to add new notification channels (web, mobile push, etc.)
- API-first approach enables third-party integrations
- Retention policies prevent database bloat

##### Cons

1. Migration complexity:

- Requires careful handling of existing notifications
- User settings need thoughtful transition
- Temporary increased system complexity during transition

1. System dependencies:

- Increased reliance on Event Store reliability
- Need to manage event processing performance
- Potential for more complex failure scenarios

1. Resource requirements:

- Significant engineering effort
- Careful testing required to ensure seamless transition

## Design and implementation details

### Database tables

First thing to create is the new _notifications_ database table. This table will store data about notifications - what kind of notification it is, what resource it's connected with, the state of it, information if it is saved by the user etc. 

```mermaid
erDiagram
    NOTIFICATION
    NOTIFICATION {
        bigint id
        bigint user_id
        bigint namespace_id
        bigint target_id
        smallint target_type
        bigint author_id
        smallint action
        smallint state
        timestamp without time zone created_at
        timestamp without time zone updated_at
        string commit_id
        smallint resolved_by_action
        bigint note_id,
        timestamp with time zone snoozed_until 
        boolean saved
    }
```

## Alternative Solutions

1. Enhance current systems independently

Pros:

- Less initial development effort
- Lower migration risk
- Can be implemented incrementally

Cons:

- Maintains fragmented user experience
- Doesn't solve code maintenance issues
- Limited future extensibility
- Duplicated effort for common features