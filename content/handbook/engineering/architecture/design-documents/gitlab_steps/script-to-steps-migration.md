---
owning-stage: "~devops::verify"
title: "Script to Steps Execution Model Migration"
toc_hide: true
---

This document describes the migration strategy for transitioning GitLab CI job execution from the current script-based model to the new steps execution model while preserving all existing user-facing CI configuration syntax.

## Executive Summary

This migration transforms how GitLab CI jobs are executed internally while maintaining complete backward compatibility. Instead of directly executing scripts, GitLab Runner will deliver job payloads over gRPC to a Step Runner agent in the execution environment. This architectural shift enables manager reconnection capabilities and improved job resilience.

## Background

GitLab CI currently operates on a script-based execution model where GitLab Runner directly orchestrates script execution. The new steps execution model introduces an architectural shift:

- **Current**: GitLab Runner → Direct script execution
- **New**: GitLab Runner → gRPC payload → Step Runner agent → Structured execution

Users continue to write the same `.gitlab-ci.yml` files, but the underlying execution mechanism changes to enable better reliability and control.

## Goals

- **Zero User Impact**: Existing `.gitlab-ci.yml` files continue to work without modification
- **Manager Reconnection**: Enable GitLab Runner manager to reconnect to running jobs across all modern executors
- **Executor Coverage**: Support all modern executors (`shell`, `instance`, `docker`, `docker-autoscaler`, `kubernetes`)
- **Performance Preservation**: Maintain current job execution performance

## Non-Goals

- New steps-related user-facing features
- Non-modern executor support (`parallels`, `virtualbox`, `docker-machine`)
- Changes to Kubernetes Pod construction methodology
- CI configuration syntax changes

## Architecture

The migration introduces a **Step Runner Agent** in the job execution environment that receives job payloads via gRPC from GitLab Runner Manager.

### Key Components

**Step Runner Agent**: A service in the execution environment that:
- Receives job payloads via gRPC
- Maintains persistent connection for job lifecycle management
- Enables manager reconnection to running jobs

**gRPC Communication**: Handles job delivery, execution control, status streaming, and reconnection protocol.

### Integration by Executor

- **Shell**: Native step runner process
- **Instance**: Step runner service with SSH bridging  
- **Docker**: Step runner in container with exec bridging
- **Kubernetes**: Step runner in pod with API exec bridging

## Implementation Approach

### Development Phases

1. **Core Infrastructure**: Step Runner gRPC service and job payload transformation
2. **Executor Integration**: Enable step-based execution across all modern executors
3. **Feature Completeness**: Achieve full feature parity and manager reconnection
4. **Rollout**: Feature flags, monitoring, and gradual deployment

### Rollout Strategy

1. Internal testing on GitLab.com projects
2. Opt-in beta for selected external projects  
3. Gradual percentage-based rollout with monitoring
4. Full migration completion

## Technical Details

### Backward Compatibility

All current job behavior is maintained:
- Execution semantics and environment variables unchanged
- File system state and exit codes preserved  
- Logging, timeouts, and cancellation behavior identical
- No changes required to existing `.gitlab-ci.yml` files

### Key Benefits

- **Manager Reconnection**: Runner manager can reconnect to jobs after restart or network issues
- **Enhanced Resilience**: Jobs continue running even if manager connection is lost
- **Foundation for Future Features**: Enables advanced capabilities like job migration

## Risks and Mitigation

| Risk | Mitigation |
|------|------------|
| Performance degradation | Comprehensive benchmarking and optimization |
| Feature gaps | Extensive compatibility testing and phased rollout |
| User disruption | Feature flags and automated rollback procedures |

## Success Metrics

- 100% of modern executors supported
- >99% manager reconnection success rate  
- ≤5% performance impact on job execution time
- Zero user-reported breaking changes

## Dependencies

- Step Runner implementation and gRPC service
- GitLab Runner executor modifications
- Container registry for component distribution

## Conclusion

This migration enables GitLab Runner manager reconnection to running jobs across all modern executors while maintaining complete backward compatibility. The architectural shift from direct script execution to gRPC-based step execution addresses long-standing reliability challenges and provides a foundation for future CI/CD capabilities.