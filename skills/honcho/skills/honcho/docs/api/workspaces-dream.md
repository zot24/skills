> Source: https://docs.honcho.dev/v3/api-reference/endpoint/workspaces/schedule-dream.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Schedule Dream

> Manually schedule a dream task for a specific collection.

This endpoint bypasses all automatic dream conditions (document threshold,
minimum hours between dreams) and schedules the dream task for a future execution.

Currently this endpoint only supports scheduling immediate dreams. In the future,
users may pass a cron-style expression to schedule dreams at specific times.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/schedule_dream
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
  /v3/workspaces/{workspace_id}/schedule_dream:
    post:
      tags:
        - workspaces
      summary: Schedule Dream
      description: >-
        Manually schedule a dream task for a specific collection.


        This endpoint bypasses all automatic dream conditions (document
        threshold,

        minimum hours between dreams) and schedules the dream task for a future
        execution.


        Currently this endpoint only supports scheduling immediate dreams. In
        the future,

        users may pass a cron-style expression to schedule dreams at specific
        times.
      operationId: schedule_dream_v3_workspaces__workspace_id__schedule_dream_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ScheduleDreamRequest'
              description: Dream scheduling parameters
      responses:
        '204':
          description: Successful Response
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
    ScheduleDreamRequest:
      properties:
        observer:
          type: string
          title: Observer
          description: Observer peer name
        observed:
          anyOf:
            - type: string
            - type: 'null'
          title: Observed
          description: Observed peer name (defaults to observer if not specified)
        dream_type:
          $ref: '#/components/schemas/DreamType'
          description: Type of dream to schedule
        session_id:
          anyOf:
            - type: string
            - type: 'null'
          title: Session Id
          description: Session ID to scope the dream to if specified
      type: object
      required:
        - observer
        - dream_type
      title: ScheduleDreamRequest
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    DreamType:
      type: string
      enum:
        - omni
      title: DreamType
      description: Types of dreams that can be triggered.
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
