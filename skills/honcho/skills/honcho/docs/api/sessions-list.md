> Source: https://docs.honcho.dev/v3/api-reference/endpoint/sessions/get-sessions.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Sessions

> Get all Sessions for a Workspace, paginated with optional filters.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/sessions/list
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
  /v3/workspaces/{workspace_id}/sessions/list:
    post:
      tags:
        - sessions
      summary: Get Sessions
      description: Get all Sessions for a Workspace, paginated with optional filters.
      operationId: get_sessions_v3_workspaces__workspace_id__sessions_list_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
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
              description: Filtering and pagination options for the sessions list
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
        - {}
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
          type: integer
          minimum: 0
          title: Total
        page:
          type: integer
          minimum: 1
          title: Page
        size:
          type: integer
          minimum: 1
          title: Size
        pages:
          type: integer
          minimum: 0
          title: Pages
      type: object
      required:
        - items
        - total
        - page
        - size
        - pages
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
