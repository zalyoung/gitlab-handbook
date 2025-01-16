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

### Example workflow for a Scrum Development team

We had a couple dashboards setup:

- An [Apdex](https://en.wikipedia.org/wiki/Apdex) based view into how the application was running for end users (both in production and our test environment)
- Dashboards for Key services / KPIs that provided deeper details to explain the why's and what's of the Apdex view 
- A dashboard that provided views into errors in our environments

Every Daily Standup, we spent 5 minutes reviewing the dashboards, indentifying patterns / errors that the team wanted to review / investigate further. The review was not to find a cause, just to identify something that was worth further investigation so we could open an Issue against it. These issues would get prioritized and worked like any other Issue. We allocated time to investigate and diagnose these Issues

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
