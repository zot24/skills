<!-- Source: https://docs.umami.is/docs/api/website-stats -->

# Website Statistics API

## Endpoints

| Endpoint | Purpose |
|----------|---------|
| `GET /api/websites/:id/active` | Active users (last 5 min) |
| `GET /api/websites/:id/daterange` | Data availability date range |
| `GET /api/websites/:id/events/series` | Time-series event data |
| `GET /api/websites/:id/metrics` | Aggregated metrics by type |
| `GET /api/websites/:id/metrics/expanded` | Detailed metrics with engagement |
| `GET /api/websites/:id/pageviews` | Pageview and session trends |
| `GET /api/websites/:id/stats` | Summary statistics |

## Common Query Parameters

**Time:**
- `startAt` (number) — Start timestamp in milliseconds
- `endAt` (number) — End timestamp in milliseconds
- `unit` (string) — `minute`, `hour`, `day`, `month`, or `year`
- `timezone` (string) — e.g., `America/Los_Angeles`

**Filtering:** Supports 22+ filter params including `path`, `referrer`, `browser`, `os`, `country`, `city`, UTM fields, `segment`, `cohort`.

## Response Examples

### Active Users
```json
{"visitors": 5}
```

### Metrics
```json
[
  {"x": "Mac OS", "y": 1918},
  {"x": "Windows 10", "y": 1413}
]
```

### Pageviews
Contains `pageviews` and `sessions` arrays with timestamp (`x`) and count (`y`) pairs.

### Summary Stats
Includes `pageviews`, `visitors`, `visits`, `bounces`, `totaltime`, and optional comparison data.
