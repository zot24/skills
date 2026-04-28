> Source: https://docs.firecrawl.dev/api-reference/endpoint/browser-list.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# List Browser Sessions

> Retrieve a list of all browser sessions, optionally filtered by status.

## Headers

| Header          | Value              |
| --------------- | ------------------ |
| `Authorization` | `Bearer <API_KEY>` |

## Query Parameters

| Parameter | Type   | Required | Description                                           |
| --------- | ------ | -------- | ----------------------------------------------------- |
| `status`  | string | No       | Filter by session status: `"active"` or `"destroyed"` |

## Response

| Field      | Type    | Description                   |
| ---------- | ------- | ----------------------------- |
| `success`  | boolean | Whether the request succeeded |
| `sessions` | array   | List of session objects       |

### Session Object

| Field                    | Type   | Description                                                         |
| ------------------------ | ------ | ------------------------------------------------------------------- |
| `id`                     | string | Unique session identifier                                           |
| `status`                 | string | Current session status (`"active"` or `"destroyed"`)                |
| `cdpUrl`                 | string | WebSocket URL for CDP connections                                   |
| `liveViewUrl`            | string | URL to watch the session in real time                               |
| `interactiveLiveViewUrl` | string | URL to interact with the session in real time (click, type, scroll) |
| `createdAt`              | string | ISO 8601 timestamp of session creation                              |
| `lastActivity`           | string | ISO 8601 timestamp of last activity                                 |

### Example Request

```bash
curl -X GET "https://api.firecrawl.dev/v2/browser?status=active" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY"
```

### Example Response

```json
{
  "success": true,
  "sessions": [
    {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "status": "active",
      "cdpUrl": "wss://cdp-proxy.firecrawl.dev/cdp/550e8400-e29b-41d4-a716-446655440000",
      "liveViewUrl": "https://liveview.firecrawl.dev/550e8400-e29b-41d4-a716-446655440000",
      "interactiveLiveViewUrl": "https://liveview.firecrawl.dev/550e8400-e29b-41d4-a716-446655440000?interactive=true",
      "createdAt": "2025-06-01T12:00:00Z",
      "lastActivity": "2025-06-01T12:05:30Z"
    }
  ]
}
```

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml /api-reference/v2-openapi.json GET /browser
openapi: 3.0.0
info:
  title: Firecrawl API
  version: v2
  description: >-
    API for interacting with Firecrawl services to perform web scraping and
    crawling tasks.
  contact:
    name: Firecrawl Support
    url: https://firecrawl.dev/support
    email: support@firecrawl.dev
servers:
  - url: https://api.firecrawl.dev/v2
security:
  - bearerAuth: []
paths:
  /browser:
    get:
      tags:
        - Browser
      summary: List browser sessions
      operationId: listBrowserSessions
      parameters:
        - name: status
          in: query
          required: false
          schema:
            type: string
            enum:
              - active
              - destroyed
          description: Filter sessions by status
      responses:
        '200':
          description: List of browser sessions
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                  sessions:
                    type: array
                    items:
                      type: object
                      properties:
                        id:
                          type: string
                        status:
                          type: string
                          enum:
                            - active
                            - destroyed
                        cdpUrl:
                          type: string
                        liveViewUrl:
                          type: string
                        interactiveLiveViewUrl:
                          type: string
                          description: >-
                            URL to interact with the browser session in real
                            time (click, type, scroll)
                        streamWebView:
                          type: boolean
                        createdAt:
                          type: string
                          format: date-time
                        lastActivity:
                          type: string
                          format: date-time
        '402':
          description: Payment required
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: Payment required to access this resource.
      security:
        - bearerAuth: []
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
