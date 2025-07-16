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
- If an on-premise installation would have platform-wide settings → Platform settings pattern

**Key Benefits of Federation-First Design:**

Features built with federation in mind work out-of-the-box with the Cells architecture across all GitLab Platform offerings (on-premise, Dedicated, SaaS on GitLab.com). Since each Cell and Organization is independent from each other, federation-first design naturally aligns with this architecture and ensures consistent functionality across all deployment models.

## Three Valid Feature Patterns

### Pattern 1: Organization-Scoped Features

*Examples: Organization-wide Integrations, System Hooks*

**When to use this pattern:**

- The feature manages configuration, policies, or resources within a single Organization
- Organization Owners need to enforce consistent practices across all projects in their Organization
- The feature operates entirely within Organization boundaries
- The feature would be implemented locally in an on-premise installation

**Key characteristics:**

- **Organization Owner control** - Organization Owners configure the feature for all projects within their Organization
- **Consistent enforcement** - Settings apply uniformly across all projects in the Organization
- **Complete isolation** - Each Organization's configuration is independent and invisible to other Organizations
- **Business unit alignment** - Reflects that Organizations represent separate business units

**Implementation approach:**

- Migrate from instance-wide to Organization-wide scope
- Provide Organization Owner permissions for feature configuration
- Ensure complete isolation between Organizations
- Design sensible defaults for new Organizations

**Example: Organization-wide Integrations**

- **Previous state**: Instance admins configured integrations (Slack, Email notifications, Redmine, Jira, etc.) for all projects on the instance
- **New state**: Organization Owners configure these integrations for all projects in their Organization
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

**Example: Hosted Runners (Federated Service)**

- **Global queue service**: Dedicated service manages CI job queues outside of GitLab.com infrastructure
- **Instance independence**: Any GitLab instance (Dedicated, on-premise, or Cell) can submit jobs to the global queue
- **Shared infrastructure**: Hosted runners are managed by the dedicated service, not individual GitLab instances
- **Availability protection**: Isolates runner infrastructure from GitLab.com to prevent resource contention
- **Federated access**: On-premise installations can access the same hosted runner infrastructure as GitLab.com
- **Technology flexibility**: Dedicated service can use appropriate queuing, orchestration, and runner management technologies
- **Scalability**: Global queue allows for efficient resource allocation across all GitLab instances

### Pattern 3: Platform Settings

*Example: Blocked Registration Domains, Infrastructure Limits*

**When to use this pattern:**

- The feature manages operational or infrastructure settings that need to be applied across all Organizations
- The setting affects the entire GitLab platform infrastructure
- The feature requires coordination at the Cell/infrastructure level
- Default behavior needs to be consistent, but Organizations may need customization options
- Cell-specific settings related to infrastructure/operations aspects of the particular Cell

**Key characteristics:**

- **Platform-level defaults** - Managed by instance administrators with global defaults for their GitLab instance
- **Optional Organization overrides** - Some settings can be overridden by Organization Owners when appropriate
- **Infrastructure/operational focus** - Typically related to infrastructure, operational limits, or platform-wide defaults
- **Global consistency with flexibility** - Ensures consistent platform behavior while allowing Organization customization where needed
- **Cell-specific configurations** - May include Cell-specific infrastructure or operational settings

**Two sub-patterns:**

**Sub-pattern 3a: Non-overridable Platform Settings**

- Settings that cannot be overridden by Organizations
- Used for security, compliance, or critical infrastructure requirements
- Example: Blocked registration domains, security policies

**Sub-pattern 3b: Overridable Platform Settings**

- Settings with platform-wide defaults that Organizations can customize
- Used for operational limits, feature defaults, or infrastructure settings
- Example: Default CI/CD timeouts, storage limits, rate limits
- Provide an internal API for GitLab.com automation - initially platform settings will be applied outside of the Cell using API calls (see [clusterwide syncing](decisions/014_clusterwide_syncing_in_cells_1_0.md) and [admin area setting synchronization](proposal-admin_area_setting_sychronization_in_cells.md))

