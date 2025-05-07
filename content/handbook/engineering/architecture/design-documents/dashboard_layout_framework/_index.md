---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Dashboard Layout Framework
status: "ongoing"
creation-date: "2025-04-08"
authors: [ "@rob.hunt", "@jiaan" ]
coaches: [ "@ahegyi" ]
dris: [ "@lfarina8", "@nicholasklick" ]
owning-stage: "~devops::analytics"
participating-stages: [ "~devops::analytics", "~devops::security risk management" ]
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< engineering/design-document-header >}}

<!--
Don't add a h1 headline. It'll be added automatically from the title front matter attribute.

For long pages, consider creating a table of contents.
-->

## Summary

Dashboards are at the heart of how our customers interact with their data. It is the means by which they are able to understand their data
and use it to meet their business needs.

However, at GitLab, our dashboards have always been inherently feature-focused, without clear UX guidance or
common UI framework instructing _how_ to build a dashboard. The result is that there is no single Dashboard
experience for across GitLab. The impact of which is that that customers have an inconsistent user experience
and have to learn how to use each dashboard and that and development teams cannot easily exchange or reuse
between existing dashboards resulting in increased development time and maintenance cost.

~"group::platform insights" is working to design, develop, and implement this unified vision for all dashboards
at GitLab. This vision began with the [Dashboards Working Group](../../../../company/working-groups/dashboards.md) and in March 2023 culminated in a
new [Pajamas dashboards pattern](https://design.gitlab.com/patterns/dashboards/). This pattern laid the groundwork for what a dashboard
is at a basic level.

Since then, ~"group::platform insights" have developed an [initial dashboards framework](https://docs.gitlab.com/development/fe_guide/analytics_dashboards/) for the analytics feature space.
This was built off the initial work for [Product Analytics](https://docs.gitlab.com/development/internal_analytics/product_analytics/).
The framework has been adopted by ~"group::optimize" for the [Value Stream Dashboard](https://docs.gitlab.com/user/analytics/value_streams_dashboard/)
and [AI Impact Analytics](https://docs.gitlab.com/user/analytics/ai_impact_analytics/),
as well as currently being developed for our [Security Dashboards](https://docs.gitlab.com/user/application_security/security_dashboard/).

The next stage of this work is to solidify the foundations of the dashboards framework, align on the UI/UX,
and what features the dashboards framework will support. There must be clear guidance on:

- What a dashboard is and isn't, along with what functionality a dashboard should provide.
- How to use the dashboards framework within existing features and new features.
- What guidelines should be followed when using the dashboards framework.
- How to contribute to the dashboards framework and the wider dashboards UI/UX.

## Motivation

As part of the [Data Unification and Insights effort](https://gitlab.com/gitlab-org/architecture/gitlab-data-analytics/design-doc), we are looking to unify and standardize our data offering
at GitLab. A core part of this work is aligning our UI/UX to how customers interact with their data and
gain insights on what they can do to meet their business needs. Implementing and adopting a standardized
dashboards framework will go a long way to meeting this need, whilst also giving us the foundation to
augment our existing offering with clearer visuals and AI integration.

### Goals

- Clear guidelines on what consistutes a dashboard layout , what functionality it contains, and how to use the framework.
- Adopt the dashboards framework across GitLab, especially where data is being used for analysis.
- An agnostic dashboards framework, not tied to any one feature, giving engineers the tools needed to quickly and efficiently set up and use dashboards.
- Link uses of the dashboards framework together in preparation for [dashboards navigation restructuring](https://gitlab.com/groups/gitlab-org/-/epics/16940).

### Non-Goals

- ~"group::platform insights" will not implement every possible piece of functionality, data source, visualization type, or dashboard.
  These will be driven by feature teams, with support from ~"group::platform insights".
- The dashboard layout framework does not include [data exploration](https://gitlab.com/gitlab-org/gitlab/-/issues/536187) outside defined panel visualizations.
- The dashboard layout framework does not include [user-driven customization](https://gitlab.com/gitlab-org/gitlab/-/issues/536610) of dashboards, only the building blocks of the dashboards themselves.
- The dashboard layout framework does not define where the [dashboard should be placed in the navigation](https://gitlab.com/gitlab-org/gitlab/-/issues/536612).

## Proposal

With the above goals and motivation in mind, we want to outline a dashboard layout framework that provides the core
functionality, UI, and UX needed to efficiently develop a dashboard within GitLab that adheres to our Pajamas guidelines.
The structure outlined below describes what this will include, and how they will function.

## Design and implementation details

![dashboard_layout_framework_outline](/images/engineering/architecture/design-documents/dashboard_layout_framework/dashboard_layout_framework_outline.png)

### The grid

In line with our design definition of a [Grid](https://design.gitlab.com/patterns/dashboards/), we require a system
uses rows and columns to snap panels into position. The system should allow panels to be resized and repositioned in a
deterministic and cross-browser friendly way.

The grid itself will support 12 columns, with an unlimited number of rows. Grid panels can be up to 12 columns wide,
allowing 1–12 panels per row. The height of a panel can be between 1 row and unlimited, enabling it to span any number
of rows as needed.

Each panel, within the grid, will have a minimum height of `125px`. This minimum height gives space for padding, the title, and basic content;
whilst not needing a scrollbar to see all the panel contents.

Our preferred choice for this grid is to use [Gridstack](https://gridstackjs.com/), an open-source MIT licensed library which supports
grid structures, along with the changing and resizing of grid items, in a deterministic, and cross-browser friendly way.

The framework configuration must not tie directly to Gridstack in case we need to move to alternatives in future.
Any grid configuration options to be abstracted to make it easier to migrate if required.

### Panels

[Panels](https://gitlab-org.gitlab.io/gitlab-ui/?path=/docs/dashboards-dashboards-panel--docs) are the wrapping modular container that provides a contextual interface for users to interact with their data.
Each panel contains:

- A title
- A tooltip for further tertiary information (optional)
- A kebab menu of contextual actions (optional)
- An indicator for any contextual errors/warnings/info (optional)
- A loading state whilst the panel retrieves the visualization data (optional)
- The visualization area

Panels handle:

- The retrieval of visualization data
- Selecting the right visualization to be rendered
- Maintaining the current state
- Showing potential error states
- Triggering contextual actions

Each panel can be resized in accordance with [the grid](#the-grid) and are scrollable when the content exceeds the size of the panel.

### Visualizations

Visualizations refer to any component that renders a graphical representation of the data. The dashboard layout framework is agnostic
to the content of the visualization, and how the visualization retrieves and processes the data.

Some common examples include:

- ECharts-based visualizations, using the [GitLab UI implementations](https://gitlab-org.gitlab.io/gitlab-ui/?path=/docs/charts-chart--docs)
  - Visualizations may contain axis, legends, and other clickable elements depending upon the ECharts implementation.
- Tables, using [GitLab UI](https://gitlab-org.gitlab.io/gitlab-ui/?path=/docs/base-table-table--docs) (or the lite version)
  - Visualizations may contain keyset pagination, sorting, and internal searching.
- Text or markdown-based content.

### Filters

Although filtering as a concept is still under [heavy UX exploration](https://gitlab.com/gitlab-org/gitlab/-/issues/521751), we can be assured
that there will be two slots where filters can be added to the dashboard layout, and used by the user.

The first slot is the global filter that is applied to every visualization within the dashboard. This will allow engineers to define the filters
that should show on the dashboard. It is up to the engineer to make sure that filters are applied appropriately to their visualizations.
In the event that a filter does not work with a visualization, then the user needs to be notified through the UI. How this notification looks
is still being discussed.
⁠⁠
The second type of filter is a per-panel filter applied to any one individual panel. ⁠At this moment, the dashboard layout framework
only supports global filters. Per-panel filters will also need to be connected to the visualization by the engineer.

Applying a filter will automatically send all applied filters to every applicable panel and visualization. For instances where filters need
to be synced to the URL, engineers can make use of the [`UrlSync` component](https://gitlab.com/gitlab-org/gitlab/blob/master/app/assets/javascripts/vue_shared/components/url_sync.vue).

For engineers developing panels, there is also scope to pre-apply filters to a panel, and then either allow these to be changed by the user or for them
to be restricted to only those values. If a panel is "locked" to a particular filter value, for instance, a panel which can only show a visualization of
data over the past 24 hours, the panel will visually indicate to the user that it is "locked" and explain what is restricted.

### Error handling

In the event of an error, the UI should handle these and explain to the user how they can fix the error, or at the very least, why it has failed.
When possible, errors should provide a retry button, or another next-step for users.

Page-level errors should use the [Pajama's alert component](https://design.gitlab.com/components/alert).

The errors should be located where the error occurred:

- Entire dashboard - replace dashboard grid with the error message.
- Global filters - show above the global filters unless the filter selection causes a
specific error for a panel, in which case the error will appear within the panel error state.

For per-panel filters and panel-specific errors, we should use the panel error state. The panel error state will:

- Highlight the panel has an error through color and iconography.
- Have a tooltip explaining the error in detail, and what the user can do, with a retry button where applicable.
- Replace the panel content with a contextual error message.

## Migration strategies

We need to consider how to migrate existing dashboard implementations. These dashboards are already solving a need
for users, even if some may have been identified as areas we could improve or provide more value.

We aim in the longer-term for all data-driven dashboards at GitLab to be fully integrated into the dashboard layout
framework. However, this can be a gradual process based upon team capacity and user requirements.
Even more so, as this will require the page to use Vue for rendering, and not every page at GitLab does.

Any migration strategy should have the user requirements, seamless migration, and quality at its heart.

### Replacing everything

In the event that a dashboard isn't meeting our users' needs, or is already scheduled for a revamp, it may be most
prudent to go straight to replacing the existing dashboard with the dashboard layout framework.

This would entail:

- Building visualizations for the data being viewed
- Using the dashboard layout framework to design and build the dashboard
- Adding existing filters or creating new filter types

Oftentimes, dashboards are also migrated to a new location within the navigation at the same time.

The development and swapping over can be managed using feature flags.

### Replacing the dashboard layout

If the visualizations on an existing dashboard are already meeting the needs of users, then it may be expedient
to upgrade the dashboard page itself to make use of the dashboard layout framework.

This would mean keeping the existing visualizations, but integrating them into the wider framework structure.
Therefore, replacing the existing dashboard page layout.

This would entail:

- Replacing the dashboard page layout with the dashboard layout framework
- Replacing the existing dashboard blocks with [panels](https://gitlab-org.gitlab.io/gitlab-ui/?path=/docs/dashboards-dashboards-panel--docs)
- Adding the existing visualizations to panels
- Adding existing filters or creating new filters types that can interact with the existing visualizations

### Replacing the panels

If the layout of the dashboard page isn't a concern, then we can keep the existing layout as-is and replace
the dashboard blocks themselves with [panels](https://gitlab-org.gitlab.io/gitlab-ui/?path=/docs/dashboards-dashboards-panel--docs).

This could also include updating the visualizations at the same time, but it isn't entirely necessary.

This would entail:

- Replacing the existing dashboard blocks with [panels](https://gitlab-org.gitlab.io/gitlab-ui/?path=/docs/dashboards-dashboards-panel--docs)
- Adding the existing visualizations to panels, or creating new visualizations
- Integrating any existing filters with the panels
