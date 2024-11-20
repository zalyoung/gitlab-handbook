---
title: Account Ownership Verification
category: GitLab.com
subcategory: Accounts
description: "Workflow detailing how and when to verify account ownership including disable 2FA"
---

## Overview

This workflow covers how a user can provide account verification. It should be used for any [account changes]({{< ref "account_changes.md" >}}).

Account actions can only be completed if the [workflow](#workflow) below is successful.

## Related topics

### User Account Verification

As of Aug 16, 2023, GitLab.com now requires that users without 2FA enabled verify their email address when a login attempt meets certain high-risk criteria. Review the [blog post](https://about.gitlab.com/blog/2023/08/08/gitlab-account-security/) announcing this change. If a user contacts support with questions, use the [`Support::SaaS::Gitlab.com::Abuse::Email Address Verification`](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/Abuse/Email%20Address%20Verification.md?ref_type=heads) macro.

If the user has questions about the email, phone, or credit card verification GitLab is requiring, please refer to the [Internal Handbook for the workflow](https://internal.gitlab.com/handbook/support/workflows/phone-number-verification) to follow.

### GitLab Team Members

If the user is a GitLab team member, have them [contact IT Ops](/handbook/it/end-user-services/_index.md).

## 2FA removal within GitLab

See the [2FA Removal workflow](content/handbook/support/workflows/2fa-removal.md) for instructions to process 2FA removal requests.

## Workflow

The workflow applies to all cases where account verification is required, aside from 2FA removals.

### Keeping the Ticket Simple and Accurate

Because an ownership-verification ticket is a matter of record, the ticket must be simple, accurate, and tightly focused on the access issue.
Do not allow the customer to bring up unrelated topics.

### Step 0: Ticket metadata

Ensure that the ticket form, category, subcategory, and topic are accurate.

Most SaaS Account categories have [automations](/handbook/support/readiness/operations/docs/zendesk/automations.md) or [triggers](/handbook/support/readiness/operations/docs/zendesk/triggers.md).

#### Account verification matrix

The table below provides a summary of the available verification options based on the owner and user type:

| Requester | Target | Challenges | Owner vouch | Notes |
| --- | --- | --- | --- | --- |
| Enterprise Owner | Own account | Owner passes challenges on own account | Owner vouch (if required) must be provided by a different owner | If no other owner is available for vouch, see [internal handbook](https://internal.gitlab.com/handbook/support) for other challenges. |
| Enterprise Owner | Member of paid group or intent to be added | Owner or target user passes challenges on their own account | Owner vouch can be from requesting owner |  Multiple enterprise users may be handled per ticket. Target user does not have to be CC'd on ticket. |
| Owner | Non-enterprise user | Target user passes challenges on own account | Owner can vouch | One user per ticket. Communication is direct from the target user who must be CC'd on ticket.  |
| Paid User | Own account | User passes challenges on own account | Owner can vouch |  |
| Paid User | Other member of same paid group | Target user passes challenges on own account |  | Communication is direct from the target user who must be CC'd on ticket. |
| Free User | Non-member of group with intent to be added | Not allowed - request must come from group owner | Owner vouch required |  |

See the [Enterprise User section]({{< ref "gitlab-com_overview.md#enterprise-users" >}}) on how to identify if a user is an Enterprise User.

### Step 1: Sending Challenges

If you need a basis for a response where you send the challenges, use the [`Support::SaaS::Gitlab.com::2FA::2FA Challenges` macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Challenges.md?ref_type=heads).

### Step 2: Checking challenge answers

> **Note**: In case the user sends back very minimal information and it's clear it's not sufficient or the answers are vague, reply asking for more information immediately after their response. You can provide some additional guidance, such as "please provide the exact date and time of the commit, not just an approximate one".

1. To verify the challenge answers, use [chatops]({{< ref "chatops.md" >}}), the Zendesk GitLab User Lookup App or, for those who have admin access, check at `https://gitlab.com/admin/users/USERNAME`.
1. Use the ZenDesk GitLab Super App's 2FA Helper to determine the [risk factor](https://internal.gitlab.com/handbook/support/#risk-factors-for-account-ownership-verification) (GitLab internal) based on the user's answers. Data classification criteria and any notes are in the [Internal Handbook - Data Classification table](https://internal.gitlab.com/handbook/support/#data-classification) (GitLab internal), which is considered the source of truth. If you need to leave a comment manually (instead of through the app), use the [`Support::SaaS::Gitlab.com::2FA::2FA Internal Note` macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Internal%20Note.md?ref_type=heads) to put an internal note on the ticket.
   - Challenge answers must be evaluated against a paid namespace if the user is a member of any paid namespace. If the user is not a member of a paid namespace, refer to [Conditions for 2FA Reset Consideration](#conditions-when-account-is-used-to-access-customers-portal) for further guidance.

1. **If verification passed:** Request that your decision be peer-reviewed by another member of the team via Slack `#support_gitlab-com`. They will perform the steps in 3a
1. **If the verification failed**: Move to step 3b

### Step 3a: User successfully proves account ownership

This section is typically done by the peer reviewer. If needed, the peer reviewer (or approving manager) may leave an approval note, in which case the original reviewer will perform the actions.

1. If you agree with the decision, sign into your admin account and locate the username in the users table or by going to `https://gitlab.com/admin/users/usernamegoeshere`
      1. Please see [Account Changes workflow]({{< ref "account_changes.md" >}}).
      1. Under the account tab, click `Edit`, add an [Admin Note]({{< ref "admin_note" >}}), and save.

### Step 3b: User Fails to Prove Account Ownership

> **Note**: Do *not* provide hints to answers, or let the user know which challenges they got right or wrong. That is how social engineering works!

1. If the user is unable to pass the risk factor but we have not provided all the applicable challenges, you may offer further challenges. This is true for all users, including owners.
   - Most commonly, an `Owner in the top level namespace` (with a valid subscription) vouch is requested. Use the `Support::SaaS::Gitlab.com::2FA::2FA ask owner vouch` [macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Ask%20owner%20vouch.md?ref_type=heads). See the [Verifying an Owner Vouch section](#authenticating-an-owner-vouch) for more information. The originating email of this request should match a verified email of the Owner's account. If the user is an Owner, vouch must be from a different Owner.
   - For large organizations, please check the Zendesk organization notes to see if they're using the [large customers](#large-customers) workflow before offering the owner vouch challenge.
   - Some challenges can be answered with the help of their colleagues. Use the `Support::SaaS::Gitlab.com::2FA::2FA Removal Verification - GitLab.com - Failed - Ask colleagues for help` [macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Removal%20Verification%20-%20GitLab.com%20-%20Failed%20-%20Ask%20colleagues%20for%20help.md?ref_type=heads) to let them know which challenges they can try to work with their colleagues to answer.
   - When we receive a subsequent response, go back to [checking challenge answers](#step-2-checking-challenge-answers) to see if they now pass.
1. If the user is unable to pass the available challenges:
   1. Inform them that without verification we will not be able to take any action on the account.
   1. Mark the ticket as "Solved".

### Authenticating an Owner Vouch

In a paid namespace: If the user elects to have an Owner vouch for their request, apply the macro [`Support::SaaS::Gitlab.com::2FA::2FA ask owner vouch`](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Ask%20owner%20vouch.md?ref_type=heads). This will direct the requestor to have an Owner (top-level) create a Snippet with a Support-provided string. Once they have replied verifying they have done so:

1. Use your Admin or Auditor account to browse to the Snippet provided (e.g. `https://gitlab.com/-/snippets/2057341`)
   - Verify the text of the Snippet matches the string you specified
   - Verify that the author of the Snippet is an Owner and direct member of the top-level paid group
1. If the Owner passes, you may count this towards the account verification challenges.

Note: Due to this [bug](https://gitlab.com/gitlab-org/gitlab/-/issues/337939) some group owners are not able to create snippets. In that case use a [backup method](#backup-methods-for-authenticating-an-owner) instead.

### Backup methods for authenticating an owner

If a group owner is unable to create a snippet, you may use another method to verify their identity. It must be an action that has been specifically instructed by Support and identifiably unique to the situation. Some examples include having the owner:

- create an issue in a project they have access to with a specific piece of text that you provide.
- create a new project at a path that you provide.
- update their GitLab Status to a specific string.

### Twitter

If a user has a pre-listed Twitter account on their GitLab profile, this may be used as an additional factor for proving account ownership.

1. Invite the user to follow `@GLSupport2FA` in a reply to their ticket.
1. Log in to <https://twitter.com/> using the GLSupport2FA twitter account in the 1Password Vault.
   - If the login requires a 2FA code, log in to <https://mail.google.com> using the <techsupport@gitlab.com> gmail credentials. Note: If you are redirected to OKTA login, use the same gmail credentials to log in to OKTA.
1. Go to <https://twitter.com/GLSupport2FA/followers> and confirm the listed Twitter account is in the Followers list.
1. Go to the messages list and send them the following snippet:

<details>
 <summary markdown="span">Verification message to send</summary>

 <p>Greetings,</p>

 <p>We recently got a request to <remove the 2FA on | delete | change the primary email address> your GitLab.com account. Since you listed this account there, we're reaching out for confirmation. Please let us know if it was you who initiated this request.</p>

 <p>If you don't reply in the positive in 7 days we won't be able to count this towards your proof of account ownership.</p>

 <p>Thanks,<br>
GitLab Support</p>
</details>

If a reply is received within 7 days, account for it in the Risk Factor Worksheet and continue with the workflow. Otherwise, this can be counted as a failed challenge.

## Account Ownership Changes

This section has been [moved to the Account Changes workflow]({{< ref "account_changes.md#account-ownership-changes" >}}).
