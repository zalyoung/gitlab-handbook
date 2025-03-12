---
title: "Advanced Finders"
status: draft
creation-date: "2025-03-09"
authors: [ "@dgruzd" ]
coach: []
approvers: []
owning-stage: "~devops::foundations"
participating-stages: []
---

## Summary

This document describes a new advanced architecture for GitLab finders that can leverage both PostgreSQL and Advanced Search (Elasticsearch/OpenSearch) as data sources. Current finders return ActiveRecord relations, which limits their ability to use Advanced Search efficiently. The new architecture aims to create a unified interface that can seamlessly switch between data sources while providing consistent pagination and result formatting.

## Business Objectives

Currently, searches performed through the dashboard or through the group and project interfaces rely exclusively on database operations rather than leveraging Advanced search when available. This results in:

1. Slower search performance when data is already available in Advanced Search
2. Limited search capabilities - features like "find all issues with term X in comments" are too performance-intensive to implement with the current database-only approach
3. Missed opportunity to leverage existing Elasticsearch indexes, which are expensive to maintain

By implementing Advanced Finders, we will:

- Improve search performance for users with Advanced Search enabled
- Enable more sophisticated search capabilities
- Maximize the value of our existing Elasticsearch infrastructure
- Create a future-proof architecture that can adapt to different data sources

## Overview

The Advanced Finders will:

1. Provide a consistent interface for accessing data from either PostgreSQL or Advanced Search
2. Return paginated collections of model instances rather than ActiveRecord relations
3. Support standard search filtering capabilities across both backends
4. Allow for backend-specific optimizations without affecting the consumer API

### Current State

Currently, GitLab finders follow a pattern where:

- They accept search parameters in their constructor
- They expose an `execute` method that returns an ActiveRecord relation
- The returned relation can be further filtered or chained with other queries
- They work exclusively with PostgreSQL as the data source

Example usage:

```ruby
relation = IssuesFinder.new(current_user, project_id: project.id).execute
issues = relation.with_label('bug').order_created_desc.limit(10)
```

This approach has the disadvantage that it cannot leverage Advanced Search, even when it's available and might provide better performance or additional search capabilities.

### Target State

The new Advanced Finders will:

- Accept search parameters and pagination options in their constructor
- Expose an `execute` method that returns a result object containing:
  - A collection of model instances (not an ActiveRecord relation)
  - Pagination metadata (total count, page info)
- Internally select the appropriate backend (PostgreSQL or Advanced Search) based on:
  - Advanced Search availability
  - Query complexity
  - Configuration preferences
  - Parameter support in Advanced Search (using allowlists)

Example usage:

```ruby
result = AdvancedIssuesFinder.new(
  current_user,
  project_id: project.id,
  with_labels: ['bug'],
  page: 2,
  per_page: 20
).execute

issues = result.items
pagination = result.pagination
```

## Goals and Key Results

### Goals

1. Enable filtered searches to leverage Advanced Search when available
2. Improve search performance for complex queries
3. Provide a clear migration path from current finders to dual-backend finders
4. Maintain feature parity with existing finders

### Key Results

1. At least three high-traffic finders (Issues, MergeRequests, Projects) refactored to use the new architecture
2. Measurable performance improvements (>30%) for complex searches when Advanced Search is enabled
3. Comprehensive test coverage ensuring identical results between PostgreSQL and Advanced Search backends
4. Documentation for both finder usage and creating new dual-backend finders

## Fundamental Design Areas

### Result Container

Rather than returning ActiveRecord relations, the new finders will return a result object that encapsulates both the collection items and metadata like pagination information.

### Backend Selection

The finder should be able to determine which backend to use based on:

- Advanced Search availability
- Query complexity
- Feature flags
- User preferences (if applicable)
- Parameter support through allowlists

### Query Translation

Finders need to translate the same set of parameters into both SQL queries and Elasticsearch queries.

### Pagination

Both backends need to support consistent pagination with page numbers and per-page limits.

### Result Formatting

Results from both backends need to be formatted consistently to match the expected model instances.

### Parameter Support Allowlisting

Each finder will maintain an allowlist of supported parameters for each backend, allowing for transparent routing and gradual migration.

### Redaction Logic

A critical safety mechanism that ensures no unauthorized data is returned to users:

- Applies permission checks using `Ability.allowed?(current_user, permission, item)` on each result
- Serves as a final safety net after backend-specific visibility filtering
- Automatically adjusts pagination data to account for redacted items
- Provides transparency through a `redacted?` flag on the result object

This redaction mechanism is especially important when using Advanced Search, as it ensures consistent application of GitLab's permission model across all data sources, even if the search backend returns results that should be invisible to the current user.

## Key Design Decisions

### Return Type

**Decision**: Finders will return a `FinderResult` object rather than an ActiveRecord relation.

