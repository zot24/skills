> Source: https://docs.honcho.dev/v3/api-reference/endpoint/peers/chat.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Query a Peer's representation using natural language

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
  /v3/workspaces/{workspace_id}/peers/{peer_id}/chat:
    post:
      tags:
        - peers
      summary: Query a Peer's representation using natural language
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
        - {}
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
