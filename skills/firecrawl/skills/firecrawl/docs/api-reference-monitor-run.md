> Source: https://docs.firecrawl.dev/api-reference/endpoint/monitor-run.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Run Monitor


## OpenAPI

````yaml /api-reference/v2-openapi.json POST /monitor/{monitorId}/run
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
  /monitor/{monitorId}/run:
    post:
      tags:
        - Monitoring
      summary: Run a monitor
      operationId: runMonitor
      parameters:
        - $ref: '#/components/parameters/MonitorId'
      responses:
        '200':
          description: Monitor check queued
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/MonitorRunResponse'
        '409':
          description: A monitor check is already running
      security:
        - bearerAuth: []
components:
  parameters:
    MonitorId:
      name: monitorId
      in: path
      required: true
      schema:
        type: string
        format: uuid
      description: The monitor ID
  schemas:
    MonitorRunResponse:
      type: object
      properties:
        success:
          type: boolean
        id:
          type: string
          format: uuid
        data:
          $ref: '#/components/schemas/MonitorCheck'
    MonitorCheck:
      type: object
      properties:
        id:
          type: string
          format: uuid
        monitorId:
          type: string
          format: uuid
        status:
          type: string
          enum:
            - queued
            - running
            - completed
            - failed
            - partial
            - skipped_overlap
        trigger:
          type: string
          enum:
            - scheduled
            - manual
        scheduledFor:
          type: string
          format: date-time
          nullable: true
        startedAt:
          type: string
          format: date-time
          nullable: true
        finishedAt:
          type: string
          format: date-time
          nullable: true
        estimatedCredits:
          type: integer
          nullable: true
          description: >-
            Upper-bound credits reserved for this check before Firecrawl knows
            how many pages changed and require judging.
        reservedCredits:
          type: integer
          nullable: true
        actualCredits:
          type: integer
          nullable: true
          description: >-
            Final credits charged for this check after scrapes, crawls, and any
            changed-page judge calls complete.
        billingStatus:
          type: string
        summary:
          $ref: '#/components/schemas/MonitorSummary'
        targetResults:
          type: array
          nullable: true
        notificationStatus:
          type: object
          nullable: true
        error:
          type: string
          nullable: true
        createdAt:
          type: string
          format: date-time
        updatedAt:
          type: string
          format: date-time
    MonitorSummary:
      type: object
      properties:
        totalPages:
          type: integer
        same:
          type: integer
        changed:
          type: integer
        new:
          type: integer
        removed:
          type: integer
        error:
          type: integer
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
