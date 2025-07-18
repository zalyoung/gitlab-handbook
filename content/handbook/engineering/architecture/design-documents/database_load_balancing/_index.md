---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Design doc title
status: proposed
creation-date: "yyyy-mm-dd"
authors: [ "@mattkasa", "@stomlinson" ]
coaches: [ "@username" ]
dris: [ "@product-manager", "@engineering-manager" ]
owning-stage: "~devops::<stage>"
participating-stages: [ ]
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!--
Before you start:

- Copy this file to a sub-directory and call it `_index.md` for it to appear in
  the design documents list.
- Remove comment blocks for sections you've filled in.
  When your document ready for review, all of these comment blocks should be
  removed.

To get started with a document you can use this template to inform you about
what you may want to document in it at the beginning. This content will change
/ evolve as you move forward with the proposal.  You are not constrained by the
content in this template. If you have a good idea about what should be in your
document, you can ignore the template, but if you don't know yet what should
be in it, this template might be handy.

- **Fill out this file as best you can.** At minimum, you should fill in the
  "Summary", and "Motivation" sections.  These can be brief and may be a copy
  of issue or epic descriptions if the initiative is already on Product's
  roadmap.
- **Create a MR for this document.** Assign it to an Architecture Evolution
  Coach (i.e. a Principal+ engineer).
- **Merge early and iterate.** Avoid getting hung up on specific details and
  instead aim to get the goals of the document clarified and merged quickly.
  The best way to do this is to just start with the high-level sections and fill
  out details incrementally in subsequent MRs.

Just because a document is merged does not mean it is complete or approved.
Any document is a working document and subject to change at any time.

When editing documents, aim for tightly-scoped, single-topic MRs to keep
discussions focused. If you disagree with what is already in a document, open a
new MR with suggested changes.

If there are new details that belong in the document, edit the document. Once
a feature has become "implemented", major changes should get new blueprints.

The canonical place for the latest set of instructions (and the likely source
of this file) is
[content/handbook/engineering/architecture/design-documents/_template.md](https://gitlab.com/gitlab-com/content-sites/handbook/-/blob/main/content/handbook/engineering/architecture/design-documents/_template.md).

Document statuses you can use:

- "proposed"
- "accepted"
- "ongoing"
- "implemented"
- "postponed"
- "rejected"

-->

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< design-document-header >}}

<!--
Don't add a h1 headline. It'll be added automatically from the title front matter attribute.

For long pages, consider creating a table of contents.
-->

## Summary

<!--
This section is very important, because very often it is the only section that
will be read by team members. We sometimes call it an "Executive summary",
because executives usually don't have time to read entire documents like this.
Focus on writing this section in a way that anyone can understand what it says,
the audience here is everyone: executives, product managers, engineers, wider
community members.

A good summary is probably at least a paragraph in length.
-->

This is a proposal to rewrite our database load balancing system to increase resiliency,
and then to rely on this increased resiliency to safely push more read traffic to replicas.

We will move all replica health checking operations, including both replication lag checks
and LSN checks (where we ask if a replica has replayed a specific write yet), off
of the web request / sidekiq worker threads, and build in timeouts so that misbehaving
replica databases cannot ever block web request / sidekiq threads during these checks.

With a more robust mechanism for LSN checks, it will be possible to safely perform
many LSN checks partway through a web request or sidekiq job. We will use this to
move web requests and jobs back to replicas after they perform a write as soon as
a replica has caught up to that write.

This will reduce read query traffic to the primary database, buying headroom.

We will also move the load balancing code to a gem in order to test it more thoroughly,
and we will develop a safer, more sophisticated deployment strategy for the load balancer code.

## Motivation

<!--
This section is for explicitly listing the motivation, goals and non-goals of
this document. Describe why the change is important, all the opportunities,
and the benefits to users.

The motivation section can optionally provide links to issues that demonstrate
interest in a document within the wider GitLab community. Links to
documentation for competing products and services is also encouraged in cases
where they demonstrate clear gaps in the functionality GitLab provides.

