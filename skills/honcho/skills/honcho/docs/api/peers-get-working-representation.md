> Source: https://honcho.dev/docs/v2/api-reference/endpoint/peers/get-working-representation.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Working Representation

> Get a peer's working representation for a session.

If a session_id is provided in the body, we get the working representation of the peer in that session.
If a target is provided, we get the representation of the target from the perspective of the peer.
If no target is provided, we get the omniscient Honcho representation of the peer.


## OpenAPI

````yaml post /v2/workspaces/{workspace_id}/peers/{peer_id}/representation
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
  /v2/workspaces/{workspace_id}/peers/{peer_id}/representation:
    post:
      tags:
        - peers
      summary: Get Working Representation
      description: >-
        Get a peer's working representation for a session.


        If a session_id is provided in the body, we get the working
        representation of the peer in that session.

        If a target is provided, we get the representation of the target from
        the perspective of the peer.

        If no target is provided, we get the omniscient Honcho representation of
        the peer.
      operationId: >-
        get_working_representation_v2_workspaces__workspace_id__peers__peer_id__representation_post
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
            description: ID of the peer
            title: Peer Id
          description: ID of the peer
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/PeerRepresentationGet'
              description: Options for getting the peer representation
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                type: object
                additionalProperties: true
                title: >-
                  Response Get Working Representation V2 Workspaces  Workspace
                  Id  Peers  Peer Id  Representation Post
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
    PeerRepresentationGet:
      properties:
        session_id:
          anyOf:
            - type: string
            - type: 'null'
          title: Session Id
          description: Get the working representation within this session
        target:
          anyOf:
            - type: string
            - type: 'null'
          title: Target
          description: >-
            Optional peer ID to get the representation for, from the perspective
            of this peer
        search_query:
          anyOf:
            - type: string
            - type: 'null'
          title: Search Query
          description: >-
            Optional input to curate the representation around semantic search
            results
        search_top_k:
          anyOf:
            - type: integer
              maximum: 100
              minimum: 1
            - type: 'null'
          title: Search Top K
          description: >-
            Only used if `search_query` is provided. Number of
            semantic-search-retrieved observations to include in the
            representation
        search_max_distance:
          anyOf:
            - type: number
              maximum: 1
              minimum: 0
            - type: 'null'
          title: Search Max Distance
          description: >-
            Only used if `search_query` is provided. Maximum distance to search
            for semantically relevant observations
        include_most_derived:
          anyOf:
            - type: boolean
            - type: 'null'
          title: Include Most Derived
          description: >-
            Only used if `search_query` is provided. Whether to include the most
            derived observations in the representation
        max_observations:
          anyOf:
            - type: integer
              maximum: 100
              minimum: 1
            - type: 'null'
          title: Max Observations
          description: >-
            Only used if `search_query` is provided. Maximum number of
            observations to include in the representation
          default: 25
      type: object
      title: PeerRepresentationGet
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
