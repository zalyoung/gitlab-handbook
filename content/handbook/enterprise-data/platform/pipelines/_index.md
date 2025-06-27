---
title: "Data Pipelines"
description: "This page describes the ways we extract this data via data pipelines."
---

Data Pipelines
==============

The Data Warehouse contains data from a wide variety of sources. In order to support such dynamic and vast integrations we employ a data extraction strategy with advanced tooling and best-in-class data engineering standards.
Detailed information about specific **Data Pipelines** is available on our [Internal GitLab Handbook Pipelines page](https://internal.gitlab.com/handbook/enterprise-data/platform/pipelines).

Data Extraction Solutions 
-------------------------

Ideally, all data extraction pipelines should fall into 1 of 3 categories:

1. Snowflake Share
1. ETL Vendor (Fivetran)
1. Custom Pipeline 

```mermaid
flowchart LR

subgraph data platform

    object_storage --> warehouse
    custom_pipeline --> object_storage[[object storage]]

    subgraph snowflake
        snowflake_share[(share)] --> warehouse[(data warehouse)]
    end

end

etl_vendor[/etl vendor/] --> warehouse
```

These solutions have varying strengths and weaknesses and there is no solution that fits all cases. In solutioning we take a variety of factors into consideration. 

| Factors        | Custom  | Snowflake share | ETL Vendor |
| -------------- | ------- |-----------------| ---------- |
| Ease           | ❔      | ✅              | ✅         |
| Flexible       | ✅      | ❌              | ❌         |
| Private        | ✅      | ✅              | ❌         |
| Secure         | ✅      | ✅              | ❔         |
| Maintainable   | ✅      | ❔              | ❌         |
| Cost Effective | ❔      | ❔              | ❔         |

Given than the main downside to Custom Pipelines is their slower time to implementation, any gains on developer efficiency and code maintainability here come with signigicant advantages. Even still, in many cases new pipelines are implemented without clarity on criticality. Enterprise applications are often changed and replaced and so even if we were able to implement the best possible custom pipeline framework, it would still make sense for us to use vendors. That is, in many cases, writing a custom pipeline just isn't worth the time or effort. 

### Criteria for Snowflake Share

The Main limitation on Snowflake Shares is their availability. If a Snowflake share is available for a data source **_and_ it meets the requirements given by our business partners** then it's likely a good solution, asumming any price is within budget.

It is essential to assess current and future requirements for the data because the easy and simplicity of using snowflake shares is paired with no flexibility. So if our requirements exceed what is available in the share then we are left without options. Further, if downstream models have already been implemented, a pipeline migration would be needed, which can be more expensive than an initial implementation.

### Criteria for ETL Vendor

ETL Vendors, like Fivetran give us more flexibility than a Snowflake share, but they come with additional cost to our contract. As noted, these can be a great option when we need to move quickly, espeically when the criticality of a new data source is unclear.

A lack of flexibility and maintainability is still an important consideration here. We've had trouble managing high complexity pipelines within vendor interfaces, and have experience pain in change management without the ability to apply approvals or tests to changes.  If the complexity of objects and/or attributes is relatively high, it might be worth considering a cutom pipeline. 

The volume of records is also a primary consideration for using Vendors at the moment as they are usually priced on usage. Contract impact is a required evaluation step for this solution. High cost may also warrant a custom pipeline.

Some data sources are just too senstive to allow for a third party to have access. Keeping the pipeline without our data platform is likely required for such cases.

### Criteria for Custom Pipelines

Custom data pipelines should be considered our best option in the sense that these pipelines offer the most opportunity for flexibility, privacy, security, and maintainability. Though, as noted, such a solution isn't always warrented. 

---

Evaluating and Solutioning Pipeline Sources
-------------------------------------------

Things we consider when implementing a pipeline for data extraction (but are not limited to) are:

<!-- Maybe this should be a table with discriptions and links, I am not sure we need a heading/section for each though -->
- Data Sensitivity
- Schema Complexity
- Data Volume
- Business Criticality
- Latency Requirements
- Access Options (database, API, filestore, etc.)

Some of these necessitate certain solutions. For example, data in a filestore like GCS will always be solutioned with custom pipelines as it's the easiest _and_ lowest cost solution. But in many cases there isn't a consistent path. For example, we sometimes have many options available for access. 

We assess these factors when solutioning a new data source in the [New Data Source Issue Template](https://gitlab.com/gitlab-data/analytics/-/blob/master/.gitlab/issue_templates/%5BNew%20Request%5D%20New%20Data%20Source.md?ref_type=heads)<!-- which will be updated before this MR is merged -->. The investigation and validation process outlined there is essential to our success and is required to be completed in order for implementation to be scheduled. 

<!-- needs more detail about how we ensure this process is completed in a timeline way -->

---

Custom Pipelines
---------------------------------

A signifcant weakness that can emerge from custom pipelines is that we can write inconsistencies, redundancies, and complexity into our data platform if we're not careful. To this end we expect our custom pipelines to ahear to the following specifications. 

### Easy to Use 

<!-- 
Including, but still working on descriptions for 
- observability (Python logging)
- Development Lifecycle
    - Including standard environment managagement, testing, and CI/CD standards
- Code Quality/Hygeine (Radovan, pls help)
- Easy to use
- Well documented
-->

### Secure



### Performant
