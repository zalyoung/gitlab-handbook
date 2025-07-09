---
owning-stage: "~devops::tenant scale"
title: 'Organizations ADR 002: Enterprise Users'
---

## Context

[Enterprise Users](https://docs.gitlab.com/user/enterprise_user/) is a Top-level Group feature that shares many of the same objectives as [Organizations](../_index.md).

The Enterprise Users feature operates within Top-level Groups which are being
replaced by Organizations.

## Decision

Broadly, Enterprise Users will be superseded by Organizations.

Enterprise Users will need to remain available for the Default Organization
until:

- Organizations is a viable alternative to Enterprise Users.
- An automated migration path is in place for Enterprise Users.

The Enterprise User features described in the documentation can be ported in the following ways:

Claiming users
: Claiming is longer applicable and will be replaced by Organization membership.
: The "managing group" concept will be replaced with a managing Organization.

Domain verification
: There is no plan for domain verification within Organizations yet.
: There may need to be a similar process at Organization level to enforce
domain ownership across a Cell cluster.

Disable two-factor authentication
: Becomes an Organization setting.

Enable the extension marketplace for the Web IDE and workspaces
: Becomes an Organization setting.

Prevent enterprise users from creating groups and projects outside the corporate group
: Exists inherently through Organization Isolation.

Separate to this ADR we will need to consider multiple aspects of prevention:

- Prevent user going into other Organizations
- What to do with existing data when disabling multi-organization option?

Bypass email confirmation for provisioned users
: This feature will be ported to Organization level.

Get users’ email addresses
: This will be available in the organization members UI.

Remove enterprise management features from an account
: The Organization Owners will have total control of their User accounts.

Disable authentication methods
: Becomes an Organization setting

## Consequences

- Enteprise Users will continue to be supported.
- A migration path to port Enterprise Users to Organizations will be created.
- Enterprise Users may be deprecated in the future when Organizations is a
viable alternative.

## Alternative

We can continue with Enterprise Users indefinitely but this leads to a poor and
confusing product experience.
