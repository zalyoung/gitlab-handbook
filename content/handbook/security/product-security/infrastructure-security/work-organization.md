---
title: "Infrastructure Security Work Organization"
description: "This page describes how the Infrastructure Security team organizes and tracks their work internally."
---

## Scope

This document describes the work organization of projects and maintenance (other words for this type could be chore or bau or klo) type of work in the InfraSec team. It will also include a generic type for interrupts that can be used for ad-hoc requests coming from other teams, these should mostly be directed through the intake process that is currently being defined though.

## Issue Structure

Projects should always have an associated Epic.
Epics can have nested epics, e.g. for milestones or to break down the main epic into separate sections.
All day to day work should be in issues or tasks, excluding team collaboration like providing feedback, pairing on work, reviewing MRs or other artifacts, etc.
Team collaboration should also always have a high priority while still considering our [manager of one value](/handbook/leadership/#managers-of-one) to improve overall team performance and engagement.
We could also think about having epics (or instead labels) to group maintenance work at a specific scope (e.g. per tool) to be able to generate metrics/insights into what tool is generating the most work for us.

### Fields

1. Start Date: required for all planned work
1. Due Date: required for all planned work
1. Health Status: required for all ongoing work

    Issues should transition to `Needs Attention` and `At Risk` based on our confidence at making the due date.

    Issues move to `Needs Attention` when there's a lowered confidence of meeting the due date due to moderate delays or complications.
    An example for this could be that work we expected to take 5 days is only 20% complete after 3 days.

    Issues move to `At Risk` when confidence in making the due date is very low due to critical blockers or severe underestimation of complexity.
    An example for this could be that an MR is blocked for an extended amount of time with necessary follow-up work being estimated to take more time than the due date allows.

    In both cases we should add an explanation to the issue that explains the reasoning behind the `Health Status`.

### Labels

#### Work Type

1. InfraSecWork::project
1. InfraSecWork::maintenance
1. InfraSecWork::interrupt (Ad-hoc work that is not plannable)
1. InfraSecWork::dependency (Dependencies on stakeholders outside InfraSec)
1. InfraSecWork::learning (Internal team development)

#### Work Status

1. InfraSecStatus::backlog
1. InfraSecStatus::planned # Refined and ready to be picked up
1. InfraSecStatus::ongoing
1. InfraSecStatus::blocked # Waiting on unexpected dependencies
1. (Closed is covered through closing the issue - all other work status labels should be removed then)

### Templates

Each type of work should have a template that contains the required fields we need to populate.

#### Project

```markdown
---
name: Project
about: New security initiative or feature
---
/set_parent <epic>

## Project Context/Description
<!-- Clear description of the security project and business context -->

## Definition of Done/Requirements
- [ ] Success criterion 1
- [ ] Success criterion 2
- [ ] Documentation updated

## Alignment to Business Goals
<!-- How this project supports organizational security objectives -->

/label ~"InfraSecWork::project" ~"InfraSecStatus::backlog" ~"Infrastructure Security Team" ~“Department::Product Security”
```

#### Maintenance

These should be mostly self-explanatory without hard requirements on the content.
Each system should have a maintenance epic for easier analytics of their respective maintenance efforts.

```markdown
---
name: Maintenance
about: Day to day operational tasks of the team
---
/set_parent <epic>
/label ~"InfraSecWork::maintenance" ~"InfraSecStatus::backlog" ~"Infrastructure Security Team" ~“Department::Product Security”
```

#### Interrupt

```markdown
---
name: Interrupt
about: Urgent non-planned work
---
## Context
<!-- Brief description and background -->

## Definition of Done/Requirements
- [ ] Success criterion 1
- [ ] Success criterion 2

## Urgency Reasoning
<!-- Why this requires immediate attention and explanation of business impact if it wouldn't be done immediately -->
/due <date>

/label ~"InfraSecWork::interrupt" ~"InfraSecStatus::ongoing" ~"Infrastructure Security Team" ~“Department::Product Security”
```

#### Dependency

These should be mostly self-explanatory given the name of the issue and the context of their parent/related issue which is required.

```markdown
---
name: Dependency
about: Dependency on a stakeholder outside of InfraSec
---
/set_parent <epic>
<!-- and / or -->
/relate <issue>

/label ~"InfraSecWork::dependency" ~"InfraSecStatus::backlog"  ~"Infrastructure Security Team" ~“Department::Product Security”
```

#### Learning

Since this is just for transparency reasons there are no hard requirements on content.

```markdown
---
name: Learning
about: Internal learning that is done on the team
---
/label ~"InfraSecWork::learning" ~"InfraSecStatus::backlog" ~"Infrastructure Security Team" ~“Department::Product Security”
```

### Dashboard

The dashboard (to be created and linked here) should contain the following sections:

1. Current projects epics that are prioritized
1. Needs attention section (e.g. blocked, overdue, health status yellow or red, interrupts without assignee)
1. Current ongoing work
1. Recently completed work (1 month look back)
1. Open stakeholder dependencies
1. Learning related tasks

This dashboard should act as the central view for the team and outside stakeholders to understand both currently ongoing work and its status as well as prioritized work that is planned.

### Automation Opportunities

This section is not fully refined, most of these opportunities will have to be planned to consider edge cases and fields that they need to consider during the decision making algorithm.

#### Triage Bot

1. Update Triage Bot to follow the agreed upon labelling.

#### Issue Hygiene

1. Bot to ping assignee to provide updates on a weekly cadence (like https://gitlab.com/service-epic-status-automation)
1. Flag issues not updated in X days as stale
1. Validate required fields are populated at each stage (e.g. Due Date is set)
1. Auto-link related issues based on keywords and patterns

#### Status Management

1. Mark issues as At Risk when they exceed due dates we have information that the due date may not be achievable
1. Auto-transition issues from planned to ongoing when assigned
1. Remove status labels when issues are closed
1. Update health status based on time since last update

#### Dependency Tracking

1. Weekly automated comments on stale dependency issues
1. Mark dependencies as At Risk when they haven't been updated in X days
