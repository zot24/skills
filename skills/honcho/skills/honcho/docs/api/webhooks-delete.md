> Source: https://docs.honcho.dev/v3/api-reference/endpoint/webhooks/delete-webhook-endpoint.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Delete Webhook Endpoint

> Delete a specific webhook endpoint.


## OpenAPI

````yaml delete /v3/workspaces/{workspace_id}/webhooks/{endpoint_id}
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
  /v3/workspaces/{workspace_id}/webhooks/{endpoint_id}:
    delete:
      tags:
        - webhooks
      summary: Delete Webhook Endpoint
      description: Delete a specific webhook endpoint.
      operationId: >-
        delete_webhook_endpoint_v3_workspaces__workspace_id__webhooks__endpoint_id__delete
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            description: Workspace ID
            title: Workspace Id
          description: Workspace ID
        - name: endpoint_id
          in: path
          required: true
          schema:
            type: string
            description: Webhook endpoint ID
            title: Endpoint Id
          description: Webhook endpoint ID
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
