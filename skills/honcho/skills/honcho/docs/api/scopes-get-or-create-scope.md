> Source: https://honcho.dev/docs/v3/api-reference/endpoint/scopes/get-or-create-scope.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Or Create Scope

> Get a Scope by ID or create a new Scope with the given ID.

Returns 201 when the scope is created and 200 when it already exists.
A pre-existing peer occupying the scope's reserved internal name is never
adopted; that conflict returns 409.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/scopes
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
  /v3/workspaces/{workspace_id}/scopes:
    post:
      tags:
        - scopes
      summary: Get Or Create Scope
      description: >-
        Get a Scope by ID or create a new Scope with the given ID.


        Returns 201 when the scope is created and 200 when it already exists.

        A pre-existing peer occupying the scope's reserved internal name is
        never

        adopted; that conflict returns 409.
      operationId: get_or_create_scope_v3_workspaces__workspace_id__scopes_post
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
              $ref: '#/components/schemas/ScopeCreate'
              description: Scope creation parameters
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Scope'
        '201':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Scope'
        '409':
          description: Conflict
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/HTTPValidationError'
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
    ScopeCreate:
      properties:
        id:
          type: string
          minLength: 1
          title: Id
        metadata:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Metadata
      type: object
      required:
        - id
      title: ScopeCreate
      description: Schema for creating (or getting) a scope by its unprefixed name.
    Scope:
      properties:
        id:
          type: string
          title: Id
        metadata:
          additionalProperties: true
          type: object
          title: Metadata
        created_at:
          type: string
          format: date-time
          title: Created At
      type: object
      required:
        - id
        - created_at
      title: Scope
      description: >-
        Scope response — external view of the peer backing a scope.


        The ``id`` is the unprefixed scope name; the reserved peer-name prefix
        is

        an internal implementation detail and never surfaces here.
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
