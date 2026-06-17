<!-- Source: https://flueframework.com/docs/api/teams-channel -->

Import from `@flue/teams`.

## `createTeamsChannel()` [\#](https://flueframework.com/docs/api/teams-channel/\#createteamschannel)

```
function createTeamsChannel<E extends Env = Env>(options: TeamsChannelOptions<E>): TeamsChannel<E>;
```

Creates one stateless, fixed-application, fixed-tenant Teams activity channel.
The callback runs only after Bot Connector token, channel, service URL, and
host-tenant verification.

## `TeamsChannelOptions` [\#](https://flueframework.com/docs/api/teams-channel/\#teamschanneloptions)

```
interface TeamsChannelOptions<E extends Env = Env> {
  appId: string;
  tenantId: string;
  openIdMetadataUrl?: string;
  tokenIssuer?: string;
  fetch?: typeof globalThis.fetch;
  bodyLimit?: number;
  activities(input: { c: Context<E>; activity: Activity }): TeamsHandlerResult;
}
```

| Field | Description |
| --- | --- |
| `appId` | Expected Bot Connector JWT audience. |
| `tenantId` | Expected tenant in the authenticated activity. |
| `openIdMetadataUrl` | OpenID metadata URL. Defaults to Microsoft’s public cloud. |
| `tokenIssuer` | Expected issuer. Defaults to `https://api.botframework.com`. |
| `fetch` | Fetch used for OpenID metadata and JWKS discovery. |
| `bodyLimit` | Maximum request body. Default: 1 MiB. |
| `activities` | Receives every authenticated and structurally valid activity. |

The `activity` is the provider-native Bot Framework `Activity`, re-exported from
`botframework-schema`. It is verified but otherwise unmodified.

```
type TeamsHandlerResult = void | JsonValue | Response | Promise<void | JsonValue | Response>;
```

Returning nothing produces an empty `200`. A JSON-compatible value is serialized
with `Response.json` and returned as a JSON response. An ordinary Hono or Fetch
`Response` passes through unchanged.

`invoke` activities expect a JSON acknowledgement body in the response (for
example, `adaptiveCard/action` responses), so return the appropriate value or
`Response`. The Bot Connector retries on any non-2xx status, so reserve error
statuses for deliveries you want redelivered.

## `TeamsChannel` [\#](https://flueframework.com/docs/api/teams-channel/\#teamschannel)

```
interface TeamsChannel<E extends Env = Env> {
  readonly routes: readonly ChannelRoute<E>[];
  destination(activity: Activity): TeamsConversationRef;
  conversationKey(ref: TeamsConversationRef): string;
  parseConversationKey(id: string): TeamsConversationRef;
}
```

`routes` contains one `POST /activities` declaration. A file named
`channels/teams.ts` is served at `/channels/teams/activities` relative to the
`flue()` mount.

`destination(activity)` derives the canonical routing identity from a verified
activity. Activities delivered to the `activities` callback always derive a
destination; it throws `InvalidTeamsInputError` for an activity that lacks the
minimal structure needed to address a reply.

Conversation keys are canonical identifiers, not authorization capabilities.

## Activities [\#](https://flueframework.com/docs/api/teams-channel/\#activities)

The callback receives the provider-native Bot Framework `Activity`, re-exported
from the official `botframework-schema` package:

```
import type {
  Activity,
  ChannelAccount,
  ConversationAccount,
  Entity,
  Attachment,
  Mention,
  MessageReaction,
} from '@flue/teams';
```

The activity keeps Microsoft’s documented `type` values and field names. Switch
on the native `activity.type` (`message`, `conversationUpdate`, `invoke`,
`messageReaction`, `installationUpdate`, and others) and read native fields such
as `activity.text`, `activity.from`, `activity.recipient`, `activity.id`,
`activity.entities`, `activity.reactionsAdded`, and `activity.membersAdded`. See
Microsoft’s [Activity schema](https://learn.microsoft.com/azure/bot-service/rest-api/bot-framework-rest-connector-activities)
for the full field inventory.

The channel does not reshape, rename, or normalize the payload; it derives only
the routing identity below.

## Identity [\#](https://flueframework.com/docs/api/teams-channel/\#identity)

```
interface TeamsConversationRef {
  tenantId: string;
  serviceUrl: string;
  conversationId: string;
  scope: 'personal' | 'groupChat' | 'channel' | 'unknown';
  botId: string;
  threadId?: string;
  teamId?: string;
  channelId?: string;
}
```

For channel activities, `threadId` is the provider `replyToId` or the current
activity id for a root message. The verified `serviceUrl` is retained so
stateless applications can address the correct Bot Connector endpoint.

Derive a `TeamsConversationRef` from a verified activity with
`channel.destination(activity)`. It is not a callback argument; call the helper
inside the `activities` callback when you need to address a reply.

## Verification [\#](https://flueframework.com/docs/api/teams-channel/\#verification)

The package retrieves the configured OpenID metadata and endorsed JWKS keys,
caches them with bounded response cache metadata, and refreshes once when a
token references an unknown key id.

Requests fail before the callback when the bearer token, signature, issuer,
audience, expiration, `msteams` endorsement, exact service URL, channel id, or
tenant identity is invalid. Discovery failures return `503`.

## Errors [\#](https://flueframework.com/docs/api/teams-channel/\#errors)

- `InvalidTeamsConversationKeyError`
- `InvalidTeamsInputError`, with structured `field`

See [Microsoft Teams setup](https://flueframework.com/docs/ecosystem/channels/teams/) for the project-owned
Fetch client and application tool composition.

## Docs Navigation

Current page: [Microsoft Teams Channel API](https://flueframework.com/docs/api/teams-channel/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
