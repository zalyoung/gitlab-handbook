---
title: Validity Checks for Secret Detection findings
status: ongoing
creation-date: "2025-07-08"
authors: [ "@craigmsmith" ]
coach: [ "@theoretick" ]
approvers: [ "@abellucci", "@amarpatel" ]
owning-stage: "~devops::application security testing"
participating-stages: [ "~devops::secure" ]
toc_hide: true
---

<!-- vale gitlab.FutureTense = NO -->
{{< engineering/design-document-header >}}

## Summary

Verify the validity and liveness of Secret Detection findings by programmatically checking them against their issuing services. This enables security teams to prioritize remediation of active secrets over revoked or inactive credentials.

See the [Verify validity/liveness of Secret Detection findings epic](https://gitlab.com/groups/gitlab-org/-/epics/13988) for more details.

## Motivation

### Goals

#### What is it trying to achieve?

- Provide token validity status of detected GitLab and partner tokens to Ultimate customers

#### How will we know that this has succeeded?

- Security teams will spend less time remediating inactive credentials

#### What are other less tangible opportunities here?

### Non-Goals

#### What is out of scope for this blueprint?

- Cross Scanner Integration (extend to DAST)
- Extended Object Support beyond Secret Detection findings

## Proposal

We will automate the verification process for tokens discovered during security scans. This feature will:

Verify token status (Active, Inactive, Possibly Active) and display results on vulnerability pages
Enable sorting and filtering findings by token status
Support GitLab and partner platform tokens
Work for cloud and self-managed/air-gapped instances
Include telemetry to measure usage and effectiveness

Customers can opt in via Security Configurations. Once enabled, discovered tokens will be automatically verified against issuing services, with status information displayed in the Vulnerability details page and Security Dashboard, allowing security teams to prioritize remediation of active credentials.
