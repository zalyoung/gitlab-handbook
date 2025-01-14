---
title: Observability Based Performance Testing at GitLab
---

## Description


Observability Based Performance Testing is a proactive approach to understanding system performance through comprehensive instrumentation and real-time data collection. Unlike traditional performance testing, which relies on specific test scenarios, observability testing provides deep visibility into application behavior under real-world conditions. 


## Approach

Observability testing is actively making use of our Observability tools to detect trends that would develop into performance issues. A couple common approaches:

1. Have the development teams monitor the dashboards on their components and proactively pickup performance concerns
2. Build dashboards/tooling that support doing exploratory testing on the Observability data, looking for linkages that may not be obvious (system A causes system B to slow down)
  - Tools like the [Performance Bar](https://docs.gitlab.com/ee/administration/monitoring/performance/performance_bar.html) can enable someone to notice a performance oddity and start the investigation into the root cause
3. Extend existing Observability tooling to development/test environments
  - This enables teams to get performance metrics earlier in the development process
  - This increases team familiarity with the tooling which facilitates easier adoption/use

## Key Components

- **Instrumentation**: Embedding traces, metrics, and structured logging across the application stack.
- **Real-time Data Collection**: Gathering performance data continuously during actual usage.
- **Holistic Analysis**: Examining the entire system to identify bottlenecks and patterns.

## Goals

- **Enhanced Performance Visibility**: Increase team awareness of their work's performance impact.
- **Proactive Issue Detection**: Identify potential problems before they affect customers.
- **Team Empowerment**: Provide accessible performance analysis tools that don't require specialized expertise.

## Non-Goals

- **Replace Load Testing**: Observability-based testing complements, but does not replace, well-designed load tests like those using [GPT](https://gitlab.com/gitlab-org/quality/performance).

## Implementation Approach

[TBD]

## Case Studies

[TBD]

## Tools and Technologies

- Prometheus
- Grafana
- [Add other relevant tools used at GitLab]

## Future Directions

[TBD]

## Resources

- [Link to relevant GitLab documentation]
- [Link to related blog posts or external resources]
- [Information on available training or workshops]