For concrete proposals we recommend laying out goals and non-goals explicitly,
but this section may be framed in terms of problem statements, challenges, or
opportunities. The latter may be a more suitable framework in cases where the
problem is not well-defined or design details not yet established.
-->

Our database load balancer has been implicated in numerous performance-related
incidents. Many incidents occurred when poor health check performance delayed the
request/response path, directly impacting users during high-traffic periods.
A significant issue is that load balancing decisions occur within the critical
request/response path. This coupling means health check problems directly impact
user-facing traffic. Experience shows slightly outdated health information is
preferable to failing requests while waiting for perfect information.
Maintaining this infrastructure within our monolith creates several challenges:

Load balancing changes require full application deployments, increasing risk.
Testing failure conditions is difficult, leading to issues found in production.
Current metrics inadequately monitor health check performance issues.
Our connection handling "sticks" to the primary database after the first write,
preventing subsequent reads from using replicas when they could.

By addressing these issues, we can create a more resilient system while reducing
primary database load through smarter connection management.

### Goals

<!--
List the specific goals / opportunities of the document.

- What is it trying to achieve?
- How will we know that this has succeeded?
- What are other less tangible opportunities here?
-->

- A misbehavior of a single replica database (either errors or slow responses)
  should not be able to take down an entire web process.
- LSN checks (checks of the form `has replica X caught up to at least write location Y`)
  are safe and cheap enough to run many times in a single web request.
- When a replica catches up to a write, the application notices and the thread
  that performed that write switches back to a replica.

- Maintain the load balancing code separately from the monolith
- Make the load balancer's behavior more resilient during high traffic periods
- Move more load away from the primary
- Improve failure modes in all cases
- Add test coverage of failure modes
- Make it safer to deploy load balancer changes

### Non-Goals

<!--
Listing non-goals helps to focus discussion and make progress. This section is
optional.

- What is out of scope for this document?
-->

- Reducing load on replicas
- Addressing other database performance issues not related to load balancing
- Long-term persistence of health check information

## Proposal

<!--
This is where we get down to the specifics of what the proposal actually is,
but keep it simple!  This should have enough detail that reviewers can
understand exactly what you're proposing, but should not include things like
API designs or implementation. The "Design Details" section below is for the
real nitty-gritty.

You might want to consider including the pros and cons of the proposed solution so that they can be
compared with the pros and cons of alternatives.
-->

We will move load balancing health checks and LSN checks out of the request/response cycle, and
persist LSN information in both an in-memory cache and redis. This will have two main improvements to the current system:

1. A single misbehaving replica will no longer block any load balancing operations indefinitely, effectively taking down every puma worker that tries to talk to it.
2. We can reduce the volume of LSN checks performed against a replica by caching the results.

As a result of these two improvements, it becomes safe to query for LSN information much more frequently.

Before this proposal, read queries could be routed to a primary database for one of the following reasons:

1. The current web request or sidekiq job previously performed a write operation, so we are "stuck" to the primary to allow reading our own write.
2. The current web request or sidekiq job was provided an LSN from the sticking system as the request or job started, and we could not find a replica up-to-date with that LSN to serve that request.
3. The current sidekiq job declared `data_consistency: :always` so it doesn't ever talk to a replica. We won't fix this case in this proposal.

A principal motivation of this proposal is that points 1. and 2. are the same event - reading our own write.
Point 1. accomplishes this naively by reading from the primary always, whereas point 2 uses LSN information to attempt to read from a replica.

This proposal aims to unify these two ideas. We will persist sticking information within a single request / job, and re-check it before every query execution.
This will let the system move back to a replica within the same job execution as soon as one is available.

When a web request or sidekiq job starts, we will re-hydrate the sticking information that was stored in the previous request or job, the same way that sticking works today.
This will let us dynamically move to a replica,  either immediately if possible, or after some number of read queries from the primary if one is not immediately available.


