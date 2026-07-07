> Source: https://flueframework.com/docs/cli/init

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# flue init


Last updated May 30, 2026 <a href="/docs/cli/init/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


## Synopsis

``` astro-code
flue init --target <node|cloudflare> [--root <path>] [--force]
```

## Description

`flue init` writes a starter `flue.config.ts`. It does not create agents, workflows, or an application entrypoint.

## Options

| Option                       | Default                   | Description                                                        |
|------------------------------|---------------------------|--------------------------------------------------------------------|
| `--target <node|cloudflare>` | Required                  | Select the target written to `flue.config.ts`.                     |
| `--root <path>`              | Current working directory | Select the existing directory in which to write `flue.config.ts`.  |
| `--force`                    | `false`                   | Write `flue.config.ts` when a `flue.config.*` file already exists. |

Without `--force`, any existing `flue.config.*` file prevents generation. If `--force` writes `flue.config.ts` beside another supported variant, the new `.ts` file takes precedence and the existing file remains on disk.

## Output

The generated `target` value matches `--target`. For `flue init --target node`, the file is:

``` astro-code
import { defineConfig } from '@flue/cli/config';

export default defineConfig({
  target: 'node',
});
```

## Examples

``` astro-code
flue init --target node
flue init --target cloudflare --root ./apps/assistant
```

See [Configuration](/docs/reference/configuration/) for the complete `flue.config.ts` surface.


## Docs Navigation

Current page: [flue init](/docs/cli/init/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


