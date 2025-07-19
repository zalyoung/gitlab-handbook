---
title: Dedicated Migration API-based
---

## Keeping Lint Happy

### API Migrations

#### KickOff (1 business day)

Initial project kickoff and setup activities.

#### Platform Discovery & Setup (35 business days)

##### Tech Discovery (DRI: Technical Architect)

<i class="far fa-folder-open"></i>[Tech Discovery Templates](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/tree/main/.gitlab/issue_templates/geo/tech_discovery)

- [ ] [Receive Primary Secondary Region Info](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/receive_primary_secondary_region_info_template.md)
- [ ] [Receive Primary Secondary Private Link Availability Info](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/receive_primary_secondary_pvt_lnk_availability_info_template.md)
- [ ] [Receive BYOD Info](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/receive_byod_info_template.md)
- [ ] [Receive Gitaly Storage Configuration](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/receive_gitaly_storage_configuration_template.md)
- [ ] [Receive SMTP Settings](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/receive_smtp_settings_template.md)
- [ ] [Send Switchboard Invite](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/send_switchboard_invite_template.md)
- [ ] [Receive Secrets and SSH Keys](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/blob/main/.gitlab/issue_templates/geo/tech_discovery/receive_secrets_and_ssh_keys_template.md)
- [ ] [Receive Full Networking Diagram](https://gitlab.com)

#### Configuration (45 business days)

##### Dedicated Instance Provisioning (DRI: EA Engineer)

<i class="far fa-folder-open"></i>[Dedicated Instance Provisioning Templates](https://gitlab.com/gitlab-com/gl-infra/gitlab-dedicated/dedicated-migrations-group/test-automations-project/-/tree/main/.gitlab/issue_templates/geo/dedicated_instance_provisioning)

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
- [ ] [Configure SAML/SCIM/SSO](https://gitlab.com)

#### Data Sanitization (N days)

##### Remediate Evaluate Outliers

- [ ] [Receive Evaluate Data](https://gitlab.com)
- [ ] [Develop Remediation Plan for Outlier Projects](https://gitlab.com)
- [ ] [Remediation Plan Acceptance and Sign-off](https://gitlab.com)
- [ ] [Execute Remediation Plan](https://gitlab.com)

#### Pilot Phase (N days)

##### Tokens, Migration Infrastructure, and Users

- [ ] [Provision API Tokens](https://gitlab.com)
- [ ] [Provision Migration VM](https://gitlab.com)
- [ ] [Select Pilot Groups and Projects](https://gitlab.com)
- [ ] [Validate User Provisioning](https://gitlab.com)
- [ ] [Migrate Pilot Projects and Validate](https://gitlab.com)
- [ ] [Verify User Mappings](https://gitlab.com)

##### Wave Planning

- [ ] [Generate Wave Planning File](https://gitlab.com)
- [ ] [Plan Waves and Wave Cadence](https://gitlab.com)
- [ ] [Finalize Pre/Post Developer Experience Plan](https://gitlab.com)
- [ ] [Finalize Wave Communications Template](https://gitlab.com)

#### Migration Execution (N days)

##### Execute Wave

- [ ] [Send Pre-Wave Communication](https://gitlab.com)
- [ ] [Start Wave Thread](https://gitlab.com)
- [ ] [Execute Wave](https://gitlab.com)
- [ ] [Send Post-Wave Communication](https://gitlab.com)
- [ ] [Execution Developer Pre/Post and Confirm](https://gitlab.com)
