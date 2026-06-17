<!-- Source: https://flueframework.com/docs/sdk/events -->

## `FlueEvent` [\#](https://flueframework.com/docs/sdk/events/\#flueevent)

`FlueEvent` is the observable runtime-event union. It includes run lifecycle, agent lifecycle, model turn, message, tool, task, compaction, operation, log, idle, and recovery-settlement (`submission_settled`) events. Events are durably stored in an event stream and can be replayed from any offset via the Durable Streams protocol. Dispatched activity uses `dispatchId` as its delivery identity rather than becoming a workflow run.

Every delivered event carries the durable event-format version `v: 1`, a per-context `eventIndex`, and a `timestamp`. The SDK union mirrors the wire format: `turn_request` is in-process only on the server (`observe()` subscribers and exporters) and never appears on streams the SDK reads.

`message_start` and `message_end` bound both user and assistant messages. Text and thinking deltas are best-effort live progress; for a completed assistant message, `message_end` is authoritative. A reader that attaches after generation starts may miss earlier partial output until it arrives. Internal interrupted-turn recovery uses separate durable state and is unaffected by this public stream behavior.

## `AttachedAgentEvent` [\#](https://flueframework.com/docs/sdk/events/\#attachedagentevent)

`AttachedAgentEvent` is emitted by direct interactions with persistent agent instances. It excludes workflow-run lifecycle events, requires `instanceId`, and does not include `runId`.

## Run types [\#](https://flueframework.com/docs/sdk/events/\#run-types)

| Type | Description |
| --- | --- |
| `RunRecord` | Persisted workflow-run record, including the workflow name, status, timestamps, payload, result, and error fields. |
| `RunStatus` | Workflow-run status: `'active'`, `'completed'`, or `'errored'`. |

## Normalized model-turn types [\#](https://flueframework.com/docs/sdk/events/\#normalized-model-turn-types)

`turn` events expose normalized model data through these exported types:

| Type | Description |
| --- | --- |
| `LlmAssistantMessage` | Normalized assistant message. |
| `LlmTextContent` | Text content. |
| `LlmThinkingContent` | Reasoning content. |
| `LlmToolCall` | Tool call content. |
| `LlmTurnPurpose` | Model-turn purpose: `'agent'`, `'compaction'`, or `'compaction_prefix'`. |

## Docs Navigation

Current page: [Events and records](https://flueframework.com/docs/sdk/events/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
