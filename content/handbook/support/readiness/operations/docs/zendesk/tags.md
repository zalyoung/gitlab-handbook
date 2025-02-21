---
title: Tags
description: Support Operations documentation page for Zendesk tags
canonical_path: "/handbook/support/readiness/operations/docs/zendesk/tags"
---

## What are Zendesk tags?

As per
[Zendesk](https://support.zendesk.com/hc/en-us/articles/4408888664474-About-tags):

> Tags are words, or combinations of words, you can use to add more context to
> tickets and topics. You can apply tags to tickets, users, and organizations.

At its core, Zendesk relies on tags pretty heavily. As such, it is best to fully
understand the tags used and how they correlate to what Zendesk does to the
ticket.

As there are many, many tags, and new ones get added frequently, we will not
list them all out here. Instead, here are the ones likely to be the most
important to those working within Zendesk:

## Zendesk Global common tags

<details>
<summary>SLA/Subscription Related Tags</summary>

| Tag                              | SLA granted | What it means |
|----------------------------------|-------------|---------------|
| `sub_community_other`            | None        | The organization has a community subscription of an unknown type |
| `sub_consumption_ai`             | Consumption | The organization has purchased an AI addon |
| `sub_consumption_cicd_minutes`   | Consumption | The organization has purchased CI/CD minutes |
| `sub_consumption_eap`            | Consumption | The organization has purchased the Enterprise Agile Planning addon |
| `sub_consumption_duo_enterprise` | Consumption | The organization has purchased GitLab Duo Enterprise |
| `sub_consumption_duo_premium`    | Consumption | The organization has purchased GitLab Duo Premium |
| `sub_consumption_duo_amazon_q`   | Consumption | The organization has purchased GitLab Duo with Amazon Q |
| `sub_consumption_storage`        | Consumption | The organization has storage |
| `sub_dotcom_premium`             | Priority    | The organization has a GitLab.com Premium subscription |
| `sub_dotcom_ultimate`            | Priority    | The organization has a GitLab.com Ultimate subscription |
| `sub_edu`                        | None        | The organization has a EDU community subscription |
| `sub_gitlab_dedicated`           | Priority    | The organization has a GitLab Dedicated subscription |
| `sub_oss`                        | None        | The organization has a OSS community subscription |
| `sub_other`                      | General     | The organization has an unknown purchase |
| `sub_proserv`                    | None        | The organization has a Professional Services engagement purchase |
| `sub_sm_premium`                 | Priority    | The organization has a Self-managed Premium subscription |
| `sub_sm_starter`                 | Standard    | The organization has a Self-managed Starter subscription |
| `sub_sm_ultimate`                | Priority    | The organization has a Self-managed Ultimate subscription |
| `sub_ss_ase`                     | General     | The organization has purchased an Assigned Support Engineer addon |
| `sub_ss_growth`                  | General     | The organization has purchased a Success Growth addon |
| `sub_ss_enterprise`              | Special     | The organization has purchased a Success Enterprise addon |
| `sub_usgov_12x5`                 | Priority    | The organization has a US Government purchase granting 12x5 support |
| `sub_usgov_24x7`                 | Priority    | The organization has a US Government purchase granting 24x7 support |

</details>
<details>
<summary>Account Related Tags</summary>

| Tag                   | What it means |
|-----------------------|---------------|
| `customer`            | Signifies the ticket is from an account labeled as Customer |
| `former_customer`     | Signifies the ticket is from an account labeled as Former Customer |
| `authorized_reseller` | Signifies the ticket is from an account labeled as Authorized Reseller |
| `integrator`          | Signifies the ticket is from an account labeled as Integrator |
| `partner`             | Signifies the ticket is from an account labeled as Partner |
| `unofficial_reseller` | Signifies the ticket is from an account labeled as Unofficial Reseller |
| `open_partner`        | Signifies the ticket is from an account labeled as Open Partner |
| `select_partner`      | Signifies the ticket is from an account labeled as Select Partner |
| `alliance_partner`    | Signifies the ticket is from an account labeled as Alliance Partner |
| `support_hold`        | Signifies the organization that filed the ticket has a Support Hold in place |

</details>
<details>
<summary>Organization Tags</summary>

| Tag                            | What it means |
|--------------------------------|---------------|
| `greatly_expired`              | The organization is slated to be removed due to data rentention policies |
| `not_in_sfdc`                  | The organization is not being controlled by the ZD-SFDC sync |
| `org_region_apac`              | The organization has a Geographic Demographic relating to APAC |
| `org_region_amer`              | The organization has a Geographic Demographic relating to AMER |
| `org_region_emea`              | The organization has a Geographic Demographic relating to EMEA |
| `org_region_latam`             | The organization has a Geographic Demographic relating to LATAM |
| `org_region_ncsa`              | The organization has a Geographic Demographic relating to NCSA |
| `org_region_noram`             | The organization has a Geographic Demographic relating to NORAM |
| `partner_customer`             | The organization has purchased from an OEM partner |
| `restricted_account`           | The SFDC account is classified as restricted and cannot receive support |
| `sub_community_other`          | The organization has a community subscription which had an undetectable type |
| `sub_consumption_ai`           | The organization has an AI subscription |
| `sub_consumption_cicd_minutes` | The organization has a CI/CD minutes purchase |
| `sub_consumption_eap`          | The organization has an Agile Planning addon |
| `sub_consumption_storage`      | The organization has a storage purchase |
| `sub_dotcom_premium`           | The organization has a gitlab.com Premium subscription |
| `sub_dotcom_ultimate`          | The organization has a gitlab.com Ultimate subscription |
| `sub_edu`                      | The organization has an EDU community subscription |
| `sub_gitlab_dedicated`         | The organization has a GitLab Dedicated subscription |
| `sub_oss`                      | The organization has an OSS subscription |
| `sub_other`                    | The organization has a subscription but the type could not be determined |
| `sub_proserv`                  | The organization has a Proserv subscription |
| `sub_sm_premium`               | The organization has a Self-Managed Premium subscription |
| `sub_sm_starter`               | The organization has a Self-Managed Starter subscription |
| `sub_sm_ultimate`              | The organization has a Self-Managed Ultimate subscription |
| `sub_ss_ase`                   | The organization has an Assigned Support Engineer addon |
| `sub_usgov_12x5`               | The organization has a US Government 12x5 subscription |
| `sub_usgov_24x7`               | The organization has a US Government 24x7 subscription |

</details>
<details>
<summary>Categorization tags (current)</summary>

| Tag | What it means/Categorization |
|-----|------------------------------|
| `lnr_category_cdot` | The L&R ticket involves customers.gitlab.com |
| `lnr_category_other` | The L&R ticket's category is unknown |
| `lnr_category_purchasing_issues` | The L&R ticket involves purchasing issues |
| `lnr_category_qsr` | The L&R ticket involves QSR |
| `lnr_category_saas` | The L&R ticket involves saas issues |
| `lnr_category_sm` | The L&R ticket involves self-managed issues |
| `lnr_category_special_program` | The L&R ticket involves GitLab special programs (EDU, OSS, etc.) |
| `lnr_category_trial` | The L&R ticket involves GitLab trials |
| `lnr_cdot_contacts` | The L&R ticket involves customers.gitlab.com account contacts |
| `lnr_cdot_login` | The L&R ticket involves customers.gitlab.com login issues |
| `lnr_cdot_other` | The L&R ticket involves customers.gitlab.com in some way |
| `lnr_cdot_transfer` | The L&R ticket involves customers.gitlab.com account transfers |
| `lnr_purchasing_issues_cc_issues` | The L&R ticket involves CC issues when purchasing |
| `lnr_purchasing_issues_non_cc_issues` | The L&R ticket involves non-CC issues when purchasing |
| `lnr_purchasing_issues_other` | The L&R ticket involves some other purchasing issue |
| `lnr_qsr_dispute` | The L&R ticket involves a QSR dispute |
| `lnr_qsr_other` | The L&R ticket involves something else about QSR |
| `lnr_qsr_questions` | The L&R ticket involves QSR questions |
| `lnr_saas_link_sub` | The L&R ticket involves linking a subscription to a namespace |
| `lnr_saas_other` | The L&R ticket involves something else about saas subscriptions |
| `lnr_saas_seat_usage` | The L&R ticket involves namespace seat usage |
| `lnr_saas_sub_issues` | The L&R ticket involves an issue with a saas subscription |
| `lnr_sm_cloud_opt_out` | The L&R ticket involves opting out of SCL |
| `lnr_sm_did_not_receive` | The L&R ticket involves not receiving a SM license |
| `lnr_sm_license_errors` | The L&R ticket involves errors applying a SM license |
| `lnr_sm_other` | The L&R ticket involves something else about SM licenses |
| `lnr_sm_resend_to_new_contact` | The L&R ticket involves sending a license to a new contact |
| `lnr_sm_seat_usage` | The L&R ticket involves seat usage on a SM instance |
| `lnr_special_programs_other` | The L&R ticket involves something else about special programs |
| `lnr_special_programs_questions` | The L&R ticket involves general questions about special programs |
| `lnr_special_programs_renew` | The L&R ticket involves renewing a special program offerring |
| `lnr_special_programs_sheerid` | The L&R ticket involves issues appying a SheerID |
| `lnr_trial_cannot_apply` | The L&R ticket involves not being able to apply a trial |
| `lnr_trial_cannot_start` | The L&R ticket involves not being able to start a trial |
| `lnr_trial_other` | The L&R ticket involves something else about trials |
| `lnr_trial_questions` | The L&R ticket involves general trial questions |
| `resold_status_no` | The customer has stated they did not buy via a reseller |
| `resold_status_reseller` | The customer has stated they are a reseller |
| `resold_status_resold` | The customer has stated they did buy via a reseller |
| `resold_status_unsure` | The customer is unsure if they bought via a reseller or not |
| `saas_account_2fa_issues_questions` | The gitlab.com Account ticket involves 2FA questions |
| `saas_account_2fa_issues_removal` | The gitlab.com Account ticket involves 2FA removal |
| `saas_account_2fa_issues_setup` | The gitlab.com Account ticket involves 2FA setup |
| `saas_account_access_issues_blocked` | The gitlab.com Account ticket involves getting account blocked errors |
| `saas_account_access_issues_cannot_login` | The gitlab.com Account ticket involves not being able to login to gitlab.com |
| `saas_account_access_issues_change_account` | The gitlab.com Account ticket involves changing something on a gitlab.com account |
| `saas_account_access_issues_cloudflare` | The gitlab.com Account ticket involves CloudFlare issues |
| `saas_account_access_issues_ip_blocked` | The gitlab.com Account ticket involves the customer's IP being blocked |
| `saas_account_access_issues_locked` | The gitlab.com Account ticket involves getting account locked errors |
| `saas_account_access_issues_other` | The gitlab.com Account ticket involves something else about accessing gitlab.com |
| `saas_account_category_2fa_issues` | The gitlab.com Account ticket involves 2FA |
| `saas_account_category_access_issues` | The gitlab.com Account ticket involves accessing gitlab.com |
| `saas_account_category_account_deletion` | The gitlab.com Account ticket involves account deletion |
| `saas_account_category_email_issues` | The gitlab.com Account ticket involves email issues |
| `saas_account_category_namesquatting` | The gitlab.com Account ticket involves namesquatting |
| `saas_account_category_other` | The gitlab.com Account ticket something else |
| `saas_account_category_registration_issues` | The gitlab.com Account ticket involves registering a gitlab.com account |
| `saas_account_email_issues_confirmation` | The gitlab.com Account ticket involves confirmation emails |
| `saas_account_email_issues_notifications` | The gitlab.com Account ticket involves notification emails |
| `saas_account_email_issues_reset` | The gitlab.com Account ticket involves password reset emails |
| `support_category_administering_gitlab_admin_area_instance` | Maintaining/Administering GitLab::Admin Area::Instance settings |
| `support_category_administering_gitlab_admin_area_limits` | Maintaining/Administering GitLab::Admin Area::Account and limit settings |
| `support_category_administering_gitlab_admin_area` | Maintaining/Administering GitLab::Admin Area |
| `support_category_administering_gitlab_admin_area_other` | Maintaining/Administering GitLab::Admin Area::Other |
| `support_category_administering_gitlab_admin_area_questions` | Maintaining/Administering GitLab::Admin Area::General questions |
| `support_category_administering_gitlab_admin_area_user_group` | Maintaining/Administering GitLab::Admin Area::User/Group management |
| `support_category_administering_gitlab_backups_create` | Maintaining/Administering GitLab::Backups/Restores::Creating backups |
| `support_category_administering_gitlab_backups` | Maintaining/Administering GitLab::Backups/Restores |
| `support_category_administering_gitlab_backups_manage` | Maintaining/Administering GitLab::Backups/Restores::Managing backups |
| `support_category_administering_gitlab_backups_other` | Maintaining/Administering GitLab::Backups/Restores::Other |
| `support_category_administering_gitlab_backups_restore` | Maintaining/Administering GitLab::Backups/Restores::Performing a restore |
| `support_category_administering_gitlab_other` | Maintaining/Administering GitLab::Other |
| `support_category_administering_gitlab_securing_2fa` | Maintaining/Administering GitLab::Securing my GitLab setup::Enforce two-factor authentication |
| `support_category_administering_gitlab_securing_compliance` | Maintaining/Administering GitLab::Securing my GitLab setup::Compliance features |
| `support_category_administering_gitlab_securing_email_confirmation` | Maintaining/Administering GitLab::Securing my GitLab setup::User email confirmation |
| `support_category_administering_gitlab_securing_exclusivity` | Maintaining/Administering GitLab::Securing my GitLab setup::Information exclusivity |
| `support_category_administering_gitlab_securing_incidents` | Maintaining/Administering GitLab::Securing my GitLab setup::Responding to security incidents |
| `support_category_administering_gitlab_securing_jobs` | Maintaining/Administering GitLab::Securing my GitLab setup::Security of running jobs |
| `support_category_administering_gitlab_securing` | Maintaining/Administering GitLab::Securing my GitLab setup |
| `support_category_administering_gitlab_securing_other` | Maintaining/Administering GitLab::Securing my GitLab setup::Other |
| `support_category_administering_gitlab_securing_proxying` | Maintaining/Administering GitLab::Securing my GitLab setup::Proxying assets |
| `support_category_administering_gitlab_securing_rate_limits` | Maintaining/Administering GitLab::Securing my GitLab setup::Rate limits |
| `support_category_administering_gitlab_securing_ssh_keys` | Maintaining/Administering GitLab::Securing my GitLab setup::Limits on SSH keys |
| `support_category_administering_gitlab_securing_token` | Maintaining/Administering GitLab::Securing my GitLab setup::Token overview |
| `support_category_administering_gitlab_securing_webhooks` | Maintaining/Administering GitLab::Securing my GitLab setup::Webhooks administration |
| `support_category_administering_gitlab_upgrades_component` | Maintaining/Administering GitLab::Upgrading GitLab::Component upgrades |
| `support_category_administering_gitlab_upgrades_database` | Maintaining/Administering GitLab::Upgrading GitLab::Database upgrades and migrations |
| `support_category_administering_gitlab_upgrades_major` | Maintaining/Administering GitLab::Upgrading GitLab::Major upgrades |
| `support_category_administering_gitlab_upgrades_minor` | Maintaining/Administering GitLab::Upgrading GitLab::Minor upgrades |
| `support_category_administering_gitlab_upgrades_other` | Maintaining/Administering GitLab::Upgrading GitLab::Other |
| `support_category_administering_gitlab_upgrading` | Maintaining/Administering GitLab::Upgrading GitLab |
| `support_category_analyze_usage_audits_errors` | GitLab analytics::Audit Events::Issues/Errors |
| `support_category_analyze_usage_audits` | GitLab analytics::Audit Events |
| `support_category_analyze_usage_audits_other_topic` | GitLab analytics::Audit Events::Other |
| `support_category_analyze_usage_audits_questions` | GitLab analytics::Audit Events::Questions |
| `support_category_analyze_usage_audits_setup` | GitLab analytics::Audit Events::Setup/configuration |
| `support_category_analyze_usage_cicd_errors` | GitLab analytics::CI/CD analytic::Issues/Errors |
| `support_category_analyze_usage_cicd` | GitLab analytics::CI/CD analytics |
| `support_category_analyze_usage_cicd_other_topic` | GitLab analytics::CI/CD analytic::Other |
| `support_category_analyze_usage_cicd_questions` | GitLab analytics::CI/CD analytic::Questions |
| `support_category_analyze_usage_cicd_setup` | GitLab analytics::CI/CD analytic::Setup/configuration |
| `support_category_analyze_usage_code_review_errors` | GitLab analytics::Code Review Analytics::Issues/Errors |
| `support_category_analyze_usage_code_review` | GitLab analytics::Code Review Analytics |
| `support_category_analyze_usage_code_review_other_topic` | GitLab analytics::Code Review Analytics::Other |
| `support_category_analyze_usage_code_review_questions` | GitLab analytics::Code Review Analytics::Questions |
| `support_category_analyze_usage_code_review_setup` | GitLab analytics::Code Review Analytics::Setup/configuration |
| `support_category_analyze_usage_contribution_errors` | GitLab analytics::Contribution Analytics::Issues/Errors |
| `support_category_analyze_usage_contribution` | GitLab analytics::Contribution Analytics |
| `support_category_analyze_usage_contribution_other_topic` | GitLab analytics::Contribution Analytics::Other |
| `support_category_analyze_usage_contribution_questions` | GitLab analytics::Contribution Analytics::Questions |
| `support_category_analyze_usage_contribution_setup` | GitLab analytics::Contribution Analytics::Setup/configuration |
| `support_category_analyze_usage_group_devops_errors` | GitLab analytics::Group DevOps Adoption::Issues/Errors |
| `support_category_analyze_usage_group_devops` | GitLab analytics::Group DevOps Adoption |
| `support_category_analyze_usage_group_devops_other_topic` | GitLab analytics::Group DevOps Adoption::Other |
| `support_category_analyze_usage_group_devops_questions` | GitLab analytics::Group DevOps Adoption::Questions |
| `support_category_analyze_usage_group_devops_setup` | GitLab analytics::Group DevOps Adoption::Setup/configuration |
| `support_category_analyze_usage_insights_errors` | GitLab analytics::Insights::Issues/Errors |
| `support_category_analyze_usage_insights` | GitLab analytics::Insights |
| `support_category_analyze_usage_insights_other_topic` | GitLab analytics::Insights::Other |
| `support_category_analyze_usage_insights_questions` | GitLab analytics::Insights::Questions |
| `support_category_analyze_usage_insights_setup` | GitLab analytics::Insights::Setup/configuration |
| `support_category_analyze_usage_issues_errors` | GitLab analytics::Issue analytics::Issues/Errors |
| `support_category_analyze_usage_issues` | GitLab analytics::Issue analytics |
| `support_category_analyze_usage_issues_other_topic` | GitLab analytics::Issue analytics::Other |
| `support_category_analyze_usage_issues_questions` | GitLab analytics::Issue analytics::Questions |
| `support_category_analyze_usage_issues_setup` | GitLab analytics::Issue analytics::Setup/configuration |
| `support_category_analyze_usage_mrs_errors` | GitLab analytics::Merge request analytics::Issues/Errors |
| `support_category_analyze_usage_mrs` | GitLab analytics::Merge request analytics |
| `support_category_analyze_usage_mrs_other_topic` | GitLab analytics::Merge request analytics::Other |
| `support_category_analyze_usage_mrs_questions` | GitLab analytics::Merge request analytics::Questions |
| `support_category_analyze_usage_mrs_setup` | GitLab analytics::Merge request analytics::Setup/configuration |
| `support_category_analyze_usage_other_errors` | GitLab analytics::Other::Issues/Errors |
| `support_category_analyze_usage_other` | GitLab analytics::Other |
| `support_category_analyze_usage_other_other_topic` | GitLab analytics::Other::Other |
| `support_category_analyze_usage_other_questions` | GitLab analytics::Other::Questions |
| `support_category_analyze_usage_other_setup` | GitLab analytics::Other::Setup/configuration |
| `support_category_analyze_usage_productivity_errors` | GitLab analytics::Productivity Analytics::Issues/Errors |
| `support_category_analyze_usage_productivity` | GitLab analytics::Productivity Analytics |
| `support_category_analyze_usage_productivity_other_topic` | GitLab analytics::Productivity Analytics::Other |
| `support_category_analyze_usage_productivity_questions` | GitLab analytics::Productivity Analytics::Questions |
| `support_category_analyze_usage_productivity_setup` | GitLab analytics::Productivity Analytics::Setup/configuration |
| `support_category_analyze_usage_respository_errors` | GitLab analytics::Repository Analytics::Issues/Errors |
| `support_category_analyze_usage_respository` | GitLab analytics::Repository Analytics |
| `support_category_analyze_usage_respository_other_topic` | GitLab analytics::Repository Analytics::Other |
| `support_category_analyze_usage_respository_questions` | GitLab analytics::Repository Analytics::Questions |
| `support_category_analyze_usage_respository_setup` | GitLab analytics::Repository Analytics::Setup/configuration |
| `support_category_analyze_usage_value_stream_errors` | GitLab analytics::Value stream analytics::Issues/Errors |
| `support_category_analyze_usage_value_stream` | GitLab analytics::Value stream analytics |
| `support_category_analyze_usage_value_stream_other_topic` | GitLab analytics::Value stream analytics::Other |
| `support_category_analyze_usage_value_stream_questions` | GitLab analytics::Value stream analytics::Questions |
| `support_category_analyze_usage_value_stream_setup` | GitLab analytics::Value stream analytics::Setup/configuration |
| `support_category_auth_alicloud` | Authentication and Authorization::AliCloud |
| `support_category_auth_alicloud_issues_errors` | Authentication and Authorization::AliCloud::Issues/errors |
| `support_category_auth_alicloud_other` | Authentication and Authorization::AliCloud::Other |
| `support_category_auth_alicloud_questions` | Authentication and Authorization::AliCloud::Questions |
| `support_category_auth_alicloud_setup_configuration` | Authentication and Authorization::AliCloud::Setup/configuration |
| `support_category_auth_alicloud_sync_issues` | Authentication and Authorization::AliCloud::Sync issues |
| `support_category_auth_atlassian_crowd` | Authentication and Authorization::Atlassian Crowd |
| `support_category_auth_atlassian_crowd_issues_errors` | Authentication and Authorization::Atlassian Crowd::Issues/errors |
| `support_category_auth_atlassian_crowd_other` | Authentication and Authorization::Atlassian Crowd::Other |
| `support_category_auth_atlassian_crowd_questions` | Authentication and Authorization::Atlassian Crowd::Questions |
| `support_category_auth_atlassian_crowd_setup_configuration` | Authentication and Authorization::Atlassian Crowd::Setup/configuration |
| `support_category_auth_atlassian_crowd_sync_issues` | Authentication and Authorization::Atlassian Crowd::Sync issues |
| `support_category_auth_atlassian_omniauth` | Authentication and Authorization::Atlassian Omniauth |
| `support_category_auth_atlassian_omniauth_issues_errors` | Authentication and Authorization::Atlassian Omniauth::Issues/errors |
| `support_category_auth_atlassian_omniauth_other` | Authentication and Authorization::Atlassian Omniauth::Other |
| `support_category_auth_atlassian_omniauth_questions` | Authentication and Authorization::Atlassian Omniauth::Questions |
| `support_category_auth_atlassian_omniauth_setup_configuration` | Authentication and Authorization::Atlassian Omniauth::Setup/configuration |
| `support_category_auth_atlassian_omniauth_sync_issues` | Authentication and Authorization::Atlassian Omniauth::Sync issues |
| `support_category_auth_auth0` | Authentication and Authorization::Auth0 OmniAuth |
| `support_category_auth_auth0_issues_errors` | Authentication and Authorization::Auth0 OmniAuth::Issues/errors |
| `support_category_auth_auth0_other` | Authentication and Authorization::Auth0 OmniAuth::Other |
| `support_category_auth_auth0_questions` | Authentication and Authorization::Auth0 OmniAuth::Questions |
| `support_category_auth_auth0_setup_configuration` | Authentication and Authorization::Auth0 OmniAuth::Setup/configuration |
| `support_category_auth_auth0_sync_issues` | Authentication and Authorization::Auth0 OmniAuth::Sync issues |
| `support_category_auth_authentiq` | Authentication and Authorization::Authentiq OmniAuth |
| `support_category_auth_authentiq_issues_errors` | Authentication and Authorization::Authentiq OmniAuth::Issues/errors |
| `support_category_auth_authentiq_other` | Authentication and Authorization::Authentiq OmniAuth::Other |
| `support_category_auth_authentiq_questions` | Authentication and Authorization::Authentiq OmniAuth::Questions |
| `support_category_auth_authentiq_setup_configuration` | Authentication and Authorization::Authentiq OmniAuth::Setup/configuration |
| `support_category_auth_authentiq_sync_issues` | Authentication and Authorization::Authentiq OmniAuth::Sync issues |
| `support_category_auth_aws_cognito` | Authentication and Authorization::Amazon Web Services Cognito |
| `support_category_auth_aws_cognito_issues_errors` | Authentication and Authorization::Amazon Web Services Cognito::Issues/errors |
| `support_category_auth_aws_cognito_other` | Authentication and Authorization::Amazon Web Services Cognito::Other |
| `support_category_auth_aws_cognito_questions` | Authentication and Authorization::Amazon Web Services Cognito::Questions |
| `support_category_auth_aws_cognito_setup_configuration` | Authentication and Authorization::Amazon Web Services Cognito::Setup/configuration |
| `support_category_auth_aws_cognito_sync_issues` | Authentication and Authorization::Amazon Web Services Cognito::Sync issues |
| `support_category_auth_azure` | Authentication and Authorization::Azure OAuth OmniAuth |
| `support_category_auth_azure_issues_errors` | Authentication and Authorization::Azure OAuth OmniAuth::Issues/errors |
| `support_category_auth_azure_other` | Authentication and Authorization::Azure OAuth OmniAuth::Other |
| `support_category_auth_azure_questions` | Authentication and Authorization::Azure OAuth OmniAuth::Questions |
| `support_category_auth_azure_setup_configuration` | Authentication and Authorization::Azure OAuth OmniAuth::Setup/configuration |
| `support_category_auth_azure_sync_issues` | Authentication and Authorization::Azure OAuth OmniAuth::Sync issues |
| `support_category_auth_bitbucket` | Authentication and Authorization::Bitbucket cloud OmniAuth |
| `support_category_auth_bitbucket_issues_errors` | Authentication and Authorization::Bitbucket cloud OmniAuth::Issues/errors |
| `support_category_auth_bitbucket_other` | Authentication and Authorization::Bitbucket cloud OmniAuth::Other |
| `support_category_auth_bitbucket_questions` | Authentication and Authorization::Bitbucket cloud OmniAuth::Questions |
| `support_category_auth_bitbucket_setup_configuration` | Authentication and Authorization::Bitbucket cloud OmniAuth::Setup/configuration |
| `support_category_auth_bitbucket_sync_issues` | Authentication and Authorization::Bitbucket cloud OmniAuth::Sync issues |
| `support_category_auth_cas` | Authentication and Authorization::CAS OmniAuth |
| `support_category_auth_cas_issues_errors` | Authentication and Authorization::CAS OmniAuth::Issues/errors |
| `support_category_auth_cas_other` | Authentication and Authorization::CAS OmniAuth::Other |
| `support_category_auth_cas_questions` | Authentication and Authorization::CAS OmniAuth::Questions |
| `support_category_auth_cas_setup_configuration` | Authentication and Authorization::CAS OmniAuth::Setup/configuration |
| `support_category_auth_cas_sync_issues` | Authentication and Authorization::CAS OmniAuth::Sync issues |
| `support_category_auth_facebook` | Authentication and Authorization::Facebook OAuth 2.0 |
| `support_category_auth_facebook_issues_errors` | Authentication and Authorization::Facebook OAuth 2.0::Issues/errors |
| `support_category_auth_facebook_other` | Authentication and Authorization::Facebook OAuth 2.0::Other |
| `support_category_auth_facebook_questions` | Authentication and Authorization::Facebook OAuth 2.0::Questions |
| `support_category_auth_facebook_setup_configuration` | Authentication and Authorization::Facebook OAuth 2.0::Setup/configuration |
| `support_category_auth_facebook_sync_issues` | Authentication and Authorization::Facebook OAuth 2.0::Sync issues |
| `support_category_auth_generic` | Authentication and Authorization::Generic OAuth2 Provider |
| `support_category_auth_generic_issues_errors` | Authentication and Authorization::Generic OAuth2 Provider::Issues/errors |
| `support_category_auth_generic_other` | Authentication and Authorization::Generic OAuth2 Provider::Other |
| `support_category_auth_generic_questions` | Authentication and Authorization::Generic OAuth2 Provider::Questions |
| `support_category_auth_generic_setup_configuration` | Authentication and Authorization::Generic OAuth2 Provider::Setup/configuration |
| `support_category_auth_generic_sync_issues` | Authentication and Authorization::Generic OAuth2 Provider::Sync issues |
| `support_category_auth_github` | Authentication and Authorization::GitHub OmniAuth |
| `support_category_auth_github_issues_errors` | Authentication and Authorization::GitHub OmniAuth::Issues/errors |
| `support_category_auth_github_other` | Authentication and Authorization::GitHub OmniAuth::Other |
| `support_category_auth_github_questions` | Authentication and Authorization::GitHub OmniAuth::Questions |
| `support_category_auth_github_setup_configuration` | Authentication and Authorization::GitHub OmniAuth::Setup/configuration |
| `support_category_auth_github_sync_issues` | Authentication and Authorization::GitHub OmniAuth::Sync issues |
| `support_category_auth_gitlab` | Authentication and Authorization::GitLab.com OmniAuth |
| `support_category_auth_gitlab_issues_errors` | Authentication and Authorization::GitLab.com OmniAuth::Issues/errors |
| `support_category_auth_gitlab_other` | Authentication and Authorization::GitLab.com OmniAuth::Other |
| `support_category_auth_gitlab_questions` | Authentication and Authorization::GitLab.com OmniAuth::Questions |
| `support_category_auth_gitlab_setup_configuration` | Authentication and Authorization::GitLab.com OmniAuth::Setup/configuration |
| `support_category_auth_gitlab_sync_issues` | Authentication and Authorization::GitLab.com OmniAuth::Sync issues |
| `support_category_auth_google` | Authentication and Authorization::Google OAuth 2.0 OmniAuth |
| `support_category_auth_google_issues_errors` | Authentication and Authorization::Google OAuth 2.0 OmniAuth::Issues/errors |
| `support_category_auth_google_other` | Authentication and Authorization::Google OAuth 2.0 OmniAuth::Other |
| `support_category_auth_google_questions` | Authentication and Authorization::Google OAuth 2.0 OmniAuth::Questions |
| `support_category_auth_google_setup_configuration` | Authentication and Authorization::Google OAuth 2.0 OmniAuth::Setup/configuration |
| `support_category_auth_google_sync_issues` | Authentication and Authorization::Google OAuth 2.0 OmniAuth::Sync issues |
| `support_category_auth_jwt` | Authentication and Authorization::JWT OmniAuth |
| `support_category_auth_jwt_issues_errors` | Authentication and Authorization::JWT OmniAuth::Issues/errors |
| `support_category_auth_jwt_other` | Authentication and Authorization::JWT OmniAuth::Other |
| `support_category_auth_jwt_questions` | Authentication and Authorization::JWT OmniAuth::Questions |
| `support_category_auth_jwt_setup_configuration` | Authentication and Authorization::JWT OmniAuth::Setup/configuration |
| `support_category_auth_jwt_sync_issues` | Authentication and Authorization::JWT OmniAuth::Sync issues |
| `support_category_auth_kerberos` | Authentication and Authorization::Kerberos Auth integration |
| `support_category_auth_kerberos_issues_errors` | Authentication and Authorization::Kerberos Auth integration::Issues/errors |
| `support_category_auth_kerberos_other` | Authentication and Authorization::Kerberos Auth integration::Other |
| `support_category_auth_kerberos_questions` | Authentication and Authorization::Kerberos Auth integration::Questions |
| `support_category_auth_kerberos_setup_configuration` | Authentication and Authorization::Kerberos Auth integration::Setup/configuration |
| `support_category_auth_kerberos_sync_issues` | Authentication and Authorization::Kerberos Auth integration::Sync issues |
| `support_category_auth_ldap` | Authentication and Authorization::LDAP |
| `support_category_auth_ldap_issues_errors` | Authentication and Authorization::LDAP::Issues/errors |
| `support_category_auth_ldap_other` | Authentication and Authorization::LDAP::Other |
| `support_category_auth_ldap_questions` | Authentication and Authorization::LDAP::Questions |
| `support_category_auth_ldap_setup_configuration` | Authentication and Authorization::LDAP::Setup/configuration |
| `support_category_auth_ldap_sync_issues` | Authentication and Authorization::LDAP::Sync issues |
| `support_category_auth_oauth_service_provider` | Authentication and Authorization::OAuth service provider |
| `support_category_auth_oauth_service_provider_issues_errors` | Authentication and Authorization::OAuth service provider::Issues/errors |
| `support_category_auth_oauth_service_provider_other` | Authentication and Authorization::OAuth service provider::Other |
| `support_category_auth_oauth_service_provider_questions` | Authentication and Authorization::OAuth service provider::Questions |
| `support_category_auth_oauth_service_provider_setup_configuration` | Authentication and Authorization::OAuth service provider::Setup/configuration |
| `support_category_auth_oauth_service_provider_sync_issues` | Authentication and Authorization::OAuth service provider::Sync issues |
| `support_category_auth_openid_connect` | Authentication and Authorization::OpenID Connect OmniAuth |
| `support_category_auth_openid_connect_issues_errors` | Authentication and Authorization::OpenID Connect OmniAuth::Issues/errors |
| `support_category_auth_openid_connect_other` | Authentication and Authorization::OpenID Connect OmniAuth::Other |
| `support_category_auth_openid_connect_questions` | Authentication and Authorization::OpenID Connect OmniAuth::Questions |
| `support_category_auth_openid_connect_setup_configuration` | Authentication and Authorization::OpenID Connect OmniAuth::Setup/configuration |
| `support_category_auth_openid_connect_sync_issues` | Authentication and Authorization::OpenID Connect OmniAuth::Sync issues |
| `support_category_auth_other` | Authentication and Authorization::Other |
| `support_category_auth_other_issues_errors` | Authentication and Authorization::Other::Issues/errors |
| `support_category_auth_other_other` | Authentication and Authorization::Other::Other |
| `support_category_auth_other_questions` | Authentication and Authorization::Other::Questions |
| `support_category_auth_other_setup_configuration` | Authentication and Authorization::Other::Setup/configuration |
| `support_category_auth_other_sync_issues` | Authentication and Authorization::Other::Sync issues |
| `support_category_auth_salesforce` | Authentication and Authorization::Salesforce OmniAuth |
| `support_category_auth_salesforce_issues_errors` | Authentication and Authorization::Salesforce OmniAuth::Issues/errors |
| `support_category_auth_salesforce_other` | Authentication and Authorization::Salesforce OmniAuth::Other |
| `support_category_auth_salesforce_questions` | Authentication and Authorization::Salesforce OmniAuth::Questions |
| `support_category_auth_salesforce_setup_configuration` | Authentication and Authorization::Salesforce OmniAuth::Setup/configuration |
| `support_category_auth_salesforce_sync_issues` | Authentication and Authorization::Salesforce OmniAuth::Sync issues |
| `support_category_auth_saml` | Authentication and Authorization::SAML |
| `support_category_auth_saml_issues_errors` | Authentication and Authorization::SAML::Issues/errors |
| `support_category_auth_saml_other` | Authentication and Authorization::SAML::Other |
| `support_category_auth_saml_questions` | Authentication and Authorization::SAML::Questions |
| `support_category_auth_saml_setup_configuration` | Authentication and Authorization::SAML::Setup/configuration |
| `support_category_auth_saml_sync_issues` | Authentication and Authorization::SAML::Sync issues |
| `support_category_auth_scim` | Authentication and Authorization::SCIM |
| `support_category_auth_scim_issues_errors` | Authentication and Authorization::SCIM::Issues/errors |
| `support_category_auth_scim_other` | Authentication and Authorization::SCIM::Other |
| `support_category_auth_scim_questions` | Authentication and Authorization::SCIM::Questions |
| `support_category_auth_scim_setup_configuration` | Authentication and Authorization::SCIM::Setup/configuration |
| `support_category_auth_scim_sync_issues` | Authentication and Authorization::SCIM::Sync issues |
| `support_category_auth_smartcard` | Authentication and Authorization::Smartcard authentication |
| `support_category_auth_smartcard_issues_errors` | Authentication and Authorization::Smartcard authentication::Issues/errors |
| `support_category_auth_smartcard_other` | Authentication and Authorization::Smartcard authentication::Other |
| `support_category_auth_smartcard_questions` | Authentication and Authorization::Smartcard authentication::Questions |
| `support_category_auth_smartcard_setup_configuration` | Authentication and Authorization::Smartcard authentication::Setup/configuration |
| `support_category_auth_smartcard_sync_issues` | Authentication and Authorization::Smartcard authentication::Sync issues |
| `support_category_auth_twitter` | Authentication and Authorization::Twitter OAuth |
| `support_category_auth_twitter_issues_errors` | Authentication and Authorization::Twitter OAuth::Issues/errors |
| `support_category_auth_twitter_other` | Authentication and Authorization::Twitter OAuth::Other |
| `support_category_auth_twitter_questions` | Authentication and Authorization::Twitter OAuth::Questions |
| `support_category_auth_twitter_setup_configuration` | Authentication and Authorization::Twitter OAuth::Setup/configuration |
| `support_category_auth_twitter_sync_issues` | Authentication and Authorization::Twitter OAuth::Sync issues |
| `support_category_auth_vault` | Authentication and Authorization::Vault Authentication with OpenID |
| `support_category_auth_vault_issues_errors` | Authentication and Authorization::Vault Authentication with OpenID::Issues/errors |
| `support_category_auth_vault_other` | Authentication and Authorization::Vault Authentication with OpenID::Other |
| `support_category_auth_vault_questions` | Authentication and Authorization::Vault Authentication with OpenID::Questions |
| `support_category_auth_vault_setup_configuration` | Authentication and Authorization::Vault Authentication with OpenID::Setup/configuration |
| `support_category_auth_vault_sync_issues` | Authentication and Authorization::Vault Authentication with OpenID::Sync issues |
| `support_category_category_administering_gitlab` | Maintaining/Administering GitLab |
| `support_category_category_analyze_usage` | GitLab analytics |
| `support_category_category_auth` | Authentication and Authorization |
| `support_category_category_cicd` | CI/CD |
| `support_category_category_deployments` | Deployments and Releases |
| `support_category_category_gitlab_duo` | GitLab Duo |
| `support_category_category_instance_management` | Installing/Configuring/Migrating GitLab |
| `support_category_category_integrations` | Integrate applications |
| `support_category_category_manage_infra` | Manage your infrastructure via GitLab |
| `support_category_category_monitoring` | Application Performance Monitoring |
| `support_category_category_other` | Other |
| `support_category_category_packages` | Packages and Registries |
| `support_category_category_performance` | Performance issues with GitLab components |
| `support_category_category_project_group_management` | Project & Group Management |
| `support_category_category_runners` | GitLab Runners |
| `support_category_category_secure` | Secure |
| `support_category_category_upgrade_assistance` | Upgrade assistance request |
| `support_category_category_usage_quotas` | Usage Quotas |
| `support_category_cicd_artifacts` | CI/CD::Artifacts |
| `support_category_cicd_artifacts_creation_topic` | CI/CD::Artifacts::Creation |
| `support_category_cicd_artifacts_errors_topic` | CI/CD::Artifacts::Errors/issues |
| `support_category_cicd_artifacts_management_topic` | CI/CD::Artifacts::Management |
| `support_category_cicd_artifacts_other_topic` | CI/CD::Artifacts::Other |
| `support_category_cicd_artifacts_questions_topic` | CI/CD::Artifacts::Questions |
| `support_category_cicd_autodevops` | CI/CD::Auto DevOps |
| `support_category_cicd_autodevops_errors` | CI/CD::Auto DevOps::Issues/errors |
| `support_category_cicd_autodevops_other` | CI/CD::Auto DevOps::Other |
| `support_category_cicd_autodevops_questions` | CI/CD::Auto DevOps::Questions |
| `support_category_cicd_autodevops_setup` | CI/CD::Auto DevOps::Setup/configuration |
| `support_category_cicd_cache` | CI/CD::Cache |
| `support_category_cicd_cache_creation` | CI/CD::Cache::Creation |
| `support_category_cicd_cache_errors` | CI/CD::Cache::Errors/issues |
| `support_category_cicd_cache_management` | CI/CD::Cache::Management |
| `support_category_cicd_cache_other` | CI/CD::Cache::Other |
| `support_category_cicd_cache_questions` | CI/CD::Cache::Questions |
| `support_category_cicd_ci_file` | CI/CD::CI file configuration |
| `support_category_cicd_ci_file_errors` | CI/CD::CI file configuration::Errors/issues |
| `support_category_cicd_ci_file_other` | CI/CD::CI file configuration::Other |
| `support_category_cicd_ci_file_questions` | CI/CD::CI file configuration::Questions |
| `support_category_cicd_ci_file_setup` | CI/CD::CI file configuration::Setup/configuration |
| `support_category_cicd_deployments` | CI/CD::Deployments |
| `support_category_cicd_deployments_environments` | CI/CD::Deployments::Environments |
| `support_category_cicd_deployments_feature_flags` | CI/CD::Deployments::Feature Flags |
| `support_category_cicd_deployments_releases` | CI/CD::Deployments::Releases |
| `support_category_cicd_deployments_review_apps` | CI/CD::Deployments::Review Apps |
| `support_category_cicd_jobs` | CI/CD::Jobs |
| `support_category_cicd_jobs_errors` | CI/CD::Jobs::Errors/issues |
| `support_category_cicd_jobs_other` | CI/CD::Jobs::Other |
| `support_category_cicd_jobs_questions` | CI/CD::Jobs::Questions |
| `support_category_cicd_jobs_setup` | CI/CD::Jobs::Setup/configuration |
| `support_category_cicd_other` | CI/CD::Other |
| `support_category_cicd_pipelines` | CI/CD::Pipelines |
| `support_category_cicd_pipelines_errors` | CI/CD::Pipelines::Errors/issues |
| `support_category_cicd_pipelines_merge_trains` | CI/CD::Pipelines::Merge trains |
| `support_category_cicd_pipelines_multiproject` | CI/CD::Pipelines::Multi-project pipelines |
| `support_category_cicd_pipelines_other` | CI/CD::Pipelines::Other |
| `support_category_cicd_pipelines_questions` | CI/CD::Pipelines::Questions |
| `support_category_cicd_pipelines_schedules` | CI/CD::Pipelines::Schedules |
| `support_category_cicd_pipelines_setup` | CI/CD::Pipelines::Setup/configuration |
| `support_category_cicd_pipelines_triggers` | CI/CD::Pipelines::Triggers |
| `support_category_cicd_variables` | CI/CD::Variables |
| `support_category_cicd_variables_ci_file` | CI/CD::Variables::Via CI file |
| `support_category_cicd_variables_group` | CI/CD::Variables::Via group settings |
| `support_category_cicd_variables_project` | CI/CD::Variables::Via project settings |
| `support_category_cicd_variables_schedules` | CI/CD::Variables::Via schedules |
| `support_category_deployments_deployments` | Deployments and Releases::Deployments |
| `support_category_deployments_deployments_errors_` | Deployments and Releases::Deployments::Issues/Errors |
| `support_category_deployments_deployments_other_` | Deployments and Releases::Deployments::Other |
| `support_category_deployments_deployments_protected_envs_` | Deployments and Releases::Deployments::Protected environments |
| `support_category_deployments_deployments_questions_` | Deployments and Releases::Deployments::Questions |
| `support_category_deployments_deployments_rollouts_` | Deployments and Releases::Deployments::Rollouts |
| `support_category_deployments_deployments_setup_` | Deployments and Releases::Deployments::Setup/configuration |
| `support_category_deployments_envs` | Deployments and Releases::Environments |
| `support_category_deployments_envs_errors` | Deployments and Releases::Environments::Issues/Errors |
| `support_category_deployments_envs_other` | Deployments and Releases::Environments::Other |
| `support_category_deployments_envs_protected_envs` | Deployments and Releases::Environments::Protected environments |
| `support_category_deployments_envs_questions` | Deployments and Releases::Environments::Questions |
| `support_category_deployments_envs_rollouts` | Deployments and Releases::Environments::Rollouts |
| `support_category_deployments_envs_setup` | Deployments and Releases::Environments::Setup/configuration |
| `support_category_deployments_feature_flags` | Deployments and Releases::Feature Flags |
| `support_category_deployments_feature_flags_errors_` | Deployments and Releases::Feature Flags::Issues/Errors |
| `support_category_deployments_feature_flags_other_` | Deployments and Releases::Feature Flags::Other |
| `support_category_deployments_feature_flags_protected_envs_` | Deployments and Releases::Feature Flags::Protected environments |
| `support_category_deployments_feature_flags_questions_` | Deployments and Releases::Feature Flags::Questions |
| `support_category_deployments_feature_flags_rollouts_` | Deployments and Releases::Feature Flags::Rollouts |
| `support_category_deployments_feature_flags_setup_` | Deployments and Releases::Feature Flags::Setup/configuration |
| `support_category_deployments_other` | Deployments and Releases::Other |
| `support_category_deployments_other_errors_` | Deployments and Releases::Other::Issues/Errors |
| `support_category_deployments_other_other_` | Deployments and Releases::Other::Other |
| `support_category_deployments_other_protected_envs_` | Deployments and Releases::Other::Protected environments |
| `support_category_deployments_other_questions_` | Deployments and Releases::Other::Questions |
| `support_category_deployments_other_rollouts_` | Deployments and Releases::Other::Rollouts |
| `support_category_deployments_other_setup_` | Deployments and Releases::Other::Setup/configuration |
| `support_category_deployments_releases` | Deployments and Releases::Releases |
| `support_category_deployments_releases_errors_` | Deployments and Releases::Releases::Issues/Errors |
| `support_category_deployments_releases_other_` | Deployments and Releases::Releases::Other |
| `support_category_deployments_releases_protected_envs_` | Deployments and Releases::Releases::Protected environments |
| `support_category_deployments_releases_questions_` | Deployments and Releases::Releases::Questions |
| `support_category_deployments_releases_rollouts_` | Deployments and Releases::Releases::Rollouts |
| `support_category_deployments_releases_setup_` | Deployments and Releases::Releases::Setup/configuration |
| `support_category_deployments_review_apps` | Deployments and Releases::Review apps |
| `support_category_deployments_review_apps_errors_` | Deployments and Releases::Review apps::Issues/Errors |
| `support_category_deployments_review_apps_other_` | Deployments and Releases::Review apps::Other |
| `support_category_deployments_review_apps_protected_envs_` | Deployments and Releases::Review apps::Protected environments |
| `support_category_deployments_review_apps_questions_` | Deployments and Releases::Review apps::Questions |
| `support_category_deployments_review_apps_rollouts_` | Deployments and Releases::Review apps::Rollouts |
| `support_category_deployments_review_apps_setup_` | Deployments and Releases::Review apps::Setup/configuration |
| `support_category_gitlab_duo_chat_errors` | GitLab Duo::Chat::Issues/Errors |
| `support_category_gitlab_duo_chat_generated_response` | GitLab Duo::Chat::Duo generated response |
| `support_category_gitlab_duo_chat_integrations` | GitLab Duo::Chat::Integration |
| `support_category_gitlab_duo_chat_licensing` | GitLab Duo::Chat::Licensing/Activation |
| `support_category_gitlab_duo_chat_questions` | GitLab Duo::Chat::Questions |
| `support_category_gitlab_duo_chat_setup` | GitLab Duo::Chat::Setup/Configuration |
| `support_category_gitlab_duo_chat_suggestion_accuracy` | GitLab Duo::Chat::Suggestion accuracy |
| `support_category_gitlab_duo_chatsupport_gitlab_duo_reviewers` | GitLab Duo::Suggested Reviewers |
| `support_category_gitlab_duo_code_suggestions_errors` | GitLab Duo::Code Suggestions::Issues/Errors |
| `support_category_gitlab_duo_code_suggestions_generated_response` | GitLab Duo::Code Suggestions::Duo generated response |
| `support_category_gitlab_duo_code_suggestions` | GitLab Duo::Code Suggestions |
| `support_category_gitlab_duo_code_suggestions_integrations` | GitLab Duo::Code Suggestions::Integration |
| `support_category_gitlab_duo_code_suggestions_licensing` | GitLab Duo::Code Suggestions::Licensing/Activation |
| `support_category_gitlab_duo_code_suggestions_questions` | GitLab Duo::Code Suggestions::Questions |
| `support_category_gitlab_duo_code_suggestions_setup` | GitLab Duo::Code Suggestions::Setup/Configuration |
| `support_category_gitlab_duo_code_suggestions_suggestion_accuracy` | GitLab Duo::Code Suggestions::Suggestion accuracy |
| `support_category_gitlab_duo_code_suggestionssupport_gitlab_duo_chat` | GitLab Duo::Chat |
| `support_category_gitlab_duo_configuration_errors` | GitLab Duo::GitLab Duo Configuration::Issues/Errors |
| `support_category_gitlab_duo_configuration_generated_response` | GitLab Duo::GitLab Duo Configuration::Duo generated response |
| `support_category_gitlab_duo_configuration_integrations` | GitLab Duo::GitLab Duo Configuration::Integration |
| `support_category_gitlab_duo_configuration_licensing` | GitLab Duo::GitLab Duo Configuration::Licensing/Activation |
| `support_category_gitlab_duo_configuration_questions` | GitLab Duo::GitLab Duo Configuration::Questions |
| `support_category_gitlab_duo_configuration_setup` | GitLab Duo::GitLab Duo Configuration::Setup/Configuration |
| `support_category_gitlab_duo_configuration_suggestion_accuracy` | GitLab Duo::GitLab Duo Configuration::Suggestion accuracy |
| `support_category_gitlab_duo_configurationsupport_gitlab_duo_other` | GitLab Duo::Other |
| `support_category_gitlab_duo_extensions_errors` | GitLab Duo::IDE Extensions::Issues/Errors |
| `support_category_gitlab_duo_extensions_generated_response` | GitLab Duo::IDE Extensions::Duo generated response |
| `support_category_gitlab_duo_extensions_integrations` | GitLab Duo::IDE Extensions::Integration |
| `support_category_gitlab_duo_extensions_licensing` | GitLab Duo::IDE Extensions::Licensing/Activation |
| `support_category_gitlab_duo_extensions_questions` | GitLab Duo::IDE Extensions::Questions |
| `support_category_gitlab_duo_extensions_setup` | GitLab Duo::IDE Extensions::Setup/Configuration |
| `support_category_gitlab_duo_extensions_suggestion_accuracy` | GitLab Duo::IDE Extensions::Suggestion accuracy |
| `support_category_gitlab_duo_extensionssupport_gitlab_duo_configuration` | GitLab Duo::GitLab Duo Configuration |
| `support_category_gitlab_duo_mr_summary_errors` | GitLab Duo::Merge Request Summary::Issues/Errors |
| `support_category_gitlab_duo_mr_summary_generated_response` | GitLab Duo::Merge Request Summary::Duo generated response |
| `support_category_gitlab_duo_mr_summary_integrations` | GitLab Duo::Merge Request Summary::Integration |
| `support_category_gitlab_duo_mr_summary_licensing` | GitLab Duo::Merge Request Summary::Licensing/Activation |
| `support_category_gitlab_duo_mr_summary_questions` | GitLab Duo::Merge Request Summary::Questions |
| `support_category_gitlab_duo_mr_summary_setup` | GitLab Duo::Merge Request Summary::Setup/Configuration |
| `support_category_gitlab_duo_mr_summary_suggestion_accuracy` | GitLab Duo::Merge Request Summary::Suggestion accuracy |
| `support_category_gitlab_duo_mr_summarysupport_gitlab_duo_vulnerabilities` | GitLab Duo::Vulnerability Explanation |
| `support_category_gitlab_duo_reviewers_errors` | GitLab Duo::Suggested Reviewers::Issues/Errors |
| `support_category_gitlab_duo_reviewers_generated_response` | GitLab Duo::Suggested Reviewers::Duo generated response |
| `support_category_gitlab_duo_reviewers_integrations` | GitLab Duo::Suggested Reviewers::Integration |
| `support_category_gitlab_duo_reviewers_licensing` | GitLab Duo::Suggested Reviewers::Licensing/Activation |
| `support_category_gitlab_duo_reviewers_questions` | GitLab Duo::Suggested Reviewers::Questions |
| `support_category_gitlab_duo_reviewers_setup` | GitLab Duo::Suggested Reviewers::Setup/Configuration |
| `support_category_gitlab_duo_reviewers_suggestion_accuracy` | GitLab Duo::Suggested Reviewers::Suggestion accuracy |
| `support_category_gitlab_duo_reviewerssupport_gitlab_duo_tests` | GitLab Duo::Test Generation |
| `support_category_gitlab_duo_tests_errors` | GitLab Duo::Test Generation::Issues/Errors |
| `support_category_gitlab_duo_tests_generated_response` | GitLab Duo::Test Generation::Duo generated response |
| `support_category_gitlab_duo_tests_integrations` | GitLab Duo::Test Generation::Integration |
| `support_category_gitlab_duo_tests_licensing` | GitLab Duo::Test Generation::Licensing/Activation |
| `support_category_gitlab_duo_tests_questions` | GitLab Duo::Test Generation::Questions |
| `support_category_gitlab_duo_tests_setup` | GitLab Duo::Test Generation::Setup/Configuration |
| `support_category_gitlab_duo_tests_suggestion_accuracy` | GitLab Duo::Test Generation::Suggestion accuracy |
| `support_category_gitlab_duo_testssupport_gitlab_duo_mr_summary` | GitLab Duo::Merge Request Summary |
| `support_category_gitlab_duo_vulnerabilities_errors` | GitLab Duo::Vulnerability Explanation::Issues/Errors |
| `support_category_gitlab_duo_vulnerabilities_generated_response` | GitLab Duo::Vulnerability Explanation::Duo generated response |
| `support_category_gitlab_duo_vulnerabilities_integrations` | GitLab Duo::Vulnerability Explanation::Integration |
| `support_category_gitlab_duo_vulnerabilities_licensing` | GitLab Duo::Vulnerability Explanation::Licensing/Activation |
| `support_category_gitlab_duo_vulnerabilities_questions` | GitLab Duo::Vulnerability Explanation::Questions |
| `support_category_gitlab_duo_vulnerabilities_setup` | GitLab Duo::Vulnerability Explanation::Setup/Configuration |
| `support_category_gitlab_duo_vulnerabilities_suggestion_accuracy` | GitLab Duo::Vulnerability Explanation::Suggestion accuracy |
| `support_category_gitlab_duo_vulnerabilitiessupport_gitlab_duo_extensions` | GitLab Duo::IDE Extensions |
| `support_category_integrations_akismet_errors` | Integrate applications::Akismet::Errors/issues |
| `support_category_integrations_akismet` | Integrate applications::Akismet |
| `support_category_integrations_akismet_other` | Integrate applications::Akismet::Other |
| `support_category_integrations_akismet_questions` | Integrate applications::Akismet::Questions |
| `support_category_integrations_akismet_setup` | Integrate applications::Akismet::Setup/configuration |
| `support_category_integrations_datadog_errors` | Integrate applications::Datadog::Errors/issues |
| `support_category_integrations_datadog` | Integrate applications::Datadog |
| `support_category_integrations_datadog_other` | Integrate applications::Datadog::Other |
| `support_category_integrations_datadog_questions` | Integrate applications::Datadog::Questions |
| `support_category_integrations_datadog_setup` | Integrate applications::Datadog::Setup/configuration |
| `support_category_integrations_elasticsearch_errors` | Integrate applications::Elasticsearch::Errors/issues |
| `support_category_integrations_elasticsearch` | Integrate applications::Elasticsearch |
| `support_category_integrations_elasticsearch_other` | Integrate applications::Elasticsearch::Other |
| `support_category_integrations_elasticsearch_questions` | Integrate applications::Elasticsearch::Questions |
| `support_category_integrations_elasticsearch_setup` | Integrate applications::Elasticsearch::Setup/configuration |
| `support_category_integrations_external_trackers_bugzilla` | Integrate applications::External issue trackers::Bugzilla |
| `support_category_integrations_external_trackers_ibm` | Integrate applications::External issue trackers::IBM EWM |
| `support_category_integrations_external_trackers` | Integrate applications::External issue trackers |
| `support_category_integrations_external_trackers_other` | Integrate applications::External issue trackers::Custom/Other issue tracker |
| `support_category_integrations_external_trackers_redmine` | Integrate applications::External issue trackers::Redmine |
| `support_category_integrations_external_trackers_youtrack` | Integrate applications::External issue trackers::YouTrack |
| `support_category_integrations_external_trackers_zentao` | Integrate applications::External issue trackers::ZenTao |
| `support_category_integrations_gitpod_errors` | Integrate applications::Gitpod::Errors/issues |
| `support_category_integrations_gitpod` | Integrate applications::Gitpod |
| `support_category_integrations_gitpod_other` | Integrate applications::Gitpod::Other |
| `support_category_integrations_gitpod_questions` | Integrate applications::Gitpod::Questions |
| `support_category_integrations_gitpod_setup` | Integrate applications::Gitpod::Setup/configuration |
| `support_category_integrations_gmail_errors` | Integrate applications::Gmail actions buttons::Errors/issues |
| `support_category_integrations_gmail` | Integrate applications::Gmail actions buttons |
| `support_category_integrations_gmail_other` | Integrate applications::Gmail actions buttons::Other |
| `support_category_integrations_gmail_questions` | Integrate applications::Gmail actions buttons::Questions |
| `support_category_integrations_gmail_setup` | Integrate applications::Gmail actions buttons::Setup/configuration |
| `support_category_integrations_jira_errors` | Integrate applications::Jira::Errors/issues |
| `support_category_integrations_jira` | Integrate applications::Jira |
| `support_category_integrations_jira_other` | Integrate applications::Jira::Other |
| `support_category_integrations_jira_questions` | Integrate applications::Jira::Questions |
| `support_category_integrations_jira_setup` | Integrate applications::Jira::Setup/configuration |
| `support_category_integrations_kroki_errors` | Integrate applications::Kroki::Errors/issues |
| `support_category_integrations_kroki` | Integrate applications::Kroki |
| `support_category_integrations_kroki_other` | Integrate applications::Kroki::Other |
| `support_category_integrations_kroki_questions` | Integrate applications::Kroki::Questions |
| `support_category_integrations_kroki_setup` | Integrate applications::Kroki::Setup/configuration |
| `support_category_integrations_mailgun_errors` | Integrate applications::Mailgun::Errors/issues |
| `support_category_integrations_mailgun` | Integrate applications::Mailgun |
| `support_category_integrations_mailgun_other` | Integrate applications::Mailgun::Other |
| `support_category_integrations_mailgun_questions` | Integrate applications::Mailgun::Questions |
| `support_category_integrations_mailgun_setup` | Integrate applications::Mailgun::Setup/configuration |
| `support_category_integrations_other_errors` | Integrate applications::Other::Errors/issues |
| `support_category_integrations_other` | Integrate applications::Other |
| `support_category_integrations_other_other` | Integrate applications::Other::Other |
| `support_category_integrations_other_questions` | Integrate applications::Other::Questions |
| `support_category_integrations_other_setup` | Integrate applications::Other::Setup/configuration |
| `support_category_integrations_pim_errors` | Integrate applications::Project integration management::Errors/issues |
| `support_category_integrations_pim` | Integrate applications::Project integration management |
| `support_category_integrations_pim_other` | Integrate applications::Project integration management::Other |
| `support_category_integrations_pim_questions` | Integrate applications::Project integration management::Questions |
| `support_category_integrations_pim_setup` | Integrate applications::Project integration management::Setup/configuration |
| `support_category_integrations_plantuml_errors` | Integrate applications::PlantUML::Errors/issues |
| `support_category_integrations_plantuml` | Integrate applications::PlantUML |
| `support_category_integrations_plantuml_other` | Integrate applications::PlantUML::Other |
| `support_category_integrations_plantuml_questions` | Integrate applications::PlantUML::Questions |
| `support_category_integrations_plantuml_setup` | Integrate applications::PlantUML::Setup/configuration |
| `support_category_integrations_project_asana` | Integrate applications::Project integrations::Asana |
| `support_category_integrations_project_bamboo` | Integrate applications::Project integrations::Bamboo |
| `support_category_integrations_project_discord` | Integrate applications::Project integrations::Discord |
| `support_category_integrations_project_emails_on_push` | Integrate applications::Project integrations::Emails on push |
| `support_category_integrations_project_github` | Integrate applications::Project integrations::GitHub |
| `support_category_integrations_project_google_chat` | Integrate applications::Project integrations::Google Chat |
| `support_category_integrations_project_` | Integrate applications::Project integrations |
| `support_category_integrations_project_irker` | Integrate applications::Project integrations::Irker |
| `support_category_integrations_project_jenkins` | Integrate applications::Project integrations::Jenkins |
| `support_category_integrations_project_mattermost` | Integrate applications::Project integrations::Mattermost |
| `support_category_integrations_project_ms_teams` | Integrate applications::Project integrations::Microsoft Teams |
| `support_category_integrations_project_other` | Integrate applications::Project integrations::Other |
| `support_category_integrations_project_pivotal` | Integrate applications::Project integrations::Pivotal tracker |
| `support_category_integrations_project_prometheus` | Integrate applications::Project integrations::Prometheus |
| `support_category_integrations_project_slack` | Integrate applications::Project integrations::Slack |
| `support_category_integrations_project_status_emails` | Integrate applications::Project integrations::Pipeline status emails |
| `support_category_integrations_project_unify_circuit` | Integrate applications::Project integrations::Unify Circuit |
| `support_category_integrations_project_webex` | Integrate applications::Project integrations::Webex |
| `support_category_integrations_project_webhooks` | Integrate applications::Project integrations::Webhooks |
| `support_category_integrations_recaptcha_errors` | Integrate applications::reCAPTCHA::Errors/issues |
| `support_category_integrations_recaptcha` | Integrate applications::reCAPTCHA |
| `support_category_integrations_recaptcha_other` | Integrate applications::reCAPTCHA::Other |
| `support_category_integrations_recaptcha_questions` | Integrate applications::reCAPTCHA::Questions |
| `support_category_integrations_recaptcha_setup` | Integrate applications::reCAPTCHA::Setup/configuration |
| `support_category_integrations_sourcegraph_errors` | Integrate applications::Sourcegraph::Errors/issues |
| `support_category_integrations_sourcegraph` | Integrate applications::Sourcegraph |
| `support_category_integrations_sourcegraph_other` | Integrate applications::Sourcegraph::Other |
| `support_category_integrations_sourcegraph_questions` | Integrate applications::Sourcegraph::Questions |
| `support_category_integrations_sourcegraph_setup` | Integrate applications::Sourcegraph::Setup/configuration |
| `support_category_integrations_trllo_errors` | Integrate applications::Trello::Errors/issues |
| `support_category_integrations_trllo` | Integrate applications::Trello |
| `support_category_integrations_trllo_other` | Integrate applications::Trello::Other |
| `support_category_integrations_trllo_questions` | Integrate applications::Trello::Questions |
| `support_category_integrations_trllo_setup` | Integrate applications::Trello::Setup/configuration |
| `support_category_integrations_visual_studio_errors` | Integrate applications::Visual Studio Code extension::Errors/issues |
| `support_category_integrations_visual_studio` | Integrate applications::Visual Studio Code extension |
| `support_category_integrations_visual_studio_other` | Integrate applications::Visual Studio Code extension::Other |
| `support_category_integrations_visual_studio_questions` | Integrate applications::Visual Studio Code extension::Questions |
| `support_category_integrations_visual_studio_setup` | Integrate applications::Visual Studio Code extension::Setup/configuration |
| `support_category_manage_infra_clusters_agent` | Manage your infrastructure via GitLab::Kubernetes clusters::Kubernetes agent |
| `support_category_manage_infra_clusters_connect` | Manage your infrastructure via GitLab::Kubernetes clusters::Connect Kubernetes clusters |
| `support_category_manage_infra_clusters_create` | Manage your infrastructure via GitLab::Kubernetes clusters::Create Kubnernetes clusters |
| `support_category_manage_infra_clusters_errors` | Manage your infrastructure via GitLab::Kubernetes clusters::Issues/errors |
| `support_category_manage_infra_clusters_gitops` | Manage your infrastructure via GitLab::Kubernetes clusters::GitOps |
| `support_category_manage_infra_clusters` | Manage your infrastructure via GitLab::Kubernetes clusters |
| `support_category_manage_infra_clusters_migrate` | Manage your infrastructure via GitLab::Kubernetes clusters::Migrate to the GitLab agent for Kubernetes |
| `support_category_manage_infra_clusters_other` | Manage your infrastructure via GitLab::Kubernetes clusters::Other |
| `support_category_manage_infra_clusters_vulnerability_scanning` | Manage your infrastructure via GitLab::Kubernetes clusters::Container vulnerability scanning |
| `support_category_manage_infra_code_errors` | Manage your infrastructure via GitLab::Infrastructure as Code::Issues/errors |
| `support_category_manage_infra_code` | Manage your infrastructure via GitLab::Infrastructure as Code |
| `support_category_manage_infra_code_other` | Manage your infrastructure via GitLab::Infrastructure as Code::Other |
| `support_category_manage_infra_code_questions` | Manage your infrastructure via GitLab::Infrastructure as Code::Questions |
| `support_category_manage_infra_code_setup` | Manage your infrastructure via GitLab::Infrastructure as Code::Setup/configuration |
| `support_category_manage_infra_code_tf_integration` | Manage your infrastructure via GitLab::Infrastructure as Code::Terraform integration in merge requests |
| `support_category_manage_infra_code_tf_state` | Manage your infrastructure via GitLab::Infrastructure as Code::Terraform state |
| `support_category_manage_infra_other` | Manage your infrastructure via GitLab::Other |
| `support_category_manage_infra_runbooks_errors` | Manage your infrastructure via GitLab::Runbooks::Issues/errors |
| `support_category_manage_infra_runbooks` | Manage your infrastructure via GitLab::Runbooks |
| `support_category_manage_infra_runbooks_other` | Manage your infrastructure via GitLab::Runbooks::Other |
| `support_category_manage_infra_runbooks_questions` | Manage your infrastructure via GitLab::Runbooks::Questions |
| `support_category_manage_infra_runbooks_setup` | Manage your infrastructure via GitLab::Runbooks::Setup/configuration |
| `support_category_monitoring_error_tracking` | Application Performance Monitoring::Error Tracking |
| `support_category_monitoring_error_tracking_errors` | Application Performance Monitoring::Error Tracking::Issues/errors |
| `support_category_monitoring_error_tracking_other` | Application Performance Monitoring::Error Tracking::Other |
| `support_category_monitoring_error_tracking_questions` | Application Performance Monitoring::Error Tracking::Questions |
| `support_category_monitoring_error_tracking_setup` | Application Performance Monitoring::Error Tracking::Setup/configuration |
| `support_category_monitoring_incidents_alerts` | Application Performance Monitoring::Incident Management::Alerts |
| `support_category_monitoring_incidents` | Application Performance Monitoring::Incident Management |
| `support_category_monitoring_incidents_escalations` | Application Performance Monitoring::Incident Management::Escalation Policies |
| `support_category_monitoring_incidents_incidents` | Application Performance Monitoring::Incident Management::Incidents |
| `support_category_monitoring_incidents_oncall` | Application Performance Monitoring::Incident Management::On-call Schedules |
| `support_category_monitoring_incidents_other` | Application Performance Monitoring::Incident Management::Other |
| `support_category_monitoring_incidents_paging` | Application Performance Monitoring::Incident Management::Paging and notifications |
| `support_category_monitoring_incidents_status_page` | Application Performance Monitoring::Incident Management::Status Page |
| `support_category_monitoring_other` | Application Performance Monitoring::Other |
| `support_category_monitoring_product_analytics` | Application Performance Monitoring::Product Analytics |
| `support_category_monitoring_product_analytics_errors` | Application Performance Monitoring::Product Analytics::Issues/errors |
| `support_category_monitoring_product_analytics_other` | Application Performance Monitoring::Product Analytics::Other |
| `support_category_monitoring_product_analytics_questions` | Application Performance Monitoring::Product Analytics::Questions |
| `support_category_monitoring_product_analytics_setup` | Application Performance Monitoring::Product Analytics::Setup/configuration |
| `support_category_packages_composer_building` | Packages and Registries::Composer Packages::Creating/building/publishing packages |
| `support_category_packages_composer_installing` | Packages and Registries::Composer Packages::Installing packages |
| `support_category_packages_composer_other` | Packages and Registries::Composer Packages::Other |
| `support_category_packages_composer` | Packages and Registries::Composer Packages |
| `support_category_packages_composer_questions` | Packages and Registries::Composer Packages::Questions |
| `support_category_packages_container_building` | Packages and Registries::Container Registry |
| `support_category_packages_container_deleting` | Packages and Registries::Container Registry |
| `support_category_packages_container_errors` | Packages and Registries::Container Registry |
| `support_category_packages_container_other` | Packages and Registries::Container Registry |
| `support_category_packages_container` | Packages and Registries::Container Registry |
| `support_category_packages_container_questions` | Packages and Registries::Container Registry |
| `support_category_packages_dependency_proxy_errors` | Packages and Registries::Dependency Proxy::Issues/Errors |
| `support_category_packages_dependency_proxy_other` | Packages and Registries::Dependency Proxy::Other |
| `support_category_packages_dependency_proxy` | Packages and Registries::Dependency Proxy |
| `support_category_packages_dependency_proxy_questions` | Packages and Registries::Dependency Proxy::Questions |
| `support_category_packages_generic_building` | Packages and Registries::Generic/Other Packages::Creating/building/publishing packages |
| `support_category_packages_generic_installing` | Packages and Registries::Generic/Other Packages::Installing packages |
| `support_category_packages_generic_other` | Packages and Registries::Generic/Other Packages::Other |
| `support_category_packages_generic` | Packages and Registries::Generic/Other Packages |
| `support_category_packages_generic_questions` | Packages and Registries::Generic/Other Packages::Questions |
| `support_category_packages_infra_building` | Packages and Registries::Infrastructure Registry::Building and pushing images |
| `support_category_packages_infra_deleting` | Packages and Registries::Infrastructure Registry::Deleting images |
| `support_category_packages_infra_errors` | Packages and Registries::Infrastructure Registry::Issues/Errors |
| `support_category_packages_infra_other` | Packages and Registries::Infrastructure Registry::Other |
| `support_category_packages_infra` | Packages and Registries::Infrastructure Registry |
| `support_category_packages_infra_questions` | Packages and Registries::Infrastructure Registry::Questions |
| `support_category_packages_maven_building` | Packages and Registries::Maven Packages::Creating/building/publishing packages |
| `support_category_packages_maven_installing` | Packages and Registries::Maven Packages::Installing packages |
| `support_category_packages_maven_other` | Packages and Registries::Maven Packages::Other |
| `support_category_packages_maven` | Packages and Registries::Maven Packages |
| `support_category_packages_maven_questions` | Packages and Registries::Maven Packages::Questions |
| `support_category_packages_npm_building` | Packages and Registries::npm Packages::Creating/building/publishing packages |
| `support_category_packages_npm_installing` | Packages and Registries::npm Packages::Installing packages |
| `support_category_packages_npm_other` | Packages and Registries::npm Packages::Other |
| `support_category_packages_npm` | Packages and Registries::npm Packages |
| `support_category_packages_npm_questions` | Packages and Registries::npm Packages::Questions |
| `support_category_packages_nuget_building` | Packages and Registries::NuGet Packages::Creating/building/publishing packages |
| `support_category_packages_nuget_installing` | Packages and Registries::NuGet Packages::Installing packages |
| `support_category_packages_nuget_other` | Packages and Registries::NuGet Packages::Other |
| `support_category_packages_nuget` | Packages and Registries::NuGet Packages |
| `support_category_packages_nuget_questions` | Packages and Registries::NuGet Packages::Questions |
| `support_category_packages_other` | Packages and Registries::Other |
| `support_category_packages_pypi_building` | Packages and Registries::PyPI Packages::Creating/building/publishing packages |
| `support_category_packages_pypi_installing` | Packages and Registries::PyPI Packages::Installing packages |
| `support_category_packages_pypi_other` | Packages and Registries::PyPI Packages::Other |
| `support_category_packages_pypi` | Packages and Registries::PyPI Packages |
| `support_category_packages_pypi_questions` | Packages and Registries::PyPI Packages::Questions |
| `support_category_performance_agent` | Performance issues with GitLab components::GitLab agent |
| `support_category_performance_alertmanager` | Performance issues with GitLab components::Alertmanager |
| `support_category_performance_certifcates` | Performance issues with GitLab components::Certificate management |
| `support_category_performance_consul` | Performance issues with GitLab components::Consul |
| `support_category_performance_database` | Performance issues with GitLab components::PostgreSQL/Database |
| `support_category_performance_emails` | Performance issues with GitLab components::Outbound/Inbounce Emails |
| `support_category_performance_exporter` | Performance issues with GitLab components::GitLab Exporter |
| `support_category_performance_geo` | Performance issues with GitLab components::GitLab Geo |
| `support_category_performance_gitaly` | Performance issues with GitLab components::Gitaly |
| `support_category_performance_grafana` | Performance issues with GitLab components::Grafana |
| `support_category_performance_lfs` | Performance issues with GitLab components::LFS |
| `support_category_performance_logrotate` | Performance issues with GitLab components::Logrotate |
| `support_category_performance_mattermost` | Performance issues with GitLab components::Mattermost |
| `support_category_performance_nginx` | Performance issues with GitLab components::Nginx |
| `support_category_performance_node_exporter` | Performance issues with GitLab components::Node Exporter |
| `support_category_performance_object_storage` | Performance issues with GitLab components::MinIO/Object storage |
| `support_category_performance_other` | Performance issues with GitLab components::Other/Unsure |
| `support_category_performance_patroni` | Performance issues with GitLab components::Patroni |
| `support_category_performance_pgbouncer` | Performance issues with GitLab components::PgBouncer |
| `support_category_performance_praefect` | Performance issues with GitLab components::Praefect |
| `support_category_performance_prometheus` | Performance issues with GitLab components::Prometheus |
| `support_category_performance_puma` | Performance issues with GitLab components::Puma |
| `support_category_performance_redis` | Performance issues with GitLab components::Redis |
| `support_category_performance_registry` | Performance issues with GitLab components::Registry |
| `support_category_performance_sentry` | Performance issues with GitLab components::Sentry |
| `support_category_performance_sidekiq` | Performance issues with GitLab components::Sidekiq |
| `support_category_performance_ssl` | Performance issues with GitLab components::SSL/TLS |
| `support_category_performance_workhorse` | Performance issues with GitLab components::GitLab Workhorse |
| `support_category_pg_management_group_creation` | Project & Group Management::Group related::Creation |
| `support_category_pg_management_group_errors` | Project & Group Management::Group related::Errors/issues |
| `support_category_pg_management_group_memberships` | Project & Group Management::Group related::Memberships |
| `support_category_pg_management_group_other` | Project & Group Management::Group related::Other |
| `support_category_pg_management_group` | Project & Group Management::Group related |
| `support_category_pg_management_group_questions` | Project & Group Management::Group related::Questions |
| `support_category_pg_management_group_settings` | Project & Group Management::Group related::Management/Settings |
| `support_category_pg_management_issues_boards` | Project & Group Management::Issues/Epics related::Issue Boards |
| `support_category_pg_management_issues_creation` | Project & Group Management::Issues/Epics related::Creation |
| `support_category_pg_management_issues_designs` | Project & Group Management::Issues/Epics related::Issue Designs |
| `support_category_pg_management_issues_errors` | Project & Group Management::Issues/Epics related::Errors/issues |
| `support_category_pg_management_issues_other` | Project & Group Management::Issues/Epics related::Other |
| `support_category_pg_management_issues` | Project & Group Management::Issues/Epics related |
| `support_category_pg_management_issues_questions` | Project & Group Management::Issues/Epics related::Questions |
| `support_category_pg_management_issues_settings` | Project & Group Management::Issues/Epics related::Management/Settings |
| `support_category_pg_management_issues_summarize_comments` | Project & Group Management::Issues/Epics related::Summarize Issue Comments |
| `support_category_pg_management_iterations_iterations` | Project & Group Management::Iterations/Milestones related::Iterations |
| `support_category_pg_management_iterations_milestones` | Project & Group Management::Iterations/Milestones related::Milestones |
| `support_category_pg_management_iterations` | Project & Group Management::Iterations/Milestones related |
| `support_category_pg_management_labels_group` | Project & Group Management::Labels related::Group Labels |
| `support_category_pg_management_labels` | Project & Group Management::Labels related |
| `support_category_pg_management_labels_project` | Project & Group Management::Labels related::Project Labels |
| `support_category_pg_management_mrs_approvals` | Project & Group Management::Merge Requests related::Approval rules/settings |
| `support_category_pg_management_mrs_changes` | Project & Group Management::Merge Requests related::Changes |
| `support_category_pg_management_mrs_conflicts` | Project & Group Management::Merge Requests related::Conflicts |
| `support_category_pg_management_mrs_creation` | Project & Group Management::Merge Requests related::Creation |
| `support_category_pg_management_mrs_dependencies` | Project & Group Management::Merge Requests related::Dependencies |
| `support_category_pg_management_mrs_generate_tests` | Project & Group Management::Merge Requests related::Generate tests in MR |
| `support_category_pg_management_mrs_management` | Project & Group Management::Merge Requests related::Management |
| `support_category_pg_management_mrs_other` | Project & Group Management::Merge Requests related::Other |
| `support_category_pg_management_mrs` | Project & Group Management::Merge Requests related |
| `support_category_pg_management_mrs_suggested_reviewers` | Project & Group Management::Merge Requests related::Suggested Reviewers |
| `support_category_pg_management_mrs_summarize_changes` | Project & Group Management::Merge Requests related::Summarize proposed MR Changes |
| `support_category_pg_management_mrs_summarize_mr` | Project & Group Management::Merge Requests related::Summarize my MR review |
| `support_category_pg_management_other` | Project & Group Management::Other |
| `support_category_pg_management_project_creation` | Project & Group Management::Project related::Creation |
| `support_category_pg_management_project_errors` | Project & Group Management::Project related::Errors/issues |
| `support_category_pg_management_project_import_export` | Project & Group Management::Project related::Import/Export |
| `support_category_pg_management_project_other` | Project & Group Management::Project related::Other |
| `support_category_pg_management_project_pages` | Project & Group Management::Project related::GitLab Pages |
| `support_category_pg_management_project` | Project & Group Management::Project related |
| `support_category_pg_management_project_questions` | Project & Group Management::Project related::Questions |
| `support_category_pg_management_project_service_desk` | Project & Group Management::Project related::Service Desk |
| `support_category_pg_management_project_settings` | Project & Group Management::Project related::Management/Settings |
| `support_category_pg_management_repository_branches` | Project & Group Management::Repository related::Branches |
| `support_category_pg_management_repository_code_owners` | Project & Group Management::Repository related::Code owners |
| `support_category_pg_management_repository_code_suggestions` | Project & Group Management::Repository related::Code suggestions |
| `support_category_pg_management_repository_creation` | Project & Group Management::Repository related::Creation |
| `support_category_pg_management_repository_explain_code` | Project & Group Management::Repository related::Explain this block of code |
| `support_category_pg_management_repository_forking` | Project & Group Management::Repository related::Forking |
| `support_category_pg_management_repository_gitlab_chat` | Project & Group Management::Repository related::GitLab Chat |
| `support_category_pg_management_repository_lfs` | Project & Group Management::Repository related::LFS |
| `support_category_pg_management_repository_mirroring` | Project & Group Management::Repository related::Mirroring |
| `support_category_pg_management_repository_other` | Project & Group Management::Repository related::Other |
| `support_category_pg_management_repository` | Project & Group Management::Repository related |
| `support_category_pg_management_repository_settings` | Project & Group Management::Repository related::Management/Settings |
| `support_category_pg_management_repository_snippets` | Project & Group Management::Repository related::Snippets |
| `support_category_pg_management_requirements_creation` | Project & Group Management::Requirements Management::Creation |
| `support_category_pg_management_requirements_errors` | Project & Group Management::Requirements Management::Errors/issues |
| `support_category_pg_management_requirements_other` | Project & Group Management::Requirements Management::Other |
| `support_category_pg_management_requirements` | Project & Group Management::Requirements Management |
| `support_category_pg_management_requirements_questions` | Project & Group Management::Requirements Management::Questions |
| `support_category_pg_management_requirements_settings` | Project & Group Management::Requirements Management::Management/Settings |
| `support_category_pg_management_roadmaps` | Project & Group Management::Roadmaps |
| `support_category_pg_management_user_creation` | Project & Group Management::User related::Creation |
| `support_category_pg_management_user_errors` | Project & Group Management::User related::Errors/issues |
| `support_category_pg_management_user_other` | Project & Group Management::User related::Other |
| `support_category_pg_management_user` | Project & Group Management::User related |
| `support_category_pg_management_user_questions` | Project & Group Management::User related::Questions |
| `support_category_pg_management_user_settings` | Project & Group Management::User related::Management/Settings |
| `support_category_pg_management_user_todo_lists` | Project & Group Management::User related::To-Do Lists |
| `support_category_pg_management_wiki_group` | Project & Group Management::Wiki related::Group Wikis |
| `support_category_pg_management_wiki` | Project & Group Management::Wiki related |
| `support_category_pg_management_wiki_project` | Project & Group Management::Wiki related::Project Wikis |
| `support_category_runners_agent_configuration` | GitLab Runners::Kubernetes - Agent::Configuration |
| `support_category_runners_agent_errors` | GitLab Runners::Kubernetes - Agent::Issues/Errors |
| `support_category_runners_agent` | GitLab Runners::Kubernetes - Agent |
| `support_category_runners_agent_installation` | GitLab Runners::Kubernetes - Agent::Installation/Registration |
| `support_category_runners_agent_other_topic` | GitLab Runners::Kubernetes - Agent::Other |
| `support_category_runners_agent_questions` | GitLab Runners::Kubernetes - Agent::Questions |
| `support_category_runners_docker_configuration` | GitLab Runners::Docker::Configuration |
| `support_category_runners_docker_errors` | GitLab Runners::Docker::Issues/Errors |
| `support_category_runners_docker` | GitLab Runners::Docker |
| `support_category_runners_docker_installation` | GitLab Runners::Docker::Installation/Registration |
| `support_category_runners_docker_other_topic` | GitLab Runners::Docker::Other |
| `support_category_runners_docker_questions` | GitLab Runners::Docker::Questions |
| `support_category_runners_freebsd_configuration` | GitLab Runners::FreeBSD::Configuration |
| `support_category_runners_freebsd_errors` | GitLab Runners::FreeBSD::Issues/Errors |
| `support_category_runners_freebsd` | GitLab Runners::FreeBSD |
| `support_category_runners_freebsd_installation` | GitLab Runners::FreeBSD::Installation/Registration |
| `support_category_runners_freebsd_other_topic` | GitLab Runners::FreeBSD::Other |
| `support_category_runners_freebsd_questions` | GitLab Runners::FreeBSD::Questions |
| `support_category_runners_helm_configuration` | GitLab Runners::Kubernetes - Helm::Configuration |
| `support_category_runners_helm_errors` | GitLab Runners::Kubernetes - Helm::Issues/Errors |
| `support_category_runners_helm` | GitLab Runners::Kubernetes - Helm |
| `support_category_runners_helm_installation` | GitLab Runners::Kubernetes - Helm::Installation/Registration |
| `support_category_runners_helm_other_topic` | GitLab Runners::Kubernetes - Helm::Other |
| `support_category_runners_helm_questions` | GitLab Runners::Kubernetes - Helm::Questions |
| `support_category_runners_linux_configuration` | GitLab Runners::Linux::Configuration |
| `support_category_runners_linux_errors` | GitLab Runners::Linux::Issues/Errors |
| `support_category_runners_linux` | GitLab Runners::Linux |
| `support_category_runners_linux_installation` | GitLab Runners::Linux::Installation/Registration |
| `support_category_runners_linux_other_topic` | GitLab Runners::Linux::Other |
| `support_category_runners_linux_questions` | GitLab Runners::Linux::Questions |
| `support_category_runners_macos_configuration` | GitLab Runners::macOS::Configuration |
| `support_category_runners_macos_errors` | GitLab Runners::macOS::Issues/Errors |
| `support_category_runners_macos` | GitLab Runners::macOS |
| `support_category_runners_macos_installation` | GitLab Runners::macOS::Installation/Registration |
| `support_category_runners_macos_other_topic` | GitLab Runners::macOS::Other |
| `support_category_runners_macos_questions` | GitLab Runners::macOS::Questions |
| `support_category_runners_operator_configuration` | GitLab Runners::Kubernetes - Operator::Configuration |
| `support_category_runners_operator_errors` | GitLab Runners::Kubernetes - Operator::Issues/Errors |
| `support_category_runners_operator` | GitLab Runners::Kubernetes - Operator |
| `support_category_runners_operator_installation` | GitLab Runners::Kubernetes - Operator::Installation/Registration |
| `support_category_runners_operator_other_topic` | GitLab Runners::Kubernetes - Operator::Other |
| `support_category_runners_operator_questions` | GitLab Runners::Kubernetes - Operator::Questions |
| `support_category_runners_other_configuration` | GitLab Runners::Other::Configuration |
| `support_category_runners_other_errors` | GitLab Runners::Other::Issues/Errors |
| `support_category_runners_other` | GitLab Runners::Other |
| `support_category_runners_other_installation` | GitLab Runners::Other::Installation/Registration |
| `support_category_runners_other_other` | GitLab Runners::Other::Other |
| `support_category_runners_other_questions` | GitLab Runners::Other::Questions |
| `support_category_runners_shared_configuration` | GitLab Runners::GitLab.com Shared Runners::Configuration |
| `support_category_runners_shared_errors` | GitLab Runners::GitLab.com Shared Runners::Issues/Errors |
| `support_category_runners_shared` | GitLab Runners::GitLab.com Shared Runners |
| `support_category_runners_shared_installation` | GitLab Runners::GitLab.com Shared Runners::Installation/Registration |
| `support_category_runners_shared_other_topic` | GitLab Runners::GitLab.com Shared Runners::Other |
| `support_category_runners_shared_questions` | GitLab Runners::GitLab.com Shared Runners::Questions |
| `support_category_runners_windows_configuration` | GitLab Runners::Windows::Configuration |
| `support_category_runners_windows_errors` | GitLab Runners::Windows::Issues/Errors |
| `support_category_runners_windows` | GitLab Runners::Windows |
| `support_category_runners_windows_installation` | GitLab Runners::Windows::Installation/Registration |
| `support_category_runners_windows_other_topic` | GitLab Runners::Windows::Other |
| `support_category_runners_windows_questions` | GitLab Runners::Windows::Questions |
| `support_category_secure_api_fuzzing_errors` | Secure::API Fuzzing::Issues/Errors |
| `support_category_secure_api_fuzzing_other` | Secure::API Fuzzing::Other |
| `support_category_secure_api_fuzzing_questions` | Secure::API Fuzzing::Questions |
| `support_category_secure_api_fuzzing` | Secure::API Fuzzing |
| `support_category_secure_api_fuzzing_setup` | Secure::API Fuzzing::Setup/Configuration |
| `support_category_secure_cve_id_errors` | Secure::CVE ID requests::Issues/Errors |
| `support_category_secure_cve_id_other` | Secure::CVE ID requests::Other |
| `support_category_secure_cve_id_questions` | Secure::CVE ID requests::Questions |
| `support_category_secure_cve_id` | Secure::CVE ID requests |
| `support_category_secure_cve_id_setup` | Secure::CVE ID requests::Setup/Configuration |
| `support_category_secure_dast_errors` | Secure::Dynamic Application Security Testing ::Issues/Errors |
| `support_category_secure_dast_other` | Secure::Dynamic Application Security Testing ::Other |
| `support_category_secure_dast_questions` | Secure::Dynamic Application Security Testing ::Questions |
| `support_category_secure_dast` | Secure::Dynamic Application Security Testing |
| `support_category_secure_dast_setup` | Secure::Dynamic Application Security Testing ::Setup/Configuration |
| `support_category_secure_dependency_scanning_errors` | Secure::Dependency Scanning::Issues/Errors |
| `support_category_secure_dependency_scanning_other` | Secure::Dependency Scanning::Other |
| `support_category_secure_dependency_scanning_questions` | Secure::Dependency Scanning::Questions |
| `support_category_secure_dependency_scanning` | Secure::Dependency Scanning |
| `support_category_secure_dependency_scanning_setup` | Secure::Dependency Scanning::Setup/Configuration |
| `support_category_secure_explain_vulnerability_errors` | Secure::Explain this vulnerability::Issues/Errors |
| `support_category_secure_explain_vulnerability_other` | Secure::Explain this vulnerability::Other |
| `support_category_secure_explain_vulnerability_questions` | Secure::Explain this vulnerability::Questions |
| `support_category_secure_explain_vulnerability` | Secure::Explain this vulnerability |
| `support_category_secure_explain_vulnerability_setup` | Secure::Explain this vulnerability::Setup/Configuration |
| `support_category_secure_fuzz_testing_errors` | Secure::Coverage-guided fuzz testing::Issues/Errors |
| `support_category_secure_fuzz_testing_other` | Secure::Coverage-guided fuzz testing::Other |
| `support_category_secure_fuzz_testing_questions` | Secure::Coverage-guided fuzz testing::Questions |
| `support_category_secure_fuzz_testing` | Secure::Coverage-guided fuzz testing |
| `support_category_secure_fuzz_testing_setup` | Secure::Coverage-guided fuzz testing::Setup/Configuration |
| `support_category_secure_iac_scanning_errors` | Secure::Infrastructure as Code ::Issues/Errors |
| `support_category_secure_iac_scanning_other` | Secure::Infrastructure as Code ::Other |
| `support_category_secure_iac_scanning_questions` | Secure::Infrastructure as Code ::Questions |
| `support_category_secure_iac_scanning` | Secure::Infrastructure as Code |
| `support_category_secure_iac_scanning_setup` | Secure::Infrastructure as Code ::Setup/Configuration |
| `support_category_secure_offline_envs_errors` | Secure::Offline Environments::Issues/Errors |
| `support_category_secure_offline_envs_other` | Secure::Offline Environments::Other |
| `support_category_secure_offline_envs_questions` | Secure::Offline Environments::Questions |
| `support_category_secure_offline_envs` | Secure::Offline Environments |
| `support_category_secure_offline_envs_setup` | Secure::Offline Environments::Setup/Configuration |
| `support_category_secure_other_errors` | Secure::Other::Issues/Errors |
| `support_category_secure_other_other` | Secure::Other::Other |
| `support_category_secure_other_questions` | Secure::Other::Questions |
| `support_category_secure_other` | Secure::Other |
| `support_category_secure_other_setup` | Secure::Other::Setup/Configuration |
| `support_category_secure_policies_errors` | Secure::Policies::Issues/Errors |
| `support_category_secure_policies_other` | Secure::Policies::Other |
| `support_category_secure_policies_questions` | Secure::Policies::Questions |
| `support_category_secure_policies` | Secure::Policies |
| `support_category_secure_policies_setup` | Secure::Policies::Setup/Configuration |
| `support_category_secure_revocation_errors` | Secure::Post-processing and revocation::Issues/Errors |
| `support_category_secure_revocation_other` | Secure::Post-processing and revocation::Other |
| `support_category_secure_revocation_questions` | Secure::Post-processing and revocation::Questions |
| `support_category_secure_revocation` | Secure::Post-processing and revocation |
| `support_category_secure_revocation_setup` | Secure::Post-processing and revocation::Setup/Configuration |
| `support_category_secure_sast_errors` | Secure::Static Application Security Testing::Issues/Errors |
| `support_category_secure_sast_other` | Secure::Static Application Security Testing::Other |
| `support_category_secure_sast_questions` | Secure::Static Application Security Testing::Questions |
| `support_category_secure_sast` | Secure::Static Application Security Testing |
| `support_category_secure_sast_setup` | Secure::Static Application Security Testing::Setup/Configuration |
| `support_category_secure_scanner_integration_errors` | Secure::Security scanner integration::Issues/Errors |
| `support_category_secure_scanner_integration_other` | Secure::Security scanner integration::Other |
| `support_category_secure_scanner_integration_questions` | Secure::Security scanner integration::Questions |
| `support_category_secure_scanner_integration` | Secure::Security scanner integration |
| `support_category_secure_scanner_integration_setup` | Secure::Security scanner integration::Setup/Configuration |
| `support_category_secure_secret_detection_errors` | Secure::Secret Detection::Issues/Errors |
| `support_category_secure_secret_detection_other` | Secure::Secret Detection::Other |
| `support_category_secure_secret_detection_questions` | Secure::Secret Detection::Questions |
| `support_category_secure_secret_detection` | Secure::Secret Detection |
| `support_category_secure_secret_detection_setup` | Secure::Secret Detection::Setup/Configuration |
| `support_category_secure_security_config_errors` | Secure::Security Configuration::Issues/Errors |
| `support_category_secure_security_config_other` | Secure::Security Configuration::Other |
| `support_category_secure_security_config_questions` | Secure::Security Configuration::Questions |
| `support_category_secure_security_config` | Secure::Security Configuration |
| `support_category_secure_security_config_setup` | Secure::Security Configuration::Setup/Configuration |
| `support_category_secure_security_dashboard_errors` | Secure::Security Dashboard::Issues/Errors |
| `support_category_secure_security_dashboard_other` | Secure::Security Dashboard::Other |
| `support_category_secure_security_dashboard_questions` | Secure::Security Dashboard::Questions |
| `support_category_secure_security_dashboard` | Secure::Security Dashboard |
| `support_category_secure_security_dashboard_setup` | Secure::Security Dashboard::Setup/Configuration |
| `support_category_secure_vulnerability_levels_errors` | Secure::Vulnerability severity levels::Issues/Errors |
| `support_category_secure_vulnerability_levels_other` | Secure::Vulnerability severity levels::Other |
| `support_category_secure_vulnerability_levels_questions` | Secure::Vulnerability severity levels::Questions |
| `support_category_secure_vulnerability_levels` | Secure::Vulnerability severity levels |
| `support_category_secure_vulnerability_levels_setup` | Secure::Vulnerability severity levels::Setup/Configuration |
| `support_category_secure_vulnerability_page_errors` | Secure::Vulnerability Page::Issues/Errors |
| `support_category_secure_vulnerability_page_other` | Secure::Vulnerability Page::Other |
| `support_category_secure_vulnerability_page_questions` | Secure::Vulnerability Page::Questions |
| `support_category_secure_vulnerability_page` | Secure::Vulnerability Page |
| `support_category_secure_vulnerability_page_setup` | Secure::Vulnerability Page::Setup/Configuration |
| `support_category_secure_vulnerability_report_errors` | Secure::Vulnerability Report::Issues/Errors |
| `support_category_secure_vulnerability_report_other` | Secure::Vulnerability Report::Other |
| `support_category_secure_vulnerability_report_questions` | Secure::Vulnerability Report::Questions |
| `support_category_secure_vulnerability_report` | Secure::Vulnerability Report |
| `support_category_secure_vulnerability_report_setup` | Secure::Vulnerability Report::Setup/Configuration |
| `support_category_usage_quotas_minutes_calc` | Usage Quotas::CI Minute usage::Subscription seat usage::Accuracy/Calculation |
| `support_category_usage_quotas_minutes_other` | Usage Quotas::CI Minute usage::Other |
| `support_category_usage_quotas_minutes_questions` | Usage Quotas::CI Minute usage::Questions |
| `support_category_usage_quotas_minutes` | Usage Quotas::CI Minute usage |
| `support_category_usage_quotas_seats_calc` | Usage Quotas::Subscription seat usage::Accuracy/Calculation |
| `support_category_usage_quotas_seats_other` | Usage Quotas::Other |
| `support_category_usage_quotas_seats_questions` | Usage Quotas::Subscription seat usage::Questions |
| `support_category_usage_quotas_seats` | Usage Quotas::Subscription seat usage |
| `support_category_usage_quotas_storage_calc` | Usage Quotas::Storage usage::Accuracy/Calculation |
| `support_category_usage_quotas_storage_other` | Usage Quotas::Storage usage::Other |
| `support_category_usage_quotas_storage_questions` | Usage Quotas::Storage usage::Questions |
| `support_category_usage_quotas_storage` | Usage Quotas::Storage usage |

</details>
<details>
<summary>Categorization tags (pre 2025-02-01)</summary>

| Tag                                                        | What it means                                                                             |
|------------------------------------------------------------|-------------------------------------------------------------------------------------------|
| `lnr_category_cdot`                                        | The L&R ticket involves customers.gitlab.com                                              |
| `lnr_category_other`                                       | The L&R ticket's category is unknown                                                      |
| `lnr_category_purchasing_issues`                           | The L&R ticket involves purchasing issues                                                 |
| `lnr_category_qsr`                                         | The L&R ticket involves QSR                                                               |
| `lnr_category_saas`                                        | The L&R ticket involves saas issues                                                       |
| `lnr_category_sm`                                          | The L&R ticket involves self-managed issues                                               |
| `lnr_category_special_program`                             | The L&R ticket involves GitLab special programs (EDU, OSS, etc.)                          |
| `lnr_category_trial`                                       | The L&R ticket involves GitLab trials                                                     |
| `lnr_cdot_contacts`                                        | The L&R ticket involves customers.gitlab.com account contacts                             |
| `lnr_cdot_login`                                           | The L&R ticket involves customers.gitlab.com login issues                                 |
| `lnr_cdot_other`                                           | The L&R ticket involves customers.gitlab.com in some way                                  |
| `lnr_cdot_transfer`                                        | The L&R ticket involves customers.gitlab.com account transfers                            |
| `lnr_purchasing_issues_cc_issues`                          | The L&R ticket involves CC issues when purchasing                                         |
| `lnr_purchasing_issues_non_cc_issues`                      | The L&R ticket involves non-CC issues when purchasing                                     |
| `lnr_purchasing_issues_other`                              | The L&R ticket involves some other purchasing issue                                       |
| `lnr_qsr_dispute`                                          | The L&R ticket involves a QSR dispute                                                     |
| `lnr_qsr_other`                                            | The L&R ticket involves something else about QSR                                          |
| `lnr_qsr_questions`                                        | The L&R ticket involves QSR questions                                                     |
| `lnr_saas_link_sub`                                        | The L&R ticket involves linking a subscription to a namespace                             |
| `lnr_saas_other`                                           | The L&R ticket involves something else about saas subscriptions                           |
| `lnr_saas_seat_usage`                                      | The L&R ticket involves namespace seat usage                                              |
| `lnr_saas_sub_issues`                                      | The L&R ticket involves an issue with a saas subscription                                 |
| `lnr_sm_cloud_opt_out`                                     | The L&R ticket involves opting out of SCL                                                 |
| `lnr_sm_did_not_receive`                                   | The L&R ticket involves not receiving a SM license                                        |
| `lnr_sm_license_errors`                                    | The L&R ticket involves errors applying a SM license                                      |
| `lnr_sm_other`                                             | The L&R ticket involves something else about SM licenses                                  |
| `lnr_sm_resend_to_new_contact`                             | The L&R ticket involves sending a license to a new contact                                |
| `lnr_sm_seat_usage`                                        | The L&R ticket involves seat usage on a SM instance                                       |
| `lnr_special_programs_other`                               | The L&R ticket involves something else about special programs                             |
| `lnr_special_programs_questions`                           | The L&R ticket involves general questions about special programs                          |
| `lnr_special_programs_renew`                               | The L&R ticket involves renewing a special program offerring                              |
| `lnr_special_programs_sheerid`                             | The L&R ticket involves issues appying a SheerID                                          |
| `lnr_trial_cannot_apply`                                   | The L&R ticket involves not being able to apply a trial                                   |
| `lnr_trial_cannot_start`                                   | The L&R ticket involves not being able to start a trial                                   |
| `lnr_trial_other`                                          | The L&R ticket involves something else about trials                                       |
| `lnr_trial_questions`                                      | The L&R ticket involves general trial questions                                           |
| `resold_status_no`                                         | The customer has stated they did not buy via a reseller                                   |
| `resold_status_reseller`                                   | The customer has stated they are a reseller                                               |
| `resold_status_resold`                                     | The customer has stated they did buy via a reseller                                       |
| `resold_status_unsure`                                     | The customer is unsure if they bought via a reseller or not                               |
| `saas_account_2fa_issues_questions`                        | The gitlab.com Account ticket involves 2FA questions                                      |
| `saas_account_2fa_issues_removal`                          | The gitlab.com Account ticket involves 2FA removal                                        |
| `saas_account_2fa_issues_setup`                            | The gitlab.com Account ticket involves 2FA setup                                          |
| `saas_account_access_issues_blocked`                       | The gitlab.com Account ticket involves getting account blocked errors                     |
| `saas_account_access_issues_cannot_login`                  | The gitlab.com Account ticket involves not being able to login to gitlab.com              |
| `saas_account_access_issues_change_account`                | The gitlab.com Account ticket involves changing something on a gitlab.com account         |
| `saas_account_access_issues_cloudflare`                    | The gitlab.com Account ticket involves CloudFlare issues                                  |
| `saas_account_access_issues_ip_blocked`                    | The gitlab.com Account ticket involves the customer's IP being blocked                    |
| `saas_account_access_issues_locked`                        | The gitlab.com Account ticket involves getting account locked errors                      |
| `saas_account_access_issues_other`                         | The gitlab.com Account ticket involves something else about accessing gitlab.com          |
| `saas_account_category_2fa_issues`                         | The gitlab.com Account ticket involves 2FA                                                |
| `saas_account_category_access_issues`                      | The gitlab.com Account ticket involves accessing gitlab.com                               |
| `saas_account_category_account_deletion`                   | The gitlab.com Account ticket involves account deletion                                   |
| `saas_account_category_email_issues`                       | The gitlab.com Account ticket involves email issues                                       |
| `saas_account_category_namesquatting`                      | The gitlab.com Account ticket involves namesquatting                                      |
| `saas_account_category_other`                              | The gitlab.com Account ticket something else                                              |
| `saas_account_category_registration_issues`                | The gitlab.com Account ticket involves registering a gitlab.com account                   |
| `saas_account_email_issues_confirmation`                   | The gitlab.com Account ticket involves confirmation emails                                |
| `saas_account_email_issues_notifications`                  | The gitlab.com Account ticket involves notification emails                                |
| `saas_account_email_issues_reset`                          | The gitlab.com Account ticket involves password reset emails                              |
| `support_administering_gitlab_admin_area`                  | The Support ticket involves the GitLab admin area                                         |
| `support_administering_gitlab_admin_area_instance`         | The Support ticket                                                                        |
| `support_administering_gitlab_admin_area_limits`           | The Support ticket account limits and settings in the GitLab admin area                   |
| `support_administering_gitlab_admin_area_other`            | The Support ticket something else about the GitLab admin area                             |
| `support_administering_gitlab_admin_area_questions`        | The Support ticket involves GitLab admin area questions                                   |
| `support_administering_gitlab_admin_area_user_group`       | The Support ticket involves user/group management in the GitLab admin area                |
| `support_administering_gitlab_backups`                     | The Support ticket involves backups                                                       |
| `support_administering_gitlab_backups_create`              | The Support ticket involves creating backups                                              |
| `support_administering_gitlab_backups_manage`              | The Support ticket involves managing backups                                              |
| `support_administering_gitlab_backups_other`               | The Support ticket involves something else about backups                                  |
| `support_administering_gitlab_backups_restore`             | The Support ticket involves restores                                                      |
| `support_administering_gitlab_other`                       | The Support ticket something else about administering a GitLab instance                   |
| `support_administering_gitlab_securing`                    | The Support ticket involves securing the GitLab instance                                  |
| `support_administering_gitlab_securing_2fa`                | The Support ticket involves enforcing 2FA on a SM instance                                |
| `support_administering_gitlab_securing_compliance`         | The Support ticket involves compliance features                                           |
| `support_administering_gitlab_securing_email_confirmation` | The Support ticket involves user email confirmation                                       |
| `support_administering_gitlab_securing_exclusivity`        | The Support ticket involves infromation exclusivity                                       |
| `support_administering_gitlab_securing_incidents`          | The Support ticket involves responding to security incidents                              |
| `support_administering_gitlab_securing_jobs`               | The Support ticket involves the security of running jobs                                  |
| `support_administering_gitlab_securing_other`              | The Support ticket involves something else about securing the GitLab instance             |
| `support_administering_gitlab_securing_proxying`           | The Support ticket involves proxy assets                                                  |
| `support_administering_gitlab_securing_rate_limits`        | The Support ticket involves rate limits                                                   |
| `support_administering_gitlab_securing_ssh_keys`           | The Support ticket involves limtis on SSH keys                                            |
| `support_administering_gitlab_securing_token`              | The Support ticket involves token overview                                                |
| `support_administering_gitlab_securing_webhooks`           | The Support ticket involves webhook administration                                        |
| `support_administering_gitlab_upgrades_component`          | The Support ticket involves upgrading SM components                                       |
| `support_administering_gitlab_upgrades_database`           | The Support ticket involves upgrading SM databases                                        |
| `support_administering_gitlab_upgrades_major`              | The Support ticket involves performing major version upgrades                             |
| `support_administering_gitlab_upgrades_minor`              | The Support ticket involves performing minor version upgrades                             |
| `support_administering_gitlab_upgrades_other`              | The Support ticket involves something else about upgrading GitLab                         |
| `support_administering_gitlab_upgrading`                   | The Support ticket involves upgrading GitLab                                              |
| `support_analyze_usage_audits`                             | The Support ticket involves Audit Events                                                  |
| `support_analyze_usage_cicd`                               | The Support ticket involves CI/CD analytics                                               |
| `support_analyze_usage_code_review`                        | The Support ticket involves Code Review Analytics                                         |
| `support_analyze_usage_contribution`                       | The Support ticket involves Contribution Analytics                                        |
| `support_analyze_usage_errors`                             | The Support ticket involves errors with analytic tools                                    |
| `support_analyze_usage_group_devops`                       | The Support ticket involves Group DevOps Adoption                                         |
| `support_analyze_usage_insights`                           | The Support ticket involves Insights                                                      |
| `support_analyze_usage_issues`                             | The Support ticket involves Issue analytics                                               |
| `support_analyze_usage_mrs`                                | The Support ticket involves Merge request analytics                                       |
| `support_analyze_usage_other`                              | The Support ticket involves something else about analyzing GitLab usage                   |
| `support_analyze_usage_other_topic`                        | The Support ticket involves something else about analytic tools                           |
| `support_analyze_usage_productivity`                       | The Support ticket involves Productivity Analytics                                        |
| `support_analyze_usage_questions`                          | The Support ticket involves questions about analytic tools                                |
| `support_analyze_usage_respository`                        | The Support ticket involves Repository Analytics                                          |
| `support_analyze_usage_setup`                              | The Support ticket involves setup of analytic tools                                       |
| `support_analyze_usage_value_stream`                       | The Support ticket involves Value stream analytics                                        |
| `support_auth_alicloud`                                    | The Support ticket involves AliCloud                                                      |
| `support_auth_atlassian_crowd`                             | The Support ticket involves Atlassian Crowd                                               |
| `support_auth_atlassian_omniauth`                          | The Support ticket involves Atlassian Omniauth                                            |
| `support_auth_auth0`                                       | The Support ticket involves Auth0 OmniAuth                                                |
| `support_auth_authentiq`                                   | The Support ticket involves Authentiq OmniAuth                                            |
| `support_auth_aws_cognito`                                 | The Support ticket involves Amazon Web Services Cognito                                   |
| `support_auth_azure`                                       | The Support ticket involves Azure OAuth OmniAuth                                          |
| `support_auth_bitbucket`                                   | The Support ticket involves Bitbucket cloud OmniAuth                                      |
| `support_auth_cas`                                         | The Support ticket involves CAS OmniAuth                                                  |
| `support_auth_facebook`                                    | The Support ticket involves Facebook OAuth 2.0                                            |
| `support_auth_generic`                                     | The Support ticket involves Generic OAuth2 Provider                                       |
| `support_auth_github`                                      | The Support ticket involves GitHub OmniAuth                                               |
| `support_auth_gitlab`                                      | The Support ticket involves GitLab.com OmniAuth                                           |
| `support_auth_google`                                      | The Support ticket involves Google OAuth 2.0 OmniAuth                                     |
| `support_auth_issues_errors`                               | The Support ticket involves errors using an authentication method                         |
| `support_auth_jwt`                                         | The Support ticket involves JWT OmniAuth                                                  |
| `support_auth_kerberos`                                    | The Support ticket involves Kerberos Auth integration                                     |
| `support_auth_ldap`                                        | The Support ticket involves LDAP                                                          |
| `support_auth_oauth_service_provider`                      | The Support ticket involves OAuth service provider                                        |
| `support_auth_openid_connect`                              | The Support ticket involves OpenID Connect OmniAuth                                       |
| `support_auth_other`                                       | The Support ticket involves some other authentication method                              |
| `support_auth_questions`                                   | The Support ticket involves questions about an authentication method                      |
| `support_auth_salesforce`                                  | The Support ticket involves Salesforce OmniAuth                                           |
| `support_auth_saml`                                        | The Support ticket involves SAML                                                          |
| `support_auth_scim`                                        | The Support ticket involves SCIM                                                          |
| `support_auth_setup_configuration`                         | The Support ticket involves setting up an authentication method                           |
| `support_auth_smartcard`                                   | The Support ticket involves Smartcard authentication                                      |
| `support_auth_sync_issues`                                 | The Support ticket involves sync issues using an authentication method                    |
| `support_auth_topic_other`                                 | The Support ticket involves something else with an authentication method                  |
| `support_auth_twitter`                                     | The Support ticket involves Twitter OAuth                                                 |
| `support_auth_vault`                                       | The Support ticket involves Vault Authentication with OpenID                              |
| `support_category_administering_gitlab`                    | The Support ticket involves Administering GitLab                                          |
| `support_category_analyze_usage`                           | The Support ticket involves Analyzing GitLab usage                                        |
| `support_category_auth`                                    | The Support ticket involves Authentication and Authorization                              |
| `support_category_cicd`                                    | The Support ticket involves CI/CD                                                         |
| `support_category_deployments`                             | The Support ticket involves Deployments                                                   |
| `support_category_gitlab_duo`                              | The Support ticket involves GitLab Duo                                                    |
| `support_category_instance_management`                     | The Support ticket involves Instance Management                                           |
| `support_category_integrations`                            | The Support ticket involves Integrations                                                  |
| `support_category_manage_infra`                            | The Support ticket involves Managing infrastructure via GitLab                            |
| `support_category_monitoring`                              | The Support ticket involves Monitoring                                                    |
| `support_category_other`                                   | The Support ticket involves something else                                                |
| `support_category_packages`                                | The Support ticket involves Packages and Registries                                       |
| `support_category_performance`                             | The Support ticket involves Performance                                                   |
| `support_category_project_group_management`                | The Support ticket involves Project/Group management                                      |
| `support_category_runners`                                 | The Support ticket involves Runners                                                       |
| `support_category_secure`                                  | The Support ticket involves Secure                                                        |
| `support_category_upgrade_assistance`                      | The Support ticket involves upgrading assistance                                          |
| `support_category_usage_quotas`                            | The Support ticket involves Usage quotes                                                  |
| `support_cicd_artifacts`                                   | The Support ticket involves CI/CD artifacts                                               |
| `support_cicd_artifacts_creation_topic`                    | The Support ticket involves CI/CD artifact creation                                       |
| `support_cicd_artifacts_errors_topic`                      | The Support ticket involves CI/CD artifact errors                                         |
| `support_cicd_artifacts_management_topic`                  | The Support ticket involves CI/CD artifact management                                     |
| `support_cicd_artifacts_other_topic`                       | The Support ticket involves something else about CI/CD artifacts                          |
| `support_cicd_artifacts_questions_topic`                   | The Support ticket involves CI/CD artifact questions                                      |
| `support_cicd_autodevops`                                  | The Support ticket involves CI/CD AutoDevOps                                              |
| `support_cicd_autodevops_errors`                           | The Support ticket involves CI/CD AutoDevOps errors                                       |
| `support_cicd_autodevops_other`                            | The Support ticket involves something else about CI/CD AutoDevOps                         |
| `support_cicd_autodevops_questions`                        | The Support ticket involves CI/CD AutoDevOps questions                                    |
| `support_cicd_autodevops_setup`                            | The Support ticket involves CI/CD AutoDevOps setup                                        |
| `support_cicd_cache`                                       | The Support ticket involves CI/CD cache                                                   |
| `support_cicd_cache_creation`                              | The Support ticket involves CI/CD cache creation                                          |
| `support_cicd_cache_errors`                                | The Support ticket involves CI/CD cache errors                                            |
| `support_cicd_cache_management`                            | The Support ticket involves CI/CD cache management                                        |
| `support_cicd_cache_other`                                 | The Support ticket involves something else concerning CI/CD cache                         |
| `support_cicd_cache_questions`                             | The Support ticket involves CI/CD cache questions                                         |
| `support_cicd_ci_file`                                     | The Support ticket involves the CI/CD file                                                |
| `support_cicd_ci_file_errors`                              | The Support ticket involves CI/CD file errors                                             |
| `support_cicd_ci_file_other`                               | The Support ticket involves something else concernign the CI/CD file                      |
| `support_cicd_ci_file_questions`                           | The Support ticket involves CI/CD file questions                                          |
| `support_cicd_ci_file_setup`                               | The Support ticket involves CI/CD file setup                                              |
| `support_cicd_deployments`                                 | The Support ticket involves CI/CD deployments                                             |
| `support_cicd_deployments_environments`                    | The Support ticket involves CI/CD deployment environments                                 |
| `support_cicd_deployments_feature_flags`                   | The Support ticket involves CI/CD deployment feature flags                                |
| `support_cicd_deployments_releases`                        | The Support ticket involves CI/CD deployment releases                                     |
| `support_cicd_deployments_review_apps`                     | The Support ticket involves CI/CD deployment review apps                                  |
| `support_cicd_jobs`                                        | The Support ticket involves CI/CD jobs                                                    |
| `support_cicd_jobs_errors`                                 | The Support ticket involves CI/CD job errors                                              |
| `support_cicd_jobs_other`                                  | The Support ticket involves something else concerning CI/CD jobs                          |
| `support_cicd_jobs_questions`                              | The Support ticket involves CI/CD job questions                                           |
| `support_cicd_jobs_setup`                                  | The Support ticket involves CI/CD job setup                                               |
| `support_cicd_other`                                       | The Support ticket involves something else with CI/CD                                     |
| `support_cicd_pipelines`                                   | The Support ticket involves CI/CD pipelines                                               |
| `support_cicd_pipelines_errors`                            | The Support ticket involves CI/CD pipeline errors                                         |
| `support_cicd_pipelines_merge_trains`                      | The Support ticket involves CI/CD merge trains                                            |
| `support_cicd_pipelines_multiproject`                      | The Support ticket involves CI/CD multiproject pipelines                                  |
| `support_cicd_pipelines_other`                             | The Support ticket involves something else concerning CI/CD pipelines                     |
| `support_cicd_pipelines_questions`                         | The Support ticket involves CI/CD pipeline questions                                      |
| `support_cicd_pipelines_schedules`                         | The Support ticket involves CI/CD pipeline schedules                                      |
| `support_cicd_pipelines_setup`                             | The Support ticket involves CI/CD pipeline setup                                          |
| `support_cicd_pipelines_triggers`                          | The Support ticket involves CI/CD pipeline triggers                                       |
| `support_cicd_variables`                                   | The Support ticket involves CI/CD variables                                               |
| `support_cicd_variables_ci_file`                           | The Support ticket involves CI/CD file variables                                          |
| `support_cicd_variables_group`                             | The Support ticket involves CI/CD group variables                                         |
| `support_cicd_variables_project`                           | The Support ticket involves CI/CD project variables                                       |
| `support_cicd_variables_schedules`                         | The Support ticket involves CI/CD schedule variables                                      |
| `support_deployments_deployments`                          | The Support ticket involves deployments                                                   |
| `support_deployments_envs`                                 | The Support ticket involves deployment environments                                       |
| `support_deployments_errors`                               | The Support ticket involves deployment errors                                             |
| `support_deployments_feature_flags`                        | The Support ticket involves deployment feature flags                                      |
| `support_deployments_other`                                | The Support ticket involves something else concerning deployments                         |
| `support_deployments_other_topic`                          | The Support ticket involves something else concerning deployments                         |
| `support_deployments_protected_envs`                       | The Support ticket involves deployment protected environments                             |
| `support_deployments_questions`                            | The Support ticket involves deployment questions                                          |
| `support_deployments_releases`                             | The Support ticket involves deployment releases                                           |
| `support_deployments_review_apps`                          | The Support ticket involves deployment review apps                                        |
| `support_deployments_rollouts`                             | The Support ticket involves deployment rollouts                                           |
| `support_deployments_setup`                                | The Support ticket involves deployment setup                                              |
| `support_gitlab_duo_chat`                                  | The Support ticket involves GitLab Duo chat                                               |
| `support_gitlab_duo_code_suggestions`                      | The Support ticket involves GitLab Duo code suggestions                                   |
| `support_gitlab_duo_errors_topic`                          | The Support ticket involves GitLab Duo errors                                             |
| `support_gitlab_duo_generated_response_topic`              | The Support ticket involves GitLab Duo responses                                          |
| `support_gitlab_duo_integrations_topic`                    | The Support ticket involves GitLab Duo integrations                                       |
| `support_gitlab_duo_licensing_topic`                       | The Support ticket involves GitLab Duo licening                                           |
| `support_gitlab_duo_mr_summary`                            | The Support ticket involves GitLab Duo merge request summaries                            |
| `support_gitlab_duo_other`                                 | The Support ticket involves GitLab Duo                                                    |
| `support_gitlab_duo_other_topic`                           | The Support ticket involves GitLab Duo                                                    |
| `support_gitlab_duo_questions_topic`                       | The Support ticket involves GitLab Duo questions                                          |
| `support_gitlab_duo_reviewers`                             | The Support ticket involves GitLab Duo reviewers                                          |
| `support_gitlab_duo_suggestion_accuracy`                   | The Support ticket involves GitLab Duo suggestion accuracy                                |
| `support_gitlab_duo_tests`                                 | The Support ticket involves GitLab Duo tests                                              |
| `support_gitlab_duo_vulnerabilities`                       | The Support ticket involves GitLab Duo vulnerabilities                                    |
| `support_gitlab_setup_topic`                               | The Support ticket involves GitLab Duo setup                                              |
| `support_instance_management_configuration_backups`        | The Support ticket involves configuring backups                                           |
| `support_instance_management_configuration_database`       | The Support ticket involves configuring databases                                         |
| `support_instance_management_configuration_grafana`        | The Support ticket involves configuring grafana                                           |
| `support_instance_management_configuration_lfs`            | The Support ticket involves configuring LFS                                               |
| `support_instance_management_configuration_logs`           | The Support ticket involves configuring logs                                              |
| `support_instance_management_configuration_mattermost`     | The Support ticket involves configuring mattermost                                        |
| `support_instance_management_configuration_nginx`          | The Support ticket involves configuring nginx                                             |
| `support_instance_management_configuration_object_storage` | The Support ticket involves configuring object storage                                    |
| `support_instance_management_configuration_other`          | The Support ticket involves something else about configuration                            |
| `support_instance_management_configuration_packages`       | The Support ticket involves configuring packages                                          |
| `support_instance_management_configuration_prometheus`     | The Support ticket involves configuring prometheus                                        |
| `support_instance_management_configuration_puma`           | The Support ticket involves configuring puma                                              |
| `support_instance_management_configuration_redis`          | The Support ticket involves configuring puma                                              |
| `support_instance_management_configuration_smtp`           | The Support ticket involves configuring smtp                                              |
| `support_instance_management_configuration_ssl`            | The Support ticket involves configuring SSLs                                              |
| `support_instance_management_configure`                    | The Support ticket involves configuration                                                 |
| `support_instance_management_geo`                          | The Support ticket involves Geo                                                           |
| `support_instance_management_geo_other`                    | The Support ticket involves something else about Geo                                      |
| `support_instance_management_geo_primary`                  | The Support ticket involves Geo primary nodes                                             |
| `support_instance_management_geo_replication`              | The Support ticket involves Geo replication                                               |
| `support_instance_management_geo_secondary`                | The Support ticket involves Geo secondary nodes                                           |
| `support_instance_management_helm`                         | The Support ticket Helm                                                                   |
| `support_instance_management_helm_exporter`                | The Support ticket Helm exporter                                                          |
| `support_instance_management_helm_gitaly`                  | The Support ticket Helm gitaly                                                            |
| `support_instance_management_helm_global`                  | The Support ticket Helm global                                                            |
| `support_instance_management_helm_grafana`                 | The Support ticket Helm grafana                                                           |
| `support_instance_management_helm_mailroom`                | The Support ticket Helm mailroom                                                          |
| `support_instance_management_helm_nginx`                   | The Support ticket Helm nginx                                                             |
| `support_instance_management_helm_object_storage`          | The Support ticket Helm oject storage                                                     |
| `support_instance_management_helm_other`                   | The Support ticket something else about Helm                                              |
| `support_instance_management_helm_pages`                   | The Support ticket using Pages with Helm                                                  |
| `support_instance_management_helm_postgresql`              | The Support ticket Helm postgresql                                                        |
| `support_instance_management_helm_praefect`                | The Support ticket Helm praefect                                                          |
| `support_instance_management_helm_rails`                   | The Support ticket Helm rails                                                             |
| `support_instance_management_helm_registry`                | The Support ticket Helm registry                                                          |
| `support_instance_management_helm_secrets`                 | The Support ticket Helm secrets                                                           |
| `support_instance_management_helm_shell`                   | The Support ticket Helm shell                                                             |
| `support_instance_management_helm_sidekiq`                 | The Support ticket Helm sidekiq                                                           |
| `support_instance_management_helm_spamcheck`               | The Support ticket Helm spamcheck                                                         |
| `support_instance_management_helm_toolbox`                 | The Support ticket Helm toolbox                                                           |
| `support_instance_management_helm_webservice`              | The Support ticket Helm webservice                                                        |
| `support_instance_management_install`                      | The Support ticket involves installing GitLab                                             |
| `support_instance_management_install_cloud`                | The Support ticket involves installing GitLab via Cloud                                   |
| `support_instance_management_install_docker`               | The Support ticket involves installing GitLab via Docker                                  |
| `support_instance_management_install_omnibus`              | The Support ticket involves installing GitLab via Omnibus                                 |
| `support_instance_management_install_source`               | The Support ticket involves installing GitLab via source code                             |
| `support_instance_management_migrate`                      | The Support ticket involves migrating GitLab                                              |
| `support_instance_management_migrate_other`                | The Support ticket involves migrating GitLab in some way                                  |
| `support_instance_management_migrate_to_ce`                | The Support ticket involves migrating GitLab to CE                                        |
| `support_instance_management_migrate_to_ee`                | The Support ticket involves migrating GitLab to EE                                        |
| `support_instance_management_migrate_to_helm`              | The Support ticket involves migrating GitLab to Helm                                      |
| `support_instance_management_migrate_to_omnibus`           | The Support ticket involves migrating GitLab to Omnibus                                   |
| `support_instance_management_other`                        | The Support ticket involves something else about instance management                      |
| `support_integrations_akismet`                             | The Support ticket involves integratiig Akismet                                           |
| `support_integrations_datadog`                             | The Support ticket involves integratiig datadog                                           |
| `support_integrations_elasticsearch`                       | The Support ticket involves integratiig elasticsearch                                     |
| `support_integrations_external_trackers`                   | The Support ticket involves integratiig external issue trackers                           |
| `support_integrations_external_trackers_bugzilla`          | The Support ticket involves integratiig bugzilla                                          |
| `support_integrations_external_trackers_ibm`               | The Support ticket involves integratiig IBM issue tracker                                 |
| `support_integrations_external_trackers_other`             | The Support ticket involves integratiig some other issue tracker                          |
| `support_integrations_external_trackers_redmine`           | The Support ticket involves integratiig redmine                                           |
| `support_integrations_external_trackers_youtrack`          | The Support ticket involves integratiig youtrack                                          |
| `support_integrations_external_trackers_zentao`            | The Support ticket involves integratiig zentao                                            |
| `support_integrations_general_errors`                      | The Support ticket errors integrating something into GitLab                               |
| `support_integrations_general_other`                       | The Support ticket something else about integrating something into GitLab                 |
| `support_integrations_general_questions`                   | The Support ticket questions integrating something into GitLab                            |
| `support_integrations_general_setup`                       | The Support ticket setting up an integration into GitLab                                  |
| `support_integrations_gitpod`                              | The Support ticket involves integratiig gitpod                                            |
| `support_integrations_gmail`                               | The Support ticket involves integratiig gmail buttons                                     |
| `support_integrations_jira`                                | The Support ticket involves integratiig Jira                                              |
| `support_integrations_jira_app`                            | The Support ticket involves integratiig the Jira app                                      |
| `support_integrations_jira_dev_panel`                      | The Support ticket involves integratiig the Jira dev panel                                |
| `support_integrations_jira_dvcs`                           | The Support ticket involves integratiig Jira DVCS                                         |
| `support_integrations_jira_other`                          | The Support ticket involves integratiig Jira in some way                                  |
| `support_integrations_kroki`                               | The Support ticket involves integratiig kroki                                             |
| `support_integrations_mailgun`                             | The Support ticket involves integratiig mailgun                                           |
| `support_integrations_other`                               | The Support ticket involves integratiig something                                         |
| `support_integrations_pim`                                 | The Support ticket involves integratiig Pproject Integration Management                   |
| `support_integrations_plantuml`                            | The Support ticket involves integratiig plantuml                                          |
| `support_integrations_project_`                            | The Support ticket involves integratiig something into a project                          |
| `support_integrations_project_asana`                       | The Support ticket involves integratiig asana                                             |
| `support_integrations_project_bamboo`                      | The Support ticket involves integratiig bamboo                                            |
| `support_integrations_project_discord`                     | The Support ticket involves integratiig discord                                           |
| `support_integrations_project_emails_on_push`              | The Support ticket involves integratiig emails on push                                    |
| `support_integrations_project_github`                      | The Support ticket involves integratiig github                                            |
| `support_integrations_project_google_chat`                 | The Support ticket involves integratiig google chat                                       |
| `support_integrations_project_irker`                       | The Support ticket involves integratiig irker                                             |
| `support_integrations_project_jenkins`                     | The Support ticket involves integratiig jenkins                                           |
| `support_integrations_project_mattermost`                  | The Support ticket involves integratiig mattermost                                        |
| `support_integrations_project_ms_teams`                    | The Support ticket involves integratiig MS teams                                          |
| `support_integrations_project_other`                       | The Support ticket involves integratiig something else                                    |
| `support_integrations_project_pivotal`                     | The Support ticket involves integratiig pivotal                                           |
| `support_integrations_project_prometheus`                  | The Support ticket involves integratiig prometheus                                        |
| `support_integrations_project_slack`                       | The Support ticket involves integratiig slack                                             |
| `support_integrations_project_status_emails`               | The Support ticket involves integratiig status emails                                     |
| `support_integrations_project_unify_circuit`               | The Support ticket involves integratiig unify circuit                                     |
| `support_integrations_project_webex`                       | The Support ticket involves integratiig webex                                             |
| `support_integrations_project_webhooks`                    | The Support ticket involves integratiig webhooks                                          |
| `support_integrations_recaptcha`                           | The Support ticket involves integratiig recaptcha                                         |
| `support_integrations_sourcegraph`                         | The Support ticket involves integratiig sourcegraph                                       |
| `support_integrations_trllo`                               | The Support ticket involves integratiig trello                                            |
| `support_integrations_visual_studio`                       | The Support ticket involves integratiig visual studio                                     |
| `support_manage_infra_clusters`                            | The Support ticket involves managing infrastructure via GitLab using clusters             |
| `support_manage_infra_clusters_agent`                      | The Support ticket involves the k8s agent                                                 |
| `support_manage_infra_clusters_connect`                    | The Support ticket invovles connecting to clusters                                        |
| `support_manage_infra_clusters_create`                     | The Support ticket involves creating clusters                                             |
| `support_manage_infra_clusters_errors`                     | The Support ticket involves errors with clusters                                          |
| `support_manage_infra_clusters_gitops`                     | The Support ticket involves gitops and clusters                                           |
| `support_manage_infra_clusters_migrate`                    | The Support ticket involves migrating clusters                                            |
| `support_manage_infra_clusters_other`                      | The Support ticket involves something else about clusters                                 |
| `support_manage_infra_clusters_vulnerability_scanning`     | The Support ticket involves cluster vulnerability scanning                                |
| `support_manage_infra_code`                                | The Support ticket involves managing infrastructure via code                              |
| `support_manage_infra_code_errors`                         | The Support ticket involves errors when managing infrastructure via code                  |
| `support_manage_infra_code_other`                          | The Support ticket involves something else about managing infrastructure via code         |
| `support_manage_infra_code_questions`                      | The Support ticket involves questions about managing infrastructure via code              |
| `support_manage_infra_code_setup`                          | The Support ticket involves setting up managing infrastructure via code                   |
| `support_manage_infra_code_tf_integration`                 | The Support ticket involves terraform integrations when managing infrastructure via code  |
| `support_manage_infra_code_tf_state`                       | The Support ticket involves terraform state issues when managing infrastructure via code  |
| `support_manage_infra_other`                               | The Support ticket involves something else about manageing infrastructure                 |
| `support_manage_infra_runbooks`                            | The Support ticket involves runbooks                                                      |
| `support_manage_infra_runbooks_errors`                     | The Support ticket involves runbooks errors                                               |
| `support_manage_infra_runbooks_other`                      | The Support ticket involves something else about runbooks                                 |
| `support_manage_infra_runbooks_questions`                  | The Support ticket involves runbooks questions                                            |
| `support_manage_infra_runbooks_setup`                      | The Support ticket involves runbooks setup                                                |
| `support_monitoring_error_tracking`                        | The Support ticket involves Error Tracking                                                |
| `support_monitoring_general_errors`                        | The Support ticket involves monitoring errors                                             |
| `support_monitoring_general_other`                         | The Support ticket involves something else about monitoring                               |
| `support_monitoring_general_questions`                     | The Support ticket involves monitoring questions                                          |
| `support_monitoring_general_setup`                         | The Support ticket involves monitoring setup                                              |
| `support_monitoring_incidents`                             | The Support ticket involves incidents                                                     |
| `support_monitoring_incidents_alerts`                      | The Support ticket involves incident alerts                                               |
| `support_monitoring_incidents_escalations`                 | The Support ticket involves incident  escalations                                         |
| `support_monitoring_incidents_incidents`                   | The Support ticket involves incident  management                                          |
| `support_monitoring_incidents_oncall`                      | The Support ticket involves incident oncall                                               |
| `support_monitoring_incidents_other`                       | The Support ticket involves something else about incidents                                |
| `support_monitoring_incidents_paging`                      | The Support ticket involves incident paging                                               |
| `support_monitoring_incidents_status_page`                 | The Support ticket involves incident status pages                                         |
| `support_monitoring_other`                                 | The Support ticket involves something else about monitoring                               |
| `support_monitoring_product_analytics`                     | The Support ticket involves product analysis                                              |
| `support_packages_composer`                                | The Support ticket involves compose packages                                              |
| `support_packages_container`                               | The Support ticket involves container registry                                            |
| `support_packages_dependency_proxy`                        | The Support ticket involves dependency proxy                                              |
| `support_packages_dependency_proxy_errors`                 | The Support ticket involves dependency proxy errors                                       |
| `support_packages_dependency_proxy_other`                  | The Support ticket involves something else about dependency proxy                         |
| `support_packages_dependency_proxy_questions`              | The Support ticket involves dependency proxy questions                                    |
| `support_packages_generic`                                 | The Support ticket involves generic packages                                              |
| `support_packages_infra`                                   | The Support ticket involves infra registries                                              |
| `support_packages_maven`                                   | The Support ticket involves maven packages                                                |
| `support_packages_npm`                                     | The Support ticket involves npm packages                                                  |
| `support_packages_nuget`                                   | The Support ticket involves nuget packages                                                |
| `support_packages_other`                                   | The Support ticket involves something else about packages                                 |
| `support_packages_packages_building`                       | The Support ticket involves building packages                                             |
| `support_packages_packages_installing`                     | The Support ticket involves installing packages                                           |
| `support_packages_packages_other`                          | The Support ticket involves something else about packages                                 |
| `support_packages_packages_questions`                      | The Support ticket involves package questions                                             |
| `support_packages_pypi`                                    | The Support ticket involves pypi packages                                                 |
| `support_packages_registries_building`                     | The Support ticket involves building registries                                           |
| `support_packages_registries_deleting`                     | The Support ticket involves deleting registries                                           |
| `support_packages_registries_errors`                       | The Support ticket involves registry errors                                               |
| `support_packages_registries_other`                        | The Support ticket involves something else about registries                               |
| `support_packages_registries_questions`                    | The Support ticket involves registry questions                                            |
| `support_performance_agent`                                | The Support ticket involves performance of the agent                                      |
| `support_performance_alertmanager`                         | The Support ticket involves performance of the alertmanager                               |
| `support_performance_certifcates`                          | The Support ticket involves performance of the certificates                               |
| `support_performance_consul`                               | The Support ticket involves performance of the consul                                     |
| `support_performance_database`                             | The Support ticket involves performance of the database                                   |
| `support_performance_emails`                               | The Support ticket involves performance of the emails                                     |
| `support_performance_exporter`                             | The Support ticket involves performance of the exporter                                   |
| `support_performance_geo`                                  | The Support ticket involves performance of the geo                                        |
| `support_performance_gitaly`                               | The Support ticket involves performance of the gitaly                                     |
| `support_performance_grafana`                              | The Support ticket involves performance of the grafana                                    |
| `support_performance_lfs`                                  | The Support ticket involves performance of the LFS                                        |
| `support_performance_logrotate`                            | The Support ticket involves performance of the logrotate                                  |
| `support_performance_mattermost`                           | The Support ticket involves performance of the mattermost                                 |
| `support_performance_nginx`                                | The Support ticket involves performance of the nginx                                      |
| `support_performance_node_exporter`                        | The Support ticket involves performance of the node exporter                              |
| `support_performance_object_storage`                       | The Support ticket involves performance of the object storage                             |
| `support_performance_other`                                | The Support ticket involves performance of the something else                             |
| `support_performance_patroni`                              | The Support ticket involves performance of the patroni                                    |
| `support_performance_pgbouncer`                            | The Support ticket involves performance of the pgbouncer                                  |
| `support_performance_praefect`                             | The Support ticket involves performance of the praefect                                   |
| `support_performance_prometheus`                           | The Support ticket involves performance of the prmetheus                                  |
| `support_performance_puma`                                 | The Support ticket involves performance of the puma                                       |
| `support_performance_redis`                                | The Support ticket involves performance of the redis                                      |
| `support_performance_registry`                             | The Support ticket involves performance of the registry                                   |
| `support_performance_sentry`                               | The Support ticket involves performance of the sentry                                     |
| `support_performance_sidekiq`                              | The Support ticket involves performance of the sidekiq                                    |
| `support_performance_ssl`                                  | The Support ticket involves performance of the SSLs                                       |
| `support_performance_workhorse`                            | The Support ticket involves performance of the workhorse                                  |
| `support_pg_management_group`                              | The Support ticket involves groups                                                        |
| `support_pg_management_group_creation`                     | The Support ticket involves group creation                                                |
| `support_pg_management_group_errors`                       | The Support ticket involves group errors                                                  |
| `support_pg_management_group_memberships`                  | The Support ticket involves group memberships                                             |
| `support_pg_management_group_other`                        | The Support ticket involves something else about groups                                   |
| `support_pg_management_group_questions`                    | The Support ticket involves group questions                                               |
| `support_pg_management_group_settings`                     | The Support ticket involves group settings                                                |
| `support_pg_management_issues`                             | The Support ticket involves issues                                                        |
| `support_pg_management_issues_boards`                      | The Support ticket involves issue boards                                                  |
| `support_pg_management_issues_creation`                    | The Support ticket involves issue creation                                                |
| `support_pg_management_issues_designs`                     | The Support ticket involves issue designs                                                 |
| `support_pg_management_issues_errors`                      | The Support ticket involves issue errors                                                  |
| `support_pg_management_issues_other`                       | The Support ticket involves something else about issues                                   |
| `support_pg_management_issues_questions`                   | The Support ticket involves issue questions                                               |
| `support_pg_management_issues_settings`                    | The Support ticket involves issue settings                                                |
| `support_pg_management_iterations`                         | The Support ticket involves iterations or milestones                                      |
| `support_pg_management_iterations_iterations`              | The Support ticket involves iterations                                                    |
| `support_pg_management_iterations_milestones`              | The Support ticket involves milestones                                                    |
| `support_pg_management_labels`                             | The Support ticket involves labels                                                        |
| `support_pg_management_labels_group`                       | The Support ticket involves group labels                                                  |
| `support_pg_management_labels_project`                     | The Support ticket involves project labels                                                |
| `support_pg_management_mrs`                                | The Support ticket involves MRs                                                           |
| `support_pg_management_mrs_approvals`                      | The Support ticket involves MR approvals                                                  |
| `support_pg_management_mrs_changes`                        | The Support ticket involves MR changes                                                    |
| `support_pg_management_mrs_conflicts`                      | The Support ticket involves MR conflicts                                                  |
| `support_pg_management_mrs_creation`                       | The Support ticket involves MR creation                                                   |
| `support_pg_management_mrs_dependencies`                   | The Support ticket involves MR dependencies                                               |
| `support_pg_management_mrs_management`                     | The Support ticket involves MR management                                                 |
| `support_pg_management_mrs_other`                          | The Support ticket involves something else about MRs                                      |
| `support_pg_management_other`                              | The Support ticket involves something else about project/group management                 |
| `support_pg_management_project`                            | The Support ticket involves projects                                                      |
| `support_pg_management_project_creation`                   | The Support ticket involves project creation                                              |
| `support_pg_management_project_errors`                     | The Support ticket involves project errors                                                |
| `support_pg_management_project_import_export`              | The Support ticket involves import/export                                                 |
| `support_pg_management_project_other`                      | The Support ticket involves something else about projects                                 |
| `support_pg_management_project_pages`                      | The Support ticket involves GitLab Pages                                                  |
| `support_pg_management_project_questions`                  | The Support ticket involves project questions                                             |
| `support_pg_management_project_service_desk`               | The Support ticket involves service desk                                                  |
| `support_pg_management_project_settings`                   | The Support ticket involves project settings                                              |
| `support_pg_management_repository`                         | The Support ticket involves repositories                                                  |
| `support_pg_management_repository_branches`                | The Support ticket involves branches                                                      |
| `support_pg_management_repository_code_owners`             | The Support ticket involves code owners                                                   |
| `support_pg_management_repository_creation`                | The Support ticket involves repository creation                                           |
| `support_pg_management_repository_forking`                 | The Support ticket involves forking                                                       |
| `support_pg_management_repository_lfs`                     | The Support ticket involves LFS                                                           |
| `support_pg_management_repository_mirroring`               | The Support ticket involves mirroring                                                     |
| `support_pg_management_repository_other`                   | The Support ticket involves something else about repositories                             |
| `support_pg_management_repository_settings`                | The Support ticket involves repository settings                                           |
| `support_pg_management_repository_snippets`                | The Support ticket involves snippets                                                      |
| `support_pg_management_requirements`                       | The Support ticket involves requirements                                                  |
| `support_pg_management_requirements_creation`              | The Support ticket involves requirement creation                                          |
| `support_pg_management_requirements_errors`                | The Support ticket involves requirement errors                                            |
| `support_pg_management_requirements_other`                 | The Support ticket involves something else about requirements                             |
| `support_pg_management_requirements_questions`             | The Support ticket involves requirement questions                                         |
| `support_pg_management_requirements_settings`              | The Support ticket involves requirement settings                                          |
| `support_pg_management_roadmaps`                           | The Support ticket involves roadmaps                                                      |
| `support_pg_management_user`                               | The Support ticket involves users                                                         |
| `support_pg_management_user_creation`                      | The Support ticket involves user creation                                                 |
| `support_pg_management_user_errors`                        | The Support ticket involves user errors                                                   |
| `support_pg_management_user_other`                         | The Support ticket involves something else about users                                    |
| `support_pg_management_user_questions`                     | The Support ticket involves user questions                                                |
| `support_pg_management_user_settings`                      | The Support ticket involves user settings                                                 |
| `support_pg_management_user_todo_lists`                    | The Support ticket involves user TODO lists                                               |
| `support_pg_management_wiki`                               | The Support ticket involves wikis                                                         |
| `support_pg_management_wiki_group`                         | The Support ticket involves group wikis                                                   |
| `support_pg_management_wiki_project`                       | The Support ticket involves project wikis                                                 |
| `support_runners_agent`                                    | The Support ticket involves k8s agent runners                                             |
| `support_runners_configuration`                            | The Support ticket involves runner configuration                                          |
| `support_runners_docker`                                   | The Support ticket involves docker runners                                                |
| `support_runners_errors`                                   | The Support ticket involves runner errors                                                 |
| `support_runners_freebsd`                                  | The Support ticket involves freebsd runners                                               |
| `support_runners_helm`                                     | The Support ticket involves helm runners                                                  |
| `support_runners_installation`                             | The Support ticket involves runner installation                                           |
| `support_runners_linux`                                    | The Support ticket involves linux runners                                                 |
| `support_runners_macos`                                    | The Support ticket involves macos runners                                                 |
| `support_runners_operator`                                 | The Support ticket involves operator runners                                              |
| `support_runners_other`                                    | The Support ticket involves some other kind of runner                                     |
| `support_runners_other_topic`                              | The Support ticket involves something else about runners                                  |
| `support_runners_questions`                                | The Support ticket involves runner questions                                              |
| `support_runners_shared`                                   | The Support ticket involves shared runners                                                |
| `support_runners_windows`                                  | The Support ticket involves Windows runners                                               |
| `support_secure_api_fuzzing`                               | The Support ticket involves API fuzzing                                                   |
| `support_secure_cve_id`                                    | The Support ticket involves CVE IDs                                                       |
| `support_secure_dast`                                      | The Support ticket involves DSAT                                                          |
| `support_secure_dependency_scanning`                       | The Support ticket involves dependency scanning                                           |
| `support_secure_errors`                                    | The Support ticket involves secure errors                                                 |
| `support_secure_fuzz_testing`                              | The Support ticket involves fuzz testing                                                  |
| `support_secure_iac_scanning`                              | The Support ticket involves IAC scanning                                                  |
| `support_secure_offline_envs`                              | The Support ticket involves offline environments                                          |
| `support_secure_other`                                     | The Support ticket involves something else about secure                                   |
| `support_secure_other_topic`                               | The Support ticket involves something else about secure                                   |
| `support_secure_policies`                                  | The Support ticket involves policies                                                      |
| `support_secure_questions`                                 | The Support ticket involves secure questions                                              |
| `support_secure_revocation`                                | The Support ticket involves revocations                                                   |
| `support_secure_sast`                                      | The Support ticket involves SAST                                                          |
| `support_secure_scanner_integration`                       | The Support ticket involves scanner integrations                                          |
| `support_secure_secret_detection`                          | The Support ticket involves secret detection                                              |
| `support_secure_security_config`                           | The Support ticket involves security configuration                                        |
| `support_secure_security_dashboard`                        | The Support ticket involves security dhasboards                                           |
| `support_secure_setup`                                     | The Support ticket involves secure setup                                                  |
| `support_secure_vulnerability_levels`                      | The Support ticket involves vulnerability levels                                          |
| `support_secure_vulnerability_page`                        | The Support ticket involves vulnerability pages                                           |
| `support_secure_vulnerability_report`                      | The Support ticket involves vulnerability reports                                         |
| `support_usage_quotas_calc`                                | The Support ticket involves usage quota calculations                                      |
| `support_usage_quotas_minutes`                             | The Support ticket involves usage quota minutes                                           |
| `support_usage_quotas_other`                               | The Support ticket involves something else about usage quota                              |
| `support_usage_quotas_questions`                           | The Support ticket involves usage quota questions                                         |
| `support_usage_quotas_seats`                               | The Support ticket involves usage quota seats                                             |
| `support_usage_quotas_storage`                             | The Support ticket involves usage quota storage                                           |

</details>
<details>
<summary>Support Internal Request Tags</summary>

| Tag                                 | What it means |
|-------------------------------------|---------------|
| `support_internal_request`          | Indicates the ticket is a Support internal request |
| `support_valid_request`             | Indicates the Support internal request was valid for submission |
| `support_ir_sa_request_for_support` | Indicates the Support internal request is about a SA requesting assistance from Support |

</details>
<details>
<summary>License and Renewals Internal Request Tags</summary>

| Tag                                | What it means |
|------------------------------------|---------------|
| `lnr_internal_request`             | Indicates the ticket is a L&R internal request |
| `lnr_valid_request`                | Indicates the L&R internal request was valid for submission |
| `lnr_saas_subscription`            | Indicates the L&R internal request is about a gitlab.com subscription |
| `lnr_saas_sub_extension`           | Indicates the problem type is "Extend an (almost) expired subscription" |
| `lnr_saas_sub_issue`               | Indicates the problem type is "Investigate incorrect subscription info" |
| `lnr_saas_nfr`                     | Indicates the problem type is "gitlab.com NFR license request" |
| `lnr_billing_entity_change`        | Indicates the problem type is "Billing Entity change" |
| `lnr_saas_trial`                   | Indicates the L&R internal request is about a gitlab.com trial |
| `lnr_saas_trial_extension`         | Indicates the problem type is "Extend a gitlab.com trial" |
| `lnr_saas_trial_edit`              | Indicates the problem type is "Change existing gitlab.com trial plan" |
| `lnr_saas_trial_over_plan`         | Indicates the problem type is "Request an Ultimate trial for a customer using a Premium subscription" |
| `lnr_sm_license`                   | Indicates the L&R internal request is about a self-managed license |
| `lnr_sm_license_extension`         | Indicates the problem type is "Extend an (almost) expired subscription" |
| `lnr_sm_license_receive_error`     | Indicates the problem type is "Customer did not receive the license" |
| `lnr_sm_license_new_contact`       | Indicates the problem type is "Customer needs the license resent to a new person" |
| `lnr_multiyear_license`            | Indicates the problem type is "Multi-year license needs to be generated" |
| `lnr_sm_nfr`                       | Indicates the problem type is "Self-managed NFR license request" |
| `lnr_sm_trial`                     | Indicates the L&R internal request is about a self-managed trial |
| `lnr_sm_trial_new`                 | Indicates the problem type is "Problems starting a new Self-managed trial" |
| `lnr_sm_trial_edit`                | Indicates the problem type is "Modify an existing Self-managed trial" |
| `lnr_sm_trial_extension`           | Indicates the problem type is "Extend an existing Self-managed trial" |
| `lnr_order_management`             | Indicates the problem type is "Order Management" |
| `lnr_hackerone`                    | Indicates the problem type is "Hacker One Reporter License" |
| `lnr_community_license`            | Indicates the problem type is "Wider Community License" |
| `lnr_request_other`                | Indicates the problem type is "Other (nothing else fits the request)" |
| `lnr_reason_more_time_needed`      | To indicate the extension reason is "More time needed for POC" |
| `lnr_reason_negotiations_underway` | To indicate the extension reason is "Contract negotiations still underway" |
| `lnr_reason_payment_delays`        | To indicate the extension reason is "Delay in customer's payment process" |
| `lnr_reason_true_up_problems`      | To indicate the extension reason is "True-up problem" |

</details>
<details>
<summary>Automation Skipping Related Tags</summary>

| Tag                             | What it means |
|---------------------------------|---------------|
| `pending_followup_notification` | This is applied by an automation to followup on pending tickets. Adding this tag skips that automation. |
| `skip_2fa_automation`           | Tell Zendesk to not run any 2FA automations/autoresponders |
| `skip_autoassign`               | Tell Zendesk to not auto-assign the ticket |
| `skip_autoclose`                | Tell Zendesk to not auto-close the ticket |
| `skip_autoreopen`               | Tell Zendesk to not auto-reopen the ticket |
| `skip_autosolve`                | Tell Zendesk to not auto-solve the ticket |
| `skip_autosolve_message`        | Tell Zendesk not to send a message about the ticket being autosolved |
| `skip_community_automation`     | Tells Zendesk to not send the community autoresponder message |
| `skip_gdpr_automation`          | Tell Zendesk to not run any Account Deletion automations/autoresponders |

</details>
<details>
<summary>Resolution Code Tags</summary>

| Tag                             | What it means |
|---------------------------------|---------------|
| `support_rc_bug`                 | The Support form resolution code for the ticket is "Product bug" |
| `support_rc_incident`            | The Support form resolution code for the ticket is "Incident" |
| `support_rc_bad_docs`            | The Support form resolution code for the ticket is "Insufficient Documentation" |
| `support_rc_performance`         | The Support form resolution code for the ticket is "Capacity / Performance" |
| `support_rc_feature_request`     | The Support form resolution code for the ticket is "Feature request" |
| `support_rc_edu_or_config`       | The Support form resolution code for the ticket is "User education / Configuration change" |
| `support_rc_oos`                 | The Support form resolution code for the ticket is "Unsupported / 3rd party" |
| `support_rc_dupe`                | The Support form resolution code for the ticket is "Duplicate" |
| `support_rc_no_response`         | The Support form resolution code for the ticket is "No response" |
| `support_rc_none`                | The Support form resolution code for the ticket is "No resolution code entered" |
| `support_rc_other`               | The Support form resolution code for the ticket is "Other" |
| `saas_account_rc_bug`            | The SaaS Account form resolution code for the ticket is "Product bug" |
| `saas_account_rc_2fa`            | The SaaS Account form resolution code for the ticket is "2FA" |
| `saas_account_rc_account_access` | The SaaS Account form resolution code for the ticket is "Account Access" |
| `saas_account_rc_namesquatting`  | The SaaS Account form resolution code for the ticket is "Namesquatting" |
| `saas_account_rc_edu_or_config`  | The SaaS Account form resolution code for the ticket is "User education / Configuration change" |
| `saas_account_rc_dupe`           | The SaaS Account form resolution code for the ticket is "Duplicate" |
| `saas_account_rc_no_response`    | The SaaS Account form resolution code for the ticket is "No response" |
| `saas_account_rc_none`           | The SaaS Account form resolution code for the ticket is "No resolution code entered" |
| `saas_account_rc_other`          | The SaaS Account form resolution code for the ticket is "Other" |
| `lnr_rc_bug`                     | The L&R form resolution code for the ticket is "Product bug" |
| `lnr_rc_license_resent`          | The L&R form resolution code for the ticket is "License resent" |
| `lnr_rc_portal_Access`           | The L&R form resolution code for the ticket is "Portal access" |
| `lnr_rc_edu_or_config`           | The L&R form resolution code for the ticket is "User education / Configuration change" |
| `lnr_rc_dupe`                    | The L&R form resolution code for the ticket is "Duplicate" |
| `lnr_rc_no_response`             | The L&R form resolution code for the ticket is "No response" |
| `lnr_rc_none`                    | The L&R form resolution code for the ticket is "No resolution code entered" |
| `lnr_rc_other`                   | The L&R form resolution code for the ticket is "Other" |

</details>
<details>
<summary>Other Notable Tags</summary>

| Tag                              | What it means |
|----------------------------------|---------------|
| `agent_offered_call`             | SE has sent a call link in a public comment |
| `docs_link`                      | SE has sent a link to docs.gitlab.com in a public comment |
| `gitlab_issue_link`              | SE has sent a link to a gitlab.com issue in a public comment |
| `gitlab_merge_request_link`      | SE has sent a link to a gitlab.com merge request in a public comment |
| `hb_link`                        | SE has sent a link to handbook.gitlab.com in a public comment |
| `partner_customer`               | Indicates the account is a customer of an Alliance partner and not eligible for support |
| `star_submitted`                 | Indicates a STAR has been submitted on the ticket |
| `within_grace_period`            | Indicates a ticket was submitted while the account is within the subscription's grace period |
| `CUSTOM_PATH_issues_IID`         | See below for more information |
| `CUSTOM_PATH_merge_requests_IID` | See below for more information |
| `americas_usa`                   | Customer selected preferred region of service: AMER |
| `europe__middle_east__africa`    | Customer selected preferred region of service: EMEA |
| `asia_pacific`                   | Customer selected preferred region of service: APAC |
| `all_regions`                    | Customer selected preferred region of service: All Regions |

For `CUSTOM_PATH_issues_IID` and `CUSTOM_PATH_merge_requests_IID`, this refers
to a long tag that contains the entire project path.

So an example:

- a link to issue 5 on project jcolyer/most_amazing_project_ever would be:
  `jcolyer_most_amazing_project_ever_issues_5`
- a link to merge request 27 on project jcolyer/most_amazing_project_ever would
  be: `jcolyer_most_amazing_project_ever_merge_requests_27`

</details>

## Zendesk US Federal common tags

<details>
<summary>SLA/Subscriptiom Related Tags</summary>

| Tag                              | SLA granted | What it means |
|----------------------------------|-------------|---------------|
| `sub_community_other`            | None        | The organization has a community subscription of an unknown type |
| `sub_consumption_ai`             | None        | The organization has purchased an AI addon |
| `sub_consumption_cicd_minutes`   | None        | The organization has purchased CI/CD minutes |
| `sub_consumption_eap`            | None        | The organization has purchased the Enterprise Agile Planning addon |
| `sub_consumption_storage`        | None        | The organization has storage |
| `sub_consumption_duo_enterprise` | Consumption | The organization has purchased GitLab Duo Enterprise |
| `sub_consumption_duo_premium`    | Consumption | The organization has purchased GitLab Duo Premium |
| `sub_consumption_duo_amazon_q`   | Consumption | The organization has purchased GitLab Duo with Amazon Q |
| `sub_dotcom_premium`             | None        | The organization has a GitLab.com Premium subscription |
| `sub_dotcom_ultimate`            | None        | The organization has a GitLab.com Ultimate subscription |
| `sub_edu`                        | None        | The organization has a EDU community subscription |
| `sub_gitlab_dedicated`           | Priority    | The organization has a GitLab Dedicated subscription |
| `sub_oss`                        | None        | The organization has a OSS community subscription |
| `sub_other`                      | None        | The organization has an unknown purchase |
| `sub_proserv`                    | None        | The organization has a Professional Services engagement purchase |
| `sub_sm_premium`                 | Priority    | The organization has a Self-managed Premium subscription |
| `sub_sm_starter`                 | Standard    | The organization has a Self-managed Starter subscription |
| `sub_sm_ultimate`                | Priority    | The organization has a Self-managed Ultimate subscription |
| `sub_ss_ase`                     | None        | The organization has purchased an Assigned Support Engineer addon |
| `sub_usgov_12x5`                 | Priority    | The organization has a US Government purchase granting 12x5 support |
| `sub_usgov_24x7`                 | Priority    | The organization has a US Government purchase granting 24x7 support |

</details>
<details>
<summary>Account Related Tags</summary>

| Tag                   | What it means |
|-----------------------|---------------|
| `customer`            | Signifies the ticket is from an account labeled as Customer |
| `former_customer`     | Signifies the ticket is from an account labeled as Former Customer |
| `reseller`            | Signifies the ticket is from an account labeled as Reseller |
| `authorized_reseller` | Signifies the ticket is from an account labeled as Authorized Reseller |
| `integrator`          | Signifies the ticket is from an account labeled as Integrator |
| `partner`             | Signifies the ticket is from an account labeled as Partner |
| `unofficial_reseller` | Signifies the ticket is from an account labeled as Unofficial Reseller |
| `open_partner`        | Signifies the ticket is from an account labeled as Open Partner |
| `select_partner`      | Signifies the ticket is from an account labeled as Select Partner |
| `alliance_partner`    | Signifies the ticket is from an account labeled as Alliance Partner |
| `support_hold`        | Signifies the organization that filed the ticket has a Support Hold in place |

</details>
<details>
<summary>Organization Tags</summary>

| Tag                            | What it means |
|--------------------------------|---------------|
| `greatly_expired`              | The organization is slated to be removed due to data rentention policies |
| `not_in_sfdc`                  | The organization is not being controlled by the ZD-SFDC sync |
| `restricted_account`           | The SFDC account is classified as restricted and cannot receive support |
| `sub_community_other`          | The organization has a community subscription which had an undetectable type |
| `sub_consumption_ai`           | The organization has an AI subscription |
| `sub_consumption_cicd_minutes` | The organization has a CI/CD minutes purchase |
| `sub_consumption_eap`          | The organization has an Agile Planning addon |
| `sub_consumption_storage`      | The organization has a storage purchase |
| `sub_dotcom_premium`           | The organization has a gitlab.com Premium subscription |
| `sub_dotcom_ultimate`          | The organization has a gitlab.com Ultimate subscription |
| `sub_edu`                      | The organization has an EDU community subscription |
| `sub_gitlab_dedicated`         | The organization has a GitLab Dedicated subscription |
| `sub_oss`                      | The organization has an OSS subscription |
| `sub_other`                    | The organization has a subscription but the type could not be determined |
| `sub_proserv`                  | The organization has a Proserv subscription |
| `sub_sm_premium`               | The organization has a Self-Managed Premium subscription |
| `sub_sm_starter`               | The organization has a Self-Managed Starter subscription |
| `sub_sm_ultimate`              | The organization has a Self-Managed Ultimate subscription |
| `sub_ss_ase`                   | The organization has an Assigned Support Engineer addon |
| `sub_usgov_12x5`               | The organization has a US Government 12x5 subscription |
| `sub_usgov_24x7`               | The organization has a US Government 24x7 subscription |

</details>
<details>
<summary>Automation Skipping Related Tags</summary>

| Tag                      | What it means |
|--------------------------|---------------|
| `skip_autosolve`         | Tell Zendesk to not auto-solve the ticket |
| `skip_autoclose`         | Tell Zendesk to not auto-close the ticket |
| `skip_autoreopen`        | Tell Zendesk to not auto-reopen the ticket |
| `skip_gdpr_automation`   | Tell Zendesk to not run any Account Deletion automations/autoresponders  |
| `skip_autosolve_message` | Tell Zendesk not to send a message about the ticket being autosolved. |
| `skip_autoassign`        | Tell Zendesk to not auto-assign the ticket |

</details>

<details>
<summary>Other Notable Tags</summary>

| Tag                          | What it means                                                                           |
|------------------------------|-----------------------------------------------------------------------------------------|
| `partner_customer`           | Indicates the account is a customer of an Alliance partner and not eligible for support |
| `star_submitted`             | Indicates a STAR has been submitted on the ticket                                       |
| `submitted_via_gitlab_email` | Signifies the ticket is submitted by a GitLab Team Member to Support Team               |

</details>
