---
title: Becoming and Being an ASE
description: Information about the ASE role for new and potential ASEs
---

## Becoming and Being an ASE

### Basic job information

The first thing to do if you're contemplating a move to an ASE role is to take
a look at two topics on the Support Engineer job family page in the Handbook:

1. [The ASE role](/job-families/engineering/support-engineer/#the-ase-role)
1. [What is it like to be an ASE (video)](/job-families/engineering/support-engineer/#what-is-it-like-to-be-an-ase)

You might also find it helpful to review the
[ASE performance factor worksheet template](LINK COMING SOON)

### Onboarding tasks for new ASEs

1. Ask an existing ASE or ASE Manager to:
   1. invite you to the `#support_assigned-support-eng` Slack channel
   1. invite you to both of the recurring ASE Team meetings
1. Find your Zendesk user ID and the Zendesk org ID for each of your assigned
   accounts, if you have any:
   1. Open the
      [Support Super Form](https://support-super-form-gitlab-com-support-support-op-651f22e90ce6d7.gitlab.io/)
      1. select `Modifications to a Zendesk Global Organization`,
      1. then select `Set an Assigned Support Engineer for an organization`
   1. To find your Zendesk user ID:
      1. Click in the field with the prompt:
         `What is the Zendesk user ID of the assigned support engineer? (put None to remove the current ASE)`
      1. Use the instructions posted on the right side of the window to find
         your user ID; save the ID somewhere convenient
   1. To find the Zendesk org ID for each of your accounts (if any):
      1. Click on the field with the prompt:
         `What is the Zendesk organization's ID?`
      1. Use the instructions posted on the right side of the window to find
         the org ID for each account; record TWO pieces of information for each
         account:
         1. The Zendesk org ID
         1. The `Zendesk Org Name`, which is an 8-character hexadecimal number
            followed by the recognizable name of the account, such as
            `f6438d0c Acme Corp.` It'll be the title for the page.
1. Submit an MR to update the
   [README.md file](https://gitlab.com/gitlab-com/support/assigned-support-engineers/-/blob/main/README.md?ref_type=heads)
   in the [Assigned Support Engineers project](https://gitlab.com/gitlab-com/support/assigned-support-engineers).
   This file is the SSoT for the current list of ASEs and their assigned
   accounts. Edit only the table rows for your accounts, and for each row enter
   the corresponding Zendesk Org Name and Zendesk Account ID as well as your
   Zendesk User ID.
1. Submit an MR to update your personal yaml file in the
   [Support Team project](https://gitlab.com/gitlab-support-readiness/support-team/-/tree/master/data/agents):
   1. Look for the `focuses:` header
   1. Add a new focus after your existing ones:

      ```yaml
      - name: ASE
        percentage: [percent]
        zendesk: [instance]
        organizations:
        - id: [org_a ID]
          percentage: [org_b percentage]
        - id: [org_b ID]
          percentage: [org_b percentage]
      ```

      1. where `[percent]` is 25 times the number of ASE units for which your
         accounts have contracted. Most accounts purchase 1 ASE unit, which
         gives them 8 hours per week with an ASE, but some purchase more. Here
         are some examples to help you:
         1. if you have 2 accounts that purchased 1 unit each, then put 50
         1. if you have 1 account that purchased 2 units, and another that
            purchased 1, then put 75
      1. where `[instance]` is either "global" or "us_gov", according to
         whether your ASE accounts work with Global or US Gov Support
      1. where `[org_a ID]` is the Zendesk org ID for your first account,
         which you saved earlier, `[org_b ID]` is the saved ID for your second
         account, and so on
      1. where `[org_a percentage]` is the percentage of your ASE time that
         will be spent on org_a, `[org_b percentage]` is the same thing for your
         second account, and the sum of the org percentages is 100
1. Change your job title in Zoom
1. Update your signature in Zendesk to indicate that you are an ASE
1. Submit an Access Request to get a user account created for you in
   Salesforce. This account will be read-only, and will **not** add you to the
   [Designated Insiders](/handbook/legal/publiccompanyresources/#designated-insiders)
   list. It is needed in order to be able to display in some reports and
   dashboards the ASEs for each account. Please follow these steps:
   1. Create an issue using
      [this template](https://gitlab.com/gitlab-com/team-member-epics/access-requests/-/issues/new?issueable_template=Individual_Bulk_Access_Request)
   1. Set the title to: `<your name>, Salesforce, Executive-NoViewAll`
   1. Fill in `Step 1` appropriately
   1. In `Step 2` enter:

      ```markdown
      * [ ] Salesforce: Executive-NoViewAll
         * [ ] Justification: Support engineers serving as Assigned Support Engineers need SFDC access in order to enable the picklist functionality described in [this issue](https://gitlab.com/gitlab-com/sales-team/field-operations/systems/-/issues/5626).
      ```

   1. Assign the issue to your manager

### On-call responsibilities

ASEs with two or more accounts are not expected to participate in either the
[Customer Emergencies On-Call (CEOC)](/handbook/support/workflows/customer_emergencies_workflows/)
or [Communication Manager On-Call (CMOC)](/handbook/support/workflows/cmoc_workflows/) rotations.

Participating in these on-call rotations creates an ongoing risk of conflict for the ASE between
high-priority work from their assigned accounts and their on-call responsibilities. This risk
becomes too great to manage when an ASE has two or more accounts.

ASEs who have been rostered for CEOC or CMOC responsibilities from their time in global support
should continue participating in these on-call rotations until they have two assigned accounts. At
that point, the ASE and their manager should create a plan for the ASE to transition off the COEC or
CMOC rotation that minimizes disruption to the team.

###

**<<<< COMING SOON >>>>**

- Balancing between ASE and Global
  - on-call rotation
  - ticket queue
  - pairings and help sessions
- Learn about how to work with your account (manager 1:1s for now, presentation eventually)
  - managing customer expectations
  - stepping out of the SE box - change your way of thinking about what you should
    or shouldn't do
  - prioritize and re-prioritize all the time
  - only attend account meetings in which you will learn or contribute
  - get to know the people as people
    - do lots of Zooms with them and chat as you work a ticket
  - get to know what they're doing with GitLab and why
- Link to the customer onboarding page (customer-onboarding.html)
- Tips from ASEs
