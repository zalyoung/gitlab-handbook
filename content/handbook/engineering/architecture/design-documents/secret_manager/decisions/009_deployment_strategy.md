---
title: 'GitLab Secrets Manager ADR 009: Deployment strategy for GitLab.com, Dedicated, and Self-managed instances'
toc_hide: true
---

## Context

We want all customers to be able to take advantage of our secrets manager. This means we need to be able to provide this feature on GitLab.com, Dedicated, and self-managed instances.

Each of these three types of environments have different delivery requirements, so we need to define our strategy for how we will deploy OpenBao to each.

## Decision

We have different strategies for each type of environment.

Eventually, we will want to use [GitLab's new Runway tooling](https://handbook.gitlab.com/handbook/engineering/infrastructure/platforms/tools/runway/) for all three environments.
However, Runway is currently on supported for GitLab.com, so we will have to plan different strategies for Dedicated and self-managed instances.

### GitLab.com

Runway is available to use for GitLab.com, so we will be using that tooling platform.
As part of this Runway deployment, we have chosen the following:

- GCP KMS will be used to store the keys used to unseal the OpenBao instance
- OpenBao will use Runway's CloudSQL for the database

### Dedicated and Self-managed

We will create an experimental, optional component within [GET](https://gitlab.com/gitlab-org/gitlab-environment-toolkit) to deliver the new infrastructure in cloud native environments.
