> Source: https://docs.firecrawl.dev/api-reference/endpoint/token-usage-historical.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Historical Token Usage

Returns historical token usage on a month-by-month basis. The endpoint can also breaks usage down by API key optionally.

We've simplified billing so that Extract now uses credits, just like all of the other endpoints. Each credit is worth 15 tokens. Reported token usage now includes usage from all endpoints.

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml /api-reference/v2-openapi.json GET /team/token-usage/historical
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
  /team/token-usage/historical:
    get:
      tags:
        - Billing
      summary: Get historical token usage for the authenticated team (Extract only)
      operationId: getHistoricalTokenUsage
      parameters:
        - name: byApiKey
          in: query
          description: Get historical token usage by API key
          required: false
          schema:
            type: boolean
            default: false
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: true
                  periods:
                    type: array
                    items:
                      type: object
                      properties:
                        startDate:
                          type: string
                          format: date-time
                          description: Start date of the billing period
                          example: '2025-01-01T00:00:00Z'
                        endDate:
                          type: string
                          format: date-time
                          description: End date of the billing period
                          example: '2025-01-31T23:59:59Z'
                        apiKey:
                          type: string
                          description: >-
                            Name of the API key used for the billing period.
                            null if byApiKey is false (default)
                          nullable: true
                        totalTokens:
                          type: integer
                          description: Total number of tokens used in the billing period
                          example: 1000
        '500':
          description: Server error
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
                    example: >-
                      Internal server error while fetching historical token
                      usage
      security:
        - bearerAuth: []
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
