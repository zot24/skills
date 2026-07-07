> Source: https://flueframework.com/docs/ecosystem/tooling/opentelemetry



# OpenTelemetry


AI-generated, awaiting review <a href="/docs/ecosystem/tooling/opentelemetry/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a> <a href="https://www.npmjs.com/package/@flue/opentelemetry" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/opentelemetry</a>


`@flue/opentelemetry` projects Flue’s live runtime observations into standard OpenTelemetry GenAI spans and metrics. It does not configure an SDK, exporter, sampling, credentials, or deployment-specific flushing.

The package implements the Development GenAI conventions pinned at commit `4c8addb53718b544134be47e256237026fe88875`. Its Flue-to-GenAI projection revision is `5` and its Flue extension revision is `3`; the GenAI semantic-convention revision and schema remain unchanged. Updating any revision requires an explicit compatibility review.

## Configure

Install the adapter and OpenTelemetry API alongside an SDK and exporter compatible with your deployment target:

``` astro-code
pnpm add @flue/opentelemetry @opentelemetry/api
```

Configure the SDK first, then register one instrumentation instance:

``` astro-code
import { createOpenTelemetryInstrumentation } from '@flue/opentelemetry';
import { instrument } from '@flue/runtime';

const instrumentation = createOpenTelemetryInstrumentation();
const disposeInstrumentation = instrument(instrumentation);
```

Pass configured tracer, meter, or structural Logger instances when the application owns them. Generated Node applications automatically dispose registrations created while evaluating `app.ts` after admissions and active work drain. Call `await disposeInstrumentation()` yourself only when registering outside that lifecycle, then flush or shut down the application-owned SDK/exporter separately.

## Trace model

| Flue activity          | OpenTelemetry representation            |
|------------------------|-----------------------------------------|
| Workflow invocation    | `invoke_workflow <name>`                |
| Prompt or skill        | `invoke_agent <agent>`                  |
| Delegated task         | one task-owned `invoke_agent <agent>`   |
| Provider inference     | `chat <requested-model>` client span    |
| GenAI tool execution   | `execute_tool <name>`                   |
| Caller shell execution | `flue.operation shell`                  |
| Context compaction     | `flue.compaction` with child chat spans |

Provider chat spans cover provider inference only. The projection reads canonical model telemetry directly: semantic `request.providerName` becomes `gen_ai.provider.name`, while `request.providerId` remains the Flue registration identity. It does not fall back to removed top-level event fields. Local tools are sibling spans under the agent invocation and correlate with model output through `gen_ai.tool.call.id`.

`gen_ai.conversation.id` identifies one persisted Flue session. It is not a workflow run, submission, dispatch, operation, trace, session name, or provider-affinity key. Flue correlation fields remain under documented `flue.*` attributes when no exact standard field exists.

## Protect content

Content is disabled by default. This excludes implemented model messages, reasoning, system instructions, tool definitions, descriptions, arguments/results, exception messages, and external-content paths. Workflow values are not currently exported even when capture is enabled.

Use one instrumentation-wide policy to enable and redact content:

``` astro-code
const instrumentation = createOpenTelemetryInstrumentation({
  content: {
    enabled: process.env.OTEL_GENAI_CAPTURE_CONTENT === 'true',
    transform(content) {
      return redactSecrets(content);
    },
  },
});
```

The `enabled` value is the global privacy ceiling. A detached converted value passes through `transform` once; returning `undefined` suppresses both destinations. Transforms are trusted application code; Flue does not validate their returned GenAI shape. Structural limits run afterward: `maxMessageParts` retains the first complete parts per input/output message and first top-level system instructions, and `maxToolDefinitions` retains the first definitions. Limit values must be finite nonnegative safe integers.

`externalContent` is a side-effect-only sink for system instructions and input/output messages. It receives a detached, structurally limited clone with a stable `contentType` scope regardless of span sampling or `inline`. Returns and mutations cannot alter inline content, failures only diagnose, and tool content is never delivered. Set `inline: false` to skip serialization while retaining this external delivery.

`maxAttributeBytes` measures the exact final UTF-8 inline string and does not limit external delivery. Object-shaped tool arguments/results use standard `gen_ai.tool.call.*` attributes; strings, arrays, primitives, and `null` use `flue.tool.call.arguments` or `flue.tool.call.result` under the same privacy and size policy. Tool descriptions and plain-text fallbacks remain raw strings. Bounded `flue.telemetry.content.*` attributes mark structural truncation and inline byte omission. The adapter does not invent flattened child keys beneath `gen_ai.*`.

## Metrics and Logs

The instrumentation emits client-operation, token-usage, workflow, agent-invocation, and tool-duration histograms. Metric dimensions exclude execution IDs; review your application-controlled workflow, agent, tool, provider, and model names for appropriate cardinality. Input token totals include cache-read and cache-creation input tokens.

Logs require explicit Logger injection. Failed inference operations emit the standard `gen_ai.client.operation.exception` event at WARN/13. Error type is always recorded; transformed exception messages are included only when content capture is enabled. Logger absence does not affect traces or metrics.

## Propagation and recovery

Flue validates and persists `traceparent` and optional `tracestate` at workflow and direct-agent admission. Baggage is not persisted. Durable direct-agent processing activates its extracted admission context, and execution interceptors activate owning spans around workflow, agent, model-stream, tool, and task work. `dispatch(...)` does not currently propagate trace context.

Workflow recovery restores the persisted admission carrier as the parent of a new recovery-handling span. The new span begins at `run_resume`; it does not reconstruct or backdate the interrupted span. Recovery does not replay provider or tool execution. Stored stream chunks create no chat spans or usage observations, and synthetic interrupted-tool repairs create no `execute_tool` spans.

## Streaming limitation

Pi does not expose authoritative raw provider stream-item timing. Flue therefore omits time-to-first-chunk and time-per-output-chunk metrics instead of deriving inaccurate values from semantic text/reasoning deltas or recovered chunks.

## Migrate from the observer API

Replace `createOpenTelemetryObserver()` with `createOpenTelemetryInstrumentation()`, register it with `instrument(...)` instead of `observe(...)`, and replace `exportContent` with the global `content` policy. The legacy custom model/tool content attributes are removed rather than emitted alongside the standard fields.

## Unsupported operations

Flue does not emit invented spans for agent creation, planning, embeddings, retrieval, memory operations, remote agent clients, or evaluations. These operations remain absent until Flue exposes a genuine corresponding boundary.

## Verify

Use an in-memory OpenTelemetry exporter in tests to verify hierarchy, names, kinds, status, attributes, metrics, and default content omission. Hosted backend rendering is backend-specific; standards-correct OTel output is the portable contract.


## Docs Navigation

Current page: [OpenTelemetry](/docs/ecosystem/tooling/opentelemetry/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


