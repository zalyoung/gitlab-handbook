# Build streams

## Introduction

Build streams are well-defined environments with everything required to
compile a software package. Framework uses them to isolate structural
dependency updates

Most structural dependency updates are either patch revisions with bug and
security fixes or major version upgrades with breaking changes. Framework
provides dynamic build stream configuration that allows projects to test against
newer versions without manual intervention by subscriber projects.

## Types of build streams

|Build Stream|Description|When it Runs|
|-|-|-|
|`CURRENT`|The certified toolchain that builds GitLab packages.|Every time a pipeline runs.|
|`PATCH`|A candidate to replace the `CURRENT` build stream with minor revisions.|Only runs on the default branch when a patch update is available.|
|`NEXT`|A candidate to replace the `CURRENT` build stream with major revisions.|Only runs on the default branch when a major version update is available.|

The distinction between `PATCH` and `NEXT` build streams accounts for situations
where a major version upgrade requires substantial changes at the same time
a component releases a security update. Due to their lower risk, `PATCH`
build streams move more quickly and allow engineers to continue work on major upgrades and more easily maintain service level agreements with customers.

## Build stream generation

Automated dependency update pipelines generate the `PATCH` and `NEXT` build
stream containers. After validation, Framework promotes the build stream
container to `CURRENT`.

```mermaid
---
title: Build stream creation workflow
---
%%{init: {'themeVariables': { 'fontFamily': 'Monospace' }}}%%
flowchart TD
    dependencyDetection((dependency update found)):::externalCaller
    mergeRequestCreation[open dependency update merge request]:::externalCaller
    generateBuildStreamImage[generate build stream image]:::scaffold
    tagBuildStreamImage[tag build stream image]:::scaffold
    pipelineComplete((pipeline complete)):::taskFinished

    dependencyDetection-->mergeRequestCreation
    mergeRequestCreation-->generateBuildStreamImage
    generateBuildStreamImage-->tagBuildStreamImage
    tagBuildStreamImage-->pipelineComplete

    classDef externalCaller stroke:#2B2838,fill:#FC6D26,stroke-width:6px,color:#FFF
    classDef scaffold stroke:#2B2838,fill:#FCA326,stroke-width:6px,color:#000
    classDef frameworkCtl stroke:#2B2838,fill:#7759C2,stroke-width:6px,color:#FFF
    classDef taskFinished stroke:#2B2838,fill:#0f0,stroke-width:4px,color:#000
```
