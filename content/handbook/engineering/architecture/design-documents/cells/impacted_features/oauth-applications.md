---
stage: enablement
group: Tenant Scale
title: 'Cells: OAuth applications'
---

{{% alert %}}
This document is a work-in-progress and represents a very early state of the
Cells design. Significant aspects are not documented, though we expect to add
them in the future. This is one possible architecture for Cells, and we intend to
contrast this with alternatives before deciding which approach to implement.
This documentation will be kept even if we decide not to implement this so that
we can document the reasons for not choosing this approach.
{{% /alert %}}

## 1. Definition

OAuth applications allow third-party applications to securely access resources associated with a GitLab user.
Users control what data they share with these applications.

OAuth applications can be created at different levels: cluster-owned, user-owned, and group-owned.
However, this is only for management purposes—**all OAuth applications are available cluster-wide**.

Examples of cluster-owned applications include:

- CustomersDot
- GitLab Pages
- GitLab CLI
- Web IDE
- VS Code Extension

OAuth applications that include the `openid` scope are considered OpenID Connect (OIDC) applications.

## 2. Data Flow

The data flow for OAuth applications is detailed in the following documentation:

- [OAuth 2.0 identity provider API](https://docs.gitlab.com/ee/api/oauth2)
- [GitLab as an OpenID Connect identity provider](https://docs.gitlab.com/ee/integration/openid_connect_provider.html)

OAuth and OIDC have multiple endpoints, with variations in how these requests are routed to the appropriate Cell:

1. **Endpoints with `client_id` and `client_secret`:**
   - Requests like `/oauth/authorize`, `/oauth/token`, and `/oauth/revoke`
   - Include these values either in the request body or URI

2. **User session-based endpoints:**
   - Endpoints like `/oauth/applications`, `/oauth/applications/new`, `/oauth/applications/:id`, and `/oauth/authorized_applications`
   - Processed after the user session is established

3. **Token-authenticated endpoints:**
   - `/oauth/token/info` is authenticated using an OAuth token

4. **Configuration endpoints:**
   - Requests such as `.well-known/openid-configuration`, `.well-known/webfinger`, and `/oauth/discovery/keys`
   - Return configurations relevant across all Cells

5. **User info endpoints:**
   - `/oauth/userinfo` is authenticated by using the access token sent in the `Authorization` header

## 3. Implementation Status for Cells 1.0

OAuth applications are partially available in Cells 1.0 using a best-effort approach, despite two key limitations:

1. Path-based routing is not yet available
2. The OAuth applications table cannot be made cluster-wide at this time

Organization handling in Cells 1.0 works as follows:

1. The system attempts to determine the `organization_id` from the current_organization data fetched from the OAuth grant page
2. When current_organization data is not available, the system falls back to using the default organization
3. For the OAuth resource owner password flow, special handling is required:
   - The `organization_id` must be specified manually
   - If not specified, the system will fall back to a default `organization_id`

This implementation provides basic OAuth functionality while working within current technical constraints.
The default organization in this context is the first organization in the legacy cell which contains the existing data from customers. The legacy cell is the original instance of GitLab.com.

For OAuth applications which have to work cluster-wide, we need to update the data flow, and it's beyond the scope of Cells 1.0.
