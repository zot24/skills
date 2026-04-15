> Source: https://docs.honcho.dev/v3/api-reference/endpoint/workspaces/get-or-create-workspace.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Or Create Workspace

> Get a Workspace by ID.

If workspace_id is provided as a query parameter, it uses that (must match JWT workspace_id).
Otherwise, it uses the workspace_id from the JWT.


## OpenAPI

````yaml post /v3/workspaces
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
  /v3/workspaces:
    post:
      tags:
        - workspaces
      summary: Get Or Create Workspace
      description: >-
        Get a Workspace by ID.


        If workspace_id is provided as a query parameter, it uses that (must
        match JWT workspace_id).

        Otherwise, it uses the workspace_id from the JWT.
      operationId: get_or_create_workspace_v3_workspaces_post
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/WorkspaceCreate'
              description: Workspace creation parameters
        required: true
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
        - {}
components:
  schemas:
    WorkspaceCreate:
      properties:
        id:
          type: string
          maxLength: 100
          minLength: 1
          pattern: ^[a-zA-Z0-9_-]+$
          title: Id
        metadata:
          additionalProperties: true
          type: object
          title: Metadata
          default: {}
        configuration:
          $ref: '#/components/schemas/WorkspaceConfiguration'
      type: object
      required:
        - id
      title: WorkspaceCreate
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
    WorkspaceConfiguration:
      properties:
        reasoning:
          anyOf:
            - $ref: '#/components/schemas/ReasoningConfiguration'
            - type: 'null'
          description: Configuration for reasoning functionality.
        peer_card:
          anyOf:
            - $ref: '#/components/schemas/PeerCardConfiguration'
            - type: 'null'
          description: >-
            Configuration for peer card functionality. If reasoning is disabled,
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
            Configuration for dream functionality. If reasoning is disabled,
            dreams will also be disabled and these settings will be ignored.
      additionalProperties: true
      type: object
      title: WorkspaceConfiguration
      description: >-
        The set of options that can be in a workspace DB-level configuration
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
    PeerCardConfiguration:
      properties:
        use:
          anyOf:
            - type: boolean
            - type: 'null'
          title: Use
          description: >-
            Whether to use peer card related to this peer during reasoning
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
            Whether to enable dream functionality. If reasoning is disabled,
            dreams will also be disabled and this setting will be ignored.
      type: object
      title: DreamConfiguration
  securitySchemes:
    HTTPBearer:
      type: http
      scheme: bearer

````
