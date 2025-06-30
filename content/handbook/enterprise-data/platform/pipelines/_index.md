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

| Factors         | Snowflake share | ETL Vendor | Custom | 
| --------------- |---------------- | ---------- | -------|
| Ease            | ✅              | ✅         | ❔     |
| Flexible        | ❌              | ❌         | ✅     |
| Private         | ✅              | ❌         | ✅     |
| Secure          | ✅              | ❔         | ✅     |
| Maintainable    | ❔              | ❌         | ✅     |   
| Cost Effective  | ❔              | ❔         | ❔     | 
| Democratization | ❌              | ❔         | ✅     |

Given than the main downside to Custom Pipelines is their slower time to implementation, any gains on developer efficiency and code maintainability here come with signigicant advantages. Even still, in many cases new pipelines are implemented without clarity on criticality. Enterprise applications are often changed and replaced and so even if we were able to implement the best possible custom pipeline framework, it would still make sense for us to use vendors. That is, in many cases, writing a custom pipeline just isn't worth the time or effort. 

#### Democratization 

We want our business partners to contribute to existing pipelines when data scope changes, as we don't want the Data Platform Team to become a bottleneck for relatively easy, short but business-impactful tasks like adding a new field.

- **Snowflake share**: This may not apply, and if it does, it would need to be arranged with the upstream vendor to change their Snowflake share.
- **ETL Vendor**: Makes it easy to add new fields, but it is questionable whether we would want to give (all) business partners access to the solution since it is not version controlled.
- **Custom development**: We want to make it so everyone can contribute. Developed pipelines require a configuration file that lists which tables/columns/endpoints need to be extracted to the Data Platform. We would encourage our business partners to make changes to these configuration files to modify the data scope (adding new tables) via a merge request and test them via a CI pipeline before submitting them for review by the respective code owners.

### Criteria for Snowflake Share

The Main limitation on Snowflake Shares is their availability. If a Snowflake share is available for a data source **_and_ it meets the requirements given by our business partners** then it's likely a good solution, asumming any price is within budget.

It is essential to assess current and future requirements for the data because the easy and simplicity of using snowflake shares is paired with no flexibility. So if our requirements exceed what is available in the share then we are left without options. Further, if downstream models have already been implemented, a pipeline migration would be needed, which can be more expensive than an initial implementation.

### Criteria for ETL Vendor

ETL Vendors, like Fivetran give us more flexibility than a Snowflake share, but they come with additional cost to our contract. As noted, these can be a great option when we need to move quickly, espeically when the criticality of a new data source is unclear.

A lack of flexibility and maintainability is still an important consideration here. We've had trouble managing high complexity pipelines within vendor interfaces, and have experience pain in change management without the ability to apply approvals or tests to changes.  If the complexity of objects and/or attributes is relatively high, it might be worth considering a cutom pipeline. 

The volume of records is also a primary consideration for using Vendors at the moment as they are usually priced on usage. Contract impact is a required evaluation step for this solution. High cost may also warrant a custom pipeline.

Some data sources are just too senstive to allow for a third party to have access. Keeping the pipeline without our data platform is likely required for such cases.

For Platform efficiency, we do not want vendors in this area with overlapping functionalities. This means we want a maximum of 1 vendor. While vendors often provide different sets of available connectors, the availability of connectors in a different vendor's product is not sufficient justification to add that vendor. A business case to add a new vendor to the Data Platform must include replacing the current existing vendor.
Currently, the Data Platform has multiple vendors (Fivetran, Stitch, and Meltano). This means we will consolidate to 1 vendor (to be determined).
### Criteria for Custom Pipelines

Custom data pipelines should be considered our best option in the sense that these pipelines offer the most opportunity for flexibility, privacy, security, and maintainability. Though, as noted, such a solution isn't always warrented. 

---

Evaluating and Solutioning Pipeline Sources
-------------------------------------------

Things we consider when implementing a pipeline for data extraction (but are not limited to) are:

| Considerations | Descriptions | Context/links |
| -------------- | ------------ | ------------- |
| Data Classification | Customer Data (Red data) could only processed via listed and approved [third party sub processors]( https://about.gitlab.com/privacy/subprocessors/#third-party-sub-processors).   |
| Schema Complexity |    |
| Data Volume |    |
| Business Criticality |    |
| Latency Requirements | ETL vendors are often limited in the scheduling of the refreshes | https://gitlab.com/gitlab-data/analytics/-/issues/21649#note_2262432625 | 
| Access Options (database, API, filestore, etc.) |    |

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

## Roadmap
