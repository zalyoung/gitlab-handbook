---
title: Observability Based Performance Testing at GitLab
---

## Description

Observability-based performance testing is an approach that focuses on understanding your system's performance characteristics through comprehensive instrumentation and real-time data collection. Unlike traditional performance testing where you run specific test scenarios, observability testing is about having deep visibility into how your application behaves under real conditions. This involves instrumenting your code with traces, metrics, and structured logging to track everything from response times and resource usage to business-level performance indicators.

The key advantage of this approach is that it enables you to understand not just what's happening in your system, but why it's happening. By collecting detailed performance data across your entire application stack, you can follow requests as they flow through your services, identify bottlenecks, spot patterns, and predict potential issues before they impact users. This makes debugging faster, helps catch performance regressions early, and allows teams to make data-driven decisions about optimizations. Instead of relying solely on synthetic tests, you're working with real-world data that shows exactly how your code performs under actual usage conditions.

## Goals

- Performance Understanding: Increase visibility in teams on the performance impact of their work
- Early Detection: Enable teams to identify potential performance problems before they get bad enough to be customer affecting
- Team Enablement: Teams have another tool to analyze performance that does not necessitate specific domain expertise (Load Testing tooling)

## Non-Goals

- Replace existing load based testing, in particular our testing with [GPT](https://gitlab.com/gitlab-org/quality/performance)
  - Observability based Performance Testing does not replace well designed load tests
    - It will find different performance problems
    - It will reduce our dependance on heavy weight load tests, but not replace.

## Approach

## Case Studies

