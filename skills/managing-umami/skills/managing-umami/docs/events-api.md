<!-- Source: https://docs.umami.is/docs/api/events -->

# Events API

## Endpoints

```
GET /api/websites/:id/events              — Event records with pagination
GET /api/websites/:id/events/stats        — Aggregated event statistics
GET /api/websites/:id/event-data          — Event data grouped by name
GET /api/websites/:id/event-data/:eventId — Full event-level data
GET /api/websites/:id/event-data/events   — Event data events
GET /api/websites/:id/event-data/fields   — Event data fields
GET /api/websites/:id/event-data/properties — Event data properties
GET /api/websites/:id/event-data/values   — Event data values
GET /api/websites/:id/event-data/stats    — Event data statistics
```

## GET /api/websites/:id/events

**Parameters:**
- `startAt` (number) — Start timestamp in ms
- `endAt` (number) — End timestamp in ms
- `search` (string) — Text search
- `page` (number) — Page number
- `pageSize` (number, default: 20) — Results per page
- `filters` (object) — Advanced filtering

## GET /api/websites/:id/events/stats

Aggregated statistics with optional period comparison.

**Parameters:**
- `startAt`, `endAt` — Required timestamps
- `compare` — `prev` (previous period) or `yoy` (year over year)
- `filters` — Optional filter parameters

## Filtering

All endpoints support filtering by: path, referrer, title, query, browser, OS, device, country, region, city, language, hostname, tags, event names, distinct IDs, UTM parameters, segments, and cohorts.
