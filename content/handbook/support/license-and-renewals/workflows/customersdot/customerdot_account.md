---
title: CustomerDot Account Related Problems
category: CustomersDot
description: Using the customer console for internal requests is only for special cases where the existing tools won't allow us to complete the task at hand.
---

## Overview

Sometimes customers have trouble accessing their account.
CustomersDot email and password log in has been deprecated.
Customers can instead [follow these steps](https://docs.gitlab.com/subscriptions/customers_portal/#sign-in-to-customers-portal) to log in using a one-time sign-in link.

### 1. Customer cannot sign in even after password reset

This could be because the password reset email was requested from [https://**gitlab.com**/users/password/new](https://gitlab.com/users/password/new).
We can confirm this by searching through the mailgun log. To locate the password reset email:

1. Log in to Mailgun using your account
1. On the left panel, expand `Sending` and go to `Logs`
1. On the top left, click the `Domain` dropdown and choose `mg.gitlab.com` domain to confirm that the password reset email was requested on GitLab.com.
1. If the customer is unable to log in using their GitLab.com account, request them to log in using a **one-time sign-in link**.

### 2. The CustomersDot account has not been confirmed

When the account is not confirmed, the customer cannot log in. To view whether an account is confirmed:

1. Sign into CustomerDot with your admin account
1. Find the customer account
1. Click on the `i` icon on the customer account or `Show` if you're already viewing the account
1. The confirmation is shown in `Confirmed at` field
1. If the customer has not confirmed their email/account, we can resend the confirmation email using [this form](https://customers.gitlab.com/customers/confirmation/new) and get back to the customer.

### 3. The customer is trying to sign in using another email address

Situations may arise where a customer has used a different email address for their [customers portal](https://customers.gitlab.com/customers/sign_in) account and their GitLab.com account. It may also be possible that a customer has signed up more than once using different email addresses (e.g. `firstname_lastname@organization.com` and `firstname.lastname@organization.com`). In scenarios such as these, please explain the differences to the customer, and clarify which email address they used for their GitLab subscription.

### 4. Unlinked CustomersDot account for GitLab purchases

Let's say a Customer X has an existing Customers Portal account with their email <customerX@example.com> either because:

- They created an account manually on [Customers Portal](https://customers.gitlab.com/customers/sign_in)
- Or they previously purchased some units if compute

Customer X will get this error if they log in or create an account in GitLab with their email <customerX@example.com> and attempt to purchase or renew a paid plan or additional storage, or try to purchase more compute minutes from GitLab.
The error is reported because *they did not link their Customers Portal account to a GitLab account before making the purchase.*

🔧 To fix the problem, Customer X needs to log in to their [Customers Portal](https://customers.gitlab.com/customers/sign_in) account and [link their GitLab account](https://docs.gitlab.com/subscriptions/customers_portal/#change-the-linked-account).

### 5. Unlinked CustomersDot account for purchases via Sales

Let's say a Customer Y purchases a subscription through Sales. Their signed Order Form has the **Sold To** contact's email as <customerY@example.com>.
Once the Quote is processed, Zuora's [callout service](https://gitlab.com/gitlab-org/customers-gitlab-com/-/blob/main/doc/zuora/zuora_callouts.md#purpose)
triggers an account creation on Customers Portal. This service uses the `Sold To` contact's details to create the account.

For various reasons, the created Customers Portal account is not linked to a GitLab account.
For example:

- The subscription has not yet been applied to a group.
- Support used [Mechanizer's force associate workaround](/handbook/support/license-and-renewals/workflows/customersdot/mechanizer#force-associate) to bypass the need to have a linked GitLab account to apply a subscription and the customer never linked their GitLab account.

Customer Y will get this error if they try to log in or create an account in GitLab with their email <customerY@example.com> then attempt to purchase or renew a paid plan or additional storage, or try to purchase more compute minutes from GitLab.
The error is reported because *they did not link their Customers Portal account to a GitLab account before making the purchase.*

🔧 To fix the problem, Customer Y needs to log in to their [Customers Portal](https://customers.gitlab.com/customers/sign_in) account and [link their GitLab account](https://docs.gitlab.com/subscriptions/customers_portal/#change-the-linked-account).

### 6. Linked accounts have different emails

Let's say a Customer Z has an existing Customers Portal account (<customerZ@example.com>) either from an existing purchase or by creating a new account.
And this Customers Portal account has been linked to a GitLab account (check the `GitLab Groups` tab) whose email is <gitlabZ@example.com>.
*This could be someone else's GitLab account or Customer Z might have multiple GitLab accounts.*

Customer Z will get this error if they try to log in or create an account in GitLab with their email <customerZ@example.com> then attempt to purchase or renew a paid plan or additional storage, or try to purchase more compute minutes from GitLab.
The error is reported because CustomersDot does not find a Customers Portal account that is linked to the GitLab account making the purchase yet there is a CustomersDot account whose email is the same as the email in the GitLab account making the purchase.
In this case, CustomersDot does not find an account linked to the GitLab account whose email is <customerZ@example.com>.
CustomersDot then tries to create an account using the email <customerZ@example.com> but this fails because a CustomersDot account with this email already exists.

🔧 To fix the problem, Customer Z needs to log in to their [Customers Portal](https://customers.gitlab.com/customers/sign_in) account and either:

- [Change the linked GitLab account](https://docs.gitlab.com/subscriptions/customers_portal/#change-the-linked-account) to the GitLab account with email <customerZ@example.com>
- Or update the email in their Customers Portal account to match the email in the linked GitLab account, which is <gitlabZ@example.com>.
Customer Z should not create another account with the email <customerZ@example.com> because an account will be created for them automatically when the transaction succeeds.

**TODO:** We need to verify that Customer Z can purchase using the GitLab account with the email <gitlabZ@example.com> because the system will locate the linked Customers Portal account.

