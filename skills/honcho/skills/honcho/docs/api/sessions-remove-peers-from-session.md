> Source: https://honcho.dev/docs/v2/api-reference/endpoint/sessions/remove-peers-from-session.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Remove Peers From Session

> Remove peers from a session


## OpenAPI

````yaml delete /v2/workspaces/{workspace_id}/sessions/{session_id}/peers
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
    delete:
      tags:
        - sessions
      summary: Remove Peers From Session
      description: Remove peers from a session
      operationId: >-
        remove_peers_from_session_v2_workspaces__workspace_id__sessions__session_id__peers_delete
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
              type: array
              items:
                type: string
              description: List of peer IDs to remove from the session
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
