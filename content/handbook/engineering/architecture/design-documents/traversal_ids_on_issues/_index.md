---
title: "Traversal IDs on issues"
status: draft
creation-date: "2025-04-22"
authors: ["@dgruzd", "@nicolasdular"]
coach: ["TBD"]
approvers: []
owning-stage: "~plan::product planning"
participating-stages: []
---

## Business Objectives

To further rollout work items, we need to tackle the scaling problems that are inherent of our hierarchy-based approach of querying data.
Without adressing these performance problems, the product will not be able to scale appropriately for large organizations.

## Problem Statement

After migrating `epics` to the `issues` table as part of the work items framework, we face a new performance problem when querying work items within the group hierarchy.
Before this migration, we only had two cases when querying within the hierarchy:

1. Issues - Getting all issues from all projects within the group hierarchy. We're able to use the `project_id` on the `issues` table.
2. Epics - Getting all epics from all groups within the group hierarchy. We're able to use the `group_id` on the `epics` table.

In both cases, the amount of namespaces was limited to either Groups or Projects. Also, the `epics` table was considerably smaller in size (about 0.5% of the `issues` table).

With work items, everything is in one `issues` table, and we now only distinguish between different work items using the `work_item_type` column. We now want to list all work items from groups and projects.
From our first experiments, we faced performance problems where the queries timed out for large groups like `gitlab-org` or `gitlab-com`.

### Root cause of the problem - looking up work items in many namespaces

When looking up all issues within a group, we use a query like the following (authorization checks are removed for improved readability):

```sql
WITH namespace_ids AS (
  SELECT id
  FROM namespaces
  WHERE traversal_ids @> ('{9970}')
)
SELECT * from issues WHERE issues.namespace_id IN (
  SELECT id FROM namespace_ids
)
ORDER BY created_at, id LIMIT 100;
```

For large groups, the amount of namespace_ids in the `IN`-clause can be a few thousand IDs, and the query can time out.

## Denormalize traversal_ids on issues table

