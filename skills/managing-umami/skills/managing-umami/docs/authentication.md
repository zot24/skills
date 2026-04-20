<!-- Source: https://docs.umami.is/docs/api/authentication -->

# Authentication

## Self-Hosted

### POST /api/auth/login

```json
{
  "username": "your-username",
  "password": "your-password"
}
```

**Response:**
```json
{
  "token": "eyTMjU2IiwiY...4Q0JDLUhWxnIjoiUE_A",
  "user": {
    "id": "uuid",
    "username": "admin",
    "role": "admin",
    "createdAt": "2025-01-01T00:00:00.000Z",
    "isAdmin": true
  }
}
```

**Usage:**
```bash
curl https://your-umami.com/api/websites \
  -H "Accept: application/json" \
  -H "Authorization: Bearer <token>"
```

### POST /api/auth/verify

Validates whether a token is still active. Returns user details including id, username, role, createdAt, isAdmin, and associated teams.

## Umami Cloud

Cloud uses API keys instead of login tokens. Generate an API key from the Cloud dashboard and pass it in the `x-umami-api-key` header or use the API client environment variable `UMAMI_API_KEY`.

## API Base URLs

- **Self-hosted**: `http://<your-instance>/api`
- **Umami Cloud**: `https://api.umami.is`

All data is returned in JSON format.
