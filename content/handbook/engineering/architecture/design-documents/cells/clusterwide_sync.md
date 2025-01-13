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

## Analysis of clusterwide tables

Below is an analysis of clusterwide tables, which can be categorized into 4
different types:

1. Reference table. Tables which are constant / exactly the same for all cells.
1. Instance Setting table. Tables which host settings which needs to affect all
   cells.
1. Organization / Cell table. Tables which may be better categorized as
   `gitlab_main_cell`.
1. User table. Tables related to users, and can be synchronized later in Cells 1.5+
   (not Cells 1.0).

| Table                                                     | Reference table | Instance Setting table | Organization/cell table | User table | Rows Present in new GDK |
|-----------------------------------------------------------|-----------------|------------------------|-------------------------|------------|-------------------------|
| ai_feature_settings                                       |                 | Y                      |                         |            | N                       |
| ai_settings                                               |                 | Y                      |                         |            | N                       |
| appearances                                               |                 | Y                      |                         |            | N                       |
| application_settings                                      |                 | Y                      |                         |            | Y                       |
| cloud_connector_access                                    |                 | Y                      |                         |            | N                       |
| plan_limits                                               |                 | Y                      |                         |            | N                       |
| service_access_tokens                                     |                 | Y                      |                         |            | N                       |
| ai_self_hosted_models                                     | Y               |                        |                         |            | N                       |
| application_setting_terms                                 | Y               |                        |                         |            | N                       |
| broadcast_messages                                        |                 | Y                      | Maybe ?                 |            | N                       |
| licenses                                                  |                 | Y                      |                         |            | N                       |
| plans                                                     | Y               |                        |                         |            | Y                       |
| subscription_add_ons                                      | Y               |                        |                         |            | Y                       |
| work_item_hierarchy_restrictions                          | Y               |                        |                         |            | Y                       |
| work_item_related_link_restrictions                       | Y               |                        |                         |            | Y                       |
| work_item_types                                           | Y               |                        |                         |            | Y                       |
| work_item_widget_definitions                              | Y               |                        |                         |            | Y                       |
| abuse_events                                              |                 |                        |                         | Y          | N                       |
| abuse_report_assignees                                    |                 |                        |                         | Y          | N                       |
| abuse_report_events                                       |                 |                        |                         | Y          | N                       |
| abuse_report_label_links                                  |                 |                        |                         | Y          | Y                       |
| abuse_report_labels                                       |                 |                        |                         | Y          | Y                       |
| abuse_report_notes                                        |                 |                        |                         | Y          | N                       |
| abuse_report_user_mentions                                |                 |                        |                         | Y          | N                       |
| abuse_reports                                             |                 |                        |                         | Y          | Y                       |
| abuse_trust_scores                                        |                 |                        |                         | Y          | N                       |
| ai_testing_terms_acceptances                              |                 |                        | Maybe                   |            | N                       |
| atlassian_identities                                      |                 |                        |                         | Y          | N                       |
| audit_events_instance_amazon_s3_configurations            |                 |                        | Maybe                   |            | N                       |
| audit_events_instance_external_audit_event_destinations   |                 |                        | Maybe                   |            | N                       |
| audit_events_instance_external_streaming_destinations     |                 |                        | Maybe                   |            | N                       |
| audit_events_instance_google_cloud_logging_configurations |                 |                        | Maybe                   |            | N                       |
| audit_events_instance_streaming_event_type_filters        |                 |                        | Maybe                   |            | N                       |
| audit_events_streaming_instance_event_type_filters        |                 |                        | Maybe                   |            | N                       |
| authentication_events                                     |                 |                        |                         | Y          | Y                       |
| aws_roles                                                 |                 |                        |                         | Y          | N                       |
| banned_users                                              |                 |                        |                         | Y          | N                       |
| deploy_tokens                                             |                 |                        |                         | Y          | N                       |
| early_access_program_tracking_events                      |                 |                        |                         | Y          | N                       |
| emails                                                    |                 |                        |                         | Y          | Y                       |
| ghost_user_migrations                                     |                 |                        |                         | Y          | N                       |
| gpg_key_subkeys                                           |                 |                        |                         | Y          | N                       |
| gpg_keys                                                  |                 |                        |                         | Y          | N                       |
| identities                                                |                 |                        |                         | Y          | N                       |
| instance_audit_events                                     |                 |                        | Maybe                   |            | N                       |
| instance_audit_events_streaming_headers                   |                 |                        | Maybe                   |            | N                       |
| instance_integrations                                     |                 |                        | Maybe                   |            | N                       |
| keys                                                      |                 |                        |                         | Y          | Y                       |
| oauth_applications                                        |                 |                        | Maybe                   |            | N                       |
| programming_languages                                     | Y               |                        | Maybe                   |            | Y                       |
| redirect_routes                                           |                 |                        | Y                       |            | N                       |
| routes                                                    |                 |                        | Y                       |            | Y                       |
| saved_replies                                             |                 |                        |                         | Y          | N                       |
| security_training_providers                               | Y               |                        | Maybe                   |            | Y                       |
| smartcard_identities                                      |                 |                        |                         | Y          | N                       |
| spam_logs                                                 |                 |                        |                         | Y          | Y                       |
| term_agreements                                           |                 |                        |                         | Y          | N                       |
| user_agent_details                                        |                 |                        |                         | Y          | N                       |
| user_audit_events                                         |                 |                        |                         | Y          | Y                       |
| user_broadcast_message_dismissals                         |                 |                        |                         | Y          | N                       |
| user_callouts                                             |                 |                        |                         | Y          | N                       |
| user_credit_card_validations                              |                 |                        |                         | Y          | N                       |
| user_custom_attributes                                    |                 |                        |                         | Y          | N                       |
| user_details                                              |                 |                        |                         | Y          | Y                       |
| user_follow_users                                         |                 |                        |                         | Y          | N                       |
| user_highest_roles                                        |                 |                        |                         | Y          | N                       |
| user_member_roles                                         |                 |                        |                         | Y          | N                       |
| user_permission_export_uploads                            |                 |                        |                         | Y          | N                       |
| user_phone_number_validations                             |                 |                        |                         | Y          | N                       |
| user_preferences                                          |                 |                        |                         | Y          | Y                       |
| user_statuses                                             |                 |                        |                         | Y          | N                       |
| user_synced_attributes_metadata                           |                 |                        |                         | Y          | N                       |
| users                                                     |                 |                        |                         | Y          | Y                       |
| users_statistics                                          |                 |                        |                         | Y          | N                       |
| vs_code_settings                                          |                 |                        |                         | Y          | N                       |
| webauthn_registrations                                    |                 |                        |                         | Y          | N                       |

