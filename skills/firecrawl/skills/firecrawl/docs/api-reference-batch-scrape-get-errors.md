> Source: https://docs.firecrawl.dev/api-reference/endpoint/batch-scrape-get-errors.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Batch Scrape Errors

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml /api-reference/v2-openapi.json GET /batch/scrape/{id}/errors
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
  /batch/scrape/{id}/errors:
    parameters:
      - name: id
        in: path
        description: The ID of the batch scrape job
        required: true
        schema:
          type: string
          format: uuid
    get:
      tags:
        - Scraping
      summary: Get the errors of a batch scrape job
      operationId: getBatchScrapeErrors
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/CrawlErrorsResponseObj'
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
        '429':
          description: Too many requests
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: >-
                      Request rate limit exceeded. Please wait and try again
                      later.
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
  schemas:
    CrawlErrorsResponseObj:
      type: object
      properties:
        errors:
          type: array
          description: Errored scrape jobs and error details
          items:
            type: object
            properties:
              id:
                type: string
              timestamp:
                type: string
                nullable: true
                description: ISO timestamp of failure
              url:
                type: string
                description: Scraped URL
              error:
                type: string
                description: Error message
        robotsBlocked:
          type: array
          description: >-
            List of URLs that were attempted in scraping but were blocked by
            robots.txt
          items:
            type: string
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