**Context**: Current finders return ActiveRecord relations, which cannot represent Elasticsearch results. We need a container that can hold results from either backend.

**Benefits**:

- Consistent interface regardless of backend
- Can include metadata (like pagination) that isn't part of the collection itself
- Allows for future extension (for example, facets, suggestions)

**Tradeoffs**:

- Not able to be chained like ActiveRecord relations
- Requires changing the API of finders

### Backend Selection Strategy

**Decision**: Use a registry of supported search backends with a prioritization mechanism and parameter support allowlisting.

**Context**: We need to select the appropriate backend based on multiple factors like availability, query complexity, and parameter support.

**Benefits**:

- Flexible prioritization logic
- Can be configured at runtime
- Supports gradual rollout through feature flags
- Parameter allowlisting allows for graceful degradation

**Tradeoffs**:

- Additional complexity compared to hardcoded backend selection
- Requires maintenance of parameter support allowlists

### Pagination Implementation

**Decision**: Implement cursor-based pagination rather than offset-based pagination.

**Context**: Elasticsearch performs better with cursor-based pagination, while PostgreSQL traditionally uses offset-based pagination.

**Benefits**:

- More consistent performance with large datasets
- Better performance with Elasticsearch
- Avoids "skipped items" problem when data changes between pages

**Tradeoffs**:

- More complex implementation
- Less familiar to developers compared to offset-based pagination

## Implementation Details

### Parameter Support Allowlisting

To facilitate gradual migration and ensure consistent results, we'll implement a parameter allowlist system:

```ruby
module Finders
  module ParameterSupport
    # Registry of supported parameters for each finder and backend
    PARAMETER_ALLOWLIST = {
      'IssuesFinder' => {
        advanced_search: [
          :project_id, :group_id, :scope, :state, :search, :in, :author_id,
          :author_username, :assignee_id, :assignee_username, :milestone_title,
          :label_name, :created_after, :created_before, :updated_after,
          :updated_before, :sort, :page, :per_page
        ],
        postgresql: [
          :project_id, :group_id, :scope, :state, :search, :in, :author_id,
          :author_username, :assignee_id, :assignee_username, :milestone_title,
          :label_name, :created_after, :created_before, :updated_after,
          :updated_before, :sort, :confidential, :my_reaction_emoji,
          :page, :per_page
        ]
      },
      'MergeRequestsFinder' => {
        advanced_search: [
          :project_id, :group_id, :scope, :state, :search, :in, :author_id,
          :author_username, :assignee_id, :assignee_username, :page, :per_page
        ],
        postgresql: [
          :project_id, :group_id, :scope, :state, :search, :in, :author_id,
          :author_username, :assignee_id, :assignee_username, :approved_by_ids,
          :reviewer_id, :reviewer_username, :wip, :draft, :page, :per_page
        ]
      }
      # Add other finders here
    }.freeze

    def self.supported_parameters(finder_name, backend)
      PARAMETER_ALLOWLIST.dig(finder_name, backend) || []
    end

    def self.backend_supports_params?(finder_name, backend, params)
      return true if backend == :postgresql # PostgreSQL backend always supports all parameters

      # Get the list of supported parameters for this finder and backend
      supported = supported_parameters(finder_name, backend)

      # Check if all provided parameters are in the supported list
      params.keys.all? { |param| supported.include?(param.to_sym) }
    end
  end
end
```

### Transparent Transition Strategy

During the migration period, we'll implement a strategy to transparently route queries between legacy and Advanced Finders based on parameter support. This approach offers several advantages:

1. Progressive migration without breaking changes
2. The ability to validate new finders against legacy finders in production
3. Gradual adoption of new finder capabilities

The implementation involves creating adapter classes that:

- Check which arguments/filters are provided
- Use feature flags to control routing behavior
- Check parameter support allowlists
- Delegate to the appropriate finder implementation
- Convert results if necessary

```ruby
module Finders
  class IssuesFinderAdapter
    attr_reader :current_user, :params

    def initialize(current_user, params = {})
      @current_user = current_user
      @params = params
    end

    def execute
      if use_advanced_finder?
        result = Finders::AdvancedIssuesFinder.new(current_user, params).execute
        # Controllers expecting ActiveRecord relations can use .items
        # We could add .to_relation for partial backward compatibility if needed
        result
      else
        # Use legacy finder
        legacy_result = ::IssuesFinder.new(current_user, params).execute
        # Optionally wrap in FinderResult for consistency
        FinderResult.new(
          legacy_result.to_a,
          {
            total_count: legacy_result.count,
            total_pages: (legacy_result.count.to_f / (params[:per_page] || 20).to_f).ceil,
            current_page: params[:page] || 1
          }
        )
      end
    end

    private

    def use_advanced_finder?
      return false unless Feature.enabled?(:advanced_finders)
      return false if params[:force_legacy_finder]

      # Check if Advanced Search is available
      return false unless advanced_search_available?

      # Check if all provided parameters are supported by the advanced finder
      ParameterSupport.backend_supports_params?('IssuesFinder', :advanced_search, params)
    end

    def advanced_search_available?
      Gitlab::CurrentSettings.elasticsearch_search?
    end
  end
end
```

