<!-- Source: https://docs.honcho.dev/v3/api-reference/endpoint/sessions/ -->

# Sessions API

## Add Peers to Session

**POST** `/v3/workspaces/{workspace_id}/sessions/{session_id}/peers`

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |

### Request Body

Object with peer IDs as keys and SessionPeerConfig objects as values:

```json
{
  "peer-id": {
    "observe_me": true,
    "observe_others": false
  }
}
```

### Response (200)

Returns the updated Session object.

---

## Clone Session

**POST** `/v3/workspaces/{workspace_id}/sessions/{session_id}/clone`

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |

### Query Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `message_id` | string or null | No | Message ID to cut off the clone at |

### Response (201 Created)

Returns the cloned Session object.

---

## Delete Session

**DELETE** `/v3/workspaces/{workspace_id}/sessions/{session_id}`

Delete a Session and all associated messages. The Session is marked as inactive immediately and returns 202 Accepted. Actual data removal occurs asynchronously. This operation cannot be reversed.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |

### Response (202 Accepted)

Returns empty object.

---

## Get or Create Session

**POST** `/v3/workspaces/{workspace_id}/sessions`

Get a Session by ID or create a new Session with the given ID.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |

### Request Body

| Field | Type | Required | Constraints | Description |
|-------|------|----------|-------------|-------------|
| `id` | string | Yes | 1-100 chars, `^[a-zA-Z0-9_-]+$` | Session identifier |
| `metadata` | object | No | -- | Custom metadata |
| `peers` | object | No | -- | Peer configuration mapping |
| `configuration` | SessionConfiguration | No | -- | Session-level settings |

### SessionConfiguration Object

| Field | Type | Description |
|-------|------|-------------|
| `reasoning` | ReasoningConfiguration | Reasoning functionality config |
| `peer_card` | PeerCardConfiguration | Peer card functionality config |
| `summary` | SummaryConfiguration | Summary functionality config |
| `dream` | DreamConfiguration | Dream functionality config |

### Response (200)

Returns the Session object.

---

## Get Peer Config

**GET** `/v3/workspaces/{workspace_id}/sessions/{session_id}/peers/{peer_id}/config`

Retrieve configuration settings for a specific Peer within a Session.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |
| `peer_id` | string | Yes | Peer identifier |

### Response (200)

```json
{
  "observe_me": true,
  "observe_others": false
}
```

---

## Get Session Context

**GET** `/v3/workspaces/{workspace_id}/sessions/{session_id}/context`

Produce a context object from the Session. The caller provides an optional token limit which the entire context must fit into. Allocates 40% of tokens to summary and 60% to recent messages.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |

### Query Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `tokens` | integer | None | Token limit (max 100,000) |
| `search_query` | string | None | Semantic search query for conclusions |
| `summary` | boolean | true | Include summary |
| `peer_target` | string | None | Peer for perspective context |
| `peer_perspective` | string | None | Perspective peer (requires peer_target) |
| `limit_to_session` | boolean | false | Limit representation to session |
| `search_top_k` | integer | None | Semantic results count (1-100) |
| `search_max_distance` | number | None | Max semantic distance (0-1) |
| `include_most_frequent` | boolean | false | Include frequent conclusions |
| `max_conclusions` | integer | None | Max conclusions (1-100) |

### Response (200)

```json
{
  "id": "string",
  "messages": [
    {
      "id": "string",
      "content": "string",
      "peer_id": "string",
      "session_id": "string",
      "metadata": {},
      "created_at": "ISO 8601",
      "workspace_id": "string",
      "token_count": 0
    }
  ],
  "summary": {
    "content": "string",
    "message_id": "string",
    "summary_type": "string",
    "created_at": "ISO 8601",
    "token_count": 0
  },
  "peer_representation": "string",
  "peer_card": ["string"]
}
```

---

## Get Session Peers

**GET** `/v3/workspaces/{workspace_id}/sessions/{session_id}/peers`

Get all Peers in a Session. Results are paginated.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |

### Query Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `page` | integer | 1 | Page number (min: 1) |
| `size` | integer | 50 | Page size (1-100) |

### Response (200)

Paginated list of Peer objects.

---

## Get Session Summaries

**GET** `/v3/workspaces/{workspace_id}/sessions/{session_id}/summaries`

Retrieve available summaries for a session.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |

### Response (200)

```json
{
  "id": "string",
  "short_summary": {
    "content": "string",
    "message_id": "string",
    "summary_type": "string",
    "created_at": "ISO 8601",
    "token_count": 0
  },
  "long_summary": {
    "content": "string",
    "message_id": "string",
    "summary_type": "string",
    "created_at": "ISO 8601",
    "token_count": 0
  }
}
```

Both `short_summary` and `long_summary` may be `null`.

---

## Get Sessions (List)

**POST** `/v3/workspaces/{workspace_id}/sessions/list`

Get all Sessions for a Workspace, paginated with optional filters.

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

Paginated list of Session objects.

---

## Remove Peers from Session

**DELETE** `/v3/workspaces/{workspace_id}/sessions/{session_id}/peers`

Remove Peers by ID from a Session.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |

### Request Body

Array of peer ID strings:
```json
["peer-id-1", "peer-id-2"]
```

### Response (200)

Returns the updated Session object.

---

## Search Session

**POST** `/v3/workspaces/{workspace_id}/sessions/{session_id}/search`

Search messages within a session.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |

### Request Body

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `query` | string | Yes | -- | Search query text |
| `filters` | object or null | No | -- | Scoping filters |
| `limit` | integer | No | 10 | Results count (1-100) |

### Response (200)

Returns an array of Message objects.

---

## Set Peer Config

**PUT** `/v3/workspaces/{workspace_id}/sessions/{session_id}/peers/{peer_id}/config`

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |
| `peer_id` | string | Yes | Peer identifier |

### Request Body

```json
{
  "observe_me": true,
  "observe_others": false
}
```

### Response (204 No Content)

---

## Set Session Peers

**PUT** `/v3/workspaces/{workspace_id}/sessions/{session_id}/peers`

Set the Peers in a Session. If a Peer does not yet exist, it will be created automatically. Fully replaces existing peers.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |

### Request Body

Object with peer IDs as keys and SessionPeerConfig as values:
```json
{
  "peer-id": {
    "observe_me": true,
    "observe_others": false
  }
}
```

### Response (200)

Returns the updated Session object.

---

## Update Session

**PUT** `/v3/workspaces/{workspace_id}/sessions/{session_id}`

Update a Session's metadata and/or configuration.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |

### Request Body

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `metadata` | object or null | No | Custom metadata |
| `configuration` | SessionConfiguration or null | No | Session configuration |

### SessionConfiguration Schema

| Field | Type | Description |
|-------|------|-------------|
| `reasoning.enabled` | boolean | Enable reasoning |
| `reasoning.custom_instructions` | string | Custom instructions |
| `peer_card.use` | boolean | Use peer cards during reasoning |
| `peer_card.create` | boolean | Generate peer cards from content |
| `summary.enabled` | boolean | Enable summarization |
| `summary.messages_per_short_summary` | integer (>=10) | Messages per short summary |
| `summary.messages_per_long_summary` | integer (>=20) | Messages per long summary |
| `dream.enabled` | boolean | Enable dreaming |

### Response (200)

Returns the updated Session object.
