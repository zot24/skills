> Source: https://docs.honcho.dev/v3/api-reference/endpoint/sessions/search-session.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Search Session

> Search a Session with optional filters. Use `limit` to control the number of results returned.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/sessions/{session_id}/search
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
  /v3/workspaces/{workspace_id}/sessions/{session_id}/search:
    post:
      tags:
        - sessions
      summary: Search Session
      description: >-
        Search a Session with optional filters. Use `limit` to control the
        number of results returned.
      operationId: >-
        search_session_v3_workspaces__workspace_id__sessions__session_id__search_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
        - name: session_id
          in: path
          required: true
          schema:
            type: string
            title: Session Id
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/MessageSearchOptions'
              description: Message search parameters
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Message'
                title: >-
                  Response Search Session V3 Workspaces  Workspace Id  Sessions 
                  Session Id  Search Post
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
    MessageSearchOptions:
      properties:
        query:
          type: string
          title: Query
          description: Search query
        filters:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Filters
          description: Filters to scope the search
        limit:
          type: integer
          maximum: 100
          minimum: 1
          title: Limit
          description: Number of results to return
          default: 10
      type: object
      required:
        - query
      title: MessageSearchOptions
    Message:
      properties:
        id:
          type: string
          title: Id
        content:
          type: string
          title: Content
        peer_id:
          type: string
          title: Peer Id
        session_id:
          type: string
          title: Session Id
        metadata:
          additionalProperties: true
          type: object
          title: Metadata
        created_at:
          type: string
          format: date-time
          title: Created At
        workspace_id:
          type: string
          title: Workspace Id
        token_count:
          type: integer
          title: Token Count
      type: object
      required:
        - id
        - content
        - peer_id
        - session_id
        - created_at
        - workspace_id
        - token_count
      title: Message
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
