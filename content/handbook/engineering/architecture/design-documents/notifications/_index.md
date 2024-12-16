---
title: Better notifications
status: proposed
creation-date: "2024-12-12"
authors: [ "@thutterer" ]
coaches: [ "@jessieay" ]
dris: [ "@jtucker_gl", "@samdbeckham" ]
owning-stage: "~devops::<stage>"
participating-stages: []
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< design-document-header >}}


## Summary

Currently, notifications are managed in two distinct ways:

- [To-Dos](https://gitlab.com/dashboard/todos) are defined and raised from the `TodoService`.
-  Email notifications are defined and raised from `Notify` via `NotificationService`.

Since these two services are not connected in any way, they must call both the `NotificationService` and the `TodoService` to raise notifications in both channels.
As we seek to create parity between these two channels, this disconnect is going to become increasingly costly to maintain.

Also we are thinking of adding to the two existing ways of receiving notification. Think of personal Slack notifications as a third "channel", for example.

Before we do this, we should make the way we trigger notifications more "framework-y", so that developers don't have to think of _n_ (number of channels) places to add a call to a service, but ideally only 1.
Our framework then would take care of the details, and send email, create todo, push to Slack etc.

## Motivation

We want to enable users to do their work without relying on email notifications. All relevant events should also be visible in the web UI.
Technically speaking, we want to create more `todos` in the database and create parity with email notifications, so users can be sure they got all the information in the UI that they would also find in their emails.

Today, you have to implement both these things seperately, so it is error prone and easy to forget or create inconsistencies.

So we want to bring emails and todos closer together, eventually wrapping them into one **reuasable system**, that makes it both easier for us (~"group::personal productivity") and all contributors to maintain parity.

With such a system in place, adding more channels, like personal Slack notifications, will become easier as well.

### Goals

We have defined the following success criteria:

1. Defining a new notification does not require deep modifications to existing notification infrastructure.
2. Newly defined notifications should respect user preferences on desired notification channel.
3. GitLab product teams can define and maintain notifications for their product areas with minimal support from grouppersonal productivity.
4. grouppersonal productivity can introduce additional notification channels (e.g. native push, Slack, Discord, etc) without requiring an update to every single notification definition.

It's important to note that these are the **longterm goals** and will require iteration, and some might be only partly achived. See iteration plan below.

### Non-Goals

We haven't defined any hard non-goals yet, but some of the goals above might be cut in scope as this document evolves.

## Proposal

Before we can make bigger architectural changes towards our longterm goal of having such a **notification framework based on an event system**, there are several iterations on the current system we should to do.
With these duplications and test gaps out of the way, it will be much easier to join email and todo services into one, add new channels like Slack, etc.

## Design and implementation details

### Preparation phase

With the rewrite of the To-Dos dashboard into a Vue app, we discovered (and created) some duplication:

- The Haml version of the To-Dos dashboard is still in the codebase. It has its own implementation of filter logic, todo body text, etc.
- The new Vue version shares some backend code with the Haml version, but not all. It is currently hard to tell where to make a change and what its effect would be. This makes it harder to maintain.
- The new Vue version currently has all todo action and target types hardcoded in the frontend code, multiple times. We should refactor that to a minimum to improve code quality.

Let's iterate and clean this up!

1. https://gitlab.com/gitlab-org/gitlab/-/issues/509080
2. https://gitlab.com/gitlab-org/gitlab/-/issues/509083

Adding a new todo target or action type will be much simpler after this.

🏁 **Adding a new type now should only require adding it to a single place in the backend.** (likely in `TodoPresenter`).

We should verify reaching this goal, by adding a new todo to the system, possibly https://gitlab.com/gitlab-org/gitlab/-/issues/507338.

### Make todos respect notification settings

Today, todos cannot be turned off and they don't respect the notification settings per project/group.

We have to spot and document the places in the codebase where each todo is created, and wrap it in a "if user wants this" check.

Either, by moving the todo service invocation into an existing email notification service call, or by creating a new service that does both.

### Shared base service

Either way, at this stage we can develop a shared base service class that all our "email+todo" services can inherit from.

This base service class should handle things like notification preferences etc.

It will also make adding a new channel like Slack notifications possible. Ideally, only this shared base service has to be extended, and all its consumers can stay unchanged.

Making sure all notification services have the same interface is also a prerequesite to later hook them into an event system.

### Event system

Eventually we want to integrate into a global [Product event platform](https://gitlab.com/groups/gitlab-org/-/epics/14860).

Details TBD as it develops.
