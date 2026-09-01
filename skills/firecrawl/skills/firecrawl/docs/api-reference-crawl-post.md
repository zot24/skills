> Source: https://docs.firecrawl.dev/api-reference/endpoint/crawl-post.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Crawl

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml api-reference/v2-openapi.json POST /crawl
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
  /crawl:
    post:
      tags:
        - Crawling
      summary: Crawl multiple URLs based on options
      operationId: crawlUrls
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
                prompt:
                  type: string
                  description: >-
                    A prompt to use to generate the crawler options (all the
                    parameters below) from natural language. Explicitly set
                    parameters will override the generated equivalents.
                excludePaths:
                  type: array
                  items:
                    type: string
                  description: >-
                    URL pathname regex patterns that exclude matching URLs from
                    the crawl. For example, if you set "excludePaths":
                    ["blog/.*"] for the base URL firecrawl.dev, any results
                    matching that pattern will be excluded, such as
                    https://www.firecrawl.dev/blog/firecrawl-launch-week-1-recap.
                includePaths:
                  type: array
                  items:
                    type: string
                  description: >-
                    URL pathname regex patterns that include matching URLs in
                    the crawl. Only the paths that match the specified patterns
                    will be included in the response. Note: the starting URL is
                    also checked against these patterns — if it does not match,
                    the crawl may return 0 pages. For example, if you set
                    "includePaths": ["blog/.*"] for the base URL
                    firecrawl.dev/blog, only pages under /blog/ will be included
                    in the results, such as
                    https://www.firecrawl.dev/blog/firecrawl-launch-week-1-recap.
                maxDiscoveryDepth:
                  type: integer
                  description: >-
                    Maximum depth to crawl based on discovery order. The root
                    site and sitemapped pages has a discovery depth of 0. For
                    example, if you set it to 1, and you set `sitemap: 'skip'`,
                    you will only crawl the entered URL and all URLs that are
                    linked on that page.
                sitemap:
                  type: string
                  enum:
                    - skip
                    - include
                    - only
                  description: >-
                    Sitemap mode when crawling. If you set it to 'skip', the
                    crawler will ignore the website sitemap and only crawl the
                    entered URL and discover pages from there onwards. If you
                    set it to 'only', the crawler will only crawl URLs from the
                    sitemap (plus the start URL) and will not discover links
                    from HTML.
                  default: include
                ignoreQueryParameters:
                  type: boolean
                  description: >-
                    Do not re-scrape the same path with different (or none)
                    query parameters
                  default: false
                regexOnFullURL:
                  type: boolean
                  description: >-
                    When true, includePaths and excludePaths regex patterns are
                    matched against the full URL (including query parameters)
                    instead of just the URL pathname. Useful when you need to
                    filter URLs based on query strings.
                  default: false
                limit:
                  type: integer
                  description: Maximum number of pages to crawl. Default limit is 10000.
                  default: 10000
                crawlEntireDomain:
                  type: boolean
                  description: >-
                    Allows the crawler to follow internal links to sibling or
                    parent URLs, not just child paths.


                    false: Only crawls deeper (child) URLs.

                    → e.g. /features/feature-1 → /features/feature-1/tips ✅

                    → Won't follow /pricing or / ❌


                    true: Crawls any internal links, including siblings and
                    parents.

                    → e.g. /features/feature-1 → /pricing, /, etc. ✅


                    Use true for broader internal coverage beyond nested paths.
                  default: false
                allowExternalLinks:
                  type: boolean
                  description: >-
                    Allows the crawler to follow links to external websites.
                    External links are followed one hop (the links found on
                    those external pages are not crawled). Links pointing to an
                    external site's homepage (a root URL with no path) are
                    skipped and reported in Get Crawl Errors with the code
                    EXTERNAL_LINK; redirects to an external homepage are skipped
                    for the same reason.
                  default: false
                allowSubdomains:
                  type: boolean
                  description: >-
                    Allows the crawler to follow links to subdomains of the main
                    domain.
                  default: false
                ignoreRobotsTxt:
                  type: boolean
                  description: >-
                    Ignore the website's robots.txt rules. Enterprise only —
                    contact support@firecrawl.com to enable.
                  default: false
                robotsUserAgent:
                  type: string
                  description: >-
                    Custom User-Agent string for robots.txt evaluation. When
                    set, robots.txt is fetched with this User-Agent and
                    allow/disallow rules are matched against it instead of the
                    default. Enterprise only — contact support@firecrawl.com to
                    enable.
                delay:
                  type: number
                  description: >-
                    Delay in seconds between scrapes. This helps respect website
                    rate limits. Setting this forces concurrency to 1.
                maxConcurrency:
                  type: integer
                  description: >-
                    Maximum number of concurrent scrapes. This parameter allows
                    you to set a concurrency limit for this crawl. If not
                    specified, the crawl adheres to your team's concurrency
                    limit.
                webhook:
                  type: object
                  description: A webhook specification object.
                  properties:
                    url:
                      type: string
                      description: >-
                        The URL to send the webhook to. This will trigger for
                        crawl started (crawl.started), every page crawled
                        (crawl.page) and when the crawl is completed
                        (crawl.completed or crawl.failed). The response will be
                        the same as the `/scrape` endpoint.
                    headers:
                      type: object
                      description: Headers to send to the webhook URL.
                      additionalProperties:
                        type: string
                    metadata:
                      type: object
                      description: >-
                        Custom metadata that will be included in all webhook
                        payloads for this crawl
                      additionalProperties: true
                    events:
                      type: array
                      description: >-
                        Type of events that should be sent to the webhook URL.
                        (default: all)
                      items:
                        type: string
                        enum:
                          - completed
                          - page
                          - failed
                          - started
                  required:
                    - url
                scrapeOptions:
                  $ref: '#/components/schemas/ScrapeOptions'
                zeroDataRetention:
                  type: boolean
                  default: false
                  description: >-
                    If true, this will enable zero data retention for this
                    crawl. To enable this feature, please contact
                    help@firecrawl.dev
              required:
                - url
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/CrawlResponse'
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
    ScrapeOptions:
      type: object
      properties:
        formats:
          $ref: '#/components/schemas/Formats'
        onlyMainContent:
          type: boolean
          description: >-
            Only return the main content of the page excluding headers, navs,
            footers, etc. This is a deterministic HTML-level filter applied
            before markdown is generated; no LLM is involved.
          default: true
        onlyCleanContent:
          type: boolean
          description: >-
            Beta. Run an additional LLM-based pass over the generated markdown
            to remove residual boilerplate that `onlyMainContent` can miss
            (cookie banners, ad blocks, social share widgets, breadcrumbs,
            newsletter signups, comment sections, related-article lists).
            Headings, lists, tables, code blocks, image references, and inline
            links are preserved. Can be combined with `onlyMainContent` (the
            most common setup) or used on its own. Skipped with a warning when
            the markdown exceeds the cleaning model's output token limit (the
            original markdown is preserved). Not supported on
            zero-data-retention requests.
          default: false
        includeTags:
          type: array
          items:
            type: string
          description: Tags to include in the output.
        excludeTags:
          type: array
          items:
            type: string
          description: Tags to exclude from the output.
        maxAge:
          type: integer
          description: >-
            Returns a cached version of the page if it is younger than this age
            in milliseconds. If a cached version of the page is older than this
            value, the page will be scraped. If you do not need extremely fresh
            data, enabling this can speed up your scrapes by 500%. Defaults to 2
            days.
          default: 172800000
        minAge:
          type: integer
          description: >-
            When set, the request only checks the cache and never triggers a
            fresh scrape. The value is in milliseconds and specifies the minimum
            age the cached data must be. If matching cached data exists, it is
            returned instantly. If no cached data is found, a 404 with error
            code SCRAPE_NO_CACHED_DATA is returned. Set to 1 to accept any
            cached data regardless of age.
        headers:
          type: object
          description: >-
            Headers to send with the request. Can be used to send cookies,
            user-agent, etc.
        waitFor:
          type: integer
          description: >-
            Specify a delay in milliseconds before fetching the content,
            allowing the page sufficient time to load. This waiting time is in
            addition to Firecrawl's smart wait feature.
          default: 0
        mobile:
          type: boolean
          description: >-
            Set to true if you want to emulate scraping from a mobile device.
            Useful for testing responsive pages and taking mobile screenshots.
          default: false
        skipTlsVerification:
          type: boolean
          description: Skip TLS certificate verification when making requests.
          default: true
        timeout:
          type: integer
          description: >-
            Timeout in milliseconds for the request. Minimum is 1000 (1 second).
            Default is 60000 (60 seconds). Maximum is 300000 (300 seconds).
          default: 60000
          minimum: 1000
          maximum: 300000
        parsers:
          type: array
          description: >-
            Controls how files are processed during scraping. When "pdf" is
            included (default), the PDF content is extracted and converted to
            markdown format, with billing based on the number of pages (1 credit
            per page). When an empty array is passed, the PDF file is returned
            in base64 encoding with a flat rate of 1 credit for the entire PDF.
          items:
            oneOf:
              - type: object
                properties:
                  type:
                    type: string
                    enum:
                      - pdf
                  mode:
                    type: string
                    enum:
                      - fast
                      - auto
                      - ocr
                    default: auto
                    description: >-
                      PDF parsing mode. "fast": text-based extraction only
                      (embedded text, fastest). "auto" (default): attempts fast
                      extraction first, falls back to OCR if needed. "ocr":
                      forces OCR parsing on every page.
                  maxPages:
                    type: integer
                    minimum: 1
                    maximum: 10000
                    description: >-
                      Maximum number of pages to parse from the PDF. Must be a
                      positive integer up to 10000.
                  pages:
                    type: boolean
                    default: false
                    description: >-
                      Include physical per-page markdown alongside the document
                      markdown. Populates the `pages` field on the document as
                      an array of { pageNumber, markdown }. No additional cost.
                  blocks:
                    type: boolean
                    default: false
                    description: >-
                      Include per-page typed layout blocks alongside the
                      document markdown. Populates the `blocks` field on the
                      document: typed blocks (title, section_header, text,
                      table, formula, figure, caption, ...) with normalized
                      bounding boxes, reading order, character-span links into
                      the markdown, and per-block confidence. No additional
                      cost.
                  pageMarkers:
                    type: boolean
                    default: false
                    description: >-
                      Annotate page breaks in the document markdown: pages are
                      joined with `\n\n---\n\n<!-- page N -->\n\n`, where N is
                      the 1-based physical page of the content that follows.
                      Markers appear between pages only (no leading marker for
                      page 1), and numbering may skip pages merged across a page
                      break — use `pages: true` when every physical page is
                      needed. No new response field; no additional cost.
                required:
                  - type
                additionalProperties: false
          default:
            - pdf
        actions:
          type: array
          description: Actions to perform on the page before grabbing the content
          items:
            oneOf:
              - title: Wait
                oneOf:
                  - type: object
                    title: Wait by Duration
                    properties:
                      type:
                        type: string
                        enum:
                          - wait
                        description: Wait for a specified amount of milliseconds
                      milliseconds:
                        type: integer
                        minimum: 1
                        description: Number of milliseconds to wait
                    required:
                      - type
                      - milliseconds
                    additionalProperties: false
                  - type: object
                    title: Wait for Element
                    properties:
                      type:
                        type: string
                        enum:
                          - wait
                        description: Wait for a specific element to appear
                      selector:
                        type: string
                        description: CSS selector to wait for
                        example: '#my-element'
                    required:
                      - type
                      - selector
                    additionalProperties: false
              - type: object
                title: Screenshot
                properties:
                  type:
                    type: string
                    enum:
                      - screenshot
                    description: >-
                      Take a screenshot. The links will be in the response's
                      `actions.screenshots` array.
                  fullPage:
                    type: boolean
                    description: >-
                      Whether to capture a full-page screenshot (ignores
                      viewport.height) or limit to the current viewport.
                    default: false
                  quality:
                    type: integer
                    description: >-
                      The quality of the screenshot, from 1 to 100. 100 is the
                      highest quality.
                  viewport:
                    type: object
                    properties:
                      width:
                        type: integer
                        description: The width of the viewport in pixels
                      height:
                        type: integer
                        description: The height of the viewport in pixels
                    required:
                      - width
                      - height
                required:
                  - type
              - type: object
                title: Click
                properties:
                  type:
                    type: string
                    enum:
                      - click
                    description: Click on an element
                  selector:
                    type: string
                    description: Query selector to find the element by
                    example: '#load-more-button'
                  all:
                    type: boolean
                    description: >-
                      Clicks all elements matched by the selector, not just the
                      first one. Does not throw an error if no elements match
                      the selector.
                    default: false
                required:
                  - type
                  - selector
              - type: object
                title: Write text
                properties:
                  type:
                    type: string
                    enum:
                      - write
                    description: >-
                      Write text into an input field, text area, or
                      contenteditable element. Note: You must first focus the
                      element using a 'click' action before writing. The text
                      will be typed character by character to simulate keyboard
                      input.
                  text:
                    type: string
                    description: Text to type
                    example: Hello, world!
                required:
                  - type
                  - text
              - type: object
                title: Press a key
                description: >-
                  Press a key on the page. See
                  https://asawicki.info/nosense/doc/devices/keyboard/key_codes.html
                  for key codes.
                properties:
                  type:
                    type: string
                    enum:
                      - press
                    description: Press a key on the page
                  key:
                    type: string
                    description: Key to press
                    example: Enter
                required:
                  - type
                  - key
              - type: object
                title: Scroll
                properties:
                  type:
                    type: string
                    enum:
                      - scroll
                    description: Scroll the page or a specific element
                  direction:
                    type: string
                    enum:
                      - up
                      - down
                    description: Direction to scroll
                    default: down
                  selector:
                    type: string
                    description: Query selector for the element to scroll
                    example: '#my-element'
                required:
                  - type
              - type: object
                title: Scrape
                properties:
                  type:
                    type: string
                    enum:
                      - scrape
                    description: >-
                      Scrape the current page content, returns the url and the
                      html.
                required:
                  - type
              - type: object
                title: Execute JavaScript
                properties:
                  type:
                    type: string
                    enum:
                      - executeJavascript
                    description: Execute JavaScript code on the page
                  script:
                    type: string
                    description: JavaScript code to execute
                    example: document.querySelector('.button').click();
                required:
                  - type
                  - script
              - type: object
                title: Generate PDF
                properties:
                  type:
                    type: string
                    enum:
                      - pdf
                    description: >-
                      Generate a PDF of the current page. The PDF will be
                      returned in the `actions.pdfs` array of the response.
                  format:
                    type: string
                    enum:
                      - A0
                      - A1
                      - A2
                      - A3
                      - A4
                      - A5
                      - A6
                      - Letter
                      - Legal
                      - Tabloid
                      - Ledger
                    description: The page size of the resulting PDF
                    default: Letter
                  landscape:
                    type: boolean
                    description: Whether to generate the PDF in landscape orientation
                    default: false
                  scale:
                    type: number
                    description: The scale multiplier of the resulting PDF
                    default: 1
                required:
                  - type
        location:
          type: object
          description: >-
            Location settings for the request. When specified, this will use an
            appropriate proxy if available and emulate the corresponding
            language and timezone settings. Defaults to 'US' if not specified.
          properties:
            country:
              type: string
              description: ISO 3166-1 alpha-2 country code (e.g., 'US', 'AU', 'DE', 'JP')
              pattern: ^[A-Z]{2}$
              default: US
            languages:
              type: array
              description: >-
                Preferred languages and locales for the request in order of
                priority. Defaults to the language of the specified location.
                See
                https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Accept-Language
              items:
                type: string
                example: en-US
        removeBase64Images:
          type: boolean
          description: >-
            Removes all base 64 images from the markdown output, which may be
            overwhelmingly long. This does not affect html or rawHtml formats.
            The image's alt text remains in the output, but the URL is replaced
            with a placeholder.
          default: true
        blockAds:
          type: boolean
          description: Enables ad-blocking and cookie popup blocking.
          default: true
        proxy:
          type: string
          enum:
            - basic
            - enhanced
            - auto
          description: |-
            Specifies the type of proxy to use.

             - **basic**: Proxies for scraping sites with none to basic anti-bot solutions. Fast and usually works.
             - **enhanced**: Enhanced proxies for scraping sites with advanced anti-bot solutions. Slower, but more reliable on certain sites. Billed at the same credit cost as basic.
             - **auto**: Firecrawl will automatically retry scraping with enhanced proxies if the basic proxy fails. Enhanced proxies carry no credit surcharge, so either way only the regular cost is billed.
          default: auto
        storeInCache:
          type: boolean
          description: >-
            If true, the page will be stored in the Firecrawl index and cache.
            Setting this to false is useful if your scraping activity may have
            data protection concerns. Using some parameters associated with
            sensitive scraping (e.g. actions, headers) will force this parameter
            to be false.
          default: true
        lockdown:
          type: boolean
          description: >-
            If true, serves the request from Firecrawl's cache only and never
            makes an outbound request to the target URL. Designed for
            compliance-constrained or air-gapped environments where the scrape
            request itself could leak sensitive information. On cache miss,
            returns a 404 with error code SCRAPE_LOCKDOWN_CACHE_MISS (the URL is
            never logged on miss). Lockdown requests are treated as zero data
            retention. Default maxAge is extended to 2 years so existing cached
            pages remain eligible. Billed at 5 credits on hit, 1 credit on cache
            miss.
          default: false
        redactPII:
          oneOf:
            - type: boolean
            - $ref: '#/components/schemas/RedactPIIOptions'
          default: false
          description: >-
            Redact personally identifiable information from returned markdown.
            Pass `true` to use defaults, or an object to tune mode, entities,
            and replacement style.
        profile:
          type: object
          description: >-
            Enable persistent browser storage across scrape and interact
            sessions. Pass a profile when scraping to preserve cookies,
            localStorage, and session data. Sessions with the same profile name
            share browser state.
          properties:
            name:
              type: string
              minLength: 1
              maxLength: 128
              description: >-
                A name for the profile. Scrapes with the same name share browser
                state (cookies, localStorage, sessions).
            saveChanges:
              type: boolean
              default: true
              description: >-
                When true, browser state is saved back to the profile when the
                interact session stops. Set to false to load existing data
                without writing. Only one saving session is allowed at a time.
          required:
            - name
        threatProtection:
          $ref: '#/components/schemas/ThreatProtectionOverride'
        auditMetadata:
          $ref: '#/components/schemas/AuditMetadata'
    CrawlResponse:
      type: object
      properties:
        success:
          type: boolean
        id:
          type: string
        url:
          type: string
          format: uri
    Formats:
      type: array
      items:
        oneOf:
          - type: object
            title: Markdown
            properties:
              type:
                type: string
                enum:
                  - markdown
            required:
              - type
          - type: object
            title: Summary
            properties:
              type:
                type: string
                enum:
                  - summary
            required:
              - type
          - type: object
            title: HTML
            properties:
              type:
                type: string
                enum:
                  - html
            required:
              - type
          - type: object
            title: Raw HTML
            properties:
              type:
                type: string
                enum:
                  - rawHtml
            required:
              - type
          - type: object
            title: Raw Base64
            properties:
              type:
                type: string
                enum:
                  - rawBase64
            required:
              - type
          - type: object
            title: Links
            properties:
              type:
                type: string
                enum:
                  - links
            required:
              - type
          - type: object
            title: Images
            properties:
              type:
                type: string
                enum:
                  - images
            required:
              - type
          - type: object
            title: Screenshot
            properties:
              type:
                type: string
                enum:
                  - screenshot
              fullPage:
                type: boolean
                description: >-
                  Whether to capture a full-page screenshot (ignores
                  viewport.height) or limit to the current viewport.
                default: false
              quality:
                type: integer
                description: >-
                  The quality of the screenshot, from 1 to 100. 100 is the
                  highest quality.
              viewport:
                type: object
                properties:
                  width:
                    type: integer
                    description: The width of the viewport in pixels
                  height:
                    type: integer
                    description: The height of the viewport in pixels
                required:
                  - width
                  - height
            required:
              - type
          - type: object
            title: JSON
            properties:
              type:
                type: string
                enum:
                  - json
              schema:
                type: object
                description: >-
                  The schema to use for the JSON output. Must conform to [JSON
                  Schema](https://json-schema.org/).
              prompt:
                type: string
                description: The prompt to use for the JSON output
              checkPromptInjection:
                type: boolean
                description: >-
                  When enabled, scans the scraped page content for prompt
                  injection attempts before running the extraction. If an
                  injection is detected, the request fails with a 403 and error
                  code SCRAPE_PROMPT_INJECTION_DETECTED. Adds 4 credits when the
                  check runs. Defaults to false.
                default: false
            required:
              - type
          - type: object
            title: Change Tracking
            properties:
              type:
                type: string
                enum:
                  - changeTracking
              modes:
                type: array
                items:
                  type: string
                  enum:
                    - git-diff
                    - json
                description: >-
                  The mode to use for change tracking. 'git-diff' provides a
                  detailed diff, and 'json' compares extracted JSON data.
              schema:
                type: object
                description: >-
                  Schema for JSON extraction when using 'json' mode. Defines the
                  structure of data to extract and compare. Must conform to
                  [JSON Schema](https://json-schema.org/).
              prompt:
                type: string
                description: >-
                  Prompt to use for change tracking when using 'json' mode. If
                  not provided, the default prompt will be used.
              tag:
                type: string
                nullable: true
                default: null
                description: >-
                  Tag to use for change tracking. Tags can separate change
                  tracking history into separate "branches", where change
                  tracking with a specific tagwill only compare to scrapes made
                  in the same tag. If not provided, the default tag (null) will
                  be used.
            required:
              - type
          - type: object
            title: Branding
            properties:
              type:
                type: string
                enum:
                  - branding
            required:
              - type
          - type: object
            title: Product
            properties:
              type:
                type: string
                enum:
                  - product
            required:
              - type
          - type: object
            title: Menu
            properties:
              type:
                type: string
                enum:
                  - menu
            required:
              - type
          - type: object
            title: Audio
            description: >-
              Extract audio (MP3) from supported video URLs, e.g. YouTube.
              Returns a signed GCS URL.
            properties:
              type:
                type: string
                enum:
                  - audio
            required:
              - type
          - type: object
            title: Video
            description: >-
              Extract best-quality video from supported video URLs, e.g.
              YouTube. Returns a signed GCS URL.
            properties:
              type:
                type: string
                enum:
                  - video
            required:
              - type
          - type: object
            title: Question
            description: >-
              Ask a natural-language question about the page. Returns the answer
              in the response `answer` field.
            properties:
              type:
                type: string
                enum:
                  - question
              question:
                type: string
                maxLength: 10000
                description: >-
                  The question to answer about the page. Maximum 10,000
                  characters.
            required:
              - type
              - question
          - type: object
            title: Highlights
            description: >-
              Find relevant source text from the page. Returns the selected text
              in the response `highlights` field.
            properties:
              type:
                type: string
                enum:
                  - highlights
              query:
                type: string
                maxLength: 10000
                description: >-
                  The text-selection query to run against the page. Maximum
                  10,000 characters.
            required:
              - type
              - query
      description: >-
        Output formats to include in the response. You can specify one or more
        formats, either as strings (e.g., `'markdown'`) or as objects with
        additional options (e.g., `{ type: 'json', schema: {...} }`). Some
        formats require specific options to be set. Example: `['markdown', {
        type: 'json', schema: {...} }]`.
      default:
        - markdown
    RedactPIIOptions:
      type: object
      description: Tuning options for PII redaction.
      properties:
        mode:
          type: string
          enum:
            - accurate
            - aggressive
            - fast
          default: accurate
          description: >-
            Redaction strategy. `accurate` is model-only and optimized for
            precision, `aggressive` increases recall with additional heuristics,
            and `fast` uses heuristics without the model call.
        entities:
          type: array
          description: >-
            Restrict redaction to these entity buckets. If omitted, all
            supported entities are redacted.
          items:
            $ref: '#/components/schemas/RedactPIIEntity'
        replaceStyle:
          type: string
          enum:
            - tag
            - mask
            - remove
          default: tag
          description: >-
            `tag` replaces spans with placeholders like `<EMAIL>`, `mask`
            replaces characters with `*`, and `remove` deletes the span text.
      additionalProperties: false
    ThreatProtectionOverride:
      type: object
      title: Threat Protection Override
      description: >-
        Per-request [Threat
        Protection](https://docs.firecrawl.dev/features/threat-protection)
        override. Fields you provide replace the corresponding fields of your
        organization's policy for this request only; omitted fields keep their
        organization-level values. Requires Threat Protection to be enabled for
        your team (enterprise feature) — otherwise the request is rejected with
        a 403. If your organization has disabled request overrides, any request
        that includes this object is rejected with a 403. If Threat Protection
        is enforced for your team, `mode` may not be set to `off`.
      properties:
        mode:
          type: string
          enum:
            - 'off'
            - normal
          description: >-
            URL scanning mode for this request. `normal` checks URLs against
            Google Web Risk (+2 credits per URL scanned).
        riskScoreThreshold:
          type: integer
          minimum: 0
          maximum: 100
          description: >-
            Normalized risk score (0–100) at or above which a classifier verdict
            blocks the URL. Lower is stricter.
          example: 75
        blacklist:
          type: array
          maxItems: 1000
          items:
            type: string
          description: >-
            Domains to always block, as plain domains (`example.com`) or
            wildcard globs (`*.example.com`). No protocol, path, or port.
        whitelist:
          type: array
          maxItems: 1000
          items:
            type: string
          description: >-
            Domains to always allow, as plain domains or wildcard globs. Wins
            over every other rule.
        blockedTlds:
          type: array
          maxItems: 1000
          items:
            type: string
          description: >-
            Top-level domains to block outright, lowercase without the leading
            dot (e.g. `zip`).
        failurePolicy:
          type: string
          enum:
            - open
            - closed
          description: >-
            What to do when the classifier can't be reached: `closed` blocks the
            request, `open` allows it.
    AuditMetadata:
      type: object
      description: >-
        User attribution included with SIEM logging events when SIEM Logging is
        enabled for the organization.
      additionalProperties: false
      required:
        - username
      properties:
        username:
          type: string
          maxLength: 1024
          description: The username associated with the request.
    RedactPIIEntity:
      type: string
      enum:
        - PERSON
        - EMAIL
        - PHONE
        - LOCATION
        - FINANCIAL
        - SECRET
      description: Public PII entity buckets supported by Firecrawl redaction.
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
