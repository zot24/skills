> Source: https://docs.firecrawl.dev/api-reference/endpoint/research-related-papers.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Find Related Papers

Expand from a seed paper through structural expansion and rank candidate papers against a natural-language `intent`. Use `mode` to choose similar papers, citers, or references.

For a workflow overview, see the [Research Index guide](/features/research).


## OpenAPI

````yaml api-reference/v2-openapi.json GET /search/research/papers/{id}/similar
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
  /search/research/papers/{id}/similar:
    get:
      tags:
        - Research
      summary: Find related papers
      operationId: researchRelatedPapers
      parameters:
        - name: id
          in: path
          required: true
          description: Primary seed paper reference.
          schema:
            type: string
          examples:
            paperId:
              summary: Canonical paperId
              value: '2014215642691656232'
            sourceId:
              summary: Source-specific primaryId
              value: arxiv:2105.05233
        - name: intent
          in: query
          required: true
          description: Natural-language ranking/filtering intent used for semantic ranking.
          schema:
            type: string
            minLength: 1
        - name: mode
          in: query
          required: false
          description: Structural expansion mode.
          schema:
            type: string
            enum:
              - similar
              - citers
              - references
            default: similar
        - name: k
          in: query
          required: false
          description: Maximum number of related papers to return.
          schema:
            type: integer
            minimum: 1
            maximum: 500
            default: 40
        - name: rerank
          in: query
          required: false
          description: Apply an additional rerank over fused candidates.
          schema:
            type: boolean
        - name: anchor
          in: query
          required: false
          description: >-
            Additional seed paper reference. Repeat this parameter for multiple
            anchors.
          schema:
            type: string
      responses:
        '200':
          description: Ranked related papers.
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ResearchSimilarPapersResponse'
              example:
                success: true
                results:
                  - paperId: '482107036680302043'
                    primaryId: arxiv:2006.11239
                    ids:
                      arxiv:
                        - '2006.11239'
                    title: Denoising Diffusion Probabilistic Models
                    abstract: >-
                      We present high quality image synthesis results using
                      diffusion probabilistic models...
                    score: 0.032119
                    signals:
                      structural: 12
                      semantic: 0.61
                      articleRank: 0.00031
                      seedOverlap: 2
                poolSize: 40
                truncated: false
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
    ResearchSimilarPapersResponse:
      type: object
      required:
        - success
        - results
        - poolSize
        - truncated
      properties:
        success:
          type: boolean
        results:
          type: array
          items:
            $ref: '#/components/schemas/ResearchPaperResult'
        poolSize:
          type: integer
          minimum: 0
        truncated:
          type: boolean
        note:
          type: string
          nullable: true
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
