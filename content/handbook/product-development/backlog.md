---
title: Healthy Backlogs at GitLab
description: "Policy for triaging backlog issues in GitLab projects."
---

{{< note >}}
Last Updated: 2025-05-15
{{< /note >}}

## Backlog Triage Policy

This policy is setup to help us address the large backlog, and set up a healthy backlog moving forward. This policy is designed to move us from having a large backlog of issues, which in 2025-05 is [over 109k open issues](https://gitlab.com/groups/gitlab-org/-/issues), to a highly managed backlog that reflects each team’s current priorities and plan. The policy breaks down triaging by defects, features, and technical debt. Note: the [existing issue triage policies](_index.md), including SLA by severity, continue to exist and we expect all Product Managers and Engineering Managers to follow the guidelines shared in the handbook.

1. **Defects**: All types of defects (customer reported, security, data loss, ux, accessibility, reliability, availability, and performance) must be triaged and compliant with the documented SLAs. Defects older than six months must be closed with a justification included or a justification added on why it is remaining open past the policy. **Resolving Defects is the highest priority over all other work.**
1. **Features**: Future plans for what we will implement as part of product direction must be triaged into one of two buckets, foundational and vision (see definitions below), and planned to be implemented within the next (rolling) twelve months. If we do not have plans to implement the feature within the next twelve months, the issue must be closed with a justification included or a justification included on why it is remaining open past the twelve month policy.
   1. Two types of future plans:
      1. _Foundational_ features are new capabilities or improvements to existing capabilities (SCM, CI, AST, Duo, etc.) that are within our key investments in FY26.
      1. _Visionary_ features are completely new capabilities that expand GitLab’s TAM (Observability, Service Desk, etc.).
   1. Note that only foundational features can be tagged for community contributions. Visionary features cannot be tagged for community contributions without approval from both of the functional leaders for this part of our platform.
1. **Technical Debt**: Deliberate deferring of foundational implementation needs to ship with higher velocity has long-term implications for the usability, security, reliability, scalability, accessibility, and/or availability of our product and platform. Technical debt may be accrued but must be triaged, assigned a priority, and have a plan to mediate within the assigned SLA. If it is to be deferred by more than 6 months, it must be put into the product and engineering roadmap. Technical debt issues you wish to be closed must not affect the "*abilities" and have a justification included on why it cannot be mediated within the next 12 months (meaning, there is an action plan on the Engineering roadmap).

This policy enables us to openly communicate our commitments for what we will work on to improve our product for the community and our customers, addressing:

1. Customers commonly point out to their account teams that they submitted a feature request and that issue has been open for some time, and sometimes for multiple years, without any engagement from GitLab.
1. It is very hard for the community to identify how they can best contribute as there are a lot of open issues tagged for accepting community contributions, including very complicated visionary features.
1. Understanding the capacity of the team to deliver on the rolling 4 quarter customer roadmap.

The policy aims to help us be deeply focused on both product quality and our Fiscal Year Plan. Executing on our Fiscal Year Plan is fundamental to GitLab’s continual growth and the impact we can have in helping organizations achieve their business goals by shipping secure software faster.
