<!-- Source: https://docs.umami.is/docs/api/share -->

# Share API

Manage share pages for analytics dashboards.

## Endpoints

| Endpoint | Purpose |
|----------|---------|
| `POST /api/share` | Create a share page |
| `GET /api/share/id/:shareId` | Get share page |
| `POST /api/share/id/:shareId` | Update share page |
| `DELETE /api/share/id/:shareId` | Delete share page |
| `GET /api/websites/:id/shares` | List website shares |
| `POST /api/websites/:id/shares` | Create website share |

## Creating a Share Page

**POST /api/share**

**Parameters:**
- `entityId` (string) — ID of entity (websiteId, pixelId, linkId, etc.)
- `shareType` (number) — 1: website, 2: link, 3: pixel, 4: board
- `name` (string) — Display name
- `slug` (string) — URL-friendly identifier
- `parameters` (object) — Feature toggles (overview, events, etc.)

## Updating

**POST /api/share/id/:shareId** — Accepts `name`, `slug`, and `parameters`.

## Deletion

**DELETE /api/share/id/:shareId** — Returns `{"ok": true}`.
