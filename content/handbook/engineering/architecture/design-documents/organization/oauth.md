---
title: "Organization OAuth Provider"
owning-stage: "~devops::tenant scale"
group: Organizations
toc_hide: true
---

## Summary

This document outlines the design for OAuth applications within GitLab's Organizations architecture. The proposed changes introduce organization-scoped OAuth applications while maintaining backward compatibility with existing instance-wide applications.

## Problem Statement

Currently, all OAuth applications in GitLab are available instance-wide, regardless of whether they are instance-owned, user-owned, or group-owned. With the introduction of Organizations, we need to:

1. Enable organization-scoped OAuth applications for better security and tenant isolation
2. Maintain backward compatibility with existing OAuth workflows
3. Support future architectural changes including Cells and Authentication architecture improvements

## Current State

### Existing OAuth Application Scopes

- **Instance-owned applications**: Created by administrators, available to all instance users
- **User-owned applications**: Created by individual users, available to all instance users
- **Group-owned applications**: Created within groups, available to all instance users

**Key limitation**: Despite different ownership models, all applications are globally accessible across the entire GitLab instance.

## Proposed Solution

### Organization-Scoped OAuth Applications

#### New Application Type: Organization-Owned

- **Scope**: Only accessible to users within the same organization
- **Management**: Created and managed by organization owners
- **Authentication**: Users can only authenticate if they belong to the same organization as the application

#### Backward Compatibility for Default Organization

- Existing instance-owned applications become default Organization-owned applications.
- Users from any organization can authenticate with applications in the default organization
- This preserves existing behavior for current GitLab instances and integrations.

Note: In the future there may be restrictions introduced that no longer allow organization users to directly authenticate with default organization applications. However, Organization Connect may make this possible with OAuth/OIDC, at the discretion of organization owners.

### Access Control Matrix

| Application Type                            | Created In    | Accessible By                       |
|---------------------------------------------|---------------|-------------------------------------|
| Instance-owned (becomes Organization-owned) | Default org   | All users (any organization)        |
| Group-owned                                 | Default org   | All users (any organization)        |
| User-owned                                  | Default org   | All users (any organization)        |
| Organization-owned                          | Specific org  | Users within same organization only |
| Group-owned                                 | Specific org  | Users within same organization only |
| User-owned                                  | Specific org  | Users within same organization only |
