> Source: https://docs.firecrawl.dev/api-reference/endpoint/agent-get.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Agent Status

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml api-reference/v2-openapi.json GET /agent/{jobId}
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
  /agent/{jobId}:
    parameters:
      - name: jobId
        in: path
        description: The ID of the agent job
        required: true
        schema:
          type: string
          format: uuid
    get:
      tags:
        - Agent
      summary: Get the status of an agent job
      operationId: getAgentStatus
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
                  status:
                    type: string
                    enum:
                      - processing
                      - completed
                      - failed
                  data:
                    type: object
                    description: The extracted data (only present when status is completed)
                  model:
                    type: string
                    enum:
                      - spark-2
                      - spark-1-pro
                      - spark-1-mini
                    default: spark-2
                    description: >-
                      Model preset used for the agent run. Every new run
                      executes on spark-2; Spark 1 names only appear on legacy
                      runs.
                  effort:
                    type: string
                    enum:
                      - low
                      - medium
                      - high
                    description: >-
                      Reasoning budget used for the agent run (only present for
                      runs that set effort)
                  error:
                    type: string
                    description: Error message (only present when status is failed)
                  expiresAt:
                    type: string
                    format: date-time
                  creditsUsed:
                    type: number
        '400':
          description: Bad request — the job ID is not a valid UUID.
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: Invalid job ID format. Job ID must be a valid UUID.
        '404':
          description: Agent job not found
          content:
            application/json:
              schema:
                type: object
                properties:
                  error:
                    type: string
                    example: Agent job not found
      security:
        - bearerAuth: []
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
