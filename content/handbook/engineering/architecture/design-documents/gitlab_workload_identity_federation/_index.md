---
title: GitLab Workload Identity Federation
status: proposed
creation-date: "2025-03-21"
authors: [ "@grzesiek" ]
coach: "tbd"
approvers: [ "@maw", "@hstutor" ]
owning-stage: "~devops::sec"
toc_hide: true
---

{{< design-document-header >}}

## Summary

The main way in which machine-type identities can interact with GitLab today is
through Personal Access Tokens. Because Primary Access Token as relatively
long-lived tokens, there is a significant risk associated with PATs leaking or
being stolen by malicious actors.

Users are often using OAuth access tokens instead to rely on shorter-lived
credentials. This is not perfect, however, because OAuth tokens are
impersonating human-users and can't be easily associated with service accounts,
and tools built for machine-type identities.

The emergent solution, widely adopted across the industry, is OIDC-based
[workload identity federation](https://cloud.google.com/iam/docs/workload-identity-federation).
GitLab users are already using this method to authenticate with Google Cloud
Platform or AWS, but there is no way to authenticate with GitLab by using
identity federation.

This design doc describes the way towards GitLab Workload Identity Federation:
GitLab users being able to grant access to GitLab to external identities by
mapping external principals onto GitLab identities and defining rules around
how the authentication and authorization is supposed to work for those
principals.

## Goals

## Requirements

## Proposal

## Decisions


