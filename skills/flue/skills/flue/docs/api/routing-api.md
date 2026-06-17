<!-- Source: https://flueframework.com/docs/api/routing-api -->

Import application composition APIs from `@flue/runtime/routing`.

## `app.ts` [\#](https://flueframework.com/docs/api/routing-api/\#appts)

`app.ts` is an optional authored application entrypoint. Without it, Flue generates an application that mounts `flue()` at `/`. When `app.ts` exists, its default export owns the request pipeline and must mount `flue()` explicitly to publish Flue routes.

```
import { flue } from '@flue/runtime/routing';
import { Hono } from 'hono';

const app = new Hono();
app.route('/', flue());
export default app;
```

See [Routing](https://flueframework.com/docs/guide/routing/) for middleware, custom routes, prefixes, and application-owned dispatch.

#### `Fetchable` [\#](https://flueframework.com/docs/api/routing-api/\#fetchable)

```
interface Fetchable {
  fetch(request: Request, env?: unknown, ctx?: unknown): Response | Promise<Response>;
}
```

Structural contract for the default export of an authored `app.ts` entry. Any object exposing a compatible `fetch()` method satisfies it, including a `new Hono()` instance.

On Cloudflare, `env` contains bindings and `ctx` is the `ExecutionContext`. On Node, `env` contains Hono’s Node adapter bindings for the incoming and outgoing messages, and `ctx` is `undefined`.

## `flue()` [\#](https://flueframework.com/docs/api/routing-api/\#flue)

```
function flue(): Hono;
```

Creates a mountable Hono sub-app for Flue’s public HTTP API. Routes are relative to the application-chosen mount prefix.

| Route | Purpose |
| --- | --- |
| `GET /openapi.json` | Return the public OpenAPI document. |
| `POST /agents/:name/:id` | Start a prompt on an HTTP-exposed agent instance; returns `202` with stream coordinates. |
| `GET /agents/:name/:id` | Stream agent events via the Durable Streams protocol. |
| `HEAD /agents/:name/:id` | Return agent stream metadata (tail offset, closed status). |
| `POST /workflows/:name` | Start an HTTP-exposed workflow run. |
| `GET /runs/:runId` | Stream workflow-run events via the Durable Streams protocol. |
| `GET /runs/:runId?meta` | Retrieve the workflow-run record as plain JSON. |
| `HEAD /runs/:runId` | Return run stream metadata (tail offset, closed status). |
| `* /channels/:name/*` | Serve method- and suffix-specific discovered channel handlers. |

Agent and workflow invocation routes are available only when the corresponding module exports a `route` handler. Discovered channel files export a named `channel` binding whose provider-declared routes are always mounted beneath `/channels/<filename>`. Run routes inspect workflow runs only and are available beneath `flue()` after a run is admitted, regardless of whether that workflow exposes HTTP invocation. They may expose payloads, results, errors, and events. Applications publishing them should authorize access to the selected run. Direct agent prompts and dispatched agent inputs are not runs.

`POST /agents/:name/:id` accepts a JSON body of `{ message, images? }`: a required `message` string and an optional `images` array of `{ type: 'image', data, mimeType }` attachments, where `data` is base64-encoded image content (capped at 14 MiB of base64 characters per image) for vision-capable models. `POST /workflows/:name` accepts the workflow’s JSON payload. The exact request schemas are published at `GET /openapi.json`.

Both invocation routes share one flat response convention. `POST /agents/:name/:id` returns `202 { streamUrl, offset }` after admission, or `200 { result, streamUrl, offset }` with `?wait=result`. `POST /workflows/:name` returns `202 { runId, streamUrl, offset }` after admission, or `200 { result, runId, streamUrl, offset }` with `?wait=result`. `streamUrl` and `offset` are server-provided stream coordinates: reading `streamUrl` from `offset` yields the admitted work’s events (the whole run for workflows; that prompt’s events for agents). Treat `offset` as an opaque token — do not construct one. `202` responses also mirror the coordinates as `Location` and `Stream-Next-Offset` headers, matching Durable Streams stream creation. Any `?wait` value other than `result` is rejected with `400 invalid_request` on both routes.

For agent prompts, waiting with `?wait=result` is best-effort and scoped to the process that admitted the prompt. The prompt itself is a durable submission either way: if the admitting process is interrupted before settlement, the waiting connection is lost while recovery settles the submission in the background — the outcome then appears in session history and as a `submission_settled` event on the agent’s stream instead of answering the original request. A caller that must observe the outcome across interruptions should read the agent stream from the returned coordinates rather than relying on the synchronous response.

`GET /runs/:runId?meta` selects the run-record view of the run resource: the persisted record (`runId`, `workflowName`, `status`, timestamps, `payload`, `result`, `error`) as a plain JSON object. The `?meta` response carries no Durable Streams headers, and stream parameters (`offset`, `live`) are ignored on this view. Both views of `/runs/:runId` are guarded by the same workflow `route` middleware: if a caller can read the run’s event stream, it can read the run record.

## Compose your own admin endpoints [\#](https://flueframework.com/docs/api/routing-api/\#compose-your-own-admin-endpoints)

Flue ships no admin HTTP surface. Build deployment-inspection endpoints from the server-side primitives exported by `@flue/runtime` — [`listRuns()`, `getRun()`, and `listAgents()`](https://flueframework.com/docs/api/data-persistence-api/#inspection-primitives) — behind your own authorization:

```
import { listAgents, listRuns } from '@flue/runtime';
import { flue } from '@flue/runtime/routing';
import { Hono } from 'hono';
import { requireOperator } from './auth.ts';

const app = new Hono();
app.route('/', flue());
app.use('/admin/*', requireOperator);
app.get('/admin/agents', async (c) => c.json(await listAgents()));
app.get('/admin/runs', async (c) => c.json(await listRuns({ limit: 100 })));
export default app;
```

The endpoints, their shapes, and their authorization are application-owned — add filters, pagination params, or projections as your operators need them.

## Docs Navigation

Current page: [Routing API](https://flueframework.com/docs/api/routing-api/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
