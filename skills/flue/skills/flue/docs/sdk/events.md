> Source: https://flueframework.com/docs/sdk/events

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Events


Last updated Jul 21, 2026<a href="/docs/sdk/events/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


The Flue Agent SDK (`@flue/sdk`) delivers conversation data in two vocabularies, at two levels of abstraction:

- **Materialized conversation state** — [`FlueConversationState`](/docs/sdk/flue-client/#flueconversationstate) and [`FlueConversationSnapshot`](/docs/sdk/flue-client/#flueconversationsnapshot): complete, renderable conversations made of messages, parts, and settlements. This is what [`observe()`](/docs/sdk/flue-client/#observe) maintains and [`history()`](/docs/sdk/flue-client/#history) returns, and it is the level application code should consume.
- **Conversation stream chunks** — [`ConversationStreamChunk`](/docs/reference/streaming-protocol/#conversationstreamchunk): the incremental update protocol that `observe()` reduces into state and that [`wait()`](/docs/sdk/flue-client/#wait)’s `onEvent` callback exposes raw.

The runtime’s low-level activity event union ([`FlueEvent`](/docs/reference/events/)) is not part of the SDK: no `FlueClient` method delivers it. In-process consumers subscribe to it with `observe()` from `@flue/runtime`.

Each vocabulary is documented on the page that owns it, linked above and mapped export-by-export [below](#exported-types). This page adds only what the SDK itself owns: the [`FlueEventStream`](#flueeventstream) iteration surface and the [offset and redelivery semantics](#offsets-and-redelivery) an SDK consumer sees.

A minimal consumer reads messages and parts from an observation:

``` astro-code
import { createFlueClient } from '@flue/sdk';

const client = createFlueClient({ url: 'https://app.example.com/api/support/thread-42' });
const observation = client.observe();

observation.subscribe(() => {
  const { conversation } = observation.getSnapshot();
  for (const message of conversation?.messages ?? []) {
    if (message.display !== 'visible') continue;
    for (const part of message.parts) {
      if (part.type === 'text') renderText(message.id, part.text, part.state);
    }
  }
});
```

## Exported types

- `FlueConversationSnapshot`, `FlueConversationState`, `FlueConversationMessage`, `FlueConversationPart`, `FlueConversationSettlement` — the materialized conversation, documented field-by-field on [FlueClient](/docs/sdk/flue-client/#flueconversationsnapshot) with `history()` and `observe()`.
- `ConversationStreamChunk` — the `updates`-view chunk union, documented on the [Streaming Protocol reference](/docs/reference/streaming-protocol/#conversationstreamchunk). Delivered raw by `wait()`’s `onEvent`; not stable application API — application code should consume materialized state via `observe()` instead.
- `PromptUsage` — aggregated token and cost usage, carried by conversation settlements; the shape matches the runtime’s export of the same name (pinned by a wire-conformance type test).

## FlueEventStream

``` astro-code
interface FlueEventStream<T = ConversationStreamChunk> extends AsyncIterable<T> {
  cancel(reason?: unknown): void;
  readonly offset: string;
}
```

An async iterable of events backed by a Durable Streams connection, with automatic reconnection, offset-based replay, and live tailing. The SDK constructs these internally (`wait()` consumes a `FlueEventStream<ConversationStreamChunk>`); the type is exported so first-party presenters can type streams of their own. `for await...of` is the consumption interface; breaking out of the loop cleans up the underlying connection.

- `cancel(reason?)` — cancels the stream and aborts the underlying connection. Iteration then ends (`done: true`) rather than throwing.
- `offset` — the resume checkpoint. It advances per delivered batch: it moves to a batch’s next-offset only once every event in that batch has been yielded, so resuming from a checkpointed value never skips undelivered events — at worst it re-delivers the batch that was in flight when the checkpoint was taken (at-least-once).

Each streamed value is passed through a caller-supplied validator before it is yielded; a validator that throws is terminal for the stream (the connection is cancelled and subsequent `next()` calls rethrow). The SDK’s own streams validate against the materialized-conversation protocol (see `ConversationStreamError` in [SDK errors](/docs/sdk/errors/)).

### FlueStreamOptions

``` astro-code
interface FlueStreamOptions {
  offset?: string;
  live?: LiveMode;
  signal?: AbortSignal;
  backoffOptions?: BackoffOptions;
}
```

Options for one event-stream read. `LiveMode` and `BackoffOptions` are re-exported from `@durable-streams/client`.

- `offset` — starting offset. Defaults to `'-1'` (full history).
- `live` — live tailing mode: `boolean | 'long-poll' | 'sse'`. Defaults to `true` (long-poll). `false` reads to the current end and completes.
- `signal` — aborts the stream; iteration ends without throwing.
- `backoffOptions` — retry behavior for connection attempts (`initialDelay`, `maxDelay`, `multiplier`, and callbacks, per `@durable-streams/client`).

## Offsets and redelivery

Every conversation read is anchored to a durable-stream offset — an opaque string checkpoint. Offsets surface on [`FlueConversationSnapshot`](/docs/sdk/flue-client/#flueconversationsnapshot), [`AgentSendResult`](/docs/sdk/flue-client/#agentsendresult), [`AgentConversationObservationSnapshot`](/docs/sdk/flue-client/#agentconversationobservationsnapshot), and [`FlueEventStream`](#flueeventstream). Treat them as opaque: compare for equality if you must, never parse or arithmetic on them. Chunk `position` values are not offsets — they identify and order items but cannot be used as resume points. The wire-level offset format and coordination headers are specified in the [Streaming Protocol reference](/docs/reference/streaming-protocol/#offsets).

Delivery is **at-least-once**: when a connection drops mid-batch, the transport reconnects from the pre-batch offset and replays the batch in flight. The SDK’s consumers each absorb this:

- `observe()` dedupes by chunk `position` and rehydrates a fresh snapshot on reconnect rather than resuming incrementally; see [`observe()`](/docs/sdk/flue-client/#observe).
- `wait()` watches only for the terminal `submission-settled` chunk of its submission, which is idempotent under redelivery. Its `onEvent` callback, however, receives the raw stream: it can observe the same chunk more than once after a reconnect, and it receives every chunk of the conversation from the admission offset, not only chunks belonging to the awaited submission. Dedupe by `position` if the distinction matters; prefer `observe()` for maintained UI state.

Both live modes (`'long-poll'` and `'sse'`) carry the same chunks with the same guarantees; SSE trades connection lifetime for lower token-by-token latency.


## Docs Navigation

Current page: [Events](/docs/sdk/events/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


