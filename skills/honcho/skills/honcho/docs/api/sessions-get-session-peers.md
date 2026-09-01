> Source: https://honcho.dev/docs/v2/api-reference/endpoint/sessions/get-session-peers.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Session Peers

> Get peers from a session


## OpenAPI

````yaml get /v2/workspaces/{workspace_id}/sessions/{session_id}/peers
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
  /v2/workspaces/{workspace_id}/sessions/{session_id}/peers:
    get:
      tags:
        - sessions
      summary: Get Session Peers
      description: Get peers from a session
      operationId: >-
        get_session_peers_v2_workspaces__workspace_id__sessions__session_id__peers_get
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the workspace
            title: Workspace Id
          description: ID of the workspace
        - name: session_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the session
            title: Session Id
          description: ID of the session
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
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Page_Peer_'
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
    Page_Peer_:
      properties:
        items:
          items:
            $ref: '#/components/schemas/Peer'
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
      title: Page[Peer]
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
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
