---
stage: core platform
group: Tenant Scale
title: 'Cells and Organizations: Feature Design Handbook'
toc_hide: true
---

## Core Architecture Principles

### Complete Organization Independence
- **Organizations are completely isolated** - Each Organization operates as an independent business unit with no direct interaction with other Organizations
- **Cells are isolated from each other** - They share no data and operate independently
- **Think of each Organization as its own GitLab instance** - This is the fundamental mental model for feature design

### Design Philosophy: Federation-First Thinking
When designing any feature for GitLab.com, always ask: **"How would this work for an on-premise GitLab installation?"**

This question helps determine the correct pattern:
- If an on-premise installation would implement this feature locally → Organization-scoped pattern
- If an on-premise installation would access GitLab.com for this feature → Federated public resources pattern
- If an on-premise installation would have platform-wide settings → Cluster-wide settings pattern

**Key Benefits of Federation-First Design:**
Features built with federation in mind work out-of-the-box with the Cells architecture across all GitLab Platform offerings (on-premise, Dedicated, SaaS on GitLab.com). Since each Cell and Organization is independent from each other, federation-first design naturally aligns with this architecture and ensures consistent functionality across all deployment models.

## Three Valid Feature Patterns

### Pattern 1: Organization-Scoped Features
*Examples: Organization-wide Integrations, System Hooks*

**When to use this pattern:**
- The feature manages configuration, policies, or resources within a single Organization
- Organization Admins need to enforce consistent practices across all projects in their Organization
- The feature operates entirely within Organization boundaries
- The feature would be implemented locally in an on-premise installation

**Key characteristics:**
- **Organization Admin control** - Organization Admins configure the feature for all projects within their Organization
- **Consistent enforcement** - Settings apply uniformly across all projects in the Organization
- **Complete isolation** - Each Organization's configuration is independent and invisible to other Organizations
- **Business unit alignment** - Reflects that Organizations represent separate business units

**Implementation approach:**
- Migrate from instance-wide to Organization-wide scope
- Provide Organization Admin permissions for feature configuration
- Ensure complete isolation between Organizations
- Design sensible defaults for new Organizations

**Example: Organization-wide Integrations**
- **Previous state**: Instance admins configured integrations (Slack, Email notifications, Redmine, Jira, etc.) for all projects on the instance
- **New state**: Organization Admins configure these integrations for all projects in their Organization
- **Why this makes sense**: Each Organization typically uses different external tools (different Slack workspaces, email domains, ticketing systems)
- **Implementation**: Each Organization has its own integration configuration with complete isolation
- **Migration path**: Convert instance-wide settings to Organization-wide defaults

**Example: System Hooks**
- **Previous state**: System-wide hooks sent notifications for changes across the entire instance
- **New state**: Organization-scoped hooks send notifications only for changes within that Organization
- **Why this makes sense**: Organizations want notifications about their own activities, not other Organizations' activities
- **Implementation**: Each Organization configures its own webhook endpoints and notification preferences
- **Migration path**: Convert instance-wide hooks to Organization-scoped hooks

### Pattern 2: Federated Public Resources
*Example: CI Catalog (Public Components)*

**When to use this pattern:**
- The feature provides access to truly public resources (like public CI components, templates, libraries)
- On-premise installations currently lack access to these public resources from GitLab.com
- The resources are designed for public consumption and would benefit all GitLab installations
- The feature addresses a current gap in on-premise functionality

**Key characteristics:**
- **Public resource access** - Organizations and on-premise installations can access publicly available resources
- **Solves on-premise gaps** - Addresses current limitations where on-premise cannot access GitLab.com public resources
- **High-performance distribution** - Often benefits from dedicated services for caching and distribution
- **No Organization data sharing** - Only truly public resources are accessible, not Organization-specific content
- **Hybrid model support** - Can combine local private resources with federated public resources

**Implementation approaches:**

**Option A: Federated API Calls via Dedicated Endpoint**
- API calls to dedicated endpoints (e.g., ci-catalog.gitlab.com) that may initially proxy to GitLab.com
- Protects GitLab.com availability by routing public resource requests through dedicated infrastructure
- Suitable for initial implementation while providing isolation from main platform
- May have higher latency for frequent access but maintains platform stability

**Option B: Dedicated Service**
- Specialized infrastructure optimized for public resource distribution
- Can use any suitable technology (databases, caching layers, CDNs, search engines, etc.)
- Not limited to OCI registry patterns - choose technology based on use case requirements
- Better performance and caching for high-frequency access
- Complete isolation from GitLab.com infrastructure

