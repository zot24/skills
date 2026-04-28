> Source: https://docs.firecrawl.dev/api-reference/endpoint/crawl-params-preview.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Crawl Params Preview


## OpenAPI

````yaml /api-reference/v2-openapi.json POST /crawl/params-preview
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
  /crawl/params-preview:
    post:
      tags:
        - Crawling
      summary: Preview crawl parameters generated from natural language prompt
      operationId: crawlParamsPreview
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                url:
                  type: string
                  format: uri
                  description: The URL to crawl
                prompt:
                  type: string
                  maxLength: 10000
                  description: Natural language prompt describing what you want to crawl
              required:
                - url
                - prompt
      responses:
        '200':
          description: Successful response with generated crawl parameters
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: true
                  data:
                    type: object
                    properties:
                      url:
                        type: string
                        format: uri
                        description: The URL to crawl
                      includePaths:
                        type: array
                        items:
                          type: string
                        description: URL patterns to include
                      excludePaths:
                        type: array
                        items:
                          type: string
                        description: URL patterns to exclude
                      maxDepth:
                        type: integer
                        description: Maximum crawl depth
                      maxDiscoveryDepth:
                        type: integer
                        description: Maximum discovery depth
                      crawlEntireDomain:
                        type: boolean
                        description: Whether to crawl the entire domain
                      allowExternalLinks:
                        type: boolean
                        description: Whether to allow external links
                      allowSubdomains:
                        type: boolean
                        description: Whether to allow subdomains
                      sitemap:
                        type: string
                        enum:
                          - skip
                          - include
                        description: Sitemap handling strategy
                      ignoreQueryParameters:
                        type: boolean
                        description: Whether to ignore query parameters
                      ignoreRobotsTxt:
                        type: boolean
                        description: Whether robots.txt rules are ignored
                      robotsUserAgent:
                        type: string
                        description: >-
                          Custom User-Agent string used for robots.txt
                          evaluation
                      deduplicateSimilarURLs:
                        type: boolean
                        description: Whether to deduplicate similar URLs
                      delay:
                        type: number
                        description: Delay between requests in milliseconds
                      limit:
                        type: integer
                        description: Maximum number of pages to crawl
        '400':
          description: Bad request
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
                    example: Invalid request parameters
        '401':
          description: Unauthorized
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
                    example: Unauthorized
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
                    example: Failed to process natural language prompt
      security:
        - bearerAuth: []
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
