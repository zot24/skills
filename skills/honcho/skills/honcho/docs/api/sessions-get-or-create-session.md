> Source: https://honcho.dev/docs/v2/api-reference/endpoint/sessions/get-or-create-session.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Or Create Session

> Get a specific session in a workspace.

If session_id is provided as a query parameter, it verifies the session is in the workspace.
Otherwise, it uses the session_id from the JWT for verification.


## OpenAPI

````yaml post /v2/workspaces/{workspace_id}/sessions
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
  /v2/workspaces/{workspace_id}/sessions:
    post:
      tags:
        - sessions
      summary: Get Or Create Session
      description: >-
        Get a specific session in a workspace.


        If session_id is provided as a query parameter, it verifies the session
        is in the workspace.

        Otherwise, it uses the session_id from the JWT for verification.
      operationId: get_or_create_session_v2_workspaces__workspace_id__sessions_post
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the workspace
            title: Workspace Id
          description: ID of the workspace
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/SessionCreate'
              description: Session creation parameters
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Session'
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
    SessionCreate:
      properties:
        id:
          type: string
          maxLength: 100
          minLength: 1
          pattern: ^[a-zA-Z0-9_-]+$
          title: Id
        metadata:
          anyOf:
            - additionalProperties: true
              type: object
            - type: 'null'
          title: Metadata
        peers:
          anyOf:
            - additionalProperties:
                $ref: '#/components/schemas/SessionPeerConfig'
              type: object
            - type: 'null'
          title: Peers
        configuration:
          anyOf:
            - $ref: '#/components/schemas/SessionConfiguration'
            - type: 'null'
      type: object
      required:
        - id
      title: SessionCreate
    Session:
      properties:
        id:
          type: string
          title: Id
        is_active:
          type: boolean
          title: Is Active
        workspace_id:
          type: string
          title: Workspace Id
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
        - is_active
        - workspace_id
        - created_at
      title: Session
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
    SessionPeerConfig:
      properties:
        observe_me:
          anyOf:
            - type: boolean
            - type: 'null'
          title: Observe Me
          description: >-
            Whether honcho should form a global theory-of-mind representation of
            this peer
        observe_others:
          anyOf:
            - type: boolean
            - type: 'null'
          title: Observe Others
          description: >-
            Whether this peer should form a session-level theory-of-mind
            representation of other peers in the session
      type: object
      title: SessionPeerConfig
    SessionConfiguration:
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
        summary:
          anyOf:
            - $ref: '#/components/schemas/SummaryConfiguration'
            - type: 'null'
          description: Configuration for summary functionality.
        dream:
          anyOf:
            - $ref: '#/components/schemas/DreamConfiguration'
            - type: 'null'
          description: >-
            Configuration for dream functionality. If deriver is disabled,
            dreams will also be disabled and these settings will be ignored.
      additionalProperties: true
      type: object
      title: SessionConfiguration
      description: >-
        The set of options that can be in a session DB-level configuration
        dictionary.


        All fields are optional. Session-level configuration overrides
        workspace-level configuration, which overrides global configuration.
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
    SummaryConfiguration:
      properties:
        enabled:
          anyOf:
            - type: boolean
            - type: 'null'
          title: Enabled
          description: Whether to enable summary functionality.
        messages_per_short_summary:
          anyOf:
            - type: integer
              minimum: 10
            - type: 'null'
          title: Messages Per Short Summary
          description: >-
            Number of messages per short summary. Must be positive, greater than
            or equal to 10, and less than messages_per_long_summary.
        messages_per_long_summary:
          anyOf:
            - type: integer
              minimum: 20
            - type: 'null'
          title: Messages Per Long Summary
          description: >-
            Number of messages per long summary. Must be positive, greater than
            or equal to 20, and greater than messages_per_short_summary.
      type: object
      title: SummaryConfiguration
    DreamConfiguration:
      properties:
        enabled:
          anyOf:
            - type: boolean
            - type: 'null'
          title: Enabled
          description: >-
            Whether to enable dream functionality. If deriver is disabled,
            dreams will also be disabled and this setting will be ignored.
      type: object
      title: DreamConfiguration
  securitySchemes:
    HTTPBearer:
      type: http
      scheme: bearer

````
