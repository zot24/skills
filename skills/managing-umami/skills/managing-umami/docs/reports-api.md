<!-- Source: https://docs.umami.is/docs/api/reports -->

# Reports API

## Core Endpoints

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/api/reports` | List all reports |
| POST | `/api/reports` | Create a report |
| GET | `/api/reports/:reportId` | Get specific report |
| POST | `/api/reports/:reportId` | Update a report |
| DELETE | `/api/reports/:reportId` | Delete a report |

## Specialized Report Endpoints

```
POST /api/reports/attribution    — Marketing attribution (first/last click)
POST /api/reports/breakdown      — Segment data by multiple dimensions
POST /api/reports/funnel         — Track conversion funnels
POST /api/reports/goal           — Monitor goal conversions
POST /api/reports/journey        — Analyze user navigation paths
POST /api/reports/performance    — Core Web Vitals (LCP, INP, CLS, FCP, TTFB)
POST /api/reports/retention      — User return rate analysis
POST /api/reports/revenue        — Revenue and transaction data
POST /api/reports/utm            — UTM parameter tracking
```

## Request Structure

```json
{
  "websiteId": "uuid",
  "type": "attribution|breakdown|funnel|goal|journey|retention|revenue|utm",
  "filters": { "os": "Mac OS", "device": "desktop" },
  "parameters": {
    "startDate": "2025-10-19T07:00:00.000Z",
    "endDate": "2025-10-26T06:59:59.999Z",
    "timezone": "America/Los_Angeles"
  }
}
```

## Report Types

### Attribution
Identifies traffic sources and conversion paths. Supports first-click and last-click models.

### Breakdown
Dimensional analysis with metrics (views, visitors, bounces, time) across selected fields.

### Funnel
Measures conversion rates across sequential URL steps with configurable time windows (days).

### Goal
Tracks conversions for specific paths or events, returning count and total volume.

### Journey
Maps multi-step user navigation flows. Configurable step count (3-7 steps).

### Performance
Returns Core Web Vitals at p50, p75, p95 percentiles:
- **LCP** — Largest Contentful Paint
- **INP** — Interaction to Next Paint
- **CLS** — Cumulative Layout Shift
- **FCP** — First Contentful Paint
- **TTFB** — Time to First Byte

### Retention
Analyzes user return behavior across days, showing return visitor percentages.

### Revenue
Aggregates transaction data by currency with comparisons and channel/referrer breakdowns.

### UTM
Segments traffic by UTM source, medium, campaign, term, and content parameters.

## Filtering

All report endpoints support filtering by: path, referrer, title, query, browser, OS, device, country, region, city, language, hostname, tags, events, distinct IDs, UTM params, segments, cohorts.
