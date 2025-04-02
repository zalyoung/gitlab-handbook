---
title: "Code Embeddings"
status: ongoing
creation-date: "2025-04-02"
authors: [ "@maddievn" ]
coach: ["@dgruzd", "@DylanGriffith"]
approvers: []
owning-stage: "~devops::foundations"
toc_hide: true
---

## Code Embeddings

### Available tools for indexing Code Embeddings

#### GitLab Active Context Gem

A Ruby gem for interfacing with vector stores like Elasticsearch, OpenSearch, and PostgreSQL with PGVector for storing and querying vectors.

Key Components:

- **Adapter Layer**: Provides a unified interface to different storage backends.
- **Collection Management**: Handles creating and managing collections of documents.
- **Reference System**: Defines how to serialize and index different types of objects.
- **Queue Management**: Manages asynchronous processing of indexing operations.
- **Migration System**: Similar to database migrations for managing schema changes.
- **Embedding Support**: Integrates with embedding generation for vector search capabilities.

#### GitLab Elasticsearch Indexer

A Go application that indexes Git repositories into Elasticsearch for GitLab.

Key Components:

- **Indexer Module**: Handles the core indexing functionality for different content types.
- **Git Integration**: Uses Gitaly to access repository content.
- **Elasticsearch Client**: Manages connections to Elasticsearch and handles document submission.

### Proposal: Use Go Indexer to index chunks and Rails to index embeddings

Indexing and chunking done in the Go Indexer, with the chunks immediately stored in vector storage.

The indexer efficiently processes and chunks code files, while Rails handles generating and storing embeddings separately.

**Process Flow:**

- Git push event triggers Rails to call indexer.
- Indexer calls Gitaly to retrieve changed files.
- Process each file by chunking the content using the configured chunker.
- Create each chunk if not present
  - Postgres: `INSERT into chunks (...) ON CONFLICT DO UPDATE`
  - Elasticsearch/OpenSearch: `doc_as_upsert: true, detect_noop: true`
- Delete orphaned chunks
  - Postgres: `DELETE from chunks where filename = ? AND hash NOT IN (?)`
- Return upserted unique IDs back to Rails
- AI Abstraction Layer tracks embedding references for each unique ID.
- In batches, references are pulled from the queue.
- A bulk lookup is done to the vector store to check if the document exists and get content.
- Embeddings are generated in bulk and upserted into the vector store.

```mermaid
sequenceDiagram
    title Indexer Indexes Code Chunks, Rails Indexes Embeddings
    participant User
    participant Rails
    participant PostgreSQL
    participant Indexer
    participant Gitaly
    participant VectorStore
    participant AIContextLayer
    participant AIGateway

    GitUser->>Rails: Git push event
    Rails->>PostgreSQL: Store current from and to SHA in postgres
    Rails->>Indexer: Trigger indexing of changed files
    Indexer->>Gitaly: Request changed files
    Gitaly-->>Indexer: Return changed files
    Indexer->>Indexer: Chunk each file
    Indexer->>VectorStore: Upsert each chunk with content + unique identifier + version
    VectorStore-->>Indexer: Confirm indexing
    Indexer->>VectorStore: Delete orphaned documents
    VectorStore-->>Indexer: Confirm deletion
    Indexer-->>Rails: Return changed unique ids

    Note right of AIContextLayer: Backfill embeddings for updated chunks
    Rails->>AIContextLayer: Build references for embeddings
    AIContextLayer->>VectorStore: Look up unique ids
    VectorStore-->>AIContextLayer: Return matching chunks
    AIContextLayer->>AIGateway: Request embeddings for chunks
    AIGateway-->>AIContextLayer: Return embeddings
    AIContextLayer->>VectorStore: Add embeddings to documents
    VectorStore-->>AIContextLayer: Confirm update
    AIContextLayer-->>Rails: Process complete
```

## Design and implementation details

### Key Implementation Notes

