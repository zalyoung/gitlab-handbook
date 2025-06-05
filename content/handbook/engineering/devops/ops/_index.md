---
title: Ops Sub-department
description: >-
  The Ops Sub-department is composed of development teams working on Verify,
  Package and Deploy features of GitLab DevOps Platform.
---

The Ops Sub-department is composed of development teams working on Verify, Package, and Deploy features of GitLab DevOps Platform.

## Teams and Handbook Pages

The following teams comprise the Ops sub-department:

- Verify stage - [handbook](/handbook/engineering/devops/ops/verify/)
  - Pipeline Execution - [handbook](/handbook/engineering/devops/ops/verify/pipeline-execution/), [jtbd](/handbook/engineering/devops/ops/verify/pipeline-execution/jtbd/)
  - Pipeline Authoring - [handbook](/handbook/engineering/devops/ops/verify/pipeline-authoring/), [jtbd](/handbook/engineering/devops/ops/verify/pipeline-authoring/jtbd/)
  - Runner - [handbook](/handbook/engineering/devops/ops/verify/runner/), [jtbd](/handbook/engineering/devops/ops/verify/runner/jtbd/)
  - CI Platform - [handbook](/handbook/engineering/devops/ops/verify/ci-platform/)
- Package stage - [handbook](/handbook/engineering/devops/ops/package/), [jtbd](/handbook/engineering/devops/ops/package/jtbd/)
  - Container Registry - [handbook](/handbook/engineering/devops/ops/package/)
  - Package Registry - [handbook](/handbook/engineering/devops/ops/package/)
- Deploy stage
  - Environments - [handbook](/handbook/engineering/devops/ops/deploy/environments/), jtbd

## Product Direction

Teams in the Ops Sub-Department map to several Product Sections.  Product direction can be found on the following direction pages:

