> Source: https://docs.firecrawl.dev/api-reference/endpoint/crawl-get.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Crawl Status

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml /api-reference/v2-openapi.json GET /crawl/{id}
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
    get:
      tags:
        - Crawling
      summary: Get the status of a crawl job
      operationId: getCrawlStatus
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/CrawlStatusResponseObj'
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
    CrawlStatusResponseObj:
      type: object
      properties:
        status:
          type: string
          description: >-
            The current status of the crawl. Can be `scraping`, `completed`, or
            `failed`.
        total:
          type: integer
          description: The total number of pages that were attempted to be crawled.
        completed:
          type: integer
          description: The number of pages that have been successfully crawled.
        creditsUsed:
          type: integer
          description: The number of credits used for the crawl.
        expiresAt:
          type: string
          format: date-time
          description: The date and time when the crawl will expire.
        next:
          type: string
          nullable: true
          description: >-
            The URL to retrieve the next 10MB of data. Returned if the crawl is
            not completed or if the response is larger than 10MB.
        data:
          type: array
          description: The data of the crawl.
          items:
            type: object
            properties:
              markdown:
                type: string
              html:
                type: string
                nullable: true
                description: HTML version of the content on page if `includeHtml`  is true
              rawHtml:
                type: string
                nullable: true
                description: Raw HTML content of the page if `includeRawHtml`  is true
              links:
                type: array
                items:
                  type: string
                description: List of links on the page if `includeLinks` is true
              screenshot:
                type: string
                nullable: true
                description: Screenshot of the page if `includeScreenshot` is true
              metadata:
                type: object
                properties:
                  title:
                    oneOf:
                      - type: string
                      - type: array
                        items:
                          type: string
                    description: >-
                      Title extracted from the page, can be a string or array of
                      strings
                  description:
                    oneOf:
                      - type: string
                      - type: array
                        items:
                          type: string
                    description: >-
                      Description extracted from the page, can be a string or
                      array of strings
                  language:
                    oneOf:
                      - type: string
                      - type: array
                        items:
                          type: string
                    nullable: true
                    description: >-
                      Language extracted from the page, can be a string or array
                      of strings
                  sourceURL:
                    type: string
                    format: uri
                    description: >-
                      The original URL that was requested. May differ from the
                      page's final URL if redirects occurred.
                  url:
                    type: string
                    format: uri
                    description: >-
                      The final URL of the page after all redirects have been
                      followed.
                  keywords:
                    oneOf:
                      - type: string
                      - type: array
                        items:
                          type: string
                    description: >-
                      Keywords extracted from the page, can be a string or array
                      of strings
                  ogLocaleAlternate:
                    type: array
                    items:
                      type: string
                    description: Alternative locales for the page
                  '<any other metadata> ':
                    type: string
                  statusCode:
                    type: integer
                    description: The status code of the page
                  error:
                    type: string
                    nullable: true
                    description: The error message of the page
                  concurrencyLimited:
                    type: boolean
                    description: >-
                      Whether this scrape was throttled due to team concurrency
                      limits
                  concurrencyQueueDurationMs:
                    type: number
                    description: >-
                      Time in milliseconds the request waited in the concurrency
                      queue. Only present when concurrencyLimited is true.
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
