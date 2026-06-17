<!-- Source: https://flueframework.com/docs/guide/routing -->

`src/app.ts` is an optional entrypoint for providing your own HTTP application in a Flue project. Add this file when your application needs authentication, health checks, route prefixes, or custom routes alongside the agents, workflows, and channels exposed by Flue.

It is an ordinary [Hono](https://hono.dev/) application, so you can compose Flue routes with your own routes and middleware.

## `app.ts` [\#](https://flueframework.com/docs/guide/routing/\#appts)

Without `src/app.ts`, Flue generates an application that mounts its public routes at `/`. When you add `src/app.ts`, export a Hono application and mount `flue()` explicitly:

```
import { flue } from '@flue/runtime/routing';
import { Hono, type MiddlewareHandler } from 'hono';
import { authenticate } from './auth.ts';

const requireUser: MiddlewareHandler = async (c, next) => {
  const user = await authenticate(c.req.raw);

  if (!user) {
    return c.json({ error: 'Unauthorized' }, 401);
  }

  await next();
};

const app = new Hono();

app.get('/health', (c) => c.json({ ok: true }));

app.use('/agents/*', requireUser);
app.use('/workflows/*', requireUser);
app.use('/runs/*', requireUser);
app.use('/channels/*', requireUser);
app.route('/', flue());

export default app;
```

In this application, `/health` is an application-owned route, while `flue()` serves exposed agents, exposed workflows, workflow run routes, and discovered channels. The middleware protects those Flue route families before requests reach their handlers.

Use broader middleware for requirements shared by a group of routes, such as requiring an authenticated user. When access depends on a specific selected resource, apply that check as well: for example, an agent route should verify that the caller may access the agent instance named by its `id`, and an application that publishes workflow run reads should authorize access to the selected run.

Because your authored application imports `Hono`, include `hono` in your application dependencies. See [Project Layout](https://flueframework.com/docs/guide/project-layout/) for alternative source directories supported by existing projects.

## Add custom routes [\#](https://flueframework.com/docs/guide/routing/\#add-custom-routes)

A custom application can serve any route your service needs. It can also accept an external event, verify and normalize it, and deliver it to an agent without exposing a direct prompt route for that event source:

```
import { dispatch } from '@flue/runtime';
import { flue } from '@flue/runtime/routing';
import { Hono } from 'hono';
import supportAssistant from './agents/support-assistant.ts';
import { parseVerifiedSupportComment } from './support-webhooks.ts';

const app = new Hono();

app.post('/webhooks/support-comments', async (c) => {
  const event = await parseVerifiedSupportComment(c.req.raw);
  const receipt = await dispatch(supportAssistant, {
    id: event.ticketId,
    input: {
      type: 'support.comment.created',
      commentId: event.commentId,
      text: event.text,
    },
  });

  return c.json(receipt, 202);
});

app.route('/', flue());

export default app;
```

Here, the webhook route belongs to your application: it determines which requests are valid and which agent instance receives the accepted input. `dispatch(...)` delivers that input asynchronously to the continuing agent session. See [Agents](https://flueframework.com/docs/guide/building-agents/) for agent interaction patterns and [Channels](https://flueframework.com/docs/guide/channels/) for provider integrations.

## Customized routing [\#](https://flueframework.com/docs/guide/routing/\#customized-routing)

For most applications, mount Flue at the root with `app.route('/', flue())`. You can instead mount it beneath a prefix when Flue is one part of a larger API:

```
import { flue } from '@flue/runtime/routing';
import { Hono } from 'hono';

const app = new Hono();

app.get('/health', (c) => c.json({ ok: true }));
app.route('/api', flue());

export default app;
```

With this mount, an exposed `support-assistant` agent is available beneath `/api/agents/support-assistant/:id`, an exposed `summarize-ticket` workflow is available beneath `/api/workflows/summarize-ticket`, and `channels/github.ts` publishes its webhook beneath `/api/channels/github/webhook`. Workflow run routes and Flue’s OpenAPI output are mounted beneath the same prefix. SDK consumers should include the mount pathname in `baseUrl`, such as `createFlueClient({ baseUrl: 'https://example.com/api' })`.

Apply middleware to the mounted paths your application publishes, such as `/api/agents/*`, `/api/workflows/*`, `/api/runs/*`, and `/api/channels/*` in this example.

Discovered channel filenames and provider route suffixes are fixed beneath the
`flue()` mount. An authored `app.ts` can prefix all Flue routes but cannot
relocate one channel independently. Use an ordinary application-owned route
outside `channels/` when you need complete path control.

## Exposing agents and workflows [\#](https://flueframework.com/docs/guide/routing/\#exposing-agents-and-workflows)

Mounting `flue()` does not make every discovered agent or workflow directly invocable. Each module opts into its public transports:

| Module export | Available through the mounted Flue application |
| --- | --- |
| Agent `route` | HTTP prompts at `POST /agents/:name/:id` and event streaming at `GET /agents/:name/:id` beneath the mount path. |
| Workflow `route` | HTTP invocation at `POST /workflows/:name` beneath the mount path. |
| Channel `channel` | Provider-declared HTTP surfaces beneath `/channels/:name/<suffix>`. |

Run reads at `GET /runs/:runId` (event streaming, and the run record via `?meta`) are not gated by any module export: the route is registered unconditionally beneath the mount path and serves any admitted workflow run, however it was invoked. When the owning workflow exports `route` middleware, both views run that middleware before disclosing whether the run exists. Unknown run IDs return `404`.

If you want run existence to stay undisclosed to unauthorized callers, have your `route` middleware reject with the same `404` shape an unknown run produces — a `401`/`403` from per-workflow middleware tells the caller a run with that ID exists. For policies that should cover every run regardless of workflow (a shared auth gate, rate limiting), apply ordinary Hono middleware in your `app.ts` above the mounted Flue app — your application owns the request path, so `app.use('/api/runs/*', ...)` runs before any Flue routing.

An agent used only through application-owned `dispatch(...)` calls does not need a public transport export.

See [Agents](https://flueframework.com/docs/guide/building-agents/) for creating and exposing continuing agent instances, and [Workflows](https://flueframework.com/docs/guide/workflows/) for exposing finite operations and inspecting their runs.

## Next steps [\#](https://flueframework.com/docs/guide/routing/\#next-steps)

- [Agents](https://flueframework.com/docs/guide/building-agents/) — create continuing agents and deliver direct or dispatched input.
- [Workflows](https://flueframework.com/docs/guide/workflows/) — create finite operations and inspect workflow runs.
- [Channels](https://flueframework.com/docs/guide/channels/) — compose provider ingress with agent sessions.
- [CLI](https://flueframework.com/docs/cli/overview/) — run the application locally, create build output, and continue to deployment.
- [Observability](https://flueframework.com/docs/guide/observability/) — observe workflow runs and agent activity.

## Docs Navigation

Current page: [Routing](https://flueframework.com/docs/guide/routing/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
