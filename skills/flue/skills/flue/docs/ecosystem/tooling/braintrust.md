> Source: https://flueframework.com/docs/ecosystem/tooling/braintrust

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Braintrust


AI-generated, awaiting review <a href="/docs/ecosystem/tooling/braintrust/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


## Quickstart

Add tracing to an existing Flue project with the [Braintrust](https://www.braintrust.dev) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add tooling braintrust
```

## Overview

The Braintrust blueprint creates a source-root `braintrust.ts` and imports it once from `app.ts`. The generated module initializes Braintrust when an API key is available, then connects Braintrust’s Flue observer to the runtime event stream:

``` astro-code
import { observe } from '@flue/runtime';
import { braintrustFlueObserver, initLogger } from 'braintrust';

if (process.env.BRAINTRUST_API_KEY) {
  initLogger({
    projectName: process.env.BRAINTRUST_PROJECT_NAME ?? 'Flue',
    apiKey: process.env.BRAINTRUST_API_KEY,
  });

  observe((event, ctx) => {
    const compatible = compatibleEvent(event);
    if (compatible) braintrustFlueObserver(compatible, ctx);
  });
}
```

The omitted `compatibleEvent(...)` helper translates current Flue tool and recovery events for the Braintrust version installed by the blueprint. The same module runs on Node.js and Cloudflare; unlike Sentry, Braintrust does not require a separate Cloudflare package or Durable Object wrapper.

Once configured, workflow invocations appear as root traces with nested spans for operations, model turns, tools, delegated tasks, and compactions. Persistent-agent operations are traced without being represented as workflow runs.

## Configure

| Variable                  | Purpose                                                                                 |
|---------------------------|-----------------------------------------------------------------------------------------|
| `BRAINTRUST_API_KEY`      | **Required for trace export** — Authenticates trace export to Braintrust.               |
| `BRAINTRUST_PROJECT_NAME` | **Optional** — Chooses the Braintrust project that receives traces. Defaults to `Flue`. |

Never commit the API key; on Cloudflare, store it as a Worker secret rather than a Wrangler `vars` value. When the key is absent, the integration does not initialize or subscribe and the application continues without trace export.

The blueprint installs Braintrust 3.17 and registers its public Flue observer through `observe(...)`. The same source builds on Node.js and Cloudflare through Braintrust’s `workerd` export; no separate Cloudflare package or Durable Object wrapper is needed.

Braintrust also provides a Node import hook for Node-only auto-instrumentation. The generated manual observer is the portable path for projects that may target either runtime.

See [Observability](/docs/guide/observability/#choose-an-observability-provider) to compare Braintrust with OpenTelemetry and Sentry.

## What Braintrust traces

| Flue activity                          | Braintrust trace                                                 |
|----------------------------------------|------------------------------------------------------------------|
| Workflow invocation                    | Root `workflow:<name>` task span                                 |
| Prompt, skill, or compaction operation | Nested `flue.<kind>` task span                                   |
| Model turn                             | `llm:<model>` span with input, output, errors, and usage metrics |
| Tool call                              | Nested `tool:<name>` span                                        |
| Delegated task                         | Nested task span                                                 |
| Context compaction                     | Nested compaction span                                           |

Model spans include token usage and estimated cost where available. Workflow traces carry `runId`; persistent-agent traces retain agent instance, session, operation, and optional `dispatchId` correlation. See [Observability](/docs/guide/observability/) for Flue’s identity and observer model.

Braintrust 3.17 expects the previous `tool_call` name for terminal tool events, reads workflow input from the legacy synthetic `run_start.payload` field, and does not consume `run_resume`. Normal Flue `run_start` events retain their current public `input` shape. The generated bridge translates tool events and creates a payload-less synthetic recovery start only when the current isolate did not observe the original workflow start; otherwise the existing workflow span remains open for `run_end`. This fallback does not preserve Flue’s distinct recovery semantics or durably continue a trace across isolates. Re-check these translations before upgrading Braintrust.

## Protect sensitive content

Braintrust tracing is content-bearing. Braintrust 3.17 does not currently read Flue’s public `run_start.input`, but its observer can export workflow results, model messages and output, reasoning, system prompts, tool definitions and values, task prompts and results, errors, and correlation metadata. Reassess workflow-input export when upgrading the integration.

Review retention, access, privacy, and compliance requirements before enabling it in production. Use Braintrust’s `setMaskingFunction(...)` before initialization when content requires redaction, and test the application-specific masker against representative prompts, reasoning, tool data, errors, secrets, and personal information.

## Cloudflare delivery

On Cloudflare, each generated agent and workflow Durable Object exports its own activity. Braintrust flushes asynchronously, but Flue observers cannot attach that final upload to the Durable Object execution lifetime. Delivery is therefore best-effort and may lose final spans when an isolate becomes idle immediately after work completes.

Confirm that tradeoff before enabling Cloudflare export and verify delivery in a deployed Worker. Node uses Braintrust’s process-exit flush fallback.

## Verify

Run a workflow with a model turn and tool call against a non-production Braintrust project. Confirm the trace hierarchy, closed tool spans, usage data, and Flue correlation. On Cloudflare, separately verify final-span delivery under the deployed isolate lifecycle.


## Docs Navigation

Current page: [Braintrust](/docs/ecosystem/tooling/braintrust/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


