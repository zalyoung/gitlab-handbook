---
# This is the title of your design document. Keep it short, simple, and descriptive. A
# good title can help communicate what the design document is and should be considered
# as part of any review.
title: Group and project operations and state management
status: ongoing
creation-date: "2025-05-26"
authors: [ "@lohrc", "@rymai" ]
dris: [ "@lohrc", "@rymai" ]
owning-stage: "~devops::tenant scale"
participating-stages: []
# Hides this page in the left sidebar. Recommended so we don't pollute it.
toc_hide: true
---

## Summary

This blueprint proposes a unified state management and tracking system for GitLab namespaces (groups and projects), as well as guidelines on making state-related operations asynchronous.
Currently, groups and projects implement state management (deletion, archival, transfer) as separate features with inconsistent data representations and no historical tracking.
The proposed solution introduces a centralized state management system using `namespaces.state` and `namespace_details.state_metadata` to provide consistent state tracking, metadata storage, and historical records across all namespace types.

## Motivation

Groups and Projects currently have inconsistent state management implementations that create several problems:

**Current Issues:**

- No consistency in group state management
- No consistency in project state management
- No consistency between group and project state management
- State in descendants is sometimes inferred from ancestors inconsistently
- No state history tracking. For instance, it's impossible to know when a project was archived, then unarchived, or when a group was transferred from another namespace
- Different data models for similar operations (for example `group_deletion_schedules` vs `projects.marked_for_deletion_at` to track the "scheduled for deletion" state)
- Performance issues with long-running synchronous operations (99.95th percentile: group transfer 51s, project transfer 27s)

**Business Impact:**

- Poor user experience due to inconsistent behavior and bugs
- Poor user experience due to performance bottlenecks causing timeouts
- Increased load on the Support and Engineering teams to resolve operations that failed due to timeouts or bugs
- Difficulty in auditing and compliance
- Maintenance overhead from duplicated and inconsistent code

### Goals

- Establish a unified state management system for all namespace types
- Provide consistent APIs and behavior across groups and projects
- Enable state history tracking and audit capabilities
- Improve performance by making appropriate operations asynchronous
- Support metadata tracking (who initiated actions, error states, inheritance)
- Reduce code duplication and maintenance overhead
- Enable better observability and debugging capabilities

### Non-Goals

- Complete rewrite of existing functionality (iterative migration approach)
- Changes to user-facing APIs or UI in the initial implementation
- Migration of non-state related group/project consolidation work
- Performance optimizations unrelated to state management

## Proposal

Introduce a centralized namespace state management system and asynchronous operation guidelines.

### Core State Model

**New Attributes:**

- `namespaces.state` (SMALLINT) - State identifier
- `namespace_details.state_metadata` (JSONB) - Associated metadata

**State Metadata Structure:**

```json
{
  "last_updated_at": "2025-05-26T10:00:00Z",
  "last_changed_by_user_id": 12345,
  "inherited_from_namespace_id": 67890,
  "last_error": "Transfer failed: insufficient permissions"
}
```

### State Definitions

| State Integer | State Name | Description |
|----------|------------|-------------|
| 0 | active | Normal operational state |
| 1 | archived | Archived but recoverable |  
| 2 | ancestor_archived | An ancestor of this namespace is archived |
| 3 | deletion_scheduled | Marked for deletion with a grace period |
| 4 | ancestor_deletion_scheduled | An ancestor of this namespace is marked for deletion with a grace period |
| 5 | deletion_in_progress | Currently being deleted |
| 6 | transfer_in_progress | Currently being transferred |

### State Transitions

```mermaid
stateDiagram-v2
    direction LR
    ac: active
    ar: archived
    aar: ancestor_archived
    ds: deletion_scheduled
    ads: ancestor_deletion_scheduled
    dip: deletion_in_progress
    tip: transfer_in_progress
    [*] --> ac    
    note right of ac
        Permanent state until human action
    end note
    ac --> ar: archive
    note right of ar
        Permanent state until human action
    end note
    ac --> aar: archive
    note right of aar
        Permanent state until ancestor is unarchived
    end note
    aar --> ac: unarchive
    ar --> ac: unarchive
    ar --> ds: schedule_deletion
    ds --> ac: restore
    ac --> ads: ancestor_schedule_deletion
    aar --> ads: ancestor_schedule_deletion
    note right of ads
        Temporary state until operation on ancestor starts
    end note
    ads --> ac: restore
    ads --> dip: delete_immediately
    note right of ds
        Temporary state until operation starts
    end note
    ac --> ds: schedule_deletion
    note right of dip
        Temporary state while operation is in progress
    end note
    ds --> dip: delete_immediately
    note right of tip
        Temporary state while operation is in progress
    end note
    ac --> tip: transfer_start
    tip --> ac: transfer_done
    ac --> [*]
    dip --> [*]
```

