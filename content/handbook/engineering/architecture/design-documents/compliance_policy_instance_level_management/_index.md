---
title: "Instance Level Compliance and Policy Management"
status: ongoing
creation-date: "2025-04-02"
authors: [ "@nrosandich", "@alan" ]
coach: "@darbyfrey"
approvers: [  ]
owning-stage: "~govern::compliance"
participating-stages: []
toc_hide: true
no_list: true
---

{{< design-document-header >}}

## Introduction

Compliance frameworks and security policies are currently managed at the group level, which creates challenges for organizations that need to apply consistent compliance and security requirements across multiple groups. This document outlines a proposed architecture to implement Instance Level Compliance and Policy Management functionality using a designated Compliance and Security Policy (CSP) Group approach, allowing organizations to centrally manage and consistently apply compliance frameworks and security policies across the entire instance.

Refer to [Instance Level Compliance and Policy Management](https://gitlab.com/groups/gitlab-org/-/epics/15864) epic for product requirements.

## Proposal

We propose designating a top-level group as the central authority for compliance frameworks and security policies at the instance level. This CSP Group will contain the master version of frameworks and policies, which will then be mirrored to other groups throughout the instance. Top-level group owners can apply these frameworks to their projects but cannot modify them, ensuring consistent application of compliance and security requirements.

## Goals

- Allow the application of compliance frameworks and security policies across multiple top-level groups from a central location.
- Enable compliance and security professionals to enforce common requirements across an organization's projects.
- Reduce the need for complex scripting to maintain consistent frameworks across groups.
- Improve separation of duties for compliance and security management.
- Allow the application of compliance frameworks and security policies across multiple top-level groups from a central location.
- Enable compliance and security professionals to enforce common requirements across an organization's projects.
- Simplify the user experience of centralized compliance and policy management by removing the requirement to manage security policy project (SPP) links across groups to a centralized SPP.
- Reduce the need for complex scripting to maintain consistent compliance frameworks across groups.
- Improve separation of duties for compliance and security management, such as granting only Admin users the ability to designate a CSP group and the users who may manage those policies.
- Create a design that can easily evolve when Organization-level scoping becomes available.
- Allow for top-level groups to manage policies within their own group while also enabling enforcement of centralized policies across all top-level groups.

## Non-Goals

- Replacing existing group-level compliance framework or security policy functionality.
- Building Organization-level management in this phase (though we aim to design for future compatibility).
- Creating new compliance framework types or security policy types.
- Changing the underlying policy evaluation engine.

## Terminology/Glossary

- **CSP Group**: Compliance and Security Policy Group - a designated top-level group with elevated permissions for centrally managing compliance and security policies.
- **Mirrored Framework**: A read-only copy of a compliance framework from the CSP Group that appears in other groups.
- **Framework-scoped Policy**: A security policy that targets specific compliance frameworks.
- **Original Framework**: The source version of a compliance framework in the CSP Group.
- **Instance Level**: Functionality that applies across the entire GitLab instance.

## Design Overview

### Core Approach

1. Instance administrator designates a top-level group as the CSP Group.
2. CSP Group admins create compliance frameworks and security policies.
3. Compliance frameworks are automatically mirrored to all other top-level groups in the instance.
4. Security policies are scoped to compliance frameworks.
5. Projects in any group can use the mirrored frameworks.
6. When a project with a mirrored framework runs a pipeline, it enforces associated policies from the CSP Group.

### Entity Relationship Diagram

```mermaid
erDiagram
    Instance ||--o| namespaces : "designates as CSP_Group"
    
    namespaces ||--o{ projects : "has_many"
    namespaces ||--o{ compliance_management_frameworks : "has_many"
    namespaces ||--o{ compliance_requirements : "has_many"
    
    projects ||--o| security_orchestration_policy_configurations : "links with"
    namespaces ||--o| security_orchestration_policy_configurations : "links with"
    security_orchestration_policy_configurations ||--|| projects : "stores policies in"
    security_orchestration_policy_configurations ||--o{ security_policies : "contains"
    
    security_policies ||--|{ compliance_framework_security_policies : "scoped to"
    compliance_framework_security_policies }|--|| compliance_management_frameworks : "scopes"
    
    compliance_management_frameworks ||--o{ compliance_requirements : "has_many"
    compliance_requirements ||--o{ compliance_requirements_controls : "has_many"
    
    compliance_management_frameworks ||--o{ mirrored_compliance_frameworks : "is mirrored as"
    mirrored_compliance_frameworks }|--|| namespaces : "belongs to"
    mirrored_compliance_frameworks }|--|| compliance_management_frameworks : "references original"
    
    mirrored_compliance_frameworks ||--o{ project_compliance_framework_settings : "has_many"
    project_compliance_framework_settings ||--o{ projects : "many_to_many"
    
    projects ||--o{ project_control_compliance_statuses : "has_many"
    compliance_requirements_controls ||--o{ project_control_compliance_statuses : "has_many"
    
    projects ||--o{ project_compliance_violations : "has_many"
    compliance_requirements_controls ||--o{ project_compliance_violations : "has_and_belongs_to_many"
    
    project_control_compliance_statuses ||--o{ audit_events : "generates"
    
    compliance_requirements ||--o{ security_policy_requirements : "associates with"
    security_policy_requirements |o--o| security_policies : "associates with"
```

## Data Model

### New Tables

**instance_csp_namespace**

```sql
CREATE TABLE instance_csp_namespace (
  id SERIAL PRIMARY KEY,
  instance_id INTEGER NOT NULL,
  namespace_id BIGINT NOT NULL REFERENCES namespaces(id),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(instance_id)
);
```

### Modified Tables

**compliance_management_frameworks**

```sql
ALTER TABLE compliance_management_frameworks 
ADD COLUMN is_csp_framework BOOLEAN NOT NULL DEFAULT FALSE,
ADD COLUMN is_mirror BOOLEAN NOT NULL DEFAULT FALSE,
ADD COLUMN original_framework_id BIGINT REFERENCES compliance_management_frameworks(id),
ADD INDEX(original_framework_id);
```

**compliance_framework_security_policies**

```sql
ALTER TABLE compliance_framework_security_policies
ADD COLUMN is_from_csp_group BOOLEAN NOT NULL DEFAULT FALSE;
```

## Core Workflows

### CSP Group Designation

1. Instance administrator navigates to `Admin Area > Settings > Security and compliance`.
2. Administrator selects a top-level group to designate as the CSP Group.
3. System creates an entry in the `instance_csp_namespace` table.
4. UI updates to show special indicators for the CSP Group.

### Compliance Framework Creation and Mirroring

1. CSP Group admin creates a compliance framework in the CSP Group.
2. System marks the framework as `is_csp_framework = true`.
3. System automatically creates mirrored copies in all other top-level groups.
4. When new top-level groups are created, system creates mirrors for all CSP frameworks.

### Security Policy Management

1. CSP Group admin creates security policies in the policy project (`.gitlab/security-policies/policy.yml`)
2. Admin scopes policies to specific compliance frameworks
3. System creates entries in `compliance_framework_security_policies` with `is_from_csp_group = true`

Example policy YAML:

```yaml
scan_execution_policy:
  name: Block vulnerable dependencies
  description: Vulnerability scanning for dependencies
  enabled: true
  rules:
  - type: pipeline
    branches:
    - release/*
  actions:
  - scan: sast
  policy_scope:
    compliance_frameworks:
      - id: 1  # CSP compliance framework
```

### Project Compliance Framework Assignment

1. Group owner can assign mirrored frameworks to projects.
2. Group owner can set mirrored frameworks as default for new projects.
3. System creates entries in `project_compliance_framework_settings` referencing the mirrored framework.

### Policy Enforcement in CI/CD Pipeline

1. When a project pipeline runs, system checks for assigned compliance frameworks.
2. If framework is mirrored, system retrieves the original framework from CSP Group.
3. System retrieves all security policies scoped to the original framework.
4. Policies are enforced against the project's pipeline.

## API Design

### GraphQL Extensions

```graphql
type Query {
  instanceCspGroup: Namespace
  cspComplianceFrameworks: [ComplianceManagementFramework!]!
  mirroredComplianceFrameworks(namespaceId: ID!): [ComplianceManagementFramework!]!
}

type Mutation {
  designateInstanceCspGroup(namespaceId: ID!): Namespace
  removeCspGroupDesignation: Boolean
  createCspComplianceFramework(input: FrameworkInput!): ComplianceManagementFramework
  updateCspComplianceFramework(id: ID!, input: FrameworkInput!): ComplianceManagementFramework
  deleteCspComplianceFramework(id: ID!): Boolean
  scopePolicyToFramework(policyId: ID!, frameworkId: ID!): ComplianceFrameworkSecurityPolicy
  assignFrameworkToProject(projectId: ID!, frameworkId: ID!): ProjectComplianceFrameworkSetting
  setDefaultGroupFramework(namespaceId: ID!, frameworkId: ID!): Namespace
}

extend type ComplianceManagementFramework {
  isCspFramework: Boolean!
  isMirror: Boolean!
  originalFramework: ComplianceManagementFramework
  mirroredFrameworks: [ComplianceManagementFramework!]!
  scopedPolicies: [SecurityPolicy!]!
}

extend type Namespace {
  cspFrameworks: [ComplianceManagementFramework!]!
  mirroredFrameworks: [ComplianceManagementFramework!]!
  defaultMirroredFramework: ComplianceManagementFramework
  isCspGroup: Boolean!
}

extend type Project {
  assignedFrameworks: [ComplianceManagementFramework!]!
}
```

## Authorization Model

### Permission Structure

#### CSP Group-Related Permissions

- `manage_instance_csp_group`: Designate/undesignate CSP Group (instance admins only).
- `manage_csp_compliance_frameworks`: Create/edit frameworks in CSP Group (CSP Group admins).
- `manage_csp_security_policies`: Create/edit policies in CSP Group (CSP Group admins).
- `scope_csp_policies_to_frameworks`: Associate policies with frameworks (CSP Group admins).

#### Group-Related Permissions

- `view_mirrored_compliance_frameworks`: View mirrored frameworks (all authenticated users).
- `assign_mirrored_frameworks`: Assign mirrored frameworks to projects (group owners/maintainers).
- `set_default_mirrored_frameworks`: Set default frameworks for group (group owners).

### Permission Matrix

| Role | Designate CSP | Manage CSP Frameworks | Manage CSP Policies | Assign Mirrored Frameworks | Set Default Frameworks |
|------|---------------|----------------------|---------------------|----------------------------|------------------------|
| Instance Admin | ✅ | ✅ | ✅ | ✅ | ✅ |
| CSP Group Admin | ❌ | ✅ | ✅ | ✅ | ✅ |
| CSP Group Maintainer | ❌ | ✅ | ✅ | ✅ | ✅ |
| Group Owner | ❌ | ❌ | ❌ | ✅ | ✅ |
| Group Maintainer | ❌ | ❌ | ❌ | ✅ | ❌ |
| Developer | ❌ | ❌ | ❌ | ❌ | ❌ |

## User Interfaces

### CSP Group Management UI

- Instance Settings > Compliance page with CSP Group designation.
- Visual indicator for CSP Group in groups list.
- Special header in CSP Group pages indicating its role.

### CSP Framework Management UI

- Enhanced compliance framework UI in CSP Group.
- Framework creation/editing forms.

### CSP Policy Management UI

- Policy editor in CSP
- Security Policy Project in CSP

### Group Policies UI (Secure > Policies)

- Group users may view policies applied to their group, including those enforced via CSP

### Project Policies UI (Secure > Policies)

- Project users may view policies applied to their project, including those enforced via CSP

### Group Framework UI

- List of available mirrored frameworks.
- Framework assignment UI for projects.
- Default framework settings for group.
- Visual indicators showing frameworks are mirrored (read-only).

### Project Compliance UI

- Assigned frameworks display.
- Framework assignment selector.
- Pipeline integration showing applied policies.

## Technical Implementation

### Models and Associations

These models define the structure of the compliance framework mirroring system.

#### MirroredComplianceFramework

- This model ensures that compliance frameworks defined in a central CSP group are mirrored across other top-level groups.
- It allows projects in different groups to inherit compliance frameworks from a central source.
- It links a mirrored framework to its original compliance framework and a specific namespace (group).
- It ensures that each namespace_id can only have one mirrored copy of a specific `original_framework_id` to prevent duplicates.
- It allows projects to reference mirrored compliance frameworks.

#### ComplianceManagementFramework

- This model represents a compliance framework, which consists of a set of security policies, requirements, and rules that organizations must follow.
- Defines compliance frameworks that belong to a namespace (group).
- Includes mirrored framework functionality with `is_mirror` and `original_framework_id` fields.
- Establishes relationships with:
  - Mirrored frameworks (so that it knows which groups have copies)
  - Compliance framework security policies (for applying security policies)
  - Security policies (via `compliance_framework_security_policies`).
- Defines a scopes:
  - `csp_frameworks`: filters frameworks that are designated as CSP frameworks.
  - `mirrored`: filters frameworks that are mirrors of CSP frameworks.
  - `originals`: filters frameworks that are not mirrors.

### Services

#### CSP::FrameworkMirroringService

- Ensures that compliance frameworks created in the CSP group are propagated to other groups automatically.
- Initializes with a CSP group ID.
- Returns an error if no CSP group is set (to prevent execution without context).
- Retrieves all compliance frameworks in the CSP group.
- Identifies all top-level groups (excluding the CSP group).
- Creates a mirrored compliance framework in each top-level group for each CSP framework by:
  - Setting `is_mirror` = true
  - Setting `original_framework_id` to the ID of the source framework
  - Copying relevant attributes from the original

#### CSP::FrameworkUpdatePropagationService

- New service that propagates updates from original frameworks to their mirrors.
- When an original framework is updated, finds all mirrors and updates their attributes.
- Maintains consistency between originals and mirrors.

#### CSP::PolicyResolverService

- Provides a way to resolve and return policies that apply to a specific project.
- Retrieves policies for a given project and returns them as a structured response.

### Background Jobs

These are asynchronous workers that run in the background to handle framework mirroring and cleanup.

#### CSP::MirrorComplianceFrameworksJob

- Automates the initial framework mirroring process without requiring manual execution.
- Retrieves the CSP group ID from InstanceSettings.
- Runs CSP::FrameworkMirroringService to mirror compliance frameworks across top-level groups.

#### CSP::SyncDeletedFrameworksJob

- Prevents stale mirrored frameworks from existing when the original compliance framework is deleted.
- Finds frameworks where `is_mirror` = true and `original_framework_id` points to a non-existent framework.
- Deletes these orphaned mirrored frameworks.

### Controllers

Controllers expose API endpoints for managing the CSP group configuration.

#### API::V4::Instance::CspGroupController

- Provides an API to retrieve and update the CSP group that holds the source compliance frameworks.
- Authentication & Authorization
  - Requires user authentication.
  - Ensures only admins can update the CSP group.
- Show Action
  - Retrieves and returns the CSP group namespace ID.
- Update Action
  - Updates the CSP group namespace in InstanceSettings.
  - Triggers CSP::FrameworkMirroringService to immediately mirror compliance frameworks to other groups.
  - Returns a success response.

## Future Considerations

### Organization Entity Integration

The mirroring approach provides a clean path to organization-level implementation:

- Replace instance-level designation with organization entity.
- Convert mirroring system to work across organizations.
- Maintain the same permission model but at organization level.

### Extended Capabilities

- Exclusion requests for specific projects.
- Detailed compliance reporting.
- Framework version control and history.
- Enhanced policy templating.
- Automated compliance violation remediation.
- Compliance dashboard for instance-wide visibility.
