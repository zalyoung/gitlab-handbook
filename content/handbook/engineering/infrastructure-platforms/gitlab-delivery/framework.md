---
title: GitLab Delivery:Framework
---

## Summary

Framework is a team within the [GitLab Delivery Stage](/handbook/engineering/infrastructure/team/delivery/). This team takes ownership of the GitLab Environment Toolkit (GET) as instance lifecycle tool, Reference Architectures, tooling and frameworks related to upgrade path testing, and will ensure installation and upgrade paths are fully tested and reliable. We follow the same processes as listed on the [GitLab Delivery Stage](/handbook/engineering/infrastructure/team/delivery/), unless otherwise stated on this page.

## Mission

The Framework team intends to make GitLab easy to operate at any scale. GitLab is critical to our end users (developers) and a necessity for organizations most important business operations and workflows. The Framework team functions with autonomy to drive good quality within our Reference Architectures and GET above all else.

### Some optimal success criteria include

1. A decrease in the cost of support per customer
1. Lower time to value for new installations
1. More instances on the recent version of GitLab
1. Fewer upgrade-related incidents
1. Instances on supported architecture

Seeing that many of these metrics are owned by multiple teams, the Framework Team will contribute here but does not have full agency to drive.

### What does it mean to Operate GitLab?

GitLab is a complex application. Organizations typically have a dedicated team to manage GitLab internally. This operation includes day-to-day maintenance, upgrades, backup and restore, and downtime. This team's goal is to make this operation easy for all organizations, including our own deployments.

It is not solely the responsibility of the Framework team to make GitLab easy to operate, but to provide guidance to the wider GitLab organization to develop in a way that is conducive to a good user experience for admins. Managing GitLab components in a tested and supported architecture significantly lowers the operational aptitude required.

### Delivery of Mission

1. Easy enablement materials to consume reference architectures for account teams and operators
2. Collaborate on structured guidance for operational excellence in feature development
3. Verify upgrade paths
4. Stewards of a good experience for managing GitLab with GET and the Reference Architectures

### Tools and Responsibilities

The Framework team will lead our GitLab Environment Toolkit and Reference Architectures initiatives, as these are great delivery methods for the goals of this team. However, these will only be a piece of the larger picture, which includes producing positive outcomes for the GitLab admin. This includes external users as well as easing the operational requirements for our own SaaS offerings.

#### GitLab Environment Toolkit (GET)

GET is a set of opinionated Terraform and Ansible scripts to assist with deploying scaled self-managed GitLab environments following the Reference Architectures. A good experience with GET means users will more quickly have an environment (lower TTV) and long-term success (decreased need for support).

#### Reference Architectures

The reference architectures will provide the best user experience with the intent to decrease the amount of required support from GitLab. The Framework team will continue to ensure the RAs meet the needs of customers by improving architecture designs over time. The Framework team will also provide guidance for internal teams to review and add components as needed.

#### Upgrade Path Validation

Upgrading GitLab is one of the most challenging parts of operating GitLab and, at times, requires very dedicated attention to plan how GitLab gets upgraded.

#### Other Responsibilities

1. Architecture performance and non-functional testing
2. Admin experience
3. Enablement of GitLab account teams to provide appropriate recommendations
4. Self-serve experience for scaling GitLab

## Team Members

{{< team-by-manager-slug "lsogunle" >}}

