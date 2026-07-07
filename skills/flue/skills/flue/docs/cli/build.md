> Source: https://flueframework.com/docs/cli/build

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# flue build


Last updated May 30, 2026 <a href="/docs/cli/build/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


## Synopsis

``` astro-code
flue build [--target <node|cloudflare>] [--root <path>] [--output <path>] [--config <path>] [--env <path>]
```

## Description

`flue build` discovers agents, workflows, and an optional application entrypoint under the selected source root, then writes target-specific deployment output.

For source discovery rules, see [Project Layout](/docs/guide/project-layout/).

## Options

| Option                       | Default                                                    | Description                                                                                                                         |
|------------------------------|------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| `--target <node|cloudflare>` | Configuration value                                        | Select the build target. Required unless supplied by configuration.                                                                 |
| `--root <path>`              | Selected config-file directory, or config search directory | Select the project root.                                                                                                            |
| `--output <path>`            | `<root>/dist`                                              | Select the build output directory.                                                                                                  |
| `--config <path>`            | Auto-discovered `flue.config.*`                            | Select a configuration file.                                                                                                        |
| `--env <path>`               | `<config-base>/.env`, when present                         | Select one alternate `.env`-format file loaded before configuration. Relative paths resolve from `<config-base>`. Shell values win. |

## Node.js output

A Node build writes a runnable server artifact:

``` astro-code
<output>/server.mjs
```

See [Deploy on Node.js](/docs/ecosystem/deploy/node/) for runtime dependencies and deployment setup.

## Cloudflare output

A Cloudflare build writes a Workers-compatible application through the official Cloudflare Vite integration. Flue prepares generated Worker and Wrangler input files without rewriting the project’s authored Wrangler configuration. Durable Object migration history remains in the project-root Wrangler config and passes through unchanged.

See [Deploy on Cloudflare](/docs/ecosystem/deploy/cloudflare/) for bindings and deployment setup.

## Examples

``` astro-code
flue build --target node
flue build --target cloudflare --root ./my-app
flue build --target node --output ./build
```


## Docs Navigation

Current page: [flue build](/docs/cli/build/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


