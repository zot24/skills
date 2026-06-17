<!-- Source: https://flueframework.com/docs/ecosystem/tooling/opentelemetry -->

`@flue/opentelemetry` converts Flue’s live `observe(...)` event stream into OpenTelemetry traces. It creates semantic spans and events but does not configure an SDK, exporter, sampling, credentials, or shutdown behavior.

See [Observability](https://flueframework.com/docs/guide/observability/) to inspect workflow runs, understand the observer model, and compare integrations.

## Quickstart [\#](https://flueframework.com/docs/ecosystem/tooling/opentelemetry/\#quickstart)

Add [OpenTelemetry](https://opentelemetry.io/) tracing to an existing Flue project by installing the adapter and API alongside an SDK and exporter for your deployment target:

```
pnpm add @flue/opentelemetry @opentelemetry/api
```

## Overview [\#](https://flueframework.com/docs/ecosystem/tooling/opentelemetry/\#overview)

`@flue/opentelemetry` supplies an observer that converts Flue runtime events into OpenTelemetry spans. Register it once in your application entrypoint, after initializing an OpenTelemetry SDK and exporter:

```
import { createOpenTelemetryObserver } from '@flue/opentelemetry';
import { observe } from '@flue/runtime';

observe(createOpenTelemetryObserver());
```

The observer creates spans for workflow runs, finite agent operations, model turns, tools, delegated tasks, and compactions. It also attaches Flue logs to the nearest tracked span. The package does not choose or configure your OpenTelemetry SDK, exporter, sampling, credentials, or shutdown behavior.

## Configure [\#](https://flueframework.com/docs/ecosystem/tooling/opentelemetry/\#configure)

| Requirement | Purpose |
| --- | --- |
| OpenTelemetry SDK | **Required for tracing** — Provides tracing for the deployment runtime and must be configured before observer registration. |
| OpenTelemetry exporter | **Required for span delivery** — Delivers spans to the selected observability backend. |
| Sampling, credentials, and shutdown behavior | **Application-specific** — Controls collection, authenticates delivery when needed, and flushes pending spans. |

Configure the SDK before the observer registration shown above. The adapter uses `trace.getTracer('@flue/opentelemetry')` by default; pass `{ tracer }` when the application already owns a configured tracer.

## What the adapter traces [\#](https://flueframework.com/docs/ecosystem/tooling/opentelemetry/\#what-the-adapter-traces)

| Flue activity | OpenTelemetry representation |
| --- | --- |
| Workflow invocation | `flue.workflow <name>` span |
| Finite agent operation | `flue.operation <kind>` span |
| Model turn | `chat <model>` client span with GenAI attributes |
| Tool call | `flue.tool <name>` span |
| Delegated task | `flue.task <agent>` span |
| Context compaction | `flue.compaction` span |
| Flue log | `flue.log` event on the nearest tracked span |

Spans include applicable Flue correlation fields and event indexes. Model-turn spans record token usage and estimated cost as attributes; the package does not create native OpenTelemetry metrics. Operation and compaction usage values are roll-ups, so do not sum them with nested model-turn values. Nested durations can also overlap.

The observer tracks open spans in local memory. Each process or Cloudflare isolate exports only the activity it handles, and live event indexes do not prove that workflow history persistence succeeded.

## Attach application trace context [\#](https://flueframework.com/docs/ecosystem/tooling/opentelemetry/\#attach-application-trace-context)

Workflow and standalone operation spans start as independent roots by default. Use `resolveRootContext` to attach an otherwise-root Flue span beneath application-owned context:

```
import { context, propagation } from '@opentelemetry/api';
import { createOpenTelemetryObserver } from '@flue/opentelemetry';
import { observe } from '@flue/runtime';

observe(
  createOpenTelemetryObserver({
    resolveRootContext(_event, ctx) {
      if (!ctx.req) return undefined;

      return propagation.extract(context.active(), Object.fromEntries(ctx.req.headers));
    },
  }),
);
```

The resolver runs only when there is no tracked Flue parent. This is application-owned extraction, not automatic Flue propagation: dispatched work does not carry HTTP trace context, and durable processing may see a synthetic request rather than the original carrier. Persist or resolve any context needed across admission or isolate boundaries in application-owned state.

The adapter also does not activate its spans as ambient context around provider SDK calls. Separate provider auto-instrumentation may require application-owned composition to appear beneath the intended Flue span.

## Interpret workflow recovery [\#](https://flueframework.com/docs/ecosystem/tooling/opentelemetry/\#interpret-workflow-recovery)

A recovered Cloudflare workflow does not retry or continue authored workflow code. When Flue terminalizes an admitted interrupted run, `run_resume` starts a separate recovery-handling span and closes locally tracked interrupted descendants.

The new segment links to the predecessor only when that span context remains available in the same isolate. After an isolate reset, correlate segments with `flue.run.id` and event indexes; Flue does not durably propagate OpenTelemetry trace context.

## Export content safely [\#](https://flueframework.com/docs/ecosystem/tooling/opentelemetry/\#export-content-safely)

By default, spans contain identifiers, durations, model and provider attributes, token and cost metadata, log levels, and generic failure messages. Workflow payloads and results, detailed errors, model input and output, tool values, task content, and log content are omitted.

Provide `exportContent(event)` to opt specific events into content export. It receives a shallow event copy; return a sanitized event to export its supported values or `undefined` to omit content:

```
observe(
  createOpenTelemetryObserver({
    exportContent(event) {
      if (event.type !== 'log') return undefined;

      return {
        ...event,
        message: redactLogMessage(event.message),
        attributes: redactLogAttributes(event.attributes),
      };
    },
  }),
);
```

Clone nested paths before modifying them. Passing `exportContent: (event) => event` intentionally exports unsanitized supported content and should be used only when the configured backend is appropriate for that data. Flue redacts image data in recognized content blocks, but arbitrary application-owned values still require sanitization.

## Runtime and delivery [\#](https://flueframework.com/docs/ecosystem/tooling/opentelemetry/\#runtime-and-delivery)

The adapter contains target-agnostic tracing code, but the OpenTelemetry SDK and exporter must support the deployment runtime. On Node.js, initialize the SDK before observer registration and flush it during application shutdown. On Cloudflare, verify SDK compatibility, export delivery, and execution-lifetime handling in the deployed Worker or Durable Object rather than relying only on Node tests.

## Verify [\#](https://flueframework.com/docs/ecosystem/tooling/opentelemetry/\#verify)

Run a workflow with a model turn and tool call, then confirm span hierarchy, Flue correlation attributes, usage values, and metadata-only defaults in a non-production backend. If you enable content export or root-context resolution, verify those policies separately with representative sensitive data and each supported deployment target.

## Docs Navigation

Current page: [OpenTelemetry](https://flueframework.com/docs/ecosystem/tooling/opentelemetry/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
