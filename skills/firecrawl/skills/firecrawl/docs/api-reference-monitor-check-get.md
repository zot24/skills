> Source: https://docs.firecrawl.dev/api-reference/endpoint/monitor-check-get.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Monitor Check


## OpenAPI

````yaml api-reference/v2-openapi.json GET /monitor/{monitorId}/checks/{checkId}
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
  /monitor/{monitorId}/checks/{checkId}:
    get:
      tags:
        - Monitoring
      summary: Get a monitor check
      operationId: getMonitorCheck
      parameters:
        - $ref: '#/components/parameters/MonitorId'
        - name: checkId
          in: path
          required: true
          schema:
            type: string
            format: uuid
          description: The monitor check ID
        - name: limit
          in: query
          schema:
            type: integer
            minimum: 1
            maximum: 100
            default: 25
        - name: skip
          in: query
          schema:
            type: integer
            minimum: 0
            default: 0
          description: >-
            Number of page results to skip. Use the `next` URL from the previous
            response for pagination.
        - name: status
          in: query
          schema:
            type: string
            enum:
              - same
              - new
              - changed
              - removed
              - error
      responses:
        '200':
          description: Monitor check details
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/MonitorCheckDetailResponse'
        '404':
          description: Monitor check not found
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
    MonitorCheckDetailResponse:
      type: object
      properties:
        success:
          type: boolean
        next:
          type: string
          nullable: true
          description: URL to fetch the next page of monitor check page results, if any.
        data:
          allOf:
            - $ref: '#/components/schemas/MonitorCheck'
            - type: object
              properties:
                pages:
                  type: array
                  items:
                    $ref: '#/components/schemas/MonitorCheckPage'
                next:
                  type: string
                  nullable: true
                  description: >-
                    URL to fetch the next page of monitor check page results, if
                    any.
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
    MonitorCheckPage:
      type: object
      properties:
        id:
          type: string
          format: uuid
        targetId:
          type: string
        url:
          type: string
          format: uri
        status:
          type: string
          enum:
            - same
            - new
            - changed
            - removed
            - error
        previousScrapeId:
          type: string
          format: uuid
          nullable: true
        currentScrapeId:
          type: string
          format: uuid
          nullable: true
        statusCode:
          type: integer
          nullable: true
        error:
          type: string
          nullable: true
        metadata:
          type: object
          nullable: true
          description: >-
            Extra per-page metadata. For search monitors this includes
            `searchStatus`, the finer-grained search disposition behind the
            top-level `status`: `alert` (maps to `new`), `already_seen`,
            `watching`, `ignored` (all map to `same`), or `skipped` (maps to
            `error`).
        judgment:
          $ref: '#/components/schemas/MonitorPageJudgment'
        diff:
          type: object
          nullable: true
          description: >-
            Inline diff artifact when the page changed. The shape depends on
            what the monitor's scrapeOptions.formats asked for. Markdown-only
            monitors populate both `text` (unified diff) and `json` (parseDiff
            AST). JSON-extraction monitors populate `json` as a per-field
            `{previous, current}` map keyed by JSON path. Mixed-mode monitors
            (`changeTracking` with both `json` and `git-diff` modes) populate
            both `text` (markdown sidecar) and `json` (per-field diff).
          properties:
            text:
              type: string
              description: >-
                Unified markdown diff. Present on markdown-only and mixed-mode
                monitors.
            json:
              type: object
              description: >-
                For markdown-only monitors, a parseDiff AST `{ files: [...] }`.
                For JSON-extraction (and mixed-mode) monitors, a per-field `{
                previous, current }` map keyed by the JSON path into the
                extraction (e.g. `plans[0].price`).
        snapshot:
          type: object
          nullable: true
          description: >-
            Snapshot of the current JSON extraction at this run. Present on
            JSON-extraction and mixed-mode monitors; absent for markdown-only
            monitors.
          properties:
            json:
              type: object
              description: >-
                The full structured JSON extracted on this run, matching the
                schema/prompt declared on the target's `changeTracking` format.
        createdAt:
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
    MonitorPageJudgment:
      type: object
      nullable: true
      properties:
        meaningful:
          type: boolean
          description: Whether the changed page is meaningful for the monitor goal.
        confidence:
          type: string
          enum:
            - high
            - medium
            - low
        reason:
          type: string
        meaningfulChanges:
          type: array
          description: Goal-relevant changes selected by the judge from the page diff.
          items:
            type: object
            properties:
              type:
                type: string
                enum:
                  - added
                  - removed
                  - changed
              before:
                type: string
                nullable: true
              after:
                type: string
                nullable: true
              reason:
                type: string
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer

````
