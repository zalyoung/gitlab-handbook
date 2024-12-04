---
stage: core platform
group: Tenant Scale
title: 'Cells: Clusterwide Sync'
status: proposed
---

## Goal

In order for some features to work, the data for some
[clusterwide](https://docs.gitlab.com/ee/development/cells/#choose-either-the-gitlab_main_cell-or-gitlab_main_clusterwide-schema)
tables needs to be synchronized to all cells.
For example, the `plans`, `plan_limits`, and `licenses` tables do need to be the same across all cells.

## Requirements

- Clusterwide tables needs to be clearly marked in the database dictionary as participating in the sync process, or not.
- There should be no additional cell-to-cell networking added. In other words, a cell should only communicate with a central service for syncing.

## Proposal

Prerequisites:

1. Only clusterwide tables are allowed to be synced. Cell tables are not allowed to be synced.
1. Some clusterwide tables (like `users`) will not be synced in Cells 1.0.

There will be a leader cell:

1. A cell can be elected a leader. The leader will be the authoritative source for that table.
1. The legacy cell will start as the leader cell.

All other cells will be followers:

1. Other cells will be followers. Followers will synchronize data from the
   leader cell for that table.
1. Follower cells should not allow any write activity to that table.
   Ideally, this is enforced at the database level.
1. While the cell is operating, the table will be periodically re-synced from
   the leader cell.

Central service:

1. The Central service recieves rows from the leader cell.
1. The Central service publishes rows to follower cells.

Syncing process:

1. A table is marked as partipating in the clusterwide sync process.
1. When a cell is created, the table will be synced from the leader cell.
1. The unit to be synchronized is a row.
   The key will be the primary key of the table.
1. All rows will be synchronized.
   Selective sync will not be available in Cells 1.0.
1. [Leader cell] Periodically, all rows of the table is sent to the Central service.
1. [Central Service] The latest state of the table is stored in a database.
1. [Follower cell] When a cell is created, it requests the rows for the table from
   the Central service.
1. [Follower cell] All rows for that table are then applied to the cells's database.
1. [Follower cell] Periodically, it requests the rows for the table from the
   Central service.

Conflicts:

1. It is undecided on what to do with extra rows.
1. Mising rows will be synchronized from the leader cell.
1. Rows with conflicting data will be replaced by data from the leader cell.

### Post Cells 1.0

It is anticipated that other clusterwide tables like `users` will need to be
synced to other cells as required.

## Alternatives

- Not syncing.
- [Logical replication](https://www.postgresql.org/docs/current/logical-replication.html).
- [Geo](https://docs.gitlab.com/ee/development/geo.html).
- Terraform / IAC.
