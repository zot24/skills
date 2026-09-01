> Source: https://honcho.dev/docs/v2/api-reference/endpoint/sessions/get-session-context.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Session Context

> Produce a context object from the session. The caller provides an optional token limit which the entire context must fit into.
If not provided, the context will be exhaustive (within configured max tokens). To do this, we allocate 40% of the token limit
to the summary, and 60% to recent messages -- as many as can fit. Note that the summary will usually take up less space than
this. If the caller does not want a summary, we allocate all the tokens to recent messages.


## OpenAPI

````yaml get /v2/workspaces/{workspace_id}/sessions/{session_id}/context
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
  /v2/workspaces/{workspace_id}/sessions/{session_id}/context:
    get:
      tags:
        - sessions
      summary: Get Session Context
      description: >-
        Produce a context object from the session. The caller provides an
        optional token limit which the entire context must fit into.

        If not provided, the context will be exhaustive (within configured max
        tokens). To do this, we allocate 40% of the token limit

        to the summary, and 60% to recent messages -- as many as can fit. Note
        that the summary will usually take up less space than

        this. If the caller does not want a summary, we allocate all the tokens
        to recent messages.
      operationId: >-
        get_session_context_v2_workspaces__workspace_id__sessions__session_id__context_get
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the workspace
            title: Workspace Id
          description: ID of the workspace
        - name: session_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the session
            title: Session Id
          description: ID of the session
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
        - name: last_message
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: >-
              The most recent message, used to fetch semantically relevant
              observations
            title: Last Message
          description: >-
            The most recent message, used to fetch semantically relevant
            observations
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
              Only used if `last_message` is provided. Whether to limit the
              representation to the session (as opposed to everything known
              about the target peer)
            default: false
            title: Limit To Session
          description: >-
            Only used if `last_message` is provided. Whether to limit the
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
              Only used if `last_message` is provided. The number of
              semantic-search-retrieved observations to include in the
              representation
            title: Search Top K
          description: >-
            Only used if `last_message` is provided. The number of
            semantic-search-retrieved observations to include in the
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
              Only used if `last_message` is provided. The maximum distance to
              search for semantically relevant observations
            title: Search Max Distance
          description: >-
            Only used if `last_message` is provided. The maximum distance to
            search for semantically relevant observations
        - name: include_most_derived
          in: query
          required: false
          schema:
            type: boolean
            description: >-
              Only used if `last_message` is provided. Whether to include the
              most derived observations in the representation
            default: false
            title: Include Most Derived
          description: >-
            Only used if `last_message` is provided. Whether to include the most
            derived observations in the representation
        - name: max_observations
          in: query
          required: false
          schema:
            anyOf:
              - type: integer
                maximum: 100
                minimum: 1
              - type: 'null'
            description: >-
              Only used if `last_message` is provided. The maximum number of
              observations to include in the representation
            title: Max Observations
          description: >-
            Only used if `last_message` is provided. The maximum number of
            observations to include in the representation
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
            - $ref: '#/components/schemas/Representation'
            - type: 'null'
          description: >-
            The peer representation, if context is requested from a specific
            perspective
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
    Representation:
      properties:
        explicit:
          items:
            $ref: '#/components/schemas/ExplicitObservation'
          type: array
          title: Explicit
          description: >-
            Facts LITERALLY stated by the user - direct quotes or clear
            paraphrases only, no interpretation or inference. Example: ['The
            user is 25 years old', 'The user has a dog']
        deductive:
          items:
            $ref: '#/components/schemas/DeductiveObservation'
          type: array
          title: Deductive
          description: >-
            Conclusions that MUST be true given explicit facts and premises -
            strict logical necessities. Each deduction should have premises and
            a single conclusion.
      type: object
      title: Representation
      description: >-
        A Representation is a traversable and diffable map of observations.

        At the base, we have a list of explicit observations, derived from a
        peer's messages.


        From there, deductive observations can be made by establishing logical
        relationships between explicit observations.


        In the future, we can add more levels of reasoning on top of these.


        All of a peer's observations are stored as documents in a collection.
        These documents can be queried in various ways

        to produce this Representation object.


        Additionally, a "working representation" is a version of this data
        structure representing the most recent observations

        within a single session.


        A representation can have a maximum number of observations, which is
        applied individually to each level of reasoning.

        If a maximum is set, observations are added and removed in FIFO order.
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
    ExplicitObservation:
      properties:
        created_at:
          type: string
          format: date-time
          title: Created At
        message_ids:
          items:
            type: integer
          type: array
          title: Message Ids
        session_name:
          type: string
          title: Session Name
        content:
          type: string
          title: Content
          description: The explicit observation
      type: object
      required:
        - created_at
        - message_ids
        - session_name
        - content
      title: ExplicitObservation
      description: Explicit observation with content and metadata.
    DeductiveObservation:
      properties:
        created_at:
          type: string
          format: date-time
          title: Created At
        message_ids:
          items:
            type: integer
          type: array
          title: Message Ids
        session_name:
          type: string
          title: Session Name
        premises:
          items:
            type: string
          type: array
          title: Premises
          description: Supporting premises or evidence for this conclusion
        conclusion:
          type: string
          title: Conclusion
          description: The deductive conclusion
      type: object
      required:
        - created_at
        - message_ids
        - session_name
        - conclusion
      title: DeductiveObservation
      description: >-
        Deductive observation with multiple premises and one conclusion, plus
        metadata.
  securitySchemes:
    HTTPBearer:
      type: http
      scheme: bearer

````
