---
title: DevOps Engineering
---

## Vision

 **Our goal is not merely to launch features, but to ensure they land successfully and provide real value to our customers.** We strive to develop a best-in-class product that exceeds expectations across all user groups by meeting high-quality standards while ensuring reliability and maintaining an ease of operation and scalability to meet diverse customer needs. All team members should remain mindful of our target customers and the multiple platforms we support in everything we do.

Ensure our product excels in all aspects especially for our primary customer [organization archetypes](/handbook/product/personas/organization-archetype/) of large enterprises. This includes scalability, adaptability, and seamless upgrade paths. When designing and implementing features, always keep in mind compatibility for all our deployment options: self-managed, dedicated and Software as a Service (SaaS).

Develop our technical, diverse and global team to drive results that support our product and customer growth, while maintaining [our values](/handbook/values/) and [unique way of working](/handbook/company/culture/all-remote/guide/).

## Mission

GitLab's unique way of working asynchronously, handbook first method, utilization of the product we develop and clear focus on our values enables very high productivity. We focus on constantly improving quality, usability and reliability of our product to reach maximum customer satisfaction. Community contributions and customer interactions rely on efficient and effective communication. We are a data-driven, customer experience first, open core organization delivering one secure, reliable, world leading DevSecOps platform. Join us in setting new standards, driving innovation, pushing the boundaries of DevSecOps, and consistently delivering exceptional results for our customers.

### Be Strategic

To better fulfill our goals and vision, we are following [R&D interlock process](/handbook/product-development/r-and-d-interlock).

### Fostering High-Performing Teams for Efficient Execution

In today's competitive landscape, GitLab's success hinges on our ability to build and maintain high-performing teams capable of efficient and rapid execution.

#### Key Focus Areas

1. **Team Optimization**
   - Enhance communication and leadership within groups
   - Implement efficient processes
   - Develop situational awareness across teams
   - Promote continuous upskilling towards group needs and/or the wider engineering division

2. **Streamlined Delivery**
   - Identify and fix internal and external bottlenecks
   - Focus on the swift delivery of results meeting acceptance criteria and general quality bar
   - Look out for improvements in efficiency by enhancing the product and using all its capabilities

3. **Quad Execution**
   - Clarify responsibilities within quads
   - Encourage accountability amongst team members and counterparts
   - Empower quads to execute independently with a clear vision

4. **Innovation and Creativity**
   - Encourage research and ingenuity by defining clear paths for delivering promising ideas
   - Tap into the underutilized creative potential within teams

We aim to create an environment where high-performing teams can thrive, innovate and execute efficiently, ultimately driving GitLab's competitive edge in the market.

### Connect the Dots! In the Product and Between Teams

One of our product's greatest strengths and selling points is its unified platform approach. While we currently offer multiple functionalities within a single product, we should strive to further enhance this advantage by creating stronger connections between these different areas.

To fully leverage this strength, we need to:

1. Integrate features more seamlessly across the platform
2. Develop cross-functional capabilities that highlight the benefits of our unified approach
3. Ensure a consistent user experience throughout the product
4. Align and reuse foundational implementations across the whole platform

Additionally, it's crucial to improve collaboration at the team level especially to support this part of our mission.

We should:

1. Increase awareness of ongoing projects and initiatives across teams
2. Share knowledge about new technologies and innovations and how they are applied today
3. Promote understanding of functionalities in different product areas
4. Foster greater collaboration between teams throughout the entire engineering organization

### Product with a Customer Focus

We will continue our strong partnership with Product to make GitLab the best, most complete DevSecOps platform on the planet. This coordination and prioritization requires a lot of work and effort to provide the right data and make the right decisions. We will focus on a variety of factors, but top of mind will be our parent department's direction to be [customer focused](/handbook/engineering/#expand-customer-focus-through-depth-breadth-and-stability).

### Usability

Millions of customers use GitLab, so UX improvements can have a huge collective impact across all of these individuals. We support this effort both in the product development as well as in our architecture. This includes continued conversion of [Pajamas components](/handbook/engineering/ux/pajamas-design-system/) in order to continue to improve the performance experienced by users.