### Instance Setting tables

#### application_settings

See related design document. In short, we will use an external source of truth
to synchronize each cell's Application Settings.

The external source of truth will need to first obtain the current values from
the Legacy Cell, before propogating the values to other cells.

When creating a setting, developers need to ensure that the default for the
setting will work correctly for any Cell. This applies especially when the new
setting has not had a chance to be synchronized yet with the external source of
truth.


### Reference tables

Convert reference tables to be in application code instead.

#### plans

The plans table is a simple table with `id`, `name`, and `title` columns. It also has a unique index on the `name`
table. There are two referencing tables, `plan_limits` and
`gitlab_subscriptions`.

The problem is that each Cell could create in-consistent data where
the `name` does not match `id` in all cells.

The solution is simple. We need a globally unique reference for each plan. We
can have the following enum:

```ruby
  enum :name_uid,
    default: 1,
    free: 2,
    bronze: 3,
    silver: 4,
    premium: 5,
    gold: 6,
    ultimate: 7,
    ultimate_trial: 8,
    ultimate_trial_paid_customer: 9,
    premium_trial: 10,
    opensource: 11
```

And drop the `id` column. We will then use the new `name_uid` column in all
referencing tables.

Another alternative is to drop the `plans` table entirely, and use a hard-coded
list of plans.

#### subscription_add_ons

The `subscription_add_ons` table is also a simple table with `id`, `name`, and
`description` columns. Again, it has a unique index on the `name` column.

