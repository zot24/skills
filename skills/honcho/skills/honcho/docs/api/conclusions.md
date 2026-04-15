> Source: https://docs.honcho.dev/v3/api-reference/endpoint/conclusions/create-conclusions.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Create Conclusions

> Create one or more Conclusions.

Conclusions are logical certainties derived from interactions between Peers. They form the basis of a Peer's Representation.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/conclusions
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
  /v3/workspaces/{workspace_id}/conclusions:
    post:
      tags:
        - conclusions
      summary: Create Conclusions
      description: >-
        Create one or more Conclusions.


        Conclusions are logical certainties derived from interactions between
        Peers. They form the basis of a Peer's Representation.
      operationId: create_conclusions_v3_workspaces__workspace_id__conclusions_post
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
              $ref: '#/components/schemas/ConclusionBatchCreate'
              description: Batch of Conclusions to create
      responses:
        '201':
          description: Successful Response
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Conclusion'
                title: >-
                  Response Create Conclusions V3 Workspaces  Workspace Id 
                  Conclusions Post
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
    ConclusionBatchCreate:
      properties:
        conclusions:
          items:
            $ref: '#/components/schemas/ConclusionCreate'
          type: array
          maxItems: 100
          minItems: 1
          title: Conclusions
      type: object
      required:
        - conclusions
      title: ConclusionBatchCreate
      description: Schema for batch conclusion creation with a max of 100 conclusions.
    Conclusion:
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
          description: The peer who made the conclusion
        observed_id:
          type: string
          title: Observed Id
          description: The peer the conclusion is about
        session_id:
          anyOf:
            - type: string
            - type: 'null'
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
        - created_at
      title: Conclusion
      description: Conclusion response - external view of a document.
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    ConclusionCreate:
      properties:
        content:
          type: string
          maxLength: 65535
          minLength: 1
          title: Content
        observer_id:
          type: string
          title: Observer Id
          description: The peer making the conclusion
        observed_id:
          type: string
          title: Observed Id
          description: The peer the conclusion is about
        session_id:
          anyOf:
            - type: string
            - type: 'null'
          title: Session Id
          description: A session ID to store the conclusion in, if specified
      type: object
      required:
        - content
        - observer_id
        - observed_id
      title: ConclusionCreate
      description: Schema for creating a single conclusion.
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
