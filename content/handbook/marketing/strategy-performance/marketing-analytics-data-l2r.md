---
title: Marketing Analytics Data - L2R Models
description: >-
  The L2R Models grouping is comprised of the core Lead to Revenue model and those models built directly from it. 
---

<link rel="stylesheet" type="text/css" href="/stylesheets/biztech.css" />

## Rpt_lead_to_revenue

The Lead to Revenue report is the consolidation of the major lifecycle objects/marts: Person, Opportunity, Account, and both types of Bizible Touchpoints. It is a one-stop shop for nearly all Sales and Marketing metrics and data on the joined objects. It allows for quick analysis of funnel progression, cohorting of data points and metrics, and allows for a true funnel from lead creation to opportunity close to be created from one table. 

### Use Cases

1. Funnel stage progression of a given record
1. Count of records in a given funnel stage
1. Average velocity between funnel stages
1. Cohorting data around a given attribute

### Key Fields

1. `lead_to_revenue_id` - The surrogate key that identifies a unique row in this model. 
1. `[kpi]_date_range_*` - KPI-specific date aggregations
1. `bizible_mql_*` - Bizible TP data on the TP that occurs just prior to the MQL Date.
1. `bizible_most_recent_*` - Bizible TP data on the most recent TP on a person/opportunity

### Key Metrics

1. Count of records by funnel stage
1. Count of Touchpoints between specific funnel stages
1. Overall velocity through the funnel
1. Funnel stage conversion rates

### Data Lineage

1. Data is sourced from SFDC
1. The full lineage can be seen [here](https://dbt.gitlabdata.com/#!/model/model.gitlab_snowflake.rpt_lead_to_revenue?g_v=1&g_i=%rpt_lead_to_revenue%2B)

### DBT Solution

The dbt solution generates a dimensional model from RAW source data. The exceptions are the following fields that are calculated based on business logic implemented within specific dbt models:

| Field              | Business Logic   |
|--------------------|------------------|
| lead_to_revenue_id | Defined in model |
| [kpi]_date_range_* | Defined in model |

## Rpt_l2r_campaign_interactions

The L2R Campaign Interactions report table uses a primary union between person/buyer and attribution/opportunity touchpoint and related mart fields to derive its base table. From there, various calculations on date/time fields and related dimensions are performed. 

### Use Cases

L2R is the base table of Campaign reporting at GitLab. It combines touchpoints allowing us to create a single view that shows the top of the funnel to Influenced SAO. It is used to track the conformance of email, content, and paid media efforts.

### Key Fields
1. Person_order_type
   1. A derived Order Type for the person record, based on the is_first_order_person SFDC field
1. Touchpoint_type
   1. A denotation of whether the given touchpoint/record is a Person/Buyer or Opportunity/Attribution touchpoint. 
1. Custom attribution fields (i.e. custom_sao)
   1. Calculations to sum up the custom model weights of an opportunity’s touchpoints based on other criteria in the model
1. Person_status_change
   1. A derived field to show the person record’s progression from one status to another. 
1. Is_mdf_campaign
   1. A T/F flag that shows whether or not the campaign associated with the record will have MDF funding or not. 
1. report_opportunity_*
   1. Derived fields to show the report-based attributes of the opportunity leveraging historical snapshot data where appropriate. 
1. Is_sales_dev_owned_record
   1. A T/F flag to show whether or not the record is owned by a Sales Dev rep in SFDC. 
1. *_date_range_*
   1. The pre-defined date aggregations of a given funnel-stage’s date for the given record.

### Key Metrics

### Data Lineage

1. Data is sourced from SFDC and L2R
1. The full lineage can be seen [here](https://dbt.gitlabdata.com/#!/model/model.gitlab_snowflake.rpt_l2r_campaign_interactions?g_v=1&g_i=%rpt_l2r_campaign_interactions%2B)

| Field                                       | Business Logic   |
|---------------------------------------------|------------------|
| Custom attribution fields (i.e. custom_sao) | Defined in model |
| person_status_change                        | Defined in model |
| is_mdf_campaign                             | Defined in model |
| report_opportunity_*                        | Defined in model |
| is_sales_dev_owned_record                   | Defined in model |
