> Source: https://honcho.dev/docs/v3/api-reference/endpoint/scopes/add-sessions-to-scope.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Add Sessions To Scope

> Add Sessions to a Scope.

All named sessions must already exist (404 otherwise). Adding a session that
is already a member is a no-op. List the resulting membership with
`POST /scopes/{scope_id}/sessions/list`.

Note: any added session that already has messages triggers an asynchronous
backfill-by-copy of its existing documents into the scope; track progress
via ``GET /scopes/{scope_id}/status``.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/scopes/{scope_id}/sessions
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
  /v3/workspaces/{workspace_id}/scopes/{scope_id}/sessions:
    post:
      tags:
        - scopes
      summary: Add Sessions To Scope
      description: >-
        Add Sessions to a Scope.


        All named sessions must already exist (404 otherwise). Adding a session
        that

        is already a member is a no-op. List the resulting membership with

        `POST /scopes/{scope_id}/sessions/list`.


        Note: any added session that already has messages triggers an
        asynchronous

        backfill-by-copy of its existing documents into the scope; track
        progress

        via ``GET /scopes/{scope_id}/status``.
      operationId: >-
        add_sessions_to_scope_v3_workspaces__workspace_id__scopes__scope_id__sessions_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
        - name: scope_id
          in: path
          required: true
          schema:
            type: string
            title: Scope Id
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ScopeSessionsAdd'
              description: IDs of the sessions to add to the scope
      responses:
        '204':
          description: Successful Response
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
    ScopeSessionsAdd:
      properties:
        session_ids:
          items:
            type: string
          type: array
          maxItems: 100
          minItems: 1
          title: Session Ids
          description: IDs of existing sessions to add to the scope
      type: object
      required:
        - session_ids
      title: ScopeSessionsAdd
      description: Schema for adding sessions to a scope.
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
