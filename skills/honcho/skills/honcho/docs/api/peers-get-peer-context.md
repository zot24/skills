> Source: https://honcho.dev/docs/v2/api-reference/endpoint/peers/get-peer-context.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Peer Context

> Get context for a peer, including their representation and peer card.

This endpoint returns the working representation and peer card for a peer.
If a target is specified, returns the context for the target from the
observer peer's perspective. If no target is specified, returns the
peer's own context (self-observation).

This is useful for getting all the context needed about a peer without
making multiple API calls.


## OpenAPI

````yaml get /v2/workspaces/{workspace_id}/peers/{peer_id}/context
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
  /v2/workspaces/{workspace_id}/peers/{peer_id}/context:
    get:
      tags:
        - peers
      summary: Get Peer Context
      description: >-
        Get context for a peer, including their representation and peer card.


        This endpoint returns the working representation and peer card for a
        peer.

        If a target is specified, returns the context for the target from the

        observer peer's perspective. If no target is specified, returns the

        peer's own context (self-observation).


        This is useful for getting all the context needed about a peer without

        making multiple API calls.
      operationId: >-
        get_peer_context_v2_workspaces__workspace_id__peers__peer_id__context_get
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the workspace
            title: Workspace Id
          description: ID of the workspace
        - name: peer_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the peer (observer)
            title: Peer Id
          description: ID of the peer (observer)
        - name: target
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: >-
              The target peer to get context for. If not provided, returns the
              peer's own context (self-observation)
            title: Target
          description: >-
            The target peer to get context for. If not provided, returns the
            peer's own context (self-observation)
        - name: search_query
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: >-
              Optional query to curate the representation around semantic search
              results
            title: Search Query
          description: >-
            Optional query to curate the representation around semantic search
            results
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
              Only used if `search_query` is provided. Number of
              semantic-search-retrieved observations to include
            title: Search Top K
          description: >-
            Only used if `search_query` is provided. Number of
            semantic-search-retrieved observations to include
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
              Only used if `search_query` is provided. Maximum distance for
              semantically relevant observations
            title: Search Max Distance
          description: >-
            Only used if `search_query` is provided. Maximum distance for
            semantically relevant observations
        - name: include_most_derived
          in: query
          required: false
          schema:
            type: boolean
            description: >-
              Whether to include the most derived observations in the
              representation
            default: true
            title: Include Most Derived
          description: >-
            Whether to include the most derived observations in the
            representation
        - name: max_observations
          in: query
          required: false
          schema:
            anyOf:
              - type: integer
                maximum: 100
                minimum: 1
              - type: 'null'
            description: Maximum number of observations to include in the representation
            title: Max Observations
          description: Maximum number of observations to include in the representation
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PeerContext'
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
    PeerContext:
      properties:
        peer_id:
          type: string
          title: Peer Id
          description: The ID of the peer
        target_id:
          type: string
          title: Target Id
          description: The ID of the target peer being observed
        representation:
          anyOf:
            - $ref: '#/components/schemas/Representation'
            - type: 'null'
          description: >-
            The working representation of the target peer from the observer's
            perspective
        peer_card:
          anyOf:
            - items:
                type: string
              type: array
            - type: 'null'
          title: Peer Card
          description: The peer card for the target peer from the observer's perspective
      type: object
      required:
        - peer_id
        - target_id
      title: PeerContext
      description: Context for a peer, including representation and peer card.
    HTTPValidationError:
      properties:
        detail:
          items:
            $ref: '#/components/schemas/ValidationError'
          type: array
          title: Detail
      type: object
      title: HTTPValidationError
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