**Option C: Progressive Enhancement**
- Start with dedicated endpoint that proxies to GitLab.com
- Migrate to fully dedicated service as scale demands increase
- Provides evolutionary path without breaking changes
- Allows for gradual optimization and technology selection

**Example: CI Catalog (Hybrid Model)**
- **Local private components**: Organizations can publish and use private CI components within their Organization
- **Federated public components**: Organizations can access public components through dedicated endpoints (e.g., ci-catalog.gitlab.com)
- **Availability protection**: Dedicated endpoints protect GitLab.com availability by isolating public resource traffic
- **On-premise gap solved**: On-premise installations can access public components through dedicated endpoints (addressing current limitation)
- **Clear boundaries**: Local components remain private within Organization boundaries
- **Public accessibility**: Public components are accessible across all Organizations and on-premise installations
- **Technology flexibility**: Dedicated service can use any suitable technology stack based on requirements
- **Performance evolution**: Can evolve from proxy endpoints to fully dedicated services for better performance

### Pattern 3: Cluster-Wide Settings
*Example: Blocked Registration Domains, Infrastructure Limits*

**When to use this pattern:**
- The feature manages operational or infrastructure settings that need to be applied globally across all Organizations
- The setting affects the entire GitLab.com platform infrastructure
- The feature requires coordination at the Cell/infrastructure level
- Default behavior needs to be consistent, but Organizations may need customization options

**Key characteristics:**
- **Platform-level defaults** - Managed by GitLab.com platform administrators with global defaults
- **Optional Organization overrides** - Some settings can be overridden by Organization Admins when appropriate
- **Infrastructure/operational focus** - Typically related to infrastructure, operational limits, or platform-wide defaults
- **Global consistency with flexibility** - Ensures consistent platform behavior while allowing Organization customization where needed

**Two sub-patterns:**

**Sub-pattern 3a: Non-overridable Cluster-Wide Settings**
- Settings that cannot be overridden by Organizations
- Used for security, compliance, or critical infrastructure requirements
- Example: Blocked registration domains, security policies

**Sub-pattern 3b: Overridable Cluster-Wide Settings**
- Settings with platform-wide defaults that Organizations can customize
- Used for operational limits, feature defaults, or infrastructure settings
- Example: Default CI/CD timeouts, storage limits, rate limits

**Implementation approach:**
- Set sensible platform-wide defaults
- Provide Organization Admin interfaces for overridable settings
- Ensure consistent application across all Organizations for non-overridable settings
- Consider how these settings work for on-premise installations

**Example: Blocked Registration Domains (Non-overridable)**
- **Purpose**: List of email domains that are blocked from registering new accounts
- **Scope**: Must be consistent across all Organizations for security and compliance
- **Control**: Cannot be overridden by individual Organizations
- **Management**: Managed by GitLab.com platform administrators
- **On-premise**: On-premise installations would have their own cluster-wide blocked domains list
- **Why non-overridable**: Security and compliance requirements apply to the entire platform

**Example: Default CI/CD Job Timeout (Overridable)**
- **Purpose**: Default timeout for CI/CD jobs across the platform
- **Scope**: Platform-wide default with Organization-level customization
- **Control**: Organizations can override the default timeout within reasonable limits
- **Management**: Platform administrators set the global default, Organization Admins can customize
- **On-premise**: On-premise installations would have their own defaults with Organization overrides
- **Why overridable**: Different Organizations have different operational needs while maintaining infrastructure protection

## Feature Design Decision Framework

### Step 1: Scope Assessment
**Question:** What is the natural scope of this feature?

Evaluate these characteristics:
- **Organization-scoped**: Feature manages resources, configuration, or policies within a single Organization
- **Public resources**: Feature provides access to truly public resources that benefit all installations
- **Platform-wide**: Feature manages settings that must be consistent across all Organizations for security/compliance

### Step 2: Cross-Organization Requirements
**Question:** Does this feature need to work beyond a single Organization's boundaries?

- **No** → Use Pattern 1 (Organization-scoped)
- **Yes** → Continue to Step 3

### Step 3: Resource Type Assessment
**Question:** What type of cross-Organization requirement is this?

