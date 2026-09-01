> Source: https://honcho.dev/docs/v2/api-reference/endpoint/workspaces/get-deriver-status.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Deriver Status

> Get the deriver processing status, optionally scoped to an observer, sender, and/or session


## OpenAPI

````yaml get /v2/workspaces/{workspace_id}/deriver/status
openapi: 3.1.0
info:
  title: Honcho API
  summary: The Identity Layer for the Agentic World
  description: >-
    Honcho is a platform for giving agents user-centric memory and social
    cognition
  contact:
    name: Plastic Labs
    url: https://honcho.dev/
    email: hello@plasticlabs.ai
  version: 2.5.1
servers:
  - url: http://localhost:8000
    description: Local Development Server
  - url: https://demo.honcho.dev
    description: Demo Server
  - url: https://api.honcho.dev
    description: Production SaaS Platform
security: []
paths:
  /v2/workspaces/{workspace_id}/deriver/status:
    get:
      tags:
        - workspaces
      summary: Get Deriver Status
      description: >-
        Get the deriver processing status, optionally scoped to an observer,
        sender, and/or session
      operationId: get_deriver_status_v2_workspaces__workspace_id__deriver_status_get
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the workspace
            title: Workspace Id
          description: ID of the workspace
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
                $ref: '#/components/schemas/DeriverStatus'
        '422':
          description: Validation Error
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/HTTPValidationError'
      security:
        - HTTPBearer: []
components:
  schemas:
    DeriverStatus:
      properties:
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
        sessions:
          anyOf:
            - additionalProperties:
                $ref: '#/components/schemas/SessionDeriverStatus'
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
      title: DeriverStatus
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    SessionDeriverStatus:
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
      title: SessionDeriverStatus
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
