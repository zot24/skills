> Source: https://docs.firecrawl.dev/api-reference/endpoint/search.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Search

The search endpoint combines web search with Firecrawl's scraping capabilities to return full page content for any query.

Include `scrapeOptions` with `formats: [{"type": "markdown"}]` to get complete markdown content for each search result otherwise you will default to getting the results (url, title, description). You can also use other formats like `{"type": "summary"}` for condensed content.

## Supported query operators

We support a variety of query operators that allow you to filter your searches better.

| Operator      | Functionality                                                             | Examples                          |
| ------------- | ------------------------------------------------------------------------- | --------------------------------- |
| `""`          | Non-fuzzy matches a string of text                                        | `"Firecrawl"`                     |
| `-`           | Excludes certain keywords or negates other operators                      | `-bad`, `-site:firecrawl.dev`     |
| `site:`       | Only returns results from a specified website                             | `site:firecrawl.dev`              |
| `filetype:`   | Only returns results with a specific file extension                       | `filetype:pdf`, `-filetype:pdf`   |
| `inurl:`      | Only returns results that include a word in the URL                       | `inurl:firecrawl`                 |
| `allinurl:`   | Only returns results that include multiple words in the URL               | `allinurl:git firecrawl`          |
| `intitle:`    | Only returns results that include a word in the title of the page         | `intitle:Firecrawl`               |
| `allintitle:` | Only returns results that include multiple words in the title of the page | `allintitle:firecrawl playground` |
| `related:`    | Only returns results that are related to a specific domain                | `related:firecrawl.dev`           |
| `imagesize:`  | Only returns images with exact dimensions                                 | `imagesize:1920x1080`             |
| `larger:`     | Only returns images larger than specified dimensions                      | `larger:1920x1080`                |

## Location Parameter

Use the `location` parameter to get geo-targeted search results. Format: `"string"`. Examples: `"Germany"`, `"San Francisco,California,United States"`.