Product Manager: [Martin Brümmer](/handbook/company/team/#mbruemmer)

## Roadmap

The team's primary roadmap is tracked within [the Roadmap epic](https://gitlab.com/groups/gitlab-com/gl-infra/-/epics/1454). Our roadmap is aligned with GitLab Delivery's overall strategic objectives and is reviewed and updated as needed.

## Working with Us

To engage with the Framework team, please refer to the following.

### Slack Channels

The following list includes Slack channels relevant to projects within the team's scope:

* [#g_software_delivery-framework](https://gitlab.enterprise.slack.com/archives/C080V5MNVMY) - This is the primary Slack channel for discussions related to the GitLab Delivery Framework team.
* [#gitlab_environment_toolkit](https://gitlab.enterprise.slack.com/archives/C01DE8TA545) - For discussions, questions, and requests specific to the GitLab Environment Toolkit (GET).
* [#reference-architectures](https://gitlab.enterprise.slack.com/archives/C015V8PDUSW) - For discussions, questions, and requests related to Reference Architectures.
* Our slack group handle is `@software-delivery-framework-team`.

## Triage DRI

The Triage DRI is a role established by the team to handle initial triage of questions and requests coming to the team. The Triage DRI process is intended to distribute knowledge and responsibilities across the team, and to prevent the same people from always being responsible for certain areas of the team's work.

### Responsibilities

1. Triaging and monitoring pipelines (e.g., [Upgrade path pipelines](https://gitlab.com/gitlab-org/quality/upgrade-tester)).
1. Monitoring and responding to requests in GET/RA Slack channels.
1. Initial issue triage for GET, and RA.
1. Maintenance of [PG Dump Generator](https://gitlab.com/gitlab-org/quality/pg-dump-generator) and related jobs if [breaking master](https://docs.gitlab.com/ee/development/database/dbmigrate_multi_version_upgrade_job.html#broken-master).
1. [Staging Ref](https://gitlab.com/gitlab-org/quality/gitlab-environment-toolkit-configs/staging-ref/-/blob/main/doc/troubleshooting.md) maintenance.

### Cadence

The Triage DRI role will be on a weekly rotation cadence. Regarding response time, we've set an aspirational goal of about one working day. It's important to note that this isn't a strict Service Level Agreement (SLA). We're viewing it more as a general guideline to aim for. We understand that sometimes things might take longer, and that's okay. The main goal is to have a reasonable timeframe for addressing inquiries and issues that come our way.

It must be emphasized that the Triage DRI is not an escalation resource like Support, but rather an advisory one. The Triage DRI is there to provide advice and initial triage, not to be a replacement for Support or other teams.

## Project Management

<!-- List of Trackers and scope -->
[Framework Issue Tracker](https://gitlab.com/groups/gitlab-com/gl-infra/software-delivery/framework/-/issues).
[GitLab Environment Toolkit (GET) issues](https://gitlab.com/gitlab-org/gitlab-environment-toolkit/-/issues) - Primary tracking system for the GitLab Environment Toolkit. This board encompasses requests, enhancements, technical debts items and customer reported issues.

[GitLab Upgrades Test Coverage](https://gitlab.com/groups/gitlab-org/-/epics/12458) - This epic encompasses issues related to testing upgrade paths.

[Reference Architecture issues](https://gitlab.com/gitlab-org/quality/reference-architectures/-/issues) - This is where we track work related to Reference Architectures and conduct reviews for customer environments upon request.

### Epics

<!-- Top level Epic(s) -->

This top-level [epic](https://gitlab.com/groups/gitlab-com/gl-infra/software-delivery/framework/-/epics/2) monitors the different initiatives and sub-epics within the team and their respective statuses. It is populated automatically through [epic automation](https://gitlab.com/gitlab-com/gl-infra/epic-issue-summaries).
Every sub-epic must

1. Epics must be created with the epic template linked below.
1. Have the top-level epic as the parent epic.
1. Have a completion date and a DRI for providing a weekly status update.
1. Have a relevant `workflow::` or `workflow-infra::` label.
1. Epic DRIs will be pinged on Tuesdays to leave a status update for the week in the epic.
1. These updates are collected into the team's top-level epic which feeds into the [Grand Review](/handbook/engineering/infrastructure/platforms/#grand-review).

We follow Platforms Project Management practices as outlined [here](/handbook/engineering/infrastructure/platforms/project-management/).

### Labels

<!-- Labels explanations -->
The primary team label is `team::GitLab Delivery Framework`. This label should be applied to issues and epics throughout the organization that require the team's attention.

#### Epic Template

<details><summary>Epic Template</summary>

```markdown
### DRI :levitate:
- TBC

### Participants :busts_in_silhouette:


### Problem to solve :thinking:

### Documentation :book:

* Publicly Accessible Documentation:

### Links / references :books:

*

---

<!-- STATUS NOTE START -->

<!-- STATUS NOTE END -->

/label ~"team::GitLab Delivery Framework" ~"workflow-infra::Triage"

```

</details>

## Team Impact

The following are records of the annual achievements of the Framework team.

1. [Team Impact Overview for 2024](https://gitlab.com/gitlab-com/gl-infra/software-delivery/framework/software-delivery-framework-issue-tracker/-/issues/15)
