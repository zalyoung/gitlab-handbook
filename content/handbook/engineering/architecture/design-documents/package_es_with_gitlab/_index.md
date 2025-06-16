---
title: Package Elasticsearch with GitLab
status: proposed
creation-date: "2025-04-18"
authors: [ "@terrichu" ]
coaches: [ "@DylanGriffith" ]
dris: [ "@bvenker", "@changzhengliu" ]
owning-stage: "~devops::ai-powered"
participating-stages: []
toc_hide: true
---

<!-- Design Documents often contain forward-looking statements -->
<!-- vale gitlab.FutureTense = NO -->

<!-- This renders the design document header on the detail page, so don't remove it-->
{{< engineering/design-document-header >}}

<!--
Don't add a h1 headline. It'll be added automatically from the title front matter attribute.

For long pages, consider creating a table of contents.
-->

## Summary

GitLab is proposing to package Elasticsearch with its distribution to solve multiple strategic challenges and unlock new capabilities. Currently, search and filtering functionality backed by PostgreSQL has significant limitations for larger instances and complex group hierarchies, which impacts feature delivery and user experience. While Elasticsearch is already used for Advanced search and adopted by a percentage of self-managed instances (with higher rates among larger customers), it remains optional infrastructure that requires separate installation and configuration.

By including Elasticsearch directly in GitLab packages, we aim to make it a standard component of the GitLab infrastructure. This change would improve database scalability by offloading text search operations, enable more powerful search and filtering capabilities, and provide a consistent platform for AI features that require vector storage for embeddings.

This initiative will benefit existing and new customers by removing adoption barriers, improving performance, and enabling a consistent experience across GitLab.com and self-managed deployments. Implementation will follow a phased approach, beginning with optional installation but designed to eventually make Elasticsearch standard infrastructure for GitLab features.

## Motivation

The motivation for this work is to establish Elasticsearch as the standard data store for search, filtering, and vector operations across GitLab. By improving the percentage of instances using Elasticsearch, we give feature teams the best opportunity to reach the most self-managed customers with performant, feature-rich experiences.

### Problem Statement

GitLab features increasingly require scalable data storage solutions that go beyond PostgreSQL's capabilities, particularly for search and filtering, AI, and data-intensive operations. Despite numerous evaluations of potential solutions, we've reached a fragmented state where:

1. Not all self-managed users run Elasticsearch with GitLab (adoption averages increase for medium and large size customers)
2. Feature teams must limit functionality for medium and large instances using PostgreSQL
3. Database scalability remains a persistent challenge for growing instances

The consequence is a divided user experience where feature availability depends on infrastructure choices, creating adoption barriers and limiting GitLab's ability to deliver consistent functionality across all deployment types.

### Industry Context

Industry competitors like GitHub provide more integrated search experiences out-of-the-box, creating a competitive gap. GitHub Enterprise Server includes Elasticsearch as an integrated component of their product, demonstrating that this approach is viable and has precedent in the industry. This integration allows GitHub to provide consistent search experiences across all deployment types, while GitLab currently requires separate installation and configuration of Elasticsearch. As vector embeddings become standard for AI-powered features, having a robust vector database is increasingly becoming table stakes in the developer platform market.

### Opportunities

1. **Improved User Experience**: More consistent feature availability across all deployment types
2. **Unified Feature Development**: Teams can build on a common foundation rather than maintaining compatibility with multiple data stores
3. **Reduced Database Load**: Offloading search and filtering operations from PostgreSQL
4. **Enhanced AI Capabilities**: Native support for vector embeddings enables next-generation AI features
5. **Competitive Parity**: Closing the gap with competitors who offer integrated search experiences
6. **Simplified Infrastructure**: Standardized components reduce operational and maintenance complexity

### Goals

- Increase adoption of Elasticsearch on self managed instances

### Non-Goals

- Convert instances using OpenSearch to switch to Elasticsearch
- Remove support for external Elasticsearch or OpenSearch configurations
- Replace other vector database solutions for specialized use cases
- Address all scaling challenges in PostgreSQL

## Proposal

We propose to package Elasticsearch with GitLab distribution through the following key initiatives:

