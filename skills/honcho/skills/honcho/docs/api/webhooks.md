<!-- Source: https://docs.honcho.dev/v3/api-reference/endpoint/webhooks/ -->

# Webhooks API

## Get or Create Webhook Endpoint

**POST** `/v3/workspaces/{workspace_id}/webhooks`

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |

### Request Body

```json
{
  "url": "string"
}
```

### Response (200)

```json
{
  "id": "string",
  "workspace_id": "string or null",
  "url": "string",
  "created_at": "ISO 8601 datetime"
}
```

---

## List Webhook Endpoints

**GET** `/v3/workspaces/{workspace_id}/webhooks`

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |

### Query Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `page` | integer | 1 | Page number (min: 1) |
| `size` | integer | 50 | Page size (1-100) |

### Response (200)

```json
{
  "items": [
    {
      "id": "string",
      "workspace_id": "string or null",
      "url": "string",
      "created_at": "ISO 8601 datetime"
    }
  ],
  "total": 0,
  "page": 1,
  "size": 50,
  "pages": 0
}
```

---

## Delete Webhook Endpoint

**DELETE** `/v3/workspaces/{workspace_id}/webhooks/{endpoint_id}`

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |
| `endpoint_id` | string | Yes | Webhook endpoint ID |

### Response (204 No Content)

---

## Test Emit

**GET** `/v3/workspaces/{workspace_id}/webhooks/test`

Test publishing a webhook event.

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string | Yes | Workspace identifier |

### Response (200)

Returns empty object.
