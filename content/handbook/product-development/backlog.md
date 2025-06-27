---
title: Healthy Backlogs at GitLab
description: "Policy for triaging backlog issues in GitLab projects"
---

{{< note >}}
Last Updated: 2025-05-18
{{< /note >}}

## Backlog Triage Policy

This policy is established to help us address a large and growing backlog, and set a standard for healthy backlogs moving forward. Our objective for heatlhy backlogs is that each team within Product Development has a highly managed backlog that reflects their respective priorities and plans. The policy breaks down triaging by defects, features, and technical debt. Note: the [existing issue triage policies](issue-triage/_index.md), including [SLA by severity](issue-triage/_index.md#priority), continue to exist and we expect all Product Managers and Engineering Managers to follow the guidelines shared in the handbook.

1. **Defects**: All types of defects (customer reported, security, data loss, ux, accessibility, reliability, availability, and performance) must be triaged and compliant with our documented SLAs. Defects older than six months that have not been remediated must be closed with a justification included. Any defects older than six months that remain in the backlog must a justification added on why it is remaining open past the policy. **Maintaining our commitment to SLA's is the highest priority over all other work. Resolving defects, particularly those affecting core functionality, reliability, or customer trust, should be given high priority in our workflow.**
1. **Features**: Future plans for what we will implement as part of product direction must be triaged into one of two buckets: "Foundational" or "Visionary" (see definitions below). In addition, features must be planned for implementation within the next (rolling) twelve month period. If we do not have plans to implement the feature within the next twelve months, the issue must be closed with a justification included. If the feature exists in the backlog without a plan to implement in the next 12 months, a justification must be included on why it is remaining open past the twelve month policy.
   1. Two types of future plans:
      1. _Foundational_ features are new capabilities or improvements to existing capabilities (ex: SCM, CI, AST, Duo, etc.) that are within our key investments in FY26.
      1. _Visionary_ features are completely new capabilities that expand GitLab’s TAM (ex: Observability, Service Desk, etc.).
   1. Note that only Foundational features can be tagged for community contributions. Visionary features cannot be tagged for community contributions without approval from both the Product and Engineering functional leaders of the respective part of our platform.
1. **Technical Debt**: As we innovate our platform, we will have situations where a strategic decision will be made to incur technical debt in order to preserve a higher feature velocity to meet market and customer demand. This accrual of technical debt presents risks due to the long-term implications for the usability, security, reliability, scalability, accessibility, and/or availability of our product and platform. Therefore technical debt may be accrued but must be triaged, assigned a priority, and have a plan to remediate within the assigned SLA. If it is to be deferred by more than 6 months, it must be put into the product and engineering roadmap. Technical debt issues you wish to be closed must not affect the "*abilities" and have a justification included on why it cannot be remediated within the next 12 months (meaning, there is an action plan on the Engineering roadmap).

This Backlog triage policy enables us to openly communicate our commitments for what we will work on to improve our product for the community and our customers, addressing:

1. Direct customer feedback requesting more predictable and timely decisions on feature requests
1. Community contributor feedback requesting clarity on how they can best contribute, and what areas of the product their contributions would be most impactful.
1. Customer and community feedback on improving visibility, transparency, and accuracy of our rolling 4 quarter customer roadmap.

Establishing these updates to our backlog triage policy will help us maintain a deep focus on both product quality and delivering customer value. Delivering customer value with predictability and high quality is fundamental to GitLab’s continual growth and the impact we can have in helping organizations achieve their business goals by shipping secure software faster.
