---
title: Product Development
---

This section of the handbook is for shared Product and Engineering content.
For any content wholly owned by only one division, please use the relevant sections: [Product](/handbook/product/) or [Engineering](/handbook/engineering/).

## Product Development Roles and Responsibilities

Successful product development requires and demands a unified commitment to shared outcomes across team members. The entire team must collectively embrace responsibility for the delivery of positive user impact, aligned to our GitLab value of delivering [Results for Customers](/handbook/values/#results).

### Leads and their Responsibilities

With a foundation of shared responsibility for delivering results, each team member is accountable to ensure their expertise is leveraged to cover critical responsibilities within the team. These critical responsibilities are covered by **_leads_**, who serve as primary orchestrators and focal points for a responsibility area. This does not mean a lead is the sole executor of their responsibility area, rather they are serving as a "go-to" person with the following expectations:

- Maintain the big picture view of their respective area(s)
- Ensure nothing falls through the cracks
- Drive consistency in approach and standards
- Facilitate collaboration and cross-pollination of ideas
- Take ultimate accountability for their domain while promoting shared responsibility
- Act as escalation points when issues arise
- Coordinate across different stakeholders and teams
- Champion best practices and continuous improvement in their areas

Within each product development team, the following responsibilities require coverage:

1. **Product Lead**: Represents the customer's needs, understands the business value associated with those needs, and translates the needs and value into the "Why" and "What" needs to be built. The result is a prioritized set of requirements and definition of metrics and what success looks like for the team. This individual also provides critical input about the quality bar and drives the definition of acceptance criteria that ensures positive user experience and owns the landing of the defined feature.
1. **Technical Lead**: Guides architectural decisions, assists in breaking down requirements into technical work needed and decides on the "How". Then provides guidance and oversight on implementation. Technical lead also provides input on the definition of done and input on the quality targets, testing & validation strategies.
1. **Delivery Lead**: Facilitates team processes, removes obstacles, defines the implementation schedule, and owns the performance against implementation schedules. They also ensure that quality of outcome is explicitly included in the discussion and regularly revisited and evaluated.
1. **Resource Lead**: Manages individual and team performance. Also responsible for team sizing and composition (seniority) to ensure the team has the skills and support it needs to be successful.
1. **UX Lead**: Ensures exceptional user experience of the product from planning through implementation where there is a direct product interface with the end user.
These responsibilities across Product, Technical, Delivery, Resource, and UX all require coverage to ensure that the product development team's output is delivered on target from a quality, usability, and capability standpoint.

### Role vs. Responsibility

There is an important distinction between a role (i.e. Product Manager, Engineering Manager) and a Lead's responsibility area (i.e. Product, Technical, Delivery, Resource, UX). While roles such as 'Product Manager' and 'Engineering Manager' often align with specific leadership responsibilities, their areas of responsibility are not exclusive to their roles.

- Ex: while a team member with the 'Product Manager' role often fulfills the Product Lead responsibilities, they have other critical contributions beyond the demarcations of the Product Lead role. In some situations where a product are consumed internally and may not directly interface with end customers, the Product Lead role may be fulfilled by a Technical Individual Contributor (IC) or an Engineering Manager.
- Ex: a team member with an 'Engineering Manager' role often covers multiple responsibilities simultaneously - an Engineering Manager may fulfill some or all of the Technical Lead, Delivery Lead, and Resource Lead roles based upon the needs of their specific team

With the caveats above, the general pattern we see within GitLab product development is:

- Product Division usually covers the responsibilities of:
  - Product Lead - note: there can be exceptions here, especially in the infrastructure area.
  - UX Lead
- Engineering Division usually covers the responsibilities of:
  - Technical Lead
  - Delivery Lead
  - Resource Lead

Within GitLab product development teams, we believe that "we win or lose as a team" - wins are team wins, and losses are team losses. The whole team owns the outcomes, and responsibilities assigned to a subset of the team are intended to drive execution excellence, and not meant to install rigid boundaries. One individual can cover multiple areas of responsibility on behalf of a team:

- Ex: Technical Lead may serve as the Delivery Lead
- Ex: Delivery Lead may also serve as Resource Lead for the team

Lastly, the specific needs that a product development team has for a specific responsibility may differ based upon the type of project, maturity of project, maturity of technology area and technology stack, maturity of developers, etc. The key is ensuring that each product development team has agreement and interlock on ownership and accountability for each of these responsibilities, regardless of how they are distributed among team members and across roles.

### Key Events & Activities Mapping into Responsibilities

Hierarchy of Work

- Direction
  - Big Initiative
    - Top-level Epic
      - Capability
        - Composite Deliverables
          - Atomic Deliverables

Legend

- ✅: driving
- ✔️: involved

|  #  | Key Events & Activities | Product Lead | Technical Lead | Delivery Lead | Quality Lead | Resource Lead | UX Lead | Tech Writing Lead |
| --- | ----------------------- | ------------ | -------------- | ------------- | ------------ | ------------- | ------- | ----------------- |
|  1 | Define a one year Direction for their area of responsibility that aligns with: (1) company's 3 year strategy, (2) their leader's (CPO/CTO) direction, (3) current company objectives, (4) customer needs. | ✅ Product focus | ✅ Technical focus |  |  |  | ✅ User focus |  |
|  2 | Break Direction into Big Initiatives that drive maturity of their area of responsibility | ✅ Product focus | ✅ Technical focus | ✔️ |  |  | ✅ User focus |  |
|  3 | Break Big Initiatives into Top-level epics that allow for planning, refining, and scoping the next X amount of days ahead (where X can be 90 days, 180 days, etc.) | ✅ Product focus | ✔️ Technical focus | ✅ Technical focus |  |  | ✔️ |  |
|  4 | Break down Top-level Epics into  Capabilities to get to the Top-level Epic goal with a focus on quality and user experience | ✅ Product focus | ✔️ Technical focus | ✅ Technical focus |  | ✔️ | ✅ User focus ✔️ | ✅ Docs focus |
|  5 | Prioritize a backlog of Capabilities to keep it up-to-date based on Top-level Epic | ✅ Product focus | ✔️ Technical focus | ✅ Technical focus |  | ✔️ | ✔️ | ✔️ |
|  6 | Break Capabilities down into Composite Deliverables that can be assigned to a team of developers |  | ✔️ | ✅ | ✅ |  | ✔️ | ✔️ |
|  7 | Prioritize a backlog of Composite Deliverables to keep it up-to-date going into milestone planning | ✅ | ✅ | ✅ | ✔️ | ✔️ | ✔️ | ✔️ |
|  8 | Interlock on Committed Deliverables for milestone | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
|  9 | Interlock on updated R&D roadmap based upon plan | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 10 | Break down Composite Deliverables into frontend, backend, infrastructure, etc. Atomic Deliverables that can be assigned to a developer |  | ✔️ | ✅ | ✅ |  |  | ✅ Docs focus |
| 11 | Prioritize a backlog of Atomic Deliverables to keep it up-to-date going into milestone planning |  | ✔️ | ✅ | ✅ |  |  |  |
| 12 | Assign Atomic Deliverables to developers |  | ✔️ | ✅ | ✅ |  |  |  |
| 13 | Track and report progress of Atomic Deliverables during the milestone to key stakeholders |  |  | ✅ |  |  |  |  |
| 14 | Validate technical work and level of quality meet acceptance criteria and Definition of Done | ✅ | ✅ | ✔️ |  | ✅ | ✅ | ✅ |
| 15 | Report status at the end of the milestone to help align planning of the next milestone |  |  | ✅ |  |  |  |  |
| 16 | Report status of Atomic Deliverables as part of achieving composite deliverables, as part of achieving Capabilities, and as part of achieving Top-level Epic |  |  | ✅ |  |  |  |  |
| 17 | Update progress against direction and initiatives based upon last milestone results | ✅ Product Focus | ✅ Technical focus | ✅ |  |  |  |  |
| 18 | Interlock on updated R&D roadmap based upon actuals | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 20 | Engage with PMM and DevRel to ensure messaging is correct, updated, and support the creation of GTM materials as needed | ✅ Product Focus |  |  |  |  |  | ✔️ |
| 21 | Present the parts of the product and related roadmap to customers in support of sales opportunities or updates for existing customers | ✅ |  |  |  |  |  |  |

### Plan of Action

1. Review and interlock with Sabrina & David
1. Current State Assessment
   Inventory of existing GitLab R&D teams at the Section/Stage/Group level and determine the current state role distribution - leveraging inputs from CTO-directs and CPO-directs:
   - Product Lead
   - Technical Lead
   - Delivery Lead
   - Resource Lead
   - UX Lead
1. Drive alignment between CPO-directs and CTO-directs level on what roles are required for each team. Start with leadership summits for Product and Engineering - and then continue in product/eng/UX lead pairing that cover specific areas:
   1. Tim Zallmann + Steve Evangelista + Hillary Benson + Angela Pesta
   1. Michael Wildpaner + Hillary Benson + Justin Farris + Angela Pesta  (maybe add Jerome Ng)
   1. Marin Jankovski + Mike Flouton+ Angela Pesta
   1. Alignment to be done on:
      1. Determine the optimal division of roles across Product and Engineering as they apply to their teams
      1. What does the success look like?
      1. Help Score "health" of each team and prioritized actions to improve
      1. Desired Future State based upon current staffing & skills:
1. Hypothesis where the CTO/CPO leads are going to end up
   1. Level at which the teams are set up for healthy engagement is not at group level (that is, locally optimized)
   1. Each lead is aware and feels accountable and covers their responsibilities
   1. Changes are required to enable predictable roadmap delivery and quality

## Messaging R&D Roadmap

Tiering approach to commitments

| Tier | Description | Target Quantity | R&D Commitment Accuracy |
| ---- | ----------- | --------------- | ----------------------- |
|  1  | Tier 1 requires GA of capability as well as validation through the Early Access Program. Requires customer references and tells a story of differentiation. | 1 per Quarter | 100% |
|  2  | Tier 2 includes key feature updates that help tie together a story. These are considered less strategic however may be noteworthy enough for a blog post or media interviews. Features do not have to be GA but must be available broadly with customer references as a "better" vs a requirement. | 1 per Quarter for each Investment Area: Win with Core DevSecOps workflows, Comprehensive Security & Compliance, Differentiate with AI across the SDLC.<br> Investment areas: SCM, CI, security, compliance, enterprise agile planning, and AI. | 80% |
|  3  | Tier 3 includes regular monthly release items which do not warrant GTM motions however should be included in items like the monthly release notes. Unlike previous tiers, these can slip their date to ensure Tier 1/Tier 2 deliverables do not miss their committed date. | Driven by FY26 objectives and priorities, as many as possible given resource, scheduling, and quality constraints. | 40% |

### GTM Strategic Launch Events

Formerly known as "Tier 0"

Characteristics:

- Typically ties together multiple GA features into a larger narrative and aligns to a major event
  - FY25 examples: GitLab 17 launch or AWS Re:Invent
- Max of 2 per year given size and scope
- Considered strategic events and will include both recent and future Tier 1 and Tier 2 R&D deliverables

### Product vs. Engineering Responsibilities

Defining the "5W + 1H" of Software Delivery for GitLab R&D

| 5W + 1H | Product (PM + UX) | Engineering |
| ------- | ----------------- | ----------- |
| WHO? | Who are our target customers, users, and buyers? <br> Prime: UX, Supporting: PM |  |
| WHAT? | What capabilities do our users need within our product to accomplish their goals and outcomes, including acceptance and success criteria? <br> Prime: PM, Supporting: UX |  |
| WHY? | Why do our users need those capabilities to achieve their desired outcomes? <br>Prime: PM, Supporting: UX |  |
| HOW? | How will the user navigate specific steps or actions to accomplish their tasks within the product? <br>Prime: UX, Supporting: PM | How will we design and build the technical solution that delivers the required capabilities and UX with the desired quality? |
| WHERE? |  | Where will we deploy capabilities and infrastructure to deliver required capabilities, UX, and quality? |
| WHEN? |  | When can the technical solution be built, tested, and made available to users per required capabilities, UX, and quality? |
