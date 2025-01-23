---
title: "Compliance Frameworks ADR 007: External Custom Requirements"
toc_hide: true
---

## Context

Allow users to create controls to expand on what GitLab offers by default.

## External requirements

- Since we can't reliably predict what kinds of data will be useful for external
  services, we will initially start out by pinging external services with just
  project settings attached.

- To avoid complicating role design and needing to control privileges
  specifically for external controls, we will use the shared HMAC secret for
  authentication.

## Constraints

1. We should limit the amount of pending status checks a requirement can have in pending state to keep execution of the worker that checks for timeouts lean.

## Decision

We decided to let external services post the status of their controls back to us in an async manner allowing for
more time to let them perform more complex checks. This will be especially
helpful if they need to request additional data to evaluate (from GitLab itself
or other sources).
