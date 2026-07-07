> Source: https://flueframework.com/docs/ecosystem/tooling/sentry

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Sentry


Last updated Jun 20, 2026 <a href="/docs/ecosystem/tooling/sentry/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


## Quickstart

Add error reporting to an existing Flue project with the [Sentry](https://sentry.io) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add tooling sentry
```

## Overview

The Sentry blueprint creates a source-root `sentry.ts` and imports it once from `app.ts`. On Node.js, the core of that generated bridge looks like this:

``` astro-code
import { observe } from '@flue/runtime';
import * as Sentry from '@sentry/node';

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  enabled: Boolean(process.env.SENTRY_DSN),
  environment: process.env.SENTRY_ENVIRONMENT ?? process.env.NODE_ENV,
  release: process.env.SENTRY_RELEASE,
  attachStacktrace: true,
  tracesSampleRate: 0,
});

observe((event) => {
  if (event.type === 'run_end' && event.isError) {
    Sentry.captureException(toError(event.error));
  }

  if (event.type === 'log' && event.level === 'error') {
    if (Object.hasOwn(event.attributes ?? {}, 'error')) {
      Sentry.captureException(toError(event.attributes?.error));
    } else {
      Sentry.captureMessage(event.message, 'error');
    }
  }
});

function toError(value: unknown): Error {
  return value instanceof Error ? value : new Error(String(value));
}
```

On Cloudflare, the generated `sentry.ts` contains the same observer bridge without calling `Sentry.init()`. Instead, the blueprint adds a module-local `cloudflare` extension to every discovered agent and workflow. The extension wraps the final generated Durable Object class with `instrumentDurableObjectWithSentry(...)`, while leaving the outer Worker uninstrumented.

## Configure

| Variable             | Purpose                                                                                       |
|----------------------|-----------------------------------------------------------------------------------------------|
| `SENTRY_DSN`         | **Required for event delivery** — Identifies the Sentry project and permits event submission. |
| `SENTRY_ENVIRONMENT` | **Optional** — Identifies the deployment environment in Sentry.                               |
| `SENTRY_RELEASE`     | **Optional** — Associates events with a deployed release.                                     |

Only `SENTRY_DSN` is needed to deliver events. A Sentry DSN permits event submission but does not grant read access to project data. Keeping it in deployment configuration rather than application source makes rotation and abuse mitigation easier; use a secret or environment binding according to your project’s policy.

The blueprint installs `@sentry/node` or `@sentry/cloudflare`, initializes the SDK at the appropriate runtime boundary, and adds an `observe(...)` bridge for workflow failures and explicit `ctx.log.error(...)` calls. It does not enable traces, AI metrics, or model-content export by default.

See [Observability](/docs/guide/observability/#choose-an-observability-provider) to compare Sentry with OpenTelemetry and Braintrust.

The integration uses different SDKs by target:

| Target     | Package              | Initialization                                                                                   |
|------------|----------------------|--------------------------------------------------------------------------------------------------|
| Node.js    | `@sentry/node`       | Module-scoped `Sentry.init(...)` in application source                                           |
| Cloudflare | `@sentry/cloudflare` | `instrumentDurableObjectWithSentry(...)` around each generated agent and workflow Durable Object |

Do not use `@sentry/node` on Cloudflare through `nodejs_compat`.

## Choose what to report

The generated bridge reports:

- workflow `run_end` events with `isError: true`;
- `ctx.log.error(...)` as an exception when the log has an `error` attribute;
- other error logs as error-level Sentry messages.

Captures include relevant `flue.*` correlation tags. Workflow failures include `flue.run.id`, which can be inspected with SDK `client.runs` or raw `/runs` APIs when the workflow exposes its run resources. Persistent-agent captures use instance, session, operation, submission, and optional dispatch correlation instead. See [Observability](/docs/guide/observability/) for Flue’s identity and observer model.

The bridge intentionally skips failed operations and tools because those failures may be recovered and later duplicated by a fatal workflow report. It also avoids arbitrary log attributes, prompts, responses, tool arguments, and complete event payloads. Make an explicit data-handling decision before expanding that policy.

## Target behavior

On Node.js, module-scoped initialization is sufficient for the bridge’s explicit captures. Complete Sentry HTTP, database, or tracing auto-instrumentation requires Sentry’s preload setup before application imports and should be verified against the built Flue server.

On Cloudflare, Flue applies a module-local `wrap` extension to the final generated Durable Object class for every instrumented agent and workflow. This preserves Flue’s routing and durability behavior while allowing Sentry to initialize from the current binding environment. The wrapper does not cover the outer Worker or an authored Hono application; add HTTP middleware separately when request instrumentation is required.

## Verify

Trigger one failed workflow and one explicit error log against a non-production Sentry project. Confirm the expected `flue.*` correlation fields. On Cloudflare, exercise a wrapped agent or workflow under workerd, and verify that the application still starts without a configured DSN.


## Docs Navigation

Current page: [Sentry](/docs/ecosystem/tooling/sentry/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


