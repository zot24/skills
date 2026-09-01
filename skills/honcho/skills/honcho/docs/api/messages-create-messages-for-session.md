> Source: https://honcho.dev/docs/v2/api-reference/endpoint/messages/create-messages-for-session.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Create Messages For Session

> Add new message(s) to a session.


## OpenAPI

````yaml post /v2/workspaces/{workspace_id}/sessions/{session_id}/messages/
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
  /v2/workspaces/{workspace_id}/sessions/{session_id}/messages/:
    post:
      tags:
        - messages
      summary: Create Messages For Session
      description: Add new message(s) to a session.
      operationId: >-
        create_messages_for_session_v2_workspaces__workspace_id__sessions__session_id__messages__post
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
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Message'
                title: >-
                  Response Create Messages For Session V2 Workspaces  Workspace
                  Id  Sessions  Session Id  Messages  Post
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
      type: object
      required:
        - loc
        - msg
        - type
      title: ValidationError
    MessageConfiguration:
      properties:
        deriver:
          anyOf:
            - $ref: '#/components/schemas/DeriverConfiguration'
            - type: 'null'
          description: Configuration for deriver functionality.
        peer_card:
          anyOf:
            - $ref: '#/components/schemas/PeerCardConfiguration'
            - type: 'null'
          description: >-
            Configuration for peer card functionality. If deriver is disabled,
            peer cards will also be disabled and these settings will be ignored.
      type: object
      title: MessageConfiguration
      description: >-
        The set of options that can be in a message DB-level configuration
        dictionary.


        All fields are optional. Message-level configuration overrides all other
        configurations.
    DeriverConfiguration:
      properties:
        enabled:
          anyOf:
            - type: boolean
            - type: 'null'
          title: Enabled
          description: Whether to enable deriver functionality.
        custom_instructions:
          anyOf:
            - type: string
            - type: 'null'
          title: Custom Instructions
          description: >-
            TODO: currently unused. Custom instructions to use for the deriver
            on this workspace/session/message.
      type: object
      title: DeriverConfiguration
    PeerCardConfiguration:
      properties:
        use:
          anyOf:
            - type: boolean
            - type: 'null'
          title: Use
          description: >-
            Whether to use peer card related to this peer during deriver
            process.
        create:
          anyOf:
            - type: boolean
            - type: 'null'
          title: Create
          description: Whether to generate peer card based on content.
      type: object
      title: PeerCardConfiguration
  securitySchemes:
    HTTPBearer:
      type: http
      scheme: bearer

````