Development team members should also constantly suggest and investigate how to improve the overall user experience of the product. These can range from enhancing performance (actual and perceived), suggesting new technologies, solving user experience issues efficiently, etc.

## Organizational Structure

```plantuml
@startwbs
* DevOps Engineering
** Create
*** Code Review
*** Remote Development
*** Source Code
** Ops
*** Deploy
*** Package
*** Verify:Runner
*** Verify:Pipelines
**** Pipeline Authoring
**** Pipeline Execution
**** Pipeline Security
** Plan
*** Product Planning
*** Project Management
*** Knowledge
@endwbs
```

## Organizational Responsibilities

The DevOps department is comprised of:

- [Dev](/handbook/engineering/devops/dev/)
- [Ops](/handbook/engineering/devops/ops/)

## People Processes

### Promotion Process

Aligned with the [company-wide promotion cadence](/handbook/people-group/promotions-transfers/#promotions-process--timeline), DevOps utilizes a process to collect, validate, approve, review all promotion proposals prior to them being added via the company-wide [process](/handbook/people-group/promotions-transfers/). The goal of this promotion projection and review is to:

- Promote the right people at the right time
- Maintain a high bar for promotions
- Ensure predictability and intentionality with promotions
- Ensure alignment with overall company [promotion rate](/handbook/people-group/people-success-performance-indicators/#promotion-rate)
- Add another layer of review to reduce bias in the promotion process

DevOps adheres to the company-wide quarterly timeline outlined [here](/handbook/people-group/promotions-transfers/#promotions-process--timeline) as our SSOT.

**The DevOps Department has an additional formal step built in to our promotion process beyond what the company is currently adhering to through our peer review process**. Ahead of the commencement of the [Calibration](/handbook/people-group/promotions-transfers/#calibration) stage of our process, all promotion documents should be peer reviewed by a Senior Manager or Director. The due date to complete the peer review is _before_ the scheduled Calibration session.

Calibration session attendees are the following team members: Senior Managers, Directors, Sr. Directors, VP, and Development's aligned People Business Partner. This is to ensure consistency across the organization. Leaders are welcome to conduct Calibration sessions prior to the scheduled sessions above with their sub-departments as well (though this is not a requirement).

In addition to the [company-wide calibration preparation](/handbook/people-group/promotions-transfers/#calibration), for the DevOps department we also ask that leaders come prepared to discuss:

1. Status of maintainership
2. Most recent talent assessment

#### Calibration Agenda

In order for calibration to be effective it's important that all participants have had an opportunity to review promotional documents and summaries ahead of the meeting.

The calibration agenda will consist of the following for each candidate:

1. General Information

   - Promotion Doc Peer Reviewer(s)
   - Link to GitLab Profile

1. Core accomplishments (list 2)
1. Improvement areas (list 2)

   - The promotion document outlines strengths, but we also want to highlight how we will support a team member's development areas at the next level.

1. Cross-functional Feedback

   - As our business goals and initiatives become increasingly cross-functional, managers should have a picture of how their team member collaborates effectively within their immediate teams, and with their core cross-functional partners and stakeholders.

1. Questions/feedback?

**Please aim to be concise and crisp in the calibration agenda summary for each candidate**. Leaders are able to reference promotion documents for details, while the calibration agenda summary is meant to be a snapshot of key points to help facilitate discussion and provide an overview for the group.

To allow time for review and the addition of questions/feedback, summaries should be included in the agenda no less than one week prior to the DevOps Leadership scheduled calibration date.

In line with our [guidance on feedback](/handbook/people-group/guidance-on-feedback), feedback should be regular and ongoing. Calibration sessions are meant to discuss team member promotion readiness and calibrate promotions across the department, but they should not replace the regular and ongoing feedback provided throughout the year. Any relevant feedback should be given promptly and not wait until talent assessments or promotion calibration. This will ensure that both the team member and their manager have an opportunity to address feedback in a timely manner.

### Talent Assessment Process

Talent Assessment Process guidelines specific for the DevOps Department is documented in [this handbook page](/handbook/people-group/talent-assessment/).

### How we hire contractors

In [this handbook page](processes/hiring-contractors.html) we document the process that the development department follows, including planning budget, candidate sourcing, interview process, contracting and onboarding.

## How We Work

### Onboarding

Welcome to GitLab! We are excited for you to join us.
Here are some curated resources to get you started:

- [Joining as an Engineer](/handbook/engineering/developer-onboarding/)
- [Joining as an Engineering Manager](/handbook/engineering/development/onboarding/manager/)

### Cross-Functional Metrics

[Link to dashboard](https://10az.online.tableau.com/#/site/gitlab/workbooks/2203014/views)

{{< tableau height="600px" src="https://us-west-2b.online.tableau.com/t/gitlabpublic/views/IssueTypesDetail/OpenIssuesDashboard" >}}
{{< /tableau >}}

{{% include "includes/cross-functional-prioritization.md" %}}

### Cross-Functional Collaboration

#### Working across Stages

Issues that impact code in another team's product stage should be approached collaboratively with the relevant Product, UX, and Engineering managers prior to work commencing, and reviewed by the engineers responsible for that stage.

We do this to ensure that the team responsible for that area of the code base is aware of the impact of any changes being made and can influence architecture, maintainability, and approach in a way that meets their stage's roadmap.

#### Architectural Collaboration

At times when cross-functional, or cross-departmental architectural collaboration is needed, the [GitLab Architecture Evolution Workflow](/handbook/engineering/architecture/) should be followed.

#### Follow the Sun Coverage

When cross-functional collaboration is required across global regions and time zones, it is recommended to adopt the [Follow the Sun Coverage](/handbook/engineering/development/processes/follow-the-sun-coverage/) approach to ensure seamless global collaboration.

#### Decisions requiring approvals

At GitLab we value [freedom and responsibility over rigidity](/handbook/values/#freedom-and-responsibility-over-rigidity). However, there are some technical decisions that will require approval before moving forward. Those scenarios are outlined in our [required approvals](/handbook/engineering/development/required-approvals/) section.

#### Security Vulnerability Handling

1. The development groups who introduce or consume the dependency of concern (e.g. gems, libs, base images, etc.) are responsible for resolving vulnerabilities detected against the dependency.
2. For business selected vendors that provide base images (RHEL's UBI8 for example), we need to wait for their patches, or need to log Deviation Request (DR) as viable resolutions. The [VulnMapper](https://gitlab.com/gitlab-com/gl-security/product-security/vulnerability-management/vulnerability-management-internal/vulnmapper/-/tree/main), an automation developed by the Threat Management team, can create vendor dependency DRs to a large extent, but there are still cases that DR needs to be reported manually.
3. The assigned development group can redirect issues if the initial assignment was inaccurate, following the processes for [shared responsibility issues](/handbook/engineering/infrastructure/engineering-productivity/issue-triage/#shared-responsibility-issues) and/or [Shared responsibility functionality](/handbook/product/categories/#shared-responsibility-functionality).

### DevOps Headcount planning

DevOps's headcount planning follows the Engineering [headcount planning](/handbook/engineering/#headcount-planning) and [long term profitability targets](/handbook/engineering/#long-term-profitability-targets). Development headcount is a percentage of overall engineering headcount.

We follow normal span of control both for our managers and directors of [4 to 10](/handbook/company/structure/#management-group). Our sub-departments and teams match as closely as we can to the [Product Hierarchy](/handbook/product/categories/#hierarchy) to best map 1:1 to [Product Managers](/handbook/product/).

### Daily Duties for Engineering Directors

The following is a non exhaustive list of daily duties for engineering directors, while some items are only applicable at certain time, though.

1. Review engineering metrics
    1. DevOps Performance Indicators
    1. Stage Performance Indicators
1. Review hiring dashboards
1. Personal todo list
1. Personal GitLab board(s) if any
1. [Working groups](/handbook/company/working-groups/) that the director drives or participates in
    1. Action items in agenda documents
    1. Issue boards
    1. Slack channel
1. [Infradev triage](/handbook/engineering/workflow/#infradev)
    1. Follow up open questions and ensure appropriate handling of issues with regard to priority and severity
    1. [Agenda document](https://docs.google.com/document/d/1wMokFji42Jw4ImfoiQG6dSkHFIWmLVj5Kz6bO3mF948/edit)
    1. [Infradev board](https://gitlab.com/groups/gitlab-org/-/boards/1193197?label_name%5B%5D=infradev)
1. [Performance refinement](/handbook/engineering/workflow/#performance-refinement)
    1. Follow up open questions and ensure appropriate handling of issues with regard to priority and severity
    1. [Agenda document](https://docs.google.com/document/d/1icG6yrW2oebXz8iXvgfM5JjtMqpsDBCn1v3_VO2ghS0/edit#)
    1. [Performance board](https://gitlab.com/groups/gitlab-org/-/boards/1233204)
1. [Infrastructure Development Escalations](/handbook/engineering/workflow/#infradev)
    1. Triage new issues, enhance Issue details and ensure appropriate handling based on priority and severity
    1. Sync discussions for infradev Issues are part of the [GitLab SaaS Weekly Meeting](/handbook/engineering/infrastructure/#gitlab-saas-infrastructure)
    1. [Agenda document](https://docs.google.com/document/d/1fLQQBKt0mShmTk_mJ-BmBM6OFjal63-AH7yKSbMg6_s/edit#)
    1. [Infradev board](https://gitlab.com/groups/gitlab-org/-/boards/1193197?label_name%5B%5D=infradev)
1. Holiday Emergency Contact Rotations
1. [Review and approve security approvals](https://gitlab.com/gitlab-com/www-gitlab-com/-/issues/12296) for the GitLab project when required and informing the security engineering team when a security risk is accepted rather than being resolved prior to approval.

### Ownership of Shared Services and Components

The GitLab application is built on top of many shared services and components, such as PostgreSQL database, Redis, Sidekiq, Prometheus and so on. These services are tightly woven into each feature's rails code base. Very often, there is need to identify the DRI when demand arises, be it feature request, incident escalation, technical debt, or bug fixes. Below is a guide to help people quickly locate the best parties who may assist on the subject matter.

#### Ownership Models

There are a few available models to choose from so that the flexibility is maximized to streamline what works best for a specific shared service and component.

1. Centralized with Specific Team
    1. A single group owns the backlog of a specific shared service including new feature requests, bug fixes, and technical debt. There may or may not be a counterpart Product Manager.
    1. The single group is a specific team, meaning there is an engineering manager and all domain owner individuals reside in this team. The DRI is the engineering manager.
    1. This single group is expected to collaborate closely and regularly in grooming and planning backlog.
    1. This model may require consensus from the Product Management counterpart.
    1. This model may fit a subject domain that experiences active development.
1. Centralized with Virtual Team
    1. A single group owns the backlog of a specific shared service including new feature requests, bug fixes, and technical debt. There may or may not be a counterpart Product Manager.
    1. The single group is a virtual team, meaning it consists of engineers from various engineering teams, for example maintainers or subject matter experts. Typically there isn't an engineering manager for this virtual team. The DRI is an appointed person in the group who may not necessarily be an engineering manager.
    1. This single group is expected to collaborate closely and regularly in refining and planning backlog.
    1. This model may fit a subject domain that's in maintenance mode.
1. Collectives
    1. Collectives consist of individuals from existing teams who voluntarily rally around a shared interest or responsibility, but unlike Working Groups may exist in perpetuity. The shared interest could be a specific technology or system. Collective members feel a collective responsibility to weakly own, improve upon or otherwise steer the subject they govern.
    1. This is a weaker form of the Virtual Team but introduces more structure than a fully decentralized model. It can be appropriate when some form of ownership is desirable where the subject has cross-cutting impact and wide reach and cannot clearly be allocated to any specific team.
    1. Collectives do not have product or engineering managers, they are fully self-governed.
    1. Members of the Collective sync regularly and keep each other informed about the shared interest. Problem areas are identified and formalized in the Collective, but are not logged into a Collective backlog. Instead a DRI is assigned who should put the task forward to the team with the greatest need for the problem to be resolved. This is to ensure that work is distributed fairly and that there are no two backlogs that compete with each other for priorities.
    1. Collectives work best when they consist of a diverse set of individuals from different areas of product and engineering. They double as knowledge sharing hubs where information is exchanged from across teams in the Collective first, and then carried back by the individuals to their specific teams.
1. Decentralized
    1. The team who implements specific functions or utilizes certain features of the shared services is responsible for their changes from local development environment to production deployment to continued maintenance post-deployment. There is not a development-wide single DRI who owns a portion or the entirety of a shared service.
    1. A specialty team may exist for specific subject domains, however their role is to enable scalability, availability, and performance by building a solid foundation and great tools for testing and troubleshooting for other engineering teams, while they are not responsible for gating every single change in the subject domain.

#### Shared Services and Components

The shared services and components below are extracted from the GitLab [product documentation](https://docs.gitlab.com/ee/development/architecture.html).

| Service or Component | Sub-Component | Ownership Model | DRI (Centralized Only) | Ownership Group (Centralized Only) | Additional Notes |
| -------------------- | ------------- | --------------- | ---------------------- | ---------------------------------- | ---------------- |
| Alertmanager |  | Centralized with Specific Team | @twk3 | [Distribution](/handbook/engineering/infrastructure-platforms/gitlab-delivery/distribution/) | Distribution team is responsible for packaging and upgrading versions. Functional issues can be directed to the vendor. |
| Certmanager |  | Centralized with Specific Team | @twk3 | [Distribution](/handbook/engineering/infrastructure-platforms/gitlab-delivery/distribution/) | Distribution team is responsible for packaging and upgrading versions. Functional issues can be directed to the vendor. |
| Consul |  |  |  |  |  |
| Container Registry |  | Centralized with Specific Team | | Package |  |
| Email - Inbound |  |  |  |  |  |
| Email - Outbound |  |  |  |  |  |
| Elasticsearch | | Centralized with Specific Team | @changzhengliu | Global Search | |
| GitLab K8S Agent |  | Centralized with Specific Team | @nicholasklick | Configure |  |
| GitLab Pages |  | Centralized with Specific Team | @vshushlin | [Knowledge](/handbook/engineering/devops/dev/plan/knowledge/) |  |
| GitLab Rails |  | Decentralized |  |  | DRI for each controller is determined by the feature category specified in the class. [app/controllers](https://gitlab.com/gitlab-org/gitlab/-/tree/master/app/controllers) and [ee/app/controllers](https://gitlab.com/gitlab-org/gitlab/-/tree/master/ee/app/controllers) |
| GitLab Shell |  | Centralized with Specific Team | @andr3 | [Create:Source Code](/handbook/engineering/devops/dev/create/source-code/backend/) | [Reference](/handbook/product/categories/#source-code-group-1) |
| HAproxy |  | Centralized with Specific Team |  | [Infrastructure](/handbook/engineering/infrastructure-platforms/production-engineering/foundations/) |  |
| Jaeger |  | Centralized with Specific Team | @dawsmith | Infrastructure:Observability | Observability team made the [initial implementation/deployment](https://gitlab.com/groups/gitlab-com/gl-infra/-/epics/210). |
| LFS |  | Centralized with Specific Team | @andr3 | [Create:Source Code](/handbook/engineering/devops/dev/create/source-code/backend/) |  |
| Logrotate |  | Centralized with Specific Team | @plu8  | [Distribution](/handbook/engineering/infrastructure-platforms/gitlab-delivery/distribution/) | Distribution team is responsible for packaging and upgrading versions. Functional issues can be directed to the vendor. |
| Mattermost |  | Centralized with Specific Team | @plu8  | [Distribution](/handbook/engineering/infrastructure-platforms/gitlab-delivery/distribution/) | Distribution team is responsible for packaging and upgrading versions. Functional issues can be directed to the vendor. |
| MinIO |  | Decentralized |  |  | Some issues can be broken down into group-specific issues. Some issues may need more work identifying user or developer impact in order to find a DRI. |
| NGINX |  | Centralized with Specific Team | @plu8  | [Distribution](/handbook/engineering/infrastructure-platforms/gitlab-delivery/distribution/) |  |
| Object Storage |  | Centralized with Specific Team |  @lmcandrew | [Scalability::Frameworks](/handbook/engineering/infrastructure/team/scalability/) |  |
| Patroni | General except Geo secondary clusters | Centralized with Specific Team | @plu8  | [Distribution](/handbook/engineering/infrastructure-platforms/gitlab-delivery/distribution/) |  |
|  | Geo secondary standby clusters | Centralized with Specific Team | @luciezhao | [Geo](/handbook/engineering/infrastructure-platforms/tenant-scale/geo/) |  |
| PgBouncer |  | Centralized with Specific Team | @plu8  | [Distribution](/handbook/engineering/infrastructure-platforms/gitlab-delivery/distribution/) |  |
| PostgreSQL | PostgreSQL Framework and Tooling | Centralized with Specific Team | @alexives | [Database](/handbook/engineering/infrastructure-platforms/data-access/database-framework/) | Specific to the development portion of PostgreSQL, such as the fundamental architecture, testing utilities, and other productivity tooling |
|  | GitLab Product Features | Decentralized |  |  | Examples like feature specific schema changes and/or performance tuning, etc. |
| Prometheus |  | Decentralized |  |  | Each group maintains their own metrics.  |
| Puma |  | Centralized with Specific Team | @pjphillips | [Cloud Connector](/handbook/engineering/infrastructure/team/cloud-connector/) |  |
| Redis |  | Decentralized |  |  | DRI is similar to Sidekiq which is determined by the feature category specified in the class. [app/workers](https://gitlab.com/gitlab-org/gitlab/-/tree/master/app/workers) and [ee/app/workers](https://gitlab.com/gitlab-org/gitlab/-/tree/master/ee/app/workers) |
| Sentry |  | Decentralized |  |  | DRI is similar to GitLab Rails which is determined by the feature category specified in the class. [app/controllers](https://gitlab.com/gitlab-org/gitlab/-/tree/master/app/controllers) and [ee/app/controllers](https://gitlab.com/gitlab-org/gitlab/-/tree/master/ee/app/controllers) |
| Sidekiq |  | Decentralized |  |  | DRI for each worker is determined by the feature category specified in the class. [app/workers](https://gitlab.com/gitlab-org/gitlab/-/tree/master/app/workers) and [ee/app/workers](https://gitlab.com/gitlab-org/gitlab/-/tree/master/ee/app/workers) |
| Workhorse |  | Centralized with Specific Team | @andr3 | [Create:Source Code](/handbook/engineering/devops/dev/create/source-code/backend/) |  |

## Learning Resources

For a list of resources and information on our GitLab Learn channel for DevOps, consult [this page](/handbook/engineering/development/training/).

### Global Prioritization

Execution of a Global prioritization can take many forms.  This is worked with both Product and Engineering Leadership engaged.  Either party can activate a proposal in this area.  The options available and when to use them are the following:

- [Rapid action](/handbook/product/product-processes/#rapid-action) - use when reassignment isn't necessary, the epic can have several issues assigned to multiple teams
- [Borrow](/handbook/product/product-processes/#borrow) - use when a temporary assignment to a team is required to help resolve an issue/epic
- [Realignment](/handbook/people-group/promotions-transfers/#realignment-of-team-members-impacting-multiple-teams) - use when a permanent assignment to a team is required to resolve ongoing challenges

### Email alias and roll-up

1. Available email alias (a.k.a. Google group):
Managers, Directors, VP's teams: each alias includes everyone in the respective organization.
1. Naming convention:
team@gitlab.com, examples below -
    - Managers: configure-be@gitlab.com includes all the engineers reporting to the Configure backend engineering manager.
    - Directors: ops-section@gitlab.com includes all the engineers and managers reporting to the director of engineering, Ops.
    - VP of Development: development@gitlab.com includes all engineers, managers, and directors reporting to the VP of Development.
1. Roll up:
Teams roll up by the org chart hierarchy -
    - Engineering managers' aliases are included in respective Sub-department aliases
    - Sub-department aliases are included in Development alias

### Working with Support

When DevOps collaborates with Support it provides invaluable insight into how customers are using the product and the challenges they run into. A few tips to make the process efficient:

- Get [access to Zendesk](/handbook/support/internal-support/#requesting-a-zendesk-light-agent-account) so you view the question and communication from customers.
- Always write answers in a way that they can be "cut-and-pasted" and sent to a customer.
- Reference documentation in your responses and make updates to GitLab documentation when needed.
- Refer to existing issues and epics to reiterate our transparency value and to invite participation from the customer.
- If you are unclear about the support-development collaboration process or workflow then please refer to the handbook page [how to use gitlab.com to request help from the GitLab development team](/handbook/support/workflows/how-to-get-help/#how-to-use-gitlabcom-to-formally-request-help-from-the-gitlab-development-team)

### Incident Management

Team members in [some job families](/handbook/engineering/infrastructure/incident-management/incident-manager-onboarding/#introduction) contribute to incident management directly through an on-call schedule for Incident Managers.
Team members should [complete onboarding](/handbook/engineering/infrastructure/incident-management/incident-manager-onboarding/#how-does-someone-onboard-into-the-incident-manager-rotation) so they can be added to the schedule when needed.
These [frequently asked questions](/handbook/engineering/infrastructure/incident-management/incident-manager-onboarding/#frequently-asked-questions) cover exemptions and changing shifts.

- [Incident Management](/handbook/engineering/infrastructure/incident-management/) process
- [Incident Manager On Call onboarding](/handbook/engineering/infrastructure/incident-management/incident-manager-onboarding/)

### DevOps Escalation Process

- [General information](processes/Infra-Dev-Escalation/)
- [Process outline](processes/Infra-Dev-Escalation/process.html)

### Reducing the impact of far-reaching work

Because our teams are working in separate groups within a single application, there is a high potential for our changes to impact other groups or the application as a whole.  We have to be cautious not to inadvertently impact overall system quality but also availability, reliability, performance, and security.

An example would be a change to user authentication or login, which might impact seemingly unrelated services, such as project management or viewing an issue.

Far-reaching work is work that has wide-ranging, diffuse implications, and includes changes to areas which will:

1. be utilized by a high percentage of users
1. impact entire services
1. touch multiple areas of the application
1. potentially have legal, security, or compliance consequences
1. potentially impact revenue

If your group, product area, feature, or merge request fits within one of the descriptions above, you must seek to understand your impact and how to reduce it. When releasing far-reaching work, use a [rollout plan](/handbook/engineering/development/processes/rollout-plans). You might additionally need to consider creating a one-off process for those types of changes, such as:

- [Creating a rollout plan procedure](/handbook/engineering/development/processes/rollout-plans)
  - Consider how to reduce the risk in your rollout plan
  - Document how to monitor the rollout while in progress
  - Describe the metrics you will use to determine the success of the rollout
  - Account for different states of data during rollout, such as cached data or data that was in a previously valid state
- Requiring feature flag usage ([example](https://gitlab.com/gitlab-com/www-gitlab-com/-/merge_requests/88298))
- Changing a recommended process to a required process for this change, such as a domain expert review
- Requesting manual testing of the work before approval

#### Identified areas

Some areas have already been identified that meet the definition above, and may consider altered approaches in their work:

| Area             | Reason                      | Special workflows (if any)                                                                                            |
| ---------------- | --------------------------- |-----------------------------------------------------------------------------------------------------------------------|
| Database migrations, tooling, complex queries, metrics | impact to entire application<br/><br/>The database is a critical component where any severe degradation or outage leads to an S1 incident. | [Documentation](https://docs.gitlab.com/ee/development/database_review.html#general-process)                          |
| Sidekiq changes (adding or removing workers, renaming queues, changing arguments, changing profile of work required)  | impact to multiple services<br/><br/>Sidekiq shards run groups of workers based on their profile of work, eg memory-bound. If a worker fails poorly, it has the potential to halt all work on that shard. | [Documentation](https://docs.gitlab.com/ee/development/sidekiq/compatibility_across_updates.html) |
| Redis changes    | impact to multiple services<br/><br/>Redis instances are responsible for sets of data that are not grouped by feature category. If one set of data is misconfigured, that Redis instance may fail.  |                                                                                                                       |
| Package product areas            | high percentage of traffic share |                                                                                                                       |
| Gitaly product areas             | high percentage of traffic share |                                                                                                                       |
| [Create: Source Code product areas](/handbook/product/categories/features/#createsource-code-group) | high percentage of traffic share. Special attention should be paid to Protected Branches, CODEOWNERS, MR Approvals, Git LFS, Workhorse and the git over SSH / gitlab-sshd interfaces. Please contact the EM (@sean_carroll) or PM (@tlinz) if you are unsure. | |
| Pipeline Execution product areas | high percentage of traffic share  | [Documentation](https://docs.gitlab.com/ee/development/contributing/verify/)                                          |
| Authentication and Authorization product areas    | touch multiple areas of the application    | [Documentation](/handbook/engineering/development/sec/software-supply-chain-security/authorization/#code-review)            |
| Compliance product areas | potentially have legal, security, or compliance consequences | [Code Review Documentation](/handbook/engineering/development/sec/software-supply-chain-security/compliance/#code-review)                     |
| Workspace product areas    | touch multiple areas of the application    | [Documentation](/handbook/engineering/architecture/design-documents/workspaces/)                                   |
| [Specific fulfillment product areas](/handbook/engineering/development/fulfillment/#revenue-impacting-changes) | potentially impact revenue |                                                                                                                       |
| Runtime language updates | impacts to multiple services | [Ruby Upgrade Guidelines](https://docs.gitlab.com/ee/development/ruby_upgrade.html#ruby-upgrade-guidelines)           |
| Application framework updates | impacts to multiple services | [Rails Upgrade Guidelines](https://docs.gitlab.com/ee/development/rails_update.html)                                  |
| Navigation | impact to entire application | [Proposing a change that impacts navigation](/handbook/product/ux/navigation)                  |

## Customer Account Escalation coordination

If development is the DRI or actively participating in a [Customer Account Escalation](/handbook/customer-success/csm/escalations/), consider the following:

- Be careful to not make commitments to customers without first talking to product management and development leaders to confirm the impact that commitment may have on other commitments.
- The customer will want to know when they can see the benefits of a change. They may not be familiar with GitLab practices for tracking and predicting due dates and milestones. Also, they may not be familiar with our workflows and associated labels nor the predictability of code review timelines, different timelines on releases to GitLab.com compared with releases for self-hosted customers and our use of feature flags.

```markdown
* Customers often don't rely on asynchronous communication at the level that GitLab does. Educate the customer on our practices and adapt to find a combined asynchronous and synchronous communication method and cadence that works for everyone.
* Encourage customers to collaborate with us in epics, issues, and merge requests of interest. Keep in mind that they may not have access to ones that are confidential and/or may not be comfortable or able to collaborate with us in this public forum.
* Consider utilizing Google documents to collaborate with the customer as a backup for collaboration via epics, issues, and merge requests.
* Consider utilizing a shared Slack channel to collaborate, adding the customers to our slack via "one Slack channel access requests".  [Example](https://gitlab.com/gitlab-com/team-member-epics/access-requests/-/issues/16192)
* In meetings, tell customers why we like to record them and ask if they are OK with doing so. Consider using [Chorus](/handbook/sales/field-operations/sales-operations/go-to-market/chorus/) for scheduling the recordings to address legal requirements for recording meetings with customers.
* In meetings, tell customers why we take notes before, during, and after the meeting, as it may not be natural for them to collaborate in this way.
* Make sure the appropriate priority label is applied to all issues being tracked by the customer.
* In the agenda for recurring meetings, track the items tracked by the customer in priority order at the top and review the status, next steps, customer DRI, and GitLab DRI for each.  Discuss in the meeting periodically.
Remind GitLab team members in Slack to update the status of items they are the DRI for before recurring meetings.
* Post a link to the meeting notes and recording in a Slack channel for the customer escalation, so those who did not attend know that the notes and recording are available for review.
* When there is an action item for someone in a meeting (whether they are present or not), tag them in an issue or MR (or in Slack) so they will see it.

