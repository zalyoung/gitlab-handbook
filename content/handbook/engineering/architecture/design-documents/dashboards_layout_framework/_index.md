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
owning-stage: "~devops::analytics"
participating-stages: [ "~devops::analytics", "~devops::security risk management" ]
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
at GitLab. This vision began with the [Dashboards Working Group](../../../../company/working-groups/dashboards.md) and in March 2023 cumulated in a
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
- The dashboard layout framework does not include [data exploration](https://gitlab.com/gitlab-org/gitlab/-/issues/536187) outside defined panel visualizations.
- The dashboard layout framework does not include [user-driven customization](https://gitlab.com/gitlab-org/gitlab/-/issues/536610) of dashboards, only the building blocks of the dashboards themselves.

## Proposal

With the above goals and motivation in mind, we want to outline a dashboards layout framework that provides the core
functionality, UI, and UX needed to efficiently develop a dashboard within GitLab that adheres to our Pajamas guidelines.
The structure outlined below describes what this will include, and how they will function.

## Design and implementation details

![dashboards_layout_framework_outline](/images/engineering/architecture/design-documents/dashboards_layout_framework/dashboards_layout_framework_outline.png)

### The grid

The grid is developed using [Gridstack](https://gridstackjs.com/), an open-source MIT licensed library which supports
grid structures, along with the changing and resizing of grid items, in a deterministic, and cross-browser friendly way.

The grid itself will support 12 columns, with an unlimited number of rows. Each item (panel) within the grid, can be
up to 12 columns in width. In other words, each row may contain between 1–12 panels. Each panel can span an unlimited
number of rows, although realistically for UX and performance reasons, it would only be a few rows for any given panel.
We will not be setting any limits at this time, so it is possible for someone using the framework to create a panel
that doesn't fit its contents.

### Panels

Panels are the wrapping modular container that provides a contextual interface for users to interact with their data.
Each panel may contain:

- A title
- A tooltip for further tertiary information
- A kebab menu of contextual actions
- An indicator for any contextual errors/warnings/info
- The visualization area

Panels handle:

- The retrieval of visualization data
- Selecting the right visualization to be rendered
- Maintaining the current state
- Showing potential error states
- Triggering contextual actions

Each panel can be resized in accordance with [the grid](#the-grid).

### Visualizations

Generally, visualizations can be one of three types:

- ECharts-based visualizations, using the [GitLab UI implementations](https://gitlab-org.gitlab.io/gitlab-ui/?path=/docs/charts-chart--docs)
- Tables, using [GitLab UI](https://gitlab-org.gitlab.io/gitlab-ui/?path=/docs/base-table-table--docs) (or the lite version)
- Text or markdown-based content

Table visualizations may contain keyset pagination, sorting, and internal searching.

Visualizations should not be contextually aware, their only job is to render the data provided in the format outlined by
it's configuration and component structure. However, for simpler migration, it may be prudent to begin by copying existing visualization components
into the dashboard structure. Although this would contain the data source or API information to begin with, a separate [data source](#data-sources)
could then be developed for a more integrated drop-in replacement.

### Filters

There are two areas where filters can be applied. The first area is the global filter that is applied to every visualization within the dashboard.
This will allow you to define the filters that should show on the dashboard either by using a pre-existing filter from the suite of filters that
have already been developed or by making your own. Each filter will need to be connected to each data source, as each data source will need to
process the filter I/O differently. In the event that a filter does not work with a data source, then the user needs to be notified through the UI.
How this notification looks is still being discussed.
⁠⁠
The second type of filter is a per-panel filter applied to any one individual panel. ⁠At this moment, the dashboard layout framework
only supports global filters. Per-panel filters will also need to be connected to each data source, but since these are a more curated option,
this should be done when visualizations and panels are being developed, so it's less of a concern.

Applying a filter will automatically update all applicable panels, as well as update the URL for users to easily share the dashboard state with others.

### Error handling

In the event of an error, the UI should handle these and explain to the user how they can fix the error, or at the very least, why it has failed.
When possible, errors should provide a retry button, or another next-step for users.

Page-level errors should use the [Pajama's alert component](https://design.gitlab.com/components/alert).

The errors should be located where the error occurred:

- Entire dashboard - replace dashboard grid with the error message.
- Global filters - show above the global filters.

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

### Data sources

Data sources are the component that ties the dashboard visualizations to our underlying data. The data sources are responsible for taking the request data:

- Which filters have been applied
- Any query parameters
- Any configuration options

And transforming these into values that the data source can understand. The data source response is then transformed into values that the dashboard layout
framework can understand for it to be able to:

- Render the visualization
- Update any UI elements
- Update any filter values

To make this work, each data source is required to have a consistent API. ⁠For now, this is a `fetch` function which looks something like:

```javascript
export default async function fetch({
  contextId, // The id of the namespace or project where the data should be retrieved from
  contextFullPath, // The full path of the namespace or project where the data should be retrieved from
  query, // The query being used to fetch the data
  queryOverrides, // Optional overrides to the base query
  visualizationType, // The type of visualization being rendered
  visualizationOptions, // Additional options for customizing the visualization
  filters, // The filters applied to the query
  onRequestDelayed, // Callback function when request is delayed. It can trigger a loading spinner in the panel
  setAlerts, // Callback function to set alerts
  setVisualizationOverrides, // Callback function to set visualization options before render but after the data fetch, allowing us to include fetched data in the visualization options
})
```

The panel will always send this information, the data source's `fetch` method can then decide which information it needs to use, and which it can ignore.
Any other functions used by the data source are data source specific, and ignored by the wider dashboard layout framework.
