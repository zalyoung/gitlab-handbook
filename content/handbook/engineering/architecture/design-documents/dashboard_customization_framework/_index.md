---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Dashboard Customization Framework
status: "ongoing"
creation-date: "2025-06-16"
authors: [ "@jiaan" ]
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

## Table of Contents

- [Summary](#summary)
- [Motivation](#motivation)
  - [Goals](#goals)
  - [Non-Goals](#non-goals)
- [Proposal](#proposal)
- [Design and implementation details](#design-and-implementation-details)
  - [Dashboard layout](#dashboard-layout)
  - [Panels](#panels)
  - [Filters](#filters)
- [Getting started](#getting-started)
- [Upgrading from static dashboards](#upgrading-from-static-dashboards)

## Summary

This document builds on the dashboard foundation established by the [Dashboard Layout Framework](../dashboard_layout_framework/_index.md),
it outlines the architecture for a dashboard customization framework that enables user-dirven dashboard creation and personalization across GitLab.

The dashboard customization framework provides Vue components and UI patterns that allow for user-driven customization of dashboard layouts.
Users can use it to add/remove panels, position & resize elements, edit text, and to save their personalized dashboard configurations. This framework
is agnostic about where dashboard configurations are stored, instead focussing purely on the customization user experience. 

The customizable dashboard component is a drop-in replacement for existing use cases of the dashboard layout framework. Internerally it wraps the
dashboard layout component and extends its capabilities to allow for user-driven customization that align with GitLab's Pajamas design system.

## Motivation

Currently dashboards provide valuable insights but are static in nature. Users cannot personalize their dashboards to focus on the metrics most
relevant to their workflows, responsibilities, or user roles. This limitations severly limits the effectiveness of dashboards as an analytics tool
for our customers.

Furthermore, without user-customization the responsibility for meeting our customer's diverse analytics needs falls entirely on product teams.
Teams must anticipate, design, and continuously maintain multiple dashboards to satisfy different user personas, use cases, and organizational
requirements. This creates a significant maintenance burden and resource allocation challenge, as teams spend considerable time building and
updating dashboard layouts and visualizations instead of focusing on core feature development and data quality improvements.

### Goals

- Enable users to personalize dashboard layouts, panel selection, and configurations to match their specific needs
- Establish the UI pattern for user-driven dashboard customization to deliver a consistent UX across our applications
- Adopt the customization framework across GitLab where customization would increase user satisfaction and experience
- Outline a clear upgrade path for static dashboards and how teams can integrate customization into their existing dashboards

### Non-Goals

- The dashboard customization framework does not include [Data Exploration](../gitlab_data_exploration/_index.md) outside defined panel visualizations.
- The dashboard customization framework does not define where [dashboards should be listed or placed in the navigation](https://gitlab.com/gitlab-org/gitlab/-/issues/536612).

## Proposal

The customizable dashboard component should be a drop-in replacement for existing use cases of the dashboard layout component. The component
should wrap the dashboard layout component and extend its capabilities to deliver a consistent user-drven dashboard customization user experience
while maintaining the core dashboard layout component's functionality and API.

## Design and implementation details

The framework extends the dashboard layout with a new editing state that users can enter to customize their dashboards. When a user is done
editing the dashboard layout, panels and filter should render and behave as a static dashboard layout with the option to customize.

![dashboard_customization_framework_outline](/images/engineering/architecture/design-documents/dashboard_customization_framework/dashboard_customization_framework_outline.png)

### Dashboard layout

- When not in an editing state, the dashboard look and behave the same as a static dashboard except for a new edit action
- When editing, allow for the input and description to be edited
- When editing, the user should be able to save or discard changes made
- When editing, the dashboard reverts to its original state when changes are discarded
- When editing, the dashboard produces a modified configuration when changes are saved
- When editing, the dashboard shows a warning message when unsaved changes will be lost
- When editing, optionally allow for the user to to add new visualizations

### Panels

- When not in an editing state, panels look and behave the same as on a static dashboard
- When editing, panels can be dragged and snapped into a new grid position
- When editing, panels can be resized with a new height and width
- When editing, allow the user to remove panels

### Filters

- When not in an editing state, filters should look and behave the same as on a static dashboard
- When editing, filters should be hidden to reduce visual clutter

## Getting started

_TODO: Add link to the relevant developer documentation section: https://gitlab.com/gitlab-org/gitlab/-/issues/549982_

## Upgrading from static dashboards

_TODO: Add link to the relevant developer documentation section: https://gitlab.com/gitlab-org/gitlab/-/issues/549982_
