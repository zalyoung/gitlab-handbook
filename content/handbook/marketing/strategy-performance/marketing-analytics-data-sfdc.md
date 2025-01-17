---
title: Marketing Analytics Data - SFDC Models
description: >-
  The SFDC Models grouping is used to designate models built from the Salesforce source objects. 

---

<link rel="stylesheet" type="text/css" href="/stylesheets/biztech.css" />

## Mart_crm_attribution_touchpoint

The Attribution Touchpoint mart is the consolidated repository of Marketo Measure’s (Bizible’s) Attribution Touchpoint data. An Attribution Touchpoint is a touchpoint associated with an Opportunity in SFDC. This mart allows you to analyze engagement by Opportunity and/or Account during the entire lifecycle of either. 

### Use Cases

1. Attributed ARR
1. Touchpoints during a given stage

### Key Terms

1. Attribution Touchpoint
   1. The record of engagement, captured through Bizible (Marketo Measure) that is associated with an Opportunity in SFDC. 
1. Net ARR
   1. Definition
1. Attribution Models
   1. Bizible-defined
   1. Linear
      1. An even distribution of weight/attribution split amongst every touchpoint related to the record. 
1. Is MGP Opportunity
   1. At least 2 unique marketing channel touchpoints for First Order and 3 unique marketing channel touchpoints for Growth opportunities, within a window of 365 days before Pipeline Created Date
1. Gitlab Model Weight
1. Time Decay Model Weight
1. Data Driven Model Weight
1. Touchpoint Sales Stage
   1. The Sales funnel stage the touchpoint occurred in. 
1. Is FMM Influenced
   1. Whether a given touchpoint is influenced by FMM effort. 
1. Is FMM Sourced
   1. Whether a given touchpoint is sourced by FMM effort. 

### Key Metrics
1. Attributed Weight
   1. The weight of a given touchpoint, based on which attribution model you are looking at. 
1. Attributed Net ARR
   1. The attributed net arr, based on which attribution model you are looking at. 

### Data Lineage
1. Data is sourced from SFDC and Bizible/Marketo Measure
1. The full lineage can be seen [here](https://dbt.gitlabdata.com/#!/model/model.gitlab_snowflake.mart_crm_attribution_touchpoint?g_v=1&g_i=%2Bmart_crm_attribution_touchpoint%2B)

### DBT Solution
The dbt solution generates a dimensional model from RAW source data. The exceptions are the following fields that are calculated based on business logic implemented within specific dbt models:

| Field                  | Business Logic   |
|------------------------|------------------|
| touchpoint_sales_stage | [Defined in model](https://gitlab.com/gitlab-data/analytics/-/blob/master/transform/snowflake-dbt/models/common_mart_marketing/mart_crm_attribution_touchpoint.sql#L114) |
| is_mgp_opportunity     | [Defined in model](https://gitlab.com/gitlab-data/analytics/-/blob/master/transform/snowflake-dbt/models/common/facts_sales_and_marketing/fct_crm_attribution_touchpoint.sql#L40) |
| is_fmm_influenced      | [Defined in model](https://gitlab.com/gitlab-data/analytics/-/blob/master/transform/snowflake-dbt/models/common_mart_marketing/mart_crm_attribution_touchpoint.sql#L311) |
| is_fmm_sourced         | [Defined in model](https://gitlab.com/gitlab-data/analytics/-/blob/master/transform/snowflake-dbt/models/common_mart_marketing/mart_crm_attribution_touchpoint.sql#L320) |



