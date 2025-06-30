---
title: Enterprise Users
category: GitLab.com
subcategory: Enterprise Users
description: "Working on tickets with Enterprise Users"
---

## Overview

Enterprise Users are GitLab.com users whose accounts are administered by an organization that has verified their email domain and purchased a GitLab subscription. To identify an Enterprise user, see the [Identifying Enterprise Users](#identifying-enterprise-users) section below.

**Key characteristic**: Enterprise User accounts are owned by the organization, not the individual user. This fundamentally changes how Support should handle account-related requests.

## When to use this workflow

Use this workflow when:

- A ticket involves a user with an Enterprise badge
- A user mentions they cannot perform account actions due to "enterprise user" restrictions  
- A Group Owner requests changes on behalf of an Enterprise User
- A ticket references domain verification or enterprise user management

## Identifying Enterprise Users

Enterprise Users can be identified by:

1. **Enterprise badge** next to their username in group member lists
2. **API verification**: Use the [Group Enterprise Users API](https://docs.gitlab.com/api/group_enterprise_users/) 
3. **User profile**: Enterprise Users may have restricted account modification capabilities
4. **Error messages**: Users may report receiving "enterprise user" related error messages when trying to modify their accounts

## Key Principles

### 🚨 **Critical Rule: Group Owner Involvement Required**

**Unless the request comes directly from a Group Owner, ensure a Group Owner is involved in any Enterprise User account modifications.**

### Account Ownership

- Enterprise User accounts belong to the **organization**, not the individual
- Most account management functions should be performed by Group Owners through the GitLab interface
- Support intervention should be minimal and require proper authorization

## Restricted Actions for Enterprise Users

The following account workflows are **restricted** for Enterprise Users and should generally be directed to Group Owners:

- [2FA Removal](./2fa-removal.md)
- [Account Ownership Verification](./account_verification.md) (modified process - see below)
- [Confirmation Emails](./confirmation_emails.md)
- [Lost Email Account](./lost_emails.md)
- [Making Changes and Taking Actions on a user's behalf](./account_changes.md)
- [Remove Validation](./remove_validation.md)

### Exception: Email Address Changes

**Email address changes are the primary exception** - only GitLab Support can change an Enterprise User's email address to a non-verified domain, which releases them from enterprise management.

### Exception: Account deletion Requests

Until feature request [#520825](https://gitlab.com/gitlab-org/gitlab/-/issues/520825) is implemented, customers may contact GitLab Support to action on account deletions for their enterprise users.

## Common Scenarios and Workflows

### Scenario 1: Enterprise User Requests Account Changes Directly

**When**: An Enterprise User contacts Support directly asking for account modifications.

**Process**:

1. **Identify** the user as an Enterprise User
2. **Explain** that their account is managed by their organization
3. **Provide** the Group Owner contact information (if available)
4. **Direct** them to contact their Group Owner for assistance
5. **Reference** the [Enterprise User documentation](https://docs.gitlab.com/user/enterprise_user/#manage-enterprise-users)

**Template Response**:

```text
Hi [User],

Thank you for contacting GitLab Support. I can see that your account is an Enterprise User, which means it's administered by your organization.

For account-related changes, please contact your Group Owner at [organization] who can assist you with:
- [List relevant capabilities]

You can find more information about Enterprise User account management in our documentation: https://docs.gitlab.com/user/enterprise_user/#manage-enterprise-users

If your Group Owner requires Support assistance, they're welcome to contact us directly.

Best regards,
[Support Engineer]
```

### Scenario 2: Group Owner Requests Changes for Enterprise User

**When**: A Group Owner contacts Support requesting account changes for their Enterprise Users.

**Process**:

1. **Verify** the requester is a Group Owner using [Account Ownership Verification](./account_verification.md)
2. **Confirm** the target user is an Enterprise User in their organization
3. **Assess** if the request can be handled by the Group Owner directly
4. **Proceed** with the request if Support intervention is required
5. **Document** the Group Owner authorization in the ticket

### Scenario 3: Email Address Change Request

**When**: Request to change an Enterprise User's email address to a non-verified domain.

**Process**:

1. **Verify** requester identity (Enterprise User or Group Owner)
2. **If from Enterprise User directly**:
   - Explain this will release them from enterprise management
   - Require Group Owner approval before proceeding
   - Wait for Group Owner confirmation
3. **If from Group Owner**:
   - Verify Group Owner identity
   - Proceed with email change
4. **Process** the email change (this releases the user from enterprise management)
5. **Confirm** completion with both parties

⚠️ **Important**: Changing an Enterprise User's email to a non-verified domain automatically releases them from enterprise management.

### Scenario 4: Account Release Request

**When**: Request to release an Enterprise User from enterprise management.

**Process**:

1. **Determine** if request comes from Enterprise User or Group Owner
2. **If from Enterprise User**:
   - Require Group Owner approval
   - Do not proceed without explicit Group Owner consent
3. **If from Group Owner**:
   - Verify Group Owner identity
   - Process the release via email address change to non-verified domain
4. **Document** the release reason and authorization

### Scenario 5: Emergency Scenarios

**When**: Urgent account access issues affecting Enterprise Users.

**Process**:

1. **Assess** the emergency nature and business impact
2. **Attempt** to contact the Group Owner immediately
3. **Engage** Customer Success team for assistance
4. **Do not bypass** Group Owner approval without Customer Success involvement
5. **Document** the emergency justification thoroughly

**Escalation Path**: Support Manager → Customer Success → Group Owner

### Scenario 6: 2FA Issues for Enterprise Users

**When**: Enterprise User reports 2FA problems and cannot access their account.

**Process**:

1. **Direct** the user to their Group Owner first
2. **Inform** that Group Owners can reset 2FA for Enterprise Users
3. **If Group Owner contacts Support**:
   - Verify Group Owner identity
   - Assist with 2FA reset if needed
4. **Reference** [2FA troubleshooting options](https://docs.gitlab.com/user/profile/account/two_factor_authentication_troubleshooting/#recovery-options-and-2fa-reset)

## Verification Requirements

### For Enterprise Users

- Use standard [Account Ownership Verification](./account_verification.md) process
- Additional requirement: Verify their enterprise status and associated organization

### For Group Owners

- Use standard [Account Ownership Verification](./account_verification.md) process  
- Verify their Group Owner role in the relevant organization
- Confirm they have authority over the specific Enterprise User(s)

## Decision Tree

```text
Enterprise User ticket received
│
├── Request from Enterprise User directly?
│   ├── Yes → Direct to Group Owner (except email changes with Group Owner approval)
│   └── No → Continue
│
├── Request from Group Owner?
│   ├── Yes → Verify Group Owner → Process request
│   └── No → Determine requester relationship
│
├── Emergency situation?
│   ├── Yes → Contact Group Owner + Customer Success
│   └── No → Follow standard process
│
└── Email change to non-verified domain?
    ├── Yes → Requires Group Owner approval → Releases enterprise management
    └── No → Direct to Group Owner for standard management
```

## Escalation Guidelines

### When to escalate

- Group Owner cannot be reached in urgent situations
- Conflicting requests between Enterprise User and Group Owner  
- Complex organizational changes affecting multiple Enterprise Users
- Legal or compliance concerns
- Requests that may impact business relationships

### Escalation path

1. **Support Manager**
2. **Customer Success Manager** (for business relationship impact)
3. **Legal/Security teams** (for compliance issues)

## References and Resources

- [Enterprise Users Documentation](https://docs.gitlab.com/user/enterprise_user/)
- [Group Enterprise Users API](https://docs.gitlab.com/api/group_enterprise_users/)
- [Managing Enterprise Users](https://docs.gitlab.com/user/enterprise_user/#manage-enterprise-users)
- [Account Ownership Verification](./account_verification.md)
- [Verified Domains for Groups](https://docs.gitlab.com/user/enterprise_user/#verified-domains-for-groups)

## Key Takeaways

1. **Enterprise User accounts are owned by organizations, not individuals**
2. **Group Owner involvement is required for most account changes**  
3. **Email changes to non-verified domains release enterprise management**
4. **When in doubt, involve the Group Owner**
5. **Emergency scenarios still require proper authorization**
6. **Document all Group Owner approvals thoroughly**
