> Source: https://honcho.dev/docs/v3/api-reference/endpoint/peers/chat.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Chat

> Query a Peer's representation using natural language. Performs agentic search and reasoning to comprehensively
answer the query based on all latent knowledge gathered about the peer from their messages and conclusions.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/peers/{peer_id}/chat
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
  version: 3.1.0
servers:
  - url: https://api.honcho.dev
    description: Production SaaS Platform
  - url: http://localhost:8000
    description: Local Development Server
security: []
paths:
  /v3/workspaces/{workspace_id}/peers/{peer_id}/chat:
    post:
      tags:
        - peers
      summary: Chat
      description: >-
        Query a Peer's representation using natural language. Performs agentic
        search and reasoning to comprehensively

        answer the query based on all latent knowledge gathered about the peer
        from their messages and conclusions.
      operationId: chat_v3_workspaces__workspace_id__peers__peer_id__chat_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
        - name: peer_id
          in: path
          required: true
          schema:
            type: string
            title: Peer Id
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/DialecticOptions'
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                properties:
                  content:
                    anyOf:
                      - type: string
                      - type: 'null'
                    title: Content
                required:
                  - content
                title: DialecticResponse
                type: object
            text/event-stream: {}
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
    DialecticOptions:
      properties:
        session_id:
          anyOf:
            - type: string
            - type: 'null'
          title: Session Id
          description: ID of the session to scope the representation to
        filters:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Filters
          description: >-
            Optional filters to scope recall. This endpoint supports only the
            'session_id' key: a session id, a list of session ids, or {"in":
            [...]}. Recall (conclusions and messages) is restricted to the
            allowlist; unsupported keys are rejected. When session_id is also
            set, it must be included in the allowlist.
        scope:
          anyOf:
            - type: string
            - items:
                type: string
              type: array
              maxItems: 100
              minItems: 1
            - type: 'null'
          title: Scope
          description: >-
            Optional (unprefixed) scope name(s) to confine recall. A single
            scope answers from the scope's own representation of the target
            peer: conclusion recall is confined to what the scope observed and
            message recall to the scope's member sessions. A list of scopes
            restricts recall to the union of the scopes' member sessions
            (explicit allowlist, fail-closed: an empty union recalls nothing).
            Mutually exclusive with `filters` and `session_id`. Requires a
            workspace- or admin-level key.
        target:
          anyOf:
            - type: string
            - type: 'null'
          title: Target
          description: >-
            Optional peer to get the representation for, from the perspective of
            this peer
        query:
          type: string
          maxLength: 10000
          minLength: 1
          title: Query
          description: Dialectic API Prompt
        stream:
          type: boolean
          title: Stream
          default: false
        reasoning_level:
          type: string
          enum:
            - minimal
            - low
            - medium
            - high
            - max
          title: Reasoning Level
          description: 'Level of reasoning to apply: minimal, low, medium, high, or max'
          default: low
        response_format:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Response Format
          description: >-
            Optional JSON Schema (root type 'object') the response must conform
            to. When provided, `content` is a JSON string matching this schema.
            Only a conservative subset of JSON Schema is supported; unsupported 
            schemas are rejected with 422. Constraint keywords (minItems, 
            maxLength, ...) are hints to the model, not enforced server-side.
      type: object
      required:
        - query
      title: DialecticOptions
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
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
