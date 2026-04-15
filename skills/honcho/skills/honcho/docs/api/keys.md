> Source: https://docs.honcho.dev/v3/api-reference/endpoint/keys/create-key.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Create Key

> Create a new Key


## OpenAPI

````yaml post /v3/keys
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
  /v3/keys:
    post:
      tags:
        - keys
      summary: Create Key
      description: Create a new Key
      operationId: create_key_v3_keys_post
      parameters:
        - name: workspace_id
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: ID of the workspace to scope the key to
            title: Workspace Id
          description: ID of the workspace to scope the key to
        - name: peer_id
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: ID of the peer to scope the key to
            title: Peer Id
          description: ID of the peer to scope the key to
        - name: session_id
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: ID of the session to scope the key to
            title: Session Id
          description: ID of the session to scope the key to
        - name: expires_at
          in: query
          required: false
          schema:
            anyOf:
              - type: string
                format: date-time
              - type: 'null'
            title: Expires At
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema: {}
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
