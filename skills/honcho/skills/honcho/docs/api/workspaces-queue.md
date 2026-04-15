> Source: https://docs.honcho.dev/v3/api-reference/endpoint/workspaces/get-queue-status.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Queue Status

> Get the processing queue status for a Workspace, optionally scoped to an observer, sender,
and/or session.

Only tracks user-facing task types (representation, summary, dream).
Internal infrastructure tasks (reconciler, webhook, deletion) are excluded.
Note: completed counts reflect items since the last periodic queue cleanup,
not lifetime totals.


## OpenAPI

````yaml get /v3/workspaces/{workspace_id}/queue/status
openapi: 3.1.0
info:
  title: Honcho API
  summary: The Identity Layer for the Agentic World
  description: >-
    Honcho is a platform for giving agents user-centric memory and social
    cognition.
  contact:
    name: Plastic Labs
    url: https://honcho.dev/
    email: hello@plasticlabs.ai
  license:
    name: GNU Affero General Public License v3.0
    url: https://github.com/plastic-labs/honcho/blob/main/LICENSE
  version: 3.0.3
servers:
  - url: https://api.honcho.dev
    description: Production SaaS Platform
  - url: http://localhost:8000
    description: Local Development Server
security: []
paths:
  /v3/workspaces/{workspace_id}/queue/status:
    get:
      tags:
        - workspaces
      summary: Get Queue Status
      description: >-
        Get the processing queue status for a Workspace, optionally scoped to an
        observer, sender,

        and/or session.


        Only tracks user-facing task types (representation, summary, dream).

        Internal infrastructure tasks (reconciler, webhook, deletion) are
        excluded.

        Note: completed counts reflect items since the last periodic queue
        cleanup,

        not lifetime totals.
      operationId: get_queue_status_v3_workspaces__workspace_id__queue_status_get
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
        - name: observer_id
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: Optional observer ID to filter by
            title: Observer Id
          description: Optional observer ID to filter by
        - name: sender_id
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: Optional sender ID to filter by
            title: Sender Id
          description: Optional sender ID to filter by
        - name: session_id
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: Optional session ID to filter by
            title: Session Id
          description: Optional session ID to filter by
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/QueueStatus'
        '422':
          description: Validation Error
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/HTTPValidationError'
      security:
        - HTTPBearer: []
        - {}
components:
  schemas:
    QueueStatus:
      properties:
        total_work_units:
          type: integer
          title: Total Work Units
          description: Total work units
        completed_work_units:
          type: integer
          title: Completed Work Units
          description: Completed work units (since last periodic cleanup)
        in_progress_work_units:
          type: integer
          title: In Progress Work Units
          description: Work units currently being processed
        pending_work_units:
          type: integer
          title: Pending Work Units
          description: Work units waiting to be processed
        sessions:
          anyOf:
            - additionalProperties:
                $ref: '#/components/schemas/SessionQueueStatus'
              type: object
            - type: 'null'
          title: Sessions
          description: Per-session status when not filtered by session
      type: object
      required:
        - total_work_units
        - completed_work_units
        - in_progress_work_units
        - pending_work_units
      title: QueueStatus
      description: >-
        Aggregated processing queue status.


        Tracks user-facing task types only: representation, summary, and dream.

        Internal infrastructure tasks (reconciler, webhook, deletion) are
        excluded.


        Note: completed_work_units reflects items since the last periodic queue

        cleanup, not lifetime totals.
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    SessionQueueStatus:
      properties:
        session_id:
          anyOf:
            - type: string
            - type: 'null'
          title: Session Id
          description: Session ID if filtered by session
        total_work_units:
          type: integer
          title: Total Work Units
          description: Total work units
        completed_work_units:
          type: integer
          title: Completed Work Units
          description: Completed work units
        in_progress_work_units:
          type: integer
          title: In Progress Work Units
          description: Work units currently being processed
        pending_work_units:
          type: integer
          title: Pending Work Units
          description: Work units waiting to be processed
      type: object
      required:
        - total_work_units
        - completed_work_units
        - in_progress_work_units
        - pending_work_units
      title: SessionQueueStatus
      description: Status for a specific session within the processing queue.
    ValidationError:
      properties:
        loc:
          items:
            anyOf:
              - type: string
              - type: integer
          type: array
          title: Location
        msg:
          type: string
          title: Message
        type:
          type: string
          title: Error Type
        input:
          title: Input
        ctx:
          type: object
          title: Context
      type: object
      required:
        - loc
        - msg
        - type
      title: ValidationError
  securitySchemes:
    HTTPBearer:
      type: http
      scheme: bearer

````
