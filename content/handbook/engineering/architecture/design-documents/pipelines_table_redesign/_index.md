---
title: Pipelines Table Redesign and GraphQL Migration
status: proposed
creation-date: "2025-04-04"
authors: ["@bsandlin", "@pburdette"]
coaches: ["@jivanvl"]
dris: ["@bsandlin", "@pburdette", "@jivanvl"]
owning-stage: "~devops::verify"
participating-stages:
    ["~group::pipeline execution", "~group::pipeline authoring"]
toc_hide: true
---

{{< design-document-header >}}

## Summary

The Pipelines Table is a critical component of GitLab's CI/CD experience, appearing in three key locations throughout the application:

1. The main Pipelines page
2. The Commit Pipelines tab
3. The Merge Request Pipelines tab

The current implementation uses REST API and displays all information at once, including pipeline mini graphs for each pipeline. This has led to significant performance issues and a suboptimal user experience.

As the migration from REST to GraphQL for the Pipelines Table is already planned, this design document proposes combining this migration with a comprehensive UI redesign. The redesign will separate essential pipeline information from detailed data (like mini graphs and job information) using a progressive disclosure pattern, while the GraphQL implementation will enable more efficient data fetching and establish the foundation for future real-time updates.

By tackling both efforts simultaneously, we can significantly reduce development costs by avoiding temporary solutions and rework. This approach will improve initial load performance by reducing payload size and rendering complexity, enhance the user experience through better information hierarchy, and establish the technical architecture needed for eventual real-time pipeline status updates—all while maintaining feature parity for critical pipeline information.

![pipelines_table](/images/engineering/architecture/design-documents/pipelines_table_redesign/pipelines_table.png)

## Motivation

### GraphQL Migration

The primary motivation for migrating the Pipelines Table from REST to GraphQL is to enable real-time updates for pipeline status information:

- **Enable Real-time Updates**: GraphQL subscriptions will allow us to deliver instantaneous pipeline status changes to users without inefficient polling mechanisms.
- **Reduce Server Load**: The current polling approach requires frequent, full-payload requests that unnecessarily consume server resources, particularly in environments with active CI/CD usage.
- **Eliminate N+1 Query Issues**: The current REST implementation suffers from N+1 query patterns when retrieving pipeline data, creating database performance bottlenecks. GraphQL's ability to batch and optimize queries will significantly reduce these database inefficiencies.
- **Improve Filtering Performance**: The GraphQL implementation will enable more efficient pipeline filtering by moving filter operations closer to the data source, reducing unnecessary data transfer and processing.
- **Optimize Network Traffic**: GraphQL allows precise specification of required data, significantly reducing payload sizes compared to REST endpoints that return fixed data structures.
- **Technical Alignment**: Most new GitLab features are being built with GraphQL, making this migration strategically aligned with the platform's technical direction and architecture.
- **Future Scalability**: As GitLab continues expanding its CI/CD capabilities, GraphQL provides a more flexible and scalable query language for accessing increasingly complex pipeline data structures.

### UI Redesign

The primary motivation for redesigning the Pipelines Table UI is to address critical performance issues caused by including the pipeline mini graph in the parent API request.

