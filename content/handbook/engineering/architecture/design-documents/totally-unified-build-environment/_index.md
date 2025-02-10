---
title: "Totally Unified Build Environment"
status: ongoing
creation-date: "2025-02-06"
authors: [ "@rmarshall" ]
coach: [ ]
approvers: [ "@deriamis", "@balasankarc", "@WarheadsSE", "@denisra" ]
owning-stage: "~devops::systems"
participating-stages: []
toc_hide: true
---

{{< design-document-header >}}

## Introduction

The Totally Unified Build Environment (`T.U.B.E.`) aims to improve reliability
and scalability when foundational components required updates. It improves
confidence in correctness and eliminates duplicate work to create higher
performance teams. The target workload reduction enables Build to support other
company-wide priorities more quickly and gives other teams more time to focus on
tasks that add value to GitLab.

## Current state of software builds

As GitLab grew, multiple build environments proliferated across projects. Some
GitLab components build with a shared environment while others use a completely
unique container image. None of these build with the same environment that
builds packages and container images for SaaS and self-managed customers.

The Build team owns dependency update certification. One update may require
changes in a dozen or more repositories. Each of these projects may or may not
have a directly responsible individual to handle build failures. Some projects
lack ownership by any one team and are effectively abandoned until surfaced by a
catastrophic build failure. Build co-ordinates effort across multiple teams and,
in cases where there is no ownership, takes ownership to ensure success.

## Motivation for change

The large amount of work required for each update makes the current process
cumbersome, slow, and prone to error. Multiple teams perform redundant tasks,
sometimes well outside their expertise, and much of this work does not directly
benefit the shipped product.

The duplication also wastes operational expenditure. Construction of each unique
build environment burns pipeline minutes and the outputs consume storage space.
Divergence between the development environment and the package build environment
masks issues until high priority incidents are declared due to delivery pipeline
failures at release time. Extended security backports elevate the diagnostic
difficulty for such failures as they often surface subtle differences in the
data lifecycles for build environments and deleted build environment
configuration.

For each outcome below, [the improvements are based on estimates drawn from both quantified sources in the GitLab application and the typical time spent on previous runtime updates](metrics-calculations.md).

### Financial

The Totally Unified Build Environment eliminates at least fifty percent of
runtime maintenance costs between labor reduction and pipeline efficiency. Patch
and major version releases consume roughly twenty percent of the Build team's
load, therefore the amount of time returned would be roughly equivalent to the
addition of one Build team member over the course of a year. Higher confidence
in those updates and less time lost to context switches provide additional
reductions and improvements that are more difficult to quantify.

Build expects reduced infrastructure costs over time. Fewer build containers
required translates to reduced storage cost and less runner time spent to
generate them. Due to maintenance policy, these reductions will be fully
realized four releases after the Totally Unified Build Environment deploys into
production.

- Reduces storage cost through elimination of duplicate build containers.
- Reduces pipeline minutes burned on duplicate environment generation.
- Reduces labor cost required to maintain version updates across multiple
  projects and product releases.

### Efficiency / Velocity

The Totally Unified Build Environment reduces the number of engineers required
to start and validate updates and wastes no time on builds that do not reflect
reality in the eventual production release environment. The current process
requires nearly a dozen or more engineers spread across multiple teams. The
Totally Unified Build Environment reduces requirement to zero engineers and for
only as long as it takes the automation to generate a new build container.

- Removes build environment maintenance tasks from feature engineers and
  frees them to focus on value added work.
- Decreases mean time to discovery with immediate build container
  deployments when automated updates detect a new version.
- Immediate build container availability increases the time available to
  project maintainers and allows them to proactively schedule work rather
  than react to last minute requests.
- Major and patch revision updates become concurrent by default without
  engineer intervention or additional plans.
- Frees Build engineers from manual paperwork tasks and allows them
  to focus more strongly on build correctness and speed.

### Confidence

The Totally Unified Build Environment improves the signal-to-noise ratio and
decreases friction that distracts from the validation process. Feature engineers
and product managers can plan for change rather than react to it.

- Eliminates manual work to track and audit component updates.
- Establishes a clear process to identify directly responsible individuals
  and proactively warn when project ownership is ambiguous.
- Eliminates an entire class of errors caused by divergent build
  environments that often appear at the very end of the release process.
- Amplifies confidence that component updates are well tested and ready to
  merge across the entire GitLab organization.

## Use cases

The Totally Unified Build Environment streamlines work for feature engineers,
Build engineers, product managers, and engineering managers.

### Feature Engineers

Feature engineers onboard to the Totally Unified Build Environment with two
commits. One attaches their build pipelines to the Totally Unified Build
Environment and the other configures their project subscription and workflow.
From that point, they have no further build environment maintenance tasks.

All relevant build environments appear automatically in subscriber project
pipelines. Thus, feature engineers receive these updates almost immediately
after publication upstream. The early warning gives feature teams more time
to plan work and the issue they receive follows their own established
processes as set in their subscriber configuration.

