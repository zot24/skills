> Source: https://flueframework.com/docs/ecosystem/tooling/braintrust

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Braintrust


Last updated Jul 21, 2026<a href="/docs/ecosystem/tooling/braintrust/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


## Quickstart

Add tracing to an existing Flue project with the [Braintrust](https://www.braintrust.dev) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add tooling braintrust
```

## Overview

The Braintrust blueprint creates a source-root `braintrust.ts` and imports it once from `app.ts`. The generated module initializes Braintrust when an API key is available, then connects Braintrust’s Flue observer to the runtime event stream:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { observe } from &#39;@flue/runtime&#39;;
import { braintrustFlueObserver, initLogger } from &#39;braintrust&#39;;

if (process.env.BRAINTRUST_API_KEY) {
  initLogger({
    projectName: process.env.BRAINTRUST_PROJECT_NAME ?? &#39;Flue&#39;,
    apiKey: process.env.BRAINTRUST_API_KEY,
  });

  observe((event, ctx) =&gt; {
    const compatible = compatibleEvent(event);
    if (compatible) braintrustFlueObserver(compatible, ctx);
  });
}</code></pre>
<figcaption><span>src/braintrust.ts (abridged)</span></figcaption>
</figure>

The omitted `compatibleEvent(...)` helper translates current Flue tool and recovery events for the Braintrust version installed by the blueprint. The same module runs on Node.js and Cloudflare; unlike Sentry, Braintrust does not require a separate Cloudflare package or Durable Object wrapper.

Once configured, agent operations appear as traces with nested spans for model turns, tools, delegated tasks, and compactions.

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

- A prompt, skill, or compaction operation becomes a `flue.<kind>` task span.
- A model turn becomes an `llm:<model>` span with input, output, errors, and usage metrics.
- A tool call becomes a nested `tool:<name>` span.
- A delegated task becomes a nested task span.
- A context compaction becomes a nested compaction span.

Model spans include token usage and estimated cost where available. Traces retain agent instance, session, operation, and optional `submissionId` correlation. See [Observability](/docs/guide/observability/) for Flue’s identity and observer model.

Braintrust 3.17 expects the previous `tool_call` name for terminal tool events, so the generated bridge translates tool events for the installed version. Re-check that translation before upgrading Braintrust.

## Protect sensitive content

Braintrust tracing is content-bearing. Its observer can export model messages and output, reasoning, system prompts, tool definitions and values, task prompts and results, errors, and correlation metadata.

Review retention, access, privacy, and compliance requirements before enabling it in production. Use Braintrust’s `setMaskingFunction(...)` before initialization when content requires redaction, and test the application-specific masker against representative prompts, reasoning, tool data, errors, secrets, and personal information.

## Cloudflare delivery

On Cloudflare, each generated agent Durable Object exports its own activity. Braintrust flushes asynchronously, but Flue observers cannot attach that final upload to the Durable Object execution lifetime. Delivery is therefore best-effort and may lose final spans when an isolate becomes idle immediately after work completes.

Confirm that tradeoff before enabling Cloudflare export and verify delivery in a deployed Worker. Node uses Braintrust’s process-exit flush fallback.

## Verify

Run an agent with a model turn and tool call against a non-production Braintrust project. Confirm the trace hierarchy, closed tool spans, usage data, and Flue correlation. On Cloudflare, separately verify final-span delivery under the deployed isolate lifecycle.


## Docs Navigation

Current page: [Braintrust](/docs/ecosystem/tooling/braintrust/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


