> Source: https://docs.honcho.dev/v3/api-reference/endpoint/sessions/get-session-context.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Session Context

> Produce a context object from the Session. The caller provides an optional token limit which the entire context must fit into.
If not provided, the context will be exhaustive (within configured max tokens). To do this, we allocate 40% of the token limit
to the summary, and 60% to recent messages -- as many as can fit. Note that the summary will usually take up less space than
this. If the caller does not want a summary, we allocate all the tokens to recent messages.


## OpenAPI

````yaml get /v3/workspaces/{workspace_id}/sessions/{session_id}/context
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
  /v3/workspaces/{workspace_id}/sessions/{session_id}/context:
    get:
      tags:
        - sessions
      summary: Get Session Context
      description: >-
        Produce a context object from the Session. The caller provides an
        optional token limit which the entire context must fit into.

        If not provided, the context will be exhaustive (within configured max
        tokens). To do this, we allocate 40% of the token limit

        to the summary, and 60% to recent messages -- as many as can fit. Note
        that the summary will usually take up less space than

        this. If the caller does not want a summary, we allocate all the tokens
        to recent messages.
      operationId: >-
        get_session_context_v3_workspaces__workspace_id__sessions__session_id__context_get
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
        - name: tokens
          in: query
          required: false
          schema:
            anyOf:
              - type: integer
                maximum: 100000
              - type: 'null'
            description: >-
              Number of tokens to use for the context. Includes summary if set
              to true. Includes representation and peer card if they are
              included in the response. If not provided, the context will be
              exhaustive (within 100000 tokens)
            title: Tokens
          description: >-
            Number of tokens to use for the context. Includes summary if set to
            true. Includes representation and peer card if they are included in
            the response. If not provided, the context will be exhaustive
            (within 100000 tokens)
        - name: search_query
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: A query string used to fetch semantically relevant conclusions
            title: Search Query
          description: A query string used to fetch semantically relevant conclusions
        - name: summary
          in: query
          required: false
          schema:
            type: boolean
            description: >-
              Whether or not to include a summary *if* one is available for the
              session
            default: true
            title: Summary
          description: >-
            Whether or not to include a summary *if* one is available for the
            session
        - name: peer_target
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: >-
              The target of the perspective. If given without
              `peer_perspective`, will get the Honcho-level representation and
              peer card for this peer. If given with `peer_perspective`, will
              get the representation and card for this peer *from the
              perspective of that peer*.
            title: Peer Target
          description: >-
            The target of the perspective. If given without `peer_perspective`,
            will get the Honcho-level representation and peer card for this
            peer. If given with `peer_perspective`, will get the representation
            and card for this peer *from the perspective of that peer*.
        - name: peer_perspective
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: >-
              A peer to get context for. If given, response will attempt to
              include representation and card from the perspective of that peer.
              Must be provided with `peer_target`.
            title: Peer Perspective
          description: >-
            A peer to get context for. If given, response will attempt to
            include representation and card from the perspective of that peer.
            Must be provided with `peer_target`.
        - name: limit_to_session
          in: query
          required: false
          schema:
            type: boolean
            description: >-
              Only used if `search_query` is provided. Whether to limit the
              representation to the session (as opposed to everything known
              about the target peer)
            default: false
            title: Limit To Session
          description: >-
            Only used if `search_query` is provided. Whether to limit the
            representation to the session (as opposed to everything known about
            the target peer)
        - name: search_top_k
          in: query
          required: false
          schema:
            anyOf:
              - type: integer
                maximum: 100
                minimum: 1
              - type: 'null'
            description: >-
              Only used if `search_query` is provided. The number of
              semantic-search-retrieved conclusions to include in the
              representation
            title: Search Top K
          description: >-
            Only used if `search_query` is provided. The number of
            semantic-search-retrieved conclusions to include in the
            representation
        - name: search_max_distance
          in: query
          required: false
          schema:
            anyOf:
              - type: number
                maximum: 1
                minimum: 0
              - type: 'null'
            description: >-
              Only used if `search_query` is provided. The maximum distance to
              search for semantically relevant conclusions
            title: Search Max Distance
          description: >-
            Only used if `search_query` is provided. The maximum distance to
            search for semantically relevant conclusions
        - name: include_most_frequent
          in: query
          required: false
          schema:
            type: boolean
            description: >-
              Only used if `search_query` is provided. Whether to include the
              most frequent conclusions in the representation
            default: false
            title: Include Most Frequent
          description: >-
            Only used if `search_query` is provided. Whether to include the most
            frequent conclusions in the representation
        - name: max_conclusions
          in: query
          required: false
          schema:
            anyOf:
              - type: integer
                maximum: 100
                minimum: 1
              - type: 'null'
            description: >-
              Only used if `search_query` is provided. The maximum number of
              conclusions to include in the representation
            title: Max Conclusions
          description: >-
            Only used if `search_query` is provided. The maximum number of
            conclusions to include in the representation
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/SessionContext'
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
    SessionContext:
      properties:
        id:
          type: string
          title: Id
        messages:
          items:
            $ref: '#/components/schemas/Message'
          type: array
          title: Messages
        summary:
          anyOf:
            - $ref: '#/components/schemas/Summary'
            - type: 'null'
          description: The summary if available
        peer_representation:
          anyOf:
            - type: string
            - type: 'null'
          title: Peer Representation
          description: >-
            A curated subset of a peer representation, if context is requested
            from a specific perspective
        peer_card:
          anyOf:
            - items:
                type: string
              type: array
            - type: 'null'
          title: Peer Card
          description: The peer card, if context is requested from a specific perspective
      type: object
      required:
        - id
        - messages
      title: SessionContext
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
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
    Summary:
      properties:
        content:
          type: string
          title: Content
          description: The summary text
        message_id:
          type: string
          title: Message Id
          description: The public ID of the message that this summary covers up to
        summary_type:
          type: string
          title: Summary Type
          description: The type of summary (short or long)
        created_at:
          type: string
          title: Created At
          description: The timestamp of when the summary was created (ISO format)
        token_count:
          type: integer
          title: Token Count
          description: The number of tokens in the summary text
      type: object
      required:
        - content
        - message_id
        - summary_type
        - created_at
        - token_count
      title: Summary
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
