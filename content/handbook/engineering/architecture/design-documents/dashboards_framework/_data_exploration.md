---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Design doc title
status: ongoin
creation-date: "2025-04-24"
authors: [ "@drosse", "@jiaan", "@rob.hunt" ]
coaches: [ "@username" ]
dris: [ "@lfarina8", "@nicholasklick" ]
owning-stage: "~devops::monitor"
participating-stages: []
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

<!--
Before you start:

- Copy this file to a sub-directory and call it `_index.md` for it to appear in
  the design documents list.
- Remove comment blocks for sections you've filled in.
  When your document ready for review, all of these comment blocks should be
  removed.

To get started with a document you can use this template to inform you about
what you may want to document in it at the beginning. This content will change
/ evolve as you move forward with the proposal.  You are not constrained by the
content in this template. If you have a good idea about what should be in your
document, you can ignore the template, but if you don't know yet what should
be in it, this template might be handy.

- **Fill out this file as best you can.** At minimum, you should fill in the
  "Summary", and "Motivation" sections.  These can be brief and may be a copy
  of issue or epic descriptions if the initiative is already on Product's
  roadmap.
- **Create a MR for this document.** Assign it to an Architecture Evolution
  Coach (i.e. a Principal+ engineer).
- **Merge early and iterate.** Avoid getting hung up on specific details and
  instead aim to get the goals of the document clarified and merged quickly.
  The best way to do this is to just start with the high-level sections and fill
  out details incrementally in subsequent MRs.

Just because a document is merged does not mean it is complete or approved.
Any document is a working document and subject to change at any time.

When editing documents, aim for tightly-scoped, single-topic MRs to keep
discussions focused. If you disagree with what is already in a document, open a
new MR with suggested changes.

If there are new details that belong in the document, edit the document. Once
a feature has become "implemented", major changes should get new blueprints.

The canonical place for the latest set of instructions (and the likely source
of this file) is
[content/handbook/engineering/architecture/design-documents/_template.md](https://gitlab.com/gitlab-com/content-sites/handbook/-/blob/main/content/handbook/engineering/architecture/design-documents/_template.md).

Document statuses you can use:

- "proposed"
- "accepted"
- "ongoing"
- "implemented"
- "postponed"
- "rejected"

-->

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< design-document-header >}}

<!--
Don't add a h1 headline. It'll be added automatically from the title front matter attribute.

For long pages, consider creating a table of contents.
-->

## Summary

<!--
This section is very important, because very often it is the only section that
will be read by team members. We sometimes call it an "Executive summary",
because executives usually don't have time to read entire documents like this.
Focus on writing this section in a way that anyone can understand what it says,
the audience here is everyone: executives, product managers, engineers, wider
community members.

A good summary is probably at least a paragraph in length.
-->


This design document outlines the architecture for a unified Dashboard Data Exploration and Querying system at GitLab. The system aims to provide users with the ability to explore and understand their GitLab data across multiple data sources through a consistent and intuitive interface.

Currently, GitLab's diverse data sources (PostgreSQL, ClickHouse, GraphQL, REST APIs) each require different query strategies and have varying schemas, relationships, and performance characteristics. This creates significant friction for users trying to access and gain insights from their data. 

The proposed architecture addresses this by creating a standardized data abstraction layer that handles the complexity of interacting with multiple data sources while providing a uniform querying experience.

The core of this proposal is to develop a single API to query any GitLab data with a consistent query language (building on GitLab Query Language - GLQL), supported by a context-aware filtering component and visualization capabilities. This will enable users to discover meaningful insights about their GitLab usage and business performance without needing to understand the underlying data architecture.

## Motivation

<!--
This section is for explicitly listing the motivation, goals and non-goals of
this document. Describe why the change is important, all the opportunities,
and the benefits to users.

The motivation section can optionally provide links to issues that demonstrate
interest in a document within the wider GitLab community. Links to
documentation for competing products and services is also encouraged in cases
where they demonstrate clear gaps in the functionality GitLab provides.

For concrete proposals we recommend laying out goals and non-goals explicitly,
but this section may be framed in terms of problem statements, challenges, or
opportunities. The latter may be a more suitable framework in cases where the
problem is not well-defined or design details not yet established.
-->

The ability for users to explore their GitLab data and derive meaningful business insights is increasingly important as organizations rely on data-driven decision making. However, several challenges currently prevent users from effectively exploring and understanding their GitLab data

### Challenges

#### Data Source Fragmentation

GitLab data resides across multiple data sources, each with different access patterns:

- **PostgreSQL databases** store transactional application data
- **ClickHouse databases** contain analytical and time-series data
- **GraphQL endpoints** provide structured API access to application data
- **REST APIs** offer additional interfaces to various data sets

Each of these sources has evolved independently, resulting in different query requirements, data models, and performance characteristics. This fragmentation forces users to understand each system separately to explore their data effectively.

#### Query Language Inconsistency

Users currently need to employ different query approaches depending on the data source:

- SQL dialects differ between PostgreSQL and ClickHouse
- GraphQL has its own query structure
- REST APIs use various parameter-based filtering mechanisms
- Filters and operators vary across endpoints even within the same API type

