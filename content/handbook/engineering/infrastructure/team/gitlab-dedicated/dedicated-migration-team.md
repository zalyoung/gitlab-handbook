---
title: Dedicated Migration Team
---


## The Team

The Dedicate migration team is a team focussed on performing migrations into GitLab Dedicated. This is achieved using either [Geo](https://docs.gitlab.com/administration/geo/) or [Congregate](https://gitlab.com/gitlab-org/professional-services-automation/tools/migration/congregate).

### Team members

| Name | Role |
|---   | -----|
|Muhamed Huseinbašić|  Senior Site Reliability Engineer | 
|Dave Dittman|         Site Reliability Engineer        |
|Sophia Langer|        Project Manager |
|Eddie Yoffe|          Program Manager |
|Oliver Seldman|       Program Manager |
|Eren Ekca|            Senior Technical Architect |
|Saurav Issar|         Senior Technical Architect |
|Petar Prokić|         Senior Engineer|
|Jessykah Bird |       Engineer |
|Jordan Ng |           Engineer |          
|Alex Rosencrans|      Engineer |
|Scott Murray|         Engineer |
|Douglas Alexandre|    Staff Engineer|
|Sampath Ranasinghe|   Senior Product Manager|
|Akanksha Joshi|      Senior Technical Program Manager|

## Mission

Successfully manage incoming migrations through FY26Q2 and FY26Q3 and establish a repeatable process for both Geo and Congregate migrations with a SSOT.

## Resources

- [GitLab group](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group)
- [GitLab project](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/dedicated-migrations)
- [Migrating Customers to Dedicated internal documentation](https://internal.gitlab.com/handbook/engineering/dedicated/migrating-customers-to-dedicated/)
- [Cutover Cancellation Impact](https://drive.google.com/drive/folders/12GInLFxnT5BPbPJh1JsemUE089-Ctj0e) 
    
## Process

### Geo Migrations

This section covers the logical groupings and worst-case time estimates for each phase. Linked are the templates that describe each task in the automation project.

## KickOff (1 business day)

Initial project kickoff and setup activities.

## Platform Discovery & Setup (35 business days)

### [Tech Discovery](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/tree/main/.gitlab/issue_templates/geo/tech_discovery) (DRI: Technical Architect)
- [ ] [Receive Primary Secondary Region Info](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/receive_primary_secondary_region_info_template.md)
- [ ] [Receive Primary Secondary Private Link Availability Info](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/receive_primary_secondary_pvt_lnk_availability_info_template.md)
- [ ] [Receive BYOD Info](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/receive_byod_info_template.md)
- [ ] [Receive Gitaly Storage Configuration](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/receive_gitaly_storage_configuration_template.md)
- [ ] [Receive SMTP Settings](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/receive_smtp_settings_template.md)
- [ ] [Share Sample Test Plan](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/share_sample_test_plan_template.md)
- [ ] [Share Initial Cutover Plan](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/share_initial_cutover_plan_template.md)
- [ ] [Send Switchboard Invite](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/send_switchboard_invite_template.md)
- [ ] [Receive Secrets and SSH Keys](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/receive_secrets_and_ssh_keys_template.md)


## Configuration (45 business days)

### [Dedicated Instance Provisioning](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/tree/main/.gitlab/issue_templates/geo/dedicated_instance_provisioning) (DRI: EA Engineer)
- [ ] [Receive BYOK](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/dedicated_instance_provisioning/receive_byok_template.md) (DRI: Technical Architect)
- [ ] [Provision PreProd Instance](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/dedicated_instance_provisioning/provision_preprod_instance_template.md)
- [ ] [Provision Prod Instance](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/dedicated_instance_provisioning/provision_prod_instance_template.md)
- [ ] [Configure Gitaly Storage Mappings](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/dedicated_instance_provisioning/configure_gitaly_storage_mappings_template.md)
- [ ] [Provision Grafana OpenSearch Access for Migration Team](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/dedicated_instance_provisioning/provision_grafana_opensearch_access_for_migration_team_template.md)
- [ ] [Setup Inbound Private Link for PreProd](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/dedicated_instance_provisioning/setup_inbound_private_link_for_preprod_template.md)
- [ ] [Setup Inbound Private Link for Prod](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/dedicated_instance_provisioning/setup_inbound_private_link_for_prod_template.md)
- [ ] [Setup Outbound Private Link for PreProd](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/dedicated_instance_provisioning/setup_outbound_private_link_for_preprod_template.md)
- [ ] [Setup Outbound Private Link for Prod](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/dedicated_instance_provisioning/setup_outbound_private_link_for_prod_template.md)
- [ ] [Send Switchboard Invite](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/dedicated_instance_provisioning/send_switchboard_invite_template.md)
### [SM Instance Prep](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/tree/main/.gitlab/issue_templates/geo/sm_instance_prep) (DRI: Technical Architect)
- [ ] [Move Files to Object Storage](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/sm_instance_prep/move_files_to_object_storage_template.md)
- [ ] [Set Up Monitoring on SM Instance](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/sm_instance_prep/set_up_monitoring_on_sm_instance_template.md)
- [ ] [Provision Prod DB Read Replica](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/sm_instance_prep/provision_prod_db_read_replica_template.md)
- [ ] [Provision PreProd DB Read Replica](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/sm_instance_prep/provision_preprod_db_read_replica_template.md)
- [ ] [Configure Gitaly Storage Mappings](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/sm_instance_prep/configure_gitaly_storage_mappings_template.md)
- [ ] [Configure SM Instance as Geo Primary](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/sm_instance_prep/configure_sm_instance_as_geo_primary_template.md)
- [ ] [Increase Geo Reverification Interval](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/sm_instance_prep/increase_geo_reverification_interval_template.md)

## Data Sanitization (40 business days)

### [Data Sanitization](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/tree/main/.gitlab/issue_templates/geo/data_sanitization) (DRI: Geo Engineer)
- [ ] [Data Verification Error Troubleshooting](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/data_sanitization/data_verification_error_troubleshooting_template.md)

## Data Synchronization (10 business days)

### [Geo Sync](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/tree/main/.gitlab/issue_templates/geo/geo_sync) (DRI: Geo Engineer)
- [ ] [Configure PreProd for Geo Sync](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/geo_sync/configure_preprod_for_geo_sync_template.md)
- [ ] [Configure Prod for Geo Sync](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/geo_sync/configure_prod_for_geo_sync_template.md)
- [ ] [Geo Sync Error Troubleshooting](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/geo_sync/geo_sync_error_troubleshooting_template.md)
- [ ] [Finalize Cutover Plan](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/geo_sync/finalize_cutover_plan_template.md)

## Pre Prod Cut Over & Testing (30 business days)

### [PreProd Cutover](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/tree/main/.gitlab/issue_templates/geo/preprod_cutover) (DRI: EA Engineer)
- [ ] [PreProd Testing](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/preprod_cutover/preprod_testing_template.md)

## Go-Live - Prod Cutover & Post Cutover Support (15 business days)

### [Prod Cutover](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/tree/main/.gitlab/issue_templates/geo/prod_cutover) (DRI: EA Engineer)
- [ ] [Post Cutover Dedicated Instance Upgrades](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/prod_cutover/post_cutover_dedicated_instance_upgrades_template.md)

### [Post Cutover](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/tree/main/.gitlab/issue_templates/geo/post_cutover) (DRI: EA Engineer)
- [ ] [Set Up Geo Secondary](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/post_cutover/set_up_geo_secondary_template.md)
- [ ] [Rebalance Gitaly Repository Storage](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/post_cutover/rebalance_gitaly_repository_storage_template.md)

### Operational Activities (DRI: EA Engineer + Project Manager)
- [ ] [Operational Activities Epic](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/sub_epics/operational_activities_epic_template.md) (Epic template only)
