> Source: https://docs.honcho.dev/v3/api-reference/endpoint/peers/get-peer-context.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Peer Context

> Get context for a peer, including their representation and peer card.

This endpoint returns a curated subset of the representation and peer card for a peer.
If a target is specified, returns the context for the target from the
observer peer's perspective. If no target is specified, returns the
peer's own context (self-observation).

This is useful for getting all the context needed about a peer without
making multiple API calls.


## OpenAPI

````yaml get /v3/workspaces/{workspace_id}/peers/{peer_id}/context
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
  /v3/workspaces/{workspace_id}/peers/{peer_id}/context:
    get:
      tags:
        - peers
      summary: Get Peer Context
      description: >-
        Get context for a peer, including their representation and peer card.


        This endpoint returns a curated subset of the representation and peer
        card for a peer.

        If a target is specified, returns the context for the target from the

        observer peer's perspective. If no target is specified, returns the

        peer's own context (self-observation).


        This is useful for getting all the context needed about a peer without

        making multiple API calls.
      operationId: >-
        get_peer_context_v3_workspaces__workspace_id__peers__peer_id__context_get
      parameters:
        - name: workspace_id
          in: path
          required: true
          schema:
            type: string
            title: Workspace Id
        - name: peer_id
          in: path
          required: true
          schema:
            type: string
            description: ID of the observer peer
            title: Peer Id
          description: ID of the observer peer
        - name: target
          in: query
          required: false
          schema:
            anyOf:
              - type: string
              - type: 'null'
            description: >-
              Optional target peer to get context for, from the observer's
              perspective. If not provided, returns the observer's own context
              (self-observation)
            title: Target
          description: >-
            Optional target peer to get context for, from the observer's
            perspective. If not provided, returns the observer's own context
            (self-observation)
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
              semantic-search-retrieved conclusions to include
            title: Search Top K
          description: >-
            Only used if `search_query` is provided. Number of
            semantic-search-retrieved conclusions to include
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
              semantically relevant conclusions
            title: Search Max Distance
          description: >-
            Only used if `search_query` is provided. Maximum distance for
            semantically relevant conclusions
        - name: include_most_frequent
          in: query
          required: false
          schema:
            type: boolean
            description: >-
              Whether to include the most frequent conclusions in the
              representation
            default: true
            title: Include Most Frequent
          description: >-
            Whether to include the most frequent conclusions in the
            representation
        - name: max_conclusions
          in: query
          required: false
          schema:
            anyOf:
              - type: integer
                maximum: 100
                minimum: 1
              - type: 'null'
            description: Maximum number of conclusions to include in the representation
            title: Max Conclusions
          description: Maximum number of conclusions to include in the representation
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
        - {}
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
            - type: string
            - type: 'null'
          title: Representation
          description: >-
            A curated subset of the representation of the target peer from the
            observer's perspective
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
