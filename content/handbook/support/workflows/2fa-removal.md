---
title: 2FA Removal
category: GitLab.com
subcategory: Accounts
description: "Workflow detailing how we process 2FA removal requests"
---

## Overview

This workflow focuses on disabling [Two-factor Authentication](https://docs.gitlab.com/ee/user/profile/account/two_factor_authentication.html) (2FA) on a GitLab.com account. The general principles for authenticating a request are covered in our [account verification workflow](account_verification.html).

2FA removal and other account actions can only be completed if the [workflow](#workflows) below is successful.

## Related topics

### GitLab Team Members

If the user is a GitLab team member, have them [contact IT Ops](/handbook/it/end-user-services/_index.md).

## 2FA removal within GitLab

### Self Service 2FA removal

In most cases, users can disable 2FA themselves and regain access to their accounts using [one of the documented methods](https://docs.gitlab.com/ee/user/profile/account/two_factor_authentication.html#recovery-options).

> As of August 2020, [Support will not intervene for free users](https://about.gitlab.com/blog/2020/08/04/gitlab-support-no-longer-processing-mfa-resets-for-free-users/) if self-service methods do not work for them.

### Enterprise Owner 2FA removal for Enterprise users

A top-level group owner can [disable 2FA for any enterprise user](https://docs.gitlab.com/ee/user/enterprise_user/#disable-two-factor-authentication) who is also a group member. With the [rollout of the `enterprise_users_automatic_claim` feature flag](https://gitlab.com/gitlab-org/gitlab/-/issues/421407), users are automatically marked as an enterprise user if [a group has a verified domain](https://docs.gitlab.com/ee/user/enterprise_user/#verified-domains-for-groups), and the user's *primary* email matches a verified domain.

## Definitions

- **Account holder**: The person who uses the account day-to-day. The individual themselves may or may not be the account owner.
- **Enterprise owner**: One or more people who represent the business entity who purchased a paid plan with GitLab, hold Owner permissions in that paid namespace, and have a [verified domain](https://docs.gitlab.com/ee/user/enterprise_user/#verified-domains-for-groups).

## Conditions for SaaS users

A SaaS user must meet **one of** the following conditions to be eligible for a 2FA reset.

1. The user occupies a seat in a paid group on GitLab.com, or a top-level group owner intends to add the user to the paid group.
1. The user is an [Enterprise User](./gitlab-com_overview/#enterprise-users).
1. The user is the primary billing contact on a current invoice for a SaaS purchase.
1. A GitLab team member (account managers, CSMs, or others) collaborates with the holder of this account in an account management project.
1. The user account is required for SSO access to Customers Portal to manage a paid subscription - see: [Conditions for 2FA Reset when account is used to access Customers Portal](#conditions-when-account-is-used-to-access-customers-portal).

More succinctly: they're paid, they use the account to pay, or we use the account to communicate with them.

In many cases, a top-level group owner may submit a ticket on behalf of the user. See the [Account verification matrix](#account-verification-matrix) for more information.

### Account verification matrix

The table below provides a summary of the available verification options based on the owner and user type:

| Requester | Target | Challenges | Notes |
| --- | --- | --- | --- |
| Enterprise owner | Own account | Owner passes challenges on own account | If the requestor fails another Enterprise owner may raise a separate request on their behalf. If no other Enterprise owner is available, see [internal handbook](https://internal.gitlab.com/handbook/support) for other challenges. |
| Enterprise owner | Member of paid group or intent to be added | Enterprise owner meets base criteria and authenticates request |  Multiple enterprise users may be handled per ticket. Target user does not have to be CC'd on ticket. |
| Enterprise owner | Non-enterprise user | Invalid request type | Account holder must raise their own request and pass challenges|
| Account holder (Paid) | Own account | User passes challenges on own account |  |
| Account holder (Paid) | Other member of same paid group | Invalid request type - must be raised by an Enterprise owner | Communication is direct from the target user who must be CC'd on ticket. |
| Account holder (Free) | Non-member of group with intent to be added | Invalid request type - request must come from Enterprise owner |  |

To summarize: If a user cannot make use of self-serve methods (lost their account recovery codes and has no SSH key registered) there are two potential ways to validate the request and recover the account: having the account holder open the request, or by having an enterprise owner create the request on their behalf.

See the [Enterprise User section](t/handbook/support/workflows/gitlab-com_overview.md#enterprise-users") on how to identify if a user is an Enterprise User.

### Conditions when account is used to access Customers Portal

[Customers Portal](https://customers.gitlab.com) requires all customers to access through a [Linked GitLab Account](https://docs.gitlab.com/ee/subscriptions/customers_portal.html#link-a-gitlabcom-account).

The user is eligible and 2FA can be reset when **one** of following conditions are met:

1. The request is made by the primary billing contact on the latest invoice for a GitLab subscription.
1. The GitLab account is linked to the customers portal account for the primary billing contact on the latest invoice for a subscription purchase.

If an invoice can not be provided, suggest [sign in with legacy email/password](https://customers.gitlab.com/customers/sign_in?legacy=true), where an invoice can be downloaded.

## Keep the Ticket simple and accurate

Because 2FA removal tickets are a matter of record, the ticket must be simple, accurate, and tightly focused on the access issue.
Do not allow the customer to bring up unrelated topics.

## Disable 2FA with support intervention

Support intervention for 2FA removal after the above steps have been attempted is only possible for users with an *existing paid plan* when the ticket is created. For security purposes, Support will not process 2FA resets for users who are added to a paid subscription for the express purpose of having 2FA disabled on their account.

### Workflows

#### Request for 2FA removal initiated by the account holder

Requests initiated by the account holder have the opportunity to provide all information they have or know about the account when filling out the request form.

##### Step 0: Validation

Some initial validation steps will occur automatically:

- Email / Username match
- Group membership validation
- Group subscription validation

If any of these are inaccurate, the ticket will be closed.

##### Step 1: Checking challenge answers

> **Note**: In case the user sends back very minimal information and it's clear it's not sufficient or the answers are vague, reply asking for more information immediately after their response. You can provide some additional guidance, such as "please provide the exact date and time of the commit, not just an approximate one".

1. To verify the challenge answers use the Zendesk GitLab User Lookup App or, for those who have admin access, check at `https://gitlab.com/admin/users/USERNAME`.
1. Use the ZenDesk GitLab Super App's 2FA Helper to determine the [risk factor](https://internal.gitlab.com/handbook/support/#risk-factors-for-account-ownership-verification) (GitLab internal) based on the user's answers. Data classification criteria and any notes are in the [Internal Handbook - Data Classification table](https://internal.gitlab.com/handbook/support/#data-classification) (GitLab internal), which is considered the source of truth. If you need to leave a comment manually (instead of through the app), use the [`Support::SaaS::Gitlab.com::2FA::2FA Internal Note` macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Internal%20Note.md?ref_type=heads) to put an internal note on the ticket.
   - Challenge answers must be evaluated against a paid namespace if the user is a member of any paid namespace. If the user is not a member of a paid namespace, refer to [Conditions for 2FA Reset Consideration](#conditions-when-account-is-used-to-access-customers-portal) for further guidance.

1. **If verification passed:** Request that your decision be peer-reviewed by another member of the team via Slack `#support_gitlab-com`. They will perform the steps in 2a
1. **If the verification failed**: Move to step 2b

##### Step 2a: User successfully proves account ownership

This section is typically done by the peer reviewer. If needed, the peer reviewer (or approving manager) may leave an approval note, in which case the original reviewer will perform the actions.

1. If you agree with the decision, sign into your admin account and locate the username in the users table or by going to `https://gitlab.com/admin/users/usernamegoeshere`
      1. Under the account tab, click `Edit`, add an [Admin Note](/handbook/support/workflows/admin_note.md), and save.
      1. On the account tab, click on `Disable 2FA`.
      1. Use the `Support::SaaS::Gitlab.com::2FA::2FA Removal Verification - Successful` [macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Removal%20Verification%20-%20Successful.md?ref_type=heads).

##### Step 2b: User fails to prove account ownership

> **Note**: Do *not* provide hints to answers, or let the user know which challenges they got right or wrong. That is how social engineering works!

1. If the user is unable to pass the risk factor:
   1. Inform them that without verification we will not be able to remove 2FA, but they may request an Enterprise Owner create a request on their behalf (if they would qualify), use the `Support::SaaS::Gitlab.com::2FA::2FA Removal Verification - GitLab.com - Failed - Final Response` [macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Removal%20Verification%20-%20GitLab.com%20-%20Failed%20-%20Final%20Response.md?ref_type=heads).
   1. Mark the ticket as "Solved".

#### Request for 2FA removal initiated by an Enterprise owner

Requests initiated by an Enterprise owner should include the owner vouch snippet. Note that owners should answer the challenges in reference to their **own** account. Other answers are not acceptable.

##### Step 0: Validation

Some initial validation steps will occur automatically:

- Email / Username match
- Group membership validation
- Group subscription validation

If any of these are inaccurate, the ticket will be closed.

##### Step 1: Checking challenge answers

> **Note**: In case the user sends back very minimal information and it's clear it's not sufficient or the answers are vague, reply asking for more information immediately after their response. As an Enterprise owner, the ticket response generated by the form should also include the owner vouch snippet. If it does not, move to [step 2b](#step-2b-enterprise-owner-fails-to-prove-their-identity) below.

1. To verify the challenge answers, use [chatops](/handbook/support/workflows/chatops.md), the Zendesk GitLab User Lookup App or, for those who have admin access, check at `https://gitlab.com/admin/users/USERNAME`.
1. Use the ZenDesk GitLab Super App's 2FA Helper to determine the [risk factor](https://internal.gitlab.com/handbook/support/#risk-factors-for-account-ownership-verification) (GitLab internal) based on the user's answers. Data classification criteria and any notes are in the [Internal Handbook - Data Classification table](https://internal.gitlab.com/handbook/support/#data-classification) (GitLab internal), which is considered the source of truth. If you need to leave a comment manually (instead of through the app), use the [`Support::SaaS::Gitlab.com::2FA::2FA Internal Note` macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Internal%20Note.md?ref_type=heads) to put an internal note on the ticket.
   - Challenge answers must be evaluated against a paid namespace if the user is a member of any paid namespace. If the user is not a member of a paid namespace, refer to [Conditions for 2FA Reset Consideration](#conditions-when-account-is-used-to-access-customers-portal) for further guidance.

1. **If verification passed:** Request that your decision be peer-reviewed by another member of the team via Slack `#support_gitlab-com`. They will perform the steps in 2a
1. **If the verification failed**: Move to step 2b

##### Step 2a: Enterprise Owner successfully proves their identity

This section is typically done by the peer reviewer. If needed, the peer reviewer (or approving manager) may leave an approval note, in which case the original reviewer will perform the actions.

1. If you agree with the decision, sign into your admin account and locate the username in the users table or by going to `https://gitlab.com/admin/users/usernamegoeshere`
      1. Under the account tab, click `Edit`, add an [Admin Note](/handbook/support/workflows/admin_note.md), and save.
      1. On the account tab, click on `Disable 2FA`.
      1. Use the `Support::SaaS::Gitlab.com::2FA::2FA Removal Verification - Successful` [macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Removal%20Verification%20-%20Successful.md?ref_type=heads).

##### Step 2b: Enterprise Owner fails to prove their identity

> **Note**: Do *not* provide hints to answers, or let the user know which challenges they got right or wrong. That is how social engineering works!

1. If the user is unable to pass the risk factor:
   1. Send the additional challenges with the `Support::SaaS::GitLab.com::2FA::Additional 2FA Challenges` [macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/Additional%202FA%20Challenges.md?ref_type=heads).
   1. You may also leverage [Backup methods for authenticating an owner](#backup-methods-for-authenticating-an-owner).
1. If the user is still unable to pass the risk factor:
   1. Inform them that without verification we will not be able to remove 2FA, use the `Support::SaaS::Gitlab.com::2FA::2FA Removal Verification - GitLab.com - Failed - Final Response` [macro](https://gitlab.com/gitlab-com/support/zendesk-global/macros/-/blob/master/active/Support/SaaS/GitLab.com/2FA/2FA%20Removal%20Verification%20-%20GitLab.com%20-%20Failed%20-%20Final%20Response.md?ref_type=heads).
   1. Mark the ticket as "Solved".

##### Backup methods for authenticating an owner

If a group owner does not include the owner vouch, you may use another method to verify their identity. It must be an action that has been specifically instructed by Support and identifiably unique to the situation. Some examples include having the owner:

- create an issue in a project they have access to with a specific piece of text that you provide.
- create a new project at a path that you provide.

##### Twitter

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

## Large Customers

For customers who are large enough to have an account management project, a different workflow can be configured for them that will allow Support to more easily disable 2FA for any of their users that require it. Before this process can be used, a GitLab team member from either Customer Success or Sales must perform a few setup steps (described below). If a customer requests this workflow, please refer them to either of those individuals.

### Setup (for CS & Sales)

The steps to follow depend on whether or not the customer has a shared Slack channel with us. Either the customer's Customer Success Manager (CS) or Account Manager (Sales) is responsible for performing this setup. Please proceed to [Shared Slack Channel](#method-1-shared-slack-channel) if they do or [No Shared Slack Channel](#method-2-no-shared-slack-channel) if they don't.

#### Method 1: Shared Slack Channel

1. Find out which users within the customer's organization are the ones that will be authorizing GitLab Support to disable 2FA on their users accounts. Obtain **both** the Slack handle and GitLab username of these users.
