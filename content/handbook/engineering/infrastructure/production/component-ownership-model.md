---
title: "Component Ownership Model"
---

**_A paved path for adding new Infrastructure Components to GitLab.com_**

![Component Ownership Model Diagram](/images/content/handbook/engineering/infrastructure/production/component_ownership_model.png)

## Understanding the Ecosystem

The Component Ownership Model extends GitLab's Production Readiness process with a focus on ownership,
and best practices using a paved-path to Production.

It guides teams through bringing non-Runway infrastructure components online for GitLab.com.
While focused on .com deployment,
it ensures components remain compatible with GitLab's broader deployment landscape:
Dedicated, FedRAMP, Cells, and future Self-Managed offerings.

This model is part of a larger transformation.
Other initiatives define the
[Self-Managed Foundation and Advanced (SMB/SMA) blueprint](https://gitlab.com/gitlab-com/content-sites/handbook/-/merge_requests/14414)
and the
[GitLab Infrastructure Platforms Review Process](https://gitlab.com/groups/gitlab-org/-/epics/17136).
The Component Ownership Model is focused on accelerating and unifying the approach taken for delivering new software components to GitLab.com in a way which aligns expectations,
encourages ownership and reduces the need for manual (possibly slow) gatekeeping from Infrastructure Platforms department.

## Relationship to Runway and the Production Readiness Process

This process is not a replacement for the [Production Readiness](./readiness.md) process,
but is intended to be an opinionated paved path designed to reduce the cycle time on Production Readiness.

This is in many ways similar to the goals of Runway.
Selecting Runway is preferable to using this process,
and should be used when possible.
Unfortunately, there are currently cases where Runway is not an option, and, in those cases,
it's preferable to use Component Ownership Model.

Compared to the previous engagement model,
Component Ownership Model will allow teams to work with greater autonomy,
faster cycle time,
and greater alignment with Infrastructure.

## Roles

Three distinct roles drive the component addition process.
Each brings specific expertise.
Each owns different responsibilities.

| Role                 | Team                               | Responsibilities                                                                                                                                                                                                                                                                                                             |
|----------------------|------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Development Team** | Development Stage Group Team       | The stage group team introducing the new component. The team owns it from conception through production. Drives the engagement process forward. Creates the artifacts: Container Images, Terraform modules, Helm charts, design documents. |
| **Reviewer**         | Production Engineering (Staff+ IC) | Evaluates the design. Asks difficult questions about scale, operations, and architecture. Their approval signals that the design can survive production's demands.                                                                                                                                                           |
| **Integration Engineer** | Production Engineering             | Guides the component into GitLab.com's infrastructure. Reviews code against the approved design. Verifies policy compliance. Ensures the implementation matches the promise.                                                                                                                                                 |

## The Vision: Self-service Infrastructure

The Component Ownership Model pushes infrastructure component ownership left.
Teams that propose components own them, from Idea to Production and beyond into ongoing maintenance and support.
Stage Groups maintain separate repositories for their Infrastructure-as-Code,
avoiding adding their changes directly to Infrastructure repositories.
By maintaining their own modules, they control their release cycles, and respond to alerts and incidents.
Infrastructure teams provide platforms, a paved path, guidance and guardrails.
The goal is to avoid roadblocks.

[Infra-Mgmt](https://gitlab.com/gitlab-com/gl-infra/infra-mgmt/) will be used to automate
repository management, mirroring, secret management and rotation.

Future iterations may include a self-service platform that automates, GCP sandbox resource provisioning.
Teams could spin up standardized environments with Atlantis for Terraform automation and Vault for secrets management.
This vision builds on proven patterns while removing infrastructure teams from the critical path.

### Maintaining Clear Boundaries

Application Team Components will not reside in [Config-Mgmt](https://ops.gitlab.net/gitlab-com/gl-infra/config-mgmt) or [k8s-workloads](https://gitlab.com/gitlab-com/gl-infra/k8s-workloads/gitlab-com) repositories.
They exist in their own repositories under the <https://gitlab.com/gitlab-com/gl-infra/components> namespace (TBD).
Application teams own these repositories, have owner rights and merge their own changes
They manage releases.

Teams build components as Helm charts for Kubernetes workloads, or Terraform Modules for
cloud resource provisioning.
They define Metrics Catalog entries for observability.
Infrastructure platforms consume these modules as isolated, well-defined, versioned dependencies,
instead of absorbing weakly-owned changes into a monolithic repository.

For modules, Convention-over-Configuration is strongly favoured,
and using
[`common-ci-tasks CI Components`](https://gitlab.com/gitlab-com/gl-infra/common-ci-tasks) and
[`common-template-copier Project Templates`](https://gitlab.com/gitlab-com/gl-infra/common-template-copier)
will encourage this approach. 

### Building on Proven Foundations

The [`common-ci-tasks` repository](https://gitlab.com/gitlab-com/gl-infra/common-ci-tasks) provides standardized CI/CD components for consistent project builds.
Teams inherit policy enforcement, testing frameworks, and deployment patterns.
This approach will avoid reinventing wheels and divergent practices, encouraging a paved-path approach.

GitLab Infrastructure team already makes use of Copier for project templates stored in the [`common-template-copier`](https://gitlab.com/gitlab-com/gl-infra/common-template-copier) project.
The Copier Templates establish patterns that make components maintainable and consistent, and provide automated upgrades to projects to migrate around breaking changes.
Using these Copier templates for new projects is mandatory.

### Designing for Portability

Although this process focuses on GitLab.com, new components must allow for future forward compatibility across GitLab's deployment models.

Some examples of situations where a proposed design may fail the design review:

1. A component that only works on Google Cloud
1. A feature requiring proprietary cloud services without self-managed equivalents.

The design stage will include some checklist items:

1. Will this component be compatible with FedRAMP environments?
1. In future, will this component be able to work in air-gapped installations?
1. Will the component allow for full end-to-end automation to support Dedicated and Cells.
   Components which require manual configuration are non-viable.

### Policy as Code

For Component Ownership Model, Infrastructure standards live as code, not documentation.
Teams consume versioned policies published as OCI images.
`conftest` will be used to valid modules against policies defined by Infrastructure policies.
Additionally, unit testing for Helm (using `helmunit`) and Terraform (using `terraform test`) will be required.
`checkov` scans will further enforce broader, industry standard policies.

Policy versions follow semantic versioning:

- **Major versions** introduce breaking changes requiring major and disruptive code updates
- **Minor versions** add new rules
- **Patch versions** fix bugs without breaking existing components

Each project will declaratively define the policy versions supported.
This will be verified through CI/CD checks on the project,
ensuring that developers are aware of policy breaches as soon as possible.
Teams declare their supported policy version.
Renovate proposes updates to the policy documents.
Infrastructure communicates standards through policy releases,
not meetings or checkboxes in a merge request template.

#### Policy Evolution

Infrastructure evolves policies based on operational experience, the need to nudge teams in a specific direction,
or even small linter fixes.
New attack vectors may require new security rules.
Performance issues drive resource policies.
Teams consume these updates at their own pace within support windows, but the
Infrastructure Platforms team may require certain minimum versions of the
policies to be enforced before allowing the team to integrate a module.
The owning team will be responsible for upgrading to the new version.

### Continuous Validation

Since policy checks are defined in code, and integrated into the standard CI components used in component projects,
policies are validated on each push and failed checks block merges.
Teams know immediately when they violate standards.

Policy violations during development are learning opportunities.
Teams can temporarily disable specific policies with justification.
These exceptions require review during integration.

### Observability as Code

Metrics Catalog integration starts during development.
Teams define [`PodMonitor`](https://prometheus-operator.dev/docs/developer/getting-started/#using-podmonitors) and [`ServiceMonitor`](https://prometheus-operator.dev/docs/developer/getting-started/#using-servicemonitors)
configurations as part of helm chart definitions.

Services define their metrics-catalog configurations alongside Helm Charts.
These configurations generate dashboards and alerts.
Alerts are automatically routed to the owning team.

### Decoupled lifecycles

Component repositories maintain their own release cycles.
Teams use semantic commits to drive an automated semantic release process.

Infrastructure repositories reference specific component module versions,
but don't contain component (IaC) code.
Teams propose version updates through merge requests, or Renovate will open them automatically.
Upgrades need to be validated in staging before production.

By using versioned modules, there is a physical limit to the drift that
can occur between the implementations in each environment.
This is different from the copy-pasta style approach sometimes used at present,
which results in configuration drift between environments over time.

Importantly, by using a single module for multiple environments, teams need to
consider the _interface_ to their module and the appropriate level of abstraction.
This is an important part of the design process, but can be missed if you're simply
declaring Terraform resources.

### Making it real

The Component Ownership Model succeeds through automation and clear ownership.
Teams move faster because standards are automated.

Application teams must embrace operational ownership.
Infrastructure teams must provide platforms, not permissions.

## COM Lifecycle Stages

### Stage 1: Design Stage

The process begins with engagement and a design.
The Application Development Team produces a small design document.
This is not a sprawling specification but a focused proposal, specifically covering the deployment of the component to GitLab.com.
This same documentation will later be used as part of the service runbooks, and production readiness process.

An SRE in the Production Engineering sub-department will work with the Application Team to validate the design.

A set of prerequisites questions will need to be covered before approval can be given, such as:

1. Will this component be forward compatible with later deployments to GitLab Dedicated, Cells, Dedicated for Government, and Self-Managed.
   1. How much overhead will the component take to deploy, maintain, upgrade and operate.

### Stage 2: Development Stage

Development follows design approval. This stage is driven by the Stage Group Development Team.
Application teams build in their repositories and own the pace of development.
Changes can be merged without Infrastructure Platforms involvement.
Within policy constraints, development can occur according to preferred approach of the stage group team.
This will reduce the need to wait for Infrastructure Platform reviews during development.

### Stage 3: Integration Stage

During this stage, the Stage Group Application owning team and the Integration SRE collaborate on delivering the change.

As a first step, an MR is opened in the appropriate Infrastructure Platforms repository, such as [Config-Mgmt](https://ops.gitlab.net/gitlab-com/gl-infra/config-mgmt) or [k8s-workloads](https://gitlab.com/gitlab-com/gl-infra/k8s-workloads/gitlab-com).
The review should be assigned to the Integration SRE.

Changes to integrate the module into each successive environment should be carried out in separate MRs,
so that each change is tested in staging before being rolled out in canary and  finally production.

Once the change is ready, the Integration SRE will review the change.
This will include a review of the Application Team module, to ensure that:

1. The implementation matches the agreed design (within reason).
2. Policy versions are up-to-date, and `common-ci-tasks` build components are up-to-date.
3. Test coverage and quality
4. Operational readiness (monitoring, alerting, runbooks)
5. Security posture
6. Resource efficiency
7. Backup and recovery procedures

The reviewing Integration SRE should, whenever possible, avoid being a "human linter".
Focusing on small menial linter-style issues should be avoided.
Computers can lint for us,
and human time is far more valuable for focusing on the big picture.
Sometimes by focusing on small niggles,
the reviewer may fail to see the wood for the trees.

Note: this isn't to say that linting isn't important. SREs should look to
automate linter issues.
This is better since it reduces gatekeeping, allows Application Teams to learn about
these issues earlier in the development cycle, and prevents unexpected delays
later in the process.

During the integration stage, multiple iterations of review and deployment may take place,
until the component is deemed to be sufficiently stable and ready for
deployment to production.

Each of these changes will be released as a new semver release of the module.

### Stage 4: Maintenance

Once the component has graduated to production, ongoing feature improvements
can iteratively be added, along with other changes, such as dependency upgrades,
performance improvements and technical debt resolution.

The responsibility for these tasks will fall on the Stage Group team owning the component.

{+ NOTE: We may want to consider an SLA for CVE resolution times on components. +}

## From Idea to Production, a runbook for Stage Group teams

**Stage 1: Design Stage**

1. Follow the [Production Readiness Process](./readiness.md) to open a Production Readiness issue. The earlier this is done, the better.
1. Create a Production Readiness MR, as per the Production Readiness Process. At this stage, the document will be fairly empty, but the Component Design can be carried out in this draft document.
1. A component may have either a Terraform Module, a Helm Module or both. ({+ TBD: one component for both or separate? +})
1. Define the interface for the component and document it in the production readiness draft MR. The interface is, in Terraform, the inputs, or in Helm, the values.
1. Produce a diagram and description of the cloud resources that the module will consume.

**Stage 2: Development Stage**

1. Declare the project in https://gitlab.com/gitlab-com/gl-infra/infra-mgmt, to create it in https://gitlab.com/gitlab-com/gl-infra/components.
   1. {+ TODO: anemic YAML definition in Infra-Mgmt for all component projects? +}
   1. {+ TODO: should we integrate incident.io and pagerduty services, into this same definition, tied to the component? +}
1. Clone the new empty project, and follow the instructions in https://gitlab.com/gitlab-com/gl-infra/common-template-copier to apply the base template for the project. Push the initial commit to GitLab.
1. Start iterating on development of the module. MR reviews can be conducted within the team.
1. Build unit tests for your infrastructure using the scaffolding provided by the Copier template.
1. Integration test the changes using Sandbox accounts, KinD and other development tooling.
1. Monitor any policy failures, and address these early.
1. Use Semantic Commits to control versioning. Semantic Versioning will automatically tag and release new versions of your module automatically, and publish these versions.

**Stage 3: Integration Stage**

1. When the team is confident that the component is ready for staging, the Stage Group team should open an MR in [Config-Mgmt](https://ops.gitlab.net/gitlab-com/gl-infra/config-mgmt) or [k8s-workloads](https://gitlab.com/gitlab-com/gl-infra/k8s-workloads/gitlab-com) repositories.
1. The change should target to Staging environment and should reference a specific version of the component module.
1. The Stage Group team will not have merge access to the Infrastructure Platforms projects, but should assign
   to the Integration SRE for review.
1. The Integration SRE will conduct a review of the MR and also ensure that the upstream module meets the proposed design.
1. If any changes need to be done upstream, these should be carried out in the upstream module
   with Semantic Releases used to publish new versions of the module, until the review is completed
   and the change is merged to the Staging environment.
1. The Stage Group team then validates the change, ensuring that it is working as expected in the staging environment.
    1. {+ TODO: consider enabling QA Integration Tests against staging for the feature at this point +}
1. Stage Group team verifies observability, alerts, etc.
1. Through multiple iterations to the upstream module, and to the integration project, the change will be rolled into production.
1. The Production deployment will need to be aligned with the wider Production Readiness process, with the production deployments
   being dependent on the production readiness review status.
   However, since the project is using Infrastructure templates, Infrastructure Policies
   and Infrastructure best-practices, the production readiness review is likely to
   to be significantly faster than one in which components are produced without
   following the paved path.

**Stage 4: Maintenance**

1. Once the change is deployed, further progressive iterative changes can be made by the team in the upstream modules.
2. As during the development phase, changes are owned by the Stage Group team.
3. Integration can usually be done by a version bump to the downstream Infrastructure Platforms project.
4. Version bumps MRs will be created automatically by Renovate, but will require a review by an Infrastructure Platform engineer for MR approval. In most cases, for small changes, these will be quick reviews.
5. Renovate will also propose dependency upgrades to the component module itself.
   Some of these will address CVEs in downstream dependencies and the team will
   be responsible for addressing these (possibly within an SLA).
6. Some shared components, such as Terraform and Helm will need to closely track the versions used on GitLab.com in the Config-Mgmt and k8s-workloads repositories. The team will be responsible for performing these upgrades, although Renovate will open the MRs.
7. The team will be responsible for Capacity Planning issues related to the component.
8. The team will need to maintain their own Pagerduty Schedule for escalations to the service.
   1. {+ Pagerduty and incident.io resources should be managed alongside Infra-Mgmt component modules +}

## Next steps

Deploying your component to GitLab.com is only the first step in a much larger
process of bringing a new component to all GitLab customers.

Next, we'll need to consider Cells, GitLab Dedicated, Dedicated for Government,
Self-Managed using GET, Omnibus and Cloud Native GitLab.

Some of these processes for handling new components are undergoing change, and
those changes are still underway.
Once they are complete, this guide will reference the appropriate next steps.
