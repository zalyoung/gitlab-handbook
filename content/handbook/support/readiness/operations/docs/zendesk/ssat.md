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

## Setup

We utilize Zendesk automations to facilitate this process.

Customers receive a link to the survey (the exact link changes depending on the
Zendesk instance they are using). This survey is created by GitLab and managed
via
[this project](https://gitlab.com/gitlab-support-readiness/forms/ces-survey)
(and mirrored to [this project](https://gitlab.com/support/ces-survey)).

Upon filling out the survey, the
[CES Processor project](https://gitlab.com/gitlab-support-readiness/processors/ces-processor)
will review the information provided in the survey. If it is a valid submission,
it will then:

- Add a satisfaction score to the ticket
- Add a satisfaction comment to the ticket
- Update the ticket field `CES Score` on the ticket
- Add an entry to our backup Google sheets
  - [Global](https://docs.google.com/spreadsheets/d/1RWun0vAsxv310rd7yylvIGuR_VuERpcHqjv62x4ycYc/edit?usp=sharing) (internal only)
  - [US Government](https://docs.google.com/spreadsheets/d/1knq7Ae6UV06FxX2TGrt3Dzb6dbPM3QcQ4xXsrAM2T4w/edit?usp=sharing) (internal only)

## Prior to 2025-05-01

### End-user experience when the SSAT survey is sent

Once the SSAT automation runs on the solved ticket, the user will receive the
SSAT survey email where they can rate their support experience directly from the
email message. A sample of this would look like:

![SSAT Survey Email](/images/support/readiness/operations/ssat_survey_sample.png)

Once the user clicks either of the two satisfaction links in the email message,
the rating will be submitted and they'll be redirected to another page where
they can add a comment about the rating if they'd like.

![Good rated SSAT](/images/support/readiness/operations/good_rated_ssat_sample.png)

In the event the user selects the `Bad, I'm unsatisfied` link, we ask them to
specify a reason for the dissatisfaction.

The options available are:

- The issue was not resolved
- GitLab doesn't meet my needs
- The answer wasn't delivered in a timely manner
- The answer wasn't helpful

![Bad rated SSAT](/images/support/readiness/operations/bad_rated_ssat_sample.png)
