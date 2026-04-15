> Source: https://docs.honcho.dev/v3/api-reference/endpoint/peers/get-or-create-peer.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Or Create Peer

> Get a Peer by ID or create a new Peer with the given ID.

If peer_id is provided as a query parameter, it uses that (must match JWT workspace_id).
Otherwise, it uses the peer_id from the JWT.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/peers
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
  /v3/workspaces/{workspace_id}/peers:
    post:
      tags:
        - peers
      summary: Get Or Create Peer
      description: >-
        Get a Peer by ID or create a new Peer with the given ID.


        If peer_id is provided as a query parameter, it uses that (must match
        JWT workspace_id).

        Otherwise, it uses the peer_id from the JWT.
      operationId: get_or_create_peer_v3_workspaces__workspace_id__peers_post
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
              $ref: '#/components/schemas/PeerCreate'
              description: Peer creation parameters
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Peer'
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
    PeerCreate:
      properties:
        id:
          type: string
          maxLength: 100
          minLength: 1
          pattern: ^[a-zA-Z0-9_-]+$
          title: Id
        metadata:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Metadata
        configuration:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Configuration
      type: object
      required:
        - id
      title: PeerCreate
    Peer:
      properties:
        id:
          type: string
          title: Id
        workspace_id:
          type: string
          title: Workspace Id
        created_at:
          type: string
          format: date-time
          title: Created At
        metadata:
          additionalProperties: true
          type: object
          title: Metadata
        configuration:
          additionalProperties: true
          type: object
          title: Configuration
      type: object
      required:
        - id
        - workspace_id
        - created_at
      title: Peer
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
