---
stage: core platform
group: Database
title: "Cells ADR 008: Cluster wide unique database sequences"
toc_hide: true
---

## Context

Having non-overlapping unique sequences across the cluster is necessary for moving organizations between cells,
this was highlighted in [core-platform-section/-/epics/3](https://gitlab.com/groups/gitlab-org/core-platform-section/-/epics/3)
and different solutions were discussed in <https://gitlab.com/gitlab-org/core-platform-section/data-stores/-/issues/102>.

## Decision

All cells will have bigint IDs on creation. While provisioning, each of them will get a
range of sequences to use from the [Topology Service](../topology_service.md).

Topology service uses the logic explained in [here](../topology_service.md#logic-to-compute-the-range) to compute the range, with this logic below is the sequence range for the legacy cell and the first created cell (and so on).

| Cell ID                | Sequence Range     |
|------------------------|--------------------|
| 1 (Legacy Cell)        | [0, 2199023255551] |
| 2 (First created cell) | [2199023255552, 4398046511103]  |

As each cell will have ~2.2 trillion IDs, which is 200 times the current largest ID (security_findings -> ~11 billion) and the newly created cells will not overlap with the legacy cell's sequences, we will not be updating legacy cell's sequence limit.

## Consequences

1. The above decision will support till [Cells 1.5](../iterations/cells-1.5.md) but not [Cells 2.0](../iterations/cells-2.0.md).
   - To support Cells 2.0 (i.e: allow moving organizations from
   Cells to the Legacy Cell), we need all integer IDs in the Legacy Cell to be converted to `bigint`.
   - Which is an ongoing effort as part of [core-platform-section/data-stores/-/issues/111](https://gitlab.com/gitlab-org/core-platform-section/data-stores/-/issues/111)
   and it is estimated to take around 12 months.
2. It's still uncertain how we will reuse the unused IDs from the decommissioned cells, it's been tracked in [issue#499109](https://gitlab.com/gitlab-org/gitlab/-/issues/499109).
   - But this should not block anything as we can accommodate 65,535 cells for now and have room to increase in future using the reserved bits as explained in [here](../topology_service.md#logic-to-compute-the-range).

## Alternatives

In addition to the [earliest proposal](../rejected/impacted_features/database_sequences.md), we evaluated
below solutions before making the final decision.

- [Solution 1: Global Service to claim sequences](https://gitlab.com/gitlab-org/core-platform-section/data-stores/-/issues/102#note_1853252715)
- [Solution 2: Converting all int IDs to bigint to generate uniq IDs](https://gitlab.com/gitlab-org/core-platform-section/data-stores/-/issues/102#note_1853260434)
- [Solution 3: Using composite primary key [(existing PKs), original cell ID]](https://gitlab.com/gitlab-org/core-platform-section/data-stores/-/issues/102#note_1853265147)
- [Solution 4: Use bigint IDs only for Cell](https://gitlab.com/gitlab-org/core-platform-section/data-stores/-/issues/102#note_1853328985)
- [Solution 5: Using Logical replication](https://gitlab.com/gitlab-org/core-platform-section/data-stores/-/issues/102#note_1857486154)
