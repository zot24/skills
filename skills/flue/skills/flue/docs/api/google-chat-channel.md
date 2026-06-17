<!-- Source: https://flueframework.com/docs/api/google-chat-channel -->

Import from `@flue/google-chat`.

## `createGoogleChatChannel()` [\#](https://flueframework.com/docs/api/google-chat-channel/\#creategooglechatchannel)

```
function createGoogleChatChannel<E extends Env = Env>(
  options: GoogleChatChannelOptions<E>,
): GoogleChatChannel<E>;
```

Creates authenticated Google Chat callback routes. At least one of `interactions`
or `workspaceEvents` is required. Omitted surfaces do not publish routes.

## `GoogleChatChannelOptions` [\#](https://flueframework.com/docs/api/google-chat-channel/\#googlechatchanneloptions)

```
interface GoogleChatChannelOptions<E extends Env = Env> {
  interactions?: {
    authentication: GoogleChatInteractionAuthentication;
    handler(input: GoogleChatInteractionHandlerInput<E>): GoogleChatHandlerResult;
  };
  workspaceEvents?: {
    authentication: GoogleChatPubSubAuthentication;
    handler(input: GoogleChatWorkspaceEventHandlerInput<E>): GoogleChatHandlerResult;
  };
  fetch?: typeof globalThis.fetch;
  bodyLimit?: number;
}
```

| Field | Description |
| --- | --- |
| `interactions` | Authenticates and handles provider-native Google Chat interaction payloads. |
| `workspaceEvents` | Authenticates and handles wrapped Pub/Sub push deliveries from the Google Workspace Events API. |
| `fetch` | Fetch implementation used only for Google signing-key discovery. |
| `bodyLimit` | Positive integer request-body limit in bytes. Defaults to 1 MiB. |

## Callback inputs [\#](https://flueframework.com/docs/api/google-chat-channel/\#callback-inputs)

```
interface GoogleChatInteractionHandlerInput<E extends Env = Env> {
  c: Context<E>;
  payload: GoogleChatInteraction;
}

interface GoogleChatWorkspaceEventHandlerInput<E extends Env = Env> {
  c: Context<E>;
  delivery: GoogleChatWorkspaceEventDelivery;
}
```

Interaction callbacks receive `{ c, payload }`; Workspace Event callbacks receive
`{ c, delivery }`. `c` is the Hono context. `payload` and `delivery` preserve the
provider-native request objects, including unknown fields and future event types.

## Callback results [\#](https://flueframework.com/docs/api/google-chat-channel/\#callback-results)

```
type JsonValue = null | boolean | number | string | JsonValue[] | { [key: string]: JsonValue };

type GoogleChatHandlerResult =
  | undefined
  | JsonValue
  | Response
  | Promise<undefined | JsonValue | Response>;
```

Returning `undefined` produces an empty `200` response. A `JsonValue` produces a
JSON response. A Hono or Fetch `Response` passes through unchanged. Callback
errors propagate to Hono error handling.

Before invoking a callback, the route returns an empty response with:

- `400` for malformed JSON or an invalid provider envelope;
- `401` for missing or invalid authentication;
- `403` when a Pub/Sub delivery names a different subscription;
- `413` when the declared or streamed body exceeds `bodyLimit`; or
- `415` unless the media type is `application/json`.

## Interaction authentication [\#](https://flueframework.com/docs/api/google-chat-channel/\#interaction-authentication)

```
type GoogleChatInteractionAuthentication =
  | {
      type: 'endpoint-url';
      audience: string;
      jwksUrl?: string;
    }
  | {
      type: 'project-number';
      projectNumber: string;
      certificatesUrl?: string;
    };
```

`endpoint-url` verifies a Google OIDC token addressed to the exact configured
HTTPS endpoint URL and issued for `chat@system.gserviceaccount.com`.
`project-number` verifies a Google Chat service token addressed to the configured
numeric project number using the Chat service-account certificates.

`jwksUrl` and `certificatesUrl` override Google discovery endpoints for supported
environments and local protocol tests.

## Pub/Sub authentication [\#](https://flueframework.com/docs/api/google-chat-channel/\#pubsub-authentication)

```
interface GoogleChatPubSubAuthentication {
  subscription: string;
  audience: string;
  serviceAccountEmail: string;
  jwksUrl?: string;
}
```

`subscription` is the exact
`projects/<project>/subscriptions/<subscription>` resource required in the push
body. The bearer token must have the configured audience and verified service
account email. `jwksUrl` overrides Google’s OIDC JWKS endpoint.

## Provider wire types [\#](https://flueframework.com/docs/api/google-chat-channel/\#provider-wire-types)

```
type GoogleChatInteractionType =
  | 'MESSAGE'
  | 'ADDED_TO_SPACE'
  | 'REMOVED_FROM_SPACE'
  | 'CARD_CLICKED'
  | 'APP_COMMAND'
  | 'APP_HOME'
  | 'SUBMIT_FORM'
  | 'WIDGET_UPDATED'
  | (string & {});

interface GoogleChatInteraction {
  type: GoogleChatInteractionType;
  eventTime?: string;
  user?: GoogleChatUser;
  space?: GoogleChatSpace;
  message?: GoogleChatMessage;
  thread?: GoogleChatThread;
  action?: GoogleChatAction;
  appCommandMetadata?: Record<string, unknown>;
  common?: Record<string, unknown>;
  [key: string]: unknown;
}
```

