---
title: Beyond Feature Gates - Unified Platform Delivery Vision
status: proposed
creation-date: "2025-07-10"
authors: [ "@nolith" ]
coaches: [ ]
dris: [ ]
owning-stage: "~devops::gitlab delivery"
participating-stages: []
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!--
Document statuses you can use:

- "proposed"
- "accepted"
- "ongoing"
- "implemented"
- "postponed"
- "rejected"

-->

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

{{< engineering/design-document-header >}}

## Summary

Feature Gates represent a fundamental shift in how GitLab delivers features across our complete platform portfolio. This document outlines a unified vision that extends beyond traditional feature flags to create a comprehensive feature delivery framework spanning four platform types: Multi Tenant SaaS, GitLab Dedicated, GitLab Dedicated for Government, and Self Managed instances.

The proposed system introduces a structured development lifecycle with four distinct stages: **Discovery**, **Experiments**, **Beta**, and **Public Availability**, with an additional **Pending ATO** stage specifically designed to address compliance requirements for regulated government environments. This framework provides complete separation of feature release processes between platforms while maintaining unified development workflows.

At its core, this vision addresses the strategic need to balance rapid innovation velocity with compliance requirements, infrastructure isolation, and customer choice across our diverse platform offerings. The system enables gradual rollout strategies that support both stabilizing GitLab.com and improving the quality of our monthly releases, with the goal of growing ARR across all the platforms, while providing government customers with the compliance controls they require.

## Motivation

GitLab's evolution from a single self-managed product to a comprehensive platform portfolio serving diverse customer segments has created fundamental challenges in feature delivery. Our current feature flag system, designed for a monolithic Rails application, cannot adequately serve the needs of our expanding service architecture, compliance requirements, and varied customer risk profiles.

### Current State Challenges

