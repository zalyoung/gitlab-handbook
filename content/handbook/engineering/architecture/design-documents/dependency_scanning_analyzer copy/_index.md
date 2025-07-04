---
title: "On-demand Dependency Scanning service"
status: proposed
creation-date: "2025-03-20"
authors: [ "@gonzoyumo" ]
coaches: [  ]
dris: [ "@johncrowley", "@thiagocsf" ]
owning-stage: "~devops::secure"
participating-stages: [Application Security Testing]
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< design-document-header >}}

<!--
Don't add a h1 headline. It'll be added automatically from the title front matter attribute.
For long pages, consider creating a table of contents.
-->

## Summary

The dependency scanning feature is expanding beyond CI pipelines to support multiple scanning contexts.
To maintain consistency and avoid duplicate implementations across these contexts, we propose creating an on-demand Dependency Scanning service capable of analyzing components in a generalized manner.

## Motivation

The development of Continuous Vulnerability Scanning led to implementing the GitLab SBOM Vulnerability Scanner in the Rails backend.
Our new Dependency Scanning using SBOM feature was designed to reuse this same scanner.
However, based on user feedback, we must reconsider our approach to provide scan results back into running CI pipelines.
This requires a stateless approach to our vulnerability scanner logic and that it can send results back to the CI job.

Additionally, upcoming features on our roadmap require scanning capabilities in various contexts.
So far, the go to solution was to rely on CI pipelines, as demonstrated by our Container Scanning for the Registry implementation.
Though, this approach presents unnecessary complexity and limitations and this dependency on CI pipelines will increasingly hinder adoption of upcoming features.

Example use cases requiring scanning capabilities outside CI pipelines include:

- IDE integration
- Web IDE scanning
- Package registry scanning
- Dependency firewall
- And others

### Goals

- Design a Dependency Scanning service that can operate with minimal requirements and report detected vulnerabilities for a given list of components.
- Reuse the existing GitLab SBOM Vulnerability Scanner to maintain a single implementation of our scanner logic.
- Support all GitLab deployment types (gitlab.com, self-managed, dedicated) including offline environments.

### Non-Goals

- Define a public API for service consumption - instead, provide an internal interface that multiple ad hoc APIs or services can consume with their own needs

## Proposal

Create a generic Dependency Scanning service class in the Rails application that:

1. Takes a collection of components and configuration as input
2. Performs security analysis using the GitLab SBOM Vulnerability Scanner
3. Outputs results in a standardized format that can be transformed for various presentation contexts

### Advantages

- Focuses exclusively on security analysis using a single implementation: the GitLab SBOM Vulnerability Scanner
- Enables various scanning contexts to use the service:
  - Without additional requirements (the rails application and background jobs are core components available in all installations)
  - With different entrypoints based on needs (internal/public HTTP API, internal service calls)
  - With different input formats that can be pre-processed into the required format
  - With different output formats through specialized presentation layers

### Challenges

- A generic service might lack the necessary context for certain optimizations
- A single service for various scanning contexts will create a single point of failure

## Architecture

The dependency scanning service follows a modular architecture with clear separation of concerns:

