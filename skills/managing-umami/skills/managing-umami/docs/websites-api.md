<!-- Source: https://docs.umami.is/docs/api/websites -->

# Websites API

Website management and statistics operations.

## Endpoints

### GET /api/websites

Retrieves all user websites.

**Parameters:**
- `includeTeams` (boolean) — Include team-owned websites
- `search` (string) — Search text
- `page` (number, default: 1) — Page number
- `pageSize` (number) — Results per page

**Response:** Array of website objects with id, name, domain, shareId, resetAt, userId, teamId, createdBy, timestamps, and user details.

### POST /api/websites

Creates a new website.

**Parameters:**
- `name` (string, required) — Website name
- `domain` (string, required) — Full domain
- `shareId` (string) — Unique string for share URL
- `teamId` (string) — Team ownership
- `id` (string) — Force UUID assignment

### GET /api/websites/:websiteId

Retrieves a specific website by ID.

### POST /api/websites/:websiteId

Updates an existing website.

**Parameters:**
- `name` (string) — Updated name
- `domain` (string) — Updated domain
- `shareId` (string) — Set `null` to unshare

### DELETE /api/websites/:websiteId

Removes a website. Returns `{"ok": true}`.

### POST /api/websites/:websiteId/reset

Removes all data for a website. Returns `{"ok": true}`.
