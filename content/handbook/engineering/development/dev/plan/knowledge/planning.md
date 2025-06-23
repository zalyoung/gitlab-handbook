---
title: Plan:Knowledge Planning process
---

## Roles

<table>
<tr>
<th>Title</th>
<th>Responsibility</th>
</tr>
<tr>
<td>Product Manager</td>
<td>

* **Set high-level goals** for each milestone
* Coordinate customer escalations (e.g. highly requested features or bug fixes)
</td>
</tr>
<tr>
<td>Engineering Manager</td>
<td>

* **Coordinate priorities among different projects** (e.g. ask engineers to temporarily switch focus to accelerate certain deliverable)
* **Find engineering DRI's** for epics and help them to plan
* Coordinate escalations(security vulnerabilities, error budget, severe bugs, infradev issues, etc).
* Keep track and report milestone progress
* Housekeeping (moving issues between milestone, triage new issues, etc)
</td>
</tr>
<tr>
<td>Engineering DRI</td>
<td>

* **Manage individual epic from start to finish:**
    * Break them down into small deliverables
    * Coordinate with other involved engineers
    * Do necessary research if needed (or suggest doing a spike)
    * Assign priority labels and candidate milestones to indicate the execution plan
    * Communicate the execution plan to the rest of the team (typically via thread on the milestone planning issue)
    * Ask for help when needed
    * Adjust the plan when something changes and communicate it to the rest of the team
</td>
</tr>
</table>

## Prioritising backlog