Since the bottleneck is the large IN clause, we're proposing to denormalize the hierarchy on the `issues` table. With that, we could directly query all issues within a group hierarchy, instead of providing all namespace_ids to the query.
This approach has already shown great results as the `vulnerability_reads` table performed the [same optimization](https://gitlab.com/groups/gitlab-org/-/epics/12372).
Noteable: The `vulnerabilities_reads` table has a similar size as the `issues` table on GitLab.com, but there is a difference in functionality. For example, the sorting options are limited, which we will need to address with specific indexes on the issues table.

### Setup

To validate the experiment, you can use the following script to backfill the `traversal_ids` column on the replica for the `gitlab-org` group:

<details><summary>Script to backfill traversal_ids on a replica</summary>

```sql
DO $$
DECLARE
    total_count INTEGER;
    batch_count INTEGER;
    done BOOLEAN := FALSE;
    start_time TIMESTAMP;
    batch_start_time TIMESTAMP;
    now_time TIMESTAMP;
    total_processed INTEGER := 0;
    percent_complete NUMERIC;
    elapsed_seconds NUMERIC;
    seconds_per_batch NUMERIC := 0;
    remaining_batches NUMERIC;
    eta_seconds NUMERIC;
    eta_text TEXT;
    namespace_count INTEGER;
    batch_size INTEGER := 5000; -- Configurable batch size
    rows_per_second NUMERIC;
    total_rows_per_second NUMERIC;
BEGIN
    RAISE NOTICE 'Adding traversal_ids column...';
    ALTER TABLE issues ADD COLUMN IF NOT EXISTS traversal_ids bigint[] DEFAULT '{}'::bigint[] NOT NULL;

    RAISE NOTICE 'Starting temporary table creation for namespaces...';
    start_time := clock_timestamp();

    -- Create temporary table to store eligible namespace IDs
    CREATE TEMPORARY TABLE IF NOT EXISTS eligible_namespaces AS
    SELECT id, traversal_ids
    FROM namespaces
    WHERE traversal_ids @> ('{9970}');

    -- Get count of eligible namespaces
    SELECT COUNT(*) INTO namespace_count FROM eligible_namespaces;

    -- Create an index on the temporary table
    RAISE NOTICE 'Creating index on namespaces temporary table...';
    CREATE INDEX IF NOT EXISTS idx_eligible_namespaces_id ON eligible_namespaces(id);
    RAISE NOTICE 'Namespaces index creation completed';

    RAISE NOTICE 'Created namespaces temporary table with % eligible namespaces in % seconds',
        namespace_count,
        EXTRACT(EPOCH FROM (clock_timestamp() - start_time));

    -- Reset start_time for issues identification
    start_time := clock_timestamp();
    DECLARE
        table_creation_start TIMESTAMP;
        query_execution_time NUMERIC;
    BEGIN
        RAISE NOTICE 'Creating temporary table for issues that need updating...';

        -- Measure just the query execution time
        table_creation_start := clock_timestamp();

        CREATE TEMPORARY TABLE IF NOT EXISTS issues_to_update AS
        SELECT i.id, n.traversal_ids, FALSE as processed
        FROM issues i
        JOIN eligible_namespaces n ON n.id = i.namespace_id
        WHERE i.traversal_ids = '{}'::bigint[];

        query_execution_time := EXTRACT(EPOCH FROM (clock_timestamp() - table_creation_start));
        RAISE NOTICE 'Query execution for issues_to_update table completed in % seconds', query_execution_time;
    END;

    -- Get total count from the temporary table
    SELECT COUNT(*) INTO total_count FROM issues_to_update WHERE processed = false;

    -- Create indices on the issues temporary table with timing
    DECLARE
        index_creation_start TIMESTAMP;
        index_creation_time NUMERIC;
    BEGIN
        RAISE NOTICE 'Creating first index on issues_to_update table...';
        index_creation_start := clock_timestamp();

        CREATE INDEX IF NOT EXISTS idx_issues_to_update_id ON issues_to_update(id);

        index_creation_time := EXTRACT(EPOCH FROM (clock_timestamp() - index_creation_start));
        RAISE NOTICE 'First index creation completed in % seconds', index_creation_time;

        RAISE NOTICE 'Creating second index on issues_to_update table...';
        index_creation_start := clock_timestamp();

        CREATE INDEX IF NOT EXISTS idx_issues_to_update_processed_id ON issues_to_update(processed, id);

        index_creation_time := EXTRACT(EPOCH FROM (clock_timestamp() - index_creation_start));
        RAISE NOTICE 'Second index creation completed in % seconds', index_creation_time;
    END;

    RAISE NOTICE 'Created issues temporary table with % issues to update in % seconds total',
        total_count,
        EXTRACT(EPOCH FROM (clock_timestamp() - start_time));

    -- Initialize start time for processing
    start_time := clock_timestamp();
    batch_start_time := start_time;

    RAISE NOTICE 'Starting to process % records with empty traversal_ids', total_count;

    WHILE NOT done LOOP
        -- Start batch timer
        batch_start_time := clock_timestamp();

        -- Process one batch from the temporary table that hasn't been processed yet
        WITH batch AS (
            SELECT id, traversal_ids
            FROM issues_to_update
            WHERE processed = FALSE
            ORDER BY id
            LIMIT batch_size
        ),
        updated AS (
            UPDATE issues i
            SET traversal_ids = b.traversal_ids
            FROM batch b
            WHERE i.id = b.id
            RETURNING 1
        ),
        mark_processed AS (
            UPDATE issues_to_update
            SET processed = TRUE
            WHERE id IN (SELECT id FROM batch)
        )
        SELECT COUNT(*) INTO batch_count FROM updated;

        -- Calculate batch processing time and rows per second for this batch
        now_time := clock_timestamp();
        elapsed_seconds := EXTRACT(EPOCH FROM (now_time - batch_start_time));

        IF batch_count > 0 THEN
            rows_per_second := ROUND(batch_count / GREATEST(elapsed_seconds, 0.001), 2);
        ELSE
            rows_per_second := 0;
        END IF;

        RAISE NOTICE 'Batch update completed in % seconds - % rows updated (% rows/sec)',
            elapsed_seconds,
            batch_count,
            rows_per_second;

        -- Exit if no rows were updated
        IF batch_count = 0 THEN
            done := TRUE;
        ELSE
            -- Track total processed rows
            total_processed := total_processed + batch_count;

            -- Calculate percentage
            percent_complete := ROUND((total_processed::NUMERIC / total_count) * 100, 2);

            -- Calculate time metrics
            now_time := clock_timestamp();
            elapsed_seconds := EXTRACT(EPOCH FROM (now_time - start_time));

            -- Calculate rows per second based on the total elapsed time
            total_rows_per_second := ROUND(total_processed / GREATEST(elapsed_seconds, 0.001), 2);

            -- Calculate batch processing time for ETA (using moving average)
            IF seconds_per_batch = 0 THEN
                seconds_per_batch := EXTRACT(EPOCH FROM batch_start_time);
            ELSE
                seconds_per_batch := (seconds_per_batch + EXTRACT(EPOCH FROM batch_start_time)) / 2;
            END IF;

            -- Calculate ETA based on both total performance and recent batch performance
            -- For shorter jobs, recent batch performance matters more
            -- For longer jobs, total average performance matters more

            DECLARE
                remaining_rows NUMERIC := total_count - total_processed;
                eta_seconds_batch NUMERIC;
                eta_seconds_overall NUMERIC;
                weight_overall NUMERIC;
            BEGIN
                -- ETA based on recent batch performance
                IF rows_per_second > 0 THEN
                    eta_seconds_batch := remaining_rows / rows_per_second;
                ELSE
                    eta_seconds_batch := remaining_rows; -- Fallback if rows_per_second is 0
                END IF;

                -- ETA based on overall rows per second
                IF total_rows_per_second > 0 THEN
                    eta_seconds_overall := remaining_rows / total_rows_per_second;
                ELSE
                    eta_seconds_overall := eta_seconds_batch; -- Fallback to batch-based ETA
                END IF;

                -- Weighted average of the two ETAs, giving more weight to overall performance as we progress
                weight_overall := LEAST(percent_complete/100, 0.8); -- Cap at 80% weight for overall to avoid extremes
                eta_seconds := (eta_seconds_batch * (1 - weight_overall)) + (eta_seconds_overall * weight_overall);

                -- Apply sanity limits to ETA
                eta_seconds := LEAST(eta_seconds, 86400 * 30); -- Cap at 30 days for display purposes
            END;

            -- Format ETA
            IF eta_seconds < 60 THEN
                eta_text := ROUND(eta_seconds) || ' seconds';
            ELSIF eta_seconds < 3600 THEN
                eta_text := ROUND(eta_seconds / 60) || ' minutes';
            ELSE
                eta_text := ROUND(eta_seconds / 3600, 1) || ' hours';
            END IF;

            -- Report progress
            RAISE NOTICE 'Progress: %/% rows (% percent complete) - % rows/sec overall - ETA: %',
                total_processed,
                total_count,
                percent_complete,
                total_rows_per_second,
                eta_text;
        END IF;

        -- Reset batch start time
        batch_start_time := clock_timestamp();

        -- Commit each batch
        COMMIT;
    END LOOP;

    RAISE NOTICE 'All batches completed, cleaning up...';

    -- Drop temporary tables
    DROP TABLE IF EXISTS issues_to_update;
    DROP TABLE IF EXISTS eligible_namespaces;
    RAISE NOTICE 'Temporary tables dropped';

    -- Calculate total elapsed time
    elapsed_seconds := EXTRACT(EPOCH FROM (clock_timestamp() - start_time));

    -- Calculate final rows per second
    IF total_processed > 0 THEN
        total_rows_per_second := ROUND(total_processed / GREATEST(elapsed_seconds, 0.001), 2);
    ELSE
        total_rows_per_second := 0;
    END IF;

    -- Format completion message
    IF elapsed_seconds < 60 THEN
        RAISE NOTICE 'Update complete. Total rows processed: % in % seconds (% rows/sec)',
            total_processed, ROUND(elapsed_seconds), total_rows_per_second;
    ELSIF elapsed_seconds < 3600 THEN
        RAISE NOTICE 'Update complete. Total rows processed: % in % minutes (% rows/sec)',
            total_processed, ROUND(elapsed_seconds / 60, 1), total_rows_per_second;
    ELSE
        RAISE NOTICE 'Update complete. Total rows processed: % in % hours (% rows/sec)',
            total_processed, ROUND(elapsed_seconds / 3600, 1), total_rows_per_second;
    END IF;
END
$$;
```

</details>

### New queries

There are the following cases to consider for the new queries:

#### User is member of the namespace or an ascendant

When the user is a member of the namespace or an ascendant, we do not need to lookup all namespaces that the user has access to.
We therefore can directly query the `issues` table:

**Querying for a top-level group (`gitlab-org`)**

```sql
SELECT * FROM issues WHERE traversal_ids[1] = 9970
```

<details><summary>[Before](https://explain.depesz.com/s/X4d5#html)</summary>

```sql
WITH "namespace_ids" AS MATERIALIZED (
  SELECT "namespaces"."id"
  FROM (
    (SELECT "namespaces"."id"
     FROM "namespaces"
     WHERE "namespaces"."type" = 'Group'
     AND (traversal_ids @> ('{9970}')))

    UNION ALL

    (SELECT "projects"."project_namespace_id"
     FROM "projects"
     LEFT JOIN project_features ON projects.id = project_features.project_id
     WHERE "projects"."namespace_id" IN (
       SELECT "namespaces"."id"
       FROM UNNEST(
         COALESCE(
           (SELECT ids
            FROM (
              SELECT "namespace_descendants"."self_and_descendant_group_ids" AS ids
              FROM "namespace_descendants"
              WHERE "namespace_descendants"."outdated_at" IS NULL
              AND "namespace_descendants"."namespace_id" = 9970
            ) cached_query),
           (SELECT ids
            FROM (
              SELECT ARRAY_AGG("namespaces"."id") AS ids
              FROM (
                SELECT namespaces.traversal_ids[array_length(namespaces.traversal_ids, 1)] AS id
                FROM "namespaces"
                WHERE "namespaces"."type" = 'Group'
                AND (traversal_ids @> ('{9970}'))
              ) namespaces
            ) consistent_query)
         )
       ) AS namespaces(id)
     )
     AND (
       EXISTS (
         SELECT 1
         FROM "project_authorizations"
         WHERE "project_authorizations"."user_id" = 3509693
         AND (project_authorizations.project_id = projects.id)
         AND (project_authorizations.access_level >= 10)
       )
       OR projects.visibility_level IN (10,20)
     )
     AND (
       "project_features"."issues_access_level" IS NULL
       OR "project_features"."issues_access_level" IN (20,30)
       OR (
         "project_features"."issues_access_level" = 10
         AND EXISTS (
           SELECT 1
           FROM "project_authorizations"
           WHERE "project_authorizations"."user_id" = 3509693
           AND (project_authorizations.project_id = project_features.project_id)
           AND (project_authorizations.access_level >= 10)
         )
       )
     )
    )
  ) namespaces
)

SELECT * FROM "issues"
WHERE (
  NOT EXISTS (
    SELECT 1
    FROM "banned_users"
    WHERE (issues.author_id = banned_users.user_id)
  )
)
AND (issues.namespace_id IN (SELECT id FROM namespace_ids))
AND "issues"."state_id" = 1
ORDER BY "issues"."created_at" DESC, "issues"."id" DESC
LIMIT 101
```

</details>

<details><summary>[Using traversal_ids](https://explain.depesz.com/s/In2U) (only `gitlab-org` backfill)</summary>

```sql
explain (analyze, buffers) SELECT * FROM "issues"
LEFT JOIN project_features ON issues.project_id = project_features.project_id
WHERE (
  NOT EXISTS (
    SELECT 1
    FROM "banned_users"
    WHERE (issues.author_id + 0 = banned_users.user_id)
  )
)
AND issues.traversal_ids[1] = 9970
AND "issues"."state_id" = 1
AND (
  "project_features"."issues_access_level" IS NULL
  OR "project_features"."issues_access_level" IN (20,30)
    OR (
      "project_features"."issues_access_level" = 10
      AND EXISTS (
        SELECT 1
        FROM "project_authorizations"
        WHERE "project_authorizations"."user_id" = 3509693
        AND (project_authorizations.project_id = project_features.project_id)
        AND (project_authorizations.access_level >= 10)
      )
    )
)
ORDER BY "issues"."created_at" DESC, "issues"."id" DESC
LIMIT 101;
```

```
Limit  (cost=1.56..1278.45 rows=101 width=1680) (actual time=0.041..0.641 rows=101 loops=1)
   Buffers: shared hit=928
   ->  Nested Loop Left Join  (cost=1.56..1783895.93 rows=141103 width=1680) (actual time=0.041..0.633 rows=101 loops=1)
         Filter: ((project_features.issues_access_level IS NULL) OR (project_features.issues_access_level = ANY ('{20,30}'::integer[])) OR ((project_features.issues_access_level = 10) AND (hashed SubPlan 2)))
         Buffers: shared hit=928
         ->  Nested Loop Anti Join  (cost=1.00..877482.26 rows=146216 width=1568) (actual time=0.023..0.380 rows=101 loops=1)
               Buffers: shared hit=428
               ->  Index Scan Backward using idx_issues_on_root_namespace_id_and_created_at_and_id on issues  (cost=0.57..740238.80 rows=292431 width=1568) (actual time=0.014..0.185 rows=101 loops=1)
                     Index Cond: (traversal_ids[1] = 9970)
                     Filter: (state_id = 1)
                     Rows Removed by Filter: 35
                     Buffers: shared hit=125
               ->  Index Only Scan using banned_users_pkey on banned_users  (cost=0.43..0.47 rows=1 width=8) (actual time=0.002..0.002 rows=0 loops=101)
                     Index Cond: (user_id = (issues.author_id + 0))
                     Heap Fetches: 0
                     Buffers: shared hit=303
         ->  Index Scan using index_project_features_on_project_id on project_features  (cost=0.56..2.58 rows=1 width=112) (actual time=0.002..0.002 rows=1 loops=101)
               Index Cond: (project_id = issues.project_id)
               Buffers: shared hit=500
         SubPlan 2
           ->  Index Only Scan using project_authorizations_pkey on project_authorizations  (cost=0.58..256.14 rows=9160 width=4) (never executed)
                 Index Cond: ((user_id = 3509693) AND (access_level >= 10))
                 Heap Fetches: 0
 Planning:
   Buffers: shared hit=24
 Planning Time: 0.664 ms
 Execution Time: 0.716 ms
```

</details>

<details><summary>[Using traversal_ids for guest access](https://explain.depesz.com/s/6SV4)</summary>

Guest don't have access to confidential work items, except if they are authors or assignees.

```sql
SELECT * FROM "issues"
LEFT JOIN project_features ON issues.project_id = project_features.project_id
LEFT JOIN issue_assignees ON (issues.id = issue_assignees.issue_id)
WHERE (
  NOT EXISTS (
    SELECT 1
    FROM "banned_users"
    WHERE (issues.author_id + 0 = banned_users.user_id)
  )
)
AND issues.traversal_ids[1] = 9970
AND issues.state_id = 1
AND (
  issues.confidential = false
  OR
  (
    issues.confidential = true AND (issues.author_id = 13585187 OR issue_assignees.user_id = 13585187)
  )
)
AND (
  "project_features"."issues_access_level" IS NULL
  OR "project_features"."issues_access_level" IN (20,30)
    OR (
      "project_features"."issues_access_level" = 10
      AND EXISTS (
        SELECT 1
        FROM "project_authorizations"
        WHERE "project_authorizations"."user_id" = 13585187
        AND (project_authorizations.project_id = project_features.project_id)
        AND (project_authorizations.access_level >= 10)
      )
    )
)
ORDER BY "issues"."created_at" DESC, "issues"."id" DESC
LIMIT 101;
```

```
 Limit  (cost=2.13..1565.71 rows=101 width=1696) (actual time=0.645..50.128 rows=101 loops=1)
   Buffers: shared hit=1399 read=49 dirtied=1
   I/O Timings: shared read=47.210
   ->  Nested Loop Left Join  (cost=2.13..2081937.74 rows=134483 width=1696) (actual time=0.643..50.104 rows=101 loops=1)
         Filter: ((project_features.issues_access_level IS NULL) OR (project_features.issues_access_level = ANY ('{20,30}'::integer[])) OR ((project_features.issues_access_level = 10) AND (hashed SubPlan 2)))
         Buffers: shared hit=1399 read=49 dirtied=1
         I/O Timings: shared read=47.210
         ->  Nested Loop Left Join  (cost=1.56..1218050.19 rows=139356 width=1584) (actual time=0.613..49.471 rows=101 loops=1)
               Filter: ((NOT issues.confidential) OR (issues.confidential AND ((issues.author_id = 13585187) OR (issue_assignees.user_id = 13585187))))
               Rows Removed by Filter: 17
               Buffers: shared hit=904 read=49 dirtied=1
               I/O Timings: shared read=47.210
               ->  Nested Loop Anti Join  (cost=1.00..877482.26 rows=146216 width=1568) (actual time=0.034..4.765 rows=113 loops=1)
                     Buffers: shared hit=476 read=3
                     I/O Timings: shared read=3.829
                     ->  Index Scan Backward using idx_issues_on_root_namespace_id_and_created_at_and_id on issues  (cost=0.57..740238.80 rows=292431 width=1568) (actual time=0.020..0.386 rows=113 loops=1)
                           Index Cond: (traversal_ids[1] = 9970)
                           Filter: (state_id = 1)
                           Rows Removed by Filter: 39
                           Buffers: shared hit=140
                     ->  Index Only Scan using banned_users_pkey on banned_users  (cost=0.43..0.47 rows=1 width=8) (actual time=0.038..0.038 rows=0 loops=113)
                           Index Cond: (user_id = (issues.author_id + 0))
                           Heap Fetches: 0
                           Buffers: shared hit=336 read=3
                           I/O Timings: shared read=3.829
               ->  Index Scan using issue_assignees_pkey on issue_assignees  (cost=0.56..2.31 rows=1 width=16) (actual time=0.394..0.394 rows=0 loops=113)
                     Index Cond: (issue_id = issues.id)
                     Buffers: shared hit=428 read=46 dirtied=1
                     I/O Timings: shared read=43.381
         ->  Index Scan using index_project_features_on_project_id on project_features  (cost=0.56..2.58 rows=1 width=112) (actual time=0.005..0.005 rows=1 loops=101)
               Index Cond: (project_id = issues.project_id)
               Buffers: shared hit=495
         SubPlan 2
           ->  Index Only Scan using project_authorizations_pkey on project_authorizations  (cost=0.58..256.14 rows=9160 width=4) (never executed)
                 Index Cond: ((user_id = 13585187) AND (access_level >= 10))
                 Heap Fetches: 0
 Planning:
   Buffers: shared hit=130 read=40 dirtied=1
   I/O Timings: shared read=52.833
 Planning Time: 58.663 ms
 Execution Time: 50.291 ms
```

</details>

TODO: We still miss the full backfill results. This is in progress on a replica.

**Querying for a sub-group (`gitlab-org/plan-stage`)**

```sql
SELECT * FROM issues WHERE traversal_ids @> ARRAY[9970, 10510295]::bigint[];
```

<details><summary>[Using travresal_ids](https://explain.depesz.com/s/bOy7#html) (only `gitlab-org` backfill)</summary>

```sql
SELECT * FROM "issues"
WHERE (
  NOT EXISTS (
    SELECT 1
    FROM "banned_users"
    WHERE (issues.author_id + 0 = banned_users.user_id)
  )
)
AND traversal_ids @> ARRAY[9970, 10510295]::bigint[]
AND "issues"."state_id" = 1
ORDER BY "issues"."created_at" DESC, "issues"."id" DESC
LIMIT 101;
```

```
Limit  (cost=95.76..95.78 rows=6 width=1568) (actual time=3125.088..3125.116 rows=101 loops=1)
   Buffers: shared hit=5002 read=2791
   I/O Timings: shared read=2970.573
   ->  Sort  (cost=95.76..95.78 rows=6 width=1568) (actual time=3125.086..3125.106 rows=101 loops=1)
         Sort Key: issues.created_at DESC, issues.id DESC
         Sort Method: top-N heapsort  Memory: 101kB
         Buffers: shared hit=5002 read=2791
         I/O Timings: shared read=2970.573
         ->  Nested Loop Anti Join  (cost=33.94..95.69 rows=6 width=1568) (actual time=152.247..3118.722 rows=1498 loops=1)
               Buffers: shared hit=4996 read=2791
               I/O Timings: shared read=2970.573
               ->  Bitmap Heap Scan on issues  (cost=33.51..76.03 rows=11 width=1568) (actual time=151.424..3043.277 rows=1498 loops=1)
                     Recheck Cond: (traversal_ids @> '{9970,10510295}'::bigint[])
                     Filter: (state_id = 1)
                     Rows Removed by Filter: 1749
                     Heap Blocks: exact=2867
                     Buffers: shared hit=577 read=2716
                     I/O Timings: shared read=2920.014
                     ->  Bitmap Index Scan on idx_issues_on_traversal_ids  (cost=0.00..33.51 rows=28 width=0) (actual time=148.797..148.798 rows=3247 loops=1)
                           Index Cond: (traversal_ids @> '{9970,10510295}'::bigint[])
                           Buffers: shared hit=210 read=216
                           I/O Timings: shared read=139.345
               ->  Index Only Scan using banned_users_pkey on banned_users  (cost=0.43..2.08 rows=1 width=8) (actual time=0.045..0.045 rows=0 loops=1498)
                     Index Cond: (user_id = (issues.author_id + 0))
                     Heap Fetches: 0
                     Buffers: shared hit=4419 read=75
                     I/O Timings: shared read=50.559
 Planning:
   Buffers: shared hit=9 read=2
   I/O Timings: shared read=2.459
 Planning Time: 3.078 ms
 Execution Time: 3125.217 ms
```

</details>

#### User is member of a sub-group(s) or project(s)

In this case, we can't just lookup all work items within a hierarchy, but need to filter on namespaces that the user has access to.
Initially it could be enough to keep the existing query we have to find all `namespace_ids` for a user and use the `traversal_ids` filter.

```sql
 WITH "namespace_ids" AS MATERIALIZED (
   -- find all namespace.ids a user has access to based on visibility and project_authorizations
 )
 SELECT * from issues
  WHERE
    traversal_ids[1] = 9970
  AND issues.namespace_id IN (namespace_ids)
```

<details><summary>[Using traversal_ids](https://explain.depesz.com/s/uK14) (only `gitlab-org` backfill)`</summary>

```sql
explain (analyze, buffers) WITH "namespace_ids" AS MATERIALIZED (
  SELECT "namespaces"."id"
  FROM (
    (SELECT "namespaces"."id"
     FROM "namespaces"
     WHERE "namespaces"."type" = 'Group'
     AND (traversal_ids @> ('{9970}')))

    UNION ALL

    (SELECT "projects"."project_namespace_id"
     FROM "projects"
     LEFT JOIN project_features ON projects.id = project_features.project_id
     WHERE "projects"."namespace_id" IN (
       SELECT "namespaces"."id"
       FROM UNNEST(
         COALESCE(
           (SELECT ids
            FROM (
              SELECT "namespace_descendants"."self_and_descendant_group_ids" AS ids
              FROM "namespace_descendants"
              WHERE "namespace_descendants"."outdated_at" IS NULL
              AND "namespace_descendants"."namespace_id" = 9970
            ) cached_query),
           (SELECT ids
            FROM (
              SELECT ARRAY_AGG("namespaces"."id") AS ids
              FROM (
                SELECT namespaces.traversal_ids[array_length(namespaces.traversal_ids, 1)] AS id
                FROM "namespaces"
                WHERE "namespaces"."type" = 'Group'
                AND (traversal_ids @> ('{9970}'))
              ) namespaces
            ) consistent_query)
         )
       ) AS namespaces(id)
     )
     AND (
       EXISTS (
         SELECT 1
         FROM "project_authorizations"
         WHERE "project_authorizations"."user_id" = 13585187
         AND (project_authorizations.project_id = projects.id)
         AND (project_authorizations.access_level >= 10)
       )
       OR projects.visibility_level IN (10,20)
     )
     AND (
       "project_features"."issues_access_level" IS NULL
       OR "project_features"."issues_access_level" IN (20,30)
       OR (
         "project_features"."issues_access_level" = 10
         AND EXISTS (
           SELECT 1
           FROM "project_authorizations"
           WHERE "project_authorizations"."user_id" = 13585187
           AND (project_authorizations.project_id = project_features.project_id)
           AND (project_authorizations.access_level >= 10)
         )
       )
     )
    )
  ) namespaces
)

SELECT * FROM "issues"
WHERE (
  NOT EXISTS (
    SELECT 1
    FROM "banned_users"
    WHERE (issues.author_id + 0 = banned_users.user_id)
  )
)
AND (issues.namespace_id IN (SELECT id FROM namespace_ids))
AND "issues"."state_id" = 1
ORDER BY "issues"."created_at" DESC, "issues"."id" DESC
LIMIT 101
```

```
 Limit  (cost=11411.84..11411.84 rows=1 width=1568) (actual time=920.052..920.085 rows=101 loops=1)
   Buffers: shared hit=20783 read=878
   I/O Timings: shared read=870.415
   CTE namespace_ids
     ->  Append  (cost=45.66..11298.52 rows=1314 width=8) (actual time=17.539..902.706 rows=79 loops=1)
           Buffers: shared hit=12996 read=878
           I/O Timings: shared read=870.415
           ->  Subquery Scan on "*SELECT* 1"  (cost=45.66..121.22 rows=49 width=8) (actual time=17.538..52.444 rows=21 loops=1)
                 Buffers: shared hit=1 read=44
                 I/O Timings: shared read=51.502
                 ->  Bitmap Heap Scan on namespaces  (cost=45.66..120.61 rows=49 width=4) (actual time=17.536..52.418 rows=21 loops=1)
                       Recheck Cond: ((traversal_ids @> '{10510295}'::integer[]) AND ((type)::text = 'Group'::text))
                       Heap Blocks: exact=21
                       Buffers: shared hit=1 read=44
                       I/O Timings: shared read=51.502
                       ->  Bitmap Index Scan on index_namespaces_on_traversal_ids_for_groups  (cost=0.00..45.65 rows=49 width=0) (actual time=14.521..14.521 rows=21 loops=1)
                             Index Cond: (traversal_ids @> '{10510295}'::integer[])
                             Buffers: shared hit=1 read=23
                             I/O Timings: shared read=13.947
           ->  Nested Loop Left Join  (cost=121.86..11170.73 rows=1265 width=8) (actual time=23.725..850.168 rows=58 loops=1)
                 Filter: ((project_features.issues_access_level IS NULL) OR (project_features.issues_access_level = ANY ('{20,30}'::integer[])) OR ((project_features.issues_access_level = 10) AND (hashed SubPlan 4)))
                 Rows Removed by Filter: 2
                 Buffers: shared hit=12995 read=834
                 I/O Timings: shared read=818.913
                 ->  Nested Loop  (cost=121.30..7646.84 rows=814 width=12) (actual time=18.622..417.977 rows=60 loops=1)
                       Buffers: shared hit=199 read=287
                       I/O Timings: shared read=412.141
                       ->  HashAggregate  (cost=120.73..121.22 rows=49 width=28) (actual time=0.540..0.593 rows=21 loops=1)
                             Group Key: namespaces_1.traversal_ids[array_length(namespaces_1.traversal_ids, 1)]
                             Batches: 1  Memory Usage: 24kB
                             Buffers: shared hit=45
                             ->  Bitmap Heap Scan on namespaces namespaces_1  (cost=45.66..120.61 rows=49 width=28) (actual time=0.492..0.528 rows=21 loops=1)
                                   Recheck Cond: ((traversal_ids @> '{10510295}'::integer[]) AND ((type)::text = 'Group'::text))
                                   Heap Blocks: exact=21
                                   Buffers: shared hit=45
                                   ->  Bitmap Index Scan on index_namespaces_on_traversal_ids_for_groups  (cost=0.00..45.65 rows=49 width=0) (actual time=0.480..0.480 rows=21 loops=1)
                                         Index Cond: (traversal_ids @> '{10510295}'::integer[])
                                         Buffers: shared hit=24
                       ->  Index Scan using index_projects_on_namespace_id_and_id on projects  (cost=0.57..153.41 rows=17 width=16) (actual time=7.317..19.865 rows=3 loops=21)
                             Index Cond: (namespace_id = (namespaces_1.traversal_ids)[array_length(namespaces_1.traversal_ids, 1)])
                             Filter: ((SubPlan 1) OR (visibility_level = ANY ('{10,20}'::integer[])))
                             Buffers: shared hit=154 read=287
                             I/O Timings: shared read=412.141
                             SubPlan 1
                               ->  Index Only Scan using index_project_authorizations_on_project_user_access_level on project_authorizations  (cost=0.58..3.60 rows=1 width=0) (actual time=4.237..4.237 rows=1 loops=60)
                                     Index Cond: ((project_id = projects.id) AND (user_id = 3509693) AND (access_level >= 10))
                                     Heap Fetches: 0
                                     Buffers: shared hit=107 read=190
                                     I/O Timings: shared read=251.396
                 ->  Index Scan using index_project_features_on_project_id on project_features  (cost=0.56..0.71 rows=1 width=8) (actual time=3.441..3.441 rows=1 loops=60)
                       Index Cond: (project_id = projects.id)
                       Buffers: shared hit=134 read=166
                       I/O Timings: shared read=204.145
                 SubPlan 4
                   ->  Index Only Scan using project_authorizations_pkey on project_authorizations project_authorizations_1  (cost=0.58..256.14 rows=9160 width=4) (actual time=8.251..216.080 rows=20150 loops=1)
                         Index Cond: ((user_id = 3509693) AND (access_level >= 10))
                         Heap Fetches: 77
                         Buffers: shared hit=12662 read=381
                         I/O Timings: shared read=202.627
   ->  Sort  (cost=113.32..113.33 rows=1 width=1568) (actual time=920.050..920.064 rows=101 loops=1)
         Sort Key: issues.created_at DESC, issues.id DESC
         Sort Method: top-N heapsort  Memory: 101kB
         Buffers: shared hit=20783 read=878
         I/O Timings: shared read=870.415
         ->  Nested Loop Anti Join  (cost=68.00..113.31 rows=1 width=1568) (actual time=910.408..918.617 rows=1498 loops=1)
               Buffers: shared hit=20783 read=878
               I/O Timings: shared read=870.415
               ->  Hash Join  (cost=67.57..110.12 rows=1 width=1568) (actual time=910.381..915.785 rows=1498 loops=1)
                     Hash Cond: (issues.namespace_id = namespace_ids.id)
                     Buffers: shared hit=16289 read=878
                     I/O Timings: shared read=870.415
                     ->  Bitmap Heap Scan on issues  (cost=33.51..76.03 rows=11 width=1568) (actual time=6.861..11.725 rows=1498 loops=1)
                           Recheck Cond: (traversal_ids @> '{9970,10510295}'::bigint[])
                           Filter: (state_id = 1)
                           Rows Removed by Filter: 1749
                           Heap Blocks: exact=2867
                           Buffers: shared hit=3293
                           ->  Bitmap Index Scan on idx_issues_on_traversal_ids  (cost=0.00..33.51 rows=28 width=0) (actual time=6.503..6.504 rows=3247 loops=1)
                                 Index Cond: (traversal_ids @> '{9970,10510295}'::bigint[])
                                 Buffers: shared hit=426
                     ->  Hash  (cost=31.57..31.57 rows=200 width=8) (actual time=903.495..903.496 rows=79 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 12kB
                           Buffers: shared hit=12996 read=878
                           I/O Timings: shared read=870.415
                           ->  HashAggregate  (cost=29.57..31.57 rows=200 width=8) (actual time=903.449..903.464 rows=79 loops=1)
                                 Group Key: namespace_ids.id
                                 Batches: 1  Memory Usage: 40kB
                                 Buffers: shared hit=12996 read=878
                                 I/O Timings: shared read=870.415
                                 ->  CTE Scan on namespace_ids  (cost=0.00..26.28 rows=1314 width=8) (actual time=17.544..903.058 rows=79 loops=1)
                                       Buffers: shared hit=12996 read=878
                                       I/O Timings: shared read=870.415
               ->  Index Only Scan using banned_users_pkey on banned_users  (cost=0.43..2.08 rows=1 width=8) (actual time=0.001..0.001 rows=0 loops=1498)
                     Index Cond: (user_id = (issues.author_id + 0))
                     Heap Fetches: 0
                     Buffers: shared hit=4494
 Planning:
   Buffers: shared hit=1277 read=296
   I/O Timings: shared read=382.085
 Planning Time: 403.961 ms
 Execution Time: 920.688 ms
```

</details>

As a future optimization, we can build the minimum `traversal_ids` for querying `namespaces`.
For example, when a user is a member of `gitlab-org/plan-stage`, we query all work items for `gitlab-org` where the visibility level:

#### User is not a member or signed out

When a user is not a member of any of the namespaces within the hierarchy or signed out, we can filter for all namespaces that are public:

```sql
SELECT * FROM issues
  JOIN namespaces ON (issues.namespace_id = namespaces.id)
  WHERE
    issues.traversal_ids[1] = 9970
    AND namespaces.visibility_level >= 20;
```

<details><summary>[Using traversal_ids](https://explain.depesz.com/s/zA6A)</summary>

```sql
SELECT * FROM "issues"
  JOIN namespaces ON (issues.namespace_id = namespaces.id)
  WHERE (
    NOT EXISTS (
      SELECT 1
      FROM "banned_users"
      WHERE (issues.author_id + 0 = banned_users.user_id)
    )
  )
  AND issues.traversal_ids[1] = 9970
  AND "issues"."state_id" = 1
  AND namespaces.visibility_level >= 20
  ORDER BY "issues"."created_at" DESC, "issues"."id" DESC
LIMIT 101;
```

```
 Limit  (cost=1.56..3237.89 rows=101 width=1962) (actual time=7.019..136.875 rows=101 loops=1)
   Buffers: shared hit=816 read=144
   I/O Timings: shared read=132.727
   ->  Nested Loop  (cost=1.56..1196895.37 rows=37353 width=1962) (actual time=7.017..136.813 rows=101 loops=1)
         Buffers: shared hit=816 read=144
         I/O Timings: shared read=132.727
         ->  Nested Loop Anti Join  (cost=1.00..892068.20 rows=100882 width=1583) (actual time=1.080..76.520 rows=104 loops=1)
               Buffers: shared hit=329 read=111
               I/O Timings: shared read=73.858
               ->  Index Scan Backward using idx_issues_on_root_namespace_id_and_created_at_and_id on issues  (cost=0.57..795435.99 rows=201764 width=1583) (actual time=1.061..75.168 rows=104 loops=1)
                     Index Cond: (traversal_ids[1] = 9970)
                     Filter: (state_id = 1)
                     Rows Removed by Filter: 35
                     Buffers: shared hit=17 read=111
                     I/O Timings: shared read=73.858
               ->  Index Only Scan using banned_users_pkey on banned_users  (cost=0.43..0.48 rows=1 width=8) (actual time=0.009..0.009 rows=0 loops=104)
                     Index Cond: (user_id = (issues.author_id + 0))
                     Heap Fetches: 0
                     Buffers: shared hit=312
         ->  Index Scan using namespaces_pkey on namespaces  (cost=0.57..3.02 rows=1 width=379) (actual time=0.577..0.577 rows=1 loops=104)
               Index Cond: (id = issues.namespace_id)
               Filter: (visibility_level >= 20)
               Rows Removed by Filter: 0
               Buffers: shared hit=487 read=33
               I/O Timings: shared read=58.870
 Planning:
   Buffers: shared hit=24
 Planning Time: 1.260 ms
 Execution Time: 137.024 ms
```

</details>

### Indexes

#### Top-level group index

To support querying work items on large top-level groups and ordering, we're adding a BTREE index on the root of every `traversal_ids`.
This is especially helpful to support all of our sorting options that we offer.

```
CREATE INDEX idx_issues_on_root_namespace_id_and_created_at_and_id ON issues ((traversal_ids[1]), created_at, id);
```

#### Index on traversal_ids

To optimize querying specific sub-groups, we add a GIN index on `traversal_ids`. This is a trade-off to optimize querying for
all work items within that sub-group and being forced to sort in memory sort due to the nature of GIN indexes.

```
CREATE INDEX idx_issues_on_traversal_ids ON issues USING gin (traversal_ids);
```

### Concerns

#### Traversal ID column storage

There is overhead of storing the `traversal_ids`. Based on the size of the backfill on `gitlab-org` we can estimate the total size:

```sql
SELECT
    pg_size_pretty(
        SUM(
            pg_column_size(traversal_ids)
        )
    ) AS filtered_column_size_pretty
FROM
    issues
WHERE
    traversal_ids[1] = 9970;

```

```
filtered_column_size_pretty
-----------------------------
30 MB
```

#### Index storage

The size of the indexes for the backfilled `gitlab-org` column are:

```sql
SELECT
    indexname,
    pg_size_pretty(pg_relation_size(indexname::regclass)) AS index_size
FROM
    pg_indexes
WHERE
    indexname IN ('idx_issues_on_root_namespace_id_and_created_at_and_id', 'idx_issues_on_traversal_ids')
ORDER BY
    pg_relation_size(indexname::regclass) DESC;
```

```
                       indexname                       | index_size |
-------------------------------------------------------+------------|
 idx_issues_on_root_namespace_id_and_created_at_and_id | 4106 MB    |
 idx_issues_on_traversal_ids                           | 125 MB     |
```

#### Index per sorting option

In addition to the BTREE index above that is a compound index on `traversal_ids[1]` and `created_at` for sorting, we are looking to also add an index
for the following sorting options:

-   `updated_at`
-   `closed_at`
-   `state_id`
-   `work_item_type_id`

### Effort of introducing traversal_ids

While the overhead mentioned above are concerns in regards to the storage size of an already large table, there is also the concern to correctly
set the `traversal_ids` on creation and keep the `traversal_ids` in sync when moving issues between projects.

This is a significant investment, but we lack alternatives to keep queries on Postgres performant enough for large hierarchies.
Based on the Security Insights team's rollout, we can [estimate around 3 milestones](https://gitlab.com/groups/gitlab-org/-/epics/12372) for this work. Although most of the time
is waiting for backfill migrations to finish and our required stops to pass.

#### Delay of syncing traversal_ids on move

When moving issues from one namespace to another, we need to update all of the `traversal_ids`. This means that there is a timeframe where issues would not show up as this is done
in a background job. Based on the Workers for updating `vulnerability_reads`, the P95 execution time of these jobs is within an acceptable range (<3 seconds) [[0](https://log.gprd.gitlab.net/app/lens?_g=%28filters%3A%21%28%28%27%24state%27%3A%28store%3AappState%29%2Cmeta%3A%28alias%3A%21n%2Cdisabled%3A%21f%2Cindex%3AAWNABDRwNDuQHTm2tH6l%2Ckey%3Ajson.class%2Cnegate%3A%21f%2Cparams%3A%28query%3A%27Sbom%3A%3ASyncProjectTraversalIdsWorker%27%29%2Ctype%3Aphrase%29%2Cquery%3A%28match_phrase%3A%28json.class%3A%27Sbom%3A%3ASyncProjectTraversalIdsWorker%27%29%29%29%2C%28%27%24state%27%3A%28store%3AappState%29%2Cmeta%3A%28alias%3A%21n%2Cdisabled%3A%21f%2Cindex%3AAWNABDRwNDuQHTm2tH6l%2Ckey%3Ajson.job_status.keyword%2Cnegate%3A%21f%2Cparams%3A%28query%3Adone%29%2Ctype%3Aphrase%29%2Cquery%3A%28match_phrase%3A%28json.job_status.keyword%3Adone%29%29%29%29%2Ctime%3A%28from%3Anow-1w%2Cto%3Anow%29%29#/?_g=h@97e8101)], [1](https://log.gprd.gitlab.net/app/lens?_g=%28filters%3A%21%28%28%27%24state%27%3A%28store%3AappState%29%2Cmeta%3A%28alias%3A%21n%2Cdisabled%3A%21f%2Cindex%3AAWNABDRwNDuQHTm2tH6l%2Ckey%3Ajson.class%2Cnegate%3A%21f%2Cparams%3A%28query%3A%27Vulnerabilities%3A%3AUpdateNamespaceIdsOfVulnerabilityReadsWorker%27%29%2Ctype%3Aphrase%29%2Cquery%3A%28match_phrase%3A%28json.class%3A%27Vulnerabilities%3A%3AUpdateNamespaceIdsOfVulnerabilityReadsWorker%27%29%29%29%2C%28%27%24state%27%3A%28store%3AappState%29%2Cmeta%3A%28alias%3A%21n%2Cdisabled%3A%21f%2Cindex%3AAWNABDRwNDuQHTm2tH6l%2Ckey%3Ajson.job_status.keyword%2Cnegate%3A%21f%2Cparams%3A%28query%3Adone%29%2Ctype%3Aphrase%29%2Cquery%3A%28match_phrase%3A%28json.job_status.keyword%3Adone%29%29%29%29%2Ctime%3A%28from%3Anow-1w%2Cto%3Anow%29%29#/?_g=h@97e8101)]

### Implementation plan

TODO

### Elasticsearch for GitLab.com and SM instances

Elasticsearch is a more suitable database for our use-case and we already denormalized the `traversal_ids` on `issues` there.
With the proposal of [Advanced Finders](https://gitlab.com/gitlab-com/content-sites/handbook/-/merge_requests/12300/) which can use ElasticSearch as a backend, it would be an option for large GitLab instances.

A downside of Elasticsearch though is the time it takes to sync data from Postgres to Elasticsearch. However, there are plans (TODO LINK) to reduce the time to a few seconds.
This could still be an issue as it can impact the user experience - e.g., a user creating a new work item and not seeing it in the list immediately afterwards due to the syncing delay.