Similar to the `plans`, we can either use a `name_uid` column strategy, or drop
the table entirely.

#### work_item_types

See this epic: TBD

#### abuse_report_labels

This table `abuse_report_labels` has several columns:

- `id`
- `cached_markdown_version`
- `title`
- `color`
- `description`
- `description_html`

There is a unique index for the `title` column.

There is no conceptual need to synchronize this table between each Cell. Abuse reports are
independent records. `abuse_report_labels` are labels which are attached to abuse
reports.

The only problem arises when `abuse_report_labels` are moved between Cells,
leading to uniqueness violations for the `title` column. The simplest measure is
to drop the uniqueness constraint, and allow duplicates.

Alternatively, we can append `(Cell 2)` to the title to de-duplicate.

#### programming_languages

The `programming_languages` table is a table with `id`, `name`, and `color`
columns. The table has a unique index on the `name` column.

Similar to the `plans`, we can adopt the `name_uid` column strategy, and drop the
`id` column. As the data comes from Gitaly (lingust), we will need to map the
`name` to an integer in a way that is stable. This mapping can be stored on
either the GitLab Ruby monolith, or in Gitaly.

<https://github.com/github-linguist/linguist/blob/main/lib/linguist/languages.yml>
has the full list of languages. We can possibly use the `langugage_id` field.

All referencing tables will be switched to refer to the `name_uid`
column instead.

#### security_training_providers

The `security_training_providers` table has a few columns:

- `id`
- `name`
- `description`
- `url`
- `logo_url`

There is a unique index on `name`.

Similar to the `plans`, we can adopt the `name_uid` column strategy, and drop the
`id` column. All referencing tables will be switched to refer to the `name_uid`
column instead.

However, as there are only three rows, we can drop the table entirely instead,
and use in-application code instead.

```ruby
SECUREFLAG_DATA = {
  name_uid: 1,
  name: 'SecureFlag',
  description: "Get remediation advice with example code and recommended hands-on labs in a fully
                interactive virtualised environment.",
  url: "https://knowledge-base-api.secureflag.com/gitlab"
}.freeze
```

----

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

1. The Central service receives rows from the leader cell.
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

### Analysis of clusterwide tables

Below is an analysis of clusterwide tables, which can be categorized into 4
different types:

1. Reference table. Tables which are constant / exactly the same for all cells.
1. Instance Setting table. Tables which host settings which needs to affect all
   cells.
1. Organization / Cell table. Tables which may be better categorized as
   `gitlab_main_cell`.
1. User table. Tables related to users, and can be synchronized later in Cells 1.5+
   (not Cells 1.0).

