---
title: Account Ownership Verification
category: GitLab.com
subcategory: Accounts
description: "Workflow detailing how and when to verify account ownership including disable 2FA"
---

## Overview

This workflow covers how a user can provide account verification. It should be used for any [account changes](../workflows/account_changes.md).

Account actions can only be completed if the [workflow](#workflow) below is successful.

## Related topics

### User Account Verification

GitLab.com requires that users without 2FA enabled verify their email address when a login attempt meets certain high-risk criteria. For users requesting support when their email address is no longer valid and are unable to receive the email, please see the [Email account lost workflow](/handbook/support/workflows/lost_emails).

If the user has questions about the email, phone, or credit card verification GitLab is requiring, please refer to the [Internal Handbook for the workflow](https://internal.gitlab.com/handbook/support/workflows/phone-number-verification/) to follow.

### GitLab Team Members

If the user is a GitLab team member, have them [contact IT Ops](/handbook/it/end-user-services/_index.md).

## 2FA removal within GitLab

See the [2FA Removal workflow](../workflows/2fa-removal.md) for instructions to process 2FA removal requests.

## Workflow

The workflow applies to all cases where account verification is required, aside from 2FA removals.

### Keeping the Ticket Simple and Accurate

Because an ownership-verification ticket is a matter of record, the ticket must be simple, accurate, and tightly focused on the access issue.
Do not allow the customer to bring up unrelated topics.

### Step 0: Ticket metadata

Ensure that the ticket form, category, subcategory, and topic are accurate.

Most SaaS Account categories have automations or triggers.

#### Account verification matrix

The table below provides a summary of the available verification options based on the owner and user type:

| Requester | Target | Challenges | Support PIN | Notes |
| --- | --- | --- | --- | --- |
| Enterprise Owner | Own account | Owner passes challenges on own account | Support PIN must be provided by a different owner | If no other owner is available for vouch, see [internal handbook](https://internal.gitlab.com) for other challenges. |
| Enterprise Owner | Member of paid group or intent to be added or Enterprise User | Owner or target user passes challenges on their own account | Support PIN is from requesting owner |  Multiple enterprise users may be handled per ticket. Target user does not have to be CC'd on ticket. |
| Owner | Non-enterprise user | Target user passes challenges on own account | Support PIN from owner | One user per ticket. Communication is direct from the target user who must be CC'd on ticket.  |
| Paid User | Own account | User passes challenges on own account | N/A | If owner is needed, owner must open a new ticket. |
| Paid User | Other member of same paid group | Target user passes challenges on own account | N/A | If owner is needed, owner must open a new ticket.|
| Free User | Non-member of group with intent to be added | Not allowed - request must come from group owner | Owner vouch required |  |

See the [Enterprise User section](../workflows/gitlab-com_overview.md#enterprise-users) on how to identify if a user is an Enterprise User.

### Step 1: Sending Challenges

If you need a basis for a response where you send the challenges, use the [`Support::SaaS::Gitlab.com::2FA::2FA Challenges` macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Challenges.md?ref_type=heads).

### Step 2: Checking challenge answers

> **Note**: In case the user sends back very minimal information and it's clear it's not sufficient or the answers are vague, reply asking for more information immediately after their response. You can provide some additional guidance, such as "please provide the exact date and time of the commit, not just an approximate one".

1. To verify the challenge answers, the Zendesk GitLab User Lookup App or, for those who have admin access, check at `https://gitlab.com/admin/users/USERNAME`.
1. Use the ZenDesk GitLab Super App's 2FA Helper to determine the [risk factor](https://internal.gitlab.com/handbook/support/#risk-factors-for-account-ownership-verification) (GitLab internal) based on the user's answers. Data classification criteria and any notes are in the [Internal Handbook - Data Classification table](https://internal.gitlab.com/handbook/support/#data-classification) (GitLab internal), which is considered the source of truth. If you need to leave a comment manually (instead of through the app), use the [`Support::SaaS::Gitlab.com::2FA::2FA Internal Note` macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Internal%20Note.md?ref_type=heads) to put an internal note on the ticket.
   - Challenge answers must be evaluated against a paid namespace if the user is a member of any paid namespace. If the user is not a member of a paid namespace, refer to [Conditions for 2FA Reset Consideration](./2fa-removal.md#conditions-when-account-is-used-to-access-customers-portal) for further guidance.

1. **If verification passed:** Request that your decision be peer-reviewed by another member of the team via Slack `#support_gitlab-com`. They will perform the steps in 3a
1. **If the verification failed**: Move to step 3b

### Step 3a: User successfully proves account ownership

This section is typically done by the peer reviewer. If needed, the peer reviewer (or approving manager) may leave an approval note, in which case the original reviewer will perform the actions.

1. If you agree with the decision, sign into your admin account and locate the username in the users table or by going to `https://gitlab.com/admin/users/usernamegoeshere`
      1. Please see [Account Changes workflow](../workflows/account_changes.md).
      1. Under the account tab, click `Edit`, add an [Admin Note](../workflows/admin_note.md), and save.

### Step 3b: User Fails to Prove Account Ownership

> **Note**: Do *not* provide hints to answers, or let the user know which challenges they got right or wrong. That is how social engineering works!

1. If the user is unable to pass the risk factor:
   1. Inform them that we were not able to verify their identity, but they may request an Enterprise Owner create a request on their behalf (if they would qualify), use the `Support::SaaS::Gitlab.com::2FA::2FA Removal Verification - GitLab.com - Failed - Final Response` [macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Removal%20Verification%20-%20GitLab.com%20-%20Failed%20-%20Final%20Response.md?ref_type=heads).
   1. Mark the ticket as "Solved".

## Account Ownership Changes

This section has been [moved to the Account Changes workflow](../workflows/account_changes.md#account-ownership-changes).
