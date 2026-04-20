<!-- Source: https://docs.umami.is/docs/api/sessions -->

# Sessions API

## Endpoints

| Endpoint | Purpose |
|----------|---------|
| `GET /api/websites/:id/sessions` | Session list with pagination |
| `GET /api/websites/:id/sessions/stats` | Session summary statistics |
| `GET /api/websites/:id/sessions/weekly` | Sessions by hour of weekday |
| `GET /api/websites/:id/sessions/:sessionId` | Individual session details |
| `GET /api/websites/:id/sessions/:sessionId/activity` | Session activity events |
| `GET /api/websites/:id/sessions/:sessionId/properties` | Session custom properties |
| `GET /api/websites/:id/session-data/properties` | Property names with counts |
| `GET /api/websites/:id/session-data/values` | Property values with counts |

## GET /api/websites/:id/sessions

**Parameters:** `startAt`, `endAt`, `search`, `page` (default: 1), `pageSize` (default: 20), `filters`

**Response:**
```json
{
  "data": [{
    "id": "uuid",
    "websiteId": "uuid",
    "hostname": "example.com",
    "browser": "chrome",
    "os": "Mac OS",
    "device": "desktop",
    "country": "SE",
    "visits": 2,
    "views": 18
  }],
  "count": 923,
  "page": 1,
  "pageSize": 20
}
```

## GET /api/websites/:id/sessions/stats

**Response metrics:** `pageviews`, `visitors`, `visits`, `countries`, `events`

## GET /api/websites/:id/sessions/weekly

Returns 7-element array (days) × 24-element arrays (hours) with session counts.

**Parameters:** `startAt`, `endAt`, `timezone`, `filters`

## Session Detail

`GET /sessions/:sessionId` returns device, browser, OS, language, geographic data, and engagement metrics (visits, views, events, total time).

`GET /sessions/:sessionId/activity` returns array of `{ createdAt, urlPath, eventType, eventName }`.

## Filtering

All filter-supporting endpoints accept: path, referrer, title, query, browser, os, device, country, region, city, language, hostname, tag, event, distinctId, UTM params, segment, cohort.
