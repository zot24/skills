> Source: https://docs.firecrawl.dev/api-reference/endpoint/batch-scrape-get.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Batch Scrape Status

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml api-reference/v2-openapi.json GET /batch/scrape/{id}
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
    get:
      tags:
        - Scraping
      summary: Get the status of a batch scrape job
      operationId: getBatchScrapeStatus
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/BatchScrapeStatusResponseObj'
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
    BatchScrapeStatusResponseObj:
      type: object
      properties:
        status:
          type: string
          description: >-
            The current status of the batch scrape. Can be `scraping`,
            `completed`, or `failed`.
        total:
          type: integer
          description: The total number of pages that were attempted to be scraped.
        completed:
          type: integer
          description: The number of pages that have been successfully scraped.
        creditsUsed:
          type: integer
          description: The number of credits used for the batch scrape.
        expiresAt:
          type: string
          format: date-time
          description: The date and time when the batch scrape will expire.
        createdAt:
          type: string
          format: date-time
          description: The date and time when the batch scrape was started.
        completedAt:
          type: string
          format: date-time
          description: >-
            The date and time when the batch scrape finished. Present only when
            the batch scrape is in a terminal state (`completed`, `failed`, or
            `cancelled`).
        duration:
          type: number
          description: >-
            Batch scrape duration in seconds. For terminal batch scrapes, this
            is the elapsed time from `createdAt` to `completedAt`. For
            in-progress batch scrapes, it is the elapsed time from `createdAt`
            to now.
        next:
          type: string
          nullable: true
          description: >-
            The URL to retrieve the next 10MB of data. Returned if the batch
            scrape is not completed or if the response is larger than 10MB.
        data:
          type: array
          description: The data of the batch scrape.
          items:
            type: object
            properties:
              markdown:
                type: string
              pages:
                type: array
                nullable: true
                description: >-
                  Physical per-page markdown for PDFs. Present only when the
                  request set the `pages` PDF parser option.
                items:
                  type: object
                  properties:
                    pageNumber:
                      type: integer
                      description: 1-based physical PDF page number.
                    markdown:
                      type: string
              blocks:
                type: array
                nullable: true
                description: >-
                  Per-page typed layout blocks for PDFs. Present only when the
                  request set the `blocks` PDF parser option.
                items:
                  type: object
                  properties:
                    pageNumber:
                      type: integer
                      description: 1-based physical PDF page number.
                    width:
                      type: number
                      nullable: true
                      description: >-
                        Page render width in px — the anchor for denormalizing
                        bbox coordinates. Null for pages that never rendered.
                    height:
                      type: number
                      nullable: true
                      description: >-
                        Page render height in px. Null for pages that never
                        rendered.
                    status:
                      type: string
                      description: 'Page-level rollup: ok | partial | failed.'
                    items:
                      type: array
                      items:
                        type: object
                        properties:
                          id:
                            type: string
                            description: >-
                              Stable within a response: p<page>.b<index in
                              reading order>.
                          type:
                            type: string
                            description: >-
                              Block type: title, section_header, text, table,
                              formula, figure, caption, page_number,
                              page_header, page_footer. New types may appear
                              over time.
                          label:
                            type: string
                            nullable: true
                            description: >-
                              Raw layout-model label, passthrough for forward
                              compatibility.
                          bbox:
                            type: array
                            nullable: true
                            minItems: 4
                            maxItems: 4
                            items:
                              type: number
                            description: >-
                              [x0, y0, x1, y1] normalized 0-1 relative to the
                              page width/height. Multiply by the page
                              width/height to get pixel coordinates. Null when
                              the page has no known dimensions.
                          content:
                            type: string
                            description: >-
                              Markdown fragment this block contributed to the
                              document markdown.
                          markdownSpan:
                            type: array
                            nullable: true
                            minItems: 2
                            maxItems: 2
                            items:
                              type: integer
                            description: >-
                              [start, end) character offsets into the document
                              markdown covering this block's fragment. Null when
                              a post-processing transform rewrote the fragment.
                          readingOrder:
                            type: integer
                          source:
                            type: string
                            nullable: true
                            description: >-
                              Pipeline path that produced the block (for example
                              native_text, layout_ocr, tsr, formula_model,
                              full_page).
                          confidence:
                            type: object
                            properties:
                              layout:
                                type: number
                                nullable: true
                                description: >-
                                  Layout-model detection score (0-1). Null when
                                  the page bypassed layout analysis.
                              ocr:
                                type: number
                                nullable: true
                                description: >-
                                  Text confidence when the source path provides
                                  one; null otherwise.
              html:
                type: string
                nullable: true
                description: HTML version of the content on page if `includeHtml`  is true
              rawHtml:
                type: string
                nullable: true
                description: Raw HTML content of the page if `includeRawHtml`  is true
              rawBase64:
                type: string
                nullable: true
                description: >-
                  The Base64-encoded original HTTP response body if `rawBase64`
                  is in `formats`. A bare Base64 string, not a data URI. The
                  MIME type is in `metadata.contentType`.
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
                  numPages:
                    type: integer
                    description: >-
                      For PDF inputs, the number of pages parsed (capped by the
                      parsers maxPages option).
                  totalPages:
                    type: integer
                    description: >-
                      For PDF inputs, the document's true page count before any
                      maxPages capping. Omitted when it cannot be determined; a
                      totalPages greater than numPages indicates the result was
                      truncated.
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
