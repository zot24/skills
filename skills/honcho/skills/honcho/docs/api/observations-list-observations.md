> Source: https://honcho.dev/docs/v2/api-reference/endpoint/observations/list-observations.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# List Observations

> List all observations using custom filters. Observations are listed by recency unless `reverse` is set to `true`.

Observations can be filtered by session_id, observer_id and observed_id using the filters parameter.


## OpenAPI

````yaml post /v2/workspaces/{workspace_id}/observations/list
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
  /v2/workspaces/{workspace_id}/observations/list:
    post:
      tags:
        - observations
      summary: List Observations
      description: >-
        List all observations using custom filters. Observations are listed by
        recency unless `reverse` is set to `true`.


        Observations can be filtered by session_id, observer_id and observed_id
        using the filters parameter.
      operationId: list_observations_v2_workspaces__workspace_id__observations_list_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the workspace
            title: Workspace Id
          description: ID of the workspace
        - name: reverse
          in: query
          required: false
          schema:
            anyOf:
              - type: boolean
              - type: 'null'
            description: Whether to reverse the order of results
            default: false
            title: Reverse
          description: Whether to reverse the order of results
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
                - $ref: '#/components/schemas/ObservationGet'
                - type: 'null'
              description: Filtering options for the observations list
              title: Options
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Page_Observation_'
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
    ObservationGet:
      properties:
        filters:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Filters
      type: object
      title: ObservationGet
      description: Schema for listing observations with optional filters
    Page_Observation_:
      properties:
        items:
          items:
            $ref: '#/components/schemas/Observation'
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
      title: Page[Observation]
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    Observation:
      properties:
        id:
          type: string
          title: Id
        content:
          type: string
          title: Content
        observer_id:
          type: string
          title: Observer Id
          description: The peer who made the observation
        observed_id:
          type: string
          title: Observed Id
          description: The peer being observed
        session_id:
          type: string
          title: Session Id
        created_at:
          type: string
          format: date-time
          title: Created At
      type: object
      required:
        - id
        - content
        - observer_id
        - observed_id
        - session_id
        - created_at
      title: Observation
      description: Observation response - external view of a document
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
