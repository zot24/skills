> Source: https://flueframework.com/docs/sdk/agents



# client.agents


AI-generated, awaiting review <a href="/docs/sdk/agents/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


Direct agent APIs interact with persistent agent instances by agent name and instance id, addressing that instance’s default conversation. Direct agent interactions do not create workflow runs and do not emit `runId`.

## `client.agents.prompt(...)`

``` astro-code
prompt(name: string, id: string, options: AgentPromptOptions): Promise<AgentPromptResult>;
```

Sends one prompt to a persistent agent instance and waits for the terminal result. This uses `POST /agents/:name/:id?wait=result`.

The prompt is a durable submission. If the request disconnects before settlement, recovery continues in the background and the result remains available from the agent conversation.

### `AgentPromptOptions`

| Field | Type | Description |
|----|----|----|
| `message` | `string` | Prompt sent to the agent instance. |
| `images` | `AgentPromptImage[]` | Optional image attachments. Requires a vision-capable model. |
| `signal` | `AbortSignal` | Cancel the in-flight HTTP request. |

### `AgentPromptImage`

``` astro-code
interface AgentPromptImage {
  type: 'image';
  data: string;
  mimeType: string;
}
```

`data` is the base64-encoded image content and `mimeType` its media type, such as `image/png`. The server rejects images whose `data` exceeds 14 MiB of base64 characters.

### `AgentPromptResult`

``` astro-code
interface AgentPromptResult extends AgentSendResult {
  result: AgentPromptResponse;
}
```

### `AgentPromptResponse`

``` astro-code
interface AgentPromptResponse {
  text: string;
  usage: {
    input: number;
    output: number;
    cacheRead: number;
    cacheWrite: number;
    totalTokens: number;
    cost: {
      input: number;
      output: number;
      cacheRead: number;
      cacheWrite: number;
      total: number;
    };
  };
  model: { provider: string; id: string };
}
```

| Field | Type | Description |
|----|----|----|
| `text` | `string` | Assistant text returned by the prompt. |
| `usage` | object | Aggregated token and cost usage for model work performed by the prompt. |
| `model` | object | Model selected for the prompt’s primary turn. |

## `client.agents.send(...)`

``` astro-code
send(name: string, id: string, options: AgentPromptOptions): Promise<AgentSendResult>;
```

Starts one prompt without waiting for completion. This uses the default `POST /agents/:name/:id` response, which returns `202`. Pass the result to `agents.wait()` to await settlement, or observe the conversation with `agents.observe()`.

### `AgentSendResult`

``` astro-code
interface AgentSendResult {
  streamUrl: string;
  offset: string;
  submissionId: string;
}
```

Both `prompt()` and `send()` return the required `submissionId`, which identifies the durable direct submission.

## `client.agents.abort(...)`

``` astro-code
abort(name: string, id: string, options?: { signal?: AbortSignal }): Promise<AgentAbortResult>;
```

Aborts all in-flight and queued durable work for an agent instance — the submission it is currently running and anything queued behind it. This uses `POST /agents/:name/:id/abort`.

Abort records a durable intent and returns once it is recorded; settlement happens asynchronously. The aborted work settles to a distinct **aborted** terminal outcome rather than a failure: a `submission_aborted` entry is written to the conversation (visible via `observe()`/`history()`), and a pending `wait()`/`prompt()` rejects with `SubmissionAbortedError` (`type: 'submission_aborted'`). Work that has already completed is not affected — an abort that loses the race to a finished response settles as completed.

### `AgentAbortResult`

``` astro-code
interface AgentAbortResult {
  aborted: boolean;
}
```

`aborted` is `true` when there was in-flight or queued work that is now being aborted, and `false` when the instance was idle.

## `client.agents.observe(...)`

``` astro-code
observe(name: string, id: string, options?: AgentConversationObserveOptions): AgentConversationObservation;
```

Observes one materialized conversation across initial history catch-up, live updates, reconnects, and canonical resets. This is the default API for applications that retain conversation state.

``` astro-code
const conversation = client.agents.observe('support', 'ticket-42', {
  live: 'sse',
});

const unsubscribe = conversation.subscribe(() => {
  const snapshot = conversation.getSnapshot();
  render(snapshot.conversation?.messages ?? []);
});
```

`getSnapshot()` returns the materialized `FlueConversationState`, its safe resume offset, the current phase, and any transport error. Call `refresh()` after creating an agent instance that was previously absent, and `close()` when observation is no longer needed.

The observed conversation is a `FlueConversationState` of `FlueConversationMessage` values. Each message has clean, render-ready parts (`text`, `reasoning`, `dynamic-tool`, `file`); streaming assembly is handled internally, so a `text` part is always `{ type, text, state }`. Structured tool output appears on the `dynamic-tool` part’s `output`.

## `client.agents.history(...)`

``` astro-code
history(name: string, id: string, options?: FlueConversationHistoryOptions): Promise<FlueConversationSnapshot>;
```

Returns one materialized conversation snapshot. The snapshot includes its opaque stream `offset`; historical token deltas are already reduced into complete message parts. Use `observe()` for live state — it performs the snapshot-to-live handoff and reduction for you. The snapshot is materialized by the API on demand and is not a persisted replay cache.


## Docs Navigation

Current page: [client.agents](/docs/sdk/agents/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


