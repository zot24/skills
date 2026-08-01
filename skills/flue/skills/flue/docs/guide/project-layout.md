> Source: https://flueframework.com/docs/guide/project-layout

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Project Layout


Last updated Jul 21, 2026<a href="/docs/guide/project-layout/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


Flue has few required conventions for file and folder layout. The examples below show the recommended structure for single- and multi-agent projects.

## Example agent codebase

``` astro-code
my-project/
├─ src/                  # Source directory
│  ├─ app.ts             # Server and router entrypoint (required)
│  ├─ db.ts              # Database configuration (optional)
│  ├─ cloudflare.ts      # Cloudflare-specific entrypoint (optional)
│  ├─ agent.ts
│  ├─ skills/...
│  ├─ tools/...
│  ├─ subagents/...
│  └─ channels/...
├─ package.json          # npm project configuration
├─ vite.config.ts        # Vite configuration (optional)
└─ flue.config.ts        # Flue project configuration (optional)
```

## Example multi-agent codebase

``` astro-code
my-project/
├─ src/                  # Source directory
│  ├─ app.ts             # Server and router entrypoint (required)
│  ├─ db.ts              # Database configuration (optional)
│  ├─ cloudflare.ts      # Cloudflare-specific entrypoint (optional)
│  └─ agents/
│     ├─ support-agent/
│     │  ├─ skills/...
│     │  ├─ tools/...
│     │  ├─ subagents/...
│     │  ├─ channels/...
│     │  └─ agent.ts
│     ├─ triage-agent/
│     └─ shared/
├─ package.json          # npm project configuration
├─ vite.config.ts        # Vite configuration (optional)
└─ flue.config.ts        # Flue project configuration (optional)
```

## Top-level files

| Path                                                                                    | Purpose                                                |
|-----------------------------------------------------------------------------------------|--------------------------------------------------------|
| [`flue.config.ts`](/docs/reference/configuration/)                                      | Flue project configuration. Optional.                  |
| [`vite.config.ts`](/docs/guide/deploy/)                                                 | Vite build & dev server configuration. Optional.       |
| [`src/app.ts`](/docs/guide/routing/)                                                    | Application route map and server entrypoint. Required. |
| [`src/db.ts`](/docs/guide/database/)                                                    | Database configuration. Optional.                      |
| [`src/cloudflare.ts`](/docs/guide/cloudflare-target/#extending-cloudflarets-entrypoint) | Cloudflare entrypoint configuration. Optional.         |

## Source directory

`src/` is the canonical source directory for new Flue projects. When integrating Flue into another application or maintaining an existing layout, authored modules may instead live in `.flue/` or at the project root. Flue selects one source directory in this order:

1.  `.flue/` — A self-contained Flue source area inside a larger application.
2.  `src/` **(Recommended)** — The recommended layout for new projects.
3.  The project root — A compact layout for small dedicated projects.

The first matching directory wins. Flue does not merge layouts: when `.flue/` exists, `app.ts`, `db.ts`, `cloudflare.ts`, and the `'use agent'` scan are resolved from it, not from `src/` or the project root. Authored modules may still import ordinary supporting code from elsewhere in the project.

Entry module paths (`app.ts`, `db.ts`, `cloudflare.ts`) can be configured explicitly in your `flue.config.ts` file. See [Configuration](/docs/reference/configuration/) for more details.

## Generated output

`dist/` is the default build output directory when you run `vite build`. You can customize this in your `vite.config.ts` file.


## Docs Navigation

Current page: [Project Layout](/docs/guide/project-layout/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


