> Source: https://honcho.dev/docs/v2/api-reference/endpoint/peers/set-peer-card.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Set Peer Card

> Set a peer card for a specific peer relationship.

Sets the peer card that the observer peer has for the target peer.
If no target is specified, sets the observer's own peer card.


## OpenAPI

````yaml put /v2/workspaces/{workspace_id}/peers/{peer_id}/card
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
  /v2/workspaces/{workspace_id}/peers/{peer_id}/card:
    put:
      tags:
        - peers
      summary: Set Peer Card
      description: |-
        Set a peer card for a specific peer relationship.

        Sets the peer card that the observer peer has for the target peer.
        If no target is specified, sets the observer's own peer card.
      operationId: set_peer_card_v2_workspaces__workspace_id__peers__peer_id__card_put
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
              The peer whose card to set. If not provided, sets the observer's
              own card
            title: Target
          description: >-
            The peer whose card to set. If not provided, sets the observer's own
            card
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/PeerCardSet'
              description: Peer card data to set
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
components:
  schemas:
    PeerCardSet:
      properties:
        peer_card:
          items:
            type: string
          type: array
          title: Peer Card
          description: The peer card content to set
      type: object
      required:
        - peer_card
      title: PeerCardSet
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
