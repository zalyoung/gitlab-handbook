---
title: "Backup and Restore GitLab"
status: ongoing
creation-date: "2024-06-04"
authors: [ "@aakriti.gupta", "@brodock", "@ibaum", "@kyetter" ]
coach: [ ]
approvers: []
owning-stage: ~"devops::data access"
participating-stages: []
toc_hide: true
---

{{< engineering/design-document-header >}}

## Summary

[The Unified Backups project](https://gitlab.com/groups/gitlab-org/-/epics/11577) provides a single command-line tool that will handle the application backup and recovery needs of GitLab installations across supported [reference architectures](https://docs.gitlab.com/ee/administration/reference_architectures/index.html). It will be packaged separately from the main GitLab code base to keep it decoupled from specific release versions but will be shipped along with GitLab releases.

This tool will be aware of the nuances of each runtime environment configuration and it will make adaptations to capture and restore data appropriately. It will stand as the primary recommended solution for most customers going forward.

Development on this tool will focus on providing value to self-hosted customers of GitLab by supporting the variety of installation types and common architectures. For these customers, we will focus on simplifying the disaster recovery process into a common set of recommendations. Additionally, we will work to resolve scalability problems with current backup solutions by supporting the cloud service integration capabilities of large high-usage GitLab instances.

Early development on this tool will focus on the specialized needs of GitLab Cells deployments on GCP for the [Tenant Scale](/handbook/engineering/infrastructure-platforms/tenant-scale/) group.

## Background

### Disaster Recovery

High-usage business-critical applications are vulnerable to a variety of potentially disastrous incidents. Bad actors may exploit security vulnerabilities to hold business data hostage in ransomware attacks. Software bugs may cause massive unexpected data corruption. Cloud providers may experience unexpected outages that inadvertently cause different types of application data to fall out of sync. This is why organizations that run important high-usage applications generally implement disaster recovery (DR) plans. DR plans allow restoring full operation of the target application regardless of whether there is a major failure or a significant mistake in day to day use.

A reliable application data backup is crucial to any disaster recovery plan. A backup captures the state of application data at a particular point in time so that it may be restored at a later time when performing disaster recovery. The captured data is usually stored as a set of one or more files kept in a location that is distinct from the machine where the application typically runs.

### System Administration and Maintenance Purposes

While DR is the primary motivation for creating tooling around backup creation and restoration, we also acknowledge that administrators of self-hosted installations often need to use backup and restoration for configuration and maintenance purposes. The administrator may need to upgrade versions of a crucial component of the system such as PostgreSQL or object storage appliance. In such cases, it is often best to take down their GitLab application temporarily to prevent further updates. Then, the admin may capture a point-in-time backup of their installation. The admin then performs the necessary changes to the system such as upgrading PostgreSQL to a more recent version. When complete, the captured backup data may be restored to ensure GitLab is close to the same state as it was in prior to the maintenance work. Finally, the site may be brought back online for general use again.

Alternatively, an admin may need to migrate their current GitLab production architecture to new infrastructure. For example, an organization may be running a simple GitLab 1K [reference architecture](https://docs.gitlab.com/ee/administration/reference_architectures/index.html) on a single machine the organization manages. However, over time, this organization has usage that has grown beyond the parameters of a simple 1K architecture, and now an admin has been charged with setting up a cloud-based 3K multi-node reference architecture hosted through Amazon Web Services (AWS). This is a common use case for backup and restoration tooling. The admin builds out their 3K deployment on AWS. Then, the admin takes a backup of the running 1K deployment. Finally, the admin restores the backup on the 3K architecture to ensure the organization can seamlessly switch from the small architecture to this new high-usage one.

In this last example, we are indicating how backup tools can facilitate customers to move their GitLab installations to different architectures. However, we need to discuss an important limitation for this use case. We only permit restoring a backup archive on the exact same version number of GitLab upon which the backup was created. We have seen many situations in the past where customers attempt to use GitLab backup tools to transfer their application data between different release versions of GitLab itself. As an example, a customer may have primarily used a version 15.10 installation without managing incremental releases updates over time. Now, the customer wants to jump to a much more recent version like 16.10. That customer may believe they can just use the Rake backup creation task to get a tarball of their older site data, setup a new location with the more recent version of GitLab, and then just use the Rake backup restoration task to populate the newer version installation with the same data. However, our current backup tooling does not support restorations on a different GitLab version than the one under which the backup was created.

Currently, we plan on making the new unified backup tool also uphold this restriction; backup restoration will only take place on the same version of GitLab that created the target backup archive. This is essential to make sure the database schema is exactly in line with what is expected by that version. Otherwise, there may be any degree of bugs and data corruptions that may occur when the code is programmed against a different data schema than what has been restored. We do intend to explore some degree of cross-version restoration support in later iterations of the project.

### Current GitLab Backup Offering

Currently GitLab provides recommendations for [how to create application backups](https://docs.gitlab.com/ee/administration/backup_restore/backup_gitlab.html) across different installation types and different hosting architectures. We provide a fairly rudimentary set of tools to create a point-in-time application backup, as well as specialized documentation for how to handle more complex cloud backup situations. You can read more on [how GitLab backups work here](https://gitlab.com/gitlab-org/gitlab/-/merge_requests/158058).

These are based on [Rake tasks](https://docs.gitlab.com/ee/raketasks/) in the GitLab repository.

#### Drawbacks of the current approach

1. Current Backup Process Is Not Scalable
1. Backups Do Not Support Cloud-Provider Managed Services
1. Rake Tasks Are Not Suitably Maintainable
1. Invocation Differs Between Installation Types and Architectures: Depending on the installation type, the way you invoke the tasks changes. Depending on which reference architecture and whether it's an on-premise or cloud installation, the required option flags and configurations are different. This duplication and divergence makes the knowledge of running backups difficult to transfer between different installation types or different reference architectures.
1. Manual Restoration for Cloud Services: To leverage certain backup features of cloud providers, such as AWS Backup's continuous, point-in-time backup of object storage, you must currently configure it yourself. Even worse, you must also perform restoration manually. GitLab does not provide any tooling to help automate the process.

## Project Goals

With Unified Backups we have the following goals:

- Have a single codebase with all the required logic to backup and restore GitLab Installations
- Create the Unified Backup CLI tool that will:
  - Control backup and restore regardless of architecture or installation type
  - Have a simple interface with self-documented options
  - Have a configuration file where credentials and other stable parameters can be stored
  - Have an optional machine-readable outputs in JSON format
- Support two different Backup formats with a similar UX:
  - Portable Backup
    - Ideal for the smallest reference architectures, 1K and 2K
    - Should work for larger on-premise installations (but may become too slow until depending on nature and quantity of data)
    - Could also be used for cloud-based installations where no managed services is being used
  - Cloud-based Backup
    - Relies solely on the Cloud provider APIs and backup capabilities
    - Support for the major cloud providers like: AWS, GCP and Azure
    - It should not require significant disk-space or permanent storage on the machine/container executing it.
    - It should be simple to extend support for additional cloud providers.
- Support for the following installation types with a consistent UX:
  - Source
  - Linux Package (Omnibus)
  - Docker
  - Kubernetes

### Non-Goals

- This is not a solution for users to backup/export their GitLab.com group or project data
- The Unified Backup CLI will not handle lifecycle management:
  - It will not handle backup retention policies
  - It will not handle backup rotation
  - It will not handle backup scheduling
- The Unified Backup CLI will not accept ENV variables as way to:
  - Provide options
  - Provide configurations
  - Provide credentials
  - Override settings or configurations from dependent tools
- The Unified Backup CLI will not integrate Deployment / Infrastructure functionality:
  - It will not run GET or Terraform
  - It will not make any change to existing infrastructure
  - It will not deploy new infrastructure

## Design and implementation details

### Design Decisions

**A centralized codebase**

By centralizing the codebase into a single project, we aim to simplify the implementation for the permutations of environments and installation types we support. Having everything in a single location makes it easier to test and extend the code.

**A decoupled tool**

There currently are multiple tools used to backup a GitLab instance:

- The [`gitlab:backup` rake tasks](https://gitlab.com/gitlab-org/gitlab/-/blob/master/lib/tasks/gitlab/backup.rake?ref_type=heads) are part of the main rails repository
- When using [`omnibus-gitlab`](https://gitlab.com/gitlab-org/omnibus-gitlab), the `gitlab-backup` is included as a wrapper around the backup Rake tasks.
- The [backup-utility](https://gitlab.com/gitlab-org/build/CNG/-/blob/master/gitlab-toolbox/scripts/bin/backup-utility) is used for backups in Kubernetes enabled environments.
- The new tool ([`gitlab-backup-cli`](https://gitlab.com/gitlab-com/gl-infra/data-access/durability/gitlab-backup-cli)) will be distributed alongside the main GitLab codebase as a standalone CLI.

**Supporting multiple cloud providers**

Adding support to new cloud providers will follow an approach similar to the adapter pattern, where we have a generic business logic on how to backup each data-type, and a specialized version for each cloud provider.

**Installation type based configuration handling**

To support the differences in each installation type, a wrapper may be used which provides the tool with the necessary information about the environment it is running on.

**Differentiating between Portable and Cloud Backups**

The clear separation between Portable and Cloud backups aims at simplifying the implementation, and allows for specific strategies to be explored in the future to take consistent backups without downtime.

The main difference between the two is that Portable backups are stored locally. Both styles of backups allow mixed data storage, e.g. application data split between local and cloud storage.

**Consistency in backups**

Consistent backups can be taken during downtime.

Online Consistent Backups will be explored through [epic 12043](https://gitlab.com/groups/gitlab-org/-/epics/12043).

**Integrating with the Unified Backup CLI**

In order to make the tool easy to integrate with external tools, we will provide optional machine-readable output in JSON format.

### Limitations

- We don't support the data in a Cloud-based Backup to be exportable to a Portable Backup format or vice-versa.
- We do not support backing up data in the cache store (Redis) which includes the [Sidekiq state](https://docs.gitlab.com/ee/administration/backup_restore/backup_gitlab.html#other-data). TODO: [More research on Redis stored data](https://gitlab.com/gitlab-org/gitlab/-/issues/466000)

### Backup Types

We provide two different approaches to create a Backup: Portable and Cloud-based.

#### Portable Backup

A Portable Backup behaves similar to the existing Rake-task approach. It relies on direct access to data-types and dependent services. It is the most compatible solution, as it does not rely on Cloud specific functionality.

A Portable Backup could be executed in all supported installation types and works on both physical and virtual machines.

With Portable Backup, the data is transferred to the machine running the backup context, stored and compressed in a specific location. A metadata file is created and the final archive can be stored locally or in a remote location (including in an Object Storage Bucket).

Each data type can be backed up in sequence or in parallel. Similarly, each one can be restored in sequence or in parallel.

Multiple Backups can be executed simultaneously, without one overwriting the other. (This is intended to support executing a backup from a cron job)

Backing up the database works the same, and require no additional configuration, no matter if using Omnibus-managed database, Patroni, an externally managed instance or whether PgBouncer is enabled.

[Future work](#future-iterations) will look into improving the consistency of Portable Backups without downtime, which may rely on using specific file-systems that can provide snapshotting capabilities.

Portable Backups have inherent limitations in scale, depending on the infrastructure, the data, and DR needs.

#### Cloud-based Backup

A Cloud-based Backup relies entirely on a Cloud Provider specific APIs and Services to perform and store the data. It is triggered by the CLI tool which orchestrates the required API calls.

Each time a Backup is started, a JSON file containing the necessary information (Backup Metadata) to find each data type is stored in the Backup Bucket, under the same prefix used to store existing Blobs.

The Backup Metadata will be used as the SSOT to specify what data is part of a Backup. In order to list or process a Backup, the tool will fetch the JSON files from the Backup Bucket. Based on the IDS and references stored there, the tool will be able to execute the restore-actions in the Cloud Provider API.

As we rely on the Backup Metadata, we primarily support listing and restoring data that was created by triggering the Unified Backup tool. This gives us the control and the foundation to build the necessary features and improvements for a Consistent Backup.

The tool will *not* rely on Cloud Provider specific scheduled backups functionality. To achieve regular scheduled backups, the tool will need to be invoked by an external service like a Cronjob.

Multiple backups may be supported to run simultaneously (unless there is a specific Cloud Provider limitation). A backup could include all supported data-types or specific ones only.

For each supported Cloud Provider, specific capabilities may be available, but we will support at least the following for each data-type:

- Databases:
  - On-Demand Database Backup or Snapshot
- Blobs in Object Storage
  - A copy of all Blobs in a new Backup Bucket
- Git repositories
  - A disk snapshot for all running Gitaly instances (Gitaly Cluster is not supported)

As Gitaly releases its planned new backup related functionality we will evaluate integrating them.

See [#future-iterations] for information regarding scheduling backups.

##### Google Cloud Platform

For GitLab installations hosted on Google Cloud Platform (GCP) we will support the following application data types
and their corresponding backup mechanism:

| Data Type               | GCP Service Component                | GCP backup mechanism                                            |
|-------------------------|--------------------------------------|-----------------------------------------------------------------|
| PostgreSQL Databases    | Cloud SQL for PostgreSQL             | On-demand database snapshots                                    |
| Blob/Files              | Cloud Storage (Object Storage)       | On-demand regional data transfer using Storage Transfer Service |
| Repositories            | Compute Engine with Persistent disks | On-demand disk snapshots                                        |

As we proceed with the implementation we will consider implementation details on how to use their APIs, including the differences between synchronous and asynchronous operations, support for Batching / Parallelization, Cloud Logging the use of Pub/Sub notifications, etc.

###### Cloud SQL for Postgres (Backup)

Cloud SQL supports the following methods to perform a Backup:

- [Automated (scheduled)](https://cloud.google.com/sql/docs/postgres/backup-recovery/backups#automated-backups)
  - Can be scheduled to a specific starting time (execution happens with a 4 hour window)
  - [Retention of automated backups](https://cloud.google.com/sql/docs/postgres/backup-recovery/backups#what_backups_cost):
    - **Cloud SQL Enterprise edition**: Minimum 7 units (usually days) max: 365 units
    - **Cloud SQL Enterprise Plus edition**: Minimum 15 units (usually days) max: 365 units
  - [Retention of WAL logs](https://cloud.google.com/sql/docs/postgres/backup-recovery/backups#retention)
    - **Cloud SQL Enterprise edition**: From 1 to 7 days (default: 7 days)
    - **Cloud SQL Enterprise Plus edition**: From 1 to 35 days (default: 35 days)
    - WAL logs can be stored on disk in the same instance or in Cloud Storage
- [On-Demand Backups](https://cloud.google.com/sql/docs/postgres/backup-recovery/backups)
  - Are not automatically deleted (can be stored for long time)

We will provide initial Backup support relying on On-Demand Backups to support long-term retention periods.

During the implementation phase we will investigate how to support and expose additional options like:

- Ability to choose a custom region to store Backups (default: same region as the instance)
- Ability to customize Automated Backup retention policy (normally managed by Terraform or as part of instance configuration)

###### Cloud SQL for Postgres (Restore)

Initial Restore support will be based on On-Demand Backups. We will rely on the IDs stored as part of the Backup Metadata file read from the Backup Bucket.

During the implementation phase we will investigate how to support and expose additional options like:

- Ability to use [Point In Time Recovery](https://cloud.google.com/sql/docs/postgres/backup-recovery/restore#tips-pitr) based on Automated Backups WAL logs (when in range)
- Restore Backup in a different instance then the current being used (we will not handle instance provisioning)
- How to expose the information necessary for data be restored as part of an external infrastructure integration (E.g. provide data for a Terraform script to create a new deployment)

###### Blobs

*Backup*

GCP backups currently use [the Storage Transfer Service](https://cloud.google.com/storage-transfer/docs/overview).
Storage Transfer Service jobs are created that copy from the individual buckets (Uploads, LFS, etc) to one bucket, under the path `/backups/$BACKUP_ID/$TARGET`.

*Restore*

- Restores should create Storage Transfer Service jobs that copy from the backup bucket path, to the individual buckets.
- We will not create or configure the buckets, that is out of scope for the tool.
- We (probably) should not empty the buckets first. Leave that up to the users to do if they want to.
- So at its most basic, a user would run something like `gitlab-backup-cli restore all $BACKUP_ID`, and the tool would create the necessary jobs to copy data from the backup bucket path, to the individual buckets, then monitor them for success/failure.

## Milestones

### 1st Milestone: Implement Cloud Backups: support 50k CNH reference architecture on GCP for Cells

The first milestone will target [Cells deployments](/handbook/engineering/architecture/design-documents/cells/#will-cells-use-the-reference-architecture-for-up-to-1000-rps-or-50000-users) that use the [50k reference architecture](https://docs.gitlab.com/administration/reference_architectures/50k_users/).

For the initial Cloud Backup implementation:

- Google Cloud Provider only (other Cloud Providers will be added at a later stage)
  - Database Backups using [Cloud SQL Backups](https://cloud.google.com/sql/docs/postgres/backup-recovery/backups) (on demand backups only, initially)
  - Object Storage Backups using [Storage Transfer Service](https://cloud.google.com/storage-transfer-service?hl=en)
  - [GCE disk snapshots](https://cloud.google.com/compute/docs/disks/snapshots) initially for repository backups.
- Only support data/snapshots managed by the Backup tool
- [Kubernetes Cronjob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) functionality to provide scheduled executions.
- Not relying on automated/scheduled Backup implementation (like AWS Backup or Google Cloud Backup)

In this iteration we are NOT aiming to solve backup consistency until we have PITR for Gitaly:

- When backing up the multiple components, what is in the database may point to something that was removed before it could have been included in the backup
- The Cloud Providers may not provide a reliable way to match each data to a specific point-in-time (that could be used to synchronize with the database snapshot)

### 2nd Milestone: Create backup CLI: support 1K Linux package reference architecture for portable backups

- Standalone tool that can be used as a replacement for current rake task.
- Targeting Linux based installations
  - [Package based](https://about.gitlab.com/install/#official-linux-package)
  - [Source based](https://docs.gitlab.com/install/installation/)
- Behaves similar to the existing backup Rake tool, with a small feature-set

## Future iterations

Investigate integration with continuous database backup (WAL log based) with a rollback to point-in-time as a Restore mechanism. Each cloud provide may implement this in different ways, with different retention policies.

We haven't planned yet any integration with AWS Backup or equivalent, but this is something we will revisit in the future.

Improvements to the Portable Backup:

- [Scalable Database solution](https://gitlab.com/gitlab-org/gitlab/-/issues/458382)
- [Encryption at Rest (relying on .7z format)](https://gitlab.com/gitlab-org/gitlab/-/issues/470570)
- [File-system snapshot support](https://gitlab.com/gitlab-org/gitlab/-/issues/428520)
- Integrated GitLab configuration files and on-disk secrets in separate backup archive

Backup Management solution, that will be composed of:

- A Web UI (decoupled from the main application)
- A REST API to control and manage Backup/Restore related operations
- Observability over Disaster Recovery operation
- Additional Service Orchestration (possible integration with GET)
- Backup Lifecycle management (as e.g.):
  - Backup retention policies
  - Backup execution policies
  - Optional granularity for different types of data
  - Notifications
- Support for both Portable and Cloud-Based backups

## User Journeys

### Backup Management

#### Backup Operations

As an SRE, I want to initiate a full backup of my GitLab instance so that I can create a complete point-in-time snapshot of all data.

*Acceptance Criteria:*

- Backup includes all GitLab repositories, database, and blob storage objects
- Backup process doesn't require GitLab downtime
- Progress indicator shows backup status
- Backup completion generates a manifest file listing all included components

As an SRE, I want to be able to verify backup integrity after a backup completes so that I can ensure the backup is usable for restoration.

*Acceptance Criteria:*

- Performs validation on all backup components
- Tests that backup files can be opened/read
- Validates backup manifest against actual backed-up data
- Reports any corruption or missing components

#### Restore Operations

As an SRE, I want to restore my GitLab instance to a specific backup point so that I can recover from data loss or corruption.

*Acceptance Criteria:*

- Can select a specific backup point to restore from
- Restore process validates target environment compatibility
- Provides option for test restore to separate environment
- Displays clear warnings about data that will be overwritten

As an SRE, I want to perform a partial restore of specific GitLab components so that I can recover individual components (database, LFS, etc) without affecting the entire instance.

*Acceptance Criteria:*

- Can select specific component(s) to restore
- Restore process does not impact other components which were not included in the restore

#### Configuration and Setup

As an SRE, I want to configure backup storage destinations so that I can store backups in my organization's preferred storage system.

*Acceptance Criteria:*

- Supports multiple storage backends (local filesystem, S3, NFS, etc.)
- Can configure encryption for backups at rest
- Validates storage connectivity and permissions during setup
- Supports backup retention policies with automatic cleanup

### Monitoring and Alerting

As an SRE, I want to receive alerts when backup operations fail so that I can quickly respond to protect my GitLab instance.

*Acceptance Criteria:*

- Alert includes failure reason, affected components, and suggested remediation steps
- Integrates with existing monitoring infrastructure (Prometheus, Grafana, etc.)

As an SRE, I want to monitor backup operation performance metrics so that I can optimize backup windows and resource allocation.

*Acceptance Criteria:*

- Tracks backup duration, data volume, and throughput rates

As an SRE, I want to monitor backup storage utilization so that I can manage capacity and costs effectively.

*Acceptance Criteria:*

- Displays current storage usage across all backup destinations
- Tracks cost metrics for cloud storage backends

### Observability and Reporting

As an SRE, I want comprehensive logging of all backup and restore operations so that I can troubleshoot issues and maintain audit trails.

*Acceptance Criteria:*

- Logs all operations with timestamps, user context, and operation details
- Supports structured logging formats (JSON) for log aggregation tools
- Includes correlation IDs to trace operations across distributed components
- Configurable log retention and log level settings

As an SRE, I want a dashboard showing the health status of my backup system so that I can quickly assess backup coverage and identify issues.

*Acceptance Criteria:*

- Shows last successful backup time and next scheduled backup
- Displays backup success/failure rates over time
- Indicates which GitLab components are covered by recent backups
- Provides quick access to recent logs and error details

As an SRE, I want to generate backup compliance reports so that I can demonstrate adherence to organizational data protection policies.

*Acceptance Criteria:*

- Generates reports showing backup frequency, retention compliance, and coverage
- Exports reports in multiple formats (PDF, CSV, JSON)
- Includes verification status and any gaps in backup coverage
- Supports custom reporting periods and filtering criteria

### Integration and Metrics

As an SRE, I want the backup tool to expose metrics that I can integrate with my existing monitoring stack.

*Acceptance Criteria:*

- Exposes standard backup metrics (success rate, duration, data size)
- Includes custom metrics relevant to GitLab backup operations
- Supports metric labeling for multi-instance deployments
- Provides health check endpoint for monitoring system integration

As an SRE, I want to track backup operation impact on GitLab performance so that I can optimize backup scheduling.

*Acceptance Criteria:*

- Monitors GitLab response times during backup operations
- Tracks database connection usage and query performance impact
- Measures effect on GitLab's resource utilization
- Provides recommendations for optimal backup timing

### Data Protection and Encryption

As an SRE, I want all backup data encrypted at rest so that sensitive GitLab data remains protected even if backup storage is compromised.

*Acceptance Criteria:*

- Supports industry-standard encryption algorithms (AES-256)
- Allows configuration of customer-managed encryption keys
- Encrypts all backup components including metadata and manifests
- Provides key rotation capabilities without requiring full re-backup

As an SRE, I want backup data encrypted in transit so that data remains secure during transfer to backup storage.

*Acceptance Criteria:*

- Allows for TLS/SSL for all network communications to backup destinations
- Supports mutual TLS authentication for enhanced security
- Validates certificate chains and rejects invalid certificates
- Configurable cipher suites to meet organizational security policies

As an SRE, I want to manage encryption keys securely so that I can maintain control over backup data access without exposing sensitive key material.

*Acceptance Criteria:*

- Integrates with external key management systems (HashiCorp Vault, AWS KMS, etc.)
- Supports key escrow and recovery procedures
- Prevents backup operations if encryption keys are unavailable
- Logs all key access and usage for audit purposes

### Access Control and Authentication

As an SRE, I want role-based access control for backup operations so that only authorized personnel can perform backup and restore functions.

*Acceptance Criteria:*

- Supports integration with enterprise identity providers (LDAP, SAML, OAuth)
- Allows granular permissions (backup-only, restore-only, full-access)
- Enforces multi-factor authentication for restore operations
- Maintains session management with configurable timeout policies

As an SRE, I want all backup tool access attempts logged so that I can detect unauthorized access and maintain security audit trails.

*Acceptance Criteria:*

- Records user actions with timestamps and source IP addresses
- Supports tamper-evident log storage and integrity verification

### Compliance and Audit

As an SRE, I want backup operations to maintain data lineage and custody records so that I can demonstrate compliance with data governance requirements.

*Acceptance Criteria:*

- Records who initiated each backup/restore operation and when
- Tracks data movement between systems and storage locations
- Maintains chain of custody documentation for forensic purposes
- Supports legal hold procedures that prevent backup deletion

As an SRE, I want backup retention policies that automatically enforce compliance requirements so that I can meet regulatory obligations without manual intervention.

*Acceptance Criteria:*

- Configurable retention periods based on data classification
- Prevents deletion of backups under legal hold
- Automatically purges expired backups according to policy
- Generates compliance reports showing retention adherence

As an SRE, I want backup operations to respect data residency requirements so that sensitive data remains within required geographic boundaries.

*Acceptance Criteria:*

- Allows configuration of storage location constraints
- Validates backup destination compliance with data residency rules
- Prevents backup operations that would violate geographic restrictions
- Provides documentation of data location for compliance audits

### Data Integrity and Validation

As an SRE, I want cryptographic verification of backup integrity so that I can detect any tampering or corruption of backup data.

*Acceptance Criteria:*

- Generates and stores cryptographic hashes for all backup files
- Can perform integrity checks on stored backups
- Alerts immediately if backup corruption is detected

As an SRE, I want secure backup verification processes so that restore testing doesn't expose sensitive data in non-production environments.

*Acceptance Criteria:*

- Supports data masking during verification restore operations
- Provides isolated verification environments with restricted access
- Automatically cleanses sensitive data from verification logs
- Validates restore functionality without compromising data security

### Incident Response and Forensics

As an SRE, I want immutable backup copies for forensic analysis so that I can investigate security incidents without risking evidence tampering.

*Acceptance Criteria:*

- Creates write-once, read-many backup copies for critical incidents
- Maintains separate forensic backup chain isolated from operational backups
- Provides timestamped evidence collection with digital signatures
- Supports secure transfer of forensic data to investigation teams

### Infrastructure Integration

As an SRE, I want the backup tool to integrate with my platform so that I can deploy and manage it alongside my existing GitLab infrastructure.

*Acceptance Criteria:*

- Supports deployment on the same platforms that GitLab self managed is supported

As an SRE, I want the backup tool to work with my existing storage infrastructure so that I can leverage current investments and operational procedures.

*Acceptance Criteria:*

- Supports multiple storage backends (NFS, S3, Azure Blob, GCS)
- Integrates with storage classes and volume provisioning in Kubernetes
- Respects existing storage quotas, policies, and access controls

As an SRE, I want the backup tool to integrate with my CI/CD pipelines so that I can automate backup operations as part of deployment workflows.

*Acceptance Criteria:*

- Provides CLI interface for scripting and automation
- Supports pre/post deployment backup triggers
- Returns appropriate exit codes for pipeline decision making
- Integrates with GitLab CI, Jenkins, GitHub Actions, and other CI systems

### Monitoring Stack Integration

As an SRE, I want the backup tool to integrate with my existing monitoring and alerting infrastructure so that I can manage all alerts through consistent channels.

*Acceptance Criteria:*

- Supports multiple monitoring backends (Prometheus, InfluxDB, DataDog, New Relic)
- Integrates with existing alerting rules and notification channels
- Supports custom metric labels and dimensions for multi-tenant environments

As an SRE, I want backup tool logs to integrate with my centralized logging system so that I can correlate backup events with other system activities.

*Acceptance Criteria:*

- Supports log forwarding to common log aggregation systems (ELK, Splunk, Fluentd)
- Provides structured logging with consistent field naming
- Includes correlation IDs that link to GitLab operation logs
- Supports log filtering and routing based on severity and component

### Configuration Management Integration

As an SRE, I want to manage backup tool configuration through my existing configuration management system so that I can maintain consistency across environments.

*Acceptance Criteria:*

- Supports configuration using environment variables, config files, and command-line arguments
- Integrates with configuration management tools (Ansible, Terraform, Puppet, Chef)
- Provides configuration validation and drift detection
- Supports GitOps workflows with configuration stored in version control

As an SRE, I want the backup tool to integrate with my secrets management system so that sensitive configuration data remains secure and centrally managed.

*Acceptance Criteria:*

- Integrates with secrets management platforms (HashiCorp Vault, AWS Secrets Manager, Kubernetes Secrets)
- Supports automatic secret rotation without service interruption
- Provides secure credential injection at runtime
- Never logs or exposes sensitive configuration values

### Network and Service Integration

As an SRE, I want the backup tool to work within my network security policies so that it doesn't compromise my security posture.

*Acceptance Criteria:*

- Supports network segmentation and firewall policies
- Respects network policies in Kubernetes environments
- Supports proxy configurations for outbound connections

As an SRE, I want the backup tool to integrate with my service discovery system so that it can automatically locate GitLab components across distributed deployments.

*Acceptance Criteria:*

- Integrates with service discovery platforms (Consul, etcd, Kubernetes DNS)
- Automatically discovers GitLab services and their health status
- Adapts to service topology changes without manual reconfiguration
- Supports multi-region and multi-cluster GitLab deployments

### Disaster Recovery Integration

As an SRE, I want the backup tool to integrate with my disaster recovery orchestration so that GitLab recovery can be automated as part of broader DR procedures.

*Acceptance Criteria:*

- Provides APIs for DR orchestration tools to trigger restore operations
- Supports dependency ordering for complex multi-service recovery
- Integrates with infrastructure provisioning tools for DR site preparation
- Provides status reporting for DR runbook automation

As an SRE, I want backup replication to integrate with my multi-site infrastructure so that I can maintain geographically distributed backup copies.

*Acceptance Criteria:*

- Supports cross-region backup replication with configurable policies
- Integrates with WAN optimization and bandwidth management tools
- Respects data sovereignty and compliance requirements across regions
- Provides conflict resolution for distributed backup management

## Cloud Backups: support 50k CNH reference architecture on GCP for Cells

In [Cells ADR 013](/handbook/engineering/architecture/design-documents/cells/decisions/013_cell_restore_from_backup/)
it was decided that we would restore into a new Cell with the same Cell ID, but a different Tenant ID.