- **Access to public resources** → Use Pattern 2 (Federated public resources)
- **Platform-wide security/compliance** → Use Pattern 3 (Cluster-wide settings - non-overridable)
- **Platform-wide operational/infrastructure** → Use Pattern 3 (Cluster-wide settings - potentially overridable)
- **Organization-to-Organization sharing** → **STOP** - This is not supported in the architecture

### Step 4: On-Premise Validation
**Question:** How would this work for an on-premise GitLab installation?

- **Pattern 1**: On-premise would implement this feature locally within their installation
- **Pattern 2**: On-premise would access public resources from GitLab.com
- **Pattern 3**: On-premise would have their own cluster-wide settings managed by their administrators
- **If none fit**: Reconsider the requirement - it may not align with the architecture

## Implementation Guidelines

### Technical Considerations

**For Organization-scoped features:**
- Design clear Organization Admin permissions and interfaces
- Implement complete data isolation between Organizations
- Plan migration paths from instance-wide configurations
- Consider default configurations for new Organizations
- Ensure feature scales within Organization boundaries

**For federated public resources:**
- Always use dedicated endpoints to protect GitLab.com availability
- Design APIs that handle network latency and failures gracefully
- Implement appropriate caching strategies for frequently accessed resources
- Consider authentication mechanisms for accessing public resources
- Plan for content delivery optimization and performance
- Choose appropriate technology stack for the dedicated service (not limited to specific patterns)
- Design for eventual evolution from proxy endpoints to fully dedicated services

**For cluster-wide settings:**
- Identify what truly requires platform-level consistency
- Ensure appropriate administrative controls and interfaces
- Consider how on-premise installations would handle these settings
- Maintain security and compliance requirements
- Design for Cell-level administration

### User Experience Principles

**Clear boundaries:**
- Make it obvious when users are accessing Organization-scoped vs. public resources
- Provide clear feedback about feature scope and limitations
- Distinguish between Organization Admin and Platform Admin capabilities

**Performance expectations:**
- Set appropriate expectations for federated access to public resources
- Provide meaningful alternatives when public resources are unavailable
- Design for graceful degradation when external resources are inaccessible

**Default behavior:**
- Design sensible defaults for new Organizations
- Consider what should happen before any configuration is applied
- Provide clear guidance for initial setup and configuration

### Migration Strategy

**From instance-wide to Organization-scoped:**
- Ensure backward compatibility during migration period
- Plan for data migration and permission model changes
- Provide clear communication about scope changes to users
- Design migration tools and processes

**Gradual rollout:**
- Plan for phased deployment across Cells and Organizations
- Consider feature flags for controlled rollout
- Monitor performance and user experience during migration
- Provide rollback mechanisms if needed

## Best Practices

### Do
- **Think federation-first** - Always consider how the feature would work for on-premise installations
- **Design for Cells architecture compatibility** - Features built with federation in mind work out-of-the-box across all GitLab Platform offerings (on-premise, Dedicated, SaaS)
- **Treat Organizations as independent** - Each Organization should function as if it's the only one
- **Design for isolation** - Ensure complete separation between Organizations for patterns 1 and 2
- **Plan for failures** - Handle network issues and service unavailability gracefully
- **Consider defaults** - Design good out-of-the-box experiences for new Organizations
- **Validate with on-premise use cases** - Ensure the pattern makes sense for on-premise installations

### Don't
- **Design cross-Organization sharing** - Organizations cannot share resources or data with each other
- **Assume Organizations want to interact** - Complete independence is the architectural goal
- **Create unnecessary cluster-wide settings** - Only use Pattern 3 for genuine security/compliance needs
- **Ignore performance implications** - Federation and isolation add complexity and latency
- **Forget about migration paths** - Existing instance-wide features need clear migration strategies
- **Bypass the decision framework** - Always validate feature design against the three patterns

## Common Anti-Patterns to Avoid

### Anti-Pattern: Cross-Organization Resource Sharing
- Organizations sharing resources, data, or configuration with each other
- Features that require Organizations to know about each other's existence
- Any form of direct Organization-to-Organization interaction or collaboration

### Anti-Pattern: Unnecessary Cluster-Wide Settings
- Settings that apply across multiple Organizations without genuine operational/infrastructure justification
- Features that require coordination between Organizations for business (not technical/operational) reasons
- Global configuration that affects multiple Organizations without platform-level necessity
- Making settings non-overridable when Organizations have legitimate customization needs

### Anti-Pattern: Assuming Cross-Organization Needs
- Designing features that "might" need cross-Organization access in the future
- Creating unnecessary complexity for theoretical requirements
- Not validating requirements against the on-premise use case

