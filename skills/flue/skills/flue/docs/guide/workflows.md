> Source: https://flueframework.com/docs/guide/workflows

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Workflows


Last updated Jun 22, 2026 <a href="/docs/guide/workflows/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


Workflows are finite, inspectable operations for background jobs, document transformations, reviews, and CI tasks. Use an [agent](/docs/guide/building-agents/) instead when work should continue across messages.

## Create a workflow

A file in `src/workflows/` defines a discovered workflow. Its filename becomes the workflow name, and its default export must be the value returned by `defineWorkflow()`:

``` astro-code
import { defineAgent, defineWorkflow } from '@flue/runtime';
import * as v from 'valibot';

export default defineWorkflow({
  agent: defineAgent(() => ({ model: 'anthropic/claude-haiku-4-5' })),
  input: v.object({ text: v.string() }),
  output: v.object({ summary: v.string() }),

  async run({ harness, input }) {
    const session = await harness.session();
    const response = await session.prompt(input.text);
    return { summary: response.text };
  },
});
```

This defines the `summarize` workflow. Each invocation validates the supplied text, asks the model to summarize it, and returns a validated `{ summary }` result. Use this pattern for finite work that should have its own run, result, and event history. See the [Workflow API](/docs/api/workflow-api/) for the complete definition contract.

## Use a reusable Action

Define the workflow inline as shown above for the ordinary case. If the workflow should run an existing [Action](/docs/guide/actions/), bind that Action to its agent:

``` astro-code
import { defineAgent, defineWorkflow } from '@flue/runtime';
import { summarize } from '../actions/summarize.ts';

export default defineWorkflow({
  agent: defineAgent(() => ({ model: 'anthropic/claude-haiku-4-5' })),
  action: summarize,
});
```

The Action owns the input, output, and handler, so the workflow does not repeat them. See [Actions](/docs/guide/actions/) for when and how to define one.

## Invoke a workflow

### CLI

Run a discovered workflow locally without adding authored workflow HTTP exposure:

``` astro-code
pnpm exec flue run summarize --input '{"text":"Flue workflows complete finite operations."}'
```

`flue run` validates the JSON supplied to `--input`, starts the configured Node.js or Cloudflare application temporarily, and invokes the workflow through its existing `flue()` mount. The normal `app.ts` pipeline and middleware execute; route-free resources are available only within this temporary local runtime. The command reports run events, prints the successful result as JSON, and exits.

### Application code

Use ambient `invoke()` from application-owned routes, channels, schedules, or other code executing inside a Flue-built server:

``` astro-code
import { invoke } from '@flue/runtime';
import summarize from './workflows/summarize.ts';

const { runId } = await invoke(summarize, {
  input: { text: 'Summarize this document.' },
});
```

`invoke()` admits a real workflow run and returns its `runId` without waiting for completion. Import the exact default export of a discovered workflow module. Use `dispatch()` instead when input should continue one persistent Agent conversation.

## Expose a workflow over HTTP

Workflow HTTP access is private by default. Two independent module exports control it:

| Export  | Exposes                                                |
|---------|--------------------------------------------------------|
| `route` | Invocation at `POST /workflows/<name>`.                |
| `runs`  | Run records and event streams beneath `/runs/<runId>`. |

Use the same authentication policy for both when callers should be able to invoke and inspect a workflow:

``` astro-code
import type { WorkflowRouteHandler, WorkflowRunsHandler } from '@flue/runtime';
import { requireUser } from '../auth.ts';

export const route: WorkflowRouteHandler = requireUser;
export const runs: WorkflowRunsHandler = requireUser;
```

Each handler is ordinary Hono middleware. Calling `next()` allows the request; returning a response denies it. Export only `route` when callers may start work but must not inspect runs, or only `runs` when runs created by schedules or application code should be inspectable.

With both exports, an SDK caller can invoke and then inspect the run:

``` astro-code
const { runId } = await client.workflows.invoke('summarize', {
  input: { text: 'Summarize this document.' },
});

const record = await client.runs.get(runId);
const events = await client.runs.events(runId);
```

Invocation returns `{ runId }`, or `{ runId, result }` with `wait: 'result'`. The `runs` export also controls SDK `client.runs` and raw `GET` and `HEAD` requests to `/runs/<runId>`. Without the corresponding export, HTTP clients receive `404`. Run data may contain sensitive inputs, results, and model activity, so do not treat a run ID as a credential.

These exports do not affect schedules, ambient `invoke()`, or server-side `listRuns()` and `getRun()`. A temporary local `flue run` process additionally exposes route-free resources through an existing authored `flue()` mount; remote attachment uses the server’s authored exposure. See the [Workflow API HTTP exports](/docs/api/workflow-api/#http-exports) for the complete contract.

## Use the workflow harness

The harness is ready when the workflow handler starts. Its canonical conversation state is local to this workflow execution: another invocation receives a new run and does not continue these sessions. Use the default session for related operations and its filesystem or shell for workflow-controlled setup:

``` astro-code
async run({ harness, input }) {
  await harness.fs.writeFile('document.md', input.document);
  const session = await harness.session();
  await session.prompt('Review document.md and write findings to review.md.');
  return { review: await harness.fs.readFile('review.md') };
}
```

A session can also run skills, delegate tasks, and produce schema-backed structured results. See [Agent API](/docs/api/agent-api/), [Skills](/docs/guide/skills/), [Subagents](/docs/guide/subagents/), and [Sandboxes](/docs/guide/sandboxes/).


## Docs Navigation

Current page: [Workflows](/docs/guide/workflows/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


