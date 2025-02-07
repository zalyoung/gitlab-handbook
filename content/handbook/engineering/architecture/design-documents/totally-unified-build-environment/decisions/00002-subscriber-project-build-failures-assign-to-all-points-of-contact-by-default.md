---
status: accepted
date: 2024-08-07
authors:
    - @rmarshall
approvers:
    - @balasankarc
    - @deriamis
    - @WarheadsSE
---

## Decision

When a subscriber project build fails, The Totally Unified Build Environment
assigns the issue it opens to the project's points of contact by default. It
also tags any groups in the contacts section in the description.

## Context

The Totally Unified Build Environment opens an issue and needs to assign it to
a directly responsible party when a subscriber project build fails.

## Rationale

Build failure visibility is a primary goal for The Totally Unified Build Environment.
Although we could assign a build failure issue to one directly responsible individual
and avoid the bystander effect, this choice comes with its own downside. For
example, what if that engineer is out of office for an extended leave or has
left GitLab? For this reason, we notify more than one point of contact
to ensure the issue gets seen and addressed. We mitigate the bystander effect
risk through one directly responsible Build engineer who drives the entire
upgrade through the epic.

## Resources and additional information

- [The Bystander Effect](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6099971/)
- [Single Directly Responsible Individual vs. Group Responsibility Discussion Thread](https://gitlab.com/gitlab-org/distribution/build-architecture/documentation/-/merge_requests/7#note_2025361473)
