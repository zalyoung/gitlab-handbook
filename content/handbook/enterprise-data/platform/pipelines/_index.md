---
title: "Data pipelines"
description: "This page describes the different data sources and the way we extract this data via data pipelines."
---

## Overview
The Data Warehouse contains data from a wide variety of sources. In order to support such dynamic and vast integrations we employ the a data extraction strategy with advanced tooling and best in class data engineering standards.
Detailed information about specific **Data Pipelines** is available on our [Internal GitLab Handbook Pipelines page](https://internal.gitlab.com/handbook/enterprise-data/platform/pipelines).


Ideally, all data extraction pipelines should fall into 1 of 3 categories:
1. Snowflake Share
1. ETL Vendor (Fivetran)
1. Custom Pipeline 

```mermaid
flowchart LR

subgraph data platform

    object_storage --> warehouse
    custom_pipeline --> object_storage@{ shape: procs, label: "object storage"}

    subgraph snowflake
        snowflake_share[(share)] --> warehouse[(data warehouse)]
    end

end

etl_vendor[/etl vendor/] --> warehouse
```