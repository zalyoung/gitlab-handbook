---
title: Observability Based Performance Testing at GitLab
---

## Description

Observability-based performance testing is an approach that focuses on understanding your system's performance characteristics through comprehensive instrumentation and real-time data collection. Unlike traditional performance testing where you run specific test scenarios, observability testing is about having deep visibility into how your application behaves under real conditions. This involves instrumenting your code with traces, metrics, and structured logging to track everything from response times and resource usage to business-level performance indicators.

The key advantage of this approach is that it enables you to understand not just what's happening in your system, but why it's happening. By collecting detailed performance data across your entire application stack, you can follow requests as they flow through your services, identify bottlenecks, spot patterns, and predict potential issues before they impact users. This makes debugging faster, helps catch performance regressions early, and allows teams to make data-driven decisions about optimizations. Instead of relying solely on synthetic tests, you're working with real-world data that shows exactly how your code performs under actual usage conditions.