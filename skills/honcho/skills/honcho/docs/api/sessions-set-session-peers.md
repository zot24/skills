> Source: https://honcho.dev/docs/v2/api-reference/endpoint/sessions/set-session-peers.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Set Session Peers

> Set the peers in a session


## OpenAPI

````yaml put /v2/workspaces/{workspace_id}/sessions/{session_id}/peers
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
    put:
      tags:
        - sessions
      summary: Set Session Peers
      description: Set the peers in a session
      operationId: >-
        set_session_peers_v2_workspaces__workspace_id__sessions__session_id__peers_put
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
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              additionalProperties:
                $ref: '#/components/schemas/SessionPeerConfig'
              description: List of peer IDs to set for the session
              title: Peers
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Session'
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
    SessionPeerConfig:
      properties:
        observe_me:
          anyOf:
            - type: boolean
            - type: 'null'
          title: Observe Me
          description: >-
            Whether honcho should form a global theory-of-mind representation of
            this peer
        observe_others:
          anyOf:
            - type: boolean
            - type: 'null'
          title: Observe Others
          description: >-
            Whether this peer should form a session-level theory-of-mind
            representation of other peers in the session
      type: object
      title: SessionPeerConfig
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