1. **Elasticsearch sizing and configuration**:
   - [Update reference architecture and documentation](https://gitlab.com/groups/gitlab-org/-/epics/18151) to include Elasticsearch minimum and recommended system specifications. This includes:
     - Configuration and performance optimizations
     - Resiliency and high availability
     - Support for upgrades
   - Include Elasticsearch as an optional component in all GitLab installation methods

2. **Improved configuration automation**:
   - [Automate Elasticsearch index configuration](https://gitlab.com/gitlab-org/gitlab/-/issues/549311) for GitLab with sensible defaults
   - [Automate maintenance tasks](https://gitlab.com/groups/gitlab-org/-/epics/15888) for indexes
   - Expand existing health checks and self-healing capabilities to include connectivity checks

## Design and Implementation Details

### Technical Approach

For the initial implementation, we propose to include Elasticsearch core version (AGPL-licensed) with GitLab's distribution packages, with the following considerations:

1. **Packaging Method Considerations**:
   - For Omnibus: Bundle Elasticsearch as a configurable component
   - For Kubernetes: Build custom Helm charts
   - For Docker: Include Elasticsearch in the standard docker-compose setup
   - For GET: Include Elasticsearch as a configurable component

2. **Version Selection**:
   - Include Elasticsearch version 8.12+ to support hybrid search capabilities
   - The latest versions have non-trivial cost savings and performance improvements for embeddings storage
   - **Implementation Note**: Elasticsearch Docker Hub images bundle both core and enterprise code, with the latter activated by default for a 30-day trial. As part of this work, we'll need to modify CI configurations to explicitly use only the core functionality.

3. **Configuration and Resource Allocation**:
   - Default to a minimal configuration suitable for small instances
   - Provide configuration templates for different instance sizes
   - In single server implementations, Elasticsearch and JVM require careful resource allocation to prevent Elasticsearch from impacting GitLab performance

### Package Size and Performance Considerations

- **Package Size Impact**: Including Elasticsearch will significantly increase the omnibus package size due to:
  - Elasticsearch core files (approximately 200-300MB)
  - Required Java Virtual Machine (JVM) runtime (approximately 150-200MB)
  - Configuration files and dependencies

- **Build Process Implications**:
  - The omnibus-gitlab build system typically builds components from source
  - For Elasticsearch, we should evaluate using pre-built binaries vs. building from source
  - Using pre-built binaries would minimize build time impact but may limit customization
  - Building from source would increase build times but provide more flexibility

### Evaluations and Evidence

Multiple teams across GitLab have invested significant resources evaluating potential solutions, but none has achieved majority adoption:

- [Package a search engine with GitLab](https://gitlab.com/gitlab-org/gitlab/-/issues/438178) - Original initiative to include Elasticsearch
- [Iteration plan for RAG](https://gitlab.com/gitlab-org/gitlab/-/issues/441110) - Comprehensive evaluation of data store options for Retrieval Augmented Generation
- [Documentation questions for Chat](https://gitlab.com/gitlab-org/gitlab/-/issues/451215) - Implementation using Vertex AI Search as a workaround
- [Spike on privacy-oriented embeddings](https://gitlab.com/gitlab-org/gitlab/-/issues/458770) - Investigation of embedding storage options for sensitive data
- [PgVector evaluation](https://gitlab.com/gitlab-org/gitlab/-/issues/438330#note_1780393655) - Assessment of PostgreSQL with PgVector extension

These explorations consistently highlight Elasticsearch as a preferred solution due to its:

- Hybrid search capabilities (combining keyword and vector search)
- Mature feature set for relevance ranking and filtering
- Existing integration with GitLab's Advanced search
- Scalable architecture for large deployments
- Ability to handle embeddings for AI use cases

## References

- https://www.elastic.co/docs/deploy-manage/production-guidance/elasticsearch-in-production-environments
- https://www.elastic.co/docs/deploy-manage/deploy/self-managed
- https://www.elastic.co/docs/deploy-manage/deploy/cloud-on-k8s
- [Issue #438178: Package a search engine with GitLab](https://gitlab.com/gitlab-org/gitlab/-/issues/438178)
- [Issue #438330: Estimate timeline to deliver "Users can ask documentation questions on SM Chat"](https://gitlab.com/gitlab-org/gitlab/-/issues/438330)
- [Issue #441110: Iteration plan: RAG](https://gitlab.com/gitlab-org/gitlab/-/issues/441110)
- [Issue #451215: Solution implementation for "users can ask documentation questions on SM Chat"](https://gitlab.com/gitlab-org/gitlab/-/issues/451215)
- [Issue #458770: Spike: Investigate and Validate Path for Privacy-Oriented Embedding Models](https://gitlab.com/gitlab-org/gitlab/-/issues/458770)
- [Issue #514017: Include Elasticsearch into GitLab delivery packages](https://gitlab.com/gitlab-org/gitlab/-/issues/514017)
- [Merge Request #142787: RAG architecture blueprint](https://gitlab.com/gitlab-org/gitlab/-/merge_requests/142787)
- [Issue #1048: Elasticsearch integration](https://gitlab.com/gitlab-org/omnibus-gitlab/-/issues/1048)
- [Issue #3857: Ship elasticsearch with omnibus packages by default](https://gitlab.com/gitlab-org/omnibus-gitlab/-/issues/3857)
- [Epic #14293: Use Advanced Search for Filtered Searches of Issues and Merge Requests](https://gitlab.com/groups/gitlab-org/-/epics/14293)
- [Epic #13510: Vulnerability Management utilizing ElasticSearch](https://gitlab.com/groups/gitlab-org/-/epics/13510)
