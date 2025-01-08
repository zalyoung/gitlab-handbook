---
title: Enabling/disabling US Government Support exceptions
description: Support Operations policies page for enabling/disabling US Government Support exceptions
canonical_path: "/handbook/support/readiness/operations/docs/policies/us_gov_support_exceptions"
---

## Which organizations sync to the US Government instance by default?

As the exact conditions of this can change at any time, it is best to refer to
our documentation page on the ZD-SFDC sync, specially the section concerning the
[Zendesk US Federal organizations sync](../../zendesk/zendesk_salesforce_sync#zendesk-us-federal-organizations-sync)
and the SOQL query documented within.

## Adding the exception submissions

For this process, the
[Support Super Form Processor](https://gitlab.com/gitlab-support-readiness/processors/support-super-form-processor)
and the scripts in the
[Swap US Gov Support Exception project](https://gitlab.com/gitlab-support-readiness/zendesk-us-government/swap-us-gov-support-exception)
do all the heavy lifting, we just need to double-check the data provided in
the generated issue and kick off the pipeline that does the change itself.

To start, a requester (with Zendesk US Government agent access) will fill out
the
[Support Super Form](https://support-super-form-gitlab-com-support-support-op-651f22e90ce6d7.gitlab.io/)
using the `What is this request concerning?` of
`Enable US Government Support exception for an Account`. In this form, they will
provide links to the SFDC account and the related SFDC opportunity that sold the
US Government SKU.

This information is then sent to the
[Support Super Form Processor](https://gitlab.com/gitlab-support-readiness/processors/support-super-form-processor)
which will do the following checks before creating an issue:

- Does the provided requester email correlate to a gitlab.com account?
- Does the requester have a Zendesk US Government agent account?
- Does the SFDC account provided correlate to an actual SFDC account?
- Does the SFDC opportunity provided correlate to an actual SFDC opportunity?
- Does the SFDC account already have the exception?
- Does the SFDC Account have the US Government SKU present on it?

Should any of those checks fail, an email will be sent to the requester via
Mailgun indicating the request was not able to be processed (indicating the
checks it did not pass).

If all checks pass, an issue is then created within our
[issue tracker](https://gitlab.com/gitlab-com/support/support-ops/support-ops-project)
for us to work.

## Removing the exception submissions

For this process, the
[Support Super Form Processor](https://gitlab.com/gitlab-support-readiness/processors/support-super-form-processor)
and the scripts in the
[Swap US Gov Support Exception project](https://gitlab.com/gitlab-support-readiness/zendesk-us-government/swap-us-gov-support-exception)
do all the heavy lifting, we just need to double-check the data provided in
the generated issue and kick off the pipeline that does the change itself.

To start, a requester (with Zendesk US Government agent access) will fill out
the
[Support Super Form](https://support-super-form-gitlab-com-support-support-op-651f22e90ce6d7.gitlab.io/)
using the `What is this request concerning?` of
`Disable US Government Support exception for an Account`. In this form, they will
provide links to the SFDC account and the related SFDC opportunity that sold the
US Government SKU.

This information is then sent to the
[Support Super Form Processor](https://gitlab.com/gitlab-support-readiness/processors/support-super-form-processor)
which will do the following checks before creating an issue:

- Does the provided requester email correlate to a gitlab.com account?
- Does the requester have a Zendesk US Government agent account?
- Does the SFDC account provided correlate to an actual SFDC account?
- Does the SFDC account have the exception?

Should any of those checks fail, an email will be sent to the requester via
Mailgun indicating the request was not able to be processed (indicating the
checks it did not pass).

If all checks pass, an issue is then created within our
[issue tracker](https://gitlab.com/gitlab-com/support/support-ops/support-ops-project)
for us to work.

## Process

Your task at this point will be to review the issue to ensure the data looks
accurate. This is done just to be sure we are not making improper changes to any
SFDC accounts.

- For adding the exception:
  - The biggest thing to check for is the approval of a Vice President at
    Enterprise Sales, Public Sector on the opportunity provided. If we do not
    see that, we cannot proceed (reply on the issue stating as much).
- For removing the exception:
  - The biggest thing to check for if the organization in questions has any
    ongoing tickets. If they do, you will want to get a Support Manager to
    determine how to proceed (as the removal can result in routing issues on
    existing non-closed tickets).

If everything looks good, you will then navigate to the
[Swap US Gov Support Exception project](https://gitlab.com/gitlab-support-readiness/zendesk-us-government/swap-us-gov-support-exception)
to run a pipeline. This is done by hovering over Builds on the left-hand side
and clicking on the
[Pipelines](https://gitlab.com/gitlab-support-readiness/zendesk-us-government/swap-us-gov-support-exception/-/pipelines)
option.

From here, you will want to click the blue
[Run pipeline](https://gitlab.com/gitlab-support-readiness/zendesk-us-government/swap-us-gov-support-exception/-/pipelines/new)
button at the top-right of the page. Doing so will bring up a page asking you
for some information, namely the variables to use. You will want to fill that
out like so:

| Type     | Input variable key | Input variable value             |
|----------|--------------------|----------------------------------|
| Variable | ACCOUNT_ID         | The SFDC Account's ID            |
| Variable | ISSUE_IID          | The issue you are working out of |

After doing so, click on the blue `Run pipeline` button to create your pipeline.

This will then run a pipeline that will swap the value on the Salesforce account
and comment on your issue confirming the change was done (and closing said
issue).
