> Source: https://honcho.dev/docs/v2/api-reference/endpoint/peers/get-sessions-for-peer.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Sessions For Peer

> Get All Sessions for a Peer


## OpenAPI

````yaml post /v2/workspaces/{workspace_id}/peers/{peer_id}/sessions
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
  /v2/workspaces/{workspace_id}/peers/{peer_id}/sessions:
    post:
      tags:
        - peers
      summary: Get Sessions For Peer
      description: Get All Sessions for a Peer
      operationId: >-
        get_sessions_for_peer_v2_workspaces__workspace_id__peers__peer_id__sessions_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the workspace
            title: Workspace Id
          description: ID of the workspace
        - name: peer_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the peer
            title: Peer Id
          description: ID of the peer
        - name: page
          in: query
          required: false
          schema:
            type: integer
            minimum: 1
            description: Page number
            default: 1
            title: Page
          description: Page number
        - name: size
          in: query
          required: false
          schema:
            type: integer
            maximum: 100
            minimum: 1
            description: Page size
            default: 50
            title: Size
          description: Page size
      requestBody:
        content:
          application/json:
            schema:
              anyOf:
                - $ref: '#/components/schemas/SessionGet'
                - type: 'null'
              description: Filtering options for the sessions list
              title: Options
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Page_Session_'
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
    SessionGet:
      properties:
        filters:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Filters
      type: object
      title: SessionGet
    Page_Session_:
      properties:
        items:
          items:
            $ref: '#/components/schemas/Session'
          type: array
          title: Items
        total:
          anyOf:
            - type: integer
              minimum: 0
            - type: 'null'
          title: Total
        page:
          anyOf:
            - type: integer
              minimum: 1
            - type: 'null'
          title: Page
        size:
          anyOf:
            - type: integer
              minimum: 1
            - type: 'null'
          title: Size
        pages:
          anyOf:
            - type: integer
              minimum: 0
            - type: 'null'
          title: Pages
      type: object
      required:
        - items
        - page
        - size
      title: Page[Session]
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    Session:
      properties:
        id:
          type: string
          title: Id
        is_active:
          type: boolean
          title: Is Active
        workspace_id:
          type: string
          title: Workspace Id
        metadata:
          additionalProperties: true
          type: object
          title: Metadata
        configuration:
          additionalProperties: true
          type: object
          title: Configuration
        created_at:
          type: string
          format: date-time
          title: Created At
      type: object
      required:
        - id
        - is_active
        - workspace_id
        - created_at
      title: Session
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
