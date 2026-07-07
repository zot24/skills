> Source: https://docs.firecrawl.dev/api-reference/endpoint/research-github-search.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Search GitHub History

Search GitHub issue/PR history, discussions, and repository READMEs. Results include repository metadata, URLs, snippets, and matched markdown content when available.

For a workflow overview, see the [Research Index guide](/features/research).


## OpenAPI

````yaml api-reference/v2-openapi.json GET /search/research/github
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
  /search/research/github:
    get:
      tags:
        - Research
      summary: Search GitHub history
      operationId: researchSearchGitHub
      parameters:
        - name: query
          in: query
          required: true
          description: >-
            Natural-language query for GitHub issues, pull requests,
            discussions, and repository READMEs.
          schema:
            type: string
            minLength: 1
        - name: k
          in: query
          required: false
          description: Maximum number of GitHub results to return.
          schema:
            type: integer
            minimum: 1
            maximum: 100
            default: 20
      responses:
        '200':
          description: Ranked GitHub history/readme results.
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ResearchGitHubSearchResponse'
              example:
                success: true
                results:
                  - resultType: issue
                    repo: firecrawl/firecrawl
                    url: https://github.com/firecrawl/firecrawl/issues/123
                    pageType: issue
                    number: 123
                    segmentCount: 2
                    title: Worker shutdown race
                    snippet: Queue worker shutdown can lose completion signals...
                    contentMd: Full matched markdown content when available.
                    scores:
                      semantic: 0.82
        '400':
          description: Invalid request
        '401':
          description: Missing or invalid bearer token
        '429':
          description: Rate limit exceeded
        '500':
          description: Internal server error
      security:
        - bearerAuth: []
components:
  schemas:
    ResearchGitHubSearchResponse:
      type: object
      required:
        - success
        - results
      properties:
        success:
          type: boolean
        results:
          type: array
          items:
            $ref: '#/components/schemas/ResearchGitHubItem'
    ResearchGitHubItem:
      type: object
      properties:
        resultType:
          type: string
          description: Result class, such as issue, pull, discussion, or repo_readme.
        repo:
          type: string
          description: Repository in owner/name form.
        url:
          type: string
          format: uri
        pageType:
          type: string
          description: History page type for issue/PR/discussion results.
        number:
          type: integer
        segmentCount:
          type: integer
        readmeUrl:
          type: string
          format: uri
        title:
          type: string
        snippet:
          type: string
        contentMd:
          type: string
          description: Full matched markdown content when available.
        scores:
          $ref: '#/components/schemas/ResearchGitHubScoreBreakdown'
    ResearchGitHubScoreBreakdown:
      type: object
      additionalProperties:
        type: number
      description: Component scores such as semantic, lexical, fusion, rrf, or rerank.
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
