<!-- Source: https://docs.honcho.dev/v3/api-reference/endpoint/peers/ -->

# Peers API

## Chat

**POST** `/v3/workspaces/{workspace_id}/peers/{peer_id}/chat`

Query a peer's representation using natural language. Performs agentic search and reasoning to comprehensively answer the query based on all latent knowledge gathered about the peer.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `peer_id` | string | Yes | Peer identifier |

### Request Body

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `query` | string | Yes | -- | Dialectic API prompt (1-10000 chars) |
| `session_id` | string or null | No | null | Session to scope representation |
| `target` | string or null | No | null | Peer ID for perspective-based query |
| `stream` | boolean | No | false | Enable response streaming |
| `reasoning_level` | string | No | low | Depth: minimal, low, medium, high, max |

### Response (200)

```json
{
  "content": "string or null"
}
```

When `stream=true`, returns `text/event-stream`.

---

## Get or Create Peer

**POST** `/v3/workspaces/{workspace_id}/peers`

Get a Peer by ID or create a new Peer with the given ID.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | The workspace identifier |

### Request Body

| Field | Type | Required | Constraints | Description |
|-------|------|----------|-------------|-------------|
| `id` | string | Yes | 1-100 chars, `^[a-zA-Z0-9_-]+$` | Peer identifier |
| `metadata` | object or null | No | -- | Optional metadata |
| `configuration` | object or null | No | -- | Optional configuration |

### Response (200)

```json
{
  "id": "string",
  "workspace_id": "string",
  "created_at": "ISO 8601 datetime",
  "metadata": {},
  "configuration": {}
}
```

---

## Get Peer Card

**GET** `/v3/workspaces/{workspace_id}/peers/{peer_id}/card`

Get a peer card for a specific peer relationship.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `peer_id` | string | Yes | ID of the observer peer |

### Query Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `target` | string or null | No | Target peer for observer's perspective. If omitted, returns own card |

### Response (200)

```json
{
  "peer_card": ["string"] or null
}
```

---

## Get Peer Context

**GET** `/v3/workspaces/{workspace_id}/peers/{peer_id}/context`

Get context for a peer, including their representation and peer card.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `peer_id` | string | Yes | ID of the observer peer |

### Query Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `target` | string or null | No | Target peer for observer's perspective |
| `search_query` | string or null | No | Semantic search query for curation |
| `search_top_k` | integer (1-100) | No | Number of semantic search results |
| `search_max_distance` | number (0-1) | No | Max semantic distance threshold |
| `include_most_frequent` | boolean | No | Include most frequent conclusions (default: true) |
| `max_conclusions` | integer (1-100) | No | Max conclusions in representation |

### Response (200)

```json
{
  "peer_id": "string",
  "target_id": "string",
  "representation": "string or null",
  "peer_card": ["string"] or null
}
```

---

## Get Peers (List)

**POST** `/v3/workspaces/{workspace_id}/peers/list`

Get all Peers for a Workspace, paginated with optional filters.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |

### Query Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `page` | integer | 1 | Page number (min: 1) |
| `size` | integer | 50 | Page size (1-100) |

### Request Body

```json
{
  "filters": {}
}
```

### Response (200)

```json
{
  "items": [
    {
      "id": "string",
      "workspace_id": "string",
      "created_at": "ISO 8601",
      "metadata": {},
      "configuration": {}
    }
  ],
  "total": 0,
  "page": 1,
  "size": 50,
  "pages": 0
}
```

---

## Get Representation

**POST** `/v3/workspaces/{workspace_id}/peers/{peer_id}/representation`

Get a curated subset of a Peer's Representation.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `peer_id` | string | Yes | Peer identifier |

### Request Body

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `session_id` | string or null | No | Scope representation to session |
| `target` | string or null | No | Peer ID for perspective-based view |
| `search_query` | string or null | No | Semantic search curation |
| `search_top_k` | integer (1-100) | No | Number of semantic results |
| `search_max_distance` | number (0-1) | No | Max semantic distance |
| `include_most_frequent` | boolean | No | Include frequent conclusions |
| `max_conclusions` | integer (1-100) | No | Max conclusions (default: 25) |

### Response (200)

```json
{
  "representation": "string"
}
```

---

## Get Sessions for Peer

**POST** `/v3/workspaces/{workspace_id}/peers/{peer_id}/sessions`

Retrieve all Sessions associated with a Peer.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `peer_id` | string | Yes | Peer identifier |

### Query Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `page` | integer | 1 | Page number (min: 1) |
| `size` | integer | 50 | Page size (1-100) |

### Request Body

```json
{
  "filters": {}
}
```

### Response (200)

```json
{
  "items": [
    {
      "id": "string",
      "is_active": true,
      "workspace_id": "string",
      "metadata": {},
      "configuration": {},
      "created_at": "ISO 8601"
    }
  ],
  "total": 0,
  "page": 1,
  "size": 50,
  "pages": 0
}
```

---

## Search Peer

**POST** `/v3/workspaces/{workspace_id}/peers/{peer_id}/search`

Search a Peer's messages, optionally filtered by various criteria.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `peer_id` | string | Yes | Peer identifier |

### Request Body

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `query` | string | Yes | -- | Search query |
| `filters` | object or null | No | null | Filters to scope the search |
| `limit` | integer | No | 10 | Number of results (1-100) |

### Response (200)

Returns an array of Message objects.

---

## Set Peer Card

**PUT** `/v3/workspaces/{workspace_id}/peers/{peer_id}/card`

Sets the peer card that the observer peer has for the target peer. If no target is specified, sets the observer's own peer card.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `peer_id` | string | Yes | Observer peer identifier |

### Query Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `target` | string or null | No | Target peer identifier |

### Request Body

```json
{
  "peer_card": ["string"]
}
```

### Response (200)

```json
{
  "peer_card": ["string"] or null
}
```

---

## Update Peer

**PUT** `/v3/workspaces/{workspace_id}/peers/{peer_id}`

Update a Peer's metadata and/or configuration.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `peer_id` | string | Yes | Peer identifier |

### Request Body

| Property | Type | Description |
|----------|------|-------------|
| `metadata` | object or null | Custom metadata |
| `configuration` | object or null | Configuration settings |

### Response (200)

Returns the updated Peer object.