### `FinderResult` Class

```ruby
class FinderResult
  attr_reader :items, :pagination, :backend_used

  def initialize(items, pagination, backend_used = nil)
    @items = items
    @pagination = pagination
    @backend_used = backend_used
  end

  def total_count
    pagination[:total_count]
  end

  def total_pages
    pagination[:total_pages]
  end

  def current_page
    pagination[:current_page]
  end

  def next_page?
    current_page < total_pages
  end

  def prev_page?
    current_page > 1
  end

  def empty?
    items.empty?
  end

  # Indicates whether any results were redacted due to permissions
  def redacted?
    pagination[:redacted] == true
  end

  # For diagnostic/logging purposes
  def used_advanced_search?
    backend_used == :advanced_search
  end

  def used_postgresql?
    backend_used == :postgresql
  end
end
```

### Base Dual-Backend Finder

```ruby
module Finders
  class BaseAdvancedFinder
    attr_reader :current_user, :params

    def initialize(current_user, params = {})
      @current_user = current_user
      @params = params
    end

    def execute
      backend_type, backend = select_backend
      items = backend.execute(query_params)

      # Apply redaction logic to filter out items the user doesn't have access to
      redacted_items = apply_redaction(items)

      # Recalculate pagination after redaction
      pagination = build_pagination_for_redacted_results(backend, redacted_items)

      FinderResult.new(redacted_items, pagination, backend_type)
    end

    private

    def select_backend
      # Return tuple of [backend_type, backend_instance]
      if advanced_search_available? && should_use_advanced_search?
        [:advanced_search, advanced_search_backend]
      else
        [:postgresql, postgresql_backend]
      end
    end

    def should_use_advanced_search?
      return false if params[:force_database_backend]

      # Check if parameters are supported by Advanced Search
      if !ParameterSupport.backend_supports_params?(self.class.name, :advanced_search, params)
        return false
      end

      # Check if query is complex enough to benefit from Advanced Search
      query_complexity > complexity_threshold
    end

    def advanced_search_available?
      Gitlab::CurrentSettings.elasticsearch_search?
    end

    def query_complexity
      # Calculate complexity of the query
      complexity = 0
      complexity += 3 if params[:search].present?
      complexity += 2 if params[:in].present? && params[:in].include?('comments')
      complexity += 1 if params[:label_name].present? && params[:label_name].is_a?(Array) && params[:label_name].size > 1
      complexity
    end

    def complexity_threshold
      # Threshold above which Advanced Search is preferred
      2
    end

    def postgresql_backend
      # Return the PostgreSQL backend implementation
    end

    def advanced_search_backend
      # Return the Advanced Search backend implementation
    end

    def query_params
      # Format the parameters for the selected backend
    end

    def build_pagination(backend)
      {
        total_count: backend.total_count,
        total_pages: backend.total_pages,
        current_page: params[:page] || 1
      }
    end

    # Apply redaction logic to filter out items the user doesn't have access to
    # This serves as a safety net, even though both backends should already apply
    # visibility scoping, to ensure no unauthorized access occurs
    def apply_redaction(items)
      return [] if items.empty?

      # Filter out items that the user doesn't have permission to access
      items.select do |item|
        # Check if the current user has access to this item
        # For most items, this will use `read_` permissions
        permission = permission_for_model(item.class.name)
        Ability.allowed?(current_user, permission, item)
      end
    end

    # Determine the appropriate permission to check based on model type
    def permission_for_model(model_name)
      case model_name
      when 'Issue'
        :read_issue
      when 'MergeRequest'
        :read_merge_request
      when 'Project'
        :read_project
      when 'Epic'
        :read_epic
      when 'User'
        :read_user
      when 'Note'
        :read_note
      when 'Snippet'
        :read_snippet
      else
        # Default to :read_<model> for other models
        :"read_#{model_name.underscore}"
      end
    end

    # Recalculate pagination data after redacting items
    def build_pagination_for_redacted_results(backend, redacted_items)
      original_pagination = build_pagination(backend)

      # If no redaction occurred, return original pagination
      if redacted_items.count == original_pagination[:total_count]
        return original_pagination
      end

      # Otherwise, we need to adjust the pagination to account for redacted items
      page_size = params[:per_page] || 20
      current_page = params[:page] || 1

      {
        total_count: redacted_items.count,
        total_pages: (redacted_items.count.to_f / page_size.to_f).ceil,
        current_page: current_page,
        redacted: true # Flag to indicate redaction occurred
      }
    end
  end
end
```

