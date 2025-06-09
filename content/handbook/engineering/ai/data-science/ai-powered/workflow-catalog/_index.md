---
title: Workflow Catalog Group
description: "The Workflow Catalog group is focused on developing Workflow Catalog, a catalog of AI Agents, tools, and workflows that can be created, curated, and shared across organizations, groups, and projects."
---

## Vision

The Workflow Catalog group is focused on developing Workflow Catalog, a catalog of AI Agents, tools, and workflows that can be created, curated, and shared across organizations, groups, and projects.

### Team members

**Engineering Manager & Engineers**

{{< team-by-manager-slug "sam-beckham" >}}

## How to reach us

Depending on the context here are the most appropriate ways to reach out to the Workflow Catalog group:

* Slack Channel: `#g_workflow_catalog`
* GitLab group `@gitlab-org/ai-powered/workflow-catalog/engineering` (just engineers)

## How we work

We're just getting started and will be defining how we work as we settle in to the new team.
Here are some links to get us started:

* [Root Epic](https://gitlab.com/groups/gitlab-org/-/epics/11111): For grouping all the work and setting out a roadmap
* [Issue board](https://gitlab.com/groups/gitlab-org/-/boards/3871464): For all in-flight issues
* [Team tasks](https://gitlab.com/gitlab-org/ai-powered/workflow-catalog/team-tasks/-/issues): For all non-product related team issues
* [Async updates](https://gitlab.com/gitlab-org/ai-powered/workflow-catalog/team-tasks/-/issues/?label_name%5B%5D=async%20update)

### Frontend-Backend Collaboration

We aim to foster high levels of collaboration between frontend and backend engineers to ensure
development velocity and code quality.

* **Schema-first development**: Before implementation begins, frontend and backend engineers collaborate
  to design a GraphQL API schema based on UI requirements, user experience needs, and performance considerations.
* **Parallel development processes**: Once the schema is agreed upon, the frontend can proceed
  using mock data, mock endpoints, or API stubs that match the agreed schema. The backend can
  focus on implementing the data model, business logic, and actual API schema.
* **Maintaining alignment**: We value great communication. When requirements or schema need to change, we communicate
  early through the relevant GitLab issue or in [`#g_workflow_catalog`](https://gitlab.enterprise.slack.com/archives/C08T5J1KXKQ)
  so our frontend or backend counterparts stay informed of all changes and can provide feedback early to avoid late-stage blockers.

### Our tech stack

* GraphQL [backend](https://docs.gitlab.com/development/api_graphql_styleguide/) and
  [frontend](https://docs.gitlab.com/development/fe_guide/graphql/). All new schema items must be
  [marked experimental](https://docs.gitlab.com/development/api_graphql_styleguide/#mark-schema-items-as-experiments)
  to let us making breaking changes when we need.
* GraphQL [subscriptions](https://docs.gitlab.com/development/fe_guide/graphql/#subscriptions) rather than polling.

## Team meetings

### Workflow Catalog: Group meeting

* **Time**: Every Tuesday at 05:30 UTC and 10:00 UTC. It's held twice in one day to allow APAC and EMEA to attend.
* **Purpose**: This meeting serves as a general sync meeting to bring up any current issues and blockers.
* **Agenda**: [Google Doc (internal only)](https://docs.google.com/document/d/19zrzqN37ZVwwEJ9iYhy4QBsUzVN0Hd1j1yn8J0v4dqE)
* **Recordings**: [Google Drive (internal only)](https://drive.google.com/drive/folders/1I9s96jg9knqOwDLabhn9100H-MsvG2ne)

## Communication

The Workflow Catalog Team communicates based on the following guidelines:

1. Always prefer async communication over sync meetings.
1. Don't shy away from arranging a [sync call](/handbook/communication/#video-calls) when async is proving inefficient, however always record it to share with team members.
1. By default communicate in the open.
1. Prefer public channels (`#g_workflow_catalog`) over private message for work-related Slack messaging
