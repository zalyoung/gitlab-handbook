---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Teams
status: proposed
creation-date: "2025-06-12"
authors: [ "@lohrc" ]
dris: [ "@lohrc" ]
owning-stage: "~devops::tenant scale"
participating-stages: []
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

## Summary

GitLab's current access control model conflates user management with project organization through the dual-purpose nature of groups. This creates significant challenges for enterprise customers who need to separate organizational structure from resource management while maintaining security and compliance requirements. This blueprint defines the architectural requirements for a Teams-based access control system that separates user management from project organization, addresses critical customer pain points, and positions GitLab competitively in the enterprise DevOps market.

The Teams architecture aims to introduce a distinct entity for managing users that can be shared across groups and projects, providing clearer mental models, better inheritance behavior, and reduced administrative overhead. This separation addresses [the #1 vulnerability in the OWASP Top 10 (Broken Access Control)](https://owasp.org/Top10/A01_2021-Broken_Access_Control/) while reducing the cognitive load for users of the current system.

## Motivation

### Current State Analysis

In GitLab, groups serve dual purposes that create inherent tension:

1. **Project organization**: Hierarchical structure for managing code, issues, and CI/CD resources
2. **User management**: Organizing people and controlling access to resources

This dual nature creates several critical problems identified through customer research and competitive analysis:

**Permission management complexity**: Nearly every customer interview mentioned challenges with GitLab's permission model, particularly around inheritance creating unexpected access levels when users have different roles at different hierarchy levels. While GitLab's custom roles provide fine-grained permission control with over 40 specific permissions, complexity arises from how these permissions interact with the dual-purpose nature of groups and the resulting inheritance patterns.

**Inconsistent sharing behavior**: Group sharing exhibits different inheritance patterns depending on the target (group vs project). Sharing a group with another group only shares direct members, while sharing a group with a project includes both direct and inherited members. This inconsistency violates user mental models and creates security risks.

**Cognitive load and mental model mismatch**: Users expect permissions to work like physical filing cabinets — explicit and visible. The current invisible inheritance model violates these expectations, leading to systematic errors and security vulnerabilities as users work around systems they don't understand.

### Industry Context and Competitive Pressure

Research across the DevOps landscape reveals that access management inefficiencies cost US companies approximately $61 billion annually, with 94% of applications showing some form of broken access control. The competitive landscape has evolved significantly, with major platforms implementing sophisticated approaches to address enterprise access management challenges:

- **Team-based hierarchical models** with sophisticated nesting and clear inheritance patterns
- **Organizational structure separation** from project management through dedicated organizational modeling features
- **Project-level permission cascading** that eliminates individual resource permission management overhead
- **Clear separation patterns** between permanent user organization and temporary access mechanisms

These evolved approaches demonstrate industry recognition that traditional access control models are insufficient for modern enterprise DevOps requirements. GitLab's current dual-purpose group model increasingly appears dated compared to these specialized solutions, potentially limiting enterprise adoption and competitive positioning.

*Detailed competitive analysis including specific platform implementations and feature comparisons is available in the [DevOps Access Control Research Report](https://drive.google.com/drive/folders/1WeMK7PYvFhGtWqYFY8VPMUOxUVfay3vr?ths=true) for internal reference.*

### Relationship to Existing Custom Roles System

The existing custom roles system already addresses permission granularity concerns through over 40 specific permissions across categories. The Teams architecture is designed to complement, not replace, this sophisticated permission system. While custom roles define *what* users can do, Teams will define *which users* should have access to specific resources and *how* that access is organized and inherited. This separation allows:

- **Custom Roles**: Continue to provide fine-grained control over specific capabilities
- **Teams**: Provide organizational context and inheritance patterns for applying those roles
- **Combined System**: Enable enterprises to model their organizational structure while maintaining precise permission control

For example, a "Frontend Developer" custom role might include specific permissions for code review and CI/CD pipeline access, while a "Mobile Team" would define which users should receive that role and how it inherits across related projects.

### Goals

#### Primary Goals

1. **Separate user management from project organization**
   - Create a distinct Teams entity that represents organizational structure
   - Enable independent evolution of user hierarchies and project hierarchies
   - Support enterprise identity integration without impacting project structure
   - Provide clear conceptual separation that aligns with user mental models

2. **Improve permission inheritance and organizational modeling**
   - Eliminate inconsistent sharing behavior between group-to-group and group-to-project scenarios
   - Make permission inheritance visible and auditable throughout the system
   - Provide "break inheritance" capabilities with clear impact warnings
   - Support both hierarchical organizational modeling and flat cross-functional collaboration
   - Integrate seamlessly with GitLab's existing custom roles system to provide organizational context for fine-grained permissions

3. **Address Enterprise Scale Requirements**
   - Support organizations with 10,000+ users and thousands of projects
   - Provide comprehensive audit trails for compliance (NIST 800-53, ISO 27001, SOX)
   - Enable bulk operations for administrative efficiency
   - Support team lifecycle management

4. **Reduce cognitive load and administrative overhead**
   - Provide progressive disclosure of permission complexity
   - Create intuitive mental models that align with user expectations
   - Reduce time-to-grant-access to under 5 minutes for standard scenarios
   - Minimize permission-related support tickets by 50%

#### Secondary Goals

1. **Enable advanced access patterns**
   - Support just-in-time access for sensitive operations
   - Provide service account management with automated rotation
   - Enable temporary permission elevation
   - Support matrix organizations and multiple reporting structures

2. **Improve developer experience**
   - Integrate access control directly into development workflows
   - Provide API-first design for automation and tooling integration
   - Support DevOps-specific permission patterns for CI/CD pipelines
   - Enable self-service access requests with appropriate approval workflows

### Non-Goals

1. **Immediate replacement of current group model**
   - This blueprint focuses on architecture and requirements, not migration strategy
   - Current group functionality must remain fully supported during transition
   - Existing customer workflows cannot be disrupted without explicit migration path

2. **Replacement of existing permission systems**
   - Teams architecture should complement, not replace, the existing custom roles and permissions system
   - The sophisticated custom role system should remain the foundation for fine-grained access control
   - Teams should provide organizational structure and inheritance patterns for applying existing permission models

3. **Over-engineering organizational complexity**
   - Focus on common enterprise organizational patterns rather than edge cases
   - Maintain philosophy of convention over configuration
   - Avoid creating complexity that contradicts the goal of reducing cognitive load

4. **External identity provider features**
   - Teams architecture should integrate with external systems, not replace them
   - Directory synchronization remains the responsibility of existing LDAP/SAML integration
   - User lifecycle management stays within current GitLab administration boundaries

### Teams and Custom Roles Integration

The Teams architecture must seamlessly integrate with GitLab's existing custom roles system to provide comprehensive access management:

**Role assignment through Teams:**

- Teams should support assignment of both default roles (Guest, Reporter, Developer, Maintainer, Owner) and custom roles
- When a Team is shared with a group or project, the assigned role (default or custom) should be applied to all Team members
- Custom role inheritance should follow the same patterns as default role inheritance

**Organizational context for custom roles:**

- Teams provide organizational context that helps administrators understand why specific custom roles are assigned
- Custom roles define capabilities, Teams define organizational structure and access patterns
- Together, they enable "Frontend Developer working on Mobile Team" rather than just "user with custom frontend permissions"

**Administrative simplification:**

- Administrators can assign a custom role once to a Team rather than individually to each team member
- Role changes can be managed at the Team level, automatically applying to all members
- Audit trails show both the custom role permissions and the organizational context through Teams

## Critical Requirements Analysis

### Customer Pain Points (Based on User Research)

**Permission Management and Inheritance Issues**

- Inheritance creates unexpected access levels with complex role interactions across group hierarchies
- Confusion around how permissions propagate through groups and subgroups, especially with custom roles
- Difficulty visualizing who has access to what, especially in large organizations with multiple custom roles
- Challenges with SAML/LDAP integration for mapping organizational groups to GitLab groups with appropriate custom roles
- Complex interactions between base roles, custom permissions, and inheritance patterns

**Organizational Structure Limitations**

- Need for organizational modeling that doesn't impact project structure
- Inflexibility for organizations that reorganize frequently
- Difficulties representing matrix organizations or multiple reporting lines
- Issues managing historical "legacy" structures as organizations evolve
- Inability to separate temporary project teams from permanent organizational structure

**Enterprise-Scale Management Challenges**

- Limited visibility into user activities and resource usage across thousands of projects
- Challenges with enforcing policies consistently across groups
- Need for better audit capabilities for compliance purposes
- Lack of tools for managing large-scale migrations or reorganizations
- Insufficient bulk operation capabilities for administrative efficiency

**Data Recovery and Deletion Concerns**

- Accidental deletion being too easy with cascading effects
- Recovery windows being too short for enterprise change management
- Inadequate safeguards for bulk operations
- Fear of data loss impacting willingness to restructure access

### Competitive Analysis Insights

**Hierarchical Team Models in the Market**

- Parent-child team relationships with automatic permission inheritance
- Integration of access control directly into development workflows through code ownership patterns
- Fine-grained access tokens with organization-level approval workflows
- Challenge: Deep nesting complexity and performance implications at scale

**Enterprise-Scale Organizational Integration**

- Multi-tier structures supporting thousands of organizational units and area paths
- Mapping capabilities for both structural hierarchies and temporal workflows
- Tight integration with enterprise directory services for seamless synchronization
- Challenge: Complexity can overwhelm smaller teams, creating vendor dependencies

**Cross-Product Permission Consistency**

- Project-level permissions that cascade to eliminate individual resource management
- Centralized administration providing consistent access across integrated product suites
- Simplified role models that balance flexibility with administrative simplicity
- Challenge: Maintaining consistency across diverse product capabilities

**Separation of Permanent and Temporary Access**

- Clear distinction between permanent user organization and temporary access mechanisms
- Permission boundaries that define maximum capabilities regardless of specific grants
- Just-in-time access patterns for sensitive operations
- Challenge: Implementation complexity and learning curve for traditional organizational models

*Detailed analysis of specific platform implementations is available in the [DevOps Access Control Research Report](https://drive.google.com/drive/folders/1WeMK7PYvFhGtWqYFY8VPMUOxUVfay3vr?ths=true) for comprehensive competitive insights.*

### Technical Architecture Requirements

**Scalability and Performance**

- Support 10,000+ users with sub-second permission resolution
- Handle thousands of teams and projects without performance degradation
- Implement caching layers that maintain consistency across distributed systems
- Avoid enterprise platform limitations of 5,000 unique permission scopes per container

**Security and Compliance**

- Implement comprehensive audit logging without performance impact
- Support separation of duties required by NIST 800-53 and ISO 27001
- Prevent privilege escalation through "orphaned permissions"
- Enable just-in-time access patterns for sensitive operations

**Integration and Migration**

- Provide clear migration path from current group-based model
- Support identity federation with LDAP, SAML, OIDC providers
- Enable gradual adoption without forcing big-bang migrations
- Maintain API compatibility during transition period
- Integrate seamlessly with existing custom roles and permissions system
- Support assignment of custom roles through Teams inheritance patterns

**Usability and Mental Models**

- Make permission inheritance visible with clear audit trails
- Provide progressive disclosure of complexity
- Support both hierarchical organizational modeling and flat collaboration
- Align with user expectations from consumer tools (Google Drive, Dropbox)

## Open Questions and Research Areas

### Hierarchical vs Flat Team Structure Decision

**Hierarchical approach benefits:**

- Natural mapping to organizational structure reduces cognitive load
- Inheritance patterns simplify administration at scale
- Aligns with existing GitLab group hierarchy mental models
- Supports enterprise compliance requirements for clear access paths

**Hierarchical approach challenges:**

- Deep nesting creates performance and usability problems (as seen in other enterprise platforms)
- Inheritance complexity can lead to unintended access (security risk)
- Organizational changes require structural modifications
- May not support matrix organizations or cross-functional teams effectively

**Flat approach benefits:**

- Eliminates inheritance complexity and associated security risks
- Better supports cross-functional collaboration and temporary projects
- Easier to understand and audit access relationships
- More flexible for organizational change management

**Flat approach challenges:**

- Administrative overhead increases significantly at enterprise scale
- Difficult to model large organizational hierarchies
- May require duplication of access grants across similar teams
- Lacks natural mechanism for policy inheritance and management

**Research Question:** Can a hybrid approach provide the benefits of both models without the complexity? Industry patterns around separating permanent user organization from temporary access mechanisms suggest this may be possible, but implementation complexity needs careful evaluation.

**Research Question:** Is there a middle ground that provides hierarchical benefits without complex inheritance? Could Teams have parent-child relationships for organizational modeling without automatic permission inheritance?

### Group Sharing Inheritance Patterns

**Current inconsistency:**

- Group-to-group sharing: Only direct members of shared group gain access
- Group-to-project sharing: Both direct and inherited members gain access

**User expectation research needed:**

- Do users expect industry-standard behavior (all nested group members gain access)?
- Or do users prefer GitLab's current group-to-group behavior (only direct members)?
- How do different user personas (administrators vs developers) expect inheritance to work?

**Security implications:**

- Broader inheritance approaches increase attack surface through expanded access grants
- Restrictive inheritance reduces access but creates user confusion
- Which approach better supports principle of least privilege?

**Research Question:** Should GitLab maintain current behavior, adopt industry-standard inheritance patterns, or create a third approach that makes the choice explicit to administrators?

### Enterprise Identity Integration Patterns

**Current Challenge:**

Enterprise customers using directory services expect access control to mirror their directory structure, but GitLab's current group model doesn't cleanly separate identity from resource organization.

**Integration Approaches to Evaluate:**

1. **Mirror directory structure**: Teams automatically sync with enterprise directory groups
2. **Map directory groups**: Manual mapping between directory groups and GitLab Teams
3. **Hybrid approach**: Some Teams sync automatically, others created manually for project-specific needs

**Compliance requirements:**

- NIST 800-53 requires clear separation of duties
- ISO 27001 mandates access control documentation and auditability
- SOX requires change management controls for access modifications

**Research Question:** How can Teams architecture support enterprise directory integration while maintaining the flexibility needed for DevOps workflows?

## Alternative Solutions Analysis

### Option 1: Enhance Current Group Model

**Approach:** Improve existing groups to better separate user management concerns through enhanced sharing options and visibility improvements.

**Pros:**
- Minimal disruption to existing customers and workflows
- Leverages existing user familiarity with group concepts
- Lower development and migration costs
- Maintains current API compatibility

**Cons:**
- Doesn't address fundamental dual-purpose nature of groups
- Inheritance inconsistencies would persist
- Limited ability to implement enterprise-scale requirements
- Doesn't provide clear separation for compliance frameworks
- May not be sufficient to compete with evolved industry offerings

### Option 2: Pure Flat Team Structure

**Approach:** Implement Teams as completely flat entities with no hierarchical relationships, requiring explicit access grants for each team-resource combination.

**Pros:**
- Eliminates inheritance complexity entirely
- Clear, auditable access relationships
- No risk of "orphaned permissions" through organizational changes
- Simple mental model for all user types

**Cons:**
- Significant administrative overhead at enterprise scale
- Doesn't support organizational modeling requirements
- May require extensive tooling to manage access grants efficiently
- Could force customers to implement hierarchy in external systems

### Option 3: Role-Based Access Control (RBAC) Enhancement

**Approach:** Implement comprehensive role-based permissions that define what actions can be performed rather than focusing on organizational structure.

**Pros:**
- Industry-standard approach understood by security professionals
- Fine-grained control over specific capabilities
- Better separation of concerns between identity and permissions
- Strong compliance framework support

**Cons:**
- Significant complexity increase for administrators and end users
- May not address organizational modeling needs
- Could create cognitive load that contradicts usability goals
- Requires extensive migration planning for current role-based permissions

### Option 4: Matrix-Based Access Control

**Approach:** Implement a two-dimensional matrix where Teams represent one axis and Resources/Projects represent another, with explicit relationship management.

**Pros:**
- Clean conceptual separation between organizational and resource hierarchies
- Supports complex organizational patterns (matrix organizations, temporary projects)
- Provides flexibility for both hierarchical and flat organizational patterns
- Clear audit trail through explicit relationship management

**Cons:**
- Potentially complex user interface and mental model
- Administrative overhead for managing matrix relationships
- Performance considerations for large matrices
- May be over-engineered solution for common use cases

## Success Criteria and Metrics

### Quantitative Success Metrics

**Performance and scale:**

- Support 10,000+ users with <2 second permission resolution time
- Handle 1,000+ teams and 1,000+ projects without performance degradation
- Achieve 99.95% uptime for permission-related operations

**Administrative efficiency:**

- Reduce average time-to-grant-access from current baseline to <5 minutes
- Decrease organizational structure and inheritance-related support issues by 50% from current baseline
- Enable bulk operations for 100+ team-resource relationships simultaneously
- Improve custom role assignment efficiency through organizational context

**Security and compliance:**

- Provide 100% audit trail coverage for all permission changes
- Pass compliance audits for NIST 800-53, ISO 27001, and SOX requirements

### Qualitative Success Metrics

**User experience:**

- User research showing >80% of administrators can correctly predict organizational inheritance patterns
- Developer survey indicating >70% satisfaction with access request experience
- Support team reporting reduced complexity in organizational structure and inheritance-related escalations
- Improved understanding of how custom roles apply through organizational context

**Enterprise adoption:**

- Fortune 500 customers successfully implementing Teams architecture
- Migration completion from group-based to team-based access within 6 months

**Competitive position:**

- Feature parity or superiority compared to major DevOps platforms
- Sales team reporting Teams architecture as competitive advantage
- Customer retention improvement in enterprise segment

## Dependencies and Integration Points

### Internal GitLab Dependencies

**Core Platform Integration:**

- User management and authentication systems
- Group and project permission resolution engines
- Custom roles and permissions system integration
- API frameworks for bulk operations and automation
- Audit logging and compliance reporting systems

**Feature Integration Requirements:**

- CI/CD pipeline permission integration for runner access and deployment gates
- Package registry access control for private packages and container images
- Security scanning and vulnerability management permission inheritance
- Issue and merge request access patterns for cross-functional collaboration

### External Integration Requirements

**Enterprise Identity Systems:**

- LDAP/enterprise directory group synchronization and mapping
- SAML assertion processing for team membership claims
- OIDC integration for just-in-time team provisioning
- Multi-factor authentication integration for sensitive team operations

**DevOps Toolchain Integration:**

- Kubernetes RBAC integration for cluster access management
- Infrastructure-as-Code tool access patterns (Terraform, Ansible)
- Monitoring and observability tool access inheritance
- Service mesh and API gateway authorization integration

### Migration and Compatibility Requirements

**Backward Compatibility:**

- Current group-based permissions must continue working during transition
- Existing API endpoints must maintain functionality with deprecation notices
- Customer automation scripts must continue working without modification
- Third-party integrations must not be disrupted during migration

**Migration Path Requirements:**

- Automated tools for converting group-based access to team-based access
- Rollback capabilities in case of migration issues
- Comprehensive validation tools to ensure permission equivalence
- Documentation and training materials for administrators managing transition

## Risk Assessment and Mitigation

### Technical Risks

**Performance and scalability risk:**

- Large-scale permission resolution could impact system performance
- Complex inheritance calculations may create database bottlenecks
- Migration process could cause temporary service degradation

**Mitigation strategies:**

- Implement comprehensive caching layers with cache invalidation strategies
- Design database schema optimized for permission resolution queries
- Plan migration in phases with rollback capabilities and performance monitoring

**Security risk:**

- Migration errors could inadvertently grant or remove access inappropriately
- New inheritance patterns could create unexpected privilege escalation paths
- Audit trail gaps during transition could impact compliance

**Mitigation strategies:**

- Extensive automated testing of permission resolution logic
- Comprehensive audit logging before, during, and after migration
- Security review of all inheritance patterns and edge cases

### Business and Adoption Risks

**Customer disruption risk:**

- Large enterprise customers may resist changes to access control patterns
- Learning curve for administrators could temporarily reduce productivity
- Integration with existing customer workflows may require significant adaptation

**Mitigation strategies:**

- Extensive customer research and feedback integration during design phase
- Comprehensive documentation, training, and migration support
- Gradual rollout with opt-in capabilities for early adopters

## Next Steps and Implementation Approach

### Research and Validation Phase

1. **Detailed user research**
   - Conduct usability studies on inheritance pattern preferences
   - Interview enterprise customers about organizational modeling needs
   - Test mental model alignment through prototype evaluation
   - Validate success metrics through baseline measurement

2. **Technical architecture deep dive**
   - Design database schema for optimal permission resolution performance
   - Create proof-of-concept implementation for scalability testing
   - Evaluate integration patterns with existing GitLab architecture
   - Assess migration complexity and risk mitigation strategies

3. **Competitive feature analysis**
   - Detailed feature comparison with major DevOps platforms
   - Analysis of customer switching patterns and motivations
   - Evaluation of enterprise sales competitive positioning
   - Assessment of differentiation opportunities

### Design and Prototyping Phase

1. **Architecture design documentation**
   - Detailed technical specifications for Teams entity and relationships
   - API design for team management, membership, and permission resolution
   - Database schema design optimized for performance and auditability
   - Integration specifications for external identity providers

2. **User experience design**
   - Wireframes and user flows for team creation and management
   - Permission inheritance visualization and audit trail interfaces
   - Migration tools and workflows for administrators
   - Progressive disclosure patterns for complex scenarios

3. **Implementation planning**
   - Phased delivery roadmap with clear milestones and dependencies
   - Resource allocation and team structure requirements
   - Risk mitigation plans and rollback strategies
   - Customer communication and support planning
