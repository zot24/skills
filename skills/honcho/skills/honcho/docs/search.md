<!-- Source: https://docs.honcho.dev/v3/documentation/features/advanced/search -->

# Search

## Overview

Honcho provides search capabilities across workspaces, sessions, and peers. The feature enables discovery of relevant messages and conversations at different organizational levels.

## Search Scopes

**Workspace Search:** Query across all content including sessions, peers, and messages throughout your entire workspace.

**Session Search:** Restrict searches to a particular session's conversation history using a session object.

**Peer Search:** Find all content associated with a specific peer across all their interactions.

## Key Parameters

The `limit` parameter controls result quantity, with a default of 10 and maximum of 100 results.

## Available Filters

Searches support filtering by:
- `session_id`: Combine peer-level searches with specific sessions
- `created_at`: Use date ranges with `gte` and `lte` operators
- `metadata`: Filter using custom metadata key-value pairs

## Response Structure

Search returns an object with an items array containing message objects. Each message includes: id, content, peer_id, session_id, metadata, created_at, workspace_id, and token_count.

## Implementation Notes

Both Python and TypeScript SDKs support search operations with similar syntax patterns. The documentation emphasizes checking for empty results and handling them gracefully before processing. Combining search with context-building enables creating context-aware applications based on historical conversation data.
