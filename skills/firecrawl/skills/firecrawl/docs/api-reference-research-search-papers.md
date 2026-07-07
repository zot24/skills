> Source: https://docs.firecrawl.dev/api-reference/endpoint/research-search-papers.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Search Papers

Search papers by topic, method, benchmark, author, or category. Results include canonical `paperId`, preferred `primaryId`, source ids, title, abstract, score, and optional ranking signals.

For a workflow overview, see the [Research Index guide](/features/research).


## OpenAPI

````yaml api-reference/v2-openapi.json GET /search/research/papers
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
  /search/research/papers:
    get:
      tags:
        - Research
      summary: Search papers
      operationId: researchSearchPapers
      parameters:
        - name: query
          in: query
          required: true
          description: Natural-language paper search query.
          schema:
            type: string
            minLength: 1
        - name: k
          in: query
          required: false
          description: Maximum number of ranked papers to return.
          schema:
            type: integer
            minimum: 1
            maximum: 500
            default: 40
        - name: authors
          in: query
          required: false
          description: >-
            Author substring filter. Repeat or pass a comma-separated value; all
            filters must match.
          schema:
            type: string
        - name: categories
          in: query
          required: false
          description: >-
            Paper category filter. Repeat or pass a comma-separated value; all
            filters must match.
          schema:
            type: string
        - name: from
          in: query
          required: false
          description: Inclusive lower bound on created/updated date.
          schema:
            type: string
            format: date
        - name: to
          in: query
          required: false
          description: Inclusive upper bound on created/updated date.
          schema:
            type: string
            format: date
      responses:
        '200':
          description: Ranked paper results.
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ResearchSearchPapersResponse'
              example:
                success: true
                results:
                  - paperId: '2014215642691656232'
                    primaryId: arxiv:2105.05233
                    ids:
                      arxiv:
                        - '2105.05233'
                    title: Diffusion Models Beat GANs on Image Synthesis
                    abstract: >-
                      We show that diffusion models can achieve image sample
                      quality superior to the current state-of-the-art
                      generative models...
                    score: 0.0163934
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
    ResearchSearchPapersResponse:
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
            $ref: '#/components/schemas/ResearchPaperResult'
    ResearchPaperResult:
      type: object
      required:
        - paperId
        - primaryId
        - title
        - abstract
        - score
      properties:
        paperId:
          type: string
          description: >-
            Canonical paper id, or web:<url> for SERP-discovered display
            results.
        primaryId:
          type: string
          description: >-
            Preferred cite/fetch id such as arxiv:<id>, pmid:<id>, pmcid:<id>,
            or doi:<id>.
        ids:
          $ref: '#/components/schemas/ResearchIdMap'
        title:
          type: string
        abstract:
          type: string
        score:
          type: number
          format: double
        signals:
          $ref: '#/components/schemas/ResearchPaperSignals'
    ResearchIdMap:
      type: object
      description: Source identifiers grouped by namespace.
      additionalProperties:
        type: array
        items:
          type: string
      example:
        arxiv:
          - '2105.05233'
    ResearchPaperSignals:
      type: object
      required:
        - structural
        - semantic
        - articleRank
        - seedOverlap
      properties:
        structural:
          type: number
          format: double
          description: Raw structural graph signal.
        semantic:
          type: number
          format: double
          description: Semantic score from the intent search.
        articleRank:
          type: number
          format: double
          description: Structural expansion article-rank score.
        seedOverlap:
          type: integer
          minimum: 0
          description: Number of distinct seeds connected to this candidate.
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
