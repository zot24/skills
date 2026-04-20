<!-- Source: https://docs.umami.is/docs/api/admin -->

# Admin API

Admin-only endpoints for self-hosted instances. Not available on Umami Cloud.

## Endpoints

### GET /api/admin/users

List all system users.

**Parameters:** `search`, `page` (default: 1), `pageSize` (default: 20)

**Response:** User ID, username, role, logo URL, display name, timestamps, website count.

### GET /api/admin/websites

List all websites in the system.

**Parameters:** `search`, `page` (default: 1), `pageSize` (default: 20)

**Response:** Website ID, name, domain, share ID, owner user info, team association, timestamps.

### GET /api/admin/teams

List all teams with member information.

**Parameters:** `search`, `page` (default: 1), `pageSize` (default: 20)

**Response:** Team ID, name, access code, logo, members with roles, website count, member count.
