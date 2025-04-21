---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Performance Health Dashboard
status: proposed
creation-date: "2025-04-18"
authors: [ "@bwilkerson13" ]
coaches: [ "@username" ]
dris: [ "@product-manager", "@engineering-manager" ]
owning-stage: ""
participating-stages: []
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< design-document-header >}}

## Summary

Data and tooling shapes behavior. 

Our current performance testing process has too long of a feedback cycle, with data that is spread across multiple sources and provided by intermediary teams. The delay and distributed nature of the process leads to a lack of direct ownership over performance issues that are raised, and a significant burden of context-switching on the engineers who maintain the code.

To be more proactive in addressing performance, we need to shorten the feedback loop to the engineering teams, and reduce the context siloing of performance data by making it more accessible and reducing the cognitive load of interpreting it. This should provide teams the ability to make proactive changes to improve performance by monitoring and responding directly to trends, and also to make data-driven decisions about prioritizing issues.

## Motivation

This proposal is motivated by a rise in reported incidents and performance issues.

### Goals

- Increase awareness for stage teams regarding the performance of their code after deployments and self-managed releases.
- Enable teams to make data-informed prioritization decisions about performance in their owned code paths.
- Shorten the feedback loop; get problems to the people who can solve them, faster

### Non-Goals

- This proposal doesn't include changing the observability or instrumentation of GitLab. We are trying to better aggregate and contextualize information that we already have.

## Proposal

Create an information source for performance data that aggregates information from .com Production and Self-Managed, and which can be scoped to a relevant user journey. 

## Design and implementation details

Prototype phase:

Create a "single pane of glass" information radiator for a single critical user journey, or common subject of performance complaints. A user with minimal context should be able to identify that path's's current health on production .com, and performance trends over a set timeframe for both .com and Self-Managed (GPT Reference Architecture test data?) 

## Alternative Solutions

<!--
It might be a good idea to include a list of alternative solutions or paths considered, although it is not required. Include pros and cons for
each alternative solution/path.

"Do nothing" and its pros and cons could be included in the list too.
-->
