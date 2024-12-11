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

With the rewrite of the To-Dos dashboard into a Vue app, we discovered (and tbh, also created) some duplications and limitations in how the To-Dos dashboard works.
Let's clean that up!

#### Remove all code related to the Haml version

With the Vue version released to all users, we first have to delete all code of the Haml implementation. This will drop lots of duplicated helpers etc.
With all that out of the way, it will be much easier to make refactorings within the Vue implementation. Currently, they also share some helpers, which makes refactorings harder and more risky.

#### Remove all hardcoding of todo targets and types from the frontend code

Currently the Vue components duplicate the list of possible todo targets and types.
This was the most pragmatic way to get the new implementation of the ground, but we have to eventually remove all this hardcoding of things that should have only a SSOT on the backend.
Otherwise, adding new targets and types means lots of duplication.

#### Add another new todo type

At this point, I would do another "reality check", similar to how we added the SSH key expiry todos to pinpoint all the duplications.

By adding a new todo type, we can verify that no duplication on the frontend is required.

We could add the "comment in thread I participate in" notifications as todos, for example. This would already be a helpful new feature for our users. And it is one of the most common emails, so it would also be a good test for database growth.

It might also require some thought on the frontend how to best display such a "thread of todos".

Also, it will make us look into todos respecting **notification settings**.

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
