<!-- Source: https://docs.umami.is/docs/api/sending-stats -->

# Sending Stats

Direct event registration via POST. No authentication required.

## Endpoint

**POST /api/send**

Cloud: `https://cloud.umami.is/api/send`

## Request

```json
{
  "payload": {
    "hostname": "your-hostname",
    "language": "en-US",
    "referrer": "",
    "screen": "1920x1080",
    "title": "Dashboard",
    "url": "/",
    "website": "your-website-id",
    "name": "event-name",
    "data": { "foo": "bar" },
    "tag": "optional-tag",
    "id": "session-id"
  },
  "type": "event"
}
```

## Response

```json
{
  "cache": "xxxxxxxxxxxxxxx",
  "sessionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "visitId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
```

## Notes

- A valid `User-Agent` HTTP header is required
- No authentication token needed
- Values can be generated programmatically from browser APIs
