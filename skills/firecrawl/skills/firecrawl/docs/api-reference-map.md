> Source: https://docs.firecrawl.dev/api-reference/endpoint/map.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Map

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml /api-reference/v2-openapi.json POST /map
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
  /map:
    post:
      tags:
        - Mapping
      summary: Map multiple URLs based on options
      operationId: mapUrls
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
                  description: The base URL to start crawling from
                search:
                  type: string
                  description: >-
                    Specify a search query to order the results by relevance.
                    Example: 'blog' will return URLs that contain the word
                    'blog' in the URL ordered by relevance.
                sitemap:
                  type: string
                  enum:
                    - skip
                    - include
                    - only
                  description: >-
                    Sitemap mode when mapping. If you set it to `skip`, the
                    sitemap won't be used to find URLs. If you set it to `only`,
                    only URLs that are in the sitemap will be returned. By
                    default (`include`), the sitemap and other methods will be
                    used together to find URLs.
                  default: include
                includeSubdomains:
                  type: boolean
                  description: Include subdomains of the website
                  default: true
                ignoreQueryParameters:
                  type: boolean
                  description: Do not return URLs with query parameters
                  default: true
                ignoreCache:
                  type: boolean
                  description: >-
                    Bypass the sitemap cache to retrieve fresh URLs. Sitemap
                    data is cached for up to 7 days; use this parameter when
                    your sitemap has been recently updated.
                  default: false
                limit:
                  type: integer
                  description: Maximum number of links to return
                  default: 5000
                  maximum: 100000
                timeout:
                  type: integer
                  description: Timeout in milliseconds. There is no timeout by default.
                location:
                  type: object
                  description: >-
                    Location settings for the request. When specified, this will
                    use an appropriate proxy if available and emulate the
                    corresponding language and timezone settings. Defaults to
                    'US' if not specified.
                  properties:
                    country:
                      type: string
                      description: >-
                        ISO 3166-1 alpha-2 country code (e.g., 'US', 'AU', 'DE',
                        'JP')
                      pattern: ^[A-Z]{2}$
                      default: US
                    languages:
                      type: array
                      description: >-
                        Preferred languages and locales for the request in order
                        of priority. Defaults to the language of the specified
                        location. See
                        https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Accept-Language
                      items:
                        type: string
                        example: en-US
              required:
                - url
            examples:
              example1:
                summary: Example 1
                value:
                  url: <string>
                  search: <string>
                  sitemap: include
                  includeSubdomains: true
                  ignoreQueryParameters: true
                  ignoreCache: false
                  limit: 5000
                  location:
                    country: US
                    languages:
                      - en-US
                  timeout: 60000
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/MapResponse'
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
    MapResponse:
      type: object
      properties:
        success:
          type: boolean
        links:
          type: array
          items:
            type: object
            properties:
              url:
                type: string
                format: uri
              title:
                type: string
                description: The title of the page, if available.
              description:
                type: string
                description: A description of the page, if available.
            required:
              - url
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
