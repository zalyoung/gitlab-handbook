# Proposal of database structure

## 📄 Technical Proposal: Notification System Design

### 🧠 Goal

Design a flexible and normalized database structure to manage **user notifications** about different types of resources (issues, notes, merge requests, epics), while avoiding:

- Single Table Inheritance (STI)
- Polymorphic Associations

## 🏗️ Database Design Overview

### 1. `notifications` table (centralized)

Stores notifications per user.

```sql
CREATE TABLE notifications (
  id SERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(id),
  read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  namespace_id BIGINT NOT NULL REFERENCES namespaces(id),
  snoozed_until TIMESTAMP,
  saved BOOLEAN DEFAULT FALSE,
  resolved_by_action SMALLINT,
  author_id BIGINT REFERENCES users(id),
  action SMALLINT
);
```

### 2. Resource Link Tables (one per resource)

Each notification links to exactly **one** resource via a dedicated table.

```sql
CREATE TABLE issue_notifications (
  notification_id BIGINT PRIMARY KEY REFERENCES notifications(id) ON DELETE CASCADE,
  issue_id BIGINT NOT NULL REFERENCES issues(id) ON DELETE CASCADE
);

CREATE TABLE note_notifications (
  notification_id BIGINT PRIMARY KEY REFERENCES notifications(id) ON DELETE CASCADE,
  note_id BIGINT NOT NULL REFERENCES notes(id) ON DELETE CASCADE
);

CREATE TABLE merge_request_notifications (
  notification_id BIGINT PRIMARY KEY REFERENCES notifications(id) ON DELETE CASCADE,
  merge_request_id BIGINT NOT NULL REFERENCES merge_requests(id) ON DELETE CASCADE
);

CREATE TABLE epic_notifications (
  notification_id BIGINT PRIMARY KEY REFERENCES notifications(id) ON DELETE CASCADE,
  epic_id BIGINT NOT NULL REFERENCES epics(id) ON DELETE CASCADE
);

CREATE TABLE ssh_keys_notification_links (
  notification_id BIGINT PRIMARY KEY REFERENCES notifications(id) ON DELETE CASCADE,
  ssh_key_id BIGINT NOT NULL REFERENCES keys(id) ON DELETE CASCADE
)

CREATE TABLE commit_notifications (
  notification_id BIGINT PRIMARY KEY REFERENCES notifications(id) ON DELETE CASCADE,
  commit_id BIGINT NOT NULL 
)
```

For the future reference: those linking tables should be sharded together with `notifications` table, so `notification_id` should be the sharding key.

## 🔍 Entity Relationship Diagram

```mermaid
erDiagram
  users ||--o{ notifications : has
  notifications ||--|| issue_notifications : links
  notifications ||--|| note_notifications : links
  notifications ||--|| merge_request_notifications : links
  notifications ||--|| epic_notifications : links etc
```

## ⚖️ Validation Strategy

### ✅ Application-Level Validation (Rails)

```ruby
# app/models/notification.rb
class Notification < ApplicationRecord
  belongs_to :user

  has_one :issue_notification
  has_one :note_notification
  has_one :merge_request_notification
  has_one :epic_notification_link 
  <etc>

  has_one :issue, through: :issue_notification
  has_one :note, through: :note_notification
  has_one :merge_request, through: :merge_request_notification
  has_one :epic, through: :epic_notification
  <etc>

  validate :only_one_resource_linked

  def only_one_resource_linked
    links = [
      issue_notification,
      note_notification,
      merge_request_notification,
      epic_notification
    ].compact

    errors.add(:base, "Only one resource can be linked to a notification") if links.size > 1
  end
end
```

## ⚙️ Notification Creation Service

Encapsulates logic for resource-safe creation:

```ruby
class NotificationCreator
  def self.create_for(resource:, user:)
    Notification.transaction do
      notification = Notification.create!(user: user)

      case resource
      when Issue
        IssueNotification.create!(notification: notification, issue: resource)
      when Note
        NoteNotification.create!(notification: notification, note: resource)
      when MergeRequest
        MergeRequestNotification.create!(notification: notification, merge_request: resource)
      when Epic
        EpicNotification.create!(notification: notification, epic: resource)
      else
        raise ArgumentError, "Unsupported resource type"
      end

      notification
    end
  end
end
```

## 📦 Rails Model Summary

Each link table has a corresponding model, e.g.:

```ruby
class IssueNotification < ApplicationRecord
  belongs_to :notification
  belongs_to :issue
end
```

Repeat similarly for `NoteNotification`, `MergeRequestNotification`, and `EpicNotification` etc.

---

## 📊 Query Examples

### Get all user notifications with resource type

```sql
SELECT n.id, 'Issue' AS resource_type, i.title, n.read, n.created_at
FROM notifications n
JOIN issue_notifications l ON l.notification_id = n.id
JOIN issues i ON i.id = l.issue_id
WHERE n.user_id = :user_id

UNION ALL

SELECT n.id, 'Note', no.content, n.read, n.created_at
FROM notifications n
JOIN note_notifications l ON l.notification_id = n.id
JOIN notes no ON no.id = l.note_id
WHERE n.user_id = :user_id

UNION ALL

SELECT n.id, 'MergeRequest', mr.title, n.read, n.created_at
FROM notifications n
JOIN merge_request_notifications l ON l.notification_id = n.id
JOIN merge_requests mr ON mr.id = l.merge_request_id
WHERE n.user_id = :user_id

UNION ALL

SELECT n.id, 'Epic', e.title, n.read, n.created_at
FROM notifications n
JOIN epic_notifications l ON l.notification_id = n.id
JOIN epics e ON e.id = l.epic_id
WHERE n.user_id = :user_id

ORDER BY created_at DESC;
```

## Benefits of this design

- No STI or polymorphic associations
- Full referential integrity via FK constraints
- Clear separation of responsibilities
- Rails-friendly with explicit models
- Easier indexing and performance optimization

## Challenges of this design

- Joining multiple tables at once
- Need for the careful queries structure to avoid inefficient queries
