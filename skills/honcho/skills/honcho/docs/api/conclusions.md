<!-- Source: https://docs.honcho.dev/v3/api-reference/endpoint/conclusions/ -->

# Conclusions API

## Create Conclusions

**POST** `/v3/workspaces/{workspace_id}/conclusions`

Create one or more Conclusions. Conclusions are logical certainties derived from interactions between Peers. They form the basis of a Peer's Representation.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | The workspace identifier |

### Request Body

```json
{
  "conclusions": [
    {
      "content": "string (1-65535 characters)",
      "observer_id": "string (required)",
      "observed_id": "string (required)",
      "session_id": "string or null (optional)"
    }
  ]
}
```

**Constraints:**
- `conclusions` array: minimum 1 item, maximum 100 items
- `content`: required, 1-65535 characters
- `observer_id`: required (peer making the conclusion)
- `observed_id`: required (peer conclusion is about)
- `session_id`: optional

### Response (201 Created)

```json
[
  {
    "id": "string",
    "content": "string",
    "observer_id": "string",
    "observed_id": "string",
    "session_id": "string or null",
    "created_at": "ISO 8601 datetime"
  }
]
```

---

## Delete Conclusion

**DELETE** `/v3/workspaces/{workspace_id}/conclusions/{conclusion_id}`

Delete a single Conclusion by ID. This action cannot be undone.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | The workspace identifier |
| `conclusion_id` | string | Yes | The conclusion identifier |

### Response (204 No Content)

Successful deletion returns no response body.

---

## List Conclusions

**POST** `/v3/workspaces/{workspace_id}/conclusions/list`

List Conclusions using optional filters, ordered by recency unless `reverse` is true.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | The workspace identifier |

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
      "observer_id": "string",
      "observed_id": "string",
      "session_id": "string or null",
      "created_at": "2024-01-01T00:00:00Z"
    }
  ],
  "total": 0,
  "page": 1,
  "size": 50,
  "pages": 0
}
```

---

## Query Conclusions

**POST** `/v3/workspaces/{workspace_id}/conclusions/query`

Query Conclusions using semantic search. Use `top_k` to control the number of results.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | The workspace identifier |

### Request Body

| Property | Type | Required | Default | Constraints | Description |
|----------|------|----------|---------|-------------|-------------|
| `query` | string | Yes | -- | -- | Semantic search query |
| `top_k` | integer | No | 10 | min: 1, max: 100 | Number of results returned |
| `distance` | number or null | No | null | min: 0, max: 1 | Maximum cosine distance threshold |
| `filters` | object or null | No | null | -- | Additional filters to apply |

### Response (200)

Returns an array of Conclusion objects:

```json
[
  {
    "id": "string",
    "content": "string",
    "observer_id": "string",
    "observed_id": "string",
    "session_id": "string or null",
    "created_at": "ISO 8601 datetime"
  }
]
```