We have [over a thousand issues in our backlog](https://gitlab.com/groups/gitlab-org/-/issues/?sort=created_date&state=opened&label_name%5B%5D=group%3A%3Aknowledge&first_page_size=100), and typically have [over 50 issues assigned to a single milestone.](https://gitlab.com/groups/gitlab-org/-/issues/?sort=created_date&state=closed&label_name%5B%5D=group%3A%3Aknowledge&milestone_title=17.9&first_page_size=100)

To help us prioritise issues in the backlog and within the milestone we use the following labels. **Everyone on the team can assign and change these labels.**

<table>
<tr>
<th>Label</th>
<th>

Meaning in %Backlog
</th>
<th>Meaning in the milestone</th>
</tr>
<tr>
<td>

~Deliverable
</td>
<td>

:x: not used
</td>
<td>

We're committed to delivering it:

* The issue has a high priority(see below)
* There are no significant unknowns
* There is enough capacity to work on it
</td>
</tr>
<tr>
<td>

~"Knowledge::P1"
</td>
<td>Highest priority, should be considered first when planning next milestones</td>
<td>

Highest priority, should be executed first. Often a ~Deliverable
</td>
</tr>
<tr>
<td>

~"Knowledge::P2"
</td>
<td>Second priority</td>
<td>

Should be picked up after all ~"Knowledge::P1" are already taken. Can sometimes be a ~Deliverable
</td>
</tr>
<tr>
<td>

~"Knowledge::P3"
</td>
<td>Third priority - we want to keep it on the radar, but likely won't prioritise in the next couple milestones</td>
<td>

We'll pick it up if we have time. Always a ~Stretch
</td>
</tr>
<tr>
<td>

`no priority label`
</td>
<td>Is not on our radar for milestone planning</td>
<td>

:x: not used
</td>
</tr>
<tr>
<td>

~Stretch
</td>
<td>

:x: not used
</td>
<td>

We plan to work on this issue, but it is:

* lower in priority than other items
* or has significant unknowns/dependencies

All issues that are not ~Deliverable 's, are assigned the ~Stretch label.
</td>
</tr>
</table>

## Process

Milestone plan coordination happens on the [planning issues](https://gitlab.com/gitlab-org/plan-stage/product/-/issues?sort=created_date&state=opened&label_name%5B%5D=group%3A%3Aknowledge&search=planning&first_page_size=100). Let's break it down on the [17.10 milestone example](https://gitlab.com/gitlab-org/plan-stage/product/-/issues/138). The process is iterative and requires a lot of back and forth between PM EM and Engineering DRI's.

### 1. PM sets high-level goal

Everything starts with [PM setting up high-level goals](https://gitlab.com/gitlab-org/plan-stage/product/-/issues/138#note_2329004921) for the milestone. Those can be:

* Large epics
* Individual small issues that don't fit into larger epics
* Other goals, like OKRs

### 2. Team drafts the milestone

Engineers draft the plan for individual epics or full categories usually via threads on the planning issue using GLQL [[1]](https://gitlab.com/gitlab-org/plan-stage/product/-/issues/138#note_2327984011), [[2]](https://gitlab.com/gitlab-org/plan-stage/product/-/issues/138#note_2357032202).

Example:

````markdown
```glql
display: table
fields: epic, title, labels("Knowledge::P*"), labels("Deliverable", "Stretch"), weight, assignees
query: group = "gitlab-org" and label = ("group::knowledge", "Category:Pages", "candidate::17.10")
```
````

We use candidate labels (ex: ~"candidate::17.10" ) and not actual milestones during the planning process to be able add tentatively add issues to the next milestone when we suspect they may slip from the current one.

### 3. EM and PM review the milestone draft

EM and PM review the proposed plan to make sure that:

* it aligns with product and engineering goals
* the plan is realistic
* dependencies are coordinated
* all metadata is applied properly and no issues are lost
* we the right mix of ~Deliverable vs ~Stretch items

When EM and PM are happy with the plan, they [prompt the team for another review](https://gitlab.com/gitlab-org/plan-stage/product/-/issues/138#note_2359960864) communicating any adjustments, especially when some engineers need to help with separate categories..

### 4. Team reviews milestone draft

A few days before milestone starts the team reviews the plan and makes final adjustments.

### 5. EM finalizes the milestone

On the last day of the previous milestone, EM moves all the issues from the previous milestone(ex: %"17.9") and candidate labels (ex: ~"candidate::17.10" ) to the actual new milestone (ex: %"17.10")

### 6. EM tracks progress of the milestone and reports it weekly

EM reports the milestone progress weekly in the weekly updates ([example](https://gitlab.com/gitlab-org/plan-stage/knowledge-group/-/wikis/Weekly-updates/2025#1710)).

### 7. EM starts the next milestone draft

Planning issues are created automatically. EM starts the milestone planning:

* Add candidate label to
    * everything in the current milestone that can slip (typically low priority issues in ~"workflow::ready for development")
    * any issues that need to be escalated (security issues, infradev, etc.)
* Collaborate with PM on setting-up high-level goals for the milestone
* Assign engineering DRI's for projects and prompt them to plan their work.

## Useful boards

<table>
<tr>
<th>Board</th>
<th>Description</th>
</tr>
<tr>
<td>

[Build board](https://gitlab.com/groups/gitlab-org/-/boards/5454834)
</td>
<td>

We use this board during milestone to track issues traveling from ~"workflow::ready for development" to ~"workflow::complete" .
</td>
</tr>
<tr>
<td>

[Prioritisation board](https://gitlab.com/groups/gitlab-org/-/boards/7660969)
</td>
<td>

We sort issues by priority within milestone and in the backlog. It's best to use this board within some context:

* Feature category ([example](https://gitlab.com/groups/gitlab-org/-/boards/7660969?label_name%5B%5D=group%3A%3Aknowledge&label_name%5B%5D=Category%3AWiki))
* Milestone ([example](https://gitlab.com/groups/gitlab-org/-/boards/7660969?label_name%5B%5D=group%3A%3Aknowledge&milestone_title=17.11)) or candidate milestone ([example](https://gitlab.com/groups/gitlab-org/-/boards/7660969?label_name%5B%5D=group%3A%3Aknowledge&label_name%5B%5D=candidate%3A%3A17.11))
* Or both
</td>
</tr>
<tr>
<td>

[Next Up to milestone transition](https://gitlab.com/groups/gitlab-org/-/boards/7819112?label_name%5B%5D=group%3A%3Aknowledge)
</td>
<td>

This board is convenient to use when planning for multiple milestones. [Example](https://gitlab.com/groups/gitlab-org/-/boards/7819112?label_name%5B%5D=group%3A%3Aknowledge&label_name%5B%5D=Category%3AWiki)
</td>
</tr>
</table>
