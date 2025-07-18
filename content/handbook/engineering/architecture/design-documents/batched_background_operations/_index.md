---
title: Batched Background operations
status: proposed
creation-date: "2025-07-16"
authors: [ "@praba.m7n", "@morefice" ]
coaches: [  ]
dris: [ "@alexives" ]
owning-stage: "~devops::data access"
participating-stages: []
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< engineering/design-document-header >}}

## Summary

Create a framework to do Batched Background data Operations (BBO). It can be used (triggered) from anywhere in the application, should be aware
of the database health to not overload it and should be able to track its progress and retry any failed operations.

## Motivation

There are many places (Sidekiq service, Cronjobs, etc.,) in the application from where we tend to do large data operations, by simply batching over the records
and performing some action(s). Such operations can result in degraded database performance, as it often touches huge amount
of records without proper measures implemented to avoid overloading the Db.

[BBM (Batched Background Migrations)](https://docs.gitlab.com/development/database/batched_background_migrations/) is a matured framework used widely to do such large data operations, it has in-built
[throttling](https://docs.gitlab.com/development/database/batched_background_migrations/#throttling-batched-migrations) and [retry](https://docs.gitlab.com/development/database/batched_background_migrations/#job-retry-mechanism) mechanisms, but it
can only be enqueued from regular rails migrations.

So it is natural to adopt the existing BBM framework's working parts to make general purpose batched data operations safe and maintainable.

### Goal and proposal

We do not want to mix BBO with BBM framework (underlying tables/modules) for following reasons:

1. BBM related tables have details not useful for Batched Background Operations (BBOs), example: `batched_background_migrations.queued_migration_version` column and other
migration specific tools
2. To [avoid STI](https://docs.gitlab.com/development/database/single_table_inheritance).
3. To not intervene logic in BBM framework to accomodate BBOs and then hide them from Admin UIs and other places.

So we want to develop framework for batched background data operations using BBM modules but without disturbing the existing framework.

### Non-Goals

This will only support data operations which batches using existing [BBM strategies](https://gitlab.com/gitlab-org/gitlab/blob/dcca730e20427a33a49220930c298632fd1e18db/lib/gitlab/background_migration/batching_strategies/), eg: looping through PKs (with scope defined).

Example: [Todos::DeleteAllDoneWorker](https://gitlab.com/gitlab-org/gitlab/-/blob/2852f2f817e9ac70a0d733484b2433cb2ed2bfc0/app/workers/todos/delete_all_done_worker.rb) can be supported but [Ci::DestroyOldPipelinesWorker](https://gitlab.com/gitlab-org/gitlab/-/blob/63f878e8e793ecdcfc60a059c12e2e4cb46ff467/app/workers/ci/destroy_old_pipelines_worker.rb) can not be, because the latter
uses Redis cache to get the next item in the batch.

## Design and implementation details

Similar to `Database::BatchedBackgroundMigrationWorker` cron, `Database::BatchedBackgroundOperationWorker` will run every minute,
which will process any newly added `batched_background_operations`.

Common methods will be pulled out from modules/classes in [workers/database/batched_background_migration](https://gitlab.com/gitlab-org/gitlab/blob/676e40c4dfa0071d4931b25ddbaf1375e59baeb0/app/workers/database/batched_background_migration/)
to reuse them in BBO framework.

BBM will get [finalized](https://gitlab.com/gitlab-org/gitlab/blob/9eab5b3eb225897bc6a00464f29137f8d0392d94/lib/gitlab/database/migrations/batched_background_migration_helpers.rb#L203) and [deleted](https://gitlab.com/gitlab-org/gitlab/blob/9eab5b3eb225897bc6a00464f29137f8d0392d94/lib/gitlab/database/migrations/batched_background_migration_helpers.rb#L183) manually
from migrations as described in [here](https://docs.gitlab.com/development/database/batched_background_migrations/#how-to). But since BBO can't have manual intervention once the `batched_background_operation` gets finished, a new cron
`delete_finished_batched_background_operations` will run periodically to clear them off.
