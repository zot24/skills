<!-- Source: https://docs.honcho.dev/v3/api-reference/endpoint/messages/ -->

# Messages API

## Create Messages For Session

**POST** `/v3/workspaces/{workspace_id}/sessions/{session_id}/messages`

Add new message(s) to a session.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |

### Request Body

```json
{
  "messages": [
    {
      "content": "string (0-25000 chars)",
      "peer_id": "string",
      "metadata": {},
      "configuration": {
        "reasoning": {
          "enabled": true,
          "custom_instructions": "string"
        }
      },
      "created_at": "ISO 8601 date-time"
    }
  ]
}
```

**Constraints:**
- `messages` array: minimum 1, maximum 100 items
- `content`: 0-25,000 characters
- `peer_id`: required
- `metadata`, `configuration`, `created_at`: optional

### Response (201 Created)

```json
[
  {
    "id": "string",
    "content": "string",
    "peer_id": "string",
    "session_id": "string",
    "metadata": {},
    "created_at": "ISO 8601 date-time",
    "workspace_id": "string",
    "token_count": 0
  }
]
```

---

## Create Messages With File

**POST** `/v3/workspaces/{workspace_id}/sessions/{session_id}/messages/upload`

Create messages from uploaded files. Files are converted to text and split into multiple messages.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |

### Request Body (multipart/form-data)

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `file` | binary | Yes | File to upload |
| `peer_id` | string | Yes | Peer identifier |
| `metadata` | string | No | Optional metadata |
| `configuration` | string | No | Optional configuration |
| `created_at` | string | No | Optional timestamp |

### Response (201 Created)

Returns an array of Message objects.

---

## Get Message

**GET** `/v3/workspaces/{workspace_id}/sessions/{session_id}/messages/{message_id}`

Get a single message by ID from a Session.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |
| `message_id` | string | Yes | Message identifier |

### Response (200)

```json
{
  "id": "string",
  "content": "string",
  "peer_id": "string",
  "session_id": "string",
  "metadata": {},
  "created_at": "ISO 8601 date-time",
  "workspace_id": "string",
  "token_count": 0
}
```

---

## Get Messages (List)

**POST** `/v3/workspaces/{workspace_id}/sessions/{session_id}/messages/list`

Get all messages for a Session with optional filters. Results are paginated.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |

### Query Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `reverse` | boolean | false | Reverse order of results |
| `page` | integer | 1 | Page number (minimum: 1) |
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
      "content": "string",
      "peer_id": "string",
      "session_id": "string",
      "metadata": {},
      "created_at": "ISO 8601 date-time",
      "workspace_id": "string",
      "token_count": 0
    }
  ],
  "total": 0,
  "page": 1,
  "size": 50,
  "pages": 0
}
```

---

## Update Message

**PUT** `/v3/workspaces/{workspace_id}/sessions/{session_id}/messages/{message_id}`

Update a message's metadata.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `session_id` | string | Yes | Session identifier |
| `message_id` | string | Yes | Message identifier |

### Request Body

```json
{
  "metadata": {}
}
```

The `metadata` field accepts an object or null.

### Response (200)

Returns the updated Message object.
