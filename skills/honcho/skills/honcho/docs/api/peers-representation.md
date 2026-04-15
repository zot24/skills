> Source: https://docs.honcho.dev/v3/api-reference/endpoint/peers/get-representation.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Representation

> Get a curated subset of a Peer's Representation. A Representation is always a subset of the total
knowledge about the Peer. The subset can be scoped and filtered in various ways.


If a session_id is provided in the body, we get the Representation of the Peer scoped to that Session.
If a target is provided, we get the Representation of the target from the perspective of the Peer.
If no target is provided, we get the omniscient Honcho Representation of the Peer.


## OpenAPI

````yaml post /v3/workspaces/{workspace_id}/peers/{peer_id}/representation
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
  /v3/workspaces/{workspace_id}/peers/{peer_id}/representation:
    post:
      tags:
        - peers
      summary: Get Representation
      description: >-
        Get a curated subset of a Peer's Representation. A Representation is
        always a subset of the total

        knowledge about the Peer. The subset can be scoped and filtered in
        various ways.


        If a session_id is provided in the body, we get the Representation of
        the Peer scoped to that Session.

        If a target is provided, we get the Representation of the target from
        the perspective of the Peer.

        If no target is provided, we get the omniscient Honcho Representation of
        the Peer.
      operationId: >-
        get_representation_v3_workspaces__workspace_id__peers__peer_id__representation_post
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
            title: Peer Id
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
                $ref: '#/components/schemas/RepresentationResponse'
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
    PeerRepresentationGet:
      properties:
        session_id:
          anyOf:
            - type: string
            - type: 'null'
          title: Session Id
          description: Optional session ID within which to scope the representation
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
            semantic-search-retrieved conclusions to include in the
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
            for semantically relevant conclusions
        include_most_frequent:
          anyOf:
            - type: boolean
            - type: 'null'
          title: Include Most Frequent
          description: >-
            Only used if `search_query` is provided. Whether to include the most
            frequent conclusions in the representation
        max_conclusions:
          anyOf:
            - type: integer
              maximum: 100
              minimum: 1
            - type: 'null'
          title: Max Conclusions
          description: >-
            Only used if `search_query` is provided. Maximum number of
            conclusions to include in the representation
          default: 25
      type: object
      title: PeerRepresentationGet
    RepresentationResponse:
      properties:
        representation:
          type: string
          title: Representation
      type: object
      required:
        - representation
      title: RepresentationResponse
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
