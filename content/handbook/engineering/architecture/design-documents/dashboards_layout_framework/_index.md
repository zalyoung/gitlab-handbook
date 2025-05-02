---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Dashboards framework
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

However, at GitLab, our dashboards have always been inherently feature-focused, without any unifying vision
or clear guidance on _how_ to build a dashboard. We don't have clear guidance for meeting the needs of our
customers, or clear UX and behavioral guidelines to make sure our customers know how to use any dashboard at GitLab.

~"group::platform insights" is working to design, develop, and implement this unified vision for all dashboards
at GitLab. This vision began with the [Dashboards Working Group](../../../../company/working-groups/dashboards.md) and in March 2023 culminated in a
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

With the above goals and motivation in mind, we want to outline a dashboards layout framework that provides the core
functionality, UI, and UX needed to efficiently develop a dashboard within GitLab that adheres to our Pajamas guidelines.
The structure outlined below describes what this will include, and how they will function.

## Design and implementation details

![dashboards_layout_framework_outline](/images/engineering/architecture/design-documents/dashboards_layout_framework/dashboards_layout_framework_outline.png)

### The grid

We must have a grid system that supports a flexible column and row grid. This grid must support items (panels) that
can be resized and repositioned.

The grid itself will support 12 columns, with an unlimited number of rows. Each item (panel) within the grid, can be
up to 12 columns in width. In other words, each row may contain between 1–12 panels. Each panel can span an unlimited
number of rows, although realistically for UX and performance reasons, it would only be a few rows for any given panel.

We will not be setting any limits at this time, so it is possible for someone using the framework to create a panel
that doesn't fit its contents. If this occurs, the panel will provide scrollbars for users to be able to see the content
that doesn't fit.

Our preferred choice for this grid is to use [Gridstack](https://gridstackjs.com/), an open-source MIT licensed library which supports
grid structures, along with the changing and resizing of grid items, in a deterministic, and cross-browser friendly way.

The framework configuration must not tie directly to Gridstack in case we need to move to alternatives in future.
Any grid configuration options to be abstracted to make it easier to migrate if required.

### Panels

[Panels](https://gitlab-org.gitlab.io/gitlab-ui/?path=/docs/dashboards-dashboards-panel--docs) are the wrapping modular container that provides a contextual interface for users to interact with their data.
Each panel may contain:

- A title
- A tooltip for further tertiary information
- A kebab menu of contextual actions
- An indicator for any contextual errors/warnings/info
- A loading state whilst the panel retrieves the visualization data
- The visualization area

Panels handle:

- The retrieval of visualization data
- Selecting the right visualization to be rendered
- Maintaining the current state
- Showing potential error states
- Triggering contextual actions

Each panel can be resized in accordance with [the grid](#the-grid) and are scrollable when the content exceeds the size of the panel.

### Visualizations

Visualizations refer to any component that can render the data from the panel. This component must consume the data from the panel, along with
any visualization options, and output this in an appropriate format for the data provided.

Some common examples include:

- ECharts-based visualizations, using the [GitLab UI implementations](https://gitlab-org.gitlab.io/gitlab-ui/?path=/docs/charts-chart--docs)
- Tables, using [GitLab UI](https://gitlab-org.gitlab.io/gitlab-ui/?path=/docs/base-table-table--docs) (or the lite version)
- Text or markdown-based content

ECharts-based visualizations may contain axis, legends, and other clickable elements depending upon the ECharts implementation.

Table visualizations may contain keyset pagination, sorting, and internal searching.

Visualizations should not be contextually aware, their only job is to render the data provided in the format outlined by
its configuration and component structure. However, for simpler migration, it may be prudent to begin by copying existing visualization components
into the dashboard structure. Although this would contain the data source or API information to begin with, a separate data source
could then be developed for a more integrated drop-in replacement.

### Filters

Although filtering as a concept are still under [heavy UX exploration](https://gitlab.com/gitlab-org/gitlab/-/issues/521751), we can be assured
that there will be two areas where filters can be applied by the user.

The first area is the global filter that is applied to every visualization within the dashboard. This will allow engineers to define the filters
that should show on the dashboard. Each filter will need to be connected to each data source, as each data source will need to process the filter
I/O differently. In the event that a filter does not work with a data source, then the user needs to be notified through the UI.
How this notification looks is still being discussed.
⁠⁠
The second type of filter is a per-panel filter applied to any one individual panel. ⁠At this moment, the dashboard layout framework
only supports global filters. Per-panel filters will also need to be connected to each data source, but since these are a more curated option,
this should be done when visualizations and panels are being developed, so it's less of a concern.

Applying a filter will automatically update all applicable panels, as well as update the URL for users to easily share the dashboard state with others.

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

### Configuration structure

The configuration used to build a dashboard, filter, panel, or visualization must follow the JSON validation schema outlined in either the [dashboard schema](https://gitlab.com/gitlab-org/gitlab/-/blob/master/ee/app/validators/json_schemas/analytics_dashboard.json) or [visualization schema](https://gitlab.com/gitlab-org/gitlab/-/blob/master/ee/app/validators/json_schemas/analytics_visualization.json).

The configuration doesn't need to have come from a JSON file, as long as the structure properties are met. Some examples of where the configuration could be stored:

- A YAML file
- A JSON file
- An API call
- A database table
- A JavaScript object
- Vue component props

The configuration should be validated against the schema before being used.