**Implementation approach:**

- Set sensible platform-wide defaults
- Provide Organization Owner interfaces for overridable settings
- Ensure consistent application across all Organizations for non-overridable settings
- Consider how these settings work for on-premise installations

**Example: Blocked Registration Domains (Non-overridable)**

- **Purpose**: List of email domains that are blocked from registering new accounts
- **Scope**: Must be consistent across all Organizations for security and compliance
- **Control**: Cannot be overridden by individual Organizations
- **Management**: Managed by instance administrators
- **On-premise**: On-premise installations would have their own platform-wide blocked domains list managed by their instance administrators
- **Why non-overridable**: Security and compliance requirements apply to the entire instance

**Example: Default CI/CD Job Timeout (Overridable)**

- **Purpose**: Default timeout for CI/CD jobs across the instance
- **Scope**: Instance-wide default with Organization-level customization
- **Control**: Organizations can override the default timeout within reasonable limits
- **Management**: Instance administrators set the global default, Organization Owners can customize
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
- **Platform-wide security/compliance** → Use Pattern 3 (Platform settings - non-overridable)
- **Platform-wide operational/infrastructure** → Use Pattern 3 (Platform settings - potentially overridable)
- **Organization-to-Organization sharing** → **STOP** - This is not supported in the architecture

### Step 4: On-Premise Validation

**Question:** How would this work for an on-premise GitLab installation?

- **Pattern 1**: On-premise would implement this feature locally within their installation
- **Pattern 2**: On-premise would access public resources from GitLab.com
- **Pattern 3**: On-premise would have their own platform-wide settings managed by their administrators
- **If none fit**: Reconsider the requirement - it may not align with the architecture

## Implementation Guidelines

### Technical Considerations

**For Organization-scoped features:**

- Design clear Organization Owner permissions and interfaces
- Implement complete data isolation between Organizations with strong enforcement patterns (Row-Level Security or Application-Level enforcement) to prevent data leakage
- Plan migration paths from instance-wide configurations
- Consider default configurations for new Organizations
- Ensure feature scales within Organization boundaries
- Design items to be scoped per Organization (e.g., global bot accounts become per-Organization accounts) to maintain data isolation

**For federated public resources:**

- Always use dedicated endpoints to protect GitLab.com availability
- Design APIs that handle network latency and failures gracefully
- Implement appropriate caching strategies for frequently accessed resources
- Consider authentication mechanisms for accessing public resources
- Plan for content delivery optimization and performance
- Choose appropriate technology stack for the dedicated service (not limited to specific patterns)
- Design for eventual evolution from proxy endpoints to fully dedicated services

**For platform settings:**

- Identify what truly requires instance-wide defaults or consistency
- Determine which settings should be overridable by Organizations vs. non-overridable
- Ensure appropriate administrative controls for both instance and Organization levels
- Consider how different GitLab instances would handle these settings and overrides
- Design clear boundaries between instance defaults and Organization customization

### User Experience Principles

**Clear boundaries:**

- Make it obvious when users are accessing Organization-scoped vs. public resources
- Provide clear feedback about feature scope and limitations
- Distinguish between Organization Owner and Instance Administrator capabilities

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

- **Think federation-first with organization-first emphasis** - Always consider how the feature would work for on-premise installations, with particular focus on Organization-scoped design
- **Design for Cells architecture compatibility** - Features built with federation in mind work out-of-the-box across all GitLab Platform offerings (on-premise, Dedicated, SaaS)
- **Treat Organizations as independent** - Each Organization should function as if it's the only one
- **Design for isolation** - Ensure complete separation between Organizations for patterns 1 and 2
- **Plan for failures** - Handle network issues and service unavailability gracefully
- **Consider defaults** - Design good out-of-the-box experiences for new Organizations
- **Validate with on-premise use cases** - Ensure the pattern makes sense for on-premise installations
- **Use dedicated endpoints for public resources** - Always protect GitLab.com availability by routing through dedicated infrastructure
- **Choose appropriate administrative levels** - Distinguish clearly between Organization Owner and Instance Administrator capabilities

