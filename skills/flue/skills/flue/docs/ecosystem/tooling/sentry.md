> Source: https://flueframework.com/docs/ecosystem/tooling/sentry

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Sentry


Last updated Jul 21, 2026<a href="/docs/ecosystem/tooling/sentry/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


## Quickstart

Add Sentry observability to an existing Flue project with the [Sentry](https://sentry.io) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add tooling sentry
```

## Overview

The Sentry blueprint creates a source-root `sentry.ts` and imports it once from `app.ts`. It delivers three signals that share one trace per conversation: terminal failures as issues, every `log.*` call as Sentry Logs, and — when `SENTRY_TRACES_SAMPLE_RATE > 0` — Flue’s `invoke_agent` → `chat` / `execute_tool` span hierarchy with token usage, following the OpenTelemetry GenAI semantic conventions. On Node.js, the core of the generated integration looks like this:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { createOpenTelemetryInstrumentation } from &#39;@flue/opentelemetry&#39;;
import { instrument } from &#39;@flue/runtime&#39;;
import * as Sentry from &#39;@sentry/node&#39;;

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  enabled: Boolean(process.env.SENTRY_DSN),
  tracesSampleRate, // clamped from SENTRY_TRACES_SAMPLE_RATE, default 0
  traceLifecycle: &#39;stream&#39;, // deliver gen_ai children that outlive their parent
  streamGenAiSpans: true,
  enableLogs: true,
  integrations: (defaults) =&gt; defaults.filter((i) =&gt; !SENTRY_AI_PROVIDER_INTEGRATIONS.has(i.name)),
});

// Sentry owns the global OTel tracer provider, so Flue&#39;s spans land in
// Sentry directly; the content policy keeps model/tool content out of
// traces unless the record flags opt in.
if (tracesSampleRate &gt; 0) {
  instrument(createOpenTelemetryInstrumentation({ content: contentPolicy() }));
}

instrument({
  key: Symbol.for(&#39;flue.sentry.bridge&#39;), // dev reloads replace, never stack
  observe(event) {
    if (event.type === &#39;operation&#39; &amp;&amp; event.isError) {
      // Issues are built from the live `errorInfo`, which carries the
      // throw-site stack; the failed submission&#39;s settlement is skipped
      // so each failure raises exactly one issue.
      captureTerminalFailure(event.errorInfo ?? event.error, correlationTags(event));
      if (event.submissionId) capturedFailedSubmissions.add(event.submissionId);
      return;
    }
    if (event.type === &#39;submission_settled&#39;) {
      /* capture only un-captured failures */
    }
    if (event.type === &#39;log&#39;) {
      Sentry.logger[event.level](event.message, logAttributes(event));
    }
  },
  interceptor: (_operation, _ctx, next) =&gt; next(),
  async dispose() {
    await Sentry.flush(2000);
  },
});</code></pre>
<figcaption><span>src/sentry.ts (abridged)</span></figcaption>
</figure>

On Cloudflare, the generated `sentry.ts` contains the same bridge and instrumentation without calling `Sentry.init()`. Instead, the blueprint adds a module-local `cloudflare` extension to every agent. The extension wraps the final generated Durable Object class with `instrumentDurableObjectWithSentry(...)`, which initializes the SDK — tracing and logs included — per isolate, while leaving the outer Worker uninstrumented.

## Configure

| Variable                    | Purpose                                                                                              |
|-----------------------------|------------------------------------------------------------------------------------------------------|
| `SENTRY_DSN`                | **Required for event delivery** — Identifies the Sentry project and permits event submission.        |
| `SENTRY_ENVIRONMENT`        | **Optional** — Identifies the deployment environment in Sentry.                                      |
| `SENTRY_RELEASE`            | **Optional** — Associates events with a deployed release.                                            |
| `SENTRY_TRACES_SAMPLE_RATE` | **Optional** — `0` to `1`. `0` (default) sends errors and logs only; above `0` also sends AI traces. |
| `SENTRY_AI_RECORD_INPUTS`   | **Optional** — `true` includes prompts, instructions, and tool definitions/arguments in trace spans. |
| `SENTRY_AI_RECORD_OUTPUTS`  | **Optional** — `true` includes model output, tool results, and exception messages/stacks in spans.   |

Only `SENTRY_DSN` is needed to deliver events. A Sentry DSN permits event submission but does not grant read access to project data. Keeping it in deployment configuration rather than application source makes rotation and abuse mitigation easier; use a secret or environment binding according to your project’s policy.

The blueprint installs `@sentry/node` or `@sentry/cloudflare` plus `@flue/opentelemetry`, initializes the SDK at the appropriate runtime boundary, and registers the event bridge and span instrumentation through `instrument(...)`. Model and tool content stays out of traces unless the record flags opt in.

See [Observability](/docs/guide/observability/#choose-an-observability-provider) to compare Sentry with OpenTelemetry and Braintrust.

The integration uses different SDKs by target:

- **Node.js** — `@sentry/node`, initialized with a module-scoped `Sentry.init(...)` in application source.
- **Cloudflare** — `@sentry/cloudflare`, initialized with `instrumentDurableObjectWithSentry(...)` around each generated agent Durable Object.

Do not use `@sentry/node` on Cloudflare.

## Choose what to report

The generated integration reports:

- **Issues** — `operation` events with `isError: true` (a failed prompt, skill, task, shell, or compact operation) and `submission_settled` events with `outcome: 'failed'` that weren’t already captured from their operation, so one failure raises one issue;
- **Logs** — every `log.info`, `log.warn`, and `log.error` call at its own level in Sentry Logs, with scrubbed attributes and trace correlation. Error logs are logs, not issues: an agent that reports a recoverable error and continues never raises an issue;
- **Traces** — the span hierarchy Flue’s OpenTelemetry instrumentation emits, sampled by `SENTRY_TRACES_SAMPLE_RATE`. Sentry’s own AI provider integrations are suppressed so model calls aren’t double-counted.

Captures include `flue.*` correlation tags — agent instance, agent name, conversation, session, operation, and submission — matching the attributes on the trace spans. See [Observability](/docs/guide/observability/) for Flue’s identity and observer model.

With the record flags off, spans carry timing, token usage, model identifiers, and correlation ids but no message or tool content. Enabling a record flag routes that direction’s content through a scrubbing transform with a 16 KiB per-attribute budget. Make an explicit data-handling decision before widening that policy.

## Target behavior

On Node.js, module-scoped initialization is sufficient for the bridge’s captures and Flue’s spans. Complete Sentry HTTP or database auto-instrumentation requires Sentry’s preload setup before application imports and should be verified against the built Flue server. Shutdown flushing is best-effort: SIGINT/SIGTERM listeners call `Sentry.flush(...)` without owning process exit, so traces and issues sent during the run are safe while very-recently-buffered logs can be cut short.

On Cloudflare, Flue applies a module-local `wrap` extension to the final generated Durable Object class for every instrumented agent. This preserves Flue’s routing and durability behavior while allowing Sentry to initialize from the current binding environment, once per isolate. The wrapper does not cover the outer Worker or an authored Hono application; add HTTP middleware separately when request instrumentation is required.

## Verify

With `SENTRY_TRACES_SAMPLE_RATE=1` against a non-production Sentry project, prompt a tool-using agent and confirm one trace with `invoke_agent`, `chat`, and `execute_tool` spans plus its logs in Sentry Logs. Trigger one terminal failure and confirm exactly one issue with the original error and throw-site stack. Confirm the expected `flue.*` correlation fields, that no model content appears while the record flags are off, on Cloudflare that a wrapped agent delivers from workerd, and that the application still starts without a configured DSN.


## Docs Navigation

Current page: [Sentry](/docs/ecosystem/tooling/sentry/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


