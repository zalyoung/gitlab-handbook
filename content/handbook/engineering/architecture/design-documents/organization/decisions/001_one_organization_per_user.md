---
owning-stage: "~devops::tenant scale"
description: 'Organization ADR 001: One Organization per User'
---

# Organization ADR 001: One Organization per User

## Context

On GitLab.com a User can move between groups provided they have membership. Organizations will segment the instance wide collection of groups with Organization boundaries. This raises questions around handling of group memberships that span multiple Organizations.

Further to the complications introduced by logical Organization boundaries, there is a related concern with Cells that will add a physical boundary between Organizations.

The current GitLab.com architecture has evolved as a monolithic system where users can freely access multiple groups and projects across the platform. With the introduction of Organizations and Cells, fundamental decisions must be made about how users relate to these new boundaries.

Two competing visions exist for the future architecture:

1. 2023-2024 Vision: The GitLab.com experience remains similar to today, allowing users to hop in/out of different Organizations within the same account.
2. 2025 Vision: Users experience GitLab.com as it is today OR they move to a new isolated Organization product. In this model, users don't move between Organizations.

The key architectural challenge centers on "clusterwide" concepts versus organization-specific isolation:

- The Cells project initially conceived a shared data layer across all Cells, where entities like Users would exist in this shared layer and could span multiple Cells.
- However, implementing clusterwide user management has proven extremely complex.
- Enterprise customers request total isolation for their organizations, contradicting the need for cross-organization user access.

There are also significant product considerations regarding user identity:

- If a user exists across multiple Organizations and then one organization implements a policy restricting access, how should the system handle the user's data in other Organizations?
- Should users be able to access both public repositories (like open source projects) and private organizational resources with a single identity?
- How will authentication, billing, and SSO work when users have access to multiple Organizations with potentially different policies?

The path forward requires balancing technical feasibility, customer needs, and product vision while addressing:

1. Feature parity between the current monolith and new Organizations
2. Migration strategies for existing and new customers
3. The relationship between the Organizations feature and Cells infrastructure
4. The fundamental question of whether users belong to the cluster or to specific Organizations

## Decision

After thorough evaluation, we have decided to implement a User-per-Organization model rather than a Clusterwide User model.

There were two important drivers of the problem:

1. Solving the GitLab.com scaling problem. This is an engineering problem that attempts to leave the product in place while scaling out the system infrastructure.
2. Providing Organizations an isolated GitLab environment. This is a by-product of introducing Organizations that is indifferent to infrastructure.

It turned out that trying to leave the product in place was far more challenging than anticipated. It was also an incorrect assumption that customers wanted the product to remain the same. A happy coincidence is that we can target isolated Organizations and solve the scaling problem at the same time.
Key aspects of this decision:

1. Users will be scoped to Organizations: Each user identity will exist within the context of a specific Organization, not across the entire cluster. This means a person may have multiple user accounts, one per Organization they need to access.

2. Legacy and Public Access: The existing GitLab.com experience will be preserved as the "default organization" where:
  - Public repositories (e.g., gitlab-org/gitlab) will remain accessible
  - Certain private organizations (e.g., gitlab-com/infra) will continue to operate
  - Users will maintain their existing accounts and access patterns

3. New Isolated Organizations: New organizations requiring isolation will be provisioned in separate Cells with organization-specific user accounts:

  - Enterprise customers requesting isolation will get a completely separate user space
  - Users will not be able to access multiple isolated organizations with a single account
  - A Google Workspace-style account switcher could facilitate user experience when working across multiple Organizations in the future

4. Database Architecture: Users will be classified in the database schema as gitlab_main_user rather than gitlab_main_clusterwide, while still allowing foreign key relationships with gitlab_main_cell:

  - This pattern allows us to isolate user tables without enforcing complete schema separation initially
  - The foreign key issues between user tables and cell tables will be addressed through progressive schema separation

5. Future Extensibility: This decision does not preclude future implementation of a true clusterwide user system:

  - A new authentication architecture could potentially enable cross-organization access in the future
  - Clusterwide features could be selectively implemented when business value justifies the technical complexity

This decision significantly simplifies the implementation path while meeting the immediate needs of enterprise customers for isolation and addressing GitLab.com's scaling requirements.

## Consequences

### Positive Consequences

1. Reduced Technical Complexity: Eliminating the clusterwide user concept significantly simplifies implementation.
2. Faster Time to Market: The Organization feature can be delivered more quickly with this approach, as it avoids complex cross-cell user management.
3. Better Alignment with Enterprise Requirements: This model directly addresses enterprise customers' demands for complete isolation, providing a clear path to offer isolated Organizations.
4. Scalability Improvements: Moving isolated organizations out of the legacy cell will help solve GitLab.com's scaling problems without having to migrate the most complex case (GitLab itself).
5. Progressive Implementation Path: The decision allows for incremental implementation, starting with isolated Organizations while maintaining the existing GitLab.com experience.

### Negative Consequences

1. User Experience Fragmentation: Users who need to work across multiple isolated Organizations will need to manage multiple accounts and switch between them.
2. Open Source Contribution Barriers: Contributors who want to work on both private isolated Organizations and public projects will need separate accounts, potentially reducing open source participation.
3. Feature Duplication: Some features like SSO and Billing will need to be reimplemented at the Organization level instead of just at the Top-level group.
4. Migration Challenges: Existing users with memberships across various groups will face complications when some of these groups move to isolated Organizations.
5. Potential Data Redundancy: Users with multiple accounts across Organizations may have duplicated profile data and settings.

### Neutral Consequences

1. Authentication Evolution: This decision shifts authentication requirements, necessitating a future authentication architecture to potentially enable cross-organization access.
2. User Table Classification: User tables will be classified as gitlab_main_user rather than part of the clusterwide schema, affecting database organization.
3. Two-Product Strategy: GitLab.com effectively becomes two distinct products: the traditional public-focused platform and a new isolated Organization offering.
4. Deferring Clusterwide Features: Complex features like cross-Organization aggregation (e.g., for /explore) are deferred indefinitely, eliminating current implementation costs but potentially requiring future investment.
5. Feature Parity Roadmap Change: Moving instance-level features down to Organization level becomes a long-term roadmap item rather than a requirement for initial launch.

## Alternatives

1. Clusterwide User Model
The originally envisioned approach involved a shared data layer across all Cells where users could exist across multiple Organizations. This would preserve the current GitLab.com experience while adding isolation capabilities.

Pros: Maintains seamless user experience across organizations, supports open source contribution from any user account, aligns with the original "utopian vision" for Cells.
Cons: Extremely complex to implement (147 foreign key issues identified), creates significant product challenges around user management policies, and doesn't align well with enterprise isolation requirements.

2. Split User Identity Model
A proposed hybrid approach that would separate the concept of "User" (login credentials) from "UserIdentity" (organization-specific profiles).

Pros: Could potentially enable single sign-on across organizations while maintaining organization-specific identities, provides a middle ground between isolation and accessibility.
Cons: Still introduces significant technical complexity, creates complicated product scenarios around user management, and doesn't fully satisfy enterprise isolation requirements.
