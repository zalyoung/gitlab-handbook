---
title: "Milestone Planning"
description: "Learn how the GitLab Application Security team does Milestone Planning"
---

## Milestone Planning

The Application Security team plans its work on a cadence based around [GitLab Product Milestones](https://gitlab.com/groups/gitlab-com/-/milestones). Our goal is to be intentional about the work we do, while also providing insights into our capacity, velocity, and current projects.

All of our planning is done using [GLQL](https://docs.gitlab.com/user/glql/) queries.

This handbook page describes the planning [responsibilities](#milestone-planning-responsibilities) and [process](#milestone-planning-process) that we use to determine what work will be completed for each Milestone.

## Milestone Planning responsibilities

Application Security team members are responsible for:

- Evaluating and communicating their capacity for the Milestone (based on PTO, rotation assignments, and other factors).
- Adding potential work items to the [Parking Lot](#parking-lot-section) and being involved in discussions around what work we should pull into the Milestone.
- Collaborating with Application Security managers to finalize the set of work being committed to for the Milestone.
- Assigning the right [labels to issues](#issues-and-labels).

Application Security managers are responsible for:

- Creating, updating, and maintaining the Milestone Planning issue.
- Collaborating with Application Security team members to discuss potential work and provide support whenever needed for work refinement or clarifications on work requirements.
- Coordinating the finalization of the Milestone Planning issue.

### Capacity expectations

On average it's expected that ICs have 3 to 4 issues that are estimated to be classified as `AppSecWeight::Large` from our [Effort Classification table](./metrics/capacity.md#effort-classification) depending on the rotations and planned PTO. Team members may have more issues if they are rated as less effort, or less issues if rated as higher effort.

## Issues and Labels

Application Security team members are responsible for keeping issues and labels up-to-date over the course of the Milestone.

Any issue being worked on by an Application Security team member must include:

- The `Security::Division`, `Department::Product Security` and `Application Security Team` label
- The appropriate [`AppSecWorkflow::` label](#workflow-labels)
- The appropriate Milestone
- The appropriate [`AppSecPriority::` labels](#priority-labels)

### Workflow Labels

| Label | Purpose |
| --- | --- |
| `AppSecWorkflow::planned` | Indicates that work has been triaged, scoped, and is ready to be worked on in the assigned milestone. This is usually present before the milestone has started or when the work hasn't started within the milestone |
| `AppSecWorkflow::in-progress` | Indicates the issue is actively being worked on, or the rotation is in progress |
| `AppSecWorkflow::complete` | Indicates the work is done, or the rotation has finished |

### Priority Labels

The priority classification labels helps ICs understand what is the priority for leadership.

The label assignment can be done by leadership (AppSec or at higher levels), or by the team members themselves. When team members are not sure on a particular priority, they can consult leadership for confirmation.

| Label | Description |
| ----- | ----------- |
| AppSecPriority::1 | Top priority work that must be completed for the end of the planned milestone. |
| AppSecPriority::2 | Work priority that is important and is prioritized as soon as all `AppSecPriority::1` work is completed. `AppSecPriority::2` work will become `AppSecPriority::1` on the next milestone. |
| AppSecPriority::3 | Work priority that is less important and is prioritized as soon as all `AppSecPriority::2` work is completed. `AppSecPriority::3` will be evaluated during Milestones Planning Sessions and may become `AppSecPriority::2` for the next milestone. |

### Unplanned work

Sometimes high-priority and/or urgent work comes up after a milestone starts. When an unplanned issue is added after the milestone began:

- Document why the work needs to be prioritized in the issue
- Apply the `Unplanned` label
- If the unplanned work is large enough to displace other planned issues, inform the applicable stakeholders so they are aware that their issue is being delayed

### SIRT/PSIRT incidents impact on planned work

Is it important to know when an issue has been delayed due to a SIRT/PSIRT incident. Follow our guidelines in the [Capacity Metrics page](./metrics/capacity.md#work-impacted-by-sirt-incidents) to know which label to add in those cases.

### Providing Issues Status & Health Updates

DRIs are responsible for providing weekly updates at the end of the week on their assigned topics using the following format.

```md
 **What's happened since last update:**

 * \[Bullet points of progress\]

 **What's next:**

 * \[Bullet points of upcoming work\]

 **Blockers:**

 * \[Any blockers or dependencies\]

 **Overall Status/Confidence:**

 * :green_circle: On Track / :yellow_circle: Needs Attention / :red_circle: At Risk
 * \[Brief explanation of status\]
```

These reports provide critical visibility into progress, plans, and potential issues, allowing leadership to make informed decisions and offer timely support when needed.

At the same time the [issue health status feature](https://docs.gitlab.com/user/project/issues/managing_issues/#health-status) must be updated to match with the `Overall Status/Confidence` update.

Updating the issue milestone is required:

- On a weekly basis, at the end of the week.
- Whenever the DRI knows they won't be able to finish it for the end of the milestone

## Milestone Planning Process

For each Milestone, a [Milestone Planning issue](https://gitlab.com/gitlab-com/gl-security/product-security/appsec/appsec-team/-/issues/?label_name%5B%5D=Milestone%20Planning) is created in the Application Security team repository. The purpose of this issue is to:

- Identify potential work to perform: rotations, KR work, critical project work, and other efforts
- Identify refinement gaps and address them
- Determine what work we're committing to for the upcoming Milestone
- Set and communicate priority for the work we've decided to take on

This issue is the single source of truth for all planning related discussions and decisions related to the upcoming Milestone.

### Manager(s)

#### Before and at the beginning of the milestone

1. On the first of the month, an Application Security manager will create an issue from [the Milestone Planning issue template](https://gitlab.com/gitlab-com/gl-security/product-security/appsec/appsec-team/-/issues/new?issuable_template=milestone_planning).
1. An Application Security manager will be responsible for completing the checklist items in the Planning Checklist section of the Milestone Planning issue.
1. An Application Security manager will have an overview on the work planned at the beginning of the issue.
1. An Application Security manager may plan for issues for a given milestone.

#### At the end of the milestone

1. An Application Security manager will check for any remaining issues that are not completed and not moved to the next milestone and discuss with the team member on the next steps.
1. An Application Security manager will apply the "AppSecWorkflow::complete" label and close the issue.

### Team Members

#### Before and at the beginning of the milestone

1. Application Security team members will add any work being carried over from the previous Milestone:
    1. Change the milestone to the next milestone.
    1. They will apply the "missed:X.Y" label, X.Y being the current milestone, or the previous milestone if the next milestone started.
1. The Application Security team will pick any potential work items from the [Parking Lot section](#park)
1. The Application Security team will work together to add new issues into the milestone planning issue.
    1. Each item being added must be refined before it can be formally committed to
    1. The team member likely to take on the work should review and agree with the Weight, if it wasn't them who refined the issue
    1. Once we have refined and committed to the work, the relevant issue needs to be updated with the Milestone and Assignee(s)
1. The Milestone Planning issue should be finalized at least 3 business days before the Milestone Start Date
    1. The Application Security Manager will use threads in the Milestone Planning issue to work with each Application Security team member to finalize their workload
    1. Once finalized, the Milestone Planning issue should be closed

#### At the end of the milestone

#### How are issues displayed in the milestone planning issue?

The GLQL query checks for:

1. One of the following labels: "Application Security Team", "AppSecPriority::1", "AppSecPriority::2" or "AppSecPriority::3".
2. The milestone is appropriately set 

If both conditions are satisfied, then it's displayed.

If you want to have an issue you're working on displayed, make sure that you use at least the ~"Application Security Team" label.

### Rotations

[HackerOne](/handbook/security/product-security/application-security/runbooks/hackerone-process/) and [Triage](/handbook/security/product-security/application-security/runbooks/triage-rotation/) rotation issues are created through the [rotation management tool](https://gitlab.com/gitlab-com/gl-security/product-security/appsec/tooling/rotation-management/) and automatically assigned to team members.

If you need to swap one rotation, read our [Rotation tool's FAQ](https://gitlab.com/gitlab-com/gl-security/product-security/appsec/tooling/rotation-management/-/tree/main?ref_type=heads#faq) on how to do it.

We can visualize all rotations in [this rotation table](https://gitlab.com/gitlab-com/gl-security/product-security/appsec/tooling/rotation-management/-/blob/main/rotations.md?ref_type=heads).

## Milestone Planning Refinement Guidelines

- Is the problem clearly defined or is more followup/data needed?
- Is the scope too large to be completed within the milestone? Does the issue need to be broken down into smaller ones or promoted to an epic instead?
- For projects and net-new initiatives, is the scope and Definition of Done clear and measurable? Is it clear what's expected?
- Does it have at least one DRI assigned and are they aware?
- Are there dependencies? If so, document them.
- Are there other stakeholders and are they looped in and aware?
- Is the correct [`AppSecWorkType::` label](/handbook/security/product-security/application-security/metrics/capacity/#type-of-work-classification) set?
- Is the [`AppSecWeight::` label](/handbook/security/product-security/application-security/metrics/capacity/#effort-classification) set?
- Does it have the `Security::Division`, `Department::Product Security` and `Application Security Team` labels?
- Across the whole milestone, is the total operational + project weight achievable?

When issue is fully refined, please set the `AppSecWorkflow:planned` label, indicating it's ready to be worked on in the assigned milestone.

### Parking Lot section

This [section of the milestone planning issue](https://gitlab.com/gitlab-com/gl-security/product-security/appsec/appsec-team/-/blob/master/.gitlab/issue_templates/milestone_planning.md#issue-parking-lot) displays all the issues that:

- Have been missed from the previous milestone
- Issues that have been assigned the ["AppSec Backlog" milestone](#backlog)

#### Backlog

Issues that:

- Have unfinished work
- Are ideas from team members but not yet prioritized
- Are not planned in any milestone

Should have the milestone set to `AppSec Backlog`.

### Missed milestones

Work planned for a milestone may not be fully finished due to time constraints or planned work being too ambitious. When this happens, attach the `missed::X.Y` label.
