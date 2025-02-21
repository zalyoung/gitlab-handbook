---
title: "Reduce the growth rate of pipeline data"
status: ongoing
creation-date: "2024-05-27"
authors: [ "@fabiopitino", "@mbobin" ]
coach: [ "@fabiopitino", "@grzesiek" ]
approvers: [ "@jreporter", "@cheryl.li" ]
owning-stage: "~devops::verify"
toc_hide: true
---

{{< engineering/design-document-header >}}

## Summary

GitLab's CI/CD system has experienced exponential growth, leading to database storage challenges. Our analysis shows that a large portion of this storage is consumed by redundant configuration data, particularly in job definitions that remain largely unchanged between pipeline runs. This document proposes a refactoring strategy to optimize storage while maintaining system performance and reliability.

## Background

The current CI/CD architecture stores complete copies of job configurations for each pipeline execution. This approach, while simple and reliable, has led to unnecessary database growth as projects scale. The `p_ci_builds_metadata` table has emerged as the primary contributor to this growth, storing duplicate job configurations and variables across pipeline runs. By analyzing usage patterns, we've identified that most projects maintain relatively stable CI configurations, making this an ideal target for optimization.

## Technical Design

### Pipeline Blueprint Architecture

At the core of our optimization strategy is the introduction of a new Pipeline Blueprint model. This model will serve as a central repository for CI/CD configuration data, enabling efficient deduplication while maintaining the flexibility of the current system.
The Pipeline Blueprint will store configuration data that typically remains static across multiple pipeline runs. Its structure is basic, a partitioned table that has many `p_ci_pipelines` rows, composed of the following columns:

```
Ci::PipelineBlueprint
  id: Primary identifier for the blueprint
  partition_id: Enables data partitioning for scale
  project_id: Associates the blueprint with a specific project
  config_file: Stores the consolidated configuration
  config_file_store: Indicates storage location (local/object storage)
  config_file_sha256: Enables deduplication through checksum comparison

Indexes:
  - PRIMARY KEY (id, partition_id)
  - UNIQUE INDEX (project_id, config_file_sha256, partition_id)
```

The unique index on `(project_id, config_file_sha256, partition_id)` ensures that we maintain exactly one blueprint for each unique configuration within a project and partition. This is crucial for our deduplication strategy as it prevents duplicate configurations from being stored and provides an efficient lookup path when linking new pipelines to existing blueprints. The order of the columns is also important because it allows us to use it for queries that lookup rows by project id.

The configuration data stored in `config_file` consolidates information from multiple existing tables:

```json
{
    "<from p_ci_builds.name>": {
        "config_options": "<from p_ci_builds_metadata.config_options OR p_ci_builds.options>",
        "config_variables": "<from p_ci_builds_metadata.config_variables OR p_ci_builds.yaml_variables>",
        "secrets": "<from p_ci_builds_metadata.secrets>",
        "id_tokens": "<from p_ci_builds_metadata.id_tokens>",
        "run_steps": "<from p_ci_builds_execution_configs.run_steps>",
        "coverage_regex": "<from p_ci_builds.coverage_regex>"
    }
}
```

This structure maintains the relationships between our existing data while eliminating redundancy. Each field maps directly to its source in our current schema, making the migration path clearer and maintaining data integrity.

### Data Classification and Lifecycle

Our optimization strategy recognizes that CI/CD data serves different purposes throughout its lifecycle. We've identified three distinct categories of data:

- *Long-term Data* represents the essential history of CI/CD operations. This includes jobs statuses, logs, and artifacts that must be preserved for compliance and historical reference. This data will continue to be stored in our primary tables and only deleted at the user's request.
- *Processing Data* encompasses the configuration and instructions needed for job execution. This data, which includes runner instructions and job configurations, will be stored in our new blueprint system. When a pipeline needs to be retried or referenced, we can efficiently reconstruct its configuration from the blueprint. We must keep the option available to delete this data when a pipeline is no longer retryable.
- *Ephemeral Data* consists of temporary information only needed during pipeline execution, such as job tokens and interruptible configuration. We'll move this data to dedicated tables with automatic cleanup policies, reducing our long-term storage requirements.

### Implementation Strategy

Our implementation approach focuses on maintaining system stability while gradually introducing these optimizations. We'll begin by introducing the Pipeline Blueprint model alongside our existing system. New pipelines will automatically generate and reference blueprints, while a background process will gradually consolidate existing pipeline configurations.

For new pipelines, we'll enhance the `Ci::CreatePipelineService` to generate blueprint configurations. The service will calculate a checksum of the configuration and either create a new blueprint or reference an existing one if the configuration matches. This ensures deduplication without compromising the independence of individual pipelines.

Migration of existing data presents unique challenges due to our historical data formats. Recent jobs store their configuration in the `p_ci_builds_metadata` table as JSON, while older jobs use YAML stored in `p_ci_builds.options` and `p_ci_builds.yaml_variables`. Our migration strategy will handle both formats:

- For recent JSON-based configurations, we'll leverage PostgreSQL's JSON aggregation functions to efficiently consolidate data at the database level. This allows for rapid migration of newer pipelines with minimal application overhead.
- For legacy YAML configurations, we'll need more careful handling at the application level to parse and convert the data correctly. This process will be managed through background jobs to minimize impact on system performance.

### Success Metrics and Monitoring

Success of this optimization will be measured through several key metrics:

- Decreased rate of database growth over time
- Reduce database size by 30%
- Successful migration of existing data with verified integrity

Epic: [Reduce the rate of builds metadata table growth](https://gitlab.com/groups/gitlab-org/-/epics/7434).
