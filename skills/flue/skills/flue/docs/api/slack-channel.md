<!-- Source: https://flueframework.com/docs/api/slack-channel -->

Import from `@flue/slack`.

## `createSlackChannel()` [\#](https://flueframework.com/docs/api/slack-channel/\#createslackchannel)

```
function createSlackChannel<E extends Env = Env>(options: SlackChannelOptions<E>): SlackChannel<E>;
```

Creates one stateless Slack channel. At least one handler is required.

## `SlackChannelOptions` [\#](https://flueframework.com/docs/api/slack-channel/\#slackchanneloptions)

```
interface SlackChannelOptions<E extends Env = Env> {
  signingSecret: string;
  bodyLimit?: number;
  events?(input: { c: Context<E>; payload: SlackEventsApiPayload }): SlackHandlerResult;
  interactions?(input: { c: Context<E>; payload: SlackInteractionPayload }): SlackHandlerResult;
  commands?(input: { c: Context<E>; payload: SlackSlashCommandPayload }): SlackHandlerResult;
}
```

| Field | Description |
| --- | --- |
| `signingSecret` | Secret used to verify Slack request signatures. |
| `bodyLimit` | Maximum request body in bytes. Defaults to 1 MiB. |
| `events` | Events API handler. Omission removes `POST /events`. |
| `interactions` | Interactivity handler. Omission removes `POST /interactions`. |
| `commands` | Slash-command handler. Omission removes `POST /commands`. |

URL verification is handled internally. Other authenticated deliveries reach
the configured handler with their provider identity intact. Workspace and
enterprise authorization is application policy.

## Events API types [\#](https://flueframework.com/docs/api/slack-channel/\#events-api-types)

```
type SlackEventsApiPayload = SlackEventCallbackPayload | SlackAppRateLimitedPayload;

interface SlackEventCallbackPayload {
  token: string;
  team_id: string;
  enterprise_id?: string | null;
  context_team_id?: string;
  context_enterprise_id?: string | null;
  api_app_id: string;
  event: SlackEvent;
  type: 'event_callback';
  event_id: string;
  event_time: number;
  event_context?: string;
  is_ext_shared_channel?: boolean;
  authorizations?: SlackAuthorization[];
}
```

`SlackEvent` is re-exported from the official `@slack/types` package. Use
`payload.type` to narrow the outer delivery and `payload.event.type` or
`payload.event.subtype` to narrow the provider event. Retry headers remain
available through `c.req.header(...)`.

## Interaction types [\#](https://flueframework.com/docs/api/slack-channel/\#interaction-types)

```
type SlackInteractionPayload =
  | SlackBlockActionsPayload
  | SlackViewSubmissionPayload
  | SlackViewClosedPayload
  | SlackShortcutPayload
  | SlackMessageActionPayload
  | SlackBlockSuggestionPayload;
```

These local types preserve Slack’s current HTTP interaction field names and
nesting. Authenticated future and legacy interaction types are forwarded at
runtime even when the installed type version does not include their
discriminant. Applications using a legacy surface can supply a local
provider-shaped type.

## `SlackSlashCommandPayload` [\#](https://flueframework.com/docs/api/slack-channel/\#slackslashcommandpayload)

Provider-native URL-encoded slash-command fields, including:

```
interface SlackSlashCommandPayload {
  command: string;
  text: string;
  response_url: string;
  trigger_id: string;
  user_id: string;
  team_id: string;
  channel_id: string;
  api_app_id: string;
  user_name?: string;
  team_domain?: string;
  channel_name?: string;
  enterprise_id?: string;
  enterprise_name?: string;
  is_enterprise_install?: string;
  [key: string]: unknown;
}
```

## Handler results [\#](https://flueframework.com/docs/api/slack-channel/\#handler-results)

```
type SlackHandlerResult = void | JsonValue | Response | Promise<void | JsonValue | Response>;
```

Returning nothing produces an empty `200`. JSON-compatible values become JSON
Thrown errors flow through normal Hono error handling.

## `SlackChannel` [\#](https://flueframework.com/docs/api/slack-channel/\#slackchannel)

```
interface SlackChannel<E extends Env = Env> {
  readonly routes: readonly ChannelRoute<E>[];
  conversationKey(ref: SlackThreadRef): string;
  parseConversationKey(id: string): SlackThreadRef;
}

interface SlackThreadRef {
  teamId: string;
  channelId: string;
  threadTs: string;
}
```

Configured routes are relative to the discovered channel namespace. For
`channels/slack.ts`, they are served beneath `/channels/slack` relative to the
`flue()` mount.

Conversation keys are canonical identifiers, not authorization capabilities.

## Errors [\#](https://flueframework.com/docs/api/slack-channel/\#errors)

- `InvalidSlackConversationKeyError`
- `InvalidSlackInputError`, with structured `field`

The channel does not deduplicate Events API retries. See
[Slack](https://flueframework.com/docs/ecosystem/channels/slack/) for provider setup and composition
with the Slack Web API.

## Docs Navigation

Current page: [Slack Channel API](https://flueframework.com/docs/api/slack-channel/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
