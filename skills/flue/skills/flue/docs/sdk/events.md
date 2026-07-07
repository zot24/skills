> Source: https://flueframework.com/docs/sdk/events

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Events and records


Last updated Jun 15, 2026 <a href="/docs/sdk/events/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


## `FlueEvent`

`FlueEvent` is the observable runtime-event union. It includes run lifecycle, agent lifecycle, model turn, message, tool, task, compaction, operation, log, structured `data`, idle, and recovery-settlement (`submission_settled`) events. Events are durably stored in an event stream and can be replayed from any offset via the Durable Streams protocol. Dispatched activity uses `dispatchId` as its delivery identity rather than becoming a workflow run.

Every delivered event carries the durable event-format version `v: 3`, a per-context `eventIndex`, and a `timestamp`. SDK readers reject v1, v2, missing, and unknown versions with `UnsupportedFlueEventVersionError`; they do not normalize historical formats. The SDK union mirrors the wire format: `turn_request` is in-process only on the server (`observe()` subscribers and exporters) and never appears on streams the SDK reads.

A `data` event carries a template-safe `name`, optional stable `id`, and JSON-compatible `data` payload. It is append-only on the wire; UI consumers can reconcile repeated `(name, id)` events last-writer-wins, while events without ids remain distinct.

`message_start` and `message_end` bound both user and assistant messages. Text and thinking deltas are best-effort live progress; for a completed assistant message, `message_end` is authoritative. A reader that attaches after generation starts may miss earlier partial output until it arrives. Internal interrupted-turn recovery uses separate durable state and is unaffected by this public stream behavior.

## `AttachedAgentEvent`

`AttachedAgentEvent` is emitted by direct interactions with persistent agent instances. It excludes workflow-run lifecycle events, requires `instanceId`, and does not include `runId`.

## Run types

| Type        | Description                                                                                                      |
|-------------|------------------------------------------------------------------------------------------------------------------|
| `RunRecord` | Persisted workflow-run record, including the workflow name, status, timestamps, input, result, and error fields. |
| `RunStatus` | Workflow-run status: `'active'`, `'completed'`, or `'errored'`.                                                  |

## Normalized model-turn types

`turn` events keep correlation, duration, purpose, and error status at top level. Their required `request` is a `ModelRequestInfo` summary; their required `response` is a `ModelResponse`. Output, usage, finish reason, and normalized errors exist only under `response`.

| Type                  | Description                                                               |
|-----------------------|---------------------------------------------------------------------------|
| `ModelRequestInput`   | Model-visible system prompt, messages, and tools.                         |
| `ModelRequestInfo`    | Provider identity, requested model, API, and request settings.            |
| `ModelRequest`        | `ModelRequestInfo` plus the full request `input`; used by `turn_request`. |
| `ModelResponse`       | Response identity, output, usage, finish reason, and normalized error.    |
| `LlmAssistantMessage` | Normalized assistant message.                                             |
| `LlmTextContent`      | Text content.                                                             |
| `LlmThinkingContent`  | Reasoning content.                                                        |
| `LlmToolCall`         | Tool call content.                                                        |
| `LlmTurnPurpose`      | Model-turn purpose: `'agent'`, `'compaction'`, or `'compaction_prefix'`.  |

`request.providerId` is the provider-registration key used in model specifiers. `request.providerName` is the semantic provider identity and may differ for gateways or custom registrations.


## Docs Navigation

Current page: [Events and records](/docs/sdk/events/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


