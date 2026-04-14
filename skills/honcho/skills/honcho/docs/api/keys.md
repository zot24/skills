<!-- Source: https://docs.honcho.dev/v3/api-reference/endpoint/keys/create-key -->

# Keys API

## Create Key

**POST** `/v3/keys`

Create a new API key for the Honcho platform.

### Query Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `workspace_id` | string or null | No | ID of the workspace to scope the key to |
| `peer_id` | string or null | No | ID of the peer to scope the key to |
| `session_id` | string or null | No | ID of the session to scope the key to |
| `expires_at` | string (date-time) or null | No | Expiration timestamp for the key |

### Request Body

No request body required.

### Response (200)

Returns the created key object.

### Authentication

Supports HTTPBearer token authentication.
