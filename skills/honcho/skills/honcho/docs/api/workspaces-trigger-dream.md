> Source: https://honcho.dev/docs/v2/api-reference/endpoint/workspaces/trigger-dream.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Trigger Dream

> Manually trigger a dream task immediately for a specific collection.

This endpoint bypasses all automatic dream conditions (document threshold,
minimum hours between dreams) and executes the dream task immediately without delay.


## OpenAPI

````yaml post /v2/workspaces/{workspace_id}/trigger_dream
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
  /v2/workspaces/{workspace_id}/trigger_dream:
    post:
      tags:
        - workspaces
      summary: Trigger Dream
      description: >-
        Manually trigger a dream task immediately for a specific collection.


        This endpoint bypasses all automatic dream conditions (document
        threshold,

        minimum hours between dreams) and executes the dream task immediately
        without delay.
      operationId: trigger_dream_v2_workspaces__workspace_id__trigger_dream_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the workspace
            title: Workspace Id
          description: ID of the workspace
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/TriggerDreamRequest'
              description: Dream trigger parameters
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
components:
  schemas:
    TriggerDreamRequest:
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
          description: Type of dream to trigger
      type: object
      required:
        - observer
        - dream_type
      title: TriggerDreamRequest
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
        - consolidate
        - agent
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
