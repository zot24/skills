> Source: https://docs.firecrawl.dev/api-reference/endpoint/research-paper.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Inspect or Read Paper

Inspect paper metadata by id, or add a `query` parameter to read the most relevant full-text passages for a question.

Accepted ids include canonical `paperId` values and source-specific `primaryId` values (e.g. `arxiv:1706.03762`).

For a workflow overview, see the [Research Index guide](/features/research).


## OpenAPI

````yaml api-reference/v2-openapi.json GET /search/research/papers/{id}
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
  /search/research/papers/{id}:
    get:
      tags:
        - Research
      summary: Inspect or read a paper
      operationId: researchGetPaper
      parameters:
        - name: id
          in: path
          required: true
          description: 'Paper reference: a canonical paperId or source-specific primaryId.'
          schema:
            type: string
          examples:
            paperId:
              summary: Canonical paperId
              value: '2014215642691656232'
            sourceId:
              summary: Source-specific primaryId
              value: arxiv:2105.05233
        - name: query
          in: query
          required: false
          description: >-
            When present, returns the top matching full-text passages for this
            question. Omit it to inspect metadata only.
          schema:
            type: string
            minLength: 1
        - name: k
          in: query
          required: false
          description: Passage count for read mode. Only valid when query is present.
          schema:
            type: integer
            minimum: 1
            maximum: 50
            default: 4
      responses:
        '200':
          description: Paper metadata or read-mode passages.
          content:
            application/json:
              schema:
                oneOf:
                  - $ref: '#/components/schemas/ResearchPaperMetadataResponse'
                  - $ref: '#/components/schemas/ResearchReadPaperResponse'
              example:
                success: true
                paper:
                  paperId: '2014215642691656232'
                  ids:
                    arxiv:
                      - '2105.05233'
                  title: Diffusion Models Beat GANs on Image Synthesis
                  abstract: >-
                    We show that diffusion models can achieve image sample
                    quality superior to the current state-of-the-art generative
                    models...
                  authors: Prafulla Dhariwal, Alexander Nichol
                  categories:
                    - cs.LG
                  createdDate: Wed, 11 May 2021 18:01:01 GMT
                  updateDate: '2021-06-01'
        '400':
          description: Invalid request
        '401':
          description: Missing or invalid bearer token
        '404':
          description: Paper not found
        '429':
          description: Rate limit exceeded
        '500':
          description: Internal server error
      security:
        - bearerAuth: []
components:
  schemas:
    ResearchPaperMetadataResponse:
      type: object
      required:
        - success
        - paper
      properties:
        success:
          type: boolean
        paper:
          $ref: '#/components/schemas/ResearchPaperMetadata'
    ResearchReadPaperResponse:
      type: object
      required:
        - success
        - paper
        - paperId
        - query
        - passages
      properties:
        success:
          type: boolean
        paper:
          $ref: '#/components/schemas/ResearchPaperMetadata'
        paperId:
          type: string
        query:
          type: string
        passages:
          type: array
          items:
            $ref: '#/components/schemas/ResearchPassage'
    ResearchPaperMetadata:
      type: object
      required:
        - paperId
        - title
        - abstract
      properties:
        paperId:
          type: string
          description: Canonical paper id.
        ids:
          $ref: '#/components/schemas/ResearchIdMap'
        title:
          type: string
        abstract:
          type: string
        authors:
          type: string
          description: Comma-joined author names.
        categories:
          type: array
          items:
            type: string
          description: Paper categories.
        createdDate:
          type: string
          description: Original creation date string.
        updateDate:
          type: string
          description: Last-updated date string.
    ResearchPassage:
      type: object
      required:
        - text
        - score
      properties:
        text:
          type: string
          description: In-body passage text. May include markdown tables.
        score:
          type: number
          format: double
          description: Dense similarity score for the passage.
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
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
