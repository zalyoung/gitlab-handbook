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

To validate the experiment, we copied the `issues` to the `new_issues` table and backfilled `traversal_ids` column on the replica.

### New queries

There are the following cases to consider for the new queries:

#### User is member of the namespace or an ascendant

When the user is a member of the namespace or an ascendant, we do not need to lookup all namespaces that the user has access to.
We therefore can directly query the `issues` table:

**User is reporter+**

```sql
SELECT * FROM "new_issues"
LEFT JOIN project_features ON new_issues.project_id = project_features.project_id
WHERE (
  NOT EXISTS (
    SELECT 1
    FROM "banned_users"
    WHERE (new_issues.author_id + 0 = banned_users.user_id)
  )
)
AND new_issues.traversal_ids[1] = 9970
AND "new_issues"."state_id" = 1
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
ORDER BY "new_issues"."created_at" DESC, "new_issues"."id" DESC
LIMIT 101;
```

-   [Before](https://explain.depesz.com/s/X4d5#html)
-   [Using traversal_ids on gitlab-org](https://explain.depesz.com/s/MO5j#html)
-   [Using traversal_ids on gitlab-com](https://explain.depesz.com/s/Iblp)

</details>

**User is guest**

Guest don't have access to confidential work items, except if they are authors or assignees. So the query is slightly modified and checks for confidentiality as well:

```sql
SELECT * FROM "new_issues"
LEFT JOIN project_features ON new_issues.project_id = project_features.project_id
LEFT JOIN issue_assignees ON (new_issues.id = issue_assignees.issue_id)
WHERE (
  NOT EXISTS (
    SELECT 1
    FROM "banned_users"
    WHERE (new_issues.author_id + 0 = banned_users.user_id)
  )
)
AND new_issues.traversal_ids[1] = 9970
AND new_issues.state_id = 1
AND (
  new_issues.confidential = false
  OR
  (
    new_issues.confidential = true AND (new_issues.author_id = 13585187 OR issue_assignees.user_id = 13585187)
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
ORDER BY "new_issues"."created_at" DESC, "new_issues"."id" DESC
LIMIT 101;
```

-   [Using traversal_ids on gitlab-org](https://explain.depesz.com/s/XppMc)
-   [Using traversal_ids on gitlab-com](https://explain.depesz.com/s/vNAv)

**Querying for a sub-group**

```sql
SELECT * FROM "new_issues"
WHERE (
  NOT EXISTS (
    SELECT 1
    FROM "banned_users"
    WHERE (new_issues.author_id + 0 = banned_users.user_id)
  )
)
AND new_issues.traversal_ids[1] = 9970
AND traversal_ids @> ARRAY[9970, 10510295]::bigint[]
ORDER BY "new_issues"."created_at" DESC, "new_issues"."id" DESC
LIMIT 101;
```

-   [Before](https://explain.depesz.com/s/SgWr)
-   [Using traversal_ids on `gitlab-org/plan-stage`](https://explain.depesz.com/s/ItZB#html)
-   [Using traversal_ids on `gitlab-com/support`](https://explain.depesz.com/s/K73Gx)

#### User is member of a sub-group(s) or project(s)

In this case, we can't just lookup all work items within a hierarchy, but need to filter on namespaces that the user has access to.
To optimze the query, we can use the [Trie Structure](https://docs.gitlab.com/development/namespaces/#search-using-trie-data-structure) and built the minimum amount of
traversal_ids required.

This is hard to replicate as a query, but to see the characteristics of it, I looked up 500 traversal_ids from the hierarchy and filtered `new_issues` based on these `traversal_ids`: https://explain.depesz.com/s/tK0j#html.

#### User is not a member or signed out

When a user is not a member of any of the namespaces within the hierarchy or signed out, we can filter for all namespaces that are public:

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
  AND namespaces.visibility_level >= 20
  ORDER BY "issues"."created_at" DESC, "issues"."id" DESC
LIMIT 101;
```

-   [Using traversal_ids on `gitlab-org`](https://explain.depesz.com/s/4jvp)
-   [Using traversal_ids on `gitlab-com`](https://explain.depesz.com/s/ZTAv)

### Indexes

#### Top-level group index

To support querying work items on large top-level groups and ordering, we're adding a BTREE index on the root of every `traversal_ids`.
This is required to support all of our sorting options that we offer.

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

There is overhead of storing the `traversal_ids`. Based on the size of the backfill on the replica:

```sql
SELECT
    pg_size_pretty(
        (SELECT avg_width FROM pg_stats
         WHERE tablename = 'new_issues' AND attname = 'traversal_ids')::bigint
        * (SELECT reltuples FROM pg_class WHERE relname = 'new_issues')::bigint
    ) AS estimated_column_size;

```

```
estimated_column_size
-----------------------------
4055 MB
```

#### Index storage

The additional storage for the indexes:

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
                       indexname                       | index_size
-------------------------------------------------------+------------
 idx_issues_on_root_namespace_id_and_created_at_and_id | 4112 MB
 idx_issues_on_traversal_ids                           | 805 MB
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

#### Delay of syncing traversal_ids when moving namespaces

When moving issues from one namespace to another, we need to update all of the `traversal_ids`. This means that there is a timeframe where issues would not show up as this is done
in a background job. Based on the Workers for updating `vulnerability_reads`, the P95 execution time of these jobs is within an acceptable range (<3 seconds) [[0](https://log.gprd.gitlab.net/app/lens?_g=%28filters%3A%21%28%28%27%24state%27%3A%28store%3AappState%29%2Cmeta%3A%28alias%3A%21n%2Cdisabled%3A%21f%2Cindex%3AAWNABDRwNDuQHTm2tH6l%2Ckey%3Ajson.class%2Cnegate%3A%21f%2Cparams%3A%28query%3A%27Sbom%3A%3ASyncProjectTraversalIdsWorker%27%29%2Ctype%3Aphrase%29%2Cquery%3A%28match_phrase%3A%28json.class%3A%27Sbom%3A%3ASyncProjectTraversalIdsWorker%27%29%29%29%2C%28%27%24state%27%3A%28store%3AappState%29%2Cmeta%3A%28alias%3A%21n%2Cdisabled%3A%21f%2Cindex%3AAWNABDRwNDuQHTm2tH6l%2Ckey%3Ajson.job_status.keyword%2Cnegate%3A%21f%2Cparams%3A%28query%3Adone%29%2Ctype%3Aphrase%29%2Cquery%3A%28match_phrase%3A%28json.job_status.keyword%3Adone%29%29%29%29%2Ctime%3A%28from%3Anow-1w%2Cto%3Anow%29%29#/?_g=h@97e8101)], [1](https://log.gprd.gitlab.net/app/lens?_g=%28filters%3A%21%28%28%27%24state%27%3A%28store%3AappState%29%2Cmeta%3A%28alias%3A%21n%2Cdisabled%3A%21f%2Cindex%3AAWNABDRwNDuQHTm2tH6l%2Ckey%3Ajson.class%2Cnegate%3A%21f%2Cparams%3A%28query%3A%27Vulnerabilities%3A%3AUpdateNamespaceIdsOfVulnerabilityReadsWorker%27%29%2Ctype%3Aphrase%29%2Cquery%3A%28match_phrase%3A%28json.class%3A%27Vulnerabilities%3A%3AUpdateNamespaceIdsOfVulnerabilityReadsWorker%27%29%29%29%2C%28%27%24state%27%3A%28store%3AappState%29%2Cmeta%3A%28alias%3A%21n%2Cdisabled%3A%21f%2Cindex%3AAWNABDRwNDuQHTm2tH6l%2Ckey%3Ajson.job_status.keyword%2Cnegate%3A%21f%2Cparams%3A%28query%3Adone%29%2Ctype%3Aphrase%29%2Cquery%3A%28match_phrase%3A%28json.job_status.keyword%3Adone%29%29%29%29%2Ctime%3A%28from%3Anow-1w%2Cto%3Anow%29%29#/?_g=h@97e8101)]

### Implementation plan

TODO
