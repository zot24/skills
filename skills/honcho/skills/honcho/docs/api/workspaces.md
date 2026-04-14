<!-- Source: https://docs.honcho.dev/v3/api-reference/endpoint/workspaces/ -->

# Workspaces API

## Get or Create Workspace

**POST** `/v3/workspaces`

Get a Workspace by ID or create a new one.

### Request Body

| Field | Type | Required | Constraints | Description |
|-------|------|----------|-------------|-------------|
| `id` | string | Yes | 1-100 chars, `^[a-zA-Z0-9_-]+$` | Workspace identifier |
| `metadata` | object | No | -- | Custom metadata |
| `configuration` | WorkspaceConfiguration | No | -- | Workspace configuration |

### Response (200)

```json
{
  "id": "string",
  "metadata": {},
  "configuration": {},
  "created_at": "ISO 8601 datetime"
}
```

---

## Get All Workspaces

**POST** `/v3/workspaces/list`

List all workspaces with pagination and optional filters.

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

Paginated list of Workspace objects.

---

## Update Workspace

**PUT** `/v3/workspaces/{workspace_id}`

Update Workspace metadata and/or configuration.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |

### Request Body

| Field | Type | Description |
|-------|------|-------------|
| `metadata` | object or null | Custom metadata |
| `configuration` | WorkspaceConfiguration or null | Workspace configuration (reasoning, peer_card, summary, dream) |

### Response (200)

Returns updated Workspace object.

---

## Delete Workspace

**DELETE** `/v3/workspaces/{workspace_id}`

Delete a workspace and all associated data. Returns 409 Conflict if workspace contains active sessions. Delete all sessions first, then delete the workspace. This action cannot be undone.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |

### Response (202 Accepted)

Returns empty object. Actual deletion occurs asynchronously.

---

## Get Queue Status

**GET** `/v3/workspaces/{workspace_id}/queue/status`

Monitor background processing status. Only tracks user-facing task types (representation, summary, dream).

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |

### Query Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `observer_id` | string or null | No | Filter by observer |
| `sender_id` | string or null | No | Filter by sender |
| `session_id` | string or null | No | Filter by session |

### Response (200)

```json
{
  "total_work_units": 0,
  "completed_work_units": 0,
  "in_progress_work_units": 0,
  "pending_work_units": 0,
  "sessions": {}
}
```

---

## Schedule Dream

**POST** `/v3/workspaces/{workspace_id}/schedule_dream`

Manually schedule a dream task for a specific collection. Bypasses automatic dream conditions.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |

### Request Body

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `observer` | string | Yes | Observer peer name |
| `observed` | string or null | No | Observed peer (defaults to observer) |
| `dream_type` | string | Yes | Dream type (e.g., `omni`) |
| `session_id` | string or null | No | Session to scope the dream |

### Response (204 No Content)

---

## Search Workspace

**POST** `/v3/workspaces/{workspace_id}/search`

Search messages across the entire workspace.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |

### Request Body

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `query` | string | Yes | -- | Search query |
| `filters` | object or null | No | -- | Scoping filters |
| `limit` | integer | No | 10 | Results count (1-100) |

### Response (200)

Returns an array of Message objects.