### Managers

The Totally Unified Build Environment respects each team's workflow and
generates issues that align with established process. This means update issues
open automatically with correct labels that increase discoverability and
attaches them to an epic for broader visibility to other interested parties.

This seamless workflow combined with automated early detection of updates
allows managers to plan their team's work rather than react to it late in a
release cycle in competition with other priorities.

For larger changes, such as the Ruby 3 upgrade, the Totally Unified Build
Environment eliminates the pre-upgrade working group tasks. The Totally Unified
Build Environment can validate multiple major and minor updates in parallel by
default without the need to intervene in multiple team projects. This
parallelism also prevents conflicts between major version upgrade validation and
the need to quickly release a security update with a less risky minor patch
release.

### Build team

The Build team manages build environment generation. Although automated, if
the pipeline fails then build engineers must diagnose and correct
the build failure. Failed builds at this stage do not impact feature
engineers or daily pipelines.

Build engineers validate the final package and container build for all
components and certifies when a build environment is ready to promote and
close the component epic.

## Requirements

### Functional

- Updates automatically show up in subscriber pipelines with no manual
  intervention required by an engineer.
- Provide automatic epic and issue creation aligned to each subscriber
  project's pre-defined workflows.
- Allow simultaneous validation of patch revisions and major updates.

### General

- Provide a single, comprehensive source of truth for build environments in
  all projects across GitLab.
- Eliminate requirement for subscriber project developers to maintain and
  curate their build environment.
- Reduce operating expenditure through reduction of storage requirements and
  duplicate effort in continuous integration pipeline jobs.
- Establish clear owners for all projects outside the Build team remit.

## Key metrics

- Container images required to build GitLab.
  - Total number of build environment containers reduced by 50%.
  - Total bytes retained in the build container registry reduced by 30%.
- Reduce Distribution time spent on version management by 80%.
- Reduce time spent by non-Distribution engineers on build environment
  maintenance to zero.
- Normal operation delivers updated build environments to GitLab teams for
  validation automatically within 12 hours of upstream publication.
- Reduce normal operations engineer time spent on build environment
  generation to zero.
- Overall increased developer happiness.
  - Do updates feel timely?
  - Do updates increase feature delivery time?
  - Does time spent on update validation block timely feature delivery?
  - Do updates fit within the scheduled workflow?

## Alternatives considered

The initial proposal included the concept of two build streams,
`build.next` and `build.current`. The `build.current` stream replaced the
containers from `gitlab-build-images` and consolidated all projects to build
with the same environment used to release products to customers. The
`build.next` environment allowed update validation that did not block
projects from builds against the current release environment.

The alternative presented to the initial proposal applied `Renovate` to open merge
requests against the `gitlab-build-images` repository. Those merge requests
would be reviewed and then merged for consumption by project pipelines.

[The initial proposal](https://gitlab.com/gitlab-org/distribution/team-tasks/-/issues/1109):

- Employed float tags that prevented clear audit for consumer projects.
- Did not completely address the possibility where an urgent patch release
  may need tested at the same time as a major upgrade blocked due to many
  breaking changes.
- Updates still required manual intervention to deliver them to projects.

[The Alternative](https://gitlab.com/groups/gitlab-org/-/epics/7853#note_1082598526):

- Failed to eliminate the gap between how projects validate their builds for
  feature releases versus what ships to customers.
- Shifted build validation for current release right into the Build
  workflow and delayed feedback.
- Updates still required manual intervention to deliver them to projects.

Due to these flaws, the approach for the two proposals are now blended.

This design:

- Eliminates the need for any engineer to enable update validation under
  normal operation.
- Shifts build failure detection back to project teams and decreases the
  mean time to resolution.
- Reduces workload on Build due to unexpected build failures if
  changes would cause build failures in the shipped build environment.
- Reduces the total number of containers to maintain, track, and retain
  across multiple container registries.

## Timeline

- Draft high level design documents. (3 weeks)
  - Impact proposal.
  - High level process flow.
- High level design document review. (1.5 weeks)
- Create subcomponent design documents. (3 weeks)
- Subcomponent design document review. (1.5 weeks)
- Create implementation tasks. (1 week)
- Project kick-off review. (1 week)
- Plan task order and identify opportunities for parallelization. (1 week)
- Implement subcomponents. (4 weeks, in parallel)
- Onboard first project after MVC complete. (1 week)
- Process feedback after first project onboarded. (1 week)
- Address MVC feedback. (2 weeks)
- Create full onboard plan. (1 week)
- Onboard all projects. (TBD, requires cross-team collaboration time management)

## Architectural Decision Records

- [Use Architecture Decision Records](decisions/00001-use-architecture-decision-records.md)
- [Subscriber project build failures assign to all points of contact](decisions/00002-subscriber-project-build-failures-assign-to-all-points-of-contact-by-default.md)
