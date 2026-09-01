> Source: https://honcho.dev/docs/v2/api-reference/endpoint/observations/query-observations.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Query Observations

> Query observations using semantic search.

Performs vector similarity search on observations to find semantically relevant results.
Observer and observed are required for semantic search and must be provided in filters.


## OpenAPI

````yaml post /v2/workspaces/{workspace_id}/observations/query
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
  /v2/workspaces/{workspace_id}/observations/query:
    post:
      tags:
        - observations
      summary: Query Observations
      description: >-
        Query observations using semantic search.


        Performs vector similarity search on observations to find semantically
        relevant results.

        Observer and observed are required for semantic search and must be
        provided in filters.
      operationId: query_observations_v2_workspaces__workspace_id__observations_query_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the workspace
            title: Workspace Id
          description: ID of the workspace
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ObservationQuery'
              description: Semantic search parameters for observations
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Observation'
                title: >-
                  Response Query Observations V2 Workspaces  Workspace Id 
                  Observations Query Post
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
    ObservationQuery:
      properties:
        query:
          type: string
          title: Query
          description: Semantic search query
        top_k:
          type: integer
          maximum: 100
          minimum: 1
          title: Top K
          description: Number of results to return
          default: 10
        distance:
          anyOf:
            - type: number
              maximum: 1
              minimum: 0
            - type: 'null'
          title: Distance
          description: Maximum cosine distance threshold for results
        filters:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Filters
          description: Additional filters to apply
      type: object
      required:
        - query
      title: ObservationQuery
      description: Query parameters for semantic search of observations
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
