---
title: Security Finding Creation API
status: proposed
creation-date: "2024-12-04"
authors: [ "@hacks4oats" ]
coaches: [ "@theoretick" ]
dris: [ "@johncrowley", "@tkopel" ]
owning-stage: "~devops::security risk management"
participating-stages: ["~devops::application security testing"]
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< design-document-header >}}

## Summary

The security finding creation API is an _internal_ API that facilitates
the creation of security findings without the need for CI/CD job
artifacts. This API establishes a clear contract on what's needed to create
the various types of security findings we store in the database.

## Motivation

This API addresses the difficulty of building application security testing
that does not run within the context of a CI/CD job, and does not produce job
artifacts. Building security testing software that works in this manner requires
workarounds, so that the source files (for example CycloneDX files) are
considered equivalent to a security report. While functional, this
workaround starts to leak implementation details quickly, adding to the overhead
of working on related areas, and results in a difficult to maintain set of code.

This will also improve the experience of working with the security report finding
class which has become overloaded. Evidence of this can be seen by looking at
the constructor which has over [20 arguments](https://gitlab.com/gitlab-org/gitlab/blob/009712173ba042d7d83ea31cb12e7019c758f39b/lib/gitlab/ci/reports/security/finding.rb#L36)
one of which is generic `details` hash that can hold arbitrarily more pieces of
data.

### Goals

* Decouple security report parsing and security finding sourcing.
* Reduce complexity of creating security findings from CycloneDX SBoMs.
* Improved performance when loading security findings from database.

### Non-Goals

* Exposing security findings as CI/CD job artifacts.

## Proposal

Create an API that has methods to create the following finding types:

* Dependency Scanning
* Container Scanning
* Operational Container Scanning
* DAST
* SAST
* Secret Detection

These methods replace the generic report finding class with new classes
whose constructors clearly define the data required for each finding type.
Refactor our security ingestion entrypoint to use a new method called
`#collect_security_findings` instead of `#collect_security_reports`. This method
will be responsible for collecting security findings from eligible sources. For
example, CycloneDX SBoMs would be scanned for advisories affecting the listed
components, and security reports would be parsed for the included security
findings.

## Design and implementation details

<!--
This section should contain enough information that the specifics of your
change are understandable. This may include API specs (though not always
required) or even code snippets. If there's any ambiguity about HOW your
proposal will be implemented, this is the place to discuss them.

If you are not sure how many implementation details you should include in the
document, the rule of thumb here is to provide enough context for people to
understand the proposal. As you move forward with the implementation, you may
need to add more implementation details to the document, as those may become
valuable context for important technical decisions made along the way. A
document is also a register of such technical decisions. If a technical
decision requires additional context before it can be made, you probably should
document this context in a document. If it is a small technical decision that
can be made in a merge request by an author and a maintainer, you probably do
not need to document it here. The impact a technical decision will have is
another helpful information - if a technical decision is very impactful,
documenting it, along with associated implementation details, is advisable.

If it's helpful to include workflow diagrams or any other related images.
Diagrams authored in GitLab flavored markdown are preferred. In cases where
that is not feasible, images should be placed under `images/` in the same
directory as the `index.md` for the proposal.
-->

The security ingestion looks like the following:

```mermaid
---
config:
    theme: "base"
---
flowchart
    subgraph "non-default branch"
    Pipeline[Pipeline] -->|uploads security reports| Rails[Rails]
    Rails -->|schedules| StoreScansWorker[Security::StoreScansWorker]
    StoreScansWorker -->|executes| StoreScansService[Security::StoreScansService]
    StoreScansService -->|passes security reports grouped by artifact type| StoreGroupedScansService[Security::StoreGroupedScansService]
    StoreScansService -->|schedules| ScanSecurityReportSecretsWorker[Security::ScanSecurityReportSecretsWorker]
    StoreGroupedScansService -->|executes| StoreScanService[Security::StoreScanService]
    StoreScanService -->|idempotently creates| Security::Scan
    StoreScanService -->|idempotently creates one or more| Security::Finding
    ScanSecurityReportSecretsWorker -->|executes| TokenRevocationService[Security::TokenRevocationService]
    TokenRevocationService -->|revokes| LeakedToken
    end

    subgraph "default branch"
    StoreScanService --> StoreSecurityReportsByProjectWorker[Security::StoreSecurityReportsByProjectWorker]
    StoreSecurityReportsByProjectWorker --> IngestReportsService[Security::Ingestion::IngestReportsService]
    IngestReportsService --> IngestReportService
    IngestReportsService --> MarkAsResolvedService
    IngestReportsService --> IngestReportSliceService
    end
```

## Alternative Solutions

<!--
It might be a good idea to include a list of alternative solutions or paths considered, although it is not required. Include pros and cons for
each alternative solution/path.

"Do nothing" and its pros and cons could be included in the list too.
-->
