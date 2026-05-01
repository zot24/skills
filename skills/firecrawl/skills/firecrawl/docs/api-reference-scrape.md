> Source: https://docs.firecrawl.dev/api-reference/endpoint/scrape.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Scrape

## Interactions

For browser interactions (clicking, typing, navigating, extracting dynamic content), use the [Interact endpoint](/features/interact). Scrape a page first, then call `POST /v2/scrape/{scrapeId}/interact` with a natural-language prompt or Playwright code to take actions on the page.

See the [Interact documentation](/features/interact) for full details and examples.

Optionally you can also use the `actions` parameter, although it's not recommended to use it for complex interactions.

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml /api-reference/v2-openapi.json POST /scrape
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
  /scrape:
    post:
      tags:
        - Scraping
      summary: Scrape a single URL and optionally extract information using an LLM
      operationId: scrapeAndExtractFromUrl
      requestBody:
        required: true
        content:
          application/json:
            schema:
              allOf:
                - type: object
                  properties:
                    url:
                      type: string
                      format: uri
                      description: The URL to scrape
                  required:
                    - url
                - $ref: '#/components/schemas/ScrapeOptions'
                - type: object
                  properties:
                    zeroDataRetention:
                      type: boolean
                      default: false
                      description: >-
                        If true, this will enable zero data retention for this
                        scrape. To enable this feature, please contact
                        help@firecrawl.dev
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ScrapeResponse'
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
                  success:
                    type: boolean
                    example: false
                  code:
                    type: string
                    example: UNKNOWN_ERROR
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
    ScrapeResponse:
      type: object
      properties:
        success:
          type: boolean
        data:
          type: object
          properties:
            markdown:
              type: string
            summary:
              type: string
              nullable: true
              description: Summary of the page if `summary` is in `formats`
            html:
              type: string
              nullable: true
              description: >-
                Cleaned HTML of the page if `html` is in `formats`. Removes
                `<script>`, `<style>`, `<noscript>`, `<meta>`, and `<head>`
                tags; converts relative URLs to absolute; resolves responsive
                image `srcset` to the largest version. Respects
                `onlyMainContent`, `includeTags`, and `excludeTags` filters.
            rawHtml:
              type: string
              nullable: true
              description: >-
                The exact, unmodified HTML as received from the page if
                `rawHtml` is in `formats`. No cleaning or filtering is applied.
            screenshot:
              type: string
              nullable: true
              description: >-
                Screenshot of the page if `screenshot` is in `formats`.
                Screenshots expire after 24 hours and can no longer be
                downloaded.
            audio:
              type: string
              nullable: true
              description: >-
                Signed URL to the extracted MP3 audio file if `audio` is in
                `formats`. The signed URL expires after 1 hour.
            links:
              type: array
              items:
                type: string
              description: List of links on the page if `links` is in `formats`
            actions:
              type: object
              nullable: true
              description: >-
                Results of the actions specified in the `actions` parameter.
                Only present if the `actions` parameter was provided in the
                request
              properties:
                screenshots:
                  type: array
                  description: >-
                    Screenshot URLs, in the same order as the screenshot actions
                    provided.
                  items:
                    type: string
                    format: url
                scrapes:
                  type: array
                  description: >-
                    Scrape contents, in the same order as the scrape actions
                    provided.
                  items:
                    type: object
                    properties:
                      url:
                        type: string
                      html:
                        type: string
                javascriptReturns:
                  type: array
                  description: >-
                    JavaScript return values, in the same order as the
                    executeJavascript actions provided.
                  items:
                    type: object
                    properties:
                      type:
                        type: string
                      value: {}
                pdfs:
                  type: array
                  description: >-
                    PDFs generated, in the same order as the pdf actions
                    provided.
                  items:
                    type: string
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
                  oneOf:
                    - type: string
                    - type: array
                      items:
                        type: string
                  description: >-
                    Other metadata extracted from HTML, can be a string or array
                    of strings
                statusCode:
                  type: integer
                  description: The status code of the page
                contentType:
                  type: string
                  description: >-
                    The content type (MIME type) of the page, e.g. text/html,
                    application/pdf
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
            warning:
              type: string
              nullable: true
              description: >-
                Can be displayed when using LLM Extraction. Warning message will
                let you know any issues with the extraction.
            changeTracking:
              type: object
              nullable: true
              description: >-
                Change tracking information if `changeTracking` is in `formats`.
                Only present when the `changeTracking` format is requested.
              properties:
                previousScrapeAt:
                  type: string
                  format: date-time
                  nullable: true
                  description: >-
                    The timestamp of the previous scrape that the current page
                    is being compared against. Null if no previous scrape
                    exists.
                changeStatus:
                  type: string
                  enum:
                    - new
                    - same
                    - changed
                    - removed
                  description: >-
                    The result of the comparison between the two page versions.
                    'new' means this page did not exist before, 'same' means
                    content has not changed, 'changed' means content has
                    changed, 'removed' means the page was removed.
                visibility:
                  type: string
                  enum:
                    - visible
                    - hidden
                  description: >-
                    The visibility of the current page/URL. 'visible' means the
                    URL was discovered through an organic route (links or
                    sitemap), 'hidden' means the URL was discovered through
                    memory from previous crawls.
                diff:
                  type: string
                  nullable: true
                  description: >-
                    Git-style diff of changes when using 'git-diff' mode. Only
                    present when the mode is set to 'git-diff'.
                json:
                  type: object
                  nullable: true
                  description: >-
                    JSON comparison results when using 'json' mode. Only present
                    when the mode is set to 'json'. This will emit a list of all
                    the keys and their values from the `previous` and `current`
                    scrapes based on the type defined in the `schema`. Example
                    [here](/features/change-tracking)
            branding:
              type: object
              nullable: true
              description: >-
                Branding information extracted from the page if `branding` is in
                `formats`. Includes colors, fonts, typography, spacing,
                components, and more.
              properties:
                colorScheme:
                  type: string
                  enum:
                    - light
                    - dark
                  description: The detected color scheme of the page.
                logo:
                  type: string
                  nullable: true
                  description: URL of the primary logo.
                colors:
                  type: object
                  nullable: true
                  description: Brand colors extracted from the page.
                  properties:
                    primary:
                      type: string
                      description: Primary brand color (hex).
                    secondary:
                      type: string
                      description: Secondary brand color (hex).
                    accent:
                      type: string
                      description: Accent color (hex).
                    background:
                      type: string
                      description: Background color (hex).
                    textPrimary:
                      type: string
                      description: Primary text color (hex).
                    textSecondary:
                      type: string
                      description: Secondary text color (hex).
                    link:
                      type: string
                      description: Link color (hex).
                    success:
                      type: string
                      description: Success/positive color (hex).
                    warning:
                      type: string
                      description: Warning color (hex).
                    error:
                      type: string
                      description: Error/danger color (hex).
                fonts:
                  type: array
                  nullable: true
                  description: Array of font families used on the page.
                  items:
                    type: object
                    properties:
                      family:
                        type: string
                        description: Font family name.
                typography:
                  type: object
                  nullable: true
                  description: Detailed typography information.
                  properties:
                    fontFamilies:
                      type: object
                      description: Font families by role.
                      properties:
                        primary:
                          type: string
                          description: Primary font family.
                        heading:
                          type: string
                          description: Heading font family.
                        code:
                          type: string
                          description: Code/monospace font family.
                    fontSizes:
                      type: object
                      description: Font sizes for different text levels.
                      properties:
                        h1:
                          type: string
                        h2:
                          type: string
                        h3:
                          type: string
                        body:
                          type: string
                    fontWeights:
                      type: object
                      description: Font weight definitions.
                      properties:
                        light:
                          type: integer
                        regular:
                          type: integer
                        medium:
                          type: integer
                        bold:
                          type: integer
                    lineHeights:
                      type: object
                      description: Line height values for different text types.
                      properties:
                        heading:
                          type: string
                        body:
                          type: string
                spacing:
                  type: object
                  nullable: true
                  description: Spacing and layout information.
                  properties:
                    baseUnit:
                      type: integer
                      description: Base spacing unit in pixels.
                    borderRadius:
                      type: string
                      description: Default border radius.
                    padding:
                      type: object
                      description: Padding values.
                    margins:
                      type: object
                      description: Margin values.
                components:
                  type: object
                  nullable: true
                  description: UI component styles.
                  properties:
                    buttonPrimary:
                      type: object
                      description: Primary button styles.
                      properties:
                        background:
                          type: string
                        textColor:
                          type: string
                        borderRadius:
                          type: string
                    buttonSecondary:
                      type: object
                      description: Secondary button styles.
                      properties:
                        background:
                          type: string
                        textColor:
                          type: string
                        borderColor:
                          type: string
                        borderRadius:
                          type: string
                    input:
                      type: object
                      description: Input field styles.
                icons:
                  type: object
                  nullable: true
                  description: Icon style information.
                images:
                  type: object
                  nullable: true
                  description: Brand images.
                  properties:
                    logo:
                      type: string
                      description: Logo image URL.
                    favicon:
                      type: string
                      description: Favicon URL.
                    ogImage:
                      type: string
                      description: Open Graph image URL.
                animations:
                  type: object
                  nullable: true
                  description: Animation and transition settings.
                layout:
                  type: object
                  nullable: true
                  description: Layout configuration (grid, header/footer heights).
                personality:
                  type: object
                  nullable: true
                  description: Brand personality traits (tone, energy, target audience).
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
