---
title: "GitLab Secret Detection ADR 008: Unified SD Scan Engine"
---

## Context

Currently, the Secret Detection scans are running for different scan target types like Source code (via Pipeline SD), Git commits (Push Protection), Issue description/comments (Client-side SD), and more target types to follow. All the mentioned scan target types have different scan engines (Gitleaks, [one managed by](https://gitlab.com/gitlab-org/security-products/secret-detection/secret-detection-service) the team, another one by Web frontend), and to add complexity to the mix, there are certain teams at GitLab maintaining their version of secret detection. This leads to multiple issues (outlined below) and an inconsistent experience for customers:

* It causes a significant burden of maintaining feature parity across multiple engines.
* It limits us from optimizing the core scanning logic for performance and efficiency.
* It becomes difficult to ensure our ruleset quality(precision and recall) against all the scan engines.
* It also becomes difficult to optimize rule patterns which are generally done against a specific regex engine.
* Inconsistent integration of intelligent scanning capabilities with the engines based on their compatibility.

## Proposal

The proposal is to build a unified Secret Detection core scanning engine that will be used for all the scan target types. The engine's core responsibility will be to run a Secret Detection scan for a given set of payload(s) against the provided scan configuration. The pre-processing (gathering/structuring payload into a scannable format) and the post-processing steps(validity checks etc) will be managed on the caller side. This setup will ensure the reusability of the core scanning logic across all the implementation layers of scan target types.

### Characteristics of the unified scan engine

* The engine is portable. This is crucial considering some scan target types(source code/artifacts) running in an isolated environment like GitLab CI.
* The engine can run transactional or streaming-based scan.
* The engine is cross-platform compatible.
* The engine is stateless by nature.
* The engine is highly resource efficient to be able to run in a resource-constrained environment (like in client IDE or small CI environment).
* The engine is to tweak the scan behavior by accepting user inputs (with defaults):
  * exclusions (rule/path/value)
  * custom ruleset
  * ruleset version
  * timeout constraints
  * payload size limit
  * payloads acceptable via file-path/dir-path/stdin (binary executable)
  * configurable resource(memory/cpu cores) limit (binary executable)
* The engine is able to run as a binary executable in air-gapped environments.

### Pre-requisite

The idea of unified engine could hold true only if we have a scan engine that is highly efficient yet portable by nature. As per the [decision](007_switch_to_go_scan_engine.md), we need to have Vectorscan-based Go scan engine implemented.

### Mode of using the Scan Engine

The minimalistic scope and the stateless nature of the proposed scan engine will open up the _portability_ advantage, which is a necessity for certain target scan types (source code or job artifacts running in CI env). Therefore, the scan engine could be adopted in one of the following three modes depending on the nature of the scan target type (traffic,size,etc.):

* **As a Distributed Service**: The scan engine will be wrapped with a REST/gRPC layer having scan API endpoints. The caller makes the scan request over the network. This mode is suitable for SD features having high traffic with lightweight payloads (\<1MB). Example: Scanning Work Items via [Secret Detection Service](https://gitlab.com/gitlab-org/security-products/secret-detection/secret-detection-service)

* **As an Embedded module**: The core engine in this mode is _embedded_ within the same host as the caller application. The caller invokes the scan for a scannable payload. This mode is transactional by nature. We are already using this mode for the Push Protection feature where the engine is embedded as a Ruby Gem and installed in the Rails monolith. The Rails monolith makes the scan request (including `git diff` data as a scannable payload) to the gem.

![Embedded Mode](/images/engineering/architecture/design-documents/secret_detection/008_scan_mode_embedded.png "Embedded Scan Mode")

* **As a Batch processor**: This is a special case to support [in-storage processing](https://en.wikipedia.org/wiki/In-situ_processing) where the Secret Detection program (+engine) runs where the data resides. This reverse approach is suitable for scan target types having larger data sizes, like source code or job artifacts, to avoid data-transfer costs incurred b/w data storage and scan servers. The primary difference when compared to Embedded mode is that the caller includes the scannable payload within the scan request whereas in Batch mode, the caller points at the scannable payload(s) available at the target host (where the program and data reside), e.g. passing a file path along with the request.

![Batch Mode](/images/engineering/architecture/design-documents/secret_detection/008_scan_mode_batch.jpg "Batch Scan Mode")

#### Adapters

The engine's minimalistic scope of running the scan for the given payload implies that the caller should implement pre-processing and post-processing steps of the scan. Since the scan target types are located at different sources (ex: Rails/CI/Gitaly), it is important to have a consistent implementation approach across all target types for better maintainability. In addition, there is a decent amount of common logic that exist in the pre-processing and post-processing steps across different scan target types which could be reused between Adapters.

We will follow the concept of `Adapters` where an `Adapter` sits between the caller and scan engine abstracting the implementation details, similar to [Language Servers](https://en.wikipedia.org/wiki/Language_Server_Protocol) for IDE. `Adapters` are primarily used in Embedded or Batch mode. 

![Workflow representing Adapters and Scan engine responsibilities](/images/engineering/architecture/design-documents/secret_detection/008_adapters.png "Workflow representation")

**Example Scenario**: We're currently using `gitleaks` scan engine in Pipeline SD scan. Though `gitleaks` offer a lot of functionalities we don't needed, there are three of them needed for this usecase:

1. To traverse through the git commit tree and retrieve diff data for each commit
2. Run secret detection scan on the retrieved content(scannable payload) efficiently (ex: scan parallelly, early-exit through keyword-based match, filter noise/FP on the detected findings through entropy etc.)
3. Create a consumable response as requested by the client via scan params

The above process typically the same for any scan target type where the `Step 1` represents pre-processing phase of the scan, `Step 2` represents the SD Scan operation itself, and finally the `Step 3` represents the post-processing phase of the scan. The pre-processing and post-processing logic are generally scan target type dependent whereas the scan logic is common across.

If we replicate the above process keeping the context of Adapters + Unified scan engine in mind, we would have an `Adapter` (say `SourceCodeAdapter`) responsible for handling pre-processing and post-processing logic whereas the `Scan engine` responsible for running the SD scan for the given scannable payloads. 

Here's the comprehensive view of unified scan engine with the different Adapters, each for a scan target type.

![High-level Design for unified scan engine with Adapters](/images/engineering/architecture/design-documents/secret_detection/008_high_level_design.jpg "High-level Design for unified scan engine with Adapters")

## Distribution

Given there are different modes of using the scan engine and the Vectorscan regex engine being platform-dependent, it is important to identify how the engine is made accessible within GitLab applications.

* When using the engine as a distributed (grpc) service: The grpc service will be deployed using Runway making it accessible to internal GitLab.com applications. The clients can make remote scan request to the service via grpc endpoints.

* When using the engine as an Embedded module or Batch processing: Depending on the client application, the nature of embedding differs. The engine can be imported as a Go module for Go-based applications whereas for Non Go applications (mostly `Ruby` in GitLab Rails), there are two choices:

  1. Write Ruby C extension for a static library generated from Go's scan engine source
  2. Package Go binary executable within GitLab Rails using Omnibus

Considering the VectorScan engine scans on a chunk of data instead of a line-by-line basis (current approach), the [high heap usage problem](https://gitlab.com/gitlab-org/gitlab/-/issues/422574#note_1582015771) is no longer applicable. In addition, Vectorscan engine operates on a pre-allocated [scratch space](https://intel.github.io/hyperscan/dev-reference/runtime.html#scratch-space) contributing to the lower memory consumption of the overall scan. The throughput of calling Go methods via C-function adds barely any overhead when compared to IPC between Ruby <-> Go processes. All that said, the decision is leaning towards writing Ruby C extension. However, we are yet to conduct a spike to confirm this decision with a data-driven evidence.