| Table                                                     | Reference table | Instance Setting table | Organization / Cell table | User table |
|-----------------------------------------------------------|-----------------|------------------|------------------------|------|
| abuse_events                                              |                 |                  |                        | Y    |
| abuse_report_assignees                                    |                 |                  |                        | Y    |
| abuse_report_events                                       |                 |                  |                        | Y    |
| abuse_report_label_links                                  |                 |                  |                        | Y    |
| abuse_report_labels                                       |                 |                  |                        | Y    |
| abuse_report_notes                                        |                 |                  |                        | Y    |
| abuse_report_user_mentions                                |                 |                  |                        | Y    |
| abuse_reports                                             |                 |                  |                        | Y    |
| abuse_trust_scores                                        |                 |                  |                        | Y    |
| ai_feature_settings                                       |                 | Y                |                        |      |
| ai_self_hosted_models                                     | Y               |                  |                        |      |
| ai_settings                                               |                 | Y                |                        |      |
| ai_testing_terms_acceptances                              |                 |                  | Maybe                  |      |
| appearances                                               |                 | Y                |                        |      |
| application_setting_terms                                 | Y               |                  |                        |      |
| application_settings                                      |                 | Y                |                        |      |
| atlassian_identities                                      |                 |                  |                        | Y    |
| audit_events_instance_amazon_s3_configurations            |                 |                  | Maybe                  |      |
| audit_events_instance_external_audit_event_destinations   |                 |                  | Maybe                  |      |
| audit_events_instance_external_streaming_destinations     |                 |                  | Maybe                  |      |
| audit_events_instance_google_cloud_logging_configurations |                 |                  | Maybe                  |      |
| audit_events_instance_streaming_event_type_filters        |                 |                  | Maybe                  |      |
| audit_events_streaming_instance_event_type_filters        |                 |                  | Maybe                  |      |
| authentication_events                                     |                 |                  |                        | Y    |
| aws_roles                                                 |                 |                  |                        | Y    |
| banned_users                                              |                 |                  |                        | Y    |
| broadcast_messages                                        | Y               |                  | Maybe ?                |      |
| cloud_connector_access                                    |                 | Y                |                        |      |
| deploy_tokens                                             |                 |                  |                        | Y    |
| early_access_program_tracking_events                      |                 |                  |                        | Y    |
| emails                                                    |                 |                  |                        | Y    |
| ghost_user_migrations                                     |                 |                  |                        | Y    |
| gpg_key_subkeys                                           |                 |                  |                        | Y    |
| gpg_keys                                                  |                 |                  |                        | Y    |
| identities                                                |                 |                  |                        | Y    |
| instance_audit_events                                     |                 |                  | Maybe                  |      |
| instance_audit_events_streaming_headers                   |                 |                  | Maybe                  |      |
| instance_integrations                                     |                 |                  | Maybe                  |      |
| keys                                                      |                 |                  |                        | Y    |
| licenses                                                  | Y               |                  |                        |      |
| oauth_applications                                        |                 |                  | Maybe                  |      |
| plan_limits                                               |                 | Y                |                        |      |
| plans                                                     | Y               |                  |                        |      |
| programming_languages                                     |                 |                  | Maybe                  |      |
| redirect_routes                                           |                 |                  | Y                      |      |
| routes                                                    |                 |                  | Y                      |      |
| saved_replies                                             |                 |                  |                        | Y    |
| security_training_providers                               |                 |                  | Maybe                  |      |
| service_access_tokens                                     |                 | Y                |                        |      |
| smartcard_identities                                      |                 |                  |                        | Y    |
| spam_logs                                                 |                 |                  |                        | Y    |
| subscription_add_ons                                      | Y               |                  |                        |      |
| term_agreements                                           |                 |                  |                        | Y    |
| user_agent_details                                        |                 |                  |                        | Y    |
| user_audit_events                                         |                 |                  |                        | Y    |
| user_broadcast_message_dismissals                         |                 |                  |                        | Y    |
| user_callouts                                             |                 |                  |                        | Y    |
| user_credit_card_validations                              |                 |                  |                        | Y    |
| user_custom_attributes                                    |                 |                  |                        | Y    |
| user_details                                              |                 |                  |                        | Y    |
| user_follow_users                                         |                 |                  |                        | Y    |
| user_highest_roles                                        |                 |                  |                        | Y    |
| user_member_roles                                         |                 |                  |                        | Y    |
| user_permission_export_uploads                            |                 |                  |                        | Y    |
| user_phone_number_validations                             |                 |                  |                        | Y    |
| user_preferences                                          |                 |                  |                        | Y    |
| user_statuses                                             |                 |                  |                        | Y    |
| user_synced_attributes_metadata                           |                 |                  |                        | Y    |
| users                                                     |                 |                  |                        | Y    |
| users_statistics                                          |                 |                  |                        | Y    |
| vs_code_settings                                          |                 |                  |                        | Y    |
| webauthn_registrations                                    |                 |                  |                        | Y    |
| work_item_hierarchy_restrictions                          | Y               |                  |                        |      |
| work_item_related_link_restrictions                       | Y               |                  |                        |      |
| work_item_types                                           | Y               |                  |                        |      |
| work_item_widget_definitions                              | Y               |                  |                        |      |

### Post Cells 1.0

It is anticipated that other clusterwide tables like `users` will need to be
synced to other cells as required.

## Alternatives

- Not syncing.
- [Logical replication](https://www.postgresql.org/docs/current/logical-replication.html).
- [Geo](https://docs.gitlab.com/ee/development/geo.html).
- Terraform / IAC.
