---
title: "Duo Workflow ADR 001: Move Duo Workflow Service into the AI Gateway"
owning-stage: "~devops::ai_powered"
toc_hide: true
---

## Context

The AI Gateway is a Python-based service that handles LLM interactions over HTTP, primarily acting as a proxy (for authentication, routing, etc.). The Duo Workflow Service is another Python-based service that provides multi-step LLM orchestration (via LangGraph) over gRPC.

Historically, the Duo Workflow Service was developed separately (using gRPC) to allow rapid iteration without integrating into an existing codebase. However, this separation creates overhead in deployments (managing two services), observability (duplicate logging/tracing), and maintenance (two sets of dependencies). As we plan to migrate Chat to the Duo Workflow backend, merging Duo Workflow into the AI Gateway can reduce complexity and provide a unified service.

Three options were considered:

1. **Option 1**: Keep services separate.
2. **Option 2**: Combine them into one service with two listeners (gRPC & HTTP).
3. **Option 3**: Combine them into one service with a single listener (e.g., using WebSockets only).

## Decision

**We decided to combine Duo Workflow Service and AI Gateway into a single repository and Docker image using two listeners (Option 2).** One port will handle the existing HTTP-based AI Gateway traffic, and another port will handle the gRPC-based Duo Workflow traffic. A command-line flag or environment variable can toggle which transports (or both) are enabled at runtime.

## Consequences

- **Pros**  
  - Single Docker image for self-hosted deployments simplifies installation and updates.  
  - Unified codebase for logs, metrics, secrets management, etc.  
  - Minimizes rewriting the existing gRPC components, reducing initial refactoring effort compared to a full WebSocket migration (Option 3).

- **Cons**  
  - Still requires gRPC support from customers’ network configurations. Some firewalls may block HTTP/2 traffic.  
  - The hosting platform (Runway) may need to manage two ports/protocols, which can add some complexity.  

Despite these downsides, Option 2 strikes the best balance between maintainability, complexity, and near-term development effort. 