- **Excessive Initial Payload**: The current implementation includes detailed stage and job data for the mini graph in the initial request, significantly increasing payload size and processing time for each pipeline.
- **Information Architecture Improvement**: The current approach presents too much information at once (Hick's Law), making it difficult for users to quickly identify pipeline status. A redesign allows us to prioritize the most important information.
- **Unnecessary Data Loading**: Most users only need to view detailed mini graph information for a small subset of pipelines, yet we currently load this data for all visible pipelines.
- **Progressive Disclosure Opportunity**: By moving the mini graph and other detailed information to an expandable view loaded with a secondary request, we can drastically improve initial load performance while still providing access to all pipeline details.
- **Enhanced Pipeline Details**: Moving detailed information to a secondary request enables us to build a more robust Pipeline Details component that can include richer visualizations, comprehensive failed jobs information, and more detailed metrics without impacting initial page performance.
- **Addressing Accumulated UX Issues**: This redesign provides an opportunity to address several long-standing UX issues in a coordinated effort rather than piecemeal fixes. Current tracked UX issues include:

    **High Complexity Issues (Weight 3)**:

  - [Improve Pipeline table layout and design](https://gitlab.com/gitlab-org/gitlab/-/issues/321517)
  - [Make pipeline mini-graph representation more user-friendly](https://gitlab.com/gitlab-org/gitlab/-/issues/327900)

    **Medium Complexity Issues (Weight 2)**:

  - [Add created-at time for running pipelines](https://gitlab.com/gitlab-org/gitlab/-/issues/432373)
  - [Reevaluate the tabs headings on pipeline index page](https://gitlab.com/gitlab-org/gitlab/-/issues/329513)
  - [Make "Triggered by me" pipelines more accessible](https://gitlab.com/gitlab-org/gitlab/-/issues/300256)
  - [Provide project-level configuration options for pipeline displays](https://gitlab.com/gitlab-org/gitlab/-/issues/339651)

    **Lower Complexity Issues (Weight 1)**:

  - [Add missing tooltips on pipeline and job list view](https://gitlab.com/gitlab-org/gitlab/-/issues/435814)
  - [Add skeleton loader to the pipeline tab on merge requests](https://gitlab.com/gitlab-org/gitlab/-/issues/354074)
  - [Align buttons on the pipeline index page with design system](https://gitlab.com/gitlab-org/gitlab/-/issues/365616)

Combining these two initiatives creates an opportunity to significantly improve both the performance and usability of the pipeline experience while establishing the foundation for real-time updates.

## Goals

The primary goals of this initiative are:

### Performance Improvement

- Reduce initial page load time for the Pipelines Table by at least 50%
- Decrease the size of the initial data payload by at least 60%
- Improve client-side rendering performance by reducing initial DOM element count
- Eliminate polling in favor of efficiently designed GraphQL queries and future subscription capability

### User Experience Enhancement

- Improve information hierarchy by separating essential pipeline information from detailed data
- Create a more intuitive interface that allows users to quickly scan pipeline statuses
- Maintain feature parity for all critical pipeline information
- Achieve at least 80% user satisfaction in usability testing

### Technical Architecture

- Complete migration from REST to GraphQL for all pipeline table functionality
- Design and implement a component architecture that supports future real-time updates
- Create a separation between list-level data and detailed pipeline information

### Development Efficiency

- Implement both the UI redesign and GraphQL migration in a single coordinated effort
- Avoid creating temporary solutions or technical debt
- Develop behind a feature flag to enable controlled testing and rollout

## Non-Goals

- Implementation of real-time updates (though laying groundwork is in scope)
- Redesign of the pipeline mini graph
- Changes to the underlying CI/CD execution engine
- Migration of other CI/CD features to GraphQL (job logs, runner management, etc.)
- Changes to pipeline creation or configuration workflows

## Proposal

The proposed solution involves a complete redesign of the Pipelines Table coupled with a migration from REST to GraphQL. The new design will adopt a progressive disclosure pattern, showing only essential information at the list level while providing users with the ability to expand individual pipeline entries to access detailed information.

This approach will utilize two separate GraphQL queries:

1. A lightweight initial query that loads only essential pipeline data for the list view
2. A second, more detailed query that is only triggered when a user expands a specific pipeline

By combining these two initiatives into a single coordinated effort, we can achieve significant performance improvements while enhancing usability and setting the stage for future real-time updates, all while minimizing development costs.

### Information Architecture

The new design will separate pipeline information into two levels:

1. **List View (Essential Information)**

   - Pipeline status and finished timestamp
   - Pipeline ID and name
   - Branch, commit, and MR information
   - Author information
   - Quick actions

2. **Expanded View (Detailed Information)**

   _Appears when user expands a pipeline row_
   - Possibly pipeline mini graph visualization (see [Pipeline Mini Graph Placement](#pipeline-mini-graph-placement) decision)
   - Failed jobs information
   - Job actions
   - Duration metrics
   - Available artifacts
   - Detailed commit information
   - Configuration details

## Design and Implementation Details

### Implementation Approach

The implementation will be phased as follows:

**Phase 1: Product Design and GraphQL Schema**

- Conduct product design sessions to finalize UI/UX requirements
- Create designs for both list view and expanded details
- Define information hierarchy and user interactions
- Introduce feature flag
- Update the GraphQL schema if necessary based on the design requirements
- Build and test the two query patterns

**Phase 2: Frontend Implementation and Testing**

- Build list view components
- Build expandable details component
- Conduct performance testing
- Conduct user testing

**Phase 3: Rollout and Monitoring**

- Gradually enable feature flag
- Monitor performance metrics
- Gather user feedback
- Complete rollout

### GraphQL Queries

[GraphQL schema details will be added here once designs are complete]

### UI Component Architecture

[This structure will evolve once designs are complete]

```shell
ci/pipelines_table/
├── components/
│ ├── PipelinesListView.vue # Container component
│ ├── PipelineListItem.vue # Individual pipeline row component
│ └── PipelineDetails.vue # Expandable details component
├── graphql/
│ ├── fragments/
│ │ └── pipeline_list_fields.fragment.graphql
│ ├── queries/
│ │ ├── project_pipelines.query.graphql
│ │ ├── merge_request_pipelines.query.graphql
│ │ ├── commit_pipelines.query.graphql
│ │ └── pipeline_details.query.graphql
│ └── subscriptions/ # For future real-time updates
│ ├──── pipeline_statuses.subscription.graphql
│ └──── pipeline_details.subscription.graphql
├── constants.js
└── utils.js
```

### Key Design Decisions

#### List View Format

**Decision DRI**: Product Design

**Options to consider**:

- Streamlined row-based list view with expandable details
- Card-based view
- Traditional table with all columns
- List items with variable information density

#### Expansion Mechanism

**Decision DRI**: Product Design

**Options to consider**:

- Expandable row revealing details panel beneath the row
- Side drawer showing related pipeline details
- Modal dialog for detailed information
- Inline expansion with progressive disclosure

#### Pipeline Mini Graph Placement

**Decision DRI**: Product Design, Engineering

**Decision**: [DECISION PENDING] Whether to include the pipeline mini graph in the details view or focus on failed jobs and actionable items instead.

**Context**: The mini graph requires fetching extensive job data (including dozens of passed jobs with names and statuses) that is often unnecessary for the user's workflow.

**Options**:

1. **Include Mini Graph in Details View**
   - Provides visual representation of pipeline stages
   - Maintains familiar visualization element
   - Requires fetching data for all jobs, including non-actionable ones

2. **Focus on Failed Jobs and Actionable Items**
   - Prioritizes information users need to take action
   - Reduces data requirements by focusing on relevant jobs
   - Shows stage summary without individual passed job details
   - Potentially more useful for troubleshooting workflows

**Next Steps**:

- Research user workflows to identify most frequently needed information
- Analyze query patterns to measure reduction in data requirements
- Test alternative presentations focusing on actionable information

**Initial Recommendation**: Focus primarily on failed jobs and actionable items in the details view, with a simplified stage summary that doesn't require fetching data for every passed job.

#### GraphQL Query Structure

**Decision DRI**: Engineering
**Decision**: Implement two separate GraphQL queries and prepare for future subscription model
**Context**: GraphQL allows for precise data fetching and real-time updates through subscriptions.

**Benefits**:

- Optimized initial payload
- On-demand loading of detailed information
- Foundation for real-time updates
- Better separation of concerns in frontend code

**Alternatives Considered**:

- Single comprehensive query with all data - Rejected due to performance concerns
- Multiple fragmented queries - Rejected due to increased request overhead

#### Pipeline Details Schema

**Decision DRI**: Engineering

**Decision**: [PENDING UI DESIGNS] Determine the optimal GraphQL schema for pipeline details based on finalized UI designs.

**Context**: The schema for the secondary query will be driven by UI requirements to ensure we only fetch data needed for the expanded details view.

**Process**:

- Complete UI designs for the expanded pipeline details view
- Identify all data elements required by the design
- Develop schema that efficiently retrieves only necessary information
- Validate schema against performance goals

**Considerations**:

- Balance between comprehensive information and query efficiency
- Prioritize data for troubleshooting and actionable items
- Structure for future extensibility and real-time updates
- Support for all three pipeline table contexts

**Next Steps**:

- Finalize expanded details UI mockups
- Map UI elements to required data fields
- Draft initial GraphQL schema
- Review with stakeholders

**Implementation Target**: A focused schema that retrieves exactly what the UI needs without unnecessary data fetching.

## Alternative Solutions

### GraphQL Migration Without UI Redesign

**Approach**: Migrating to GraphQL while maintaining the current UI design.

**Pros**:

- Provides some performance benefits
- Allows incremental improvements
- Lower risk of user experience disruption

**Cons**:

- Requires building GraphQL queries that match current REST payloads
- Creates technical debt when UI is eventually redesigned
- Doesn't address information hierarchy or cognitive load issues
- Misses opportunity for combined implementation efficiency

## Metrics

To establish baseline performance measurements and set clear targets for improvement, we've gathered the following metrics across the locations where the Pipelines Table appears:

### Current Performance Baselines

| Location                    | Metric                                                            | Current Value | Target |
| --------------------------- | ----------------------------------------------------------------- | ------------- | ------ |
| Main Pipelines Page         | Average network response time (no filtering)                      | 1.35 seconds  | TBD    |
| Main Pipelines Page         | Average network response time (with trigger author/status filter) | 2.38 seconds  | TBD    |
| Merge Request Pipelines Tab | Average network response time                                     | 1.64 ms       | TBD    |

We'll measure the success of this initiative by comparing pre and post-implementation metrics across these dimensions, with specific improvement targets as outlined in the Goals section.
