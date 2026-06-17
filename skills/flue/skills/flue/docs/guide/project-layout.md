<!-- Source: https://flueframework.com/docs/guide/project-layout -->

Flue discovers application entrypoints from your project’s source directory. Use `src/` for new projects, with `app.ts`, `cloudflare.ts`, `agents/`, `workflows/`, and `channels/` defining the application surfaces Flue builds.

## Example project layout [\#](https://flueframework.com/docs/guide/project-layout/\#example-project-layout)

```
my-project/
├─ package.json
├─ flue.config.ts
├─ src/
│  ├─ app.ts
│  ├─ cloudflare.ts
│  ├─ agents/
│  │  └─ support-assistant.ts
│  ├─ workflows/
│  │  └─ summarize-ticket.ts
│  └─ channels/
│     └─ github.ts
└─ dist/
```

Organize supporting application code however you prefer inside `src/`. The files and directories below are the parts of your application that Flue discovers and builds automatically.

## Important files and directories [\#](https://flueframework.com/docs/guide/project-layout/\#important-files-and-directories)

| Path | Purpose | Learn more |
| --- | --- | --- |
| `app.ts` | Optional entrypoint for composing Flue with your application’s routes and middleware. | [Routing](https://flueframework.com/docs/guide/routing/) |
| `cloudflare.ts` | Optional Cloudflare-only module for Worker exports and non-HTTP handlers. | [Cloudflare](https://flueframework.com/docs/ecosystem/deploy/cloudflare/#extending-the-worker) |
| `agents/` | Addressable agents that can receive continuing interactions over time. | [Agents](https://flueframework.com/docs/guide/building-agents/) |
| `workflows/` | Finite operations that receive input and return a result. | [Workflows](https://flueframework.com/docs/guide/workflows/) |
| `channels/` | Verified provider HTTP ingress discovered by filename. | [Channels](https://flueframework.com/docs/guide/channels/) |

### `app.ts` [\#](https://flueframework.com/docs/guide/project-layout/\#appts)

`app.ts` is an optional custom application entrypoint. Add it when your server needs to compose Flue routes with application behavior such as authentication, webhooks, health endpoints, or a route prefix. A project without `app.ts` uses Flue’s generated application directly.

For more information, see [Routing](https://flueframework.com/docs/guide/routing/).

### `cloudflare.ts` [\#](https://flueframework.com/docs/guide/project-layout/\#cloudflarets)

`cloudflare.ts` is an optional Cloudflare-only deployment module. Its named exports become top-level Worker exports, and its optional default export adds non-HTTP Worker handlers. Use it for same-Worker Durable Object classes, explicit Cloudflare Sandbox aliases, queue consumers, scheduled handlers, and other Cloudflare-native additions. Custom HTTP handling remains in `app.ts`.

For more information, see [Deploy on Cloudflare](https://flueframework.com/docs/ecosystem/deploy/cloudflare/#extending-the-worker).

### `agents/` [\#](https://flueframework.com/docs/guide/project-layout/\#agents)

The `agents/` directory contains agents that Flue can address by name. Each immediate file defines one discovered agent, and its filename becomes the agent name: `src/agents/support-assistant.ts` is discovered as `support-assistant`.

Keep agent files flat inside `agents/`; nested files are not discovered as additional agents. Prefer lower-kebab-case filenames such as `support-assistant.ts` so names remain portable across deployment targets.

For more information, see [Agents](https://flueframework.com/docs/guide/building-agents/).

### `workflows/` [\#](https://flueframework.com/docs/guide/project-layout/\#workflows)

The `workflows/` directory contains finite operations that Flue can invoke by name. Each immediate file defines one discovered workflow, and its filename becomes the workflow name: `src/workflows/summarize-ticket.ts` is discovered as `summarize-ticket`.

Keep workflow files flat inside `workflows/`; nested files are not discovered as additional workflows. Prefer lower-kebab-case filenames such as `summarize-ticket.ts` so names remain portable across deployment targets.

For more information, see [Workflows](https://flueframework.com/docs/guide/workflows/).

### `channels/` [\#](https://flueframework.com/docs/guide/project-layout/\#channels)

The `channels/` directory contains provider HTTP integrations. Each immediate
file must export one named `channel` binding. Its filename becomes an immutable
namespace: `src/channels/github.ts` publishes provider-declared routes beneath
`/channels/github`.

Nested files are ordinary support modules and are not discovered as channels.
Every route has a provider-owned non-empty suffix such as `/webhook`, `/events`,
or `/interactions`; `/channels/github` itself is not an endpoint.

For more information, see [Channels](https://flueframework.com/docs/guide/channels/).

## Source directory [\#](https://flueframework.com/docs/guide/project-layout/\#source-directory)

`src/` is the canonical source directory for new Flue projects. When integrating Flue into another application or maintaining an existing layout, authored modules may instead live in `.flue/` or at the project root. Flue selects one source directory in this order:

1. `.flue/` — A self-contained Flue source area inside a larger application.
2. `src/` **(Recommended)** — The recommended layout for new projects.
3. The project root — A compact layout for small dedicated projects.

The first matching directory wins. Flue does not merge layouts: when `.flue/` exists, it does not discover agents, workflows, channels, `app.ts`, or `cloudflare.ts` from `src/` or the project root. Authored modules may still import ordinary supporting code from elsewhere in the project.

The source directory is always discovered relative to your project root. To configure the project root, see [Configuration](https://flueframework.com/docs/reference/configuration/).

## Output directory [\#](https://flueframework.com/docs/guide/project-layout/\#output-directory)

`dist/` is the default output directory for generated build artifacts. It is created at the project root when you build the application and is never part of authored source discovery.

To change where generated artifacts are written, set `output` in `flue.config.ts`:

```
import { defineConfig } from '@flue/cli/config';

export default defineConfig({
  output: './build',
});
```

For more information about project and output configuration, see [Configuration](https://flueframework.com/docs/reference/configuration/).

## Docs Navigation

Current page: [Project Layout](https://flueframework.com/docs/guide/project-layout/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
