> Source: https://docs.firecrawl.dev/api-reference/endpoint/monitor-update.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Update Monitor


## OpenAPI

````yaml /api-reference/v2-openapi.json PATCH /monitor/{monitorId}
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
  /monitor/{monitorId}:
    patch:
      tags:
        - Monitoring
      summary: Update a monitor
      operationId: updateMonitor
      parameters:
        - $ref: '#/components/parameters/MonitorId'
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/MonitorUpdateRequest'
            example:
              schedule:
                text: every 15 minutes starting at :07
              status: active
      responses:
        '200':
          description: Monitor updated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/MonitorResponse'
        '404':
          description: Monitor not found
      security:
        - bearerAuth: []
components:
  parameters:
    MonitorId:
      name: monitorId
      in: path
      required: true
      schema:
        type: string
        format: uuid
      description: The monitor ID
  schemas:
    MonitorUpdateRequest:
      type: object
      description: Partial monitor update payload. Include at least one field.
      properties:
        name:
          type: string
          maxLength: 256
        schedule:
          $ref: '#/components/schemas/MonitorSchedule'
        webhook:
          $ref: '#/components/schemas/MonitorWebhook'
        notification:
          $ref: '#/components/schemas/MonitorNotification'
        targets:
          type: array
          minItems: 1
          maxItems: 50
          items:
            $ref: '#/components/schemas/MonitorTarget'
        retentionDays:
          type: integer
          minimum: 1
          maximum: 365
        goal:
          type: string
          maxLength: 2000
          nullable: true
          description: >-
            Plain-language goal used to judge whether changed pages are
            meaningful. If provided and `judgeEnabled` is omitted, judging is
            enabled automatically.
        judgeEnabled:
          type: boolean
          description: >-
            Whether to judge changed pages against `goal`. Requires a non-empty
            `goal` to run.
        status:
          type: string
          enum:
            - active
            - paused
    MonitorResponse:
      type: object
      properties:
        success:
          type: boolean
        data:
          $ref: '#/components/schemas/Monitor'
    MonitorSchedule:
      type: object
      description: Schedule for monitor checks. Provide either `cron` or `text`.
      properties:
        cron:
          type: string
          description: Five-field cron expression. Minimum interval is 15 minutes.
          example: '*/30 * * * *'
        text:
          type: string
          description: >-
            Natural language schedule. Supported examples include `every 30
            minutes`, `every 15 minutes starting at :07`, `hourly`, `every 2
            hours`, `daily`, `daily at 9:00`, `daily at 9am`, `daily at 5:30
            PM`, and `weekly`.
          example: every 30 minutes
        timezone:
          type: string
          default: UTC
          description: IANA timezone for the schedule.
          example: UTC
    MonitorWebhook:
      type: object
      description: Webhook destination for monitor page and check completion events.
      properties:
        url:
          type: string
          format: uri
          description: The URL to send monitor webhooks to.
        headers:
          type: object
          description: Headers to send to the webhook URL.
          additionalProperties:
            type: string
        metadata:
          type: object
          description: Custom metadata included in webhook payloads.
          additionalProperties: true
        events:
          type: array
          description: Monitor webhook events to receive. Defaults to all monitor events.
          items:
            type: string
            enum:
              - monitor.page
              - monitor.check.completed
      required:
        - url
    MonitorNotification:
      type: object
      properties:
        email:
          type: object
          properties:
            enabled:
              type: boolean
              default: false
            recipients:
              type: array
              maxItems: 25
              items:
                type: string
                format: email
            includeDiffs:
              type: boolean
              default: false
              description: Include changed page details in email summaries.
    MonitorTarget:
      oneOf:
        - type: object
          title: Scrape target
          properties:
            id:
              type: string
              format: uuid
              description: Optional stable ID for this target. Generated if omitted.
            type:
              type: string
              enum:
                - scrape
            urls:
              type: array
              minItems: 1
              items:
                type: string
                format: uri
            scrapeOptions:
              $ref: '#/components/schemas/ScrapeOptions'
          required:
            - type
            - urls
        - type: object
          title: Crawl target
          properties:
            id:
              type: string
              format: uuid
              description: Optional stable ID for this target. Generated if omitted.
            type:
              type: string
              enum:
                - crawl
            url:
              type: string
              format: uri
            crawlOptions:
              type: object
              description: >-
                Crawl options such as `limit`, `maxDepth`, `includePaths`, and
                `excludePaths`.
            scrapeOptions:
              $ref: '#/components/schemas/ScrapeOptions'
          required:
            - type
            - url
    Monitor:
      type: object
      properties:
        id:
          type: string
          format: uuid
        name:
          type: string
        status:
          type: string
          enum:
            - active
            - paused
            - deleted
        schedule:
          type: object
          properties:
            cron:
              type: string
            timezone:
              type: string
        nextRunAt:
          type: string
          format: date-time
          nullable: true
        lastRunAt:
          type: string
          format: date-time
          nullable: true
        currentCheckId:
          type: string
          format: uuid
          nullable: true
        targets:
          type: array
          items:
            $ref: '#/components/schemas/MonitorTarget'
        webhook:
          $ref: '#/components/schemas/MonitorWebhook'
        notification:
          $ref: '#/components/schemas/MonitorNotification'
        retentionDays:
          type: integer
        estimatedCreditsPerMonth:
          type: integer
          nullable: true
          description: >-
            Upper-bound monthly credit estimate. When judging is enabled, actual
            usage may be lower because judge credits are only charged for
            changed pages that are judged.
        lastCheckSummary:
          $ref: '#/components/schemas/MonitorSummary'
        goal:
          type: string
          nullable: true
        judgeEnabled:
          type: boolean
        createdAt:
          type: string
          format: date-time
        updatedAt:
          type: string
          format: date-time
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
             - **enhanced**: Enhanced proxies for scraping sites with advanced anti-bot solutions. Slower, but more reliable on certain sites. Costs up to 5 credits per request.
             - **auto**: Firecrawl will automatically retry scraping with enhanced proxies if the basic proxy fails. If the retry with enhanced is successful, 5 credits will be billed for the scrape. If the first attempt with basic is successful, only the regular cost will be billed.
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
    MonitorSummary:
      type: object
      properties:
        totalPages:
          type: integer
        same:
          type: integer
        changed:
          type: integer
        new:
          type: integer
        removed:
          type: integer
        error:
          type: integer
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
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
