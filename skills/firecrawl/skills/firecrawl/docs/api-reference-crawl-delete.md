> Source: https://docs.firecrawl.dev/api-reference/endpoint/crawl-delete.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Cancel Crawl

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml /api-reference/v2-openapi.json DELETE /crawl/{id}
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
  /crawl/{id}:
    parameters:
      - name: id
        in: path
        description: The ID of the crawl job
        required: true
        schema:
          type: string
          format: uuid
    delete:
      tags:
        - Crawling
      summary: Cancel a crawl job
      operationId: cancelCrawl
      responses:
        '200':
          description: Successful cancellation
          content:
            application/json:
              schema:
                type: object
                properties:
                  status:
                    type: string
                    enum:
                      - cancelled
                    example: cancelled
        '404':
          description: Crawl job not found
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: Crawl job not found.
        '500':
          description: Server error
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: An unexpected error occurred on the server.
      security:
        - bearerAuth: []
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
