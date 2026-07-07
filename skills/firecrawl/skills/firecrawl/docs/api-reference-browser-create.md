> Source: https://docs.firecrawl.dev/api-reference/endpoint/browser-create.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Create Interact Session

> Start a standalone Interact browser session you drive with code (no prior scrape required).

## Headers

| Header          | Value              |
| --------------- | ------------------ |
| `Authorization` | `Bearer <API_KEY>` |
| `Content-Type`  | `application/json` |

## Request Body

| Parameter             | Type    | Required | Default | Description                                                                                                                                                  |
| --------------------- | ------- | -------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `ttl`                 | number  | No       | 600     | Total session lifetime in seconds (30-3600)                                                                                                                  |
| `activityTtl`         | number  | No       | 300     | Seconds of inactivity before session is destroyed (10-3600)                                                                                                  |
| `profile`             | object  | No       | —       | Enable persistent storage across sessions. See below.                                                                                                        |
| `profile.name`        | string  | Yes\*    | —       | Name for the profile (1-128 chars). Sessions with the same name share storage.                                                                               |
| `profile.saveChanges` | boolean | No       | `true`  | When `true`, browser state is saved back to the profile on close. Set to `false` to load existing data without writing. Only one saver is allowed at a time. |

## Response

| Field                    | Type    | Description                                                         |
| ------------------------ | ------- | ------------------------------------------------------------------- |
| `success`                | boolean | Whether the session was created                                     |
| `id`                     | string  | Unique session identifier                                           |
| `cdpUrl`                 | string  | WebSocket URL for CDP connections                                   |
| `liveViewUrl`            | string  | URL to watch the session in real time                               |
| `interactiveLiveViewUrl` | string  | URL to interact with the session in real time (click, type, scroll) |
| `expiresAt`              | string  | When the session will expire based on TTL                           |

### Example Request

```bash theme={null}
curl -X POST "https://api.firecrawl.dev/v2/interact" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "ttl": 120
  }'
```

### Example Response

```json theme={null}
{
  "success": true,
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "cdpUrl": "wss://cdp-proxy.firecrawl.dev/cdp/550e8400-e29b-41d4-a716-446655440000",
  "liveViewUrl": "https://liveview.firecrawl.dev/550e8400-e29b-41d4-a716-446655440000",
  "interactiveLiveViewUrl": "https://liveview.firecrawl.dev/550e8400-e29b-41d4-a716-446655440000?interactive=true"
}
```

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml api-reference/v2-openapi.json POST /interact
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
  /interact:
    post:
      tags:
        - Interact
      summary: Create an interact session
      operationId: createBrowserSession
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                ttl:
                  type: integer
                  default: 300
                  minimum: 30
                  maximum: 3600
                  description: Total time-to-live in seconds for the interact session
                activityTtl:
                  type: integer
                  minimum: 10
                  maximum: 3600
                  description: >-
                    Time in seconds before the session is destroyed due to
                    inactivity
                streamWebView:
                  type: boolean
                  default: true
                  description: Whether to stream a live view of the browser
                profile:
                  type: object
                  description: >-
                    Enable persistent storage across interact sessions. Data
                    saved in one session can be loaded in a later session using
                    the same name.
                  properties:
                    name:
                      type: string
                      minLength: 1
                      maxLength: 128
                      description: >-
                        A name for the profile. Sessions with the same name
                        share storage.
                    saveChanges:
                      type: boolean
                      default: true
                      description: >-
                        When true, browser state is saved back to the profile on
                        close. Set to false to load existing data without
                        writing. Multiple non-saving sessions are allowed but
                        only one saving session at a time.
                  required:
                    - name
      responses:
        '200':
          description: Interact session created successfully
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                  id:
                    type: string
                    description: The unique session identifier
                  cdpUrl:
                    type: string
                    description: WebSocket URL for Chrome DevTools Protocol access
                  liveViewUrl:
                    type: string
                    description: URL to view the interact session in real time
                  interactiveLiveViewUrl:
                    type: string
                    description: >-
                      URL to interact with the interact session in real time
                      (click, type, scroll)
                  expiresAt:
                    type: string
                    format: date-time
                    description: When the session will expire based on TTL
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