This inconsistency creates a steep learning curve for users who need to access data across multiple sources and requires specialized knowledge of each system's querying capabilities.

#### Schema and Data Model Disparities

Beyond the query language differences, there are fundamental inconsistencies in how data is structured:

- Field naming conventions vary across systems
- Entity relationships are modeled differently
- Data granularity differs (e.g., detailed records vs. aggregated data)
- Time-based data uses inconsistent formats and time zone handling

These disparities make it difficult to establish meaningful connections between related data points that exist in different systems, limiting users' ability to gain a complete picture of their information.

#### User Experience Friction

The current state creates significant friction in the data exploration process:

- Users must often switch between multiple tools or interfaces to access different data sources
- Creating dashboards that combine data from multiple sources requires complex integration work
- Non-technical users face significant barriers to exploring data on their own
- Visualization options are inconsistent across data sources

This friction discourages data exploration and limits the insights users can derive from their GitLab data.

#### Performance and Resource Challenges

Different data sources have varying performance characteristics:

- Some queries may be resource-intensive and could impact system performance
- Query optimization strategies differ across data sources
- Performance can vary dramatically for similar queries against different data sources
- Resource limits and timeout thresholds are inconsistent

These challenges make it difficult to provide a consistently responsive exploration experience across all data types.

### Opportunities for Unified Data Exploration

Despite these challenges, there is a significant opportunity to simplify and enhance how users interact with their GitLab data:

- A unified data exploration interface could dramatically reduce the learning curve
- Standardizing query patterns could unlock new cross-source analytics capabilities
- Consistent visualization options would help users interpret data more effectively
- A metadata-driven approach could make new data sources discoverable as they become available
- Integration with GitLab Duo could further enhance data exploration through AI assistance

A well-designed data exploration architecture would not only address the current pain points but also establish a foundation for more advanced analytics capabilities in the future.

### Goals

<!--
List the specific goals / opportunities of the document.

- What is it trying to achieve?
- How will we know that this has succeeded?
- What are other less tangible opportunities here?
-->

- **Create a unified data exploration experience** across GitLab's diverse data sources
- **Simplify the process of querying data** for both technical and non-technical users
- **Standardize the filtering interface** to work consistently regardless of underlying data source
- **Enable metadata-driven discovery** of available data sources and their schemas
- **Support common visualization needs** by leveraging existing dashboard framework components
- **Ensure appropriate performance** for data exploration queries across different data sources
- **Maintain proper security controls** and respect user permissions across all data sources
- **Facilitate integration with GitLab Duo** to enhance data exploration capabilities
- **Establish a foundation** for cross-source analytics that can evolve over time

### Non-Goals

<!--
Listing non-goals helps to focus discussion and make progress. This section is
optional.

- What is out of scope for this document?
-->

- **Building a comprehensive business intelligence platform** - We are focused on exploration, not replacing dedicated BI tools
- **Dashboard layout framework implementation** - We will rely on the existing framework
- **Dashboard listing features** - Management of dashboard listings is outside the scope
- **Dashboard file management** - Managing underlying dashboard files is not covered
- **Dashboard onboarding experiences** - Initial onboarding flows are not part of this proposal
- **Dashboard cloning functionality** - Features to clone dashboards are not included
- **Single data source implementations** - The focus is on architecture across data sources, not implementing individual source adapters
- **Creating new visualization components** - We will use existing visualization components rather than creating new ones
- **Implementing a data warehouse** - We're not aiming to consolidate all data into a single data store



## Proposal

<!--
This is where we get down to the specifics of what the proposal actually is,
but keep it simple!  This should have enough detail that reviewers can
understand exactly what you're proposing, but should not include things like
API designs or implementation. The "Design Details" section below is for the
real nitty-gritty.

You might want to consider including the pros and cons of the proposed solution so that they can be
compared with the pros and cons of alternatives.
-->

## Design and implementation details

<!--
This section should contain enough information that the specifics of your
change are understandable. This may include API specs (though not always
required) or even code snippets. If there's any ambiguity about HOW your
proposal will be implemented, this is the place to discuss them.

If you are not sure how many implementation details you should include in the
document, the rule of thumb here is to provide enough context for people to
understand the proposal. As you move forward with the implementation, you may
need to add more implementation details to the document, as those may become
valuable context for important technical decisions made along the way. A
document is also a register of such technical decisions. If a technical
decision requires additional context before it can be made, you probably should
document this context in a document. If it is a small technical decision that
can be made in a merge request by an author and a maintainer, you probably do
not need to document it here. The impact a technical decision will have is
another helpful information - if a technical decision is very impactful,
documenting it, along with associated implementation details, is advisable.

If it's helpful to include workflow diagrams or any other related images.
Diagrams authored in GitLab flavored markdown are preferred. In cases where
that is not feasible, images should be placed under `images/` in the same
directory as the `index.md` for the proposal.
-->

## Alternative Solutions

<!--
It might be a good idea to include a list of alternative solutions or paths considered, although it is not required. Include pros and cons for
each alternative solution/path.

"Do nothing" and its pros and cons could be included in the list too.
-->