- Embedding deduplication is managed by tracking references: if a ref is in the queue for an hour, it might have changed multiple times or be deleted, but we only care about the final state
- A hashed version of the filename and chunk content will be used as the unique identifier for each document.
- The indexer can be called with an option to index a full repository (e.g. a `--force` option) which can be called for initial indexing, when the chunker changes, etc. Normal mode is to process changed files only.
- Embedding generation is the most time-intensive part of the process, with a throughput of approximately 250 embeddings per minute for the current model.
- Data is restricted to namespaces with Duo Pro or Duo Enterprise add-ons.
- NB: This implementation does not support feature branches.

### Required changes on indexer

- Add mode to indexer for indexing code chunks
- Allow indexer to call chunker
- Add postgres client to indexer (Elasticsearch/OpenSearch client exists) and selecting a client from Rails
- Implement translations for each adapter (Elasticsearch, OpenSearch, Postgres) for indexing

### Schema

| Field Name | Type | Description |
|------------|------|-------------|
| id | keyword | hash of the filename and chunk content |
| project_id | bigint | Filter by projects |
| path | keyword | Relative path including file name |
| type | smallint | Enum indicating whether it's the full blob content or a node extracted from a chunker. Example options: `file\|class\|function\|imports\|constant` |
| content | text | Code content |
| name | text | Name of chunk, e.g. `ModuleName::ClassName::method_name` |
| source | keyword | `"#{blob.id}:#{offset}:#{length}"` which can be used to rebuild the full file or restore order of chunks |
| language | keyword | Language of content |
| embeddings_v1 | vector | Embeddings for the content |

The following fields were considered but not added to the initial schema. Adding new fields can be done using AI Abstraction Layer migrations and backfills can be done using either migrations or by doing a reindex.

- `archived` (`boolean`): for group-level search, filter out projects that are archived
- `branches` (`keyword[]`): to support non-default branches
- `extension` (`keyword`): extension of the file to easily filter by extension
- `repository_access_level` (`smallint`): permissions for group-level searches
- `traversal_ids` (`keyword`): Efficient group-level searches
- `visibility_level` (`smallint`): permissions for group-level searches

### Options for supporting multiple branches

By default, GitLab code search supports indexing and searching only the default branch. Supporting multiple branches requires additional considerations for storage, indexing strategy, and query complexity.

#### Option 1: Index Only Branch Diffs

Only index the differences (diffs) between the default branch and other branches. When a file is modified in a branch, index that version with branch metadata.

#### Option 2: Branch Bitmap Approach

Store a bitmap representing branch membership for each file. Maintain an ordered list of branches (e.g., master, branch1, branch2, branch3), and represent file presence with a bitmap (e.g., file in master and branch1 = 1100, file modified in branch2 = 0010).

#### Option 3: Tree Structure Traversal

Implement a tree-based structure representing the git repository hierarchy that can be traversed during search operations. This would mirror the actual version control model but requires a more sophisticated implementation.

#### Pros and Cons

| Option | Pros | Cons |
|--------|------|------|
| **Option 1: Index Only Branch Diffs** | • Requires less storage space<br>• Simpler implementation process<br>• Faster initial indexing | • Search results may include duplicate files (from default branch and branch versions)<br>• Requires result deduplication/selection logic<br>• Boosting for branch-specific results is easier in Elasticsearch than PostgreSQL |
| **Option 2: Branch Bitmap Approach** | • Efficient representation of branch membership<br>• No duplicate results | • Uncertain performance impact for bitmap operations in Elasticsearch/PostgreSQL<br>• Requires reindexing metadata (but not embeddings) for all files when branches change<br>• Bitmap size grows with number of branches<br>• More complex implementation |
| **Option 3: Tree Structure Traversal** | • Most accurate representation of git model<br>• Potentially more flexible for complex queries<br>• Could better handle branch hierarchies and merges| • Most complex implementation<br>• No clear implementation path currently defined |

### Proposal: Searching over indexed chunks

