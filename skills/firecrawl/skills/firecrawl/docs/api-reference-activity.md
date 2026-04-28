> Source: https://docs.firecrawl.dev/api-reference/endpoint/activity.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Activity

> Lists your team's recent API activity from the last 24 hours. Returns metadata about each job including the job ID, which can be used with the corresponding GET endpoint (e.g. GET /crawl/{id}) to retrieve full results. Supports cursor-based pagination and filtering by endpoint.

Lists your recent API activity from the last 24 hours. Use this to discover job IDs, then retrieve results with the corresponding GET endpoint.

| Endpoint       | Retrieval Endpoint          |
| -------------- | --------------------------- |
| `scrape`       | `GET /v2/scrape/{id}`       |
| `crawl`        | `GET /v2/crawl/{id}`        |
| `batch_scrape` | `GET /v2/batch/scrape/{id}` |
| `agent`        | `GET /v2/extract/{id}`      |


## OpenAPI

````yaml /api-reference/v2-openapi.json GET /team/activity
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
  /team/activity:
    get:
      tags:
        - Account
      summary: List recent API activity
      description: >-
        Lists your team's recent API activity from the last 24 hours. Returns
        metadata about each job including the job ID, which can be used with the
        corresponding GET endpoint (e.g. GET /crawl/{id}) to retrieve full
        results. Supports cursor-based pagination and filtering by endpoint.
      operationId: getActivity
      parameters:
        - name: endpoint
          in: query
          required: false
          schema:
            type: string
            enum:
              - scrape
              - crawl
              - batch_scrape
              - search
              - extract
              - llmstxt
              - deep_research
              - map
              - agent
              - browser
              - interact
          description: Filter by endpoint
        - name: limit
          in: query
          required: false
          schema:
            type: integer
            default: 50
            minimum: 1
            maximum: 100
          description: Maximum number of results per page
        - name: cursor
          in: query
          required: false
          schema:
            type: string
          description: >-
            Cursor for pagination. Use the cursor value from the previous
            response.
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
                  data:
                    type: array
                    items:
                      type: object
                      properties:
                        id:
                          type: string
                          description: >-
                            The job ID. Use this with the corresponding GET
                            endpoint to retrieve results.
                        endpoint:
                          type: string
                          enum:
                            - scrape
                            - crawl
                            - batch_scrape
                            - search
                            - extract
                            - llmstxt
                            - deep_research
                            - map
                            - agent
                            - browser
                            - interact
                          description: The endpoint used for this job
                        api_version:
                          type: string
                          description: The API version used for this request
                          example: v1
                        created_at:
                          type: string
                          format: date-time
                          description: When the job was created
                        target:
                          type: string
                          nullable: true
                          description: The URL or query that was submitted
                  cursor:
                    type: string
                    nullable: true
                    description: >-
                      Cursor to use for the next page. Null if there are no more
                      results.
                  has_more:
                    type: boolean
                    description: Whether there are more results available
      security:
        - bearerAuth: []
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
