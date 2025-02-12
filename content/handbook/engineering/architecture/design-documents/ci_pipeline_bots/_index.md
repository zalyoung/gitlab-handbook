---
title: CI Pipeline Bots
status: proposed
creation-date: "2025-02-11"
authors: [ "@mfangitlab" ]
coaches: [ "@hfyngvason" ]
dris: [ "@rutshah", "@carolinesimpson" ]
owning-stage: "~devops::verify"
participating-stages: []
toc_hide: true
---
<!-- vale gitlab.FutureTense = NO -->

{{< design-document-header >}}

## Summary

Pipeline schedules and pull mirroring operations currently run with the permissions of their original creator. If that user loses project access or leaves the organization, these automated processes fail due to insufficient permissions.

To address this dependency, we propose implementing a new bot type (`ci_pipeline_bots`) that will execute these operations independently of individual user permissions. This solution ensures continuous pipeline operation regardless of personnel changes.

## Motivation

Users are heavily interested in having this for [pipeline schedules](https://gitlab.com/gitlab-org/gitlab/-/issues/404931).

### Goals

1. Pipeline Schedules will continue to run if the assignee is the `ci_pipelines_bot` even if the creator has no permission to the project afterwards.
2. Pull mirroring will continue to run if the assignee is the `ci_pipelines_bot` even if the creator has no permission to the project afterwards.
3. The pipelines should be run with the least privilege access needed to be successful.

### Non-Goals

Using this `ci_pipelines_bot` for anything other than pipeline schedules and pull mirroring.

## Proposal

We have an [open MR](https://gitlab.com/gitlab-org/gitlab/-/merge_requests/179899) on how this service would look like. It is currently only a Service class with no entry point and also Feature Flagged, so there's low risk and easily revertable.

The key ideas here is that this `ci_pipeline_bot` is

1. Created only by maintainers+ of the project
1. Can be assigned a role of `developer` or `maintainer`
1. Can only be assigned to `pipeline_schedules` and `pull_mirroring`
1. Has no cross-project permissions
1. Has no other token privilages, aside from the CI_JOB_TOKEN
    1. This means it cannot generate Personal Access Tokens, Project/Group access tokens, Login, Session tokens, Deploy/Trigger tokens, etc
1. Users can only assign this bot to the feature if they already have permission to run pipelines for that branch

This is very similar to the `security_policy_bot` we have today, except with a more restrictive set of abilities.

We acknowledge that this is not a final comprehensive solution for all services CI. This is a lightweight solution to address repeated security issues with these two features.

The idea is that we should easily be able to switch over to Service Account for CI once that feature has adequate functionality. More details below.

## Alternative Solutions

### 1. Service Accounts

This is a major talking point, see the [discussion on the issue](https://gitlab.com/gitlab-org/gitlab/-/issues/404931#note_2337906010) with input from `group::authentication`. I'll also post the discussion here for talking points.

There are currently some barriers with using Service Accounts.

  1. They are currently scoped to the group level, this adds an extra layer of insecurity as we want to scope this feature initially on the project level to prevent multi-project escalations.
      1. This however means we won't support cross-project pipelines for the MVP. But this is planned as it'll give us some time to flesh out service accounts long-term blueprint as well as CI_JOB_TOKEN granular permissions.
      1. Additionally, this creates friction as regular maintainers cannot create bot accounts and must ask the org admin which'll most likely lead to a "super" service account used for everything.
  1. Service Accounts currently supports by default more authentication methods in addition to job_token (eg, PAT, maybe others), while we do not want to support any other authentication other than job token. This helps improve security as we're limiting the access vectors
  1. Service Accounts for premium users needs to be licensed. Given we want a different bot user per project; this'll be a hard hit for users with a low number of seats

`group::authentication` is aware of these limitations and are in the process of coming up with a blueprint/solution on how to address these.

Given that we'll eventually need [consolidation of user_types](https://gitlab.com/gitlab-org/gitlab/-/issues/512136#note_2306065867), we know that we're adding onto the tech debt, but this new user_type (`ci_pipelines_bot`) should easily convert into a Service Account once the needs are met as it has a finite scope and it's already project specific (for cells and organizations).

### 2. Composite Identities

Pipeline schedules and pull mirroring need to continue functioning even after user deletion, which conflicts with the core concept of composite accounts.
