---
title: "Supply Chain Risk Management Strategy"
description: "This page outlines GitLab's comprehensive approach to supply chain risk management, providing a structured framework for identifying, assessing, and mitigating risks across the software development lifecycle while advancing toward higher SLSA compliance levels."
---

## Introduction

This page outlines GitLab's comprehensive strategy for identifying, assessing, and mitigating risks within our software supply chain. Our risk-based approach is designed to protect both our own data and our customers' data while progressively advancing towards higher levels of Supply chain Levels for Software Artifacts (SLSA) compliance.

## Goals and Objectives

- Identify and mitigate risks to GitLab's internal data assets throughout the supply chain
- Safeguard our customers' data by ensuring the integrity and security of our software delivery pipeline
- Achieve and maintain progressively higher levels of SLSA compliance through risk-focused improvements
- Establish comprehensive visibility and traceability to detect supply chain threats and vulnerabilities
- Implement a proactive risk management framework to address emerging supply chain threats
- Create a measurable approach to reduce supply chain attack surfaces
- Support and enhance the [Product Security Risk Register (PSRR)](/handbook/security/product-security/security-platforms-architecture/risk-register/) with structured supply chain risk data and analysis

## Supply Chain Component Model

### Decomposing Supply Chain Complexity

GitLab's complete supply chain is too complex to represent in a single comprehensive diagram. Instead, we break down this complexity into manageable components using a recursive model:

- Each artifact has its own supply chain
- Each artifact's supply chain may depend on other artifacts, which have their own supply chains
- This creates a directed graph structure where:
  - Root nodes are the distributed artifacts (our final products)
  - Internal nodes are intermediate artifacts and components
  - Leaf nodes represent the boundaries of our supply chain (external components)

We focus our inventory and management efforts on artifacts and components within GitLab's direct control. For external components (leaf nodes), we track their origin and basic metadata but do not attempt to document their entire supply chains at this stage.

### SLSA Supply Chain Model