### Don't

- **Design cross-Organization sharing** - Organizations cannot share resources or data with each other
- **Assume Organizations want to interact** - Complete independence is the architectural goal
- **Create unnecessary platform settings** - Only use Pattern 3 for genuine operational/infrastructure needs
- **Ignore performance implications** - Federation and isolation add complexity and latency
- **Forget about migration paths** - Existing instance-wide features need clear migration strategies
- **Bypass the decision framework** - Always validate feature design against the three patterns
- **Make settings non-overridable without justification** - Only restrict Organization customization when truly necessary for security/compliance
- **Make direct API calls to GitLab.com** - Use dedicated endpoints to prevent resource contention

## Common Anti-Patterns to Avoid

### Anti-Pattern: Cross-Organization Resource Sharing

- Organizations sharing resources, data, or configuration with each other
- Features that require Organizations to know about each other's existence
- Any form of direct Organization-to-Organization interaction or collaboration

### Anti-Pattern: Unnecessary Platform Settings

- Settings that apply across multiple Organizations without genuine operational/infrastructure justification
- Features that require coordination between Organizations for business (not technical/operational) reasons
- Global configuration that affects multiple Organizations without instance-level necessity
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

- Organization Owner configures integrations (Slack, Email notifications, Redmine, Jira) for all projects in their Organization
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

### ✅ Good: Hosted Runners (Federated Service)

- Global queue service manages CI job queues outside of GitLab.com infrastructure
- Any GitLab instance (Dedicated, on-premise, or Cell) can submit jobs to the global queue
- Shared runner infrastructure managed by dedicated service, not individual GitLab instances
- Isolates runner infrastructure from GitLab.com to prevent resource contention
- On-premise installations can access the same hosted runner infrastructure as GitLab.com
- Efficient resource allocation across all GitLab instances through global queue management

### ✅ Good: Platform Blocked Domains (Non-overridable)

- List of email domains blocked from registration managed at the instance level
- Consistent across all Organizations for security and compliance reasons
- Cannot be overridden by individual Organizations
- Each GitLab instance (on-premise, Dedicated, GitLab.com) has their own platform-wide blocked domains
- Managed by instance administrators, not Organization Owners
- Genuine security/compliance justification for non-overridable platform-wide scope

### ✅ Good: Default CI/CD Job Timeout (Overridable)

- Instance-wide default timeout for CI/CD jobs
- Organizations can override the default within reasonable limits
- Provides consistent infrastructure protection while allowing customization
- Instance administrators set global defaults, Organization Owners can customize
- Each GitLab instance has their own defaults with Organization override capability
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
- [ ] If platform settings, the setting requires instance-wide consistency for security/compliance/operational reasons
- [ ] If platform settings, it's clear whether the setting should be overridable by Organizations
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
| Access to public resources | Federated Public Resources | CI Catalog (public components), Hosted Runners |
| Platform-wide security/compliance | Platform Settings (non-overridable) | Blocked registration domains |
| Platform-wide operational/infrastructure | Platform Settings (overridable) | Default CI/CD timeouts, storage limits |
| Cross-Organization sharing | **Not Supported** | None - reconsider requirement |

## Conclusion

The Cells and Organizations architecture provides a clear framework for feature design with three distinct patterns. By following the federation-first thinking approach and validating against on-premise use cases, you can ensure that features are designed appropriately for this distributed architecture while maintaining the core principle of Organization independence.

**Federation-first design provides automatic compatibility** with the Cells architecture across all GitLab Platform offerings (on-premise, Dedicated, SaaS on GitLab.com). Since each Cell and Organization operates independently, features designed with federation principles naturally work across all deployment models without additional adaptation.
