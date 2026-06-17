<!-- Source: https://flueframework.com/docs/sdk/runs -->

Run APIs inspect workflow runs only. Direct agent prompts and dispatched agent inputs are not runs.

## `client.runs.get(...)` [\#](https://flueframework.com/docs/sdk/runs/\#clientrunsget)

```
get(runId: string): Promise<RunRecord>;
```

Retrieves one workflow-run record via the public `GET /runs/:runId?meta` view. The record is guarded by the same workflow `route` middleware as the run’s event stream.

## `client.runs.events(...)` [\#](https://flueframework.com/docs/sdk/runs/\#clientrunsevents)

```
events(runId: string, options?: RunEventsOptions): Promise<FlueEvent[]>;
```

Retrieves events from a workflow run as an array. This is a Durable Streams catch-up read with no live tailing. Omit `offset` for full history, provide an offset to resume strictly after that point, or pass `tail` to limit a full-history read to the most recent events.

### `RunEventsOptions` [\#](https://flueframework.com/docs/sdk/runs/\#runeventsoptions)

```
type RunEventsOptions = Omit<FlueStreamOptions, 'live'>;
```

The same options as [`FlueStreamOptions`](https://flueframework.com/docs/sdk/runs/#fluestreamoptions) minus `live`, which `events()` never uses.

## `client.runs.stream(...)` [\#](https://flueframework.com/docs/sdk/runs/\#clientrunsstream)

```
stream(runId: string, options?: FlueStreamOptions): FlueEventStream<FlueEvent>;
```

Streams workflow-run events via the [Durable Streams](https://durablestreams.com/) protocol. See [Streaming Protocol](https://flueframework.com/docs/api/streaming-protocol/) for the raw HTTP contract. Returns an async iterable of typed `FlueEvent` objects. When `live` is enabled, the stream tails the run until `run_end`, cancellation, or disconnection. Interrupted streams resume automatically from the last received offset.

```
const run = await client.workflows.invoke('summarize', {
  payload: { text: 'Hello' },
});

for await (const event of client.runs.stream(run.runId, { live: true })) {
  console.log(event.type);
  if (event.type === 'run_end') break;
}
```

### `FlueStreamOptions` [\#](https://flueframework.com/docs/sdk/runs/\#fluestreamoptions)

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `offset` | `string` | `"-1"` | Starting offset. `"-1"` for full history, `"now"` for future events only, or an opaque offset from a previous read. |
| `tail` | `number` | — | With `offset: "-1"`, start far enough back to read at most the latest N events. Must be an integer of at least 1. |
| `live` | `boolean | 'sse' | 'long-poll'` | `true` | Enable live tailing. `true` uses long-poll; pass `'sse'` explicitly for SSE. |
| `signal` | `AbortSignal` | — | Stop consuming events when aborted. |
| `backoffOptions` | `BackoffOptions` | — | Configure reconnect retry behavior. |

`tail` is available anywhere these options are accepted, including `client.runs.events()`. It only modifies the `"-1"` start; it has no effect with `"now"` or a concrete resume offset. There is no upper cap.

### `BackoffOptions` [\#](https://flueframework.com/docs/sdk/runs/\#backoffoptions)

`BackoffOptions` is exported by `@durable-streams/client` and passed through by Flue for reconnect behavior. Most callers can use the defaults.

### `FlueEventStream<T>` [\#](https://flueframework.com/docs/sdk/runs/\#flueeventstreamt)

An async iterable that yields typed events. Use `for await` to consume events. Call `cancel()` to stop the stream explicitly.

```
interface FlueEventStream<T> extends AsyncIterable<T> {
  cancel(reason?: unknown): void;
  readonly offset: string;
}
```

`offset` is a resume checkpoint (the server’s `Stream-Next-Offset`). It is batch-granular: it advances to a batch’s next-offset only once every event in that batch has been delivered. Resuming from a checkpointed `offset` never skips undelivered events — at worst it re-delivers events of the batch that was in flight when the checkpoint was taken (at-least-once). For per-event checkpoints, use the event’s `eventIndex` instead (on workflow-run streams it equals the stream sequence); `flue logs --format ndjson` prints a per-event `offset` derived from it.

## Docs Navigation

Current page: [client.runs](https://flueframework.com/docs/sdk/runs/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