The [Feature Gates Gap Analysis](https://docs.google.com/document/u/0/d/1eQuUTiiM8PzFs--NDgOacOa6m9Sqwh5A9sHvWsTMfnI/edit) with 36 team members identified critical pain points:

* **Managing dependencies between flags (56%)**: Complex interdependent flag relationships
* **Maintaining too many flags (50%)**: Technical debt accumulation
* **Poor visibility into active flags (42%)**: Lack of comprehensive oversight
* **Metrics/data visibility (42%)**: Insufficient correlation between flags and system behavior
* **Testing complexity (31%)**: Difficulty testing flag combinations across environments

These challenges are compounded by our platform diversification, where different customer segments require fundamentally different approaches to feature delivery and risk management; like being intentional on what type of customers receive features in the "Discovery" stage, or having good visibility in SLA breaches caused by features in "Experiment" and "Beta" stage.

### Strategic Imperatives

**Platform Diversification**: GitLab now serves four distinct platform types, each with unique operational, compliance, and customer requirements. Our feature delivery system must accommodate these differences while maintaining development efficiency.

**Compliance and Regulatory Requirements**: Government customers, requiring FedRAMP authorization, need granular control over feature adoption with formal approval processes. Our current system—with its monthly release cadence and 3-month security support window—creates a fundamental timing conflict: Significant Change Requests can take up to 3 months, potentially exceeding our security support timeline. This forces us into difficult choices between delaying government deployments or extending security support on an ad-hoc basis. The introduction of GitLab Dedicated for Government with Moderate FedRAMP ATO requires a more flexible approach to feature delivery that can accommodate these extended review cycles while maintaining security compliance.

**Infrastructure Evolution**: The ongoing Cells project introduces new concepts of rings and infrastructure isolation that create opportunities for more sophisticated rollout strategies when combined with feature gates. This creates a unified model where users are both physically located within a specific cell and logically assigned to a corresponding ring that represents their risk acceptance factor. The ring assignment serves dual purposes: determining infrastructure deployment boundaries and defining feature rollout risk profiles, enabling consistent and predictable rollout strategies across the entire user base.

**Incident Mitigation**: Production incidents like [INC-851](https://gitlab.com/gitlab-com/gl-infra/production/-/issues/19806) demonstrate the critical need for feature gates that operate independently of the Rails monolith, enabling rapid incident response without full system restarts.

### Goals

1. **Unified Feature Delivery Framework**: Create a consistent approach to feature delivery across all GitLab platforms while respecting each platform's unique requirements
2. **Compliance-First Architecture**: Build compliance considerations into the core feature delivery workflow, enabling seamless support for government and regulated customers
3. **Developer Velocity**: Maintain high development velocity while providing comprehensive safety controls and rollback mechanisms
4. **Operational Excellence**: Provide comprehensive visibility, metrics, and automated workflows that reduce operational overhead and improve incident response times
5. **Customer Choice**: Enable customers to control their exposure to new Experiments and Beta features according to their risk tolerance

### Non-Goals

* **Migration of the existing feature flags**: This document does not propose migrating existing feature flags to the new system, those will either be removed or converted to settings as an independent effort
* **Implementation timeline**: Specific implementation schedules and resource allocation are out of scope
* **Detailed technical specifications**: Technical implementation details will be addressed in subsequent technical design documents

## Proposal

### Unified Development Lifecycle

The Feature Gates framework builds upon GitLab's existing [Experimental, Beta, and Public Availability workflow](https://docs.gitlab.com/policy/development_stages_support/), extending it with two critical additions: a new **Discovery** stage for internal development validation and a **Pending ATO** stage designed for compliance workflows.

![The five stages of development](/images/engineering/architecture/design-documents/beyond_feature_gates/stages.svg)
[Image source](https://docs.google.com/drawings/d/11fICSZtbBQ60XkKYj10cfGmLVTiUPMU3z4eesXi5nw8/edit)

This enhanced five-stage development lifecycle provides clear progression paths for all features while accommodating platform-specific requirements:

#### Discovery Stage

Every new feature begins in the Discovery stage, available exclusively on unregulated environments we control (Multi Tenant SaaS and GitLab Dedicated). This stage serves as the foundation for internal validation and initial testing:

* **Exclusive Internal Access**: Features are initially available only to the specific development team that built the feature and their associated product manager
* **Gradual Internal Rollout**: Progressive enablement from development teams → GitLab employees → controlled user segments
* **Platform Availability**: Multi Tenant SaaS and GitLab Dedicated only
* **Gate Behavior**: Explicitly controlled, defaults to OFF

#### Experiments Stage

Features requiring extended development cycles and early user feedback transition to Experiments:

* **Opt-in User Access**: Customers can explicitly enable experimental features through a new Feature Preview panel
* **Platform Availability**: Multi Tenant SaaS, GitLab Dedicated, and Self Managed
* **Feedback Integration**: Formal feedback collection and processing workflows
* **Gate Behavior**: Available through Feature Preview panel, disabled by default

#### Beta Stage

Mature experimental features progress to Beta for broader validation:

* **Expanded Access**: Wider customer opt-in availability with clearer support expectations
* **Platform Availability**: Multi Tenant SaaS, GitLab Dedicated, and Self Managed
* **Stability Expectations**: Higher reliability standards with defined support levels
* **Gate Behavior**: Available through Feature Preview panel, disabled by default

#### Pending ATO Stage

A new stage specifically designed to address compliance requirements:

* **Compliance Review**: Features undergo formal compliance assessment for government deployment
* **Platform Behavior**:
  * **Multi Tenant SaaS/GitLab Dedicated**: Automatically enabled (transparent to users)
  * **GitLab Dedicated for Government**: Remains disabled pending ATO approval
  * **Self Managed**: Follows Multi Tenant SaaS behavior
* **Gate Persistence**: Feature gate code remains in place, potentially useful for emergency situations in all SaaS

#### Public Availability Stage

The final stage representing full feature maturity:

* **Universal Access**: Available across all platforms without restrictions
* **Gate Removal**: Feature gate code can be safely removed from codebase
* **Platform Availability**: All platforms (Multi Tenant SaaS, GitLab Dedicated, GitLab Dedicated for Government, Self Managed)
* **Compliance Status**: Approved for all deployment scenarios

### Platform-Specific Behaviors

![The five stages of development by platform](/images/engineering/architecture/design-documents/beyond_feature_gates/stages_by_platform.svg)
[Image source](https://docs.google.com/drawings/d/1sdhfZbAKSx89Mikcv7JB1rYnGdLPxfjL6fnSGM4pS1w/edit)

#### Multi Tenant SaaS

* **Full Lifecycle Support**: All stages from Discovery through Public Availability
* **Automatic Progression**: Features automatically enabled when reaching Pending ATO
* **Risk Tolerance**: Highest tolerance for experimental features
* **User Controls**: Comprehensive Feature Preview panels for opt-in/opt-out

#### GitLab Dedicated

* **Full Lifecycle Support**: All stages from Discovery through Public Availability
* **Automatic Progression**: Features automatically enabled when reaching Pending ATO
* **Risk Profile**: Moderate risk tolerance with customer-specific controls
* **User Controls**: Admin-level Feature Preview panels with granular control

#### GitLab Dedicated for Government (FedRAMP)

* **Restricted Lifecycle**: Only Discovery (internal) and Public Availability stages
* **ATO Gating**: Features blocked at Pending ATO until formal approval
* **Compliance First**: No access to unapproved features regardless of customer preference
* **User Controls**: Post-approval admin controls for approved features only

#### Self Managed

* **Transparent Operation**: Pending ATO stage transparent (follows Multi Tenant SaaS behavior)
* **Customer Control**: Full Feature Preview capabilities for Experiments and Beta
* **Autonomous Operation**: No external API dependencies for feature gate evaluation
* **Upgrade Path**: Features progress with version upgrades

### Feature Preview Panel and Cascading Controls

A cornerstone of the Feature Gates framework is the **Feature Preview Panel** \- an interface that enables hierarchical feature control across different organizational levels. This system introduces cascading controls that GitLab currently lacks, providing flexibility in feature adoption.

#### Feature Channel Strategy

The Feature Preview Panel presents features through channel-based organization:

* **Stable Channel**: Only features in Public Availability stage
* **Beta Channel**: Includes Beta and Public Availability features
* **Experimental Channel**: Includes Experimental, Beta, and Public Availability features

This channel approach simplifies feature management by providing predefined feature sets while maintaining granular control for specific features when needed.

![Features preview UI](/images/engineering/architecture/design-documents/beyond_feature_gates/features_preview_ui.png)
[Image source](https://lucid.app/lucidchart/8a29132d-1509-4ff7-ae96-640690c6934d/edit?page=0_0&invitationId=inv_905a3df6-4864-43e4-9187-d8ce14197b04#)

#### Hierarchical Control Architecture

Not all features affect the whole system. Some are instance wide, others could be relevant at organization, group, project, or user level. We want to empower cascading control flow, where an experiment or beta is available only if enabled at a higher level.

The Feature Preview Panel operates on a cascading control model where higher-level owners set policies that flow down through organizational boundaries:

**Feature Gates Server** (SaaS Only):

* Ultimate control authority for all features not yet in Public Availability
* Provides main kill-switch capability for emergency feature disabling
* Available only on GitLab-controlled SaaS environments
* Can override all lower-level settings when features need to be disabled globally
* Not accessible to the instance admin, only the platform operators can access it

**Instance Administrator Level**:

* Selects overall feature channel policy (Stable, Beta, Experimental)
* Sets baseline feature enablement for the entire instance
* Can override individual feature toggles for compliance or operational reasons
* Operates only with features that reached the Experiment or Beta stages

**Organization/Group/Project Level** (where applicable):

* Inherits policies from the level above
* Can optionally disable a feature that was approved at higher level
* Disabling a feature, makes it unavailable to the lower entities

**User Level**:

Some features are designed to only affect users, in that case the hierarchy of controls is Instance/Organization/User

* Final control layer for individual user preferences
* Can only disable features enabled at higher levels

#### Current State Gap

Today, GitLab lacks this hierarchical control structure. Experiment and Beta features toggles are typically implemented on a case by case basis, usually controlled by a main feature flag and without the ability to delegate controlled access to different organizational levels. The Feature Preview Panel addresses this gap by providing:

* **Organizational Autonomy**: Groups and projects can adopt features within policy boundaries
* **Administrative Control**: Instance admins maintain compliance and operational oversight
* **User Choice**: End users can fine-tune their experience within organizational policies

### Integration with Infrastructure Evolution

#### Cells and Rings Synergy

The Feature Gates framework creates powerful synergy with the ongoing Cells project:

* **Ring-based Rollouts**: Feature gates can leverage ring concepts for progressive rollouts
* **Infrastructure Isolation**: Cells provide infrastructure isolation, Feature Gates provide feature isolation
* **Unified Mental Model**: Rings serve as a common concept across Product, Development, and Infrastructure teams
* **Risk Mitigation**: Combined approach provides multiple layers of blast radius control

#### Deployment Strategy Evolution

Enhanced deployment strategies enable immediate benefits:

* **Code Deployment Isolation**: Improved deployment isolation strategies
* **Feature Release Isolation**: Feature-level control through Feature Gates
* **Progressive Rollout**: Ring-by-ring feature enablement strategies
* **Incident Response**: Multiple intervention points for issue mitigation

### Compliance and Continuous Monitoring Integration

#### ConMon Framework Alignment

The Feature Gates backend could provide structured integration with Continuous Monitoring requirements:

* **Compliance Dashboard**: Organized overview of pending compliance items
* **Approval Workflows**: Integrated approval tracking and documentation
* **Audit Trail**: Comprehensive logging of all feature gate state changes
* **Automated Reporting**: Integration with monthly compliance reporting cycles

#### ATO Process Integration

* **Submission Tracking**: Automated tracking of features submitted for ATO review
* **Review Status**: Real-time visibility into compliance review progress
* **Approval Implementation**: Streamlined process for enabling approved features
* **Emergency Controls**: Rapid feature disabling capabilities for incident response

## Design and Implementation Details

### Architecture Principles

#### Cross-Platform SDK

* **Unified Interface**: Consistent API across Ruby, JavaScript, and Go
* **Platform Independence**: No dependency on Rails monolith for feature gate evaluation
* **Local Caching**: Robust caching strategies to ensure performance and reliability
* **Fallback Mechanisms**: Graceful degradation when feature gate service is unavailable

#### Hierarchical Control Model

This principle is limited to the Experiment and Beta stages.

An instance level controls for overall feature policy, with cascading toggles at Organization, Group, Project and User to opt-out from approved features.

#### Automated Lifecycle Management

* **Usage Tracking**: Comprehensive instrumentation of feature gate evaluation
* **Lifecycle Progression**: Automated identification of features ready for stage progression
* **Cleanup Automation**: Automated identification of gates ready for removal
* **Dependency Management**: Explicit tracking and validation of feature dependencies

### Testing and Quality Assurance

#### Mandatory Test Configurations

Four parallel test configurations ensure comprehensive coverage:

1. **Default Configuration**: All gates set to default values (Self Managed simulation)
2. **Full Enablement**: All gates enabled (maximum feature coverage)
3. **Production Mirror**: Gates match current Multi Tenant SaaS configuration (reality testing)
4. **FedRAMP mode**: All gates set to OFF

### Operations and Monitoring

#### Comprehensive Metrics

* **Error Rate Correlation**: Automated correlation of error rates with gate state changes
* **Performance Impact**: Measurement of feature gate impact on system performance
* **User Engagement**: Tracking of user interaction with gated features
* **Adoption Analytics**: Feature adoption rates across different user segments

#### Incident Response Integration

* **incident.io Integration**: API interface for rapid feature disabling during incidents
* **Log integration**: log traversed gates in case of errors
* **Emergency Workflows**: Predefined workflows for common incident scenarios
* **Rollback Automation**: Automated feature rollback capabilities
* **Communication Integration**: A overview panel with feature disabled due to an incident

#### Management Interface

* **Role-Based Access**: Differentiated interfaces for Developers, SRE, and Product Managers
* **Workflow Guidance**: Integrated predefined workflows for safe feature rollouts
* **Approval Tracking**: Comprehensive tracking of all approval processes (manual and automated)
* **Audit Capabilities**: Complete audit trails for compliance and operational review

## Alternative Solutions

### Enhanced Current System

**Description**: Evolve the existing Rails-based feature flag system built on the Flipper gem to support additional platforms and requirements.

**Pros**:

* Lower initial implementation cost
* Familiar to current development teams
* Existing knowledge and tooling

**Cons**:

* Cannot address cross-platform service architecture requirements
* Maintains monolithic dependencies
* Does not solve compliance workflow needs or government platform requirements
* Limited ability to operate independently during Rails monolith incidents

### Branch-Based Release Control

**Description**: Leverage [Git branch strategies and deployment pipelines](https://docs.google.com/document/d/15PFtN-r0KsTID83Fz5Xs34OUIf_6xM9mfP7QQJEmaqo/edit?tab=t.2lak1sm5zdwc#bookmark=id.6d1pygd6uh2) to control feature releases without runtime feature gates.

**Pros**:

* No runtime performance impact from feature flag evaluation
* No need to build or integrate an advanced feature flag solution
* Simplifies testing by eliminating flag combination complexity

**Cons**:

* Cannot provide runtime feature disabling for incident response
* Lacks granular user-level or organization-level control capabilities
* Does not support gradual rollout strategies or A/B testing scenarios
* Cannot address compliance requirements for selective feature approval
* Incompatible with the cascading control model required for diverse customer segments
* Does not enable the rapid incident mitigation capabilities essential for SaaS operations
* Extremely complex workflow to accommodate the differences between our platforms
* High risk of merge conflicts, resulting in reduced velocity and increased integration testing

## Conclusion

The Feature Gates unified platform delivery vision represents a strategic investment in GitLab's ability to serve diverse customer segments while maintaining development velocity and operational excellence. By introducing structured development lifecycle stages with built-in compliance considerations, we create a framework that scales with our platform diversification while providing the safety and control mechanisms our customers require.

The integration with ongoing infrastructure initiatives, like Cells, and compliance frameworks for GitLab for Government, creates a comprehensive system that addresses current pain points while positioning GitLab for continued growth in government and enterprise markets.

This vision requires significant engineering investment but provides the foundation for sustainable feature delivery across GitLab's complete platform portfolio. The structured approach ensures that we can maintain our innovation velocity while meeting the increasingly sophisticated requirements of our diverse customer base.

---

*Reference material*:

* [Feature Gates Proposal](https://docs.google.com/document/d/19DCi1pTeiNKQPGX1Q0GwZDXbTi5G22IDvB8C0P3nFhg/edit)
* [Beyond Feature Gates: A new pattern to deliver GitLab](https://docs.google.com/document/d/1yqyXcqw21a4hYZjQvjjYm6N_wYb3zY4-UuuD0z3gl6U/edit)
* [Feature Gates Gap Analysis](https://docs.google.com/document/u/0/d/1eQuUTiiM8PzFs--NDgOacOa6m9Sqwh5A9sHvWsTMfnI/edit)