We align our supply chain tracking with the SLSA framework ([Specification 1.1](https://slsa.dev/spec/v1.1/)), which defines three key areas to secure:

![SLSA Supply Chain Model](/images/security/product-security/supply-chain-risk-management/supply-chain-model.svg)

This model illustrates the core steps we track:

1. **Source**: Where code is authored, reviewed, and stored
1. **Build**: Where source is transformed into packages/artifacts
1. **Distribution**: Where built artifacts are stored and distributed

The model also depicts:

- **Producer**: The entity responsible for creating the software
- **Consumer**: The entity consuming the software (another supply chain, or end-user)
- **Dependencies**: Internal and external components that feed into the Build and Distribution processes

For each artifact in our supply chain, we track its path through these three core steps, documenting controls and provenance at each stage.

### Supply Chain component types

Our model identifies specific component types within each core step of the supply chain. These types serve as reference elements to be used when describing a particular subset of the supply chain. Note that not all components will be present in every supply chain - the categorization below provides a framework for comprehensive modeling.

These types are linked to [SLSA threats](https://slsa.dev/spec/v1.1/threats) in the PSRR to create comprehensive risks, see the "[Threats](#threats)" section below. Risks can be linked to a subtype if more granularity is needed.

#### Source components

The Source core step includes everything that can edit and alter the source code before the Build step:

| Component type | Sub type | Label |
| -- | -- | -- |
| **Development Dependencies** | (Wraps all sub-types below) | `~sscs-rm-component:src:dev-dependencies` |
|  | Development environment setup tools and dependencies (ex: [asdf](https://asdf-vm.com/)/[mise](https://mise.jdx.dev/)) | `~sscs-rm-component:src:dev-setup-tools` |
|  | IDEs (including extensions and plugins) | `~sscs-rm-component:src:IDEs` |
|  | Docker images | `~sscs-rm-component:src:docker-images` |
|  | Pre-commit hooks | `~sscs-rm-component:src:pre-commit-hooks` |
|  | Local code formatters and linters | `~sscs-rm-component:src:linters` |
| **GitLab Repositories** | (Wraps all sub-types below) | `~sscs-rm-component:src:repo` |
|  | Project configuration | `~sscs-rm-component:src:repo-config` |
|  | [Code Owners](https://docs.gitlab.com/user/project/codeowners/) configuration | `~sscs-rm-component:src:repo-code-owners` |
|  | Repository access controls | `~sscs-rm-component:src:repo-access-control` |

#### Build components

The Build core step includes everything that can transform the source code (compilation, linting, etc.) and produce an artifact:

| Component type | Sub type | Label |
| -- | -- | -- |
| **CI/CD** | (Wraps all sub-types below) | `~sscs-rm-component:build:ci-cd` |
|  | GitLab Runners | `~sscs-rm-component:build:gitlab-runners` |
|  | CI/CD templates | `~sscs-rm-component:build:ci-templates` |
|  | CI/CD Components | `~sscs-rm-component:build:ci-components` |
| **Build images** | (Wraps all sub-types below) | `~sscs-rm-component:build:build-images` |
|  | Base Docker images | `~sscs-rm-component:build:base-docker-images` |
|  | Intermediate images | `~sscs-rm-component:build:intermediate-images` |
|  | Container build tools | `~sscs-rm-component:build:container-build-tools` |
|  | Container registry | `~sscs-rm-component:build:container-registry` |
| **Runtime Dependencies** | (Wraps all sub-types below) | `~sscs-rm-component:build:runtime-dependencies` |
|  | Ruby Gems | `~sscs-rm-component:build:ruby-gems` |
|  | NPM packages | `~sscs-rm-component:build:npm-packages` |
|  | Go modules | `~sscs-rm-component:build:go-modules` |
|  | Python packages | `~sscs-rm-component:build:python-packages` |
|  | Other language-specific dependencies | `~sscs-rm-component:build:other-packages` |
| **Secrets** | (Wraps all sub-types below) | `~sscs-rm-component:build:secrets` |
|  | Vault | `~sscs-rm-component:build:vault` |
|  | CI/CD variables | `~sscs-rm-component:build:ci-variables` |
|  | Key management systems | `~sscs-rm-component:build:key-management` |
|  | Certificate authorities | `~sscs-rm-component:build:certificate-authorities` |
|  | Signing infrastructure | `~sscs-rm-component:build:signing-infra` |

#### Distribution components

| Component type | Sub type | Label |
| -- | -- | -- |
| **Registries** | (Wraps all sub-types below) | `~sscs-rm-component:dis:registries` |
|  | Package registry | `~sscs-rm-component:dis:package-registry` |
|  | Container registry | `~sscs-rm-component:dis:container-registry` |
| **Distribution Infrastructure** | (Wraps all sub-types below) | `~sscs-rm-component:dis:distribution-infra` |
|  | CDNs | `~sscs-rm-component:dis:cdns` |
|  | Mirror services | `~sscs-rm-component:dis:mirror-services` |
|  | Download servers | `~sscs-rm-component:dis:download-servers` |
| **Verification Systems** | (Wraps all sub-types below) | `~sscs-rm-component:dis:verification-systems` |
|  | Signature verification | `~sscs-rm-component:dis:signature-verification` |
|  | Checksumming services | `~sscs-rm-component:dis:checksumming-services` |
|  | Attestation systems | `~sscs-rm-component:dis:attestation-systems` |

### SLSA 1.1 Alignment

This framework is based on the Supply chain Levels for Software Artifacts (SLSA) specification 1.1. We deliberately adopt SLSA terminology and concepts to ensure consistency with industry standards and facilitate compliance efforts. Key SLSA elements incorporated into our model include:

- Build provenance documentation
- Source verification
- Build integrity controls
- Artifact authentication
- Access control requirements

#### Threats

SLSA [defines a set of threats](https://slsa.dev/spec/v1.1/threats) that are used in the PSRR to link elements of the model to risks:

![SLSA Threats](/images/security/product-security/supply-chain-risk-management/supply-chain-threats.svg)

| Threat area | Threat | Description | Label |
| -- | -- | -- | -- |
| Source | [(A) Producer](https://slsa.dev/spec/v1.1/threats#a-producer) | Software producer intentionally creates a malicious revision of the source | `~sscs-rm-threat::a-malicious-source` |
| | [(B) Modifying the source](https://slsa.dev/spec/v1.1/threats#b-modifying-the-source) -> [(B1) Submit change without review](https://slsa.dev/spec/v1.1/threats#b1-submit-change-without-review) | Directly submit without review | `~sscs-rm-threat::b1-submit-without-review` |
| | | Single actor controls multiple accounts | `~sscs-rm-threat::b1-actor-controls-multiple-accounts` |
| | | Use a robot account to submit change | `~sscs-rm-threat::b1-robot-account-submit` |
| | | Abuse of rule exceptions | `~sscs-rm-threat::b1-abuse-rule-exceptions` |
| | | Highly-permissioned actor bypasses or disables controls | `~sscs-rm-threat::b1-bypass-controls` |
| | [(B) Modifying the source](https://slsa.dev/spec/v1.1/threats#b-modifying-the-source) -> [(B2) Evade change management process](https://slsa.dev/spec/v1.1/threats#b2-evade-change-management-process) | Modify code after review | `~sscs-rm-threat::b2-modify-after-review` |
| | | Submit a change that is unreviewable | `~sscs-rm-threat::b2-unreviewable-change` |
| | | Copy a reviewed change to another context | `~sscs-rm-threat::b2-copy-to-another-context` |
| | | Commit graph attacks | `~sscs-rm-threat::b2-commit-graph-attacks` |
| | [(B) Modifying the source](https://slsa.dev/spec/v1.1/threats#b-modifying-the-source) -> [(B3) Render code review ineffective](https://slsa.dev/spec/v1.1/threats#b3-render-code-review-ineffective) | Collude with another trusted person | `~sscs-rm-threat::b3-collusion` |
| | | Trick reviewer into approving bad code | `~sscs-rm-threat::b3-trick-reviewer` |
| | | Reviewer blindly approves changes | `~sscs-rm-threat::b3-blind-approval` |
| | [(B) Modifying the source](https://slsa.dev/spec/v1.1/threats#b-modifying-the-source) -> [(B4) Render change metadata ineffective](https://slsa.dev/spec/v1.1/threats#b4-render-change-metadata-ineffective) | Forge change metadata | `~sscs-rm-threat::b4-forge-metadata` |
| | [(C) Source code management](https://slsa.dev/spec/v1.1/threats#c-source-code-management) | Platform admin abuses privileges | `~sscs-rm-threat::c-admin-abuse` |
| | | Exploit vulnerability in SCM | `~sscs-rm-threat::c-exploit-scm-vulnerability` |
| Build | [(D) External build parameters](https://slsa.dev/spec/v1.1/threats#d-external-build-parameters) | Build from unofficial fork of code | `~sscs-rm-threat::d-unofficial-fork` |
| | | Build from unofficial branch or tag | `~sscs-rm-threat::d-unofficial-branch` |
| | | Build from unofficial build steps | `~sscs-rm-threat::d-unofficial-steps` |
| | | Build from unofficial parameters | `~sscs-rm-threat::d-unofficial-parameters` |
| | | Build from modified version of code modified after checkout | `~sscs-rm-threat::d-modified-after-checkout` |
| | [(E) Build process](https://slsa.dev/spec/v1.1/threats#e-build-process) | Forge values of the provenance (other than output digest) | `~sscs-rm-threat::e-forge-provenance-values` |
| | | Forge output digest of the provenance | `~sscs-rm-threat::e-forge-output-digest` |
| | | Compromise project owner | `~sscs-rm-threat::e-compromise-owner` |
| | | Compromise other build | `~sscs-rm-threat::e-compromise-other-build` |
| | | Steal cryptographic secrets | `~sscs-rm-threat::e-steal-secrets` |
| | | Poison the build cache | `~sscs-rm-threat::e-poison-cache` |
| | | Compromise build platform admin | `~sscs-rm-threat::e-compromise-platform-admin` |
| | [(F) Artifact publication](https://slsa.dev/spec/v1.1/threats#f-artifact-publication) | Build with untrusted CI/CD | `~sscs-rm-threat::f-untrusted-cicd` |
| | | Upload package without provenance | `~sscs-rm-threat::f-upload-without-provenance` |
| | | Tamper with artifact after CI/CD | `~sscs-rm-threat::f-tamper-after-cicd` |
| | | Tamper with provenance | `~sscs-rm-threat::f-tamper-with-provenance` |
| | [(G) Distribution channel](https://slsa.dev/spec/v1.1/threats#g-distribution-channel) | Build with untrusted CI/CD | `~sscs-rm-threat::g-untrusted-cicd` |
| | | Issue VSA from untrusted intermediary | `~sscs-rm-threat::g-untrusted-vsa` |
| | | Upload package without provenance or VSA | `~sscs-rm-threat::g-upload-without-verification` |
| | | Replace package and VSA with another | `~sscs-rm-threat::g-replace-package-vsa` |
| | | Tamper with artifact after upload | `~sscs-rm-threat::g-tamper-after-upload` |
| | | Tamper with provenance or VSA | `~sscs-rm-threat::g-tamper-verification` |
| Usage | [(H) Package selection](https://slsa.dev/spec/v1.1/threats#h-package-selection) | Dependency confusion | `~sscs-rm-threat::h-dependency-confusion` |
| | | Typosquatting | `~sscs-rm-threat::h-typosquatting` |
| | [(I) Usage](https://slsa.dev/spec/v1.1/threats#i-usage) | Improper usage | `~sscs-rm-threat::i-improper-usage` |
| Dependency | [Build dependency](https://slsa.dev/spec/v1.1/threats#build-dependency) | Include a vulnerable dependency | `~sscs-rm-threat::dep-vulnerable-dependency` |
| | | Use a compromised build tool | `~sscs-rm-threat::dep-compromised-build-tool` |
| | | Use a compromised runtime dependency during the build | `~sscs-rm-threat::dep-compromised-runtime-dependency` |

## Integration with the Product Security Risk Register

The Supply Chain Risk Management Strategy serves as a critical foundation for the [Product Security Risk Register (PSRR)](/handbook/security/product-security/security-platforms-architecture/risk-register/). Each supply chain-related risk identified in the PSRR must be linked to specific elements within this supply chain model:

1. **Risk Mapping Requirements**

   - Every supply chain risk in the PSRR must reference specific components from this model
   - By extension, risks identifies which part of the supply chain step is affected (Source, Build, or Distribution)
   - Risk documentation can include specific artifacts involved
   - The potential for risk propagation through the supply chain should be documented

1. **Bidirectional Traceability**

   - Supply chain model components must link back to relevant PSRR risk items (see labels above)
   - PSRR entries must link to the affected supply chain components
   - Updates to the supply chain model should trigger reviews of related PSRR entries
   - New PSRR risks related to supply chain must be mapped to this model during risk registration

1. **Unified Risk Assessment Approach**

   - The risk scoring methodology must be consistent between this model and the PSRR
   - Supply chain risk mitigations documented in the PSRR should align with controls in this model
   - Risk acceptance decisions should consider the full context of the supply chain graph

This integration ensures a comprehensive approach to supply chain risk management that leverages our existing security frameworks while providing deeper visibility into supply chain-specific threats.

## How to Use This Model

### For Development Teams

{{% alert title="Note" color="primary" %}}
The following items represent future/North Star requests and are not current requirements.
{{% /alert %}}

1. **Artifact Documentation**

   - For each new artifact type, document its source components
   - Register artifact in the central inventory (see https://gitlab.com/groups/gitlab-org/-/epics/16484)

1. **Compliance Verification**

   - Regular self-assessments against the model requirements
   - Document evidence of control implementation
   - Participate in periodic supply chain reviews

### For Security Teams

1. **Risk Monitoring and Intelligence**

   - Implement continuous risk monitoring for registered components
   - Conduct regular threat hunting across the supply chain ecosystem
   - Maintain a supply chain threat intelligence program
   - Establish risk thresholds and escalation procedures for detected anomalies

1. **Risk-Based Audit Support**

   - Maintain risk evidence collection for compliance purposes
   - Support external audits with risk assessment documentation
   - Verify the implementation and effectiveness of risk controls across teams
   - Develop risk-focused audit narratives and documentation

1. **Risk Model Evolution**

   - Update the risk model as new threats and attack techniques emerge
   - Refine risk classification criteria based on incident data and operational feedback
   - Ensure alignment with evolving SLSA requirements and industry threat landscape
   - Conduct periodic red team exercises to test supply chain security resilience

## Risk Management Metrics and Success Criteria

{{% alert title="Note" color="primary" %}}
The following metrics represent future/North Star indicators. These are not currently tracked and are subject to changes.
{{% /alert %}}

Success in our supply chain risk management strategy will be measured by:

| Metric | Possible methodology | Dependencies |
| -- | -- | -- |
| Completeness of risk assessment coverage across all components and artifacts | Track threat models done for each component. | [Inventory of GitLab public artifacts](https://gitlab.com/gitlab-com/gl-security/product-security/security-architecture/general/-/issues/73) |
| Quantifiable reduction in supply chain security incidents and vulnerabilities | Create new labels to track down incidents and vulnerabilities related to our supply chain. | AppSec team |
| Decreased mean time to detect and respond to supply chain threats | Risks in the PSRR should have remediation issues linked, but also detection issues. | PSRR |
| Progressive achievement of higher SLSA levels with documented risk reduction | Track implemented [SLSA requirements](https://slsa.dev/spec/v1.1/requirements). | This [Epic](https://gitlab.com/groups/gitlab-org/-/epics/15857) for SLSA Level 3 support. |
| Successful passing of external security audits with minimal findings | Map findings related to supply chain. Loop back with coverage above to make sure previously unknown risks are logged. | SecAssurance / AppSec |
| Improved visibility and quantification of supply chain risks and dependencies | Track "dead-ends" in supply chains (missing information). | Each risk is labeled correctly in the PSRR & [Inventory of GitLab public artifacts](https://gitlab.com/gitlab-com/gl-security/product-security/security-architecture/general/-/issues/73) |
| Reduced number of critical and high-risk components in the supply chain | Number of components with risk score above a shreshold. | PSRR |

