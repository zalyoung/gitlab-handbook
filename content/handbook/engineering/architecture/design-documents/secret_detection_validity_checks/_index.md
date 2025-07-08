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

Verify the validity and liveness of Secret Detection findings by programmatically checking them against their issuing services. This reduces false positives and helps users prioritize remediation of active secrets over revoked or invalid credentials.

See the [Verify validity/liveness of Secret Detection findings epic](https://gitlab.com/groups/gitlab-org/-/epics/13988) for more details.

