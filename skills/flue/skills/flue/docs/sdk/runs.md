> Source: https://flueframework.com/docs/sdk/runs

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# client.runs


Last updated Jun 20, 2026 <a href="/docs/sdk/runs/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


Run APIs inspect workflow runs only. They require the owning workflow to export `runs` middleware that authorizes the request; otherwise the server returns the same `404` as for an unknown run. Direct agent prompts and dispatched agent inputs are not runs.

## `client.runs.get(...)`

``` astro-code
get(runId: string): Promise<RunRecord>;
```

Retrieves one workflow-run record via `GET /runs/:runId?meta`. The owning workflow’s `runs` middleware authorizes the request.

## `client.runs.events(...)`

``` astro-code
events(runId: string, options?: RunEventsOptions): Promise<FlueEvent[]>;
```

Retrieves events from a workflow run as an array. This is a Durable Streams catch-up read with no live tailing. Omit `offset` for full history, provide an offset to resume strictly after that point, or pass `tail` to limit a full-history read to the most recent events.

### `RunEventsOptions`

``` astro-code
type RunEventsOptions = Omit<FlueStreamOptions, 'live'>;
```

The same options as [`FlueStreamOptions`](#fluestreamoptions) minus `live`, which `events()` never uses.

## `client.runs.stream(...)`

``` astro-code
stream(runId: string, options?: FlueStreamOptions): FlueEventStream<FlueEvent>;
```

Streams workflow-run events via the [Durable Streams](https://durablestreams.com) protocol. See [Streaming Protocol](/docs/api/streaming-protocol/) for the raw HTTP contract. Returns an async iterable of typed `FlueEvent` objects. When `live` is enabled, the stream tails the run until `run_end`, cancellation, or disconnection. Interrupted streams resume automatically from the last received offset.

``` astro-code
const run = await client.workflows.invoke('summarize', {
  input: { text: 'Hello' },
});

for await (const event of client.runs.stream(run.runId, { live: true })) {
  console.log(event.type);
  if (event.type === 'run_end') break;
}
```

### `FlueStreamOptions`

| Option           | Type                            | Default | Description                                                                                                         |
|------------------|---------------------------------|---------|---------------------------------------------------------------------------------------------------------------------|
| `offset`         | `string`                        | `"-1"`  | Starting offset. `"-1"` for full history, `"now"` for future events only, or an opaque offset from a previous read. |
| `tail`           | `number`                        | —       | With `offset: "-1"`, start far enough back to read at most the latest N events. Must be an integer of at least 1.   |
| `live`           | `boolean | 'sse' | 'long-poll'` | `true`  | Enable live tailing. `true` uses long-poll; pass `'sse'` explicitly for SSE.                                        |
| `signal`         | `AbortSignal`                   | —       | Stop consuming events when aborted.                                                                                 |
| `backoffOptions` | `BackoffOptions`                | —       | Configure reconnect retry behavior.                                                                                 |

`tail` is available anywhere these options are accepted, including `client.runs.events()`. It only modifies the `"-1"` start; it has no effect with `"now"` or a concrete resume offset. There is no upper cap.

### `BackoffOptions`

`BackoffOptions` is exported by `@durable-streams/client` and passed through by Flue for reconnect behavior. Most callers can use the defaults.

### `FlueEventStream<T>`

An async iterable that yields typed events. Use `for await` to consume events. Call `cancel()` to stop the stream explicitly.

``` astro-code
interface FlueEventStream<T> extends AsyncIterable<T> {
  cancel(reason?: unknown): void;
  readonly offset: string;
}
```

`offset` is a resume checkpoint (the server’s `Stream-Next-Offset`). It is batch-granular: it advances to a batch’s next-offset only once every event in that batch has been delivered. Resuming from a checkpointed `offset` never skips undelivered events — at worst it re-delivers events of the batch that was in flight when the checkpoint was taken (at-least-once). An event’s `eventIndex` identifies and orders it within its runtime context; it is not a stream offset.


## Docs Navigation

Current page: [client.runs](/docs/sdk/runs/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


