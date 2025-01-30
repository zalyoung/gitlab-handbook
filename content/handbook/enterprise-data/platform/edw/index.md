---
title: "Enterprise Data Warehouse"
---

## Enterprise Data Warehouse Overview

### Architectural Overview

GitLab's Enterprise Data Warehouse serves as our central repository for analytics and reporting, transforming raw data into actionable insights. Through the combination of Snowflake's powerful data platform and dbt's transformation capabilities, we've implemented a robust ELT (Extract, Load, Transform) framework that adheres to the Kimball methodology.

Our warehouse architecture is organized into four distinct schemas:

1. **COMMON Schema:** Houses our Enterprise Dimensional Model (EDM), serving as the heart of our integrated application data. This schema implements the Kimball methodology to ensure the highest data quality standards.
1. **SPECIFIC Schema:** Maintains independent application data that doesn't require integration with other systems, following our Trusted Data Development process while avoiding unnecessary complexity.
1. **WORKSPACE Schema:** Provides a flexible environment for experimentation and prototyping, serving as a staging area for future EDM solutions.
1. **LEGACY Schema:** Maintains historical modeling approaches as we strategically deprecate and migrate critical systems to our modern architecture.

## The Data Journey

The journey from raw data to dimensional models follows a carefully orchestrated path through three distinct layers:

```mermaid
flowchart LR
    Staging --> Preparation --> Modeling
```

### Foundational Principles for Preparing Data Models

The following principles guide how we prepare data for use in data models. These principles form the foundation for what changes should be made to data and help categorize where and when those changes will be made. While these principles provide guidance, individual developers must rely on subject matter knowledge and their understanding of the craft to apply these principles effectively.

### Staging Layer

The staging layer forms our foundation, where we first conform the data to GitLab standards. This standardization occurs as close to the source as possible, ensuring clean, reliable data for downstream processes. Key aspects include:

- Conforming column names and data types to GitLab standard conventions
- Establishing consistent handling of NULL and blank values
  - Converting blank values to NULL
  - Setting appropriate defaults when NULL values are not acceptable
- Normalizing column names to improve readability and self-documentation
- Avoiding repetitive naming across data models

These transformations ensure expected behavior in downstream processes and help catch malformed data early in the pipeline.

### Preparation Layer

In the preparation layer, business logic meets data. This layer encompasses:

- Filtering malformed records
- Creating calculated fields
- Deriving fields and records
- Applying business logic and quality tests

These transformations should be separated from staging steps to improve maintainability and readability. While many transformations can be performed in a single data model, separate and sequential models may be used when doing so increases readability or maintainability.

For record derivation (such as date interval expansion), it's best to delay processing as long as possible to manage potential performance issues. Field derivation, which requires combining multiple data models, should be performed where it adds the least complexity and minimizes dataset size increases.

### Modeling Layer

The final modeling layer transforms our prepared data into business-ready structures. This layer:

- Implements specific business requirements
- Optimizes for analytics
- Creates fact and dimension tables
- Applies transformations driven by specific business use cases

The transformations in this step should be derived from specific business requirements that couldn't be applied at a broader scale. The result enables self-service analytics while maintaining high performance standards.

## Dimensional Modeling Fundamentals

