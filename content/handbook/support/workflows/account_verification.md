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

If the user has questions about the email, phone, or credit card verification GitLab is requiring, please refer to the [Internal Handbook for the workflow](https://internal.gitlab.com/workflows/phone-number-verification) to follow.

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

Most SaaS Account categories have [automations](../readiness/operations/docs/zendesk/automations.md) or [triggers](../readiness/operations/docs/zendesk/triggers.md).

#### Account verification matrix

The table below provides a summary of the available verification options based on the owner and user type:

| Requester | Target | Challenges | Owner vouch | Notes |
| --- | --- | --- | --- | --- |
| Enterprise Owner | Own account | Owner passes challenges on own account | Owner vouch (if required) must be provided by a different owner | If no other owner is available for vouch, see [internal handbook](https://internal.gitlab.com) for other challenges. |
| Enterprise Owner | Member of paid group or intent to be added | Owner or target user passes challenges on their own account | Owner vouch can be from requesting owner |  Multiple enterprise users may be handled per ticket. Target user does not have to be CC'd on ticket. |
| Owner | Non-enterprise user | Target user passes challenges on own account | Owner can vouch | One user per ticket. Communication is direct from the target user who must be CC'd on ticket.  |
| Paid User | Own account | User passes challenges on own account | Owner can vouch |  |
| Paid User | Other member of same paid group | Target user passes challenges on own account |  | Communication is direct from the target user who must be CC'd on ticket. |
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

1. If the user is unable to pass the risk factor but we have not provided all the applicable challenges, you may offer further challenges. This is true for all users, including owners.
   - Most commonly, an `Owner in the top level namespace` (with a valid subscription) vouch is requested. Use the `Support::SaaS::Gitlab.com::2FA::2FA ask owner vouch` [macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Ask%20owner%20vouch.md?ref_type=heads). See the [Verifying an Owner Vouch section](#authenticating-an-owner-vouch) for more information. The originating email of this request should match a verified email of the Owner's account. If the user is an Owner, vouch must be from a different Owner.
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

<<<<<<< content/handbook/support/workflows/account_verification.md
=======
### Step 4a: User Successfully Proves Account Ownership

This section is typically done by the peer reviewer. If needed, the peer reviewer (or approving manager) may leave an approval note, in which case the original reviewer will perform the actions.

1. For situations other than 2FA, please see [Account Changes workflow]({{< ref "account_changes.md" >}}).
1. For disabling 2FA: If you agree with the decision, sign into your admin account and locate the username in the users table or by going to `https://gitlab.com/admin/users/usernamegoeshere`
      1. Under the account tab, click `Edit`, add an [Admin Note]({{< ref "admin_note" >}}), and save.
      1. On the account tab, click on `Disable 2FA`.
      1. Use the `Support::SaaS::Gitlab.com2FA::2FA Removal Verification - Successful` [macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Removal%20Verification%20-%20Successful.md?ref_type=heads).

### Step 4b: User Fails to Prove Account Ownership

> **Note**: Do *not* provide hints to answers, or let the user know which challenges they got right or wrong. That is how social engineering works!

1. If the user is unable to pass the risk factor but we have not provided all the applicable challenges, you may offer further challenges. This is true for all users, including owners.
   - Most commonly, an `Owner in the top level namespace` (with a valid subscription) vouch is requested. Use the `Support::SaaS::Gitlab.com::2FA::2FA ask owner vouch` [macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Ask%20owner%20vouch.md?ref_type=heads). See the [Verifying an Owner Vouch section](#authenticating-an-owner-vouch) for more information. The originating email of this request should match a verified email of the Owner's account. If the user is an Owner, vouch must be from a different Owner.
   - For large organizations, please check the Zendesk organization notes to see if they're using the [large customers](#large-customers) workflow before offering the owner vouch challenge.
   - Some challenges can be answered with the help of their colleagues. Use the `Support::SaaS::Gitlab.com::2FA::2FA Removal Verification - GitLab.com - Failed - Ask colleagues for help` [macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Removal%20Verification%20-%20GitLab.com%20-%20Failed%20-%20Ask%20colleagues%20for%20help.md?ref_type=heads) to let them know which challenges they can try to work with their colleagues to answer.
   - When we receive a subsequent response, go back to [evaluating the challenges](#step-3-evaluating-challenge-answers) to see if they now pass.
1. If the user is unable to pass the available challenges:
   1. Inform them that without verification we will not be able to take any action on the account. For 2FA, use the `Support::SaaS::Gitlab.com::2FA::2FA Removal Verification - GitLab.com - Failed - Final Response` [macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Removal%20Verification%20-%20GitLab.com%20-%20Failed%20-%20Final%20Response.md?ref_type=heads).
   1. Mark the ticket as "Solved".

## Large Customers

For customers who are large enough to have an account management project, a different workflow can be configured for them that will allow Support to more easily disable 2FA for any of their users that require it. Before this process can be used, a GitLab team member from either Customer Success or Sales must perform a few setup steps (described below). If a customer requests this workflow, please refer them to either of those individuals.

### Setup (for CS & Sales)

The steps to follow depend on whether or not the customer has a shared Slack channel with us. Either the customer's Customer Success Manager (CS) or Account Manager (Sales) is responsible for performing this setup. Please proceed to [Shared Slack Channel](#method-1-shared-slack-channel) if they do or [No Shared Slack Channel](#method-2-no-shared-slack-channel) if they don't.

#### Method 1: Shared Slack Channel

1. Find out which users within the customer's organization are the ones that will be authorizing GitLab Support to disable 2FA on their users accounts. Obtain **both** the Slack handle and GitLab username of these users.
1. Create a file called `2FA Verification.md` inside of the `.gitlab/issue_templates` directory of the customer's [Account Management](https://gitlab.com/gitlab-com/account-management) project. If that directory does not exist, create it as well.
1. Populate the `2FA Verification.md` file with the template below, taking care to replace the following variables from it with your specific customer's information:
   - `CUSTOMER_SLACK_CHANNEL` - The name of the shared Slack channel that the customer's organization has with us.
   - `SLACK_USERNAME` - The Slack handle of a user that is authorized to allow GitLab Support to disable 2FA for the customer's user accounts.
   - `GITLAB_USERNAME` - The GitLab username of a user that is authorized to allow GitLab Support to disable 2FA for the customer's user accounts.

     <details>
      <summary markdown="span">2FA Verification Template</summary>

       A user in your organization is requesting to have [GitLab two-factor authentication](https://docs.gitlab.com/ee/user/profile/account/two_factor_authentication.html) removed from their account. Please review and complete the highlighted sections below.

      **Support Engineer Instructions**
       - Ping the customer's organization owners in CUSTOMER_SLACK_CHANNEL using the [Notify Customer - Slack](/handbook/support/workflows/account_verification#2-contact-through-slack-skip-if-no-shared-slack-channel) template. For this organization the owners are SLACK_USERNAME, SLACK_USERNAME, and SLACK_USERNAME.
       - Fill out the `Request Details` section below.

      **Request Details**
       - User Requesting Reset: USERS_GITLAB_USERNAME
       - Support Ticket: TICKET_NUMBER

      **Customer Instructions**
       - Review the request and get in contact with the user requesting the reset to verify its authenticity.
       - Comment on this issue indicating your approval.
       - Unassign yourself and any others from this issue.
       - Assign to the Support Engineer who opened this issue.

       /assign GITLAB_USERNAME GITLAB_USERNAME GITLAB_USERNAME, /label ~"2FA Reset" ~"Awaiting confirmation"

1. Create a [Support Super form](https://support-super-form-gitlab-com-support-support-op-651f22e90ce6d7.gitlab.io/) submission
   - For "What is this request concerning?", select `Modifications to a Zendesk Global Organization`
   - For "What kind of modification are you looking to make?", select `Add 2FA exemption for large customers`
   - Fill out the other fields with the correct and relevant information it asks for

#### Method 2: No Shared Slack Channel

1. Find out which users within the customer's organization are the ones that will be authorizing GitLab Support to disable 2FA on their users accounts. Obtain the GitLab username of these users.
1. Create a file called `2FA Verification.md` inside of the `.gitlab/issue_templates` directory of the customer's [Account Management](https://gitlab.com/gitlab-com/account-management) project. If that directory does not exist, create it as well.
1. Populate the `2FA Verification.md` file with the template below, taking care to replace the following variables from it with your specific customer's information:
   - `GITLAB_USERNAME` - The GitLab username of a user that is authorized to allow GitLab Support to disable 2FA for the customer's user accounts.

     <details>
      <summary markdown="span">2FA Verification Template</summary>

       A user in your organization is requesting to have [GitLab two-factor authentication](https://docs.gitlab.com/ee/user/profile/account/two_factor_authentication.html) removed from their account. Please review and complete the highlighted sections below.

       **Support Engineer Instructions**
       - Fill out the `Request Details` section below.

       **Request Details**
       - User Requesting Reset: USERS_GITLAB_USERNAME
       -Support Ticket: TICKET_NUMBER

       **Customer Instructions***
       - Review the request and get in contact with the user requesting the reset to verify its authenticity.
       - Comment on this issue indicating your approval.
       - Unassign yourself and any others from this issue.
       - Assign to the Support Engineer who opened this issue.

       /assign GITLAB_USERNAME GITLAB_USERNAME GITLAB_USERNAME, /label ~"2FA Reset" ~"Awaiting confirmation"

1. Create a [Support Super form](https://support-super-form-gitlab-com-support-support-op-651f22e90ce6d7.gitlab.io/) submission
   - For "What is this request concerning?", select `Modifications to a Zendesk Global Organization`
   - For "What kind of modification are you looking to make?", select `Add 2FA exemption for large customers`
   - Fill out the other fields with the correct and relevant information it asks for

### Usage (for GitLab Support)

If a 2FA ticket is opened by an organization that has had this workflow configured for them, perform the following steps to process the request depending on whether or not the customer has a shared Slack channel with us.

>**Note:** 2FA removal for the user is approved by the Customer via the 2FA Verification template. This means the Customer will confirm with the User having 2FA removed and not support.

#### 1. Create Issue

1. Open a new issue in the issue tracker of the customer's account verification project using the `2FA Verification` template and follow all instructions within it. A link to this template should be in the notes for the organization in Zendesk.

#### 2. Contact Through Slack (skip if no shared Slack channel)

1. Within the customer's shared Slack channel with us, use the template below to alert them to the fact that a new 2FA disable request exists in their account management issue tracker. Be sure to replace the following variables:
   - `SLACK_USERNAME` - The Slack handle of a user that is authorized to allow GitLab Support to disable 2FA for the customer's user accounts. If there are more than one, add them as well.
   - `ISSUE_LINK` - The URL of the 2FA reset issue created on the shared project

     <details>
       <summary markdown="span">Notify Customer - Slack</summary>

       <p>Hi `SLACK_USERNAME` - we've received a request from one of your users to disable 2FA on their account.

       <p>Could you vouch for them by following the steps in this issue: `ISSUE_LINK`?

       <p>Once you've done that, please let me know. If you don't get to this within 24 hours, we'll use our standard account verification procedures to determine if they're eligible for a 2FA reset.

>**Note:** If the customer has created an issue using the `2FA Verification` template themselves and sent us a Zendesk ticket with a link to it, skip this step.

#### 3. Wait For Authorization

Wait for the customer to comment on the issue and approve the request to disable 2FA.

As stressed in the Slack notification template, we will wait for the customer's answer for 24 hours. If no response is received by then, regular 2FA verification will take place via the [challenges workflow](#step-2-sending-challenges).

#### 4. Disable 2FA

Once the customer has approved the request, disable 2FA on the user's account, add an [Admin Note]({{< ref "admin_note" >}}) on the user's account, and then close both the support ticket and issue.

Peer review is **not** required. You may make the change yourself.

## Account Ownership Changes

This section has been [moved to the Account Changes workflow](../workflows/account_changes.md#account-ownership-changes).
