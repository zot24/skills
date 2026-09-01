> Source: https://honcho.dev/docs/v2/api-reference/endpoint/observations/delete-observation.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Delete Observation

> Delete a specific observation.

This permanently deletes the observation (document) from the theory-of-mind system.
This action cannot be undone.


## OpenAPI

````yaml delete /v2/workspaces/{workspace_id}/observations/{observation_id}
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
  /v2/workspaces/{workspace_id}/observations/{observation_id}:
    delete:
      tags:
        - observations
      summary: Delete Observation
      description: >-
        Delete a specific observation.


        This permanently deletes the observation (document) from the
        theory-of-mind system.

        This action cannot be undone.
      operationId: >-
        delete_observation_v2_workspaces__workspace_id__observations__observation_id__delete
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the workspace
            title: Workspace Id
          description: ID of the workspace
        - name: observation_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the observation to delete
            title: Observation Id
          description: ID of the observation to delete
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema: {}
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
