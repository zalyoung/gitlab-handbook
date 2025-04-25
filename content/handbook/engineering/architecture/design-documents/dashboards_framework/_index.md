---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Dashboards framework
status: ongoing
creation-date: "2025-04-08"
authors: [ "@rob.hunt", "@jiaan" ]
coaches: [ "@ahegyi" ]
dris: [ "@lfarina8", "@nicholasklick" ]
owning-stage: "~devops::monitor"
participating-stages: [ "~devops::monitor", "~devops::security risk management" ]
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< design-document-header >}}

<!--
Don't add a h1 headline. It'll be added automatically from the title front matter attribute.

For long pages, consider creating a table of contents.
-->

## Summary

Dashboards are at the heart of how our customers interact with their data.
It is the means to which they are able to understand their data and use it to meet their business needs.
However, at GitLab, our dashboards have always been inherently feature-focused, without any unifying vision
or clear guidance on _how_ to build a dashboard that meets the needs of our customers whilst also providing
clear UX and behavioral guidelines to make sure our customers know how to use a dashboard at GitLab, irrespective
of the data they're looking at.

~"group::platform insights" is working to design, develop, and implement this unified vision for all dashboards
at GitLab. This vision began with the [Dashboards Working Group](https://handbook.gitlab.com/handbook/company/working-groups/dashboards/) and in March 2023 cumulated in a
new [Pajamas dashboards pattern](https://design.gitlab.com/patterns/dashboards/). This pattern laid the groundwork for what a dashboard
is at a basic level.

Since then, ~"group::platform insights" have developed an [initial dashboards framework](https://docs.gitlab.com/development/fe_guide/analytics_dashboards/) for the analytics feature space.
Built off the initial work for [Product Analytics](https://docs.gitlab.com/development/internal_analytics/product_analytics/).
The framework has been adopted by ~"group::optimize" for the [Value Stream Dashboard](https://docs.gitlab.com/user/analytics/value_streams_dashboard/)
and [AI Impact Analytics](https://docs.gitlab.com/user/analytics/ai_impact_analytics/),
as well as currently being evaluated for our [Security Dashboards](https://docs.gitlab.com/user/application_security/security_dashboard/).

The next stage of this work is to solidify the foundations of the dashboards framework, align on the UI/UX,
and what features the dashboards framework will support. There must be clear guidance on:

- What a dashboard is and isn't, along with what functionality a dashboard should provide.
- How to use the dashboards framework within existing features and new features.
- What guidelines should be followed when using the dashboards framework.
- How to contribute to the dashboards framework and the wider dashboards UI/UX.

## Motivation

As part of the [Data Unification and Insights effort](https://gitlab.com/gitlab-org/architecture/gitlab-data-analytics/design-doc), we are looking to unify and standardize our data offering
at GitLab. A core part of this work, is aligning our UI/UX to how customers interact with their data and
gain insights on what they can do to meet their business needs. Implementing and adopting a standardized
dashboards framework will go a long way to meeting this need, whilst also giving us the foundation to
augment our existing offering with clearer visuals and AI integration.

### Goals

- Clear guidelines on what a dashboard is, what functionality it contains, and how to use the framework.
- Adopt the dashboards framework across GitLab, especially where data is being used for analysis.
- An agnostic dashboards framework, not tied to any one feature, giving engineers the tools needed to quickly and efficiently set up and use dashboards.
- Link uses of the dashboards framework together in preparation for [dashboards navigation restructuring](https://gitlab.com/groups/gitlab-org/-/epics/16940).

### Non-Goals

- ~"group::platform insights" will not implement every possible piece of functionality, data source, visualization type, or dashboard.
  These will be driven by feature teams, with support from ~"group::platform insights".
- The dashboard layout framework does not include [data exploration](https://gitlab.com/gitlab-org/gitlab/-/issues/536187 outside defined panel visualizations.
- The dashboard layout framework does not include [user-driven customization](https://gitlab.com/gitlab-org/gitlab/-/issues/536610) of dashboards, only the building blocks of the dashboards themselves.

## Proposal

With the above goals and motivation in mind, we want to outline a dashboards layout framework that provides the core
functionality, UI, and UX needed to efficiently develop a dashboard within GitLab that adheres to our Pajamas guidelines.
The structure outlined below describes what this will include, and how they will function.

### Building blocks

![dashboards_layout_framework_outline](/images/engineering/architecture/design-documents/dashboards_layout_framework/dashboards_layout_framework_outline.png)

#### The grid

The grid will be developed using [Gridstack](https://gridstackjs.com/), an open-source MIT licensed library which supports
grid structures, along with the changing and resizing of grid items, in a deterministic, and cross-browser friendly way.

The grid itself will support 12 columns, with an unlimited number of rows. Each item (panel) within the grid, can be
up to 12 columns in width. In other words, each row may contain between 1–12 panels. Each panel can span an unlimited
number of rows, although realistically for UX and performance reasons, it would only be a few rows for any given panel.
We will not be setting any limits at this time though, so it is perfectly possible for someone using the framework to
create a panel that doesn't fit its contents.

#### Panels


#### Visualizations


#### Filters


#### Error handling


#### Data structures


#### Data sources

## Design and implementation details

<!--
This section should contain enough information that the specifics of your
change are understandable. This may include API specs (though not always
required) or even code snippets. If there's any ambiguity about HOW your
proposal will be implemented, this is the place to discuss them.

If you are not sure how many implementation details you should include in the
document, the rule of thumb here is to provide enough context for people to
understand the proposal. As you move forward with the implementation, you may
need to add more implementation details to the document, as those may become
valuable context for important technical decisions made along the way. A
document is also a register of such technical decisions. If a technical
decision requires additional context before it can be made, you probably should
document this context in a document. If it is a small technical decision that
can be made in a merge request by an author and a maintainer, you probably do
not need to document it here. The impact a technical decision will have is
another helpful information - if a technical decision is very impactful,
documenting it, along with associated implementation details, is advisable.

If it's helpful to include workflow diagrams or any other related images.
Diagrams authored in GitLab flavored markdown are preferred. In cases where
that is not feasible, images should be placed under `images/` in the same
directory as the `index.md` for the proposal.
-->

## Alternative Solutions

<!--
It might be a good idea to include a list of alternative solutions or paths considered, although it is not required. Include pros and cons for
each alternative solution/path.

"Do nothing" and its pros and cons could be included in the list too.
-->
