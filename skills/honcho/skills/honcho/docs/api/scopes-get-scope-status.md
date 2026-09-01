> Source: https://honcho.dev/docs/v3/api-reference/endpoint/scopes/get-scope-status.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Scope Status

> Get the backfill/reconciliation job status for a Scope.

Returns a per-session map of the backfill job state (pending / completed /
failed) with the number of documents copied once complete. Empty when no
backfill has ever been enqueued for the scope.


## OpenAPI

````yaml get /v3/workspaces/{workspace_id}/scopes/{scope_id}/status
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
  /v3/workspaces/{workspace_id}/scopes/{scope_id}/status:
    get:
      tags:
        - scopes
      summary: Get Scope Status
      description: >-
        Get the backfill/reconciliation job status for a Scope.


        Returns a per-session map of the backfill job state (pending / completed
        /

        failed) with the number of documents copied once complete. Empty when no

        backfill has ever been enqueued for the scope.
      operationId: >-
        get_scope_status_v3_workspaces__workspace_id__scopes__scope_id__status_get
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
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ScopeStatus'
        '404':
          description: Not Found
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
    ScopeStatus:
      properties:
        backfill_status:
          additionalProperties:
            additionalProperties: true
            type: object
          type: object
          title: Backfill Status
      type: object
      title: ScopeStatus
      description: >-
        Per-session backfill/reconciliation job status for a scope.


        ``backfill_status`` maps each session that has had a backfill enqueued
        to

        its current job state: ``{state, updated_at[, docs_copied]}`` where

        ``state`` is ``pending``/``completed``/``failed`` and ``docs_copied`` is

        present once a backfill completes.
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
