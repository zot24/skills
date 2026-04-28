> Source: https://docs.firecrawl.dev/api-reference/endpoint/queue-status.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Queue Status

Metrics about your team's scrape queue.

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.


## OpenAPI

````yaml /api-reference/v2-openapi.json GET /team/queue-status
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
  /team/queue-status:
    get:
      tags:
        - Miscellaneous
      summary: Metrics about your team's scrape queue
      operationId: getQueueStatus
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
                    example: true
                  jobsInQueue:
                    type: number
                    description: Number of jobs currently in your queue
                  activeJobsInQueue:
                    type: number
                    description: Number of jobs currently active
                  waitingJobsInQueue:
                    type: number
                    description: Number of jobs currently waiting
                  maxConcurrency:
                    type: number
                    description: >-
                      Maximum number of concurrent active jobs based on your
                      plan
                  mostRecentSuccess:
                    type: string
                    format: date-time
                    description: Timestamp of the most recent successful job
                    nullable: true
      security:
        - bearerAuth: []
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
