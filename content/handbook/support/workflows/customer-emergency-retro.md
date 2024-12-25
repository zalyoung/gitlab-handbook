---
title: Customer Emergency Retrospectives
category:
description: ""
---

The GitLab Support team puts a lot of effort into solving problems during customer emergencies. During emergencies, we sometimes identify challenges that are not limited to the specific customer we’re helping. Conducting retrospectives (or "retros") on these situations can help us to ensure we retain the insights we gain during these emergencies. The questions raised during retrospectives help us to improve our product and processes to the benefit of all.

## :feather: Retro Principles

A few key principles to keep in mind:

- It is not necessary to conduct a retro on every emergency.
  - If during an emergency you think "we really need a better way to deal with _that_ in the future", you should probably conduct a retro on that emergency.
- A retro is a [blameless opportunity](https://docs.gitlab.com/ee/tutorials/scrum_events/standups_retrospectives_velocity.html#sprint-retrospectives) for the team to identify process improvements.
- :feather: Retros should be as lightweight as possible.
- :reminder_ribbon: [Not every problem should lead to a new process to prevent them.](https://handbook.gitlab.com/handbook/values/#accept-mistakes).
- :repeat: Retros should be synchronous when possible. It is recommended to conduct a synchronous retro because it can be easier to [establish a safe environment](https://handbook.gitlab.com/handbook/engineering/management/group-retrospectives/#establishing-a-safe-environment) and because biasing for asynchronous communication can reduce the efficiency of the retro.

## :musical_score: Conducting a Retro

Anyone can suggest that a retro should be conducted on an emergency (or other anomalous situation). Once it has been determined that a retro should be conducted on a particular emergency, this section should guide you.

Ideally, someone who was directly involved in the emergency identifies someone who was not actively involved in the emergency to lead the synchronous retro. A thirty minute session is typically sufficient.

The person conducting the retro should review the ticket and related Slack threads and issues before the retro. (The aim is to get enough context to make the retro efficient while keeping an open mind and refraining from drawing conclusions before the retro.)

During the synchronous portion of the retro:

1. apply the `retro` label to the issue in [the tracker](https://gitlab.com/gitlab-com/support/readiness/emergencies/-/issues/?sort=created_date&state=opened&first_page_size=100)
1. the SE who responded to the emergency provides a brief timeline (while the person conducting the retro asks questions to fill in the gaps)
1. the person conducting the retro and the SE who responded to the emergency work through what went well, what could have gone better and suggestions for what we might do or change
1. apply the `retro-actions` label if there are suggested possible action items in the issue

### Possible Retrospective Outcomes

The suggestions and outcomes of a retrospective will vary. Common outcomes include:

- new bug issue
- new feature proposal
- check-in with PM in an existing issue or feature proposal
- update to processes in handbook

## :robot:  Automation

A retrospective issue is automatically created in the [issue tracker](https://gitlab.com/gitlab-com/support/readiness/emergencies/-/issues/?sort=created_date&state=opened&first_page_size=100) for `gitlab-com/support/readiness/emergencies` for each incoming page for the [Customer Emergencies](customer_emergencies_workflows) rotation.

The automation is managed by Support Readiness. Start [with an RFC](/handbook/support/managers/change-management.md#start-with-a-request-for-comments-rfc) if you'd like to propose changes to this process.

GitLab team members with access can look at the [:rewind: Retros](https://gitlab.com/gitlab-com/support/readiness/emergencies/-/boards/9004657?label_name[]=retro) issue board.
