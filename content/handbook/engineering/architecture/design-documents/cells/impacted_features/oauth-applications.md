---
stage: enablement
group: Tenant Scale
description: 'Cells: OAuth applications'
---
<!-- vale gitlab.FutureTense = NO -->
{{% alert %}}
This document is a work-in-progress and represents a very early state of the
Cells design. Significant aspects are not documented, though we expect to add
them in the future. This is one possible architecture for Cells, and we intend to
contrast this with alternatives before deciding which approach to implement.
This documentation will be kept even if we decide not to implement this so that
we can document the reasons for not choosing this approach.
{{% /alert %}}

# Cells: OAuth applications

## 1. Definition

OAuth applications allow third-party applications to securely access resources associated with a GitLab user.
Users control what data they share with these applications.
OAuth applications can be created at different levels: instance-owned, user-owned, project-owned, and group-owned.
However, this is only for management purposes—**all OAuth applications are available instance-wide**.

Examples of instance-owned applications include: CustomersDot, GitLab Pages, GitLab CLI, Web IDE, and the VS Code Extension.

OAuth applications that include the `openid` scope are considered OpenID Connect (OIDC) applications.

## 2. Data Flow

The data flow for OAuth applications is detailed in the following documentation:

- [OAuth 2.0 identity provider API](https://docs.gitlab.com/ee/api/oauth2)
- [GitLab as an OpenID Connect identity provider](https://docs.gitlab.com/ee/integration/openid_connect_provider.html)

OAuth and OIDC have multiple endpoints, with variations in how these requests are routed to the appropriate Cell:

1. **Endpoints with `client_id` and `client_secret`:**
   Requests like `/oauth/authorize`, `/oauth/token`, and `/oauth/revoke` include these values either in the request body or URI.

1. **User session-based endpoints:**
   Endpoints like `/oauth/applications`, `/oauth/applications/new`, `/oauth/applications/:id`, and `/oauth/authorized_applications` are processed after the user session is established.

1. **Token-authenticated endpoints:**
   `/oauth/token/info` is authenticated using an OAuth token.

1. **Configuration endpoints:**
   Requests such as `.well-known/openid-configuration`, `.well-known/webfinger`, and `/oauth/discovery/keys` return configurations relevant across all Cells.

1. **User info endpoints:**
   `/userinfo` is authenticated via the access token sent in the `Authorization` header.

## 3. Implementation Status for Cells 1.0

OAuth applications are partially available in Cells 1.0 using a best-effort approach, despite two key limitations:

1. Path-based routing is not yet available
2. The OAuth applications table cannot be made cluster-wide at this time

Organization handling in Cells 1.0 works as follows:

1. The system attempts to determine the `organization_id` from the current_organization data fetched from the OAuth grant page
1. When current_organization data is not available, the system falls back to using the default organization
1. For the OAuth resource owner password flow, special handling is required:
   - The `organization_id` must be specified manually
   - If not specified, the system will fall back to a default `organization_id`

This implementation provides basic OAuth functionality while working within current technical constraints.

## 4. Future Proposal

### 4.1. Cluster-wide OAuth Applications

Once technical limitations are addressed in future versions, OAuth applications should be cluster-wide and synchronized across Cells, regardless of whether they are instance, user, project, or group owned. OAuth access grants, OAuth access tokens, and OAuth refresh tokens will be scoped to an Organization.

Pros:

- Enables third-party applications to register a single OAuth application per GitLab cluster
- Does not require admins of third-party applications to have visibility into GitLab infrastructure
- Preserves existing workflows (e.g., VS Code Extension ships with hardcoded OAuth App ID)

Cons:

- More complex as OAuth applications need to be synced across Cells
- Each organization requires a different token, requiring special handling for:
  - VS Code extension (needs to store tokens per organization)
  - Git access
  - Docker access

## 5. Alternative Approaches Considered

### 5.1. OAuth Applications Scoped to Cells / Organizations

OAuth applications, OAuth access grants, OAuth access tokens, and OAuth refresh tokens would be scoped to an Organization.

Pros:

- Less complex as OAuth applications do not need to be synced across Cells

Cons:

- Third-party applications need to install multiple OAuth applications: one per Cell
- Users need to understand which OAuth application is associated with a specific Cell
- Third-party application admins need visibility into GitLab infrastructure
- Need to create new OAuth applications as new Cells are created

### 5.2. All OAuth Entities are Cluster-wide

OAuth applications, OAuth access grants, OAuth access tokens, and OAuth refresh tokens would be cluster-wide.

Pros:

- Similar to Cluster-wide OAuth applications approach
- Enables single OAuth application registration per GitLab cluster
- No special handling required for Git, Docker, and API access credentials

Cons:

- Routing will not work as OAuth access tokens do not have a clear owning Cell
- Significant synchronization overhead for short-lived OAuth access tokens across Cells
