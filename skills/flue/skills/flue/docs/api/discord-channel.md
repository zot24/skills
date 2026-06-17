<!-- Source: https://flueframework.com/docs/api/discord-channel -->

Import from `@flue/discord`.

## `createDiscordChannel()` [\#](https://flueframework.com/docs/api/discord-channel/\#creatediscordchannel)

```
function createDiscordChannel<E extends Env = Env>(
  options: DiscordChannelOptions<E>,
): DiscordChannel<E>;
```

Creates one stateless Discord HTTP interactions channel.

## `DiscordChannelOptions` [\#](https://flueframework.com/docs/api/discord-channel/\#discordchanneloptions)

```
interface DiscordChannelOptions<E extends Env = Env> {
  publicKey: string;
  bodyLimit?: number;
  interactions(input: { c: Context<E>; interaction: APIInteraction }): DiscordHandlerResult;
}
```

| Field | Description |
| --- | --- |
| `publicKey` | 32-byte application public key as 64 hexadecimal characters. |
| `bodyLimit` | Maximum request body in bytes. Defaults to 1 MiB. |
| `interactions` | Receives each authenticated non-PING Discord interaction. |

The package verifies Ed25519 signatures before parsing. The application public
key cryptographically binds authenticated requests to its Discord application,
so no separate application-id option is required.

## Interaction types [\#](https://flueframework.com/docs/api/discord-channel/\#interaction-types)

`APIInteraction` and `APIInteractionResponse` are re-exported from
`discord-api-types/v10`. Callbacks receive the parsed provider object with its
field names, nesting, and numeric discriminants unchanged.

PING interactions are handled internally and return PONG without invoking the
callback. The callback uses the current provider union for strong narrowing.
Authenticated future numeric types are still forwarded at runtime, so an
exhaustive branch must tolerate an unfamiliar numeric value after a Discord API
change.

`interaction.token` is a short-lived provider capability. Keep it out of model
context, dispatched input, logs, and durable history.

## Handler results [\#](https://flueframework.com/docs/api/discord-channel/\#handler-results)

```
type DiscordHandlerResult =
  | APIInteractionResponse
  | Response
  | Promise<APIInteractionResponse | Response>;
```

Discord interactions require a provider response. Return a provider-native
interaction response or an ordinary Hono or Fetch `Response`. Thrown errors
flow through normal Hono error handling.

Discord requires an initial response within three seconds. The package does not
race or cancel application handlers; applications must admit durable work and
respond within that provider deadline.

## `DiscordChannel` [\#](https://flueframework.com/docs/api/discord-channel/\#discordchannel)

```
interface DiscordChannel<E extends Env = Env> {
  readonly routes: readonly ChannelRoute<E>[];
  conversationKey(ref: DiscordDestinationRef): string;
  parseConversationKey(id: string): DiscordDestinationRef;
}
```

`routes` contains one `POST /interactions` declaration. A file named
`channels/discord.ts` is served at `/channels/discord/interactions` relative to
the `flue()` mount.

## `DiscordDestinationRef` [\#](https://flueframework.com/docs/api/discord-channel/\#discorddestinationref)

```
type DiscordDestinationRef =
  | {
      type: 'guild';
      guildId: string;
      channelId: string;
    }
  | {
      type: 'dm';
      channelId: string;
    }
  | {
      type: 'private';
      channelId: string;
    };
```

Applications derive destination references from native interaction fields when
a durable destination exists. Conversation keys are canonical identifiers, not
authorization capabilities.

## Errors [\#](https://flueframework.com/docs/api/discord-channel/\#errors)

- `InvalidDiscordConversationKeyError`
- `InvalidDiscordInputError`, with structured `field`

The package does not invent a timestamp freshness window or deduplicate
interaction ids.

See [Discord setup](https://flueframework.com/docs/ecosystem/channels/discord/) for composition with
`@discordjs/rest` and application-owned tools.

## Docs Navigation

Current page: [Discord Channel API](https://flueframework.com/docs/api/discord-channel/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
