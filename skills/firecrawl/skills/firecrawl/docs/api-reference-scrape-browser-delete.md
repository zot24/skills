> Source: https://docs.firecrawl.dev/api-reference/endpoint/scrape-browser-delete.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Stop Interacting

> Stop the interactive browser session associated with a scrape job.

Use this endpoint to stop the interactive browser session for a scrape job. Stopping the session releases browser resources and finalizes billing.

Credits are billed based on session duration: **2 credits per browser minute**, prorated by the second.

## Path Parameters

| Parameter | Type          | Required | Description                                           |
| --------- | ------------- | -------- | ----------------------------------------------------- |
| `jobId`   | string (UUID) | Yes      | The scrape job ID associated with the browser session |

## Response

| Field               | Type    | Description                                    |
| ------------------- | ------- | ---------------------------------------------- |
| `success`           | boolean | Whether the session was successfully destroyed |
| `sessionDurationMs` | number  | Total session duration in milliseconds         |
| `creditsBilled`     | number  | Number of credits billed for the session       |
| `error`             | string  | Error message (only present on failure)        |

### Example Request

```bash
curl -X DELETE "https://api.firecrawl.dev/v2/scrape/550e8400-e29b-41d4-a716-446655440000/interact" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY"
```

### Example Response

```json
{
  "success": true
}
```

### Error Codes

| Status | Description                                  |
| ------ | -------------------------------------------- |
| `403`  | Session belongs to a different team          |
| `404`  | No browser session found for this scrape job |

For detailed usage with examples, see the [Interact feature guide](/features/interact).


## OpenAPI

````yaml /api-reference/v2-openapi.json DELETE /scrape/{jobId}/interact
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
  /scrape/{jobId}/interact:
    delete:
      tags:
        - Scraping
      summary: Stop the interactive browser session associated with a scrape job
      operationId: stopInteractiveScrapeBrowserSession
      parameters:
        - name: jobId
          in: path
          required: true
          schema:
            type: string
            format: uuid
          description: The scrape job ID
      responses:
        '200':
          description: Interactive scrape browser session stopped successfully
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
        '403':
          description: Forbidden
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: false
                  error:
                    type: string
                    example: Forbidden.
        '404':
          description: Interactive scrape browser session not found
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: false
                  error:
                    type: string
                    example: Browser session not found.
      security:
        - bearerAuth: []
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
