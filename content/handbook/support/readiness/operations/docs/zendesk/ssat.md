---
title: SSAT
description: Support Operations documentation page for Zendesk satisfaction surveys
canonical_path: "/handbook/support/readiness/operations/docs/zendesk/ssat"
---

## What is the Zendesk satisfaction survey?

As per
[Zendesk](https://support.zendesk.com/hc/en-us/articles/4408886194202-Customizing-your-customer-satisfaction-survey)

> One of Zendesk Support's most popular features is our built-in customer
> satisfaction survey. Customer satisfaction allows you to track how well your
> agents and customer service organization as a whole are performing on a
> ticket by ticket basis. Because of our simplified approach, on average our
> customers see a roughly 21% response rate - which is fantastic! Zendesk
> Support provides some great defaults for the survey, but we get a lot of
> questions about how to further customize the customer satisfaction
> experience.

We shorthand the overall setup (survey and ticket ratings) as SSAT

## Zendesk Global setup

Zendesk Global uses an
[automation](https://gitlab.zendesk.com/admin/objects-rules/rules/automations/46784293)
to send out the satisfaction survey.

## Zendesk US Federal setup

Zendesk US Federal uses an
[automation](https://gitlab-federal-support.zendesk.com/admin/objects-rules/rules/automations/360094875892)
to send out the satisfaction survey.

## End-user experience when the SSAT survey is sent

Once the SSAT automation runs on the solved ticket, the user will receive an
SSAT survey email. A sample of this would look like:

![SSAT Survey Email](/images/support/readiness/operations/ssat_survey_email.png)

When the user clicks the survey link, they will be redirected to a page where they can select a rating 
and optionally add a comment.

![Good rated SSAT](/images/support/readiness/operations/good_rated_ssat_sample.png)

In the event the user selects `Bad, I'm unsatisfied`, we ask them to
specify a reason for the dissatisfaction.

The options available are:

- The issue was not resolved
- GitLab doesn't meet my needs
- The answer wasn't delivered in a timely manner
- The answer wasn't helpful

![Bad rated SSAT](/images/support/readiness/operations/bad_rated_ssat_sample.png)
