> Source: https://docs.firecrawl.dev/api-reference/endpoint/parse.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Parse

Upload a local or non-public document and convert it into clean, LLM-ready data. `/parse` accepts file bytes via `multipart/form-data` and returns Markdown, JSON, HTML, links, images, or a summary — with reading order and tables preserved.

* Turn PDF, DOCX, XLSX, HTML, and more into Markdown or structured JSON
* Up to **5x faster** parsing via a Rust-based engine
* Files up to **50 MB** per request
* Zero Data Retention support

## When to use `/parse`

Use `/parse` when the source document is **a local file** or **not publicly accessible by URL**. If you have a public URL that points to a document, prefer [`/scrape`](/api-reference/endpoint/scrape) — it auto-detects the file type from the extension or content type and parses it the same way.

| Source                                                           | Endpoint                                         |
| ---------------------------------------------------------------- | ------------------------------------------------ |
| Public URL to a document (e.g. `https://example.com/report.pdf`) | [`POST /scrape`](/api-reference/endpoint/scrape) |
| Local file or non-public bytes (PDF, DOCX, XLSX, HTML, …)        | `POST /parse` (this endpoint)                    |


## OpenAPI

````yaml /api-reference/v2-openapi.json POST /parse
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
  /parse:
    post:
      tags:
        - Scraping
      summary: Upload and parse a file
      operationId: parseFile
      requestBody:
        required: true
        content:
          multipart/form-data:
            schema:
              type: object
              properties:
                file:
                  type: string
                  format: binary
                  description: >-
                    The file bytes to parse. Supported extensions: .html, .htm,
                    .pdf, .docx, .doc, .odt, .rtf, .xlsx, .xls.
                options:
                  $ref: '#/components/schemas/ParseOptions'
              required:
                - file
            encoding:
              options:
                contentType: application/json
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ScrapeResponse'
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
                  code:
                    type: string
                    example: BAD_REQUEST
                  error:
                    type: string
                    example: Invalid multipart form-data request.
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
    ParseOptions:
      type: object
      description: Optional parse options sent as JSON in the multipart `options` field.
      properties:
        formats:
          $ref: '#/components/schemas/ParseFormats'
        onlyMainContent:
          type: boolean
          description: >-
            Only return the main content of the page excluding headers, navs,
            footers, etc.
          default: true
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
        headers:
          type: object
          description: Headers to send when additional network requests are required.
        timeout:
          type: integer
          description: >-
            Timeout in milliseconds for the request. Default is 30000 (30
            seconds). Maximum is 300000 (300 seconds).
          default: 30000
          maximum: 300000
        parsers:
          type: array
          description: >-
            Controls file parser behavior when relevant (for example PDF parser
            mode).
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
                      PDF parsing mode. "fast": text-only extraction. "auto":
                      text-first with OCR fallback. "ocr": OCR on every page.
                  maxPages:
                    type: integer
                    minimum: 1
                    maximum: 10000
                    description: Maximum number of pages to parse from the PDF.
                required:
                  - type
                additionalProperties: false
          default:
            - pdf
        skipTlsVerification:
          type: boolean
          description: Skip TLS certificate verification when making requests.
          default: true
        removeBase64Images:
          type: boolean
          description: >-
            Remove base64-encoded images from output and keep alt text
            placeholders.
          default: true
        blockAds:
          type: boolean
          description: Enable ad and cookie popup blocking.
          default: true
        proxy:
          type: string
          enum:
            - basic
            - auto
          description: >-
            Proxy mode for parse uploads. `/parse` supports only `basic` and
            `auto`.
        origin:
          type: string
          description: Origin identifier for analytics and logging.
          default: api
        integration:
          type: string
          nullable: true
          description: Optional integration identifier.
        zeroDataRetention:
          type: boolean
          default: false
          description: >-
            If true, this will enable zero data retention for this parse. To
            enable this feature, please contact help@firecrawl.dev
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
    ParseFormats:
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
      description: >-
        Output formats supported for `/parse` uploads. Browser-rendering formats
        and change tracking are not supported.
      default:
        - markdown
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