### Anti-Pattern: Bypassing Organization Boundaries
- Features that circumvent Organization isolation for convenience
- Shared caches or data stores that leak information between Organizations
- Global search or discovery that spans multiple Organizations

## Examples in Practice

### ✅ Good: Organization-wide Integrations
- Organization Admin configures integrations (Slack, Email notifications, Redmine, Jira) for all projects in their Organization
- Each Organization has independent integration configuration with their own external services
- No cross-Organization visibility or sharing of integration settings
- Clear migration path from instance-wide configuration
- Makes business sense since Organizations use different external tools

### ✅ Good: Organization-scoped System Hooks
- Organization-level webhooks for notifications about changes within the Organization
- Each Organization configures its own webhook endpoints and notification preferences
- Complete isolation between Organizations' notification systems
- Clear migration from instance-wide system hooks
- Organizations only receive notifications about their own activities

### ✅ Good: Federated CI Catalog (Hybrid Model)
- Organizations can publish and use private CI components within their Organization (local catalog)
- Organizations can also access public components through dedicated endpoints (e.g., ci-catalog.gitlab.com)
- Dedicated endpoints protect GitLab.com availability by isolating public resource traffic
- On-premise installations can access public components through the same dedicated endpoints
- Local components remain private within the Organization boundary
- Public components are accessible across all Organizations and on-premise installations
- Can evolve from proxy endpoints to fully dedicated services using appropriate technology stack

### ✅ Good: Cluster-Wide Blocked Domains (Non-overridable)
- List of email domains blocked from registration managed at the platform level
- Consistent across all Organizations for security and compliance reasons
- Cannot be overridden by individual Organizations
- On-premise installations have their own cluster-wide blocked domains
- Managed by GitLab.com platform administrators, not Organization Admins
- Genuine security/compliance justification for non-overridable cluster-wide scope

### ✅ Good: Default CI/CD Job Timeout (Overridable)
- Platform-wide default timeout for CI/CD jobs
- Organizations can override the default within reasonable limits
- Provides consistent infrastructure protection while allowing customization
- Platform administrators set global defaults, Organization Admins can customize
- On-premise installations have their own defaults with Organization override capability
- Balances operational needs with infrastructure protection

### ❌ Avoid: Any Cross-Organization Features
- Features that require Organizations to interact with each other
- Sharing resources between Organizations
- Global settings that affect multiple Organizations without platform-level justification
- Features that don't make sense for isolated on-premise installations

## Validation Checklist

Before implementing any feature, verify:

- [ ] The feature works with complete Organization isolation (for Patterns 1 and 2)
- [ ] The on-premise use case is clear and makes sense
- [ ] No cross-Organization interaction is required
- [ ] The feature fits clearly into one of the three valid patterns
- [ ] If cluster-wide, the setting requires platform-level consistency for security/compliance/operational reasons
- [ ] If cluster-wide, it's clear whether the setting should be overridable by Organizations
- [ ] If federated, the resources are truly public and benefit all installations
- [ ] Migration path from existing instance-wide features is defined
- [ ] Default behavior for new Organizations is designed
- [ ] Performance implications of federation are considered
- [ ] Security boundaries between Organizations are maintained
- [ ] Administrative controls are appropriate for the pattern chosen

## Pattern Selection Quick Reference

| Feature Characteristic | Pattern | Example |
|------------------------|---------|---------|
| Organization-internal configuration | Organization-scoped | Integrations, System Hooks |
| Access to public resources | Federated Public Resources | CI Catalog (public components) |
| Platform-wide security/compliance | Cluster-wide Settings (non-overridable) | Blocked registration domains |
| Platform-wide operational/infrastructure | Cluster-wide Settings (overridable) | Default CI/CD timeouts, storage limits |
| Cross-Organization sharing | **Not Supported** | None - reconsider requirement |

## Conclusion

The Cells and Organizations architecture provides a clear framework for feature design with three distinct patterns. By following the federation-first thinking approach and validating against on-premise use cases, you can ensure that features are designed appropriately for this distributed architecture while maintaining the core principle of Organization independence.

**Federation-first design provides automatic compatibility** with the Cells architecture across all GitLab Platform offerings (on-premise, Dedicated, SaaS on GitLab.com). Since each Cell and Organization operates independently, features designed with federation principles naturally work across all deployment models without additional adaptation.
