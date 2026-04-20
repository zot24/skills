<!-- Source: https://docs.umami.is/docs/api/realtime -->

# Realtime API

Live analytics data showing statistics from the last 30 minutes.

## Endpoint

**GET /api/realtime/:websiteId**

## Response Structure

```json
{
  "countries": { "US": 9, "DE": 3 },
  "urls": { "/": 43, "/about": 12 },
  "referrers": { "umami.is": 31 },
  "events": [
    {
      "__type": "pageview",
      "sessionId": "uuid",
      "eventName": null,
      "createdAt": "2025-01-01T00:00:00.000Z",
      "browser": "chrome",
      "os": "Mac OS",
      "device": "desktop",
      "country": "US",
      "urlPath": "/",
      "referrerDomain": "google.com"
    }
  ],
  "series": {
    "views": [{ "x": 1704067200000, "y": 5 }],
    "visitors": [{ "x": 1704067200000, "y": 3 }]
  },
  "totals": {
    "views": 120,
    "visitors": 45,
    "events": 8,
    "countries": 12
  },
  "timestamp": 1704067200000
}
```

Authentication required.
