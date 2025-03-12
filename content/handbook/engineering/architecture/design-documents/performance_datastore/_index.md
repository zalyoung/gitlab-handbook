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

The Performance Results Datastore will complement our shift-left performance testing approach by enabling sophisticated data-driven decisions and providing comprehensive visibility into performance trends across environments, test scenarios, and GitLab versions. This evolution represents the next phase in our performance engineering maturity, turning the valuable data we already collect into actionable insights available to everyone.

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

We propose building a Performance Results Datastore with the following core components:

1. **Data Collection Layer**: APIs and integration points for various performance testing tools to submit results to the datastore
2. **Storage Layer**: A time-series database optimized for performance metrics storage and retrieval
3. **Analysis Layer**: Services for querying, analyzing, and comparing performance results
4. **Visualization Layer**: Integration with existing visualization tools (Grafana) for creating dashboards

The solution will be designed to:

- Support multiple types of performance tests
- Store results with rich metadata (GitLab version, environment details, test parameters)
- Provide flexible querying capabilities for various analysis needs
- Scale to accommodate growing volumes of performance data
- Integrate seamlessly with existing CI/CD pipelines

## Design and implementation details

As we already have many of these pieces existing already, we will try to reuse what already exists before we re-create.

There is already an existing InfluxDB instance and Grafana front end our first POC will be to create a bucket in that infrastructure, use Grafana to generate views into the data, and build a simple connector that enables a CI pipeline to query the data it needs out.

### Use case

1. Performance run inside an MR
   - The run generates it's results
   - It queries the datastore for the latest results (and loads it's data back)
   - It compares the results to determine if the results are within tolerances and determines Pass/Fail status
2. User has questions about how performance has trended over time
   - Queries the results in Grafana
   - Compares the results to answer questions

## Alternative Solutions

1. Run a baseline run and the performance run every MR
    - Pros:
      - Provides immediate, direct comparison without relying on historical data
      - Guarantees latest reference point for comparison
      - Eliminates concerns about environmental or temporal variations
    - Cons:
      - Dramatically increases CI resource consumption and pipeline duration
      - Creates redundant test runs of the same baseline code
      - Doubles the testing time for every performance-relevant MR
      - Scales poorly as more performance tests are added to the suite
      - Use a hard coded baseline
2. Use Static, Hard-Coded Baselines
    - Pros:
      - Simple implementation with minimal infrastructure needs
      - Consistent reference points for comparison
      - Low maintenance overhead for implementation
    - Cons:
      - Quickly becomes outdated as the application evolves
      - Fails to account for legitimate performance changes over time
      - Requires manual updates to adjust expectations
3. Use Existing Per-Environment Prometheus Instances
    - Pros:
      - Leverages existing monitoring infrastructure
      - Data already collected and available
    - Cons:
      - Data is isolated within each environment
      - Added complexity on the CI run to determine which data source to use
      - Test run will vary, will the needed data be present?
4. Build a Custom Performance Analytics Platform
    - Pros:
      - Fully tailored to our specific performance testing needs
      - Maximum flexibility in data model and analysis capabilities
    - Cons:
      - Significantly higher development and maintenance effort
      - Longer time to initial value
      - Requires specialized skills to build and maintain
      - Will reinvent capabilities already available in existing tools
5. Use Object Storage (S3/GCS/Package Registry) to Store Baselines as JSON Files
    - Pros:
      - Simple implementation with minimal infrastructure dependencies
      - Easy integration with CI/CD pipelines and existing tools
      - Straightforward version control of baseline files
      - Low operational overhead with highly reliable storage
      - Cost-effective for the amount of data involved
    - Cons:
      - Limited query capabilities for dynamic analysis and investigation
      - No built-in visualization or trending capabilities
      - Requires custom tooling for comparison and regression detection
      - Difficult to perform ad-hoc analysis or identify patterns across multiple tests
      - Doesn't scale well for storing full test result datasets, only suitable for baselines

## References

- [GitLab Performance Tool (GPT)](https://gitlab.com/gitlab-org/quality/performance)
- [GPT Benchmarks Wiki](https://gitlab.com/gitlab-org/quality/performance/-/wikis/Benchmarks/Latest)
- [Reference Architecture Test Environment Details](https://gitlab.com/gitlab-org/quality/gitlab-environment-toolkit-configs/quality/-/wikis/Performance-environments-setup)
- Replace InfluxDB with Prometheus InfluxDB exporter
  - [MR](https://gitlab.com/gitlab-org/gitlab-environment-toolkit/-/merge_requests/174)
  - [Issue](https://gitlab.com/gitlab-org/gitlab-environment-toolkit/-/issues/98)
- [Shift Left and Right Performance Testing](../shift_left_right_performance/_index.md)
- [End-to-End Pipeline Monitoring](../../../infrastructure-platforms/developer-experience/end-to-end-pipeline-monitoring/#test-metrics)
