> Source: https://docs.firecrawl.dev/api-reference/endpoint/batch-scrape-delete.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Cancel Batch Scrape

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml /api-reference/v2-openapi.json DELETE /batch/scrape/{id}
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
  /batch/scrape/{id}:
    parameters:
      - name: id
        in: path
        description: The ID of the batch scrape job
        required: true
        schema:
          type: string
          format: uuid
    delete:
      tags:
        - Scraping
      summary: Cancel a batch scrape job
      operationId: cancelBatchScrape
      responses:
        '200':
          description: Successful cancellation
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: true
                  message:
                    type: string
                    example: Batch scrape job successfully cancelled.
        '404':
          description: Batch scrape job not found
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: Batch scrape job not found.
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
