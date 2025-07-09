---
owning-stage: "~devops::tenant scale"
title: 'Organizations ADR 003: Organization SAML'
---

## Context

Organizations is the new customer entry container for GitLab. This will take
over from the Top-Level Group on GitLab.com and Instance Level on Self Managed
and Dedicated.

We need to integrate Organizations directly with SAML and other SSO mechanisms. SAML is the
primary focus but other SSO methods share a lot of overlap.

We currently have SSO capability within the instance and Top-level Group.

The Default Organization on GitLab.com will remain indefinitely. We need to
support Top-level Group SSO for now with the possibility of deprecation after
Organizations is released.

The Self Managed and Dedicated instances will transition to Organizations. The
release pathway is less clear than GitLab.com but may operate on a different
schedule.

When a user is added to an Organization they receive an Organization role defined in the
`organization_users` table.

When a user is created through the Organization they will be owned by that
Organization and their `users.organization_id` will be defined accordingly.
table row will

## Decision

## Consequences

Authentication Architecture Changes
: Authentication model shifts from instance/group-level to organization-level SSO.

Migration and Transition Complexity
: Dual authentication system required during transition, maintaining both old group SSO and new organization SSO simultaneously.

Deployment Timeline Variations
: GitLab.com, Self Managed, and Dedicated will have different rollout schedules, creating feature parity gaps.

Legacy System Support Burden
: Indefinite maintenance of Default Organization and existing group SSO creates ongoing technical debt.

Customer Configuration Impact
: Existing customers must reconfigure SAML setups, requiring IT admin coordination and potential user workflow disruption.

Integration Scope Expansion
: Change will trigger similar restructuring for other SSO methods (OAuth, LDAP) due to shared authentication patterns.

## Alternatives


