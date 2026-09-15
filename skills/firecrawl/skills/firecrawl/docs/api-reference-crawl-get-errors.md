> Source: https://docs.firecrawl.dev/api-reference/endpoint/crawl-get-errors.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Crawl Errors


  This endpoint records pages that did not make it into the crawl's `data` array: `errors` for scrapes Firecrawl failed, and `robotsBlocked` for URLs blocked by robots.txt. Failed pages appear nowhere in the [crawl status](/api-reference/endpoint/crawl-get) counters, so this is the only place to find them — but the list is not guaranteed complete, because some internal failure classes are filtered out before the response is built. See [Execution and result accounting](/features/crawl#execution-and-result-accounting) for how to read it alongside the status counters.


> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml api-reference/v2-openapi.json GET /crawl/{id}/errors
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
  /crawl/{id}/errors:
    parameters:
      - name: id
        in: path
        description: The ID of the crawl job
        required: true
        schema:
          type: string
          format: uuid
    get:
      tags:
        - Crawling
      summary: Get the errors of a crawl job
      operationId: getCrawlErrors
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
