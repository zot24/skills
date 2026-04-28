> Source: https://docs.firecrawl.dev/api-reference/endpoint/extract-get.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Extract Status

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml /api-reference/v2-openapi.json GET /extract/{id}
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
  /extract/{id}:
    parameters:
      - name: id
        in: path
        description: The ID of the extract job
        required: true
        schema:
          type: string
          format: uuid
    get:
      tags:
        - Extraction
      summary: Get the status of an extract job
      operationId: getExtractStatus
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ExtractStatusResponse'
      security:
        - bearerAuth: []
components:
  schemas:
    ExtractStatusResponse:
      type: object
      properties:
        success:
          type: boolean
        data:
          type: object
        status:
          type: string
          enum:
            - completed
            - processing
            - failed
            - cancelled
          description: The current status of the extract job
        expiresAt:
          type: string
          format: date-time
        tokensUsed:
          type: integer
          description: >-
            The number of tokens used by the extract job. Only available if the
            job is completed.
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
