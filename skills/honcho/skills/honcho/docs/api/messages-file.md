> Source: https://docs.honcho.dev/v3/api-reference/endpoint/messages/create-messages-with-file.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Create Messages With File

> Create messages from uploaded files. Files are converted to text and split into multiple messages.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/sessions/{session_id}/messages/upload
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
  /v3/workspaces/{workspace_id}/sessions/{session_id}/messages/upload:
    post:
      tags:
        - messages
      summary: Create Messages With File
      description: >-
        Create messages from uploaded files. Files are converted to text and
        split into multiple messages.
      operationId: >-
        create_messages_with_file_v3_workspaces__workspace_id__sessions__session_id__messages_upload_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
        - name: session_id
          in: path
          required: true
          schema:
            type: string
            title: Session Id
      requestBody:
        required: true
        content:
          multipart/form-data:
            schema:
              $ref: >-
                #/components/schemas/Body_create_messages_with_file_v3_workspaces__workspace_id__sessions__session_id__messages_upload_post
      responses:
        '201':
          description: Successful Response
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Message'
                title: >-
                  Response Create Messages With File V3 Workspaces  Workspace
                  Id  Sessions  Session Id  Messages Upload Post
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
    Body_create_messages_with_file_v3_workspaces__workspace_id__sessions__session_id__messages_upload_post:
      properties:
        file:
          type: string
          contentMediaType: application/octet-stream
          title: File
        peer_id:
          type: string
          title: Peer Id
        metadata:
          anyOf:
            - type: string
            - type: 'null'
          title: Metadata
        configuration:
          anyOf:
            - type: string
            - type: 'null'
          title: Configuration
        created_at:
          anyOf:
            - type: string
            - type: 'null'
          title: Created At
      type: object
      required:
        - file
        - peer_id
      title: >-
        Body_create_messages_with_file_v3_workspaces__workspace_id__sessions__session_id__messages_upload_post
    Message:
      properties:
        id:
          type: string
          title: Id
        content:
          type: string
          title: Content
        peer_id:
          type: string
          title: Peer Id
        session_id:
          type: string
          title: Session Id
        metadata:
          additionalProperties: true
          type: object
          title: Metadata
        created_at:
          type: string
          format: date-time
          title: Created At
        workspace_id:
          type: string
          title: Workspace Id
        token_count:
          type: integer
          title: Token Count
      type: object
      required:
        - id
        - content
        - peer_id
        - session_id
        - created_at
        - workspace_id
        - token_count
      title: Message
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
