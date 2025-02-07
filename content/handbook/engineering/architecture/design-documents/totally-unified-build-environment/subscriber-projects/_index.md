---
title: "Totally Unified Build Environment - Subscriber Projects"
status: ongoing
creation-date: "2025-02-06"
authors: [ "@rmarshall" ]
coach: [ ]
approvers: [ "@deriamis", "@balasankarc", "@WarheadsSE", "@denisra" ]
owning-stage: "~devops::systems"
participating-stages: []
toc_hide: true
---

## Introduction

Framework gives subscriber project developers more time to focus on value
added features. It automatically and transparently manages build
environments and updates to runtimes. Workfow changes, such as when the
directly reponsible individual changes or labels change, are the only tasks
that require manual intervention after the initial set up process.

## How projects onboard to Framework

All subscriber project configuration lives in one repository. This design
simplifies management for Distribution as a single source of truth and
simulatenously allows subscriber project maintainers to manage their own
workflow. New Framework subscribers open a merge request that will:

- Identify the project.
- Identify the directly responsible individuals who act as the point of
  contact when required.
- Set the correct labels for issues Framework opens that follows the
  subscriber project's established workflow rules.
- Add subscriber project maintainers in `CODEOWNERS` to enable independent
  management of workflow configuration after the initial enrollment.

Project maintainers also open a second merge request in their own
repository. This request incorporates Framework shared scaffold
configuration into the continuous integration build jobs. This enables
transparent delivery of updated build environments to the subscriber project
and automatically opens issues to schedule and track update tasks with the
preferred workflow set in the enrollment merge request.

## Software build overview

Subscriber projects always build in the same environment Distribution and
Delivery use to ship GitLab. When an update happens in one of those
environments, Framework automatically adds additional build jobs in some
pipelines that use the newer version. These extra jobs are allowed to fail
and update issues automatically created by Framework.

The automation eliminates friction caused by Distribution's current role as
intermediary. Challenges discovered in the test build flow directly and
immediately to an issue. Subscriber projects manage their own workflow, so
product and engineering managers can schedule work related to updates rather
than react to it late in the release cycle. This minimizes disruption and
creates greater visibility for both engineers and across the organization.
