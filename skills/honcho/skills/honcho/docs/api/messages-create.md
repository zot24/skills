> Source: https://docs.honcho.dev/v3/api-reference/endpoint/messages/create-messages-for-session.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Create Messages For Session

> Add new message(s) to a session.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/sessions/{session_id}/messages
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
  /v3/workspaces/{workspace_id}/sessions/{session_id}/messages:
    post:
      tags:
        - messages
      summary: Create Messages For Session
      description: Add new message(s) to a session.
      operationId: >-
        create_messages_for_session_v3_workspaces__workspace_id__sessions__session_id__messages_post
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
          application/json:
            schema:
              $ref: '#/components/schemas/MessageBatchCreate'
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
                  Response Create Messages For Session V3 Workspaces  Workspace
                  Id  Sessions  Session Id  Messages Post
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
    MessageBatchCreate:
      properties:
        messages:
          items:
            $ref: '#/components/schemas/MessageCreate'
          type: array
          maxItems: 100
          minItems: 1
          title: Messages
      type: object
      required:
        - messages
      title: MessageBatchCreate
      description: Schema for batch message creation with a max of 100 messages
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
    MessageCreate:
      properties:
        content:
          type: string
          maxLength: 25000
          minLength: 0
          title: Content
        peer_id:
          type: string
          title: Peer Id
        metadata:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Metadata
        configuration:
          anyOf:
            - $ref: '#/components/schemas/MessageConfiguration'
            - type: 'null'
        created_at:
          anyOf:
            - type: string
              format: date-time
            - type: 'null'
          title: Created At
      type: object
      required:
        - content
        - peer_id
      title: MessageCreate
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
    MessageConfiguration:
      properties:
        reasoning:
          anyOf:
            - $ref: '#/components/schemas/ReasoningConfiguration'
            - type: 'null'
          description: Configuration for reasoning functionality.
      type: object
      title: MessageConfiguration
      description: >-
        The set of options that can be in a message DB-level configuration
        dictionary.


        All fields are optional. Message-level configuration overrides all other
        configurations.
    ReasoningConfiguration:
      properties:
        enabled:
          anyOf:
            - type: boolean
            - type: 'null'
          title: Enabled
          description: Whether to enable reasoning functionality.
        custom_instructions:
          anyOf:
            - type: string
            - type: 'null'
          title: Custom Instructions
          description: >-
            TODO: currently unused. Custom instructions to use for the reasoning
            system on this workspace/session/message.
      type: object
      title: ReasoningConfiguration
  securitySchemes:
    HTTPBearer:
      type: http
      scheme: bearer

````
