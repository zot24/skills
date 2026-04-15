> Source: https://docs.honcho.dev/v3/api-reference/endpoint/workspaces/delete-workspace.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Delete Workspace

> Delete a Workspace. This accepts the deletion request and processes it in the background,
permanently deleting all peers, messages, conclusions, and other resources associated
with the workspace.

Returns 409 Conflict if the workspace contains active sessions.
Delete all sessions first, then delete the workspace.

This action cannot be undone.


## OpenAPI

````yaml delete /v3/workspaces/{workspace_id}
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
  /v3/workspaces/{workspace_id}:
    delete:
      tags:
        - workspaces
      summary: Delete Workspace
      description: >-
        Delete a Workspace. This accepts the deletion request and processes it
        in the background,

        permanently deleting all peers, messages, conclusions, and other
        resources associated

        with the workspace.


        Returns 409 Conflict if the workspace contains active sessions.

        Delete all sessions first, then delete the workspace.


        This action cannot be undone.
      operationId: delete_workspace_v3_workspaces__workspace_id__delete
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
      responses:
        '202':
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
        - {}
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
