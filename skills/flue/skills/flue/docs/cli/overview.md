<!-- Source: https://flueframework.com/docs/cli/overview -->

Install `@flue/cli` as a development dependency, then invoke the `flue` executable through your package manager:

```
npm install --save-dev @flue/cli
npx flue dev
```

The CLI requires Node.js `>=22.19.0`. Cloudflare development and deployment also require `wrangler` as a development dependency.

The CLI follows the application lifecycle: initialize a target, develop against it locally, exercise agents and workflows, inspect workflow runs, and create the artifact you deploy. Each command page documents its complete arguments, options, output, and target-specific behavior.

## Initialize and configure [\#](https://flueframework.com/docs/cli/overview/\#initialize-and-configure)

Use `flue init` once to create a starter `flue.config.ts` for Node.js or Cloudflare:

```
npx flue init --target node
```

The configuration selects the normal runtime target and can set the project root and build output. CLI flags provide one-time overrides. See [`flue init`](https://flueframework.com/docs/cli/init/), [Configuration](https://flueframework.com/docs/reference/configuration/), and [Project Layout](https://flueframework.com/docs/guide/project-layout/) for the available settings and source discovery conventions.

## Develop locally [\#](https://flueframework.com/docs/cli/overview/\#develop-locally)

Use `flue dev` while authoring an application:

```
npx flue dev
```

Development mode builds the discovered application for its configured target, serves it locally, and rebuilds as source files change. Use it to exercise the same routes and runtime environment that callers use. Agents and workflows are not public merely because they are built; [Routing](https://flueframework.com/docs/guide/routing/) explains how to expose them and add application-owned routes.

Keep local credentials and platform values in environment configuration rather than source. See [`flue dev`](https://flueframework.com/docs/cli/dev/) for watch behavior, ports, environment files, and target-specific details.

## Exercise agents and workflows [\#](https://flueframework.com/docs/cli/overview/\#exercise-agents-and-workflows)

For a Node.js target, the CLI can exercise discovered agents and workflows without public HTTP routes.

Use `flue connect` for an interactive connection to one continuing agent instance:

```
npx flue connect support-assistant ticket-8472
```

Use `flue run` for one finite workflow invocation:

```
npx flue run summarize-ticket --payload '{"ticket":"Ticket details"}'
```

These commands use private local execution and do not pass through application ingress middleware. Deployed applications instead receive input through their published routes and transports. See [`flue connect`](https://flueframework.com/docs/cli/connect/) and [`flue run`](https://flueframework.com/docs/cli/run/) for their exact contracts.

## Inspect workflow runs [\#](https://flueframework.com/docs/cli/overview/\#inspect-workflow-runs)

Use `flue logs` to replay or follow events for a workflow run owned by a running Flue server:

```
npx flue logs run_01JX...
```

Runs are workflow-only. Direct agent prompts and dispatched agent inputs are persistent session interactions, not runs. A one-shot `flue run` process streams its own events and cannot be inspected later with `flue logs`. See [`flue logs`](https://flueframework.com/docs/cli/logs/) for server selection, authentication headers, filtering, and output formats.

## Build and deploy [\#](https://flueframework.com/docs/cli/overview/\#build-and-deploy)

Use `flue build` to create target-specific deployment output:

```
npx flue build
```

A build packages the discovered application for its runtime target. It does not choose a model, add credentials, expose additional routes, or configure platform-owned bindings. See [`flue build`](https://flueframework.com/docs/cli/build/) for output details, then continue to the [Node.js](https://flueframework.com/docs/ecosystem/deploy/node/) or [Cloudflare](https://flueframework.com/docs/ecosystem/deploy/cloudflare/) deployment guide.

## Command reference [\#](https://flueframework.com/docs/cli/overview/\#command-reference)

| Command | Description |
| --- | --- |
| [`flue init`](https://flueframework.com/docs/cli/init/) | Create an initial `flue.config.ts`. |
| [`flue dev`](https://flueframework.com/docs/cli/dev/) | Start a watch-mode local development server. |
| [`flue connect`](https://flueframework.com/docs/cli/connect/) | Open an interactive local agent-instance connection. |
| [`flue run`](https://flueframework.com/docs/cli/run/) | Execute one workflow invocation locally. |
| [`flue logs`](https://flueframework.com/docs/cli/logs/) | Replay or follow workflow-run events from a running server. |
| [`flue build`](https://flueframework.com/docs/cli/build/) | Create deployable application artifacts. |
| [`flue add`](https://flueframework.com/docs/cli/add/) | Fetch sandbox, channel, or database installation blueprints for a coding agent. |
| [`flue update`](https://flueframework.com/docs/cli/update/) | Fetch a current blueprint so a coding agent can apply its newer upgrade guides. |
| [`flue docs`](https://flueframework.com/docs/cli/docs/) | List, read, and search the bundled Flue documentation. |

## Docs Navigation

Current page: [CLI](https://flueframework.com/docs/cli/overview/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
