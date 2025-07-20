---
title: "Technical Leads at GitLab"
---

## Technical Leads

At GitLab, a Technical Lead ("Tech Lead") is both an [archetype](/handbook/engineering/ic-leadership/#tech-lead) and a [role](#the-tech-lead-role).

"Tech Lead as an archetype" is an expectation, especially for Staff+ Engineers,
but "Tech Lead as a role" can be assigned to any Engineer, regardless of their
seniority. The primary factor taken into the account when assigning a Tech Lead
role is efficiency, and optionally domain knowledge and/or expertise that might stem from
assigning this role to a given individual contributor.

### The Tech Lead Role

At GitLab, a Tech Lead might be an individual contributor with additional
responsibilities. Every engineer regardless of their seniority can be a Tech
Lead. This is a temporary role that is tied to a specific topic / project. We
allow teams to have multiple Tech Leads at the same time for different
projects. They may be overseeing the work of additional engineers on the project,
and remain aware of the moving pieces across them.

An engineer who is acting as a Tech Lead is **not** a manager, and the role
itself is **not** an additional seniority level.

### Responsibilities of a Tech Lead

Tech leads wear many hats. Their responsibilities may differ from project to
project but may include:

1. Providing technical vision and architecture, defining and evolving the
   overall technical specification for a given project.
1. Providing technical guidance and mentoring to other engineers on the team.
1. Planning and prioritizing work, organizing the engineering effort by
   breaking down bigger tasks into smaller actionable items.
1. Tracking progress on commitments and reporting status updates to stakeholders or the DRI of the project.
1. Risk management, identifying, assessing and managing technical risks that
   may impact deliverables.
1. Coordination, overseeing the work of others and helping remove blockers.

The Engineering Manager (EM) can also help provide support in project management, but the Tech Lead and the EM should collaborate to decide ownership of specific tasks.

## Difference between a Tech Lead and a Directly Responsible Individual (DRI)

While both Tech Leads and [DRIs](../people-group/directly-responsible-individuals.md) have important leadership roles, they serve different purposes:

- A Tech Lead is a temporary role focused on technical leadership for a specific Epic, or initiative, like a working group. While the Tech Lead and DRI roles often overlap, they are distinct and can be assigned separately. The DRI is ultimately accountable for the success or failure of the project and owns the delivery, while the Tech Lead provides technical guidance and coordination.

- A DRI is the single person ultimately accountable for the success or failure of a project or decision. They have the authority over making final decisions and they needn't be the individual that does the tactical project work. 

A Tech Lead may or may not be the DRI for their project. In fact, a Tech Lead can further report to a DRI. 

For example, on a cross-functional working group, the Tech Lead may focus on technical implementation and coordination of a specific part of the initiative, while they report to a DRI who is responsible for the overall success of the initiative.

### When does a project require a Tech Lead?

A Tech Lead may be most valuable for projects that have one or more of these characteristics:

- **Technical complexity**: Projects involving significant architectural decisions or technical risks that need careful consideration and oversight.
- **Cross-team coordination**: Work that spans multiple teams or requires coordination between different technical teams.
- **Number of collaborators**: Projects where multiple engineers are working simultaneously on related components and would benefit from technical guidance and coordination from a Tech Lead.
- **Strategic importance**: Initiatives that are critical to business objectives and require dedicated technical leadership to ensure success.

Not every project requires a dedicated Tech Lead. For simpler, well-defined tasks or projects where the technical direction is clear, having a Tech Lead might not be necessary.

A Tech Lead should not be mistaken as the sole decision maker. We envision Tech Leads as technical facilitators who can help guide the project to success, and not as a central authority that needs to make or approve every technical decision.

### Assigning a Tech Lead to a project

To formally assign a Tech Lead to a project, the Engineering Manager (EM) should follow these steps:

1. Add the designated person as Assignee to the Epic.
1. Add a clear identifier in the Epic description using the format: "Tech Lead: [Name]".
1. Add the `~tech-lead-project` label to the Epic.

### Slack channel

There is a Slack channel available
[#tech_leads](https://gitlab.enterprise.slack.com/archives/C06ALUU5NKS)
(internal) where Tech Leads can collaborate together, and ask questions about
the role or an archetype of a Tech Lead. Everyone else is welcome too!
