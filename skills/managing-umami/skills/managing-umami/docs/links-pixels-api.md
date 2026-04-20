<!-- Source: https://docs.umami.is/docs/api/links + https://docs.umami.is/docs/api/pixels -->

# Links & Pixels API

## Links API

Manage short URL redirects.

| Endpoint | Purpose |
|----------|---------|
| `GET /api/links` | List all links |
| `POST /api/links` | Create link (`name`, `url`, `slug` required, slug min 8 chars) |
| `GET /api/links/:linkId` | Get link |
| `POST /api/links/:linkId` | Update link |
| `DELETE /api/links/:linkId` | Delete link |

**Create/Update params:** `name`, `url`, `slug` (8+ chars), `teamId` (optional)

**List params:** `search`, `page`, `pageSize`

## Pixels API

Manage tracking pixels.

| Endpoint | Purpose |
|----------|---------|
| `GET /api/pixels` | List all pixels |
| `POST /api/pixels` | Create pixel (`name`, `slug` required, slug min 8 chars) |
| `GET /api/pixels/:pixelId` | Get pixel |
| `POST /api/pixels/:pixelId` | Update pixel |
| `DELETE /api/pixels/:pixelId` | Delete pixel |

**Create/Update params:** `name`, `slug` (8+ chars), `teamId` (optional)

**List params:** `search`, `page`, `pageSize`

Both return `{"ok": true}` on successful deletion.