A query containing filters and embeddings is built and when executed, it is translated to a query the vector store is able to execute and results are returned.

```mermaid
sequenceDiagram
    participant App as Application Code
    participant Query as Query
    participant VertexAI as Vertex API via AI Gateway
    participant VectorStore as Vector Store (ES/PG/OS)
    participant QueryResult as Query Result

    Note over App: Querying from vector stores

    App->>Query: Create query with filter conditions
    App->>Query: Add knn query for similarity search
    Query->>VertexAI: generate embeddings in bulk
    VertexAI->>Query: return embedding vector
    Query->>VectorStore: Execute query with filters and embedding vector
    VectorStore->>Query: Return matching documents
    Query->>QueryResult: Format and redact unauthorized results
    QueryResult->>App: Results
```

**Example query:**

Querying across two projects and getting the 5 closest results to a given embedding (generated by a question):

```ruby
target_embedding = ::ActiveContext::Embeddings.generate_embeddings('the question')
query = ActiveContext::Query.filter(project_id: [1, 2]).knn(target: 'embeddings_v1', vector: target_embedding, limit: 5)
result = Ai::Context::Collections::Blobs.search(user: current_user, query: query)
```

This will return the closest matching blob *chunks*.

Adding AND and OR filters to the query:

```ruby
query = ActiveContext::Query
  .and(
    ActiveContext::Query.filter(project_id: 1),
    ActiveContext::Query.filter(branch_name: 'master'),
    ActiveContext::Query.or(
      ActiveContext::Query.filter(language: 'ruby'),
      ActiveContext::Query.filter(extension: 'rb')
    )
  )
  .knn(target: 'embeddings_v1', vector: target_embedding, limit: 5)
```

### Proposal: Index state management

#### Overview

This design proposal outlines a system to track the state of indexed namespaces and projects for Code Embeddings.

#### Database Schema

The design proposes two main tables:

##### 1. Ai::Code::EnabledNamespace

- **Purpose**: Track namespaces that should be indexed
- **Schema**:
  - References namespace (with dependent: nullify)
  - `state` (smallint) with enum values:
    - `pending`: 0
    - `ready`: 10
  - `metadata` (jsonb)

##### 2. Ai::Code::Repository

- **Purpose**: Track the indexing state of repositories
- **Schema**:
  - References project (dependent: nullify)
  - References ai_code_enabled_namespace (dependent: nullify)
  - `project_identifier` (non-nullable, non-FK column) for orphaned document deletion
  - `state` (smallint) with enum values:
    - `pending`: 0
    - `code_indexing_in_progress`: 1
    - `embedding_indexing_in_progress`: 2
    - `ready`: 10
    - `pending_deletion`: 240,
    - `deleted`: 250,
    - `failed`: 255
  - `metadata` (jsonb)
    - `last_initial_queued_item` (char)
    - `last_initial_queued_item_score` (float)
    - `reason_for_delete` (char)
    - `last_error` (char)
  - `indexed_at` (timestamp)
  - `last_commit` (char)
- **Partitioning**: Int range partitioning on `namespace_id`.

#### Process Flow

The system uses a `SchedulingService` called from a cron worker that publishes events at defined intervals. Each event has a corresponding worker that processes the event.

##### SchedulingService Tasks

1. `create_enabled_namespaces`
2. `initial_indexing`
3. `mark_repositories_as_ready`
4. `repository_should_be_marked_as_deleted`
5. `delete_repository`
6. `enabled_namespace_should_be_marked_as_deleted`

##### Main Process Flows

###### 1. Rollout

- Find eligible namespaces and create EnabledNamespace records
- Create repository records for each namespace
- Call indexer and track state
- Enqueue embedding references based on streamed response
- Mark repositories as ready when indexing completes

###### 2. Deletion (when projects or namespaces are deleted)

- Mark repositories for deletion when `project` or `namespace` becomes nil
- Call indexer to delete project documents

###### 3. License Changes

