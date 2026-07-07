> Source: https://flueframework.com/docs/cli/overview



# CLI


Last updated Jun 22, 2026 <a href="/docs/cli/overview/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


Install `@flue/cli` as a development dependency, then invoke `flue` through your package manager:

``` astro-code
npm install --save-dev @flue/cli
npx flue dev
```

The CLI requires Node.js `>=22.19.0`. Cloudflare development and deployment also require `wrangler` as a development dependency.

## Develop locally

`flue dev` serves the application for its configured Node.js or Cloudflare target, watches source files, and rebuilds on changes:

``` astro-code
npx flue dev
```

Use its real HTTP and SDK surface while authoring application routes and integrations. Agents and workflows are not public merely because they are discovered; [Routing](/docs/guide/routing/) explains authored exposure.

## Exercise one resource

`flue run` executes one agent prompt or workflow invocation and exits:

``` astro-code
npx flue run assistant --input '{"message":"Summarize this repository."}'
npx flue run summarize-ticket --input '{"ticket":"Ticket details"}'
```

Without an absolute `--server`, the command starts the configured Node.js or Cloudflare runtime temporarily. It calls through the authored `app.ts` and an existing `flue()` mount, so normal application and resource middleware executes. Route-free resources are temporarily available through that mount for local use; this does not alter deployment behavior or create a mount.

Use `--server /api/flue` for a non-root authored local mount. An absolute URL attaches to an already-running local or deployed application:

``` astro-code
npx flue run workflow:summarize-ticket \
  --server https://example.com/api/flue \
  --input '{"ticket":"Ticket details"}'
```

See [`flue run`](/docs/cli/run/) for input, identity, headers, resource qualification, and server behavior.

## Build and deploy

`flue build` creates target-specific deployment output:

``` astro-code
npx flue build
```

A build packages the discovered application for its runtime target. It does not choose a model, add credentials, expose additional routes, or configure platform-owned bindings. Continue to the [Node.js](/docs/ecosystem/deploy/node/) or [Cloudflare](/docs/ecosystem/deploy/cloudflare/) deployment guide.

## Command reference

| Command | Description |
|----|----|
| [`flue init`](/docs/cli/init/) | Create an initial `flue.config.ts`. |
| [`flue dev`](/docs/cli/dev/) | Serve and watch the local application. |
| [`flue run`](/docs/cli/run/) | Execute one agent prompt or workflow invocation, then exit. |
| [`flue build`](/docs/cli/build/) | Create deployable application artifacts. |
| [`flue add`](/docs/cli/add/) | Fetch sandbox, channel, or database installation blueprints for a coding agent. |
| [`flue update`](/docs/cli/update/) | Fetch a current blueprint so a coding agent can apply its newer upgrade guides. |
| [`flue docs`](/docs/cli/docs/) | List, read, and search the bundled Flue documentation. |


## Docs Navigation

Current page: [CLI](/docs/cli/overview/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


