> Source: https://docs.firecrawl.dev/api-reference/endpoint/agent.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Agent

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml /api-reference/v2-openapi.json POST /agent
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
  /agent:
    post:
      tags:
        - Agent
      summary: Start an agent task for agentic data extraction
      operationId: startAgent
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                urls:
                  type: array
                  items:
                    type: string
                    format: uri
                  description: Optional list of URLs to constrain the agent to
                prompt:
                  type: string
                  description: The prompt describing what data to extract
                  maxLength: 10000
                schema:
                  type: object
                  description: Optional JSON schema to structure the extracted data
                maxCredits:
                  type: number
                  description: >-
                    Maximum credits to spend on this agent task. Defaults to
                    2500 if not set. Values above 2,500 are always billed as
                    paid requests.
                strictConstrainToURLs:
                  type: boolean
                  description: >-
                    If true, agent will only visit URLs provided in the urls
                    array
                model:
                  type: string
                  enum:
                    - spark-1-mini
                    - spark-1-pro
                  default: spark-1-mini
                  description: >-
                    The model to use for the agent task. spark-1-mini (default)
                    is 60% cheaper, spark-1-pro offers higher accuracy for
                    complex tasks
              required:
                - prompt
      responses:
        '200':
          description: Agent task started successfully
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                  id:
                    type: string
                    format: uuid
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
                    example: Rate limit exceeded.
      security:
        - bearerAuth: []
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
