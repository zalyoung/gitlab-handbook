---
title: 'Cells: Organization migration'
status: proposed
creation-date: "2024-05-01"
authors: [ "@dbalexandre", "@mkozono" ]
coach: [ "@ayufan" ]
dris: [ "@sranasinghe", "@luciezhao" ]
approvers: [ "@sranasinghe", "@luciezhao" ]
owning-stage: "~devops::systems"
participating-stages: ["~devops::data stores", "~devops::systems"]
toc_hide: true
---

## Summary

When we reach production and can operate organizations on new [cells](../cells), we need to be able to move [organizations](https://docs.gitlab.com/ee/user/organization/) from GitLab.com into a cell or between any two cells. [The Org Mover project](https://gitlab.com/groups/gitlab-org/-/epics/12857) provides a CLI orchestrator tool that makes the process of moving organization data from one cell to another a breeze. It’s designed to ensure no data loss or corruption with minimal downtime.

It is important to note that the tool itself isn't responsible for moving data, but it takes care of setting up all the required logistics. It will be developed as a gem within the [gitlab-org/gitlab](https://gitlab.com/gitlab-org/gitlab) codebase.

## Motivation

Org Mover will allow organizations to be moved to our scalable cells architecture, future-proofing our GitLab.com services as GitLab grows. This way, we guarantee that we will be able to deliver a consistently excellent service for our GitLab.com customers with all the advantages that come with the cells architecture.

### Goals

- Move organizations off GitLab.com or between Cells to rebalance them with minimal downtime:
  - Maximum downtime requirements for moving an organization and cutting it over to the target cell are as follows:
    - Cells 1.5 - 24 hours
    - Cells 2.0 - Ideally 0. Low enough to not have to coordinate the migration with them.
  - Reuse Geo code to replicate non-PostgreSQL data continuously for a particular organization.
  - Implement a reliable and scalable tool to copy all PostgreSQL data for a particular organization from the source database and writes it to the target database present in another cell.
  - Create the Org mover CLI orchestrator tool that will:
    - Set up and manage the replication of non-PostgreSQL data for a particular organization.
    - Put an organization into a maintenance mode.
    - Start the PostgreSQL data copy.
    - Handle tables exempt from sharding.
    - Handle the ElasticSearch and Zoekt data.
    - Rebuild the ClickHouse data.
    - Monitor the replication process.
    - Perform the switchover.
    - Remove all organization data that has been moved over.
  - Implement robust error handling and monitoring to quickly identify and resolve any issues in the data synchronization process.
- Ensure there's no data loss or corruption during the move. The process must ensure that all data at the source cell is copied to the target cell.
- Ensure the process for moving data from one cell to another is timely and allows for reasonable throughput. Moving many organizations simultaneously shouldn't put undue strain on the infrastructure.
- Ensure there is no downtime while turning on/off the replication on live systems. Both GitLab.com and the target cell will have live organizations with users consuming services. Therefore, we cannot afford to incur downtime to configure the replication.

### Non-Goals

- The decision of which organization lives in which cell.
- Support for self-hosted installations.
- Geo may or may not be configured, or partially configured, on GitLab.com. This document does not require a decision at the time of writing.

## High-Level Proposal

A organization move can be broken down into five distinct high-level phases:

1. **Continuously replicate an organization's non-PostgreSQL data from the source cell to the target cell.**

    1. Org Mover will reuse [Geo](https://docs.gitlab.com/ee/administration/geo/) code to transfer non-PostgreSQL data continuously to the target cell.

       The purpose is to reuse GitLab Geo code to replicate organization data outside the PostgreSQL database (files, Git data, object storage, container registry, etc.) from the source cell to the target cell. Given that cells cannot use PostgreSQL streaming replication, we need to make Geo independent of the method of PostgreSQL replication. This way, the target cell can connect directly to the source cell database or use PostgreSQL logical replication.

1. **Prepare the organization for the switchover.**

    1. Put the organization into a [maintenance mode](https://gitlab.com/groups/gitlab-org/-/epics/13800).

       A switchover requires a maintenance window in which updates to the source cell are blocked to ensure the switchover can occur without data loss. To block new writes to the data on the source Cell, we put the organization in maintenance mode. This means that the organization's users cannot make any writes to it while in maintenance mode.

       The maintenance window ends once the replication of all the organization's data is completely finished and verified and the routing table is updated. So, to keep the window as short as possible, we should ensure that non-PostgreSQL data replication and verification processes are as close to 100% as possible during active use, and that the newer changes are almost immediately replicated to the target cell before putting the organization in maintenance mode.

1. **Copy organization's PostgreSQL data from the source cell to the target cell.**

    1. Copy data for a particular organization from the source database and write it to the target database present in another cell.

       Copy data for a particular organization from the source database in multiple tables based on `organization_id` and write it to the database present in the target cell.

       Early Org Mover will implement a tool that uses the [COPY approach](https://gitlab.com/gitlab-org/gitlab/-/issues/473894) to transfer PostgreSQL data during cutover. This requires a long downtime to move large organizations, but can be very quick for small organizations.

       The tool is also responsible for the secrets/tokens stored at rest (database). It will establish a trust between the source and target cell to either re-encrypt data inline or prepare the encrypted data on the source cell to be re-encrypted with a transport key and re-encrypted to the target cell after the process finishes. This document does not require a decision at the time of writing.

    1. Handle tables exempt from sharding.

       Some tables are missing the sharding key, so the Org Mover will need to know how to move the data in each of these tables to the target database. This must happen after the organization database data copy is complete.

    1. Handle the ElasticSearch and Zoekt data.

       TBD

    1. Rebuild the ClickHouse data.

       We don't have the `organization_id` available in ClickHouse to move the data to another cell, and most data in ClickHouse is built from PostgreSQL. So once the organization database data copy is complete, we must rebuild the ClickHouse data from PostgreSQL data.

       It is important to note that the Analytics Data Working Group is investigating different ways of syncing data, which would automatically pick up database-level changes and apply them to ClickHouse databases. Since the Org Mover re-creates data on the target cell and drops data from the source cell, changes will be picked up by ClickHouse automatically, and the Org Mover does not need to know about ClickHouse. This is still in [the research phase](https://gitlab.com/gitlab-org/architecture/gitlab-data-analytics/design-doc/-/blob/master/areas/synchronization.md?ref_type=heads#goals-and-objectives.).

1. **Switchover and update the routing information.**

    There are no new writes to the organization data in the source cell, and the
    organization database in the source cell is equal to the organization data in
    the target cell. So, we change the routing information for the organization
    `cell_id`. When we update the `cell_id`, it will automatically make the given
    cell authoritative to handle traffic for the given organization, and we can
    disable the maintenance mode.

1. **Remove all organization data that has been moved over.**

    1. Delete organization's stale data from the source cell:

        1. Remove all data from the PostgreSQL database.

        1. Remove all data from tables exempt from sharding.

        1. Rebuild the ClickHouse data.

        1. Remove all non-PostgreSQL data.

    1. Delete organization's stale data from the targer cell:

        1. Remove all data from the Geo tracking database.

## Implementation Roadmap

1. [Enable Geo on Gitlab.com and perform the checksumming of all data](https://gitlab.com/groups/gitlab-org/-/epics/14631) -- 4-6 Milestones
1. [Make Geo PostgreSQL replication technology agnostic](https://gitlab.com/groups/gitlab-org/-/epics/13721) -- 2-3 Milestones
1. Design and implement selective sync of Organizations -- 1-2 Milestones
1. Make Geo work as a Disater Recovery solution alongside the Org Mover use case -- 2-3 Milestones
1. [Develop the CLI tool to copy PostgreSQL data from the source database to the target database](https://gitlab.com/gitlab-org/gitlab/-/issues/473894) -- 2-3 Milestones
1. Develop the CLI orchestrator tool -- 3-4 Milestones
1. Implement error handling and monitoring -- 1-2 Milestones
1. Test and validate the solution -- 1-2 Milestones

## Alternative Solutions

We could move organizations using [Direct transfer](https://docs.gitlab.com/ee/user/group/import/) and [Congregate](https://gitlab.com/gitlab-org/professional-services-automation/tools/migration/congregate). Both have been considered and evaluated, but these solutions do not meet the downtime requirements.

## Future iterations

- Add PostgreSQL Logical Replication as an option to minimize cutover downtime.
- Provide an API interface to make integration with infrastructure tools easier.
- Provide intuitive configuration and management UI interfaces.

## Migration approaches at different stages of Cells

We will need to adopt different approaches for each [major stage](_index.md#cells-iterations) of the Cells evolution based on which technologies are available at each stage.

As we discuss forming and migrating Organizations it's important to call out that top-level groups will retain their access URL as they move between Organizations. For example, when a customer's top-level groups are moved from the [Default Organization](../organization/_index.md#default-organization) to an Organization of their own, their methods of access are unchanged. This means bookmarks, git remote URLs, etc .. for projects in these top-level groups remain unchanged and require no action from users or updates to automation after a migration.

### Cells 1.0

Cells 1.0 will use [Direct Transfer (DT)](https://docs.gitlab.com/ee/user/group/import/) to move internal top-level groups to a separate Organization. 

We still need to evaluate and address any gaps but this is the only option available in this timeframe.

DT will generate new IDs when the data is imported into a new organization. This is because DT is a copy instead of a move operation. It does not make sense to evolve DT to work as a move operation as it deviates from its core purpose for importing and exporting data.

It makes sense for DT to evolve to work with organizations in time for Cells 1.0. This is not throw away work since it is a feature that will need to be supported when we have Cells and Organizations.

Limitations:

- Only top-level groups can be moved between organizations.
- New IDs will be generated which will break automation and integrations - This is acceptable since we will only be moving a limited set of internal top-level groups.

We will migrate a few small GitLab internal top-level groups to a secondary cell. There will be no customer org migrations in Cells 1.0. The specific top-level groups to be migrated will be identified in due course.

![org-migrations-cells-1-0](/images/design-documents/cells/org_migrations_cells_1_0.png)

All existing top-level Groups on GitLab.com are part of the `default Organization`. A list of all GitLab top-level groups can be found [here (internal link)](https://docs.google.com/spreadsheets/d/18JSGNWYXhAofSqPPLCh_wb0dc9wTT9HuOucHegmsYhA/edit#gid=0).

We will create a new temporary organization (GitLab Inc) on the secondary cell.

We will use [direct transfer](https://docs.gitlab.com/ee/user/group/import/)
or [congregate](https://gitlab.com/gitlab-org/professional-services-automation/tools/migration/congregate) to migrate select top-level GitLab groups from the `default Organization` on the primary cells to GitLab Inc organization on the secondary cell. If [org mover](https://gitlab.com/groups/gitlab-org/-/epics/12859) is ready in time we will use this instead.

The top-level groups being migrated will be read-only for the duration of the migration. Once the migration is complete the organization will become read/write and fully operational on the secondary cell.

### Cells 1.5

The focus will be moving top-level groups into Organizations and then migration those Organizations to secondary Cells.

We will establish a process for moving top-level groups between organizations on the same Cell. This functionality is net new and will need to be developed in time for Cells 1.5 and is a pre-requisite before Org mover can move an Organization between Cells.

The solution will need to re-write the org IDs when a top-level group is moved to a new Organization. A new solution is preferable to using DT since DT does much more than re-writing IDs and will be a more complex operation. This also ensures new IDs are not generated where it's not necessary when the top-level groups is moved into a new Organization that will lead to users having to make changes to their local repositories, bookmarks, etc ... to match the new IDs and paths.

Once the top-level groups for a customer are in their own Organization on [Cell 1 (the legacy Cell)](decisions/012_cell_unique_identifier.md), Org mover will move the entire Organization from Cell 1 to a secondary Cell.

Limitations:

- Only top-level groups can be moved between Organizations.
- It will only be possible to move top-level groups between organizations in the same Cell - This is acceptable because our primary use case involves creating a new Organization for a customer in Cell 1 and moving their top-level groups into this Organization. Groups will not need to be moved across Cells at this stage.

At Cells 1.5, we will consolidate the GitLab Organization by merging the top-levels groups that are part of the GitLab Inc Organization with the main GitLab Organization - the long term home for all GitLab top-level groups.

![org-migrations-cells-1-5](/images/design-documents/cells/org_migrations_cells_1_5.png)

All remaining top-level GitLab groups on the legacy Cell will be moved to the GitLab Organization. The entire GitLab Organization will be moved to a secondary cell using org mover. Following this, Organizations will be consolidated by moving the top-level groups in the temporary GitLab Inc Organization into the GitLab Organization. The GitLab Inc org will then be deleted.

### Cells 2.0

At this stage it is anticipated that we will have a fleet of Cells. Load across these Cells will need to be rebalanced as Organizations grow requiring a mechanism for moving Organizations between seconary Cells. Org mover will be evolved to move Organizations between secondary Cells.

There is also a need to move top-level groups between Organizations that are on different Cells. The primary use case is to support mergers between two customer Orgazations. We do not currently have solution for this. We will in due course evaluate where the Org mover should be evolved move top-levels groups between secondary Cells and other approaches.

Limitations:

- Only top-level groups can be moved between organizations.
