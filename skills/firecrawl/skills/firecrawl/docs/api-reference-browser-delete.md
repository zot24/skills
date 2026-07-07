> Source: https://docs.firecrawl.dev/api-reference/endpoint/browser-delete.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Delete Interact Session

> Destroy a standalone Interact session and release its resources.

## Headers

| Header          | Value              |
| --------------- | ------------------ |
| `Authorization` | `Bearer <API_KEY>` |

## Path Parameters

| Parameter   | Type   | Required | Description                        |
| ----------- | ------ | -------- | ---------------------------------- |
| `sessionId` | string | Yes      | The Interact session ID to destroy |

## Response

| Field     | Type    | Description                                    |
| --------- | ------- | ---------------------------------------------- |
| `success` | boolean | Whether the session was successfully destroyed |

### Example Request

```bash theme={null}
curl -X DELETE "https://api.firecrawl.dev/v2/interact/550e8400-e29b-41d4-a716-446655440000" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY"
```

### Example Response

```json theme={null}
{
  "success": true
}
```

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml api-reference/v2-openapi.json DELETE /interact/{sessionId}
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
  /interact/{sessionId}:
    delete:
      tags:
        - Interact
      summary: Delete an interact session
      operationId: deleteBrowserSession
      parameters:
        - name: sessionId
          in: path
          required: true
          schema:
            type: string
          description: The interact session ID
      responses:
        '200':
          description: Interact session deleted successfully
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                  sessionDurationMs:
                    type: integer
                    description: Total session duration in milliseconds
                  creditsBilled:
                    type: number
                    description: Number of credits billed for the session
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
