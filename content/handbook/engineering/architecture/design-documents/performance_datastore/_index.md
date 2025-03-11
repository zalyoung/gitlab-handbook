---
title: "Performance results datastore"
status: proposed
creation-date: "2025-03-11"
authors: [ "@AndyWH" ]
coach:
dris: [ "@AndyWH" ]
approvers: [ "@ksvoboda" ]
owning-stage:
participating-stages: []
toc_hide: true
---


## Summary

Performance testing is a critical component of our software quality assurance process. We've established excellent foundations with tools like GitLab Performance Tool (GPT) and our Reference Architecture environments, which have successfully validated our performance capabilities across different scaling tiers.

This blueprint proposes the creation of a Performance Results Datastore that builds upon these successful elements and takes our capabilities to the next level. By creating a central repository for performance testing metrics, we can amplify the value of our existing performance testing work, unlock new analytical capabilities, and further integrate performance awareness throughout our development lifecycle.

The Performance Results Datastore will complement our shift-left and shift-right performance testing approach by enabling sophisticated data-driven decisions and providing comprehensive visibility into performance trends across environments, test scenarios, and GitLab versions. This evolution represents the next phase in our performance engineering maturity, turning the valuable data we already collect into actionable insights available to everyone.

## Motivation

A centralized performance results datastore will enable powerful new capabilities for performance analysis and testing:

1. **Dynamic Analysis in CI/CD Pipelines**: Enable automatic performance testing directly within MR pipelines, with immediate feedback on potential performance impacts. This accelerates development by providing developers with instant visibility into their changes' performance implications.

2. **Self-Service Exploration and Pattern Identification**: Allow teams to independently explore performance data through intuitive interfaces, discovering patterns and trends without requiring specialized performance engineering expertise.

3. **Proactive Performance Management**: Support the creation of dynamic baselines and automated regression detection to identify problematic changes before they reach production.

4. **Contextual Performance Insights**: Correlate performance metrics with specific code changes, environment configurations, and user behaviors to provide richer analysis context.

5. **Democratized Performance Data**: Make performance insights accessible to product managers, developers, and SREs alike, enabling data-driven decisions at all levels.

6. **Comparative Analysis**: Facilitate easy comparison between environments, versions, and test scenarios to better understand the impact of architecture changes, code refactoring, and new features.

This datastore will transform our approach to performance testing from periodic assessments to continuous insights, aligning with our broader shift-left initiative by making performance a more integral part of our development process.

## Goals

- Create a centralized repository for all performance test results
- Enable programmatic access to performance data for analysis and visualization
- Support comparative analysis between different test runs, environments, and GitLab versions
- Provide a foundation for automated performance regression detection
- Facilitate long-term trending and visualization of performance metrics
- Integrate with existing CI/CD pipelines for automatic data collection
- Support both high-level aggregated metrics and detailed raw performance data
- Enable dynamic baseline creation based on historical data

## Non-Goals

- **Replacing existing performance testing tools**: We'll enhance and integrate with our successful tools like GPT rather than replacing them
- **Duplicating our monitoring infrastructure**: We'll leverage our mature monitoring solutions rather than creating parallel systems
- **Reinventing visualization**: We'll build on our investment in Grafana and other visualization tools instead of creating custom alternatives
- **Competing with real-time monitoring**: We'll complement our existing real-time monitoring capabilities rather than replacing them
- **Expanding beyond performance focus**: We'll maintain a dedicated focus on performance metrics to ensure depth and relevance of insights

This initiative is about amplification and evolution of our performance capabilities, not replacement. We're building upon the solid foundation created by previous work to unlock new possibilities without discarding the valuable systems already in place.

## Proposal

## Design and implementation details

## Alternative Solutions

## References

- [GitLab Performance Tool (GPT)](https://gitlab.com/gitlab-org/quality/performance)
- [GPT Benchmarks Wiki](https://gitlab.com/gitlab-org/quality/performance/-/wikis/Benchmarks/Latest)
- [Reference Architecture Test Environment Details](https://gitlab.com/gitlab-org/quality/gitlab-environment-toolkit-configs/quality/-/wikis/Performance-environments-setup)
- [Replace InfluxDB with Prometheus InfluxDB exporter](https://gitlab.com/gitlab-org/gitlab-environment-toolkit/-/merge_requests/174)
- [Shift Left and Right Performance Testing](../shift_left_right_performance/_index.md)
- [End-to-End Pipeline Monitoring](../../../infrastructure-platforms/developer-experience/end-to-end-pipeline-monitoring/#test-metrics)
