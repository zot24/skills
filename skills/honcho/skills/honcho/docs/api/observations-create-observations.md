> Source: https://honcho.dev/docs/v2/api-reference/endpoint/observations/create-observations.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Create Observations

> Create one or more observations.

Creates observations (theory-of-mind facts) for the specified observer/observed peer pairs.
Each observation must reference existing peers and a session within the workspace.
Embeddings are automatically generated for semantic search.

Maximum of 100 observations per request.


## OpenAPI

````yaml post /v2/workspaces/{workspace_id}/observations
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
  /v2/workspaces/{workspace_id}/observations:
    post:
      tags:
        - observations
      summary: Create Observations
      description: >-
        Create one or more observations.


        Creates observations (theory-of-mind facts) for the specified
        observer/observed peer pairs.

        Each observation must reference existing peers and a session within the
        workspace.

        Embeddings are automatically generated for semantic search.


        Maximum of 100 observations per request.
      operationId: create_observations_v2_workspaces__workspace_id__observations_post
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
              $ref: '#/components/schemas/ObservationBatchCreate'
              description: Batch of observations to create
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
                  Response Create Observations V2 Workspaces  Workspace Id 
                  Observations Post
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
    ObservationBatchCreate:
      properties:
        observations:
          items:
            $ref: '#/components/schemas/ObservationCreate'
          type: array
          maxItems: 100
          minItems: 1
          title: Observations
      type: object
      required:
        - observations
      title: ObservationBatchCreate
      description: Schema for batch observation creation with a max of 100 observations
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
    ObservationCreate:
      properties:
        content:
          type: string
          maxLength: 65535
          minLength: 1
          title: Content
        observer_id:
          type: string
          title: Observer Id
          description: The peer making the observation
        observed_id:
          type: string
          title: Observed Id
          description: The peer being observed
        session_id:
          type: string
          title: Session Id
          description: The session this observation relates to
      type: object
      required:
        - content
        - observer_id
        - observed_id
        - session_id
      title: ObservationCreate
      description: Schema for creating a single observation
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
