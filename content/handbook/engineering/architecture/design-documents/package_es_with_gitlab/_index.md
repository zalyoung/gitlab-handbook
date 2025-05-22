---
title: Package Elasticsearch with GitLab
status: proposed
creation-date: "2025-04-18"
authors: [ "@terrichu" ]
coaches: [ "@username" ]
dris: [ "@bvenker", "@changzhengliu" ]
owning-stage: "~devops::foundations"
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

### Problem Statement

GitLab features increasingly require scalable data storage solutions that go beyond PostgreSQL's capabilities, particularly for search and filtering, AI, and data-intensive operations. Despite numerous evaluations of potential solutions, we've reached a fragmented state where:

1. Not all self-managed users run Elasticsearch with GitLab (adoption averages increase for medium and large size customers)
2. Feature teams must limit functionality for medium and large instances using PostgreSQL
3. Database scalability remains a persistent challenge for growing instances

The consequence is a divided user experience where feature availability depends on infrastructure choices, creating adoption barriers and limiting GitLab's ability to deliver consistent functionality across all deployment types.

### Industry Context

Industry competitors like GitHub provide more integrated search experiences out-of-the-box, creating a competitive gap. GitHub Enterprise Server includes Elasticsearch as an integrated component of their product, demonstrating that this approach is viable and has precedent in the industry. This integration allows GitHub to provide consistent search experiences across all deployment types, while GitLab currently requires separate installation and configuration of Elasticsearch. As vector embeddings become standard for AI-powered features, having a robust vector database is increasingly becoming table stakes in the developer platform market.

### Opportunities

1. **Unified Feature Development**: Teams can build on a common foundation rather than maintaining compatibility with multiple data stores
2. **Improved User Experience**: More consistent feature availability across all deployment types
3. **Reduced Database Load**: Offloading search and filtering operations from PostgreSQL
4. **Enhanced AI Capabilities**: Native support for vector embeddings enables next-generation AI features
5. **Competitive Parity**: Closing the gap with competitors who offer integrated search experiences
6. **Simplified Infrastructure**: Standardized components reduce maintenance complexity

### Benefits to Users

- **Self-Managed Customers**: Simplified setup with integrated Elasticsearch
- **GitLab Administrators**: Reduced operational complexity with packaged solution
- **End Users**: Access to more powerful search and AI features
- **Development Teams**: Increased productivity with better search capabilities
- **Feature Teams**: Broader audience for features powered by Advanced search

The motivation for this work is to establish Elasticsearch as the standard data store for search, filtering, and vector operations across GitLab. By improving the percentage of instances using Elasticsearch, we give feature teams the best opportunity to reach the most self-managed customers with performant, feature-rich experiences.

### Goals

- Increase adoption of Elasticsearch on self managed instances
- Improve search experience for users across all GitLab

### Non-Goals

- Convert instances using OpenSearch to switch to Elasticsearch
- Force Elasticsearch on instances that don't need it
- Remove support for existing external Elasticsearch configurations
- Replace other vector database solutions for specialized use cases
- Address all scaling challenges in PostgreSQL

## Proposal

We propose to package Elasticsearch with GitLab distribution through the following key initiatives:

1. **Sizing and configuration for all instance sizes**:
   - Configuration for GitLab, including but not limited to number of nodes and [shard sizing](https://www.elastic.co/docs/deploy-manage/production-guidance/optimize-performance/size-shards)
   - Performance optimizations for Elasticsearch
   - [Resiliancy and high availability](https://www.elastic.co/docs/deploy-manage/production-guidance/availability-and-resilience)
   - Upgrades

2. **Improved configuration automation**:
   - Streamline Elasticsearch index configuration for GitLab with sensible defaults
   - Automate common setup tasks to reduce administrator burden
   - Expand existing health checks and self-healing capabilities to include connectivity checks

3. **Reference architecture updates**:
   - Update reference architecture guides to include Elasticsearch instance sizing
   - Provide specific hardware recommendations for different instance sizes
   - Document best practices for resource allocation

4. **Installation option for all deployment types**:
   - Include Elasticsearch as an optional component in all GitLab installation methods
   - Provide clear documentation for enabling and configuring Elasticsearch
   - Ensure compatibility with existing external Elasticsearch installations

### Implementation Approaches

Several potential implementation approaches to consider:

1. **Full Packaging**: Include Elasticsearch directly in omnibus and K8S deliverable packages
   - Elasticsearch core is [open source under the AGPL license](https://www.elastic.co/about/open-source)
   - Would provide most seamless experience for users

2. **Installation Script**: Include scripts in GitLab's distribution that facilitate downloading and installing Elasticsearch
   - Would reduce package size
   - Might be more complex for users

3. **Prompt-based Installation**: Prompt users to install Elasticsearch when they try to use features that require it
   - Requires lowest implementation effort
   - Less proactive, may lead to feature discovery issues

Based on preliminary discussions, the full packaging approach appears to offer the best balance of user experience and implementation feasibility, but further evaluation is needed before making a final decision.

## Design and Implementation Details

### Technical Approach

For the initial implementation, we propose to include Elasticsearch core  version with GitLab's distribution packages, with the following considerations:

1. **Packaging Method Considerations**:
   - For Omnibus: Bundle Elasticsearch as a configurable component
   - For Kubernetes: Leveraging the [cloud-on-k8s](https://github.com/elastic/cloud-on-k8s) project
   - For Docker: Include Elasticsearch in the standard docker-compose setup

2. **Version Selection**:
   - Include Elasticsearch version 8.12+ to support hybrid search capabilities
   - Elasticsearch core is open source under the AGPL license
   - The latest versions have non-trivial cost savings and performance improvements for embeddings storage
   - **Implementation Note**: Elasticsearch Docker Hub images bundle both core and enterprise code, with the latter activated by default for a 30-day trial. As part of this work, we'll need to modify CI configurations to explicitly use only the core functionality.

3. **Configuration and Resource Allocation**:
   - Default to a minimal configuration suitable for small instances
   - Provide configuration templates for different instance sizes
   - Implement automatic scaling parameters based on instance characteristics
   - Isolate resources to prevent ES from impacting GitLab performance

### Self-Managed Considerations

For self-managed customers, the primary challenges are:

- Infrastructure Requirements: Adding new components like Elasticsearch increases complexity
- Architecture Requirements: Elasticsearch in production environment require different configuration and operational settings dependent upon instance size
- Airgapped Support: Providing options for customers in airgapped environments

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

- **Resource Isolation**:
  - Elasticsearch and JVM will require careful resource allocation to prevent performance impact
  - Memory requirements for Elasticsearch + JVM should be properly documented
  - Recommendations for minimum and recommended system specifications will need to be updated

- **Precedent**: Other large components like PostgreSQL (average build time 42.54s) and Ruby (average build time 87.54s) have been successfully integrated into the omnibus package

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
