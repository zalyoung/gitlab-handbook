---
title: SLA policies
description: Support Operations documentation page for Zendesk SLAs
canonical_path: "/handbook/support/readiness/operations/docs/zendesk/service-level-agreements"
---

## Zendesk calls them service level agreements, we do not

What appears here is all titled service level agreements, or SLAs, but many of
these are internal service level objectives, or SLOs, instead. They are titled
as service level agreement, or SLA, because that is what Zendesk calls the
setting. Nothing detailed herein is an actual, legal service level agreement.

## What are Zendesk service level agreements?

As per
[Zendesk](https://support.zendesk.com/hc/en-us/articles/4408829459866-Defining-SLA-policies):

> A Service Level Agreement, or SLA, is an agreed upon measure of the response
> and resolution times that your support team delivers to your customers.
> Providing support based on service levels ensures that you're delivering
> measured and predictable service. It also provides greater visibility when
> problems arise.

## Understanding SLA

When it comes to understanding SLA, there are two key concepts:

### How Zendesk defined SLA works

Zendesk SLA is strictly using FRT (first reply time) and NRT (next reply time)
by their own definitions:

- A ticket is using the FRT metrics if it has no public agent replies
- A ticket is using the NRT metrics if it has at least one public agent reply

The SLA timer (and thus the determination if a ticket is breached or not) stems
from looking up the metric definition on the SLA Policy in use (ticket events
can show this) and the ticket's _Priority_ field (not to be confused with
_Customer Severity_ or _Customer Priority_).

So as an example, if a ticket starting in the Billing team's queue, got a few
back and forth replies, and then go moved to the L&R team, Zendesk would
classify the ticket as using the NRT definition at that time.

### How GitLab defined SLA works

NOTE: Zendesk US Government _solely_ uses the Zendesk definition. None of the
following applies to Zendesk US Government

We use the _Ticket Stage_ field to determine the SLA timer. As such, our SLA
Policies are built with this in mind. We define FRT (first reply time) and NRT
(next reply time) by our own definitions:

- A ticket is using the FRT metric if work has not begun on the ticket by the
  relevant team
- A ticket is using the NRT metric if work has begun on the ticket by the
  relevant team

The SLA timer (and thus the determination if a ticket is breached or not) stems
from looking up the metric definition on the SLA Policy in use (ticket events
can show this) and the ticket's _Priority_ field (not to be confused with
_Customer Severity_ or _Customer Priority_).

So as an example, if a ticket starting in the Billing team's queue, got a few
back and forth replies, and then go moved to the L&R team, we would classify
the ticket as using the FRT definition at that time (largely due to Support
Readiness manually changing the _Ticket Stage_ value during the transition).

## How the SLA Policy is set by GitLab

For most tickets, the SLA is set depending on the following factors:

- The requester's support entitlement, except for the following forms:
  - Support Ops
  - Billing
  - L&R
- The form the ticket is currently using
- The _Ticket Stage_ ticket field

When a ticket is created, the _Customer Severity_ ticket field is translated
into a _Priority_ ticket field value:

- `Severity 1` becomes `Urgent` (unless the ticket is not an Emergency ticket,
  at which point it becomes `High`)
- `Severity 2` becomes `High`
- `Severity 3` becomes `Normal`
- `Severity 4` becomes `Low`

After that point, the _Priority_ ticket field is used in the SLA metrics (just
like Zendesk defines it).

As a ticket is updated, its SLA Policy might change depending on the form being
used, the _Ticket Stage_ ticket field, and any changes to the requester's
support entitlement (except for the above specified forms). The ticket's events
are the best source to determine the SLA Policy currently in place for a ticket
at any given state.

## When does an SLA timer tick

An SLA timer ticks after a customer replies, while the ticket status is New,
Open, On-hold, or Pending, up to the point _before_ an agent makes a public reply
during the business hours defined for said ticket.

Keeping this in mind, this means setting a ticket to pending or on-hold without
making a public agent reply does _not stop_ the SLA timer.

## Do all XXX timers use the same timeframe?

No, this is not correct. Every policy uses its own definitions for the timers.
While there is some overlap, we do not have a consistently used value for any
specific SLA timer. As an example, NRT is not "24 hours" across the board. It
can vary from SLA Policy to SLA Policy.

### Change management

Keep in mind, all change management should be stemming from an issue, first and
foremost.

We manage role membership via Zendesk itself (on user profiles), but only with
corresponding access request issues.

**NOTE** Any changes to SLAs **require** Support Readiness Director approval.
Changes here can have severe legal implications and should only be worked by a
Fullstack Engineer.

#### Creating a new SLA

As we manage SLA policies via our sync repos, you simply need to create the
file within the sync repo itself. The sync process will handle creating the
SLA policy within Zendesk itself.

#### Updating an existing SLA

Updating an existing SLA is considerably easier than creating a new one. Simply
change the code in the source project and it will occur via the sync
repo.

#### Deleting a SLA

**NOTE** This can be a **very** dangerous action to perform. Exercise extreme
caution in doing do.

To delete a role, you need to purge it from multiple locations:

- Sync repo project
- Zendesk itself

The first can be done via merge requests, but the last one has to be done in the
the Zendesk instance itself. Before doing so, 100% of the role's members should
be removed from the role.

After doing so, open up the admin page of your corresponding Zendesk instance
([Global](https://gitlab.zendesk.com/admin) or
[US Government](https://gitlab-federal-support.zendesk.com/admin))
`Objects and rules` on the left-hand side, and then click
`Service level agreements`. On this page, locate the SLA you want to delete,
click the gear icon to the right of it, and then click `Delete`.

This will cause a pop-up modal to appear asking you to confirm the action. Click
the blue `Delete policy` button to do so.

### Troubleshooting

#### Pipeline error "Blank ID"

This means the script detected a YAML file within `data/active` or
`data/inactive` that has an `id` value of blank (or nil). You will need to
locate the file mentioned in the error and correct that.

#### Pipeline error "Blank position"

This means the script detected a YAML file within `data/active` or
`data/inactive` that has an `position` value of blank (or nil). You will need to
locate the file mentioned in the error and correct that.

#### Pipeline error "Blank title"

This means the script detected a YAML file within `data/active` or
`data/inactive` that has an `title` value of blank (or nil). You will need to
locate the file mentioned in the error and correct that.

#### Pipeline error "GitLab errors"

This is a generic error message that will detail some error that occurred when
trying to either create or update the tag used on the source project. The exact
steps to fix this will vary based on the nature of the error itself. You will
need to review the error and determine the next steps from there.

If you are unsure how to proceed, it is best to seek assistance from the wider
team.

## Service level agreement standards

To ensure all SLA policies we utilize are both consistent in nature and
transparent in their actions, we strive to meet some standards on all SLA
policies we work with.

### Naming standards

The name used for the SLA policy should be simple, clear, and concise. You want
the name to convey what the SLA policy is used for.

### Condition standards

Generally speaking, we aim to make SLA policy conditions as simple as possible.
When possible, you should use condition sets that are very specific and
succinct. As an example, if you wanted a SLA policy to only run when the form is
`Support Ops`, it is better to simply put a condition of "Form is Support Ops"
than adding exclusions for _every_ other form. This can take time and practice
to learn, so when in doubt, pair with the rest of the Support Ops team!
