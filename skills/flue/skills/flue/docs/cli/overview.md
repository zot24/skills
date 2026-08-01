> Source: https://flueframework.com/docs/cli/overview

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# CLI


Last updated Jul 21, 2026<a href="/docs/cli/overview/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


The `flue` CLI ships in the `@flue/cli` package as a single `flue` binary. It scaffolds projects, runs one agent module locally, fetches integration blueprints, and reads the documentation bundled with your installed version.

The CLI is not the build tool. Dev servers and production builds are owned by [Vite](/docs/guide/deploy/): `vite dev` and `vite build`, with the `flue()` plugin from `@flue/vite` in `vite.config.ts`.

## Invocation

`@flue/cli` requires Node.js 22.19 or newer. [`flue init`](/docs/cli/init/) scaffolds it as a `devDependency`, and the [getting started guide](/docs/guide/getting-started/) installs it alongside `@flue/runtime`:

``` astro-code
npm install @flue/runtime @flue/cli
```

The `flue` bin is then available through your package manager’s runner (`npx flue`, `pnpm flue`, `yarn flue`) or from `package.json` scripts:

``` astro-code
npx flue run src/agents/assistant.ts -m "Say hello"
```

## Commands

- [`flue init [directory]`](/docs/cli/init/) — scaffold a starter Flue project, prompting for the build target and server setup when flags are omitted.
- [`flue run <path>`](/docs/cli/run/) — run one agent module locally without a server: submit one message, stream the turn, print the reply, exit.
- [`flue add [kind] [name|url]`](/docs/cli/add/) — fetch a blueprint implementation guide for a coding agent to follow; with no arguments, list the available blueprints.
- [`flue update <kind> <name|url>`](/docs/cli/update/) — fetch the same blueprint guide for updating an existing integration.
- [`flue docs [read|search]`](/docs/cli/docs/) — list the bundled documentation pages, print one as markdown, or search them.

Each command page is the reference for that command’s arguments, flags, and output. Every command prints its primary payload to stdout and everything else — prompts, streaming output, errors — to stderr, so piping stdout is always safe.

## Global flags

| Flag              | Description                                                                           |
|-------------------|---------------------------------------------------------------------------------------|
| `--help`, `-h`    | Print usage to stdout and exit 0. Works globally and per command (`flue run --help`). |
| `--version`, `-v` | Print the `@flue/cli` version to stdout and exit 0.                                   |

There are no other global flags; every command rejects flags it does not declare.


## Docs Navigation

Current page: [CLI](/docs/cli/overview/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