## Design and implementation details

<!--
This section should contain enough information that the specifics of your
change are understandable. This may include API specs (though not always
required) or even code snippets. If there's any ambiguity about HOW your
proposal will be implemented, this is the place to discuss them.

If you are not sure how many implementation details you should include in the
document, the rule of thumb here is to provide enough context for people to
understand the proposal. As you move forward with the implementation, you may
need to add more implementation details to the document, as those may become
valuable context for important technical decisions made along the way. A
document is also a register of such technical decisions. If a technical
decision requires additional context before it can be made, you probably should
document this context in a document. If it is a small technical decision that
can be made in a merge request by an author and a maintainer, you probably do
not need to document it here. The impact a technical decision will have is
another helpful information - if a technical decision is very impactful,
documenting it, along with associated implementation details, is advisable.

If it's helpful to include workflow diagrams or any other related images.
Diagrams authored in GitLab flavored markdown are preferred. In cases where
that is not feasible, images should be placed under `images/` in the same
directory as the `index.md` for the proposal.
-->


Things to talk about in impl details:

- What do we move out of request/response path and where
- How do we want to change our health check strategy
  - Suppose 10 replicas, then check 1 random one, upvote in redis if good.
    - If first one fails, get a random one of the good ones from redis
    - Aggregate on reading, store your "upvote" namespaced to your pod name so we don't hammer a key.

- Less lsn lookups in sidekiq dequeue

notes:


- check redis, not up to date
- query db for lsn, push result to redis

- lsn check background wakeup procedure:
  - Current + next lsn (2 mutexes + variables)
  - Each loop, wake up threads waiting for current lsn, then check next lsn (lock mutex), then wake up next_lsn threads and swap the mutexes
  - That way we get all the threads each time.

- redis key for each <replica-fqdn>_<pod_name>, value is lsn that we know the replica has, some short ttl (minutes?)
- Web / sidekiq threads just trust the host list in process mem if they don't need a lsn requirement.
- (background thread ensures some lag minimum in seconds for each replica in the host list)
- If a request requires an LSN:
  - Ask process mem for a replica that is up-to-date on that LSN
    - Happy path: found all of them! Pick one
    - Medium path: found some but not all of them
      - Run an lsn check on some subset that aren't up-to-date (check 2?) (in the background, recheck from redis when the background thread tries to do this check)
      - Pick one that was up-to-date
    - Unhappy path: didn't find any.
      - Ask redis for latest lsn for each replica
        - Happy path, found one up-to-date-enough! Use it + set it in process memory (any time you query redis, always make process memory a cache of redis state as fresh as you know it)
        - Unhappy path:
          - None are up-to-date-enough in redis. We need to decide to either wait or talk to some databases
          - Ask every replica for its lsn, write to process mem then to redis (writing to key <fqdn>_<pod_name> so that it doesn't trample other pods)
          - Thundering herd problem:
            - Queue with the background thread that we need a fast lsn check, go to sleep for a duration and wait for the check to come back. Use a condition variable to coordinate this so we wait for "remaining sleep budget or until check is done"
              - This fixes the case where the background thread gets stuck - the condition variable will wake the request thread back up and it can make a decision
              - This pushes lsn checks to the background thread, background threads can end up in a thundering herd situation of checks here.
                - fix by jittering how long each pod trusts a redis lsn result before asking the database.
                  - Means that only some small % of pods are doing an lsn check at a time without any locking between pods
                  - Get duration remaining on key ttl with https://redis.io/docs/latest/commands/ttl/ (very fast, fixes clock sync problem)
                  - Some pods will become de-facto "leaders" because they have short ttls, but that's not a big deal, lsn checks are very fast

## Alternative Solutions

<!--
It might be a good idea to include a list of alternative solutions or paths considered, although it is not required. Include pros and cons for
each alternative solution/path.

"Do nothing" and its pros and cons could be included in the list too.
-->
