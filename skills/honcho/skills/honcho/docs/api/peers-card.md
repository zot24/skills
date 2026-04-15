> Source: https://docs.honcho.dev/v3/api-reference/endpoint/peers/get-peer-card.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Get Peer Card

> Get a peer card for a specific peer relationship.

Returns the peer card that the observer peer has for the target peer if it exists.
If no target is specified, returns the observer's own peer card.


## OpenAPI

````yaml get /v3/workspaces/{workspace_id}/peers/{peer_id}/card
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
  /v3/workspaces/{workspace_id}/peers/{peer_id}/card:
    get:
      tags:
        - peers
      summary: Get Peer Card
      description: >-
        Get a peer card for a specific peer relationship.


        Returns the peer card that the observer peer has for the target peer if
        it exists.

        If no target is specified, returns the observer's own peer card.
      operationId: get_peer_card_v3_workspaces__workspace_id__peers__peer_id__card_get
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
              Optional target peer to retrieve a card for, from the observer's
              perspective. If not provided, returns the observer's own card
            title: Target
          description: >-
            Optional target peer to retrieve a card for, from the observer's
            perspective. If not provided, returns the observer's own card
      responses:
        '200':
          description: Successful Response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PeerCardResponse'
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
    PeerCardResponse:
      properties:
        peer_card:
          anyOf:
            - items:
                type: string
              type: array
            - type: 'null'
          title: Peer Card
          description: The peer card content, or None if not found
      type: object
      title: PeerCardResponse
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
