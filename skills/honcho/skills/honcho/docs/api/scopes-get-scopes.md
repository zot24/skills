> Source: https://honcho.dev/docs/v3/api-reference/endpoint/scopes/get-scopes.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Scopes

> Get all Scopes for a Workspace. Results are paginated.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/scopes/list
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
  /v3/workspaces/{workspace_id}/scopes/list:
    post:
      tags:
        - scopes
      summary: Get Scopes
      description: Get all Scopes for a Workspace. Results are paginated.
      operationId: get_scopes_v3_workspaces__workspace_id__scopes_list_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
        - name: reverse
          in: query
          required: false
          schema:
            type: boolean
            description: Whether to reverse the order of results
            default: false
            title: Reverse
          description: Whether to reverse the order of results
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Page_Scope_'
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
    Page_Scope_:
      properties:
        items:
          items:
            $ref: '#/components/schemas/Scope'
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
      title: Page[Scope]
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
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
