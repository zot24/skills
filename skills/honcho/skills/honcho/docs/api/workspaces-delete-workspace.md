> Source: https://honcho.dev/docs/v2/api-reference/endpoint/workspaces/delete-workspace.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Delete Workspace

> Delete a Workspace


## OpenAPI

````yaml delete /v2/workspaces/{workspace_id}
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
  /v2/workspaces/{workspace_id}:
    delete:
      tags:
        - workspaces
      summary: Delete Workspace
      description: Delete a Workspace
      operationId: delete_workspace_v2_workspaces__workspace_id__delete
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the workspace to delete
            title: Workspace Id
          description: ID of the workspace to delete
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Workspace'
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
    Workspace:
      properties:
        id:
          type: string
          title: Id
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
        - created_at
      title: Workspace
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