### Backend Implementations

#### PostgreSQL Backend

```ruby
module Finders
  module Backends
    class PostgreSQL
      attr_reader :finder, :params

      def initialize(finder, params)
        @finder = finder
        @params = params
      end

      def execute(query_params)
        relation = build_relation(query_params)
        paginate(relation)
      end

      def total_count
        @total_count ||= build_relation(query_params).count
      end

      def total_pages
        (total_count.to_f / (params[:per_page] || 20).to_f).ceil
      end

      private

      def build_relation(query_params)
        # Build ActiveRecord relation based on query_params
      end

      def paginate(relation)
        page = params[:page] || 1
        per_page = params[:per_page] || 20

        relation.page(page).per(per_page).to_a
      end
    end
  end
end
```

#### Advanced Search Backend

```ruby
module Finders
  module Backends
    class AdvancedSearch
      attr_reader :finder, :params

      def initialize(finder, params)
        @finder = finder
        @params = params
      end

      def execute(query_params)
        search_results = perform_search(query_params)
        format_results(search_results)
      end

      def total_count
        @total_count ||= perform_search(query_params, count_only: true)
      end

      def total_pages
        (total_count.to_f / (params[:per_page] || 20).to_f).ceil
      end

      private

      def perform_search(query_params, count_only: false)
        # Perform Elasticsearch search based on query_params
      end

      def format_results(search_results)
        # Convert Elasticsearch results to model instances
      end
    end
  end
end
```

### Example Implementation: IssuesFinder

```ruby
module Finders
  class AdvancedIssuesFinder < BaseAdvancedFinder
    def initialize(current_user, params = {})
      super
    end

    private

    def postgresql_backend
      Backends::PostgreSQL::IssuesBackend.new(self, params)
    end

    def advanced_search_backend
      Backends::AdvancedSearch::IssuesBackend.new(self, params)
    end
  end
end
```

## Rollout Strategy

1. Create the base infrastructure for Advanced Finders
2. Define initial parameter support allowlists for high-traffic finders
3. Implement the first finder (e.g., IssuesFinder) with both backends
4. Add feature flags to control backend selection
5. Create adapter classes that can transparently delegate to either new or legacy finders based on parameter support
6. Gradually expand parameter support allowlists as capabilities are added
7. Progressively replace existing finders with Advanced Finders
8. Update controllers and API endpoints to use the new finders
9. Monitor performance and correctness

## Testing Strategy

1. Unit tests for each backend implementation
2. Integration tests comparing results between backends
3. Tests for parameter support allowlist behavior
4. Performance benchmarks for representative queries
5. Load testing with large datasets

## Migration Plan

### Phase 1: Infrastructure and Allowlist Setup

- Implement base classes and interfaces
- Create testing framework
- Implement parameter support allowlists
- Implement feature flags for gradual rollout

### Phase 2: Legacy Finder Adapter

- Create adapter layer that can delegate to either new or legacy finders
- Implement parameter support detection using allowlists
- Ensure backward compatibility with existing code

### Phase 3: First Implementation with Limited Parameter Support

- Refactor IssuesFinder to use the new architecture
- Implement both PostgreSQL and Advanced Search backends
- Start with a small allowlist of supported parameters
- Deploy with feature flags disabled
- Perform extensive testing

### Phase 4: Transparent Migration with Expanding Parameter Support

- Enable feature flags for a percentage of users
- Have adapters automatically route queries to new finders based on parameter support
- Gradually expand parameter support by updating allowlists
- Monitor performance and error rates

### Phase 5: Additional Finders

- Refactor additional high-impact finders
- Document patterns for creating new finders
- Continue expanding parameter support allowlists

### Phase 6: Legacy Finder Deprecation

- Mark old finders as deprecated
- Create migration guides for custom finders
- Eventually remove old finders

## Conclusion

The Advanced Finders architecture provides a flexible, future-proof approach to retrieving data in GitLab. By supporting both PostgreSQL and Advanced Search backends with a consistent interface and parameter support allowlisting, we can improve search performance and capabilities while ensuring a smooth migration path.

## References

- [Epic: Use Advanced Search for Filtered Searches of Issues and Merge Requests](https://gitlab.com/groups/gitlab-org/-/epics/14293)
- [Issue: Finders should return ActiveRecord collections](https://gitlab.com/gitlab-org/gitlab/-/issues/298771)
- [Guidelines for reusing abstractions](https://docs.gitlab.com/development/reusing_abstractions/#finders)
- [Work Items API Performance Working Group](/handbook/engineering/development/dev/plan/working-groups/work-items-api-performance/)