Dimensional modeling is part of the Business Dimensional Lifecycle methodology developed by [Ralph Kimball](https://en.wikipedia.org/wiki/Ralph_Kimball). It presents data in a standard, intuitive framework that allows for high-performance access while maintaining business process orientation.

### Useful links and resources

- [dbt Discourse about Kimball dimensional modelling](https://discourse.getdbt.com/t/is-kimball-dimensional-modeling-still-relevant-in-a-modern-data-warehouse/225/6) in modern data warehouses including some important ideas why we should still use Kimball
- [Dimensional modelling manifesto](https://www.kimballgroup.com/1997/08/a-dimensional-modeling-manifesto/)
- [Dimensional Modelling techniques](https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/dimensional-modeling-techniques/) by Kimball Group

### Core Concepts

Dimensional modeling uses two primary components:

- **Facts (Measures)**: Typically numeric values that can be aggregated
- **Dimensions (Context)**: Groups of hierarchies and descriptors that define the facts

This approach creates several schema patterns:

- **Star Schema**: Central fact table linked to dimension tables
- **Snowflake Schema**: Dimensional tables linking to other dimension tables
- **Galaxy Schema**: Multiple interconnected fact tables

### Development Process

Dimensional models are built in four key steps:

1. Choose the business process (e.g., track monthly revenue)
1. Declare the grain (e.g., per customer)
1. Identify the dimensions
1. Identify the facts

### Benefits of Dimensional Modeling

1. Industry-standard design proven successful over decades
1. Easy to understand and access data structures suitable for business teams
1. Centralized implementation of business logic and consistent definitions
1. Support for "plug and play" of new subject areas
1. Increased model power as dimensions are added

The dimensional model grows stronger over time as more dimensions are added, providing a flexible and scalable foundation for enterprise analytics.

## Schemas

Our schema design reflects the natural progression of data through our warehouse, from initial ingestion to final consumption. Raw data enters through dedicated schemas, undergoes transformation in preparation schemas, and ultimately resides in consumption-ready schemas that support our dimensional model. This layered approach allows us to maintain clean handoffs between different stages of data processing while ensuring data quality and consistency throughout the pipeline. Each schema serves as a checkpoint in our data's journey, with clear responsibilities and governance rules that help maintain the integrity of our data warehouse.

## Common Prep Schema

The Common Prep schema serves as a crucial intermediate layer in our data architecture, guided by four fundamental principles that ensure data quality, maintainability, and usability.

### Core Principles

Four fundamental principles guide development and maintenance:

1. **Single Source of Truth** Maintain one prep model per dimensional entity. For example, use a single `prep_charge` model rather than separate variations, pushing specialized versions downstream as `FACT`, `MART`, or `REPORT` models. This approach:

- Streamlines data lineage
- Keeps code DRY
- Reduces maintenance overhead
- Prevents redundant implementations

1. **Lowest Grain Preservation** Keep prep models at the lowest possible grain of the dimensional entity. This:

- Establishes them as the Single Source of Truth (SSOT)
- Enables flexible downstream modeling
- Supports various model types (`DIM`, `FACT`, `MART`, `MAPPING`, `BDG`, `REPORT`)
- Avoids limiting future analysis capabilities

1. **Comprehensive Data Retention** Avoid filtering records in the `COMMON_PREP` schema. Instead:

- Implement filtering in `COMMON` schema and downstream
- Maintain data availability for various use cases
- Prevent premature data exclusion
- Support diverse analytical needs

1. **Pragmatic Model Creation** Skip the prep layer when direct transformation to Common schema is more efficient:

- Avoid pattern-based modeling
- Eliminate unnecessary complexity
- Focus on value addition
- Maintain model efficiency

### Use Cases

The schema serves six essential functions:

1. **Surrogate Key Generation** Create and manage keys used throughout the Common Schema.
1. **Data Cleansing** Standardize data types and handle `NULL` values consistently.
1. **Business Logic Application** Implement transformations needed before data combination.
1. **Reference Data Integration** Incorporate foreign keys and identifier fields for proper joining.
1. **Source Unification** Combine multiple data sources with consistent formatting.
1. **Performance Optimization** Break down large datasets for efficient processing.

While the `COMMON_PREP` schema is optional, it provides significant value when used appropriately. These principles establish a foundation for clean, maintainable, and efficient data modeling that supports diverse analytical needs while preventing unnecessary complexity.

## Common Mapping Schema

Mapping/look-up (map_) tables to support dimension tables should be created in the `common_mapping` schema.

## Common Schema

The Common schema is where all of the facts and dimensions that compose the Enterprise Dimensional Model are stored. The Common schema contains a variety of different types of dimensions and facts that create multiple star schemas. The models in this schema are robust and provide the basis for analyzing GitLab's businesses processes. 

Our dimensional model revolves around two core components: dimensions (providing context) and facts (measuring events). Understanding each component's role and characteristics is crucial for effective data modeling.

### Dimension Tables

Dimension tables supply the descriptive attributes that give context to our business events. These are the "who, what, where, when, why, and how" of our data. A dimension table typically represents a business entity like a customer, product, or location.

#### Characteristics of Dimensions

- Contain descriptive attributes (text-based or categorical)
- Usually have fewer rows than fact tables but more columns
- Change relatively slowly over time
- Provide the entry points for querying and filtering
- Include hierarchical relationships (e.g., geography hierarchies)

#### Common Types of Dimensions

1. **Conformed Dimensions** These dimensions maintain consistent meaning across multiple fact tables. Examples include:

- Date dimensions used across various business processes
- Customer dimensions used in sales and support
- Product dimensions used in inventory and sales

1. **Local Dimensions** Specific to a single business process or fact table, these dimensions provide context for particular events or metrics. Examples include:

- Support ticket status
- Order types
- Campaign attributes

#### Slowly Changing Dimensions & Snapshots

##### Understanding Time Perspectives

Data analysis typically requires two viewpoints: current and historical. The current view uses up-to-date dimension values, while historical analysis needs to understand how things looked at specific points in time. For example:

- Analyzing sales with a previous product catalog
- Tracking customer location changes over time
- Understanding organizational structure changes

##### Types of Dimensions

We implement three approaches to handle time-based changes:

1. **Type 1 Dimensions**

- Overwrite values when they change
- Maintain only current state
- Provide simplest implementation
- Lose historical context

1. **Type 2 Dimensions (SCD)**

- Add new records for changes
- Track validity periods with `valid_from` and `valid_to` dates
- Enable historical analysis
- Maintain complete change history

1. **Type 3 Dimensions**

- Maintain current and alternate values
- Enable multiple analytical perspectives
- Support dual categorization needs
- Not currently implemented in our EDM

##### SCD in Practice

Snapshot tables form the backbone of our historical tracking system, capturing the complete lifecycle of business objects from creation through every modification to the present state. These tables maintain a detailed audit trail of changes while enabling efficient historical analysis.

In our implementation, Slowly Changing Dimensions are created using dbt's snapshot functionality. dbt snapshots provide a simple yet powerful way to track historical changes in our data. When a snapshot is run, dbt compares the current state of the data with the previous snapshot and automatically tracks any changes through `valid_from` and `valid_to` dates.

A snapshot tracks changes through validity periods, marking each state with these timestamps. For example, a simple state change might look like:

| id | attribute | valid_from_date | valid_to_date |
|----|-----------|----------------|---------------|
| 1  | 'open'    | 2022-01-01     | 2021-01-02    |
| 1  | 'closed'  | 2022-01-02     | NULL          |

While this format efficiently stores historical data, it can be challenging for business users to analyze. To improve usability, we transform these snapshots into daily grain records in the `COMMON` schema. These `_daily_snapshot` models expand the validity periods into individual day records, making time-based analysis more intuitive while maintaining consistency with our dimensional model.

During model development, we start with staging models in `COMMON_PREP` to implement business logic, then use dbt's snapshot functionality to track changes. This foundation allows us to create daily snapshots when needed while managing performance impacts.

Best practices for snapshot implementation include adding clear current record indicators, maintaining consistent grain across related models, and thoroughly documenting validity periods. These practices ensure our historical tracking remains accurate and performant while serving diverse analytical needs.

### Fact Tables

Fact tables record the business events we want to analyze. They contain the quantitative metrics (measures) of our business processes, along with references to related dimensions.

#### Characteristics of Facts

- Contain numeric measures that can be aggregated
- Usually have many rows but fewer columns
- Grow continuously as new events occur
- Include foreign keys to dimensions
- Represent specific business processes

#### Types of Facts

**Atomic Facts** Fact tables record business events at their most granular level, serving as the foundation for all fact-based analysis. These tables:

- Represent individual business events
- Maintain complete, unfiltered data
- Preserve maximum detail level
- Enable flexible aggregation options

**Derived Facts** Derived facts build upon atomic facts, creating specialized views for specific analytical needs while maintaining clear lineage to source data. These tables serve three main purposes:

1. **Performance Optimization** Large atomic fact tables can be filtered into focused subsets for specific business needs. For example, if a business analytics team regularly analyzes only 10% of a large event table, a derived fact can provide this subset, optimizing query performance and improving user experience.

1. **Metric Standardization** Derived facts precompute commonly used aggregations, particularly beneficial for complex metrics:

- Semi-additive measures like ratios that can't be summed across grains
- Balance-type metrics such as ARR or retention numbers
- Account balances that require specific aggregation rules

1. **Cross-Process Analysis** Through "Drill Across Facts," derived facts can combine multiple fact tables using conformed dimensions. This process:

- Links related business processes
- Maintains dimensional consistency
- Uses full outer joins on common dimensions
- Creates unified analytical views

Each derived fact maintains direct reference to its source atomic fact, ensuring clear lineage and auditability. This relationship should be clearly documented in the model's metadata, specifying whether it's an atomic or derived fact table.

#### Fact Measures

Facts typically contain three types of measures:

1. **Additive**: Can be summed across any dimension

- Revenue
- Quantity sold
- Count of events

1. **Semi-Additive**: Can be summed across some dimensions

- Account balances (sum across accounts, not time)
- Inventory levels (sum across products, not time)

1. **Non-Additive**: Cannot be summed, require other calculations

- Ratios
- Percentages
- Unit prices

### Special Purpose Tables

#### Bridge Tables

Bridge (`bdg_`) tables reside in the `common` schema and serve a crucial role in our dimensional model. These intermediate tables resolve many-to-many relationships between tables, maintaining data model flexibility while ensuring proper relationship management.

#### Scaffold Tables

Scaffold tables provide a foundational structure between fact tables, ensuring all potential dimensional combinations are represented in visualizations and analyses. They are particularly valuable when:

- Working with visualization tools like Tableau
- Analyzing sparse datasets
- Comparing actuals against targets
- Maintaining consistent time-based analysis

##### Implementation Details

- Reside in the `common_mart` schema
- Use the `rpt_scaffold_` prefix
- Build on top of fact tables
- Maintain complete dimensional combinations

#### Example Use Case

When analyzing sales against targets, a scaffold table ensures proper day-by-day and attribute-by-attribute structure. This means:

- Every day is represented, even without sales
- All dimension combinations are maintained
- Targets remain intact and visible
- Analysis remains consistent across time periods

## Common Mart Schema

The Common Mart schema combines dimensions and facts into business-ready analytics models, serving as the primary access point for business users and analytics tools.

### Purpose and Structure

The mart layer transforms our dimensional model into subject-area specific datasets that:

- Combine relevant facts and dimensions
- Pre-join commonly used attributes
- Apply standard business rules
- Optimize for specific use cases

### Organization By Business Domain

Mart models are typically organized by business function:

- Finance
- Marketing
- People
- Product
- Sales

### Key Characteristics

1. **Built on EDM Foundation**

- Uses fact and dimension tables as sources
- Maintains consistent business definitions
- Leverages standardized keys and relationships
- Never built on other mart models

1. **Optimized for Analysis**

- Pre-joined for common queries
- Includes frequently used calculations
- Maintains appropriate grain
- Considers performance implications

1. **Business-Oriented Design**

- Named for business concepts
- Documented in business terms
- Structured for self-service
- Supports common analysis patterns

### Best Practices

- Keep models focused on specific business domains
- Document assumptions and limitations
- Maintain consistent naming across related marts
- Regular testing of business logic
- Monitor usage patterns for optimization
- Maintain clear lineage to source models

## Specific Schema

The `SPECIFIC` schema is to be used for tables that perform a reporting function and act as a source of truth but do not conform to the dimensional modeling structure of the Enterprise Dimensional Model.

## No Transformaion Views

A **No Transformation View** should be direct views of raw source data that are needed for reporting without further transformation.  They should not be used to build additional tables since there will be a table upstream in the `RAW` or `PREP` database that will provide better lineage documentation for further transformations.  They should always be created as a view with no additional transformation or filtering and should be prefixed with `ntv_`.

## Entitlement

To facilitate the use of row level security in both Snowflake and Tableau a schema dedicated for entitlement tables, a mapping between the user or role and the records they are allowed to see, is used.  The tables in this schema follow a standard form but are not limited to an exact structure.  The purpose of these tables is to be joined to other tables in such a way that at query time the second table will be limited to the appropriate records for the runner of the query.

### Naming

The name of the entitlement table should direct users to the other table or tables that it should be used in combination with as well as the application it should be used with. Documentation for exactly what tables the entitlement table should be used for can be found in the data warehouse model [documentation](https://dbt.gitlabdata.com/#!/overview).  For example an entitlement table that would be used with the `mart_team_member_directory` table in Tableau would be named `ent_team_member_directory_tableau`.

### Form

Each entitlement table must have at least two columns: a join key that will connect to an other table and represents a subset of records and a column representing a Tableau user or Snowflake role.  The column that is used to join to an other table should be named the same as it is in that table to make it easier to user the correct table.  The values in the column that is used as a join key should represent the values of that column in the corresponding table.  The column or columns that represent the Tableau users or Snowflake roles should be named to match.

Every combination of user and join key must be explicitly included in as row in the table.

### Example

If row level security is to be implented on the `mart_team_member_directory` table diretly in Snowflake then the following table would be created:

`ent_team_member_directory_snowflake`

| cost_center   | snowflake_role |
|---------------|----------------|
| Cost of Sales | TMEMBER1       |
| G&A           | TMEMBER1       |
| R&D           | ANALYST_GROUP  |
| Marketing     | ANALYST_GROUP  |

Then a [row access policy](https://docs.snowflake.com/en/user-guide/security-row-intro) would be applied to the `mart_team_member_directory` table.

If row level security is to be implented on the `mart_team_member_directory` table in a Data Source in Tableau then the following table would be created:

`ent_team_member_directory_tableau`

| cost_center   | tableau_user            |
|---------------|-------------------------|
| Cost of Sales | team_member1@gitlab.com |
| Cost of Sales | team_member2@gitlab.com |
| Cost of Sales | team_member3@gitlab.com |
| G&A           | team_member1@gitlab.com |
| G&A           | team_member2@gitlab.com |
| Sales         | team_member1@gitlab.com |
| R&D           | team_member3@gitlab.com |
| Marketing     | team_member1@gitlab.com |

Then, using the guidelines outlined in [Tableau Developers Guide](/handbook/enterprise-data/platform/tableau/tableau-developer-guide/#row-level-security), a Data Source and filters would be created.

## Technical Implementation Details

### Naming Standards

It is critical to be intentional when organizing a self-service data environment, starting with naming conventions. The goal is to make navigating the data warehouse easy for beginner, intermediate, and advanced users. We make this possible by following these best practices:

1. PREP TABLES: `prep_<subject>` = Used to clean raw data and prepare it for dimensional analysis.
1. FACT TABLES: `fct_<verb>` Facts represent events or real-world processes that occur. Facts can often be identified because they represent the action or 'verb'.  (e.g. session, transaction)
1. DIMENSION TABLES: `dim_<noun>` = dimension table. Dimensions provide descriptive context to the fact records. Dimensions can often be identified because they are 'nouns' such as a person, place, or thing (e.g. customer, employee) The dimension attributes act as 'adjectives'. (e.g. customer type, employee division)
1. MART TABLES: `mart_<subject>` = Join dimension and fact tables together with minimal filters and aggregations. Because they have minimal filters and aggregations, mart tables can be used for a wide variety of reporting purposes.
1. REPORT TABLES: `rpt_<subject>` = Can be built on top of dim, fact, and mart tables. Very specific filters are applied that make report tables applicable to a narrow subset of reporting purposes.
1. PUMP TABLES: `pump_<subject>` = Can be built on top of dim, fact, mart, and report tables. Used for models that will be piped into a third party tool.
1. MAP TABLES: `map_<subjects>` = Used to maintain one-to-one relationships between data that come from different sources.
1. BRIDGE TABLES: `bdg_<subjects>` = Used to maintain many-to-many relationships between data that come from different sources. See the Kimball Group's [documentation](https://www.kimballgroup.com/2012/02/design-tip-142-building-bridges/) for tips on how to build bridge tables.
1. SCAFFOLD TABLES: `rpt_scaffold_<subject>` = Used to support the visualization layer by creating a template / blueprint with all the combinations of common dimensions between the desired fact tables.
1. Singular naming should be used, e.g. dim_customer, not dim_customers.
1. Use prefixes in table and column names to group like data. Data will remain logically grouped when sorted alphabetically, e.g. dim_geo_location, dim_geo_region, dim_geo_sub_region.
1. Use dimension table names in primary and foreign key naming. This makes it clear to the user what table will need to be joined to pull in additional attributes. For example, the primary key for dim_crm_account is dim_crm_account_id. If this field appears in fct_subscription, it will be named dim_crm_account_id to make it clear the user will need to join to dim_crm_account to get additional account details.
1. Dimension, fact, and mart tables are not to contain references to operational systems. We abstract the name away from the source system the data is produced into a name that describes the business entity or semantic significance of the data. For example, data from Salesforce is described as `crm` in the dimensional model and not `sfdc` or `salesforce`.

### File-Based Data Sources

When handling non-CSV data sources, we prefer direct extraction from source systems. However, temporary solutions using seed files, Sheetload, or Driveload may be acceptable with a clear deprecation plan. For CSV-type source data, we have three options:

1. **dbt seed**

- Version controlled via GitLab
- Easy updates via MR
- Best for < 1,000 rows
- Preferred for small datasets

1. **GCP Driveload**

- Stable and predictable
- No unexpected changes
- Requires manual file updates
- Preferred for larger datasets

1. **Sheetload**

- Enables team data entry
- Less stable implementation
- Difficult SOX compliance
- Last resort for Tier 1 assets

### Testing Framework

Models require testing and documentation via schema.yml files, following the [Trusted Data Framework (TDF)](/handbook/enterprise-data/platform/dbt-guide/#trusted-data-framework).

### Time Standards

We standardize on Monday as the first day of week across all systems:

```sql
CASE WHEN day_name = 'Mon' THEN date_day
    ELSE DATE_TRUNC('week', date_day)
END AS first_day_of_week
```

This ensures:

- Consistent weekly reporting
- Alignment with ISO 8601
- Accurate metric calculations
- Standard implementation across models

## Entity Relationship Diagram (ERD) Library

These diagrams provide the relationships between data objects in the Enterprise Dimensional Model across the major business process fly wheels.

### Lead to Cash ERDs

<details markdown=1>

<summary><b>ERD Library</b></summary>

- [Sales Funnel ERD](https://lucid.app/lucidchart/invitations/accept/inv_aaf2071b-0e70-446c-bc7f-1f8dcfdd650c)
- [Annual Recurring Revenue (ARR) ERD](https://lucid.app/lucidchart/invitations/accept/inv_8914efa4-00a6-4705-8ce3-d422d052cc22)
- [Common Subscription Model ERD](https://lucid.app/lucidchart/invitations/accept/inv_776b0a6b-70f9-44e2-bc60-cfbf56dcc7bb)
- [Common Behavior ERD](https://lucid.app/lucidchart/5d5c918d-2e6d-47d6-a2e5-db3c4951c531/edit?viewport_loc=-109%2C105%2C3982%2C1787%2CFb93ppTmuaDu&invitationId=inv_a4c5f29c-930f-4103-a121-320dd8009b5a)
- [Delta ARR: Subscription Lineage Monthly ERD](https://lucid.app/lucidchart/invitations/accept/inv_07d25d39-3076-408f-b768-67d1895ea064)
- [DRAFT: Quota ERD](https://lucid.app/lucidchart/invitations/accept/inv_2d4d5137-8aa6-488f-89a1-4295bf9ebde5)
- [DRAFT: Orders ERD](https://lucid.app/lucidchart/invitations/accept/inv_b726f4d1-7d92-4a21-832e-68f9db4fb104)

</details>

### Product Release to Adoption ERDs

<details markdown=1>

<summary><b>ERD Library</b></summary>

- [Common Product Usage Data Model ERD](https://lucid.app/lucidchart/3a42e56a-028e-45d7-b2ca-5ef489bafd32/edit?viewport_loc=2142%2C1704%2C4416%2C1626%2C8XAjn~AniBES&invitationId=inv_e0a19114-45d5-4a78-9123-dc3b8991d826)
- [Common Behavior ERD](https://lucid.app/lucidchart/5d5c918d-2e6d-47d6-a2e5-db3c4951c531/edit?viewport_loc=-109%2C105%2C3982%2C1787%2CFb93ppTmuaDu&invitationId=inv_a4c5f29c-930f-4103-a121-320dd8009b5a)

</details>

### Team Member ERDs

<details markdown=1>

<summary><b>ERD Library</b></summary>

- [Common Team Member Data Model ERD](https://lucid.app/lucidchart/17fbbbe5-f652-40e9-905e-1b07ec040520/edit?viewport_loc=153%2C6%2C1472%2C542%2CC6RZ78OfF1Bh&invitationId=inv_f6b923fd-02bb-4786-abd7-bf205c7d1da2)
- [DRAFT: Recruiting ERD](https://lucid.app/lucidchart/caa98a41-649a-4af0-9d2b-129360dbce96/edit?viewport_loc=-1384%2C-550%2C3649%2C1344%2C0_0&invitationId=inv_5af17fdd-3d57-4966-823a-bba083d80718)

</details>

### Create Entity Relationship (ER) Diagrams using Lucidchart

`Lucidchart` is a web-based diagramming application that allows users to visually collaborate on drawing, revising and sharing charts and diagrams, and improve processes, systems, and organizational structures.

An `Entity Relationship (ER) Diagram` is a type of flowchart that illustrates how `entities` or `objects` relate to each other within a system. `ER diagrams` are used to model and design relational databases, in terms of logic and business rules (in a logical data model) and in terms of the specific technology to be implemented (in a physical data model.)

The below steps illustrate how to create an `ER Diagram` (Logical & Physical Data Model) using `Lucidchart's ERD import functionality`. This process of creating a data model from a database or a script is also known as `Reverse engineering`.

<details markdown=1>
<summary><b>Step 1:</b> Create a blank lucid document from 'Lucidchart app' (should be available via Okta dashboard in case a user is assigned to it).</summary>

![create-lucid-chart.png](/images/enterprise-data/platform/edw/create-lucid-chart.png)
</details>

<details markdown=1>
<summary> <b>Step 2:</b> Click 'Import Data' that appears below the 'Shape Library' located at the bottom left hand side of the page. </summary>

![import-data.png](/images/enterprise-data/platform/edw/import-data.png)
</details>

<details markdown=1>
<summary><b>Step 3:</b> Select 'Entity Relationship (ERD)' from 'All Data Sources'. And choose 'Import from SQL Database' option from the dropdown list menu of 'Import your Data'.</summary>

![import-sql-database.png](/images/enterprise-data/platform/edw/import-sql-database.png)
</details>

<details markdown=1>
<summary> <b>Step 4:</b>  Select 'MySQL' as the DBMS source to import the data from, to create the ERD.</summary>

![sql-script.png](/images/enterprise-data/platform/edw/sql-script.png)
</details>

<details markdown=1>
<summary> <b>Step 5:</b>  Run the below script in Snowflake after updating/modifying the filter critera for selecting the 'table_schema' for selecting the tables for which the ERD needs to be created for.</summary>

```sql
The below query can be run in Prod database in Snowflake to get all the Models/tables from COMMON and COMMON_PREP Schemas:

SELECT 'mysql' dbms,
        t.TABLE_SCHEMA,
        t.TABLE_NAME,
        c.COLUMN_NAME,
        c.ORDINAL_POSITION,
        c.DATA_TYPE,
        c.CHARACTER_MAXIMUM_LENGTH,
        '' CONSTRAINT_TYPE,
        '' REFERENCED_TABLE_SCHEMA,
        '' REFERENCED_TABLE_NAME,
        '' REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLES t
LEFT JOIN INFORMATION_SCHEMA.COLUMNS c
ON t.TABLE_SCHEMA=c.TABLE_SCHEMA
AND t.TABLE_NAME=c.TABLE_NAME
WHERE t.TABLE_SCHEMA NOT IN('INFORMATION_SCHEMA')
AND t.TABLE_SCHEMA IN ('COMMON', 'COMMON_PREP')
```

</details>

<details markdown=1>
<summary><b>Step 6:</b> Download and export the results/output of the above query from Snowflake in to a csv file.</summary>

![export-results.png](/images/enterprise-data/platform/edw/export-results.png)
</details>

<details markdown=1>
<summary><b>Step 7:</b>  Navigate back to Lucidchart app and select the result.csv file to be uploaded and click 'Import'.</summary>

![import-tables.png](/images/enterprise-data/platform/edw/import-tables.png)
</details>

<details markdown=1>
<summary><b>Step 8:</b> All the tables/models from the selected 'table_schema' list will now appear under 'ERD Import'. The schemas can be expanded and scrolled through to view all the tables.</summary>

![schemas.png](/images/enterprise-data/platform/edw/schemas.png)

![tables.png](/images/enterprise-data/platform/edw/tables.png)
</details>

<details markdown=1>
<summary><b>Step 9:</b>  The required tables/entities of interest can be dragged on to the canvas and relationships between the entities can be defined from the ribbon to create the ER Diagram. <br>
Note: The number of fields to be shown for each of the entity can easily be modified from the 'Advanced Options' section thats appears towards the right hand side of the page.</summary>

![ERD.png](/images/enterprise-data/platform/edw/ERD.png)
</details> <br>

## Big Data

Big Data is a concept that we use to understand the limits of data offerings. Generically, Big Data is anything that exceeds or strains our current technical capacity for processing and delivery.  Dealing with Big Data may be less efficient and more costly as new or creative solutions need to be developed and deployed to expand the capabilities of the data offerings.

### Big Data and the Enterprise Data Warehouse

Big Data in the Enterprise Data Warehouse is categorized by three general topics:

1. Volume - how much data there is for a relevant source, concept, or model
1. Velocity - how quickly the data changes, is ingested, or consumed
1. Variety - how the structure and format of a data source compares to other sources

The Enterprise Data Warehouse is limited in each of these conceptual areas and any data that approaches these limits would be considered Big Data.

#### Volume

While there is not a real limit to the amount of data that can be stored in the Enterprise Data Warehouse there are limits to how much data can be transformed in a performant and cost effective way.  The current limits are being able to create a single table within a 3 hour timeframe using an XL snowflake warehouse.  As an example all of the collected snowplow data, over 6TB and 30 billion records, can not all be processed at once and would be considered Big Data.

#### Velocity

As the Enterprise Data Warehouse is designed to process and transform the data to present a curated set of tables, there are limits to how quickly those transformations can be processed in a cost effective way.  The Enterprise Data Warehouse is designed to process the data every 24 hours and data that needs to be processed more quickly than that to accommodate business needs would be considered Big Data.  As an example evaluating website behavior in near real time would be considered Big Data.

#### Variety

The current design of the Enterprise Data Warehouse is build on the Snowflake cloud database.  This limits the formats and structures of data that can be processed to those that fit into structured tables.  While some processing of semi-structured data, such as JSON, is possible directly in the Enterprise Data Warehouse this is limited and must be first ingested as a column in a table decreasing efficiency.  Generally, any data input or output from the Enterprise Data Warehouse that is not in a structured table would be considered Big Data.  As an example the service ping payload from the Version database is JSON that requires extensive manipulation before in can be analyzed and would be considered Big Data.

## Analytics Performance Policy Framework

### Problem Statement

Due to increasing data volumes and business logic complexity in the Enterprise Data Warehouse, the data model transformations built in the EDW have become increasingly non-performant overtime with the daily dbt model production run taking over 12 hours to complete. Query runtimes on some of our largest Snowplow, Service Ping, and GitLab.com data sets can take longer than several minutes to complete on L and XL size warehouses. Our daily Snowplow event data volumes are expected to increase by 2.5x within the next 12+ months. Therefore, we need an Analytics Performance Policy that can provide guidelines on how to architect performant data models in the transformation layer of the EDW that balance technical considerations with business needs and requirements.

We think about dbt model runs along 3 major dimensions: performance, efficiency, and cost.

1. **Performance** relates to how long it takes a model to build
1. **Efficiency** relates to how well a model uses local storage, remote storage, and partition pruning.
1. **Cost** relates to how many Snowflake credits are required to run a model and is impacted by both the performance and efficiency of the model.

The scope of this Analytics Performance Policy at this time is specifically focused on the performance of models. In the future, we will consider adding a separate efficiency and cost policy that would roll-up to an overall Analytics Scalability Policy.

*The Analytics Performance Policy is only considering the data transformations and does not consider retention of data that is extracted and loaded towards the RAW database of the EDW. For the time being, the policy assumes we will keep all data in the RAW database and we will not delete data. After a data retention policy is implemented in the future, we would reevaluate and iterate on this Analytics Performance Policy that focuses on the Transformation layer of the EDW. The alignment that is reached with the Functional Teams in this Analytics Performance Policy will be used to influence a data retention policy on the RAW database in Snowflake.*

### Performance Targets

*These initial performance targets were created to allow the daily dbt model production run to finish within an 8 hour working day and provide for the run to be triaged within a working day. The Snowflake query time targets were created to make incremental improvements from several minutes query times to 1 minute to provide for a more productive and delightful querying experience in Snowflake. These targets are subject to change in the future as we continue to improve performance and receive new business requirements.*

1. Reduce dbt model production run time from 12 hours to 8 hours. Assumes we do not scale up and keep using a XL size warehouse. Assumes we can scale out with using more concurrent threads running at the same time.
1. Individual dbt model run time is consistently between 30 minutes to 1 hour maximum per model, overtime as data volumes continue to increase.
1. A simple query of the Snowplow, Service Ping, and GitLab.com big data sets in Snowflake finishes in under 1 minute on a L or XL warehouse.

### Architectural Approaches to Improve Performance

1. Transform and Surface Smaller Amounts of Data in the Data Models.
    1. Limit the amount of rows and/or columns surfaced in the atomic fact tables (lowest grain that captures ALL transactions for a business process), based on business needs weighed against technical and performance constraints. Ex. Limit the data in a model to the last 13 months of data that is both performant and required for business analysis.
    1. Shard monolithic atomic fact tables (lowest grain that captures ALL transactions for a business process) that model the higher levels of abstraction of a business process into smaller data models that model sub-business processes. Ex. Model the SDLC (Software Development Lifecycle) into its component parts like SCM, CI, CD, Security etc. versus having the end to end SDLC modeled in one, montholic, super large data model.
    1. Create aggregated data models at a level of detail purpose built for Business Analytics use cases. Ex. Consider aggregating product usage data to the user, namespace, installation, metric grains by week, month, quarter, and year timeframes as required by the business use case.
1. Consider adding a clustering key to the data model that is aligned to commonly queried use cases in the model.
1. Evaluate the use of the simple_cte macro in the data model and insure only the required columns that are needed for the model are selected.
1. Consider setting the data model to be incremental.

### Historical Archiving Process

1. For non-idempotent data, which is data that cannot be recreated or otherwise surfaced in the data model due to a performance policy consideration, leverage a data platform archiving methodology to create an historical archive of the data.

For example, with only exposing 13 months of product usage data in atomic fact tables and creating an aggregated data table at the month, metric, namespace grain that only provides data for the past 13 months, an historical archive table would be able to provide insights from 2 or 3 years in the past for the aggregated table while the live data model would only provide the last 13 months of data.  
