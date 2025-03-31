---
title: "Duo Workflow ADR 002: Migrate from gRPC to WebSockets"
owning-stage: "~devops::ai_powered"
toc_hide: true
---

## Context

Initially, the Duo Workflow Service used gRPC over HTTP/2 for streaming. While gRPC provides efficient bi-directional streaming and code generation, it can pose challenges:
- Firewalls or corporate proxies often block or inspect HTTP/2 traffic in ways that break gRPC.  
- Browsers cannot natively use gRPC without a proxy layer (gRPC-Web or Envoy).  
- Our self-managed customers have frequently highlighted friction in configuring gRPC.

Moving to **WebSockets** (over HTTP/1.1) can address these issues and unify the transport across all components (client, server, LSP executor). It also enables direct browser-to-service streaming if needed, simplifying real-time feedback loops.

## Decision

**We decided to replace gRPC with WebSockets** for Duo Workflow’s streaming and request/response interactions. Protobuf will be used for serialization over WebSockets where appropriate, preserving type safety.

## Consequences

- **Pros**
  - Single port over standard HTTP/1.1 with WebSocket upgrades is more likely to be firewall-friendly.  
  - Browsers can connect directly without needing a separate proxy or gRPC-Web implementation.  
  - Unified transport across front-end, back-end, and possibly the LSP executor logic.

- **Cons**
  - Requires refactoring the existing gRPC-based code, including streaming logic, interceptors, and error handling.  
  - gRPC’s built-in features (flow control, code generation) will need to be re-created or replaced with equivalent libraries in the WebSocket ecosystem.  
  - Performance differences vs. gRPC in high-load or binary-heavy streaming scenarios may require additional testing or optimization.  

The benefit of easier adoption, fewer networking roadblocks, and improved client compatibility outweighs the additional refactoring effort.