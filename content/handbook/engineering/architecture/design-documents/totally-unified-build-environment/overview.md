---
title: "Totally Unified Build Environment"
status: ongoing
creation-date: "2025-02-06"
authors: [ "@rmarshall" ]
coach: [ ]
approvers: [ "@deriamis", "@balasankarc", "@WarheadsSE", "@denisra" ]
owning-stage: "~devops::systems"
participating-stages: []
toc_hide: true
---

## Overview

The Totally Unified Build Environment creates a single build environment for
all GitLab components and dependencies. This eliminates inconsistency
between what gets tested and what gets shipped to customers.

## Workflows

Most will encounter the Totally Unified Build Environment through their
daily work when a continuous integration pipeline builds their code.

```mermaid
---
title: The Totally Unified Build Environment in Motion
---
%%{init: {'themeVariables': { 'fontFamily': 'Monospace'}}}%%
flowchart TD
    dependencyProject((Subscriber Project)):::externalCaller
    subscriberProjectPipelineStarts([Subscriber Project pipeline]):::externalCaller
    tubeScaffold([The Totally Unified Build Environment generates build job definitions]):::scaffold
    buildStreamJob([Subscriber Project build stream jobs]):::externalCaller
    updateBuildStreamIssue([The Totally Unified Build Environment Updates Subscriber Project Dependency Issue]):::scaffold
    tubeComplete((Build Complete)):::taskFinished

    dependencyProject --> subscriberProjectPipelineStarts
    subscriberProjectPipelineStarts ---->|request build stream jobs| tubeScaffold
    tubeScaffold -->|build stream job definitions| subscriberProjectPipelineStarts
    subscriberProjectPipelineStarts --> buildStreamJob
    buildStreamJob --> updateBuildStreamIssue
    updateBuildStreamIssue --> tubeComplete

    classDef externalCaller stroke:#2B2838,fill:#FC6D26,stroke-width:6px,color:#FFF
    classDef scaffold stroke:#2B2838,fill:#FCA326,stroke-width:6px,color:#000
    classDef tubeCtl stroke:#2B2838,fill:#7759C2,stroke-width:6px,color:#FFF
    classDef taskFinished stroke:#2B2838,fill:#0f0,stroke-width:4px,color:#000
```

### How Engineers use The Totally Unified Build Environment

The Totally Unified Build Environment provides centrally managed continuous integration job configuration that project maintainers customize for their project.

- Patch and major updates show up automatically with no changes in local continuous integration configuration.
- Issues open automatically and align to the subscriber project workflow.

### How Management uses The Totally Unified Build Environment

The upgrade process uses GitLab project management features. It automatically creates an epic and labels it for discoverability along with a due date.

Engineering and Product managers can schedule the automatically opened issues through their normal process.

## Design philosophy

The Totally Unified Build Environment follows five core principles:

- One common toolchain builds all software across GitLab.
- Keep management processes light to maximize engineer agency and autonomy.
- Increase velocity for feature and incubation teams through baked in self-service.
- Decrease or eliminate manual work wherever feasible.
- Retain the final go/no-go decision for a human.