```
type GoogleChatSpaceType = 'SPACE' | 'GROUP_CHAT' | 'DIRECT_MESSAGE' | (string & {});

type GoogleChatDeprecatedSpaceType = 'ROOM' | 'DM' | (string & {});

interface GoogleChatSpace {
  name?: string;
  spaceType?: GoogleChatSpaceType;
  type?: GoogleChatDeprecatedSpaceType;
  [key: string]: unknown;
}

interface GoogleChatThread {
  name?: string;
  [key: string]: unknown;
}

interface GoogleChatUser {
  name?: string;
  displayName?: string;
  type?: string;
  domainId?: string;
  [key: string]: unknown;
}

interface GoogleChatMessage {
  name?: string;
  text?: string;
  argumentText?: string;
  formattedText?: string;
  space?: GoogleChatSpace;
  thread?: GoogleChatThread;
  attachment?: readonly unknown[];
  annotations?: readonly unknown[];
  [key: string]: unknown;
}

interface GoogleChatAction {
  actionMethodName?: string;
  parameters?: readonly {
    key?: string;
    value?: string;
    [key: string]: unknown;
  }[];
  [key: string]: unknown;
}
```

Workspace Events remain wrapped in the Pub/Sub push body:

```
interface GoogleChatWorkspaceEventDelivery {
  message: GoogleChatPubSubMessage;
  subscription: string;
  deliveryAttempt?: number;
  [key: string]: unknown;
}

interface GoogleChatPubSubMessage {
  attributes: GoogleChatCloudEventAttributes;
  data: string;
  messageId: string;
  publishTime?: string;
  orderingKey?: string;
  [key: string]: unknown;
}

interface GoogleChatCloudEventAttributes {
  'ce-datacontenttype': 'application/json';
  'ce-id': string;
  'ce-source': string;
  'ce-specversion': '1.0';
  'ce-subject': string;
  'ce-type': GoogleChatWorkspaceEventType;
  'ce-time'?: string;
  [key: string]: string | undefined;
}
```

```
type GoogleChatWorkspaceEventType =
  | 'google.workspace.chat.message.v1.created'
  | 'google.workspace.chat.message.v1.updated'
  | 'google.workspace.chat.message.v1.deleted'
  | 'google.workspace.chat.message.v1.batchCreated'
  | 'google.workspace.chat.message.v1.batchUpdated'
  | 'google.workspace.chat.message.v1.batchDeleted'
  | 'google.workspace.chat.membership.v1.created'
  | 'google.workspace.chat.membership.v1.updated'
  | 'google.workspace.chat.membership.v1.deleted'
  | 'google.workspace.chat.membership.v1.batchCreated'
  | 'google.workspace.chat.membership.v1.batchUpdated'
  | 'google.workspace.chat.membership.v1.batchDeleted'
  | 'google.workspace.chat.reaction.v1.created'
  | 'google.workspace.chat.reaction.v1.deleted'
  | 'google.workspace.chat.reaction.v1.batchCreated'
  | 'google.workspace.chat.reaction.v1.batchDeleted'
  | 'google.workspace.chat.space.v1.updated'
  | 'google.workspace.chat.space.v1.deleted'
  | 'google.workspace.chat.space.v1.batchUpdated'
  | 'google.workspace.events.subscription.v1.suspended'
  | 'google.workspace.events.subscription.v1.expirationReminder'
  | 'google.workspace.events.subscription.v1.expired'
  | (string & {});
```

`message.data` remains the provider’s base64-encoded JSON string; the channel
validates it but does not replace it with a decoded or normalized event.

## `GoogleChatChannel` [\#](https://flueframework.com/docs/api/google-chat-channel/\#googlechatchannel)

```
interface ChannelRoute<E extends Env = Env> {
  readonly method: string;
  readonly path: string;
  readonly handler: Handler<E>;
}

interface GoogleChatChannel<E extends Env = Env> {
  readonly routes: readonly ChannelRoute<E>[];
  conversationKey(ref: GoogleChatConversationRef): string;
  parseConversationKey(id: string): GoogleChatConversationRef;
}
```

`interactions` publishes exactly `POST /interactions`; `workspaceEvents`
publishes exactly `POST /events`. `routes` contains only configured surfaces. In
`channels/google-chat.ts`, these become
`POST /channels/google-chat/interactions` and
`POST /channels/google-chat/events`, relative to the `flue()` mount.

## Conversation identity [\#](https://flueframework.com/docs/api/google-chat-channel/\#conversation-identity)

```
interface GoogleChatConversationRef {
  space: string;
  thread?: string;
  spaceType?: GoogleChatSpaceType;
}
```

`space` must use `spaces/<id>`. `thread`, when present, must use
`spaces/<id>/threads/<thread-id>` and belong to the same space. Canonical keys
encode only `space` and `thread`; `spaceType` is descriptive and does not affect
the key. Keys are identifiers, not authorization capabilities.

`conversationKey()` throws `InvalidGoogleChatInputError` for an invalid reference.
`parseConversationKey()` accepts only canonical keys produced by
`conversationKey()` and throws `InvalidGoogleChatConversationKeyError` otherwise.

## Errors [\#](https://flueframework.com/docs/api/google-chat-channel/\#errors)

```
class InvalidGoogleChatInputError extends TypeError {
  readonly field: string;
}

class InvalidGoogleChatConversationKeyError extends TypeError {}
```

`InvalidGoogleChatInputError` reports invalid channel options and conversation
references through `field`. An invalid `bodyLimit` throws `TypeError`.

## Docs Navigation

Current page: [Google Chat Channel API](https://flueframework.com/docs/api/google-chat-channel/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
