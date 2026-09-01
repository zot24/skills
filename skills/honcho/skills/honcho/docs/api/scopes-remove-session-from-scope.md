> Source: https://honcho.dev/docs/v3/api-reference/endpoint/scopes/remove-session-from-scope.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Remove Session From Scope

> Remove a Session from a Scope.

Note: documents copied/derived while the session was a member are
reconciled asynchronously — the session's explicit copies are soft-deleted
from the scope, dependent derived documents follow (fail-closed), and the
scope's card is rebuilt from the remaining evidence.


## OpenAPI

````yaml delete /v3/workspaces/{workspace_id}/scopes/{scope_id}/sessions/{session_id}
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
  /v3/workspaces/{workspace_id}/scopes/{scope_id}/sessions/{session_id}:
    delete:
      tags:
        - scopes
      summary: Remove Session From Scope
      description: >-
        Remove a Session from a Scope.


        Note: documents copied/derived while the session was a member are

        reconciled asynchronously — the session's explicit copies are
        soft-deleted

        from the scope, dependent derived documents follow (fail-closed), and
        the

        scope's card is rebuilt from the remaining evidence.
      operationId: >-
        remove_session_from_scope_v3_workspaces__workspace_id__scopes__scope_id__sessions__session_id__delete
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
        - name: session_id
          in: path
          required: true
          schema:
            type: string
            title: Session Id
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
