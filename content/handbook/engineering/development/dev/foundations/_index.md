---
title: Foundations Stage
description: The responsibilities of this stage are described by the [Foundations product category](/handbook/product/categories/#foundations-stage). Foundations is [made up of multiple groups](/handbook/product/categories/#core-platform-section), each with their own features and areas of responsibility, noted last on this page.
---

## Core Focuses

- Elevate all features to enterprise-grade quality through consistent design system adoption, rigorous cross-deployment testing, and maintaining the reliability standards necessary to fulfill our 99.9% SLA commitments.
- Create a seamless, scalable migration experience for enterprises by optimizing migration pathways (speed, friction), providing clear visibility into migration progress, and reducing manual intervention requirements.
- Drive operational excellence by optimizing developer workflows, analyzing maintenance burdens, and continuously improving development processes to deliver maximum value with the most efficiency.

### Key Priorities (In Order)

1. Enterprise-grade completeness 
1. Design System Adoption
1. Personalized Homepage
1. Efficiency in migrations

### Areas of opportunity

- Experience features as Professional Services, the Dedicated team, or customers do to close quality gaps
- Track user adoption and usage to understand maintenance burden or high priority areas to address
- Identify components that aren't using the standard Design System and prioritize updates
- Maintain a [4-quarter technical roadmap](https://data-science-foundations-roadmap-e4062b.gitlab.io/stages/foundations) that anticipates future scale needs
- 
- 
- 
- 

### User Journeys

- **Critical to Homepage and Navigation:**
  - User needs to quickly resume work across multiple projects or groups
  - User wants to see all their active work items in one place without navigating through multiple pages

- **Critical to Import & Integrate:**
  - Large-Scale Enterprise needs to migrate multiple projects/groups from another platform (GitHub, Bitbucket) or GitLab instance
  - Enterprise team member wants to perform migrations at scale with minimal manual intervention
  - Enterprise team member requires visibility into migration progress and success/failure status
  - Enterprise team member wants to map contributors from source system to appropriate users in destination system

- **Critical to Personal Productivity:**
  - User needs to identify and prioritize items requiring immediate attention

- **Personal Productivity:**
  - User needs to process multiple notifications efficiently without switching contexts
  - User wants to reduce the "noise" by pruning unnecessary notifications
  - User needs to control which events generate notifications

- **Critical to Design System:**
  - User needs a consistent and accessible user experience
  - Designer needs to efficiently implement interfaces and support multiple color modes with components and design tokens
  - Developer needs to efficiently implement interfaces and support multiple color modes with components and utility classes
  - Maintainer needs to ensure quality of interfaces through compliance with design system

### Standards of Quality and Completeness

- Systems must meet enterprise SLA expectations for availability and performance as measured by [99.9% Error Budget](#metrics)
- Features should work consistently across all deployment types (SaaS, Self-hosted, Dedicated)
- All new and existing features should follow the [GitLab Design System](https://design.gitlab.com/)
- Instrumentation should be standardized for aggregation with metrics
- Removing areas of technical burden / maintenance
- Optimizing areas of high impact

## OKRs

For a list of active OKRs, [check the OKR project](https://gitlab.com/gitlab-com/gitlab-OKRs/-/issues/?sort=created_date&state=opened&label_name%5B%5D=devops%3A%3Afoundations&milestone_title=Started&first_page_size=50).

## Direction

The direction and strategy for Foundations is documented on [https://about.gitlab.com/direction/foundations/](https://about.gitlab.com/direction/foundations/). This page (and the category direction
pages under the "Categories" header) is the single source of truth on where we're going and why.

- Direction pages should be reviewed regularly by Product. When updating these pages, please CC the relevant group to keep your teammates informed.
- Product should make sure that their groups understand the direction and have an opportunity to contribute to it. Consider a monthly direction AMA for your group to field questions.

## Career Development

{{% include "includes/engineering/foundations-data-science-shared/career-development.md" %}}

## Team Days

{{% include "includes/engineering/foundations-data-science-shared/team-day.md" %}}

## Meetings

Although we have a bias for asynchronous communication, synchronous meetings are necessary and should adhere to our [communication guidelines](/handbook/communication/#video-calls). Some regular meetings that take place are:

| **Meeting (Internal Only, limited access)** | **Frequency** | **DRI**         | **Topics**                                                                                                                                                                                                           |
|---------------------------------------------|---------------|------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| [SaaS Availability](/handbook/engineering/#saas-availability-weekly-standup)                            | Weekly        | Infrastructure  | Incident corrective actions, Feature Change Lock status, Past Due Infradev, Error Budget, or Security updates                                                                                                        |
| [Engineering Stage Review](https://docs.google.com/document/d/1wo3mQaO-vUo9NCyuCIJYHGcYFgdhoQUYRlgAj-5X7PI/edit?tab=t.0#heading=h.954v91mukl7r) [Handbook](#stage-reviews)                    | Monthly       | Michelle Gill   | Productivity metrics, Technical Roadmap updates                                                                                                                                                                      |
| [Foundations and Data Science EM Meeting](https://docs.google.com/document/d/1ZcKI1ZxrGTg8qdnKpnzrdLFd3foFOcwUtn5VjqLCRcQ/edit?tab=t.0#heading=h.t57w20kzngmo)     | Biweekly      | Michelle Gill   | Standards discussions, questions, help needed, FYIs, process improvements, collaborating on engineering stage direction, team event planning, leadership communication dissemination, wider initiative brainstorming, OKRs |
| [Core Development Staff Meeting](https://docs.google.com/document/d/1fx6Indy9rDX9-btjRvElRwgidP3rSzzVrK8QwDvSpDk/edit?tab=t.0#heading=h.ky78crs5w5jj)              | Biweekly      | Tim Zallmann    | Recurring staff meeting for updates across engineering management within Tim's organization |

For one-off, topic specific meetings, please always consider recording these calls and sharing them (or taking notes in an internally available document.

Agenda documents and recordings can be placed in the [shared Google drive](https://drive.google.com/drive/u/0/folders/0ALpc3GhrDkKwUk9PVA) (internal only) as a single source of truth.

All meetings should have an agenda prepared at least 12 hours in advance. If this is not the case, you are not obligated to attend the meeting. Consider meetings canceled if they do not have an agenda by the start time of the meeting.

### Stage Reviews

{{% include "includes/engineering/foundations-data-science-shared/stage-review.md" %}}

## Shared calendars

1. Foundations: Important Dates - Use this calendar for stage-wide reminders (OKR due dates, promotion cycles, talent assessment timelines, regular holiday preparations). To add this calendar to your Google Calendar, use this calendar ID `c_kvfbp2t8edtgm4rjialus0834g@group.calendar.google.com`.
1. Foundations Shared - Use this calendar for recurring group level reminders and meetings (Release kickoff, milestone planning, social calls). To add this calendar to your Google Calendar, use this calendar ID `gitlab.com_k9f27ijja1hj176oncn1e8qqvk@group.calendar.google.com`.

## Skip Levels

{{% include "includes/engineering/foundations-data-science-shared/skip-levels.md" %}}

## Metrics

{{% include "includes/engineering/foundations-data-science-shared/metrics.md" %}}

### Development

{{< tableau height="600px" toolbar="hidden" src="https://us-west-2b.online.tableau.com/t/gitlabpublic/views/TopEngineeringMetrics/TopEngineeringMetricsDashboard" >}}
  {{< tableau/filters "STAGE_LABEL"="foundations" >}}
{{< /tableau >}}

{{< tableau height="600px" src="https://us-west-2b.online.tableau.com/t/gitlabpublic/views/MergeRequestMetrics/OverallMRsbyType_1" >}}
  {{< tableau/filters "STAGE_LABEL"="foundations" >}}
{{< /tableau >}}

### Say/Do Ratio

{{% include "includes/engineering/foundations-data-science-shared/say-do-ratio.md" %}}

## Links and resources

{{% include "includes/engineering/foundations/shared-links.md" %}}
{{% include "includes/engineering/foundations-data-science-shared/shared-links.md" %}}
