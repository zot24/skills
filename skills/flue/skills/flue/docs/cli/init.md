> Source: https://flueframework.com/docs/cli/init

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# flue init


Last updated Jul 21, 2026<a href="/docs/cli/init/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


## Synopsis

``` astro-code
flue init [directory] [--target <node|cloudflare>] [--deploy] [--force]
```

## Description

`flue init` scaffolds a complete Flue project skeleton: `flue.config.ts`, `package.json`, TypeScript setup, a Hello agent, and — depending on your choices — the HTTP server files. Two choices shape the skeleton: the build target (`node` or `cloudflare`) and whether to include the HTTP server setup. Both are resolved from flags when passed, and prompted for interactively otherwise.

`[directory]` is the directory to scaffold into, resolved from the current working directory and created (with parents) when it does not exist. It defaults to the current directory. The directory’s basename, lowercased and restricted to `[a-z0-9-]`, becomes the `package.json` name and (for the Cloudflare target) the Worker name; a basename with no valid characters falls back to `my-flue-app`.

`flue init` writes files only — it does not install dependencies. The printed next steps (and the generated README) begin with `npm install`.

## Options

| Option              | Description                                                                                                                                                                                                                            |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `--target <target>` | Build target: `node` or `cloudflare`. When omitted, `flue init` prompts for it; without a terminal, omitting it is an error. Any other value is rejected: `Invalid target: "bogus". Supported targets: node, cloudflare`.              |
| `--deploy`          | Include the HTTP server setup (`vite.config.ts`, `src/app.ts`, and the Hono and Vite dependencies). Off by default for the `node` target. The `cloudflare` target always deploys, so `--target cloudflare` implies `--deploy`.         |
| `--root <path>`     | Directory to scaffold into; identical to the positional argument. Passing both is rejected: `Pass the directory as an argument or with --root, not both.`                                                                              |
| `--force`           | Scaffold into a non-empty directory without confirmation, and overwrite every file in the skeleton that already exists (including `flue.config.*`). Without `--force`, an existing file is left alone and reported as “kept existing”. |

A flag may be passed at most once (`--target may only be passed once.`). Unknown flags, extra positional arguments, and arguments after a bare `--` are rejected.

## Generated files

Every skeleton contains:

- `flue.config.ts`
- `package.json`
- `tsconfig.json`
- `.gitignore`
- `.env`
- `src/agents/hello.ts`
- `AGENTS.md`
- `README.md`
- `vite.config.ts` (`--deploy` only)
- `src/app.ts` (`--deploy` only)
- `src/db.ts` (Node only)
- `src/cloudflare.ts` (Cloudflare only)

## Examples

``` astro-code
flue init                                  # prompt for everything, scaffold into the current directory
flue init ./my-agent-app                   # prompt, scaffold into ./my-agent-app (created if missing)
flue init --target node                    # local-run skeleton, no prompts
flue init --target node --deploy           # Node server skeleton
flue init ./bot --target cloudflare        # Cloudflare skeleton (--deploy implied)
flue init --target node --force            # scaffold into a non-empty directory, overwrite flue.config.*
```


## Docs Navigation

Current page: [flue init](/docs/cli/init/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


