> Source: https://docs.firecrawl.dev/api-reference/endpoint/monitor-delete.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Delete Monitor


## OpenAPI

````yaml /api-reference/v2-openapi.json DELETE /monitor/{monitorId}
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
  /monitor/{monitorId}:
    delete:
      tags:
        - Monitoring
      summary: Delete a monitor
      operationId: deleteMonitor
      parameters:
        - $ref: '#/components/parameters/MonitorId'
      responses:
        '200':
          description: Monitor deleted
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/SuccessResponse'
        '404':
          description: Monitor not found
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
    SuccessResponse:
      type: object
      properties:
        success:
          type: boolean
          example: true
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