```mermaid
flowchart TD
    %% Define styles
    classDef contextStyle fill:#d0e0ff,stroke:#3080ff,stroke-width:2px
    classDef apiStyle fill:#d0ffee,stroke:#30c0a0,stroke-width:2px
    classDef coreStyle fill:#ffe0d0,stroke:#ff8040,stroke-width:2px
    classDef presenterStyle fill:#fff0c0,stroke:#ffaa00,stroke-width:2px
    classDef postProcStyle fill:#ffd0e0,stroke:#ff60a0,stroke-width:2px
    classDef outputStyle fill:#e8d0ff,stroke:#9040ff,stroke-width:2px
    classDef dbStyle fill:#ffd0d0,stroke:#ff4040,stroke-width:2px
    classDef findingsStyle fill:#c0ffc0,stroke:#40a040,stroke-width:2px

    %% Contexts Group
    subgraph Contexts[Scanning Contexts]
        CI[CI Job]
        IDE[IDE Integration]
        WebIDE[Web IDE]
        PMDB[PMDB update]
        DEPS_FW[Dependency Firewall]
    end

    %% API Layer Group
    subgraph APILayer[Pre-processing]
        SBOM_API(SBOM Scan API)
        IDE_API(IDE Scan API)
        DB_API(GlobalAdvisoryScanner)
        DEPS_FW_API(Dependency Firewall API)
    end

    %% Core Service
    SERVICE{Dependency Scanning Service}:::coreStyle

    %% Findings output from service
    FINDINGS[Findings]:::findingsStyle

    %% Results Processing Layer
    subgraph ResultsProcessingLayer[Results Processing]
        %% Presenters
        CI_PRESENTER(CI Report Presenter)
        DB_PRESENTER(Ingestion Service)
        IDE_PRESENTER(IDE Presenter)
        WEBIDE_PRESENTER(Web IDE Presenter)
        DEPS_FW_PRESENTER(Dependency FW Presenter)

        %% Post-processing components
        CI_POSTPROC[CI Job Integration]:::postProcStyle
        IDE_POSTPROC[IDE UI Integration]:::postProcStyle
        DEPS_FW_POSTPROC[Dependency FW Integration]:::postProcStyle
        VULN_MNGMT[Vulnerability Management Integration]:::postProcStyle
    end

    %% Outcomes Group
    subgraph Outcomes[Outcomes]
        DS_REPORT[DS Report in CI job]
        IDE_ALERTS[IDE Alerts]
        WEBIDE_ALERTS[Web IDE Alerts]
        VULN_REPORT[Vulnerability Report]
        DEPS_FW_BLOCK[Policy Enforcement]
    end

    %% Connection flows - Input path
    CI -->|scan request| SBOM_API
    IDE -->|scan request| IDE_API
    WebIDE -->|scan request| IDE_API
    PMDB -->|advisories| DB_API
    DEPS_FW -->|scan request| DEPS_FW_API

    %% Direct component flows to service
    SBOM_API -->|components| SERVICE
    IDE_API -->|components| SERVICE
    DB_API -->|components| SERVICE
    DEPS_FW_API -->|components| SERVICE

    %% Service outputs raw findings
    SERVICE --> FINDINGS

    %% Findings flow to presentation layer
    FINDINGS --> CI_PRESENTER
    FINDINGS --> DB_PRESENTER
    FINDINGS --> IDE_PRESENTER
    FINDINGS --> WEBIDE_PRESENTER
    FINDINGS --> DEPS_FW_PRESENTER

    %% Presenters to post-processing
    CI_PRESENTER --> CI_POSTPROC
    DB_PRESENTER --> VULN_MNGMT
    IDE_PRESENTER --> IDE_POSTPROC
    WEBIDE_PRESENTER --> IDE_POSTPROC
    DEPS_FW_PRESENTER --> DEPS_FW_POSTPROC

    %% Post-processing to final outputs
    CI_POSTPROC --> DS_REPORT
    IDE_POSTPROC --> IDE_ALERTS
    IDE_POSTPROC --> WEBIDE_ALERTS
    VULN_MNGMT --> VULN_REPORT
    DEPS_FW_POSTPROC --> DEPS_FW_BLOCK

    %% Apply styles
    class CI,IDE,WebIDE,PMDB,DEPS_FW contextStyle
    class SBOM_API,IDE_API,DB_API,DEPS_FW_API apiStyle
    class CI_PRESENTER,DB_PRESENTER,IDE_PRESENTER,WEBIDE_PRESENTER,DEPS_FW_PRESENTER presenterStyle
    class DS_REPORT,IDE_ALERTS,WEBIDE_ALERTS,VULN_REPORT,DEPS_FW_BLOCK outputStyle
```

## Implementation Details

TODO

## Alternative Solutions

### Create a Satellite Service with Runway

[Runway(https://docs.runway.gitlab.com/reference/blueprints/satellite-services-vision/#objective)] would be the ideal solution for a stateless service like this.

Unfortunately, support for all deployment types is not yet available and only part of the long term vision, which doesn't meet our requirements.

An hybrid approach using a Runway service in supported environments and a fallback to a different implementation in others would create additional development and maintenance costs.
Note that this could be considered further if we face performance limitations with the current proposal.

### Package GitLab SBOM Vulnerability Scanner into a Gem and its own container image

Multiple scanning contexts could reuse the generic scanner without depending on the Rails platform, either by bundling the gem or executing the container.

Though, the GitLab SBOM Vulnerability Scanner still requires access to the PMDB data to function, which is currently available via the GitLab rails application DB. This approach would
then require an API on the rails platform that the SBOM Scaner could use to fetch advisory data.

Additionally, some scanning contexts might lack the infrastructure to either run the scan directly (gem) or orchestrate the container execution. This would lead to additional complexity and requirements (e.g., triggering a CI pipeline to execute the workload and find a way to collect results).

## References

- [Dependency Scanning Analyzer](https://handbook.gitlab.com/handbook/engineering/architecture/design-documents/dependency_scanning_analyzer/)
- [GitLab SBOM Vulnerability Scanner](https://docs.gitlab.com/ee/user/application_security/sbom/)
- [Continuous Vulnerability Scanning](https://docs.gitlab.com/ee/user/application_security/vulnerability_report/)