### Asynchronous operation guidelines

Operations must be asynchronous if they meet any of the following criteria:

- P99.95 performance exceeds 10 seconds
- Operation involves cascading changes to descendants
- Operation requires external service calls or integrations
- Operation involves bulk database writes, deletes, or migrations
- Risk of creating database locks that affect concurrent operations
- Memory-intensive operations that could impact system resources

#### Implementation requirements

All asynchronous operations must provide:

- State transition to appropriate `_in_progress` state
- Immediate acknowledgment of the successful request and ongoing operation
- Progress indicators where technically feasible
- Completion notifications through appropriate channels (Activity, Notification center, Email)
- Comprehensive error handling with user-facing error messages
- Rollback capabilities for failed operations

#### Current operations requiring async implementation

Based on current performance metrics:

- Group transfers (P99.95: 51s) - Priority 1
- Project transfers (P99.95: 27s) - Priority 1
- [Upcoming group archival](https://gitlab.com/groups/gitlab-org/-/epics/15019)

## Design and implementation details

### Database Schema Changes

**Phase 1: Add new columns and indices**

```ruby
class AddStateToNamespaces < Gitlab::Database::Migration[2.3]
  milestone '18.1'
  disable_ddl_transaction!

  def change
    add_column :namespaces, :state, :smallint
  end
end

class AddStateMetadataToNamespaceDetails < Gitlab::Database::Migration[2.3]
  milestone '18.1'
  disable_ddl_transaction!

  CONSTRAINT_NAME = 'check_namespace_details_state_metadata_is_hash'

  def up
    with_lock_retries do
      add_column :namespace_details, :state_metadata, :jsonb, default: {}, null: false
    end

    add_check_constraint :namespace_details, "(jsonb_typeof(state_metadata) = 'object')", CONSTRAINT_NAME
  end

  def down
    remove_check_constraint :namespace_details, CONSTRAINT_NAME

    with_lock_retries do
      remove_column :namespace_details, :state_metadata
    end
  end
end

class AddIndexToStateOnNamespaces < Gitlab::Database::Migration[2.3]
  milestone '18.1'
  disable_ddl_transaction!

  INDEX_NAME = 'index_namespaces_on_state'

  def up
    add_concurrent_index :namespaces, :state, name: INDEX_NAME
  end

  def down
    remove_concurrent_index_by_name :namespaces, INDEX_NAME
  end
end
```

**Phase 2: Create namespace state updates table**

```ruby
class CreateNamespaceStateUpdates < Gitlab::Database::Migration[2.3]
  disable_ddl_transaction!
  milestone '18.1'

  CONSTRAINT_NAME = 'check_namespace_state_updates_metadata_is_hash'

  def up
    create_table :namespace_state_updates do |t|
      t.timestamps_with_timezone null: false
      t.smallint :from_state, null: false
      t.smallint :to_state, null: false
      t.references :namespace,
        null: false,
        foreign_key: { on_delete: :cascade },
        index: true
      t.jsonb :metadata, default: {}, null: false
    end

    add_check_constraint :namespace_state_updates, "(jsonb_typeof(metadata) = 'object')", CONSTRAINT_NAME
  end

  def down
    drop_table :namespace_state_updates
  end
end
```

### Model Changes

**New Concern: `Namespaces::Stateful`**

```ruby
module Namespaces::Stateful
  extend ActiveSupport::Concern
  
  included do
    has_many :namespace_state_updates, dependent: :delete_all
    
    STATES = {
      active: 0,
      archived: 1,
      ancestor_archived: 2,
      deletion_scheduled: 3,
      ancestor_deletion_scheduled: 4,
      deletion_in_progress: 5,
      transfer_in_progress: 6
    }.with_indifferent_access.freeze

    state_machine :state, initial: :active, initialize: false do
      event :archive do
        transition [:active] => :archived
      end
  
      event :ancestor_archive do
        transition [:active, :archived, :deletion_scheduled, :ancestor_deletion_scheduled] => :ancestor_archived
      end

      event :unarchive do
        transition [:archived, :ancestor_archived] => :active
      end
  
      event :schedule_deletion do
        transition [:active, :archived] => :deletion_scheduled
      end

      event :ancestor_schedule_deletion do
        transition [:active, :archived, :ancestor_archived] => :ancestor_deletion_scheduled
      end

      event :restore do
        transition [:deletion_scheduled, :ancestor_deletion_scheduled] => :active
      end

      event :deletion_start do
        transition [:deletion_scheduled, :ancestor_deletion_scheduled] => :deletion_in_progress
      end
  
      event :transfer_start do
        transition active: :transfer_in_progress
      end
  
      event :transfer_done do
        transition transfer_in_progress: :active
      end
  
      after_transition any => any do |namespace|
        namespace.run_after_commit do
          namespace_state_updates.create!(from_state: state_was, to_state: state, metadata: state_metadata)
        end
      end

      state :active, value: STATES[:active]
      state :archived, value: STATES[:archived]
      state :ancestor_archived, value: STATES[:ancestor_archived]
      state :deletion_scheduled, value: STATES[:deletion_scheduled]
      state :ancestor_deletion_scheduled, value: STATES[:ancestor_deletion_scheduled]
      state :deletion_in_progress, value: STATES[:deletion_in_progress]
      state :transfer_in_progress, value: STATES[:transfer_in_progress]
    end
  end
  
  class_methods do
    def non_inheritable_state?(state)
      [:deletion_in_progress, :transfer_in_progress].include?(state)
    end
  end

  def change_state!(new_state, changed_by_user:, inherited_from_namespace: nil)
    state = new_state

    namespace_details.state_metadata = {
      last_updated_at: Time.current
      last_changed_by_user_id: changed_by_user.id
      inherited_from_namespace_id: inherited_from_namespace&.id
    }.compact

    save!
  end
  
  def state_metadata
    namespace_details&.state_metadata || {}
  end
end
```

**New model: `Namespaces::StateUpdate`**

Introduce `namespace_state_updates` table to track all state transitions:

```ruby
class NamespaceStateUpdate < ApplicationRecord
  belongs_to :namespace
end
```

**Unified State Management Service:**

```ruby
class Namespaces::StateManagementService
  def initialize(namespace, current_user, inherited_from_namespace: nil)
    @namespace = namespace
    @current_user = current_user
    @inherited_from_namespace = inherited_from_namespace
  end
  
  def execute!(new_state)
    final_state =
      case new_state
      when :archived
        @inherited_from_namespace ? :ancestor_archived : :archived
      when :deletion_scheduled
        @inherited_from_namespace ? :ancestor_deletion_scheduled : :deletion_scheduled
      when :deletion_in_progress, :transfer_in_progress
        new_state
      end
    end

    update_state!(final_state)
  end
  
  private
  
  def update_state!(new_state)
    @namespace.change_state!(new_state, changed_by_user: @current_user, inherited_from_namespace: @inherited_from_namespace)

    return if Namespace.non_inheritable_state?(new_state)
    return unless @inherited_from_namespace

    update_descendants_state(new_state)
  end

  def update_descendants_state(state)
    NamespaceDescendantsStateUpdateWorker.perform_async(namespace_id: @namespace.id, current_user_id: @current_user.id, state: state)
  end
end
```

### Worker Layer

**State Synchronization Worker:**

```ruby
module Namespaces
  class NamespaceDescendantsStateUpdateWorker
    include ApplicationWorker
  
    data_consistency :always
  
    sidekiq_options retry: 3
    include ExceptionBacktrace
  
    INTERVAL = 2.seconds.to_i
  
    feature_category :groups_and_projects
    idempotent!
  
    def perform(namespace_id:, current_user_id:, state:)
      namespace = Namespace.find_by_id(namespace_id)
      return unless namespace

      # The namespace state has changed since the job was enqueued, the update will be done by another job.
      return unless state == namespace.state

      current_user = User.find_by_id(current_user_id)
  
      # rubocop: disable CodeReuse/ActiveRecord
      descendants = namespace.descendants # rubocop: disable CodeReuse/ActiveRecord
      descendants.find_each(batch_size: 100).with_index do |descendant, index|  
        with_context(namespace: descendant) do
          Namespaces::StateManagementService
            .new(descendant, current_user, inherited_from_namespace: namespace)
            .execute(state)
        end
      end
      # rubocop: enable CodeReuse/ActiveRecord
    end
  end
end
```

### Migration Strategy

**Iteration 1: Infrastructure Setup**

- Add `state` column to `namespaces`
- Create `namespace_state_updates` table
- Add `Namespaces::Stateful` concern

**Iteration 2: State Synchronization**

- Ensure `state` updates with legacy state changes
- Implement bidirectional synchronization
- Add validation and consistency checks

**Iteration 3: Backfill Historical Data**

- Migrate existing states to new system
- Backfill `state` from legacy columns/tables
- Data validation and cleanup

**Iteration 4: Feature Migration**

- Replace legacy state checks with new system
- Update controllers and services
- Maintain backward compatibility

**Iteration 5: Legacy Cleanup**

- Remove legacy state columns/tables
- Update documentation and tests
- Performance optimization

### Performance Considerations

**Asynchronous Operations:**

- Group transfers (P1 priority - currently 51s at 99.95th percentile)
- Project transfers (P1 priority - currently 27s at 99.95th percentile)
- Large group archival operations

**Optimization Strategies:**

- Batch updates for descendant state changes
- Background job processing for heavy operations
- Caching for frequently accessed state information
- Database indexes on `state` and related columns

### API Consistency

**Unified REST API Endpoints:**

```shell
GET /api/v4/namespaces/:id/state
PUT /api/v4/namespaces/:id/state
GET /api/v4/namespaces/:id/state/history
```

**GraphQL Schema:**

```graphql
type Namespace {
  state: NamespaceState!
  stateHistory: [NamespaceStateUpdate!]!
}

enum NamespaceState {
  ACTIVE
  ARCHIVED
  DELETION_SCHEDULED
  DELETION_IN_PROGRESS
  TRANSFER_IN_PROGRESS
}
```

## Alternative Solutions

### Alternative 1: Separate State Tables per Type

**Pros:**

- Clear separation of concerns
- Type-specific optimizations possible

**Cons:**

- Maintains current inconsistency
- Duplicated logic and maintenance overhead
- No unified querying capabilities

### Alternative 2: Event Sourcing Approach

**Pros:**

- Complete audit trail
- Time-travel capabilities
- Excellent for compliance

**Cons:**

- Significant complexity increase
- Performance overhead for simple state queries
- Steep learning curve for team

### Alternative 3: Do Nothing

**Pros:**

- No development effort required
- No migration risks

**Cons:**

- Performance issues persist (P1 transfer operations)
- Inconsistency continues to create bugs
- Technical debt accumulates
- Poor user experience remains

**Decision:** The proposed solution balances complexity with benefits, providing immediate improvements while enabling future enhancements.

## Metrics and Success Criteria

**Performance Targets:**

- Reduce P99.95 group transfer time from 51s to <10s
- Reduce P99.95 project transfer time from 27s to <5s
- Maintain deletion operation performance (<2s for scheduling)

**Quality Metrics:**

- Zero state inconsistency bugs after full migration
- 100% state history coverage for audit requirements
- Unified test coverage across all namespace types

**Developer Experience:**

- Single API for all state management operations
- Consistent behavior documentation
- Reduced code duplication (target: 50% reduction in state-related code)

## Risks and Mitigations

**Risk: Data Migration Complexity**

- *Mitigation:* Iterative approach with rollback capabilities, extensive testing

**Risk: Performance Impact During Migration**

- *Mitigation:* Background migrations, feature flags, monitoring

**Risk: API Breaking Changes**

- *Mitigation:* Maintain backward compatibility, versioned APIs

**Risk: State Consistency Issues**

- *Mitigation:* Bidirectional synchronization during transition, validation checks