- Check for expired licenses or missing Duo licenses
- Delete EnabledNamespace records when licenses become invalid

#### Implementation Notes

- All operations are scoped to the currently active connection
- For tracking completion of initial indexing, the system stores the highest queued item and periodically checks if it exists in the queue with the same score
- The system follows a state machine pattern for tracking repository and namespace states

## Alternative Solutions

### Indexing and chunking done in Rails

Call Gitaly from rails to obtain code blobs, use a dedicated chunker in Ruby/Go/Rust to split content, enhance data with PostgreSQL, generate embeddings through the AI gateway, and index resulting vectors into the vector store.

```mermaid
sequenceDiagram
    title Direct Processing Without the Indexer
    participant Rails
    participant Gitaly
    participant Chunker
    participant PostgreSQL
    participant AIGateway
    participant VectorStore

    Rails->>Gitaly: Request code blobs
    Gitaly-->>Rails: Return code blobs
    Rails->>Chunker: Send content for chunking
    Note right of Chunker: Ruby/Go/Rust Chunker
    Chunker-->>Rails: Return code chunks
    Rails->>PostgreSQL: Get metadata for enrichment
    PostgreSQL-->>Rails: Return metadata
    Rails->>AIGateway: Request embeddings for chunks
    AIGateway-->>Rails: Return embeddings
    Rails->>VectorStore: Index chunks with embeddings
    VectorStore-->>Rails: Confirm indexing
```

### Indexing and chunking done in the Go Indexer, with the chunks returned to Rails

Use the Go-based indexer to extract and chunk code, then send the results back to Rails via stdout. Rails then enriches the data with PostgreSQL and indexes it into the vector store. Embeddings are either generated in the same process before indexing (direct) or in a separate process (deferred).

```mermaid
sequenceDiagram
    title Option 2: Indexer Returns Code and Chunks to Rails
    participant Rails
    participant Indexer
    participant PostgreSQL
    participant AIGateway
    participant VectorStore

    Rails->>Indexer: Request to extract & chunk code
    Note right of Indexer: Go-based indexer accesses<br/>Gitaly directly
    Indexer-->>Rails: Return chunks via stdout
    Rails->>PostgreSQL: Get metadata for enrichment
    PostgreSQL-->>Rails: Return metadata

    alt Direct Embedding
        Rails->>AIGateway: Request embeddings for chunks
        AIGateway-->>Rails: Return embeddings
        Rails->>VectorStore: Index chunks with embeddings
    else Deferred Embedding
        Rails->>VectorStore: Index chunks without embeddings
        Rails->>Rails: Queue embedding generation
        Rails->>AIGateway: Request embeddings (async)
        AIGateway-->>Rails: Return embeddings
        Rails->>VectorStore: Update with embeddings
    end

    VectorStore-->>Rails: Confirm indexing
```

### Pros and Cons of solutions

| Option | Pros | Cons |
|--------|------|------|
| **Option 1: Indexing and chunking done in the Go Indexer, with the chunks immediately stored in vector storage** | • More performant indexing of code<br>• Separation of concerns: indexing code and embeddings is separate<br>• Better deduplication handling for rapidly changing files | • Requires more effort to implement clients and adapters for all vector stores<br>• Makes the indexer stateful<br>• The bottleneck for indexing is still on the embedding generation side |
| **Option 2: Indexing and chunking done in Rails** | • Familiar Ruby technology for all engineers<br>• Faster implementation timeline<br> | • Slower processing for getting code blobs (up to 50x slower than Go solution)<br>• Requires building service to get blobs from Gitaly<br>|
| **Option 3: Indexing and chunking done in the Go Indexer, with the chunks returned to Rails** | • Significant performance boost for getting code from gitaly<br>• Type safety<br>• Binary is available in all self-managed installations | • Requires Go expertise for development<br>• Shared binary ownership between teams<br> |

#### Common Implementation Approach

All options

- Use the AI abstraction layer
- Process references using Sidekiq workers
- Re-enqueue failed references for retry