See the [complete list of supported locations](https://firecrawl.dev/search_locations.json) for all available countries and languages.

## Country Parameter

Use the `country` parameter to specify the country for search results using ISO country codes. Default: `"US"`.

Examples: `"US"`, `"DE"`, `"FR"`, `"JP"`, `"UK"`, `"CA"`.

```json
{
  "query": "restaurants",
  "country": "DE"
}
```

## Categories Parameter

Filter search results by specific categories using the `categories` parameter:

* **`github`**: Search within GitHub repositories, code, issues, and documentation
* **`research`**: Search academic and research websites (arXiv, Nature, IEEE, PubMed, etc.)
* **`pdf`**: Search for PDFs

### Example Usage

```json
{
  "query": "machine learning",
  "categories": ["github", "research"],
  "limit": 10
}
```

### Category Response

Each result includes a `category` field indicating its source:

```json
{
  "success": true,
  "data": {
    "web": [
      {
        "url": "https://github.com/example/ml-project",
        "title": "Machine Learning Project",
        "description": "Implementation of ML algorithms",
        "category": "github"
      },
      {
        "url": "https://arxiv.org/abs/2024.12345",
        "title": "ML Research Paper",
        "description": "Latest advances in machine learning",
        "category": "research"
      }
    ]
  }
}
```

## Time-Based Search

Use the `tbs` parameter to filter results by time periods, including custom date ranges. See the [Search Feature documentation](https://docs.firecrawl.dev/features/search#time-based-search) for detailed examples and supported formats.

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml /api-reference/v2-openapi.json POST /search
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
  /search:
    post:
      tags:
        - Search
      summary: Search and optionally scrape search results
      operationId: searchAndScrape
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                query:
                  type: string
                  description: The search query
                  maxLength: 500
                limit:
                  type: integer
                  description: >-
                    Maximum number of results to return (per source type when
                    using multiple sources)
                  default: 10
                  maximum: 100
                  minimum: 1
                sources:
                  type: array
                  items:
                    oneOf:
                      - type: object
                        title: Web
                        properties:
                          type:
                            type: string
                            enum:
                              - web
                          tbs:
                            type: string
                            description: >-
                              Time-based search parameter. Supports predefined
                              time ranges (`qdr:h`, `qdr:d`, `qdr:w`, `qdr:m`,
                              `qdr:y`), custom date ranges
                              (`cdr:1,cd_min:MM/DD/YYYY,cd_max:MM/DD/YYYY`), and
                              sort by date (`sbd:1`). Values can be combined,
                              e.g. `sbd:1,qdr:w`.
                          location:
                            type: string
                            description: Location parameter for search results
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
                        title: News
                        properties:
                          type:
                            type: string
                            enum:
                              - news
                        required:
                          - type
                  description: >-
                    Sources to search. Will determine the arrays available in
                    the response. Defaults to ['web'].
                  default:
                    - web
                categories:
                  type: array
                  items:
                    oneOf:
                      - type: object
                        title: GitHub
                        properties:
                          type:
                            type: string
                            enum:
                              - github
                        required:
                          - type
                      - type: object
                        title: Research
                        properties:
                          type:
                            type: string
                            enum:
                              - research
                        required:
                          - type
                      - type: object
                        title: PDF
                        properties:
                          type:
                            type: string
                            enum:
                              - pdf
                        required:
                          - type
                  description: >-
                    Categories to filter results by. Defaults to [], which means
                    results will not be filtered by any categories.
                tbs:
                  type: string
                  description: >-
                    Time-based search parameter. Supports predefined time ranges
                    (`qdr:h`, `qdr:d`, `qdr:w`, `qdr:m`, `qdr:y`), custom date
                    ranges (`cdr:1,cd_min:MM/DD/YYYY,cd_max:MM/DD/YYYY`), and
                    sort by date (`sbd:1`). Values can be combined, e.g.
                    `sbd:1,qdr:w`.
                location:
                  type: string
                  description: >-
                    Location parameter for search results (e.g. `San
                    Francisco,California,United States`). For best results, set
                    both this and the `country` parameter.
                country:
                  type: string
                  description: >-
                    ISO country code for geo-targeting search results (e.g.
                    `US`). For best results, set both this and the `location`
                    parameter.
                  default: US
                timeout:
                  type: integer
                  description: Timeout in milliseconds
                  default: 60000
                ignoreInvalidURLs:
                  type: boolean
                  description: >-
                    Excludes URLs from the search results that are invalid for
                    other Firecrawl endpoints. This helps reduce errors if you
                    are piping data from search into other Firecrawl API
                    endpoints.
                  default: false
                enterprise:
                  type: array
                  items:
                    type: string
                    enum:
                      - anon
                      - zdr
                  description: >-
                    Enterprise search options for Zero Data Retention (ZDR). Use
                    `["zdr"]` for end-to-end ZDR (10 credits / 10 results) or
                    `["anon"]` for anonymized ZDR (2 credits / 10 results). Must
                    be enabled for your team.
                scrapeOptions:
                  allOf:
                    - $ref: '#/components/schemas/ScrapeOptions'
                  description: Options for scraping search results
                  default: {}
              required:
                - query
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                  data:
                    type: object
                    properties:
                      web:
                        type: array
                        items:
                          type: object
                          properties:
                            title:
                              type: string
                              description: Title from search result
                            description:
                              type: string
                              description: Description from search result
                            url:
                              type: string
                              description: URL of the search result
                            markdown:
                              type: string
                              nullable: true
                              description: Markdown content if scraping was requested
                            html:
                              type: string
                              nullable: true
                              description: HTML content if requested in formats
                            rawHtml:
                              type: string
                              nullable: true
                              description: Raw HTML content if requested in formats
                            links:
                              type: array
                              items:
                                type: string
                              description: Links found if requested in formats
                            screenshot:
                              type: string
                              nullable: true
                              description: >-
                                Screenshot URL if requested in formats.
                                Screenshots expire after 24 hours and can no
                                longer be downloaded.
                            audio:
                              type: string
                              nullable: true
                              description: >-
                                Signed URL to the extracted MP3 audio file if
                                `audio` is in `formats`. The signed URL expires
                                after 1 hour.
                            metadata:
                              type: object
                              properties:
                                title:
                                  type: string
                                description:
                                  type: string
                                sourceURL:
                                  type: string
                                  description: >-
                                    The original URL that was requested. May
                                    differ from the page's final URL if
                                    redirects occurred.
                                url:
                                  type: string
                                  description: >-
                                    The final URL of the page after all
                                    redirects have been followed.
                                statusCode:
                                  type: integer
                                error:
                                  type: string
                                  nullable: true
                      images:
                        type: array
                        items:
                          type: object
                          properties:
                            title:
                              type: string
                              description: Title from search result
                            imageUrl:
                              type: string
                              description: URL of the image
                            imageWidth:
                              type: integer
                              description: Width of the image
                            imageHeight:
                              type: integer
                              description: Height of the image
                            url:
                              type: string
                              description: URL of the search result
                            position:
                              type: integer
                              description: Position of the search result
                      news:
                        type: array
                        items:
                          type: object
                          properties:
                            title:
                              type: string
                              description: Title of the article
                            snippet:
                              type: string
                              description: Snippet from the article
                            url:
                              type: string
                              description: URL of the article
                            date:
                              type: string
                              description: Date of the article
                            imageUrl:
                              type: string
                              description: Image URL of the article
                            position:
                              type: integer
                              description: Position of the article
                            markdown:
                              type: string
                              nullable: true
                              description: Markdown content if scraping was requested
                            html:
                              type: string
                              nullable: true
                              description: HTML content if requested in formats
                            rawHtml:
                              type: string
                              nullable: true
                              description: Raw HTML content if requested in formats
                            links:
                              type: array
                              items:
                                type: string
                              description: Links found if requested in formats
                            screenshot:
                              type: string
                              nullable: true
                              description: >-
                                Screenshot URL if requested in formats.
                                Screenshots expire after 24 hours and can no
                                longer be downloaded.
                            audio:
                              type: string
                              nullable: true
                              description: >-
                                Signed URL to the extracted MP3 audio file if
                                `audio` is in `formats`. The signed URL expires
                                after 1 hour.
                            metadata:
                              type: object
                              properties:
                                title:
                                  type: string
                                description:
                                  type: string
                                sourceURL:
                                  type: string
                                  description: >-
                                    The original URL that was requested. May
                                    differ from the page's final URL if
                                    redirects occurred.
                                url:
                                  type: string
                                  description: >-
                                    The final URL of the page after all
                                    redirects have been followed.
                                statusCode:
                                  type: integer
                                error:
                                  type: string
                                  nullable: true
                    description: >-
                      The search results. The arrays available will depend on
                      the sources you specified in the request. By default, the
                      `web` array will be returned.
                  warning:
                    type: string
                    nullable: true
                    description: Warning message if any issues occurred
                  id:
                    type: string
                    description: The ID of the search job
                  creditsUsed:
                    type: integer
                    description: The number of credits used for the search
        '408':
          description: Request timeout
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
                    example: Request timed out
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
