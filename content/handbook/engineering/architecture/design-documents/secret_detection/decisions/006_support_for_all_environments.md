---
title: "GitLab Secret Detection ADR 006: Unified SD Support for all GitLab Environments"
---

## Context

We need to take steps in making Secret Detection features scalable and consistently accessible across GitLab.com, Self-Managed (including air-gapped) and Dedicated environments.

There are two problems that we should address, preferably both at the same time to avoid the expensive redesigns.
      
1. The initial consideration of using Cloud Connector for SM/Dedicated envs is no longer valid due to [certain limitations](https://gitlab.com/gitlab-org/gitlab/-/work_items/525472#note_2418504073). This puts us back to original problem of requiring to make standalone service accessible across all the environments.
     
2. Secret Push Protection feature (scanning git commits during git push) requires blocking Secret Detection(SD) scans where scan should run immediately and return the results. The current design of Rails directly invoking the Secret Scan engine(Gem/Secret Detection Service) supports blocking scan requests. However, it is not scalable to do the same on large objects like Job Artifacts or Logs as it affects the throughput of the Scan engine. We need to adopt a non-blocking approach where the scans are run in the background and provide results eventually, similar to how we ingest Security Reports.

## Proposal

Multiple proposals were [discussed](https://gitlab.com/gitlab-org/gitlab/-/work_items/525472#note_2418504073) for the above problems, this ADR drafts a combined approach considering relevant proposals.

The proposal suggests to address the the first problem by running SD scans within Embedded SD module(Gem/Binary) for Self-Managed(inc. offline) and Dedicated environments. This is a default setup that should be capable enough to handle the traffic for a single-tenant environment. As an alternative, we allow the customers to self-host Secret Detection Service in their infrastructure in the Embedded SD module throughput isn't meeting the needs. We will prioritize invoking self-hosting service URL (if given) over Embedded module for Secret Detection scan. 

The second problem is addressed by introducing asynchronous way of invoking secret detection scans using the existing Sidekiq infrastructure used by Rails.

### Blocking scan requests

We will continue using SDS for GitLab.com and the embedded approach (i.e Gem/Binary) for Self-Managed and Dedicated customers as a default setup, however, we will allow customers to self-host SDS (share Helm Chart/Docker image) in case the embedded approach is not scalable enough for their use case.

### Non-Blocking scan requests

We will leverage the existing Sidekiq for running the non-blocking SD scans in the background. The scan engine remains the same as the one used for blocking approach

### Support Matrix

| Environment | blocking scan requests | non-blocking scan requests |
|-------------|------------------------|----------------------------|
| GitLab.com | Runway-hosted SDS | Sidekiq + Runway-hosted |
| Self-Managed/Dedicated (default) | Embedded(Gem/Binary) | Sidekiq + Embedded |
| Self-Managed/Dedicated (custom) | Self-hosted SDS | Sidekiq + Self-hosted SDS |

### Service Authentication and Authorization

The ensure the authenticity of the service (primarily applicable to Self-hosted),  we could adopt Auth framework from [Cloud Connector](https://docs.gitlab.com/development/cloud_connector/).

_This decision still requires evaluation interms of feasibility_

## High-level design

![High-level Secret Detection design](/images/engineering/architecture/design-documents/secret_detection/006_support_all_envs.png "High level design supporting sync and async scans")

## Next Steps

- TBD
