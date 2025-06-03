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

### Scanning Modes

The minimalistic scope and the stateless nature of the proposed scan engine will open up the _portability_ advantage, which is a necessity for certain target scan types (source code or job artifacts running in CI env). Therefore, the scan engine could be adopted in one of the following three modes depending on the nature of the scan target type (traffic,size,etc.):

* **Distributed Service:** The scan engine will be wrapped with a REST/gRPC layer having scan API endpoints. The caller makes the scan request over the network. This mode is suitable for SD features having high traffic with lightweight payloads (\<1MB). Example: Scanning Work Items via [Secret Detection Service](https://gitlab.com/gitlab-org/security-products/secret-detection/secret-detection-service)

* **Embedded**: The core engine in this mode is _embedded_ within the same host as the caller application. The caller invokes the scan for a scannable payload. This mode is transactional by nature. We are already using this mode for the Push Protection feature where the engine is embedded as a Ruby Gem and installed in the Rails monolith. The Rails monolith makes the scan request (including `git diff` data as a scannable payload) to the gem.

![Embedded Mode](/images/engineering/architecture/design-documents/secret_detection/008_scan_mode_embedded.png "Embedded Scan Mode")

* **Batch**: This is a special case to support [in-storage processing](https://en.wikipedia.org/wiki/In-situ_processing) where the Secret Detection program (+engine) runs where the data resides. This reverse approach is suitable for scan target types having larger data sizes, like source code or job artifacts, to avoid data-transfer costs incurred b/w data storage and scan servers. The primary difference when compared to Embedded mode is that the caller includes the scannable payload within the scan request whereas in Batch mode, the caller points at the scannable payload(s) available at the target host (where the program and data reside), e.g. passing a file path along with the request.

![Batch Mode](/images/engineering/architecture/design-documents/secret_detection/008_scan_mode_batch.jpg "Batch Scan Mode")

#### Adapters

The engine's minimalistic scope of running the scan for the given payload implies that the caller should implement pre-processing and post-processing steps of the scan. Since the scan target types are located at different sources (ex: Rails/CI/Gitaly), it is important to have a consistent implementation approach across all target types for better maintainability and reusability.

We will follow the concept of `Adapters` where an `Adapter` sits between the caller and scan engine abstracting the implementation details, similar to [Language Servers](https://en.wikipedia.org/wiki/Language_Server_Protocol) for IDE. `Adapters` are primarily used in Embedded or Batch mode. Example: `SourceCodeAdapter` for scanning git-based source code in Pipeline-based SD, or `JobArtifactAdapter` for scanning job artifacts.

![High-level Design for unified scan engine with Adapters](/images/engineering/architecture/design-documents/secret_detection/008_high_level_design.png "High-level Design for unified scan engine with Adapters")