- [CI Section Direction](https://about.gitlab.com/direction/ci/)
- [CD Section Direction](https://about.gitlab.com/direction/delivery/)

## Slack channels

- [#ci-section](https://gitlab.slack.com/archives/C05B0MER7LM) - CI Section discussions spanning the Verify, Package and Monitor Stages
- [#cd-section](https://gitlab.slack.com/archives/C05BTB4CBGQ) - CD Section discussions spanning Deploy Stage
- [#ops_staff_plus](https://gitlab.slack.com/archives/C0305PJB9JR) - Foster collaboration and technical leadership within Ops section
- 🔒ops-staff-confidential - Channel for reviewing topics for Ops Engineering leaders.  Please use other public channels for topics that don't require confidentiality.

## Meetings

### Zoom Recordings synced to Google Drive

GitLab encourages transparency by default, and when meetings are recorded, they can be automatically synced to Google Drive as highlighted in [the section about how we conduct video calls at GitLab](/handbook/communication/#video-calls). To summarize:

1. Record meetings to the cloud in Zoom, and add the text [REC] anywhere in the meeting title (e.g. Google calendar event)
1. It will automatically be added to the [GitLab Videos Recorded folder](https://drive.google.com/drive/folders/0APOeuCQrsm4KUk9PVA) on Google Drive, with a naming convention of `youremail-Meeting Title`.
1. After a meeting ends, Zoom may take some time to process the recording before it is actually available. The sync to Google Drive happens on the hour mark, so if the recording is not available, it may take another hour to be transferred.
1. Future recordings of recurring meetings can be found in the same folder `youremail-Meeting Title`, even if alternate hosts start the recording.

#### Hackathons

Hackathons provide a great opportunity for team members to experiment with working on ideas as possible features that can be integrated into GitLab in the future. The intent is to inspire creativity and encourage collaboration amongst those you may not have the opportunity to work with on a regular basis, set aside regular milestone deliverables, and have some fun with tackling different challenges.

With the IT landscape rapidly changing with explorations in emerging technologies, having Hackathons take place twice a year offers everyone a chance to contribute to different areas of interest.

## Planning Processes

Planning processes followed by teams in the Sub-department:

- [General Ops Sub-department Planning Process](/handbook/engineering/devops/ops/general-planning/)

## Sustaining / Non-Sustaining planning exercise

In FY23, each EM in Ops was asked to participate in a [capacity planning exercise that involved evaluating the sustaining vs non-sustaining work](https://gitlab.com/gitlab-com/ops-sub-department/ops-engineering-management/-/issues/125) in their team's backlog. This exercise was also repeated by the [Verify Pipeline teams in FY24](https://gitlab.com/groups/gitlab-org/-/epics/11284) to better understand Engineering capacity needs for each of the Pipeline teams.

Each team created a staffing justification based on the breakdown of sustaining vs non-sustaining issues in their backlog. EMs estimated the number of backend engineers and frontend engineers that would be needed, per quarter, of the given fiscal year to burndown these issues, as ordered by the [prioritization framework](/handbook/product/product-processes/#prioritization-framework) and relevant priority/severity labels.

### Sustaining work

Sustaining work refers to the most important security, availability, scalability and performance, essential for "keeping the lights on" for the feature categories the team supports. Capacity planning for sustaining work was based on meeting the SLO/SLAs of these types of issues.  The labels for sustaining work include, but are not limited to:

- `bug::vulnerability` (note: specifically this label, as an issue with only a `security` label does not make it a security vulnerability)
- `bug::availability`
- `bug::performance`
- `infradev`

### Non-Sustaining work

Non-sustaining effort refers to all other work the teams would work on, including:

- `type::feature`
- `type::maintenance` (e.g. technical debt that does not impact availability, scalability, performance, etc)
- all other `type::bug` issues not covered as sustaining work
- reviewing community contributions
- responding to customer inquiries / support requests

## Ops Promotion Process

### Tips for writing Promotion Documents

- The format and guidelines are [as listed in this Google Doc template](https://docs.google.com/document/d/1nDkYGK2yhe8pD-lnMGmEF-Cf0IlGgVOznjXMq9FxGiQ/edit)
- **Results** is our most important value to cover in promotion docs, especially at Staff+ levels. This should be short (making it succinct can be easier to understand), but descriptive enough to show the impact these results have had.
- **Impact** should also be highlighted (quantifiable where possible), with examples such as:
  - customer-facing impact (CMAU, ARR growth, retention, adoption, etc)
  - improvements in efficiency, team process or other team metrics
- Examples demonstrating leadership, ownership and accountability (going *above and beyond* for your current role):
  - Your role on a project or initiative ("how did you successfully help deliver X?", "what role did you play in this Working Group?")
  - MR Review efforts (your role as a maintainer for your team or for the rest of the department in your domain)
  - Collaborating with your team's stable counterparts
  - Mentoring/coaching others on your team or outside your team (e.g. participation in mentorship programs, coaching in MRs as a reviewer/maintainer)
  - Influencing your team's technical direction or contributions to more strategic discussions
    - For Staff+ engineers: this could mean authoring or contributing to architectural design documents or leading technical discussions with your team or driving cross-stage collaboration
  - Involvement in recruiting efforts (e.g. as an interviewer and/or reviewer of the technical assessment)
- Examples of promotion documents from previously approved Ops promotions can be found in this [Google Drive folder](https://drive.google.com/drive/folders/15hQXI2H9JSdifmjiSGnyDfcVRJ8LKScS)

### Promotion Document Reviews

1. Team Member and Manager work together to create promotion document.
1. Promotion document is shared with Ops Sub-Department managers in #ops-staff-confidential channel (private to Ops Managers, Senior Managers, Director) to receive feedback on the document content and how it calibrates with others in the Sub-Department.  This can be done early and often.
1. Manager requests another Manager in the Sub-Department review and approve the document.
1. Manager requests Senior Manager in the Sub-Department review and approve the document.
1. Manager requests Director add Team Member to list of Sub-Department planned promotions.  If the team member cannot be added Director will provide feedback to Manager as to why.
1. Director presents promotion doc at Development Department quarterly promotion review meeting.  If the promotion is not approved Director will provide feedback to Manager as to why.

### Quarterly Promotion Review Meeting

Ops Managers, Sr. Managers, and Directors meet in the last month of each quarter to:

1. Review promotion projections for each group.  Managers add a list of their direct reports who they anticipate will be ready for promotion in the next 3 quarters to the meeting agenda.  *Note these lists may change and are not a guarantee a team member will be promoted in a specific quarter.  The lists are used for planning purposes, to help us anticipate the number of team members approaching promotion, budget impact, and to support calibration across the group.*
These lists should include:
    1. Team Member name
    1. Targeted promotion quarter
    1. Link to promotion doc
    1. Whether the doc has received any Ops Manager or Ops Senior Manager approvals.
1. Review Ops team member promotion docs planned to be presented at Development Department quarterly promotion review meeting.

#### Promotion Mentor for Staff+ Roles

Team members who aspire to advance within our organization are advised to identify a [mentor](/handbook/people-group/learning-and-development/mentor/) in the targeted role, and reach out to them about a mentorship. Involving a mentor in the peer promotion review process is beneficial, as it ensures:

1. The feedback is informed by comprehensive understanding and relevance to the individual's development.
1. The feedback, being familiar and constructive, will not catch the mentee off guard and will provide clear directions for improvement from peers they'd work with directly.

Individuals pursuing promotion, possibly in consultation with their managers, should maintain regular communication with their mentor to evaluate progress and explore further opportunities for growth. This initiative also aims to cultivate leadership qualities among our senior Staff+ engineers.

We plan to trial this optional process in Ops during Q1FY25. Progress and established mentor/mentee pairs can be found in this [epic](https://gitlab.com/groups/gitlab-org/ci-cd/-/epics/6)

## Async Updates (No Status In Meetings)

We have a policy in Ops to keep status updates out of meetings. Instead of reporting on status in meetings Directors, Senior Engineering Managers, Engineering Managers and Principal Engineers provide regular async updates.

The content of these updates varies by individual and role:

### Async Update Guidance

#### Engineering Manager

1. Cadence: Weekly to Monthly (Optional)
1. Topics:
    1. Highlights & Accomplishments
    1. Team Projects & Priorities (progress, blockers, key decisions, etc.)
    1. What's next - what to expect in next update

#### Senior Engineering Manager

1. Cadence: Monthly (Optional)
1. Topics:
    1. Milestone Review
        1. Allocation of focus in milestone plans (major features, maintenance, etc.)
        1. What tradeoffs or decisions should be made prior to Milestone kickoff? For example:
            1. Is the team overcommitted?
            1. Does the allocation of effort need to shift to meet specific goals? (e.g. Security SLAs)

#### Principal Engineer

1. Cadence: Weekly (Optional)
1. Topics:
    1. Highlights & Accomplishments
    1. Projects & Priorities (progress, blockers, key decisions, etc.)

### Benefits of reporting and reviewing status async vs. synchronously in meetings

1. Collaboration - By sharing announcements, achievements, goals, and plans we are empowering team members with the information they need to make sound decisions and succeed in their roles.
1. Results - Async updates provide an important channel for sharing accomplishments and progress.
1. Efficiency - Expecting each team member to [poll](https://en.wikipedia.org/wiki/Polling_(computer_science)) for the status they need is extremely inefficient and becomes more inefficient as the organization grows. By using a [Publish Subscribe model](https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern) we are able to share information much more efficiently.
1. Diversity, Inclusion & Belonging - Async status is more inclusive of team members across timezones.  Not every team member will be able to make a sync meeting (due to timezone or other factors) but everyone can participate in an async update.
1. Iteration - Taking the time to checkpoint where we are at each week prompts the author and readers to consider ways to iterate and to reflect on incremental progress.
1. Transparency - Sharing information in a consistent, accessible way increases transparency and reduces the threshold for team members to contribute.

## Escalations from Support Team

We are piloting a process to make coordinating with the Support team on customer escalations more efficient.

See [How to Use GitLab.com to Formally Request Help from the GitLab Ops Development Team](/handbook/support/workflows/how-to-get-help/#how-to-formally-request-help-from-the-gitlab-development-team) for process details.

If you encounter an Ops-related customer escalation, that seems to have a high
[customer priority](/handbook/product/product-processes/customer-issues-prioritization-framework/#priority-points),
and would benefit from additional visibility, please post a link with a short description in
[`#doe-ops` Slack channel](https://gitlab.slack.com/archives/CT9CM1VDJ).

### Supporting Customers on Dedicated instances

When teams are asked to triage support requests for customers on GitLab Dedicated and engineers need access to their logs, a sync can be arranged between the engineer and the assigned Support Engineer for a screen sharing session.
However, when further troubleshooting is needed by the engineering team or async collaboration is preferred, follow these steps to request access:

1. Create an [access request](https://gitlab.com/gitlab-com/team-member-epics/access-requests/-/issues/new?issue%5Bassignee_id%5D=&issue%5Bmilestone_id%5D=) (AR) and list the engineers who require access.  (Note that EMs can create this issue and provide `Manager Approval` on behalf of the engineers)
1. Assign the AR to the EM and PM of the [Dedicated group](/handbook/engineering/infrastructure/team/gitlab-dedicated/) for *read-only* log access.
1. Reference the AR issue in the support tracker issue so that the Support Engineer is aware.
