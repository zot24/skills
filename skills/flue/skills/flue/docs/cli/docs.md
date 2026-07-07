> Source: https://flueframework.com/docs/cli/docs

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# flue docs


Last updated Jun 9, 2026 <a href="/docs/cli/docs/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


## Synopsis

``` astro-code
flue docs
flue docs read <path>
flue docs search <query>
```

## Description

`flue docs` works with the documentation bundled inside the installed `@flue/cli` package. It requires no network access, and its content always matches the installed CLI version.

With no arguments, the command prints usage hints and the full page catalog. `read` prints one page as Markdown. `search` prints ranked results as JSON.

The catalog, page Markdown, and search JSON print to stdout; usage hints and errors print to stderr.

## Subcommands

| Subcommand       | Description                                         |
|------------------|-----------------------------------------------------|
| *(none)*         | List every documentation page with path and title.  |
| `read <path>`    | Print one documentation page as Markdown.           |
| `search <query>` | Search the documentation and print results as JSON. |

## Page paths

`read` accepts the catalog path as printed by `flue docs`, plus equivalent website forms:

``` astro-code
flue docs read guide/sandboxes
flue docs read /docs/guide/sandboxes/
flue docs read https://flueframework.com/docs/guide/sandboxes/
```

Unknown pages exit with status `1`.

## Search output

`search` joins multiple arguments into one query and prints the top eight matches:

``` astro-code
{
  "query": "durable execution",
  "results": [
    {
      "path": "concepts/durable-execution",
      "title": "Durable Agents",
      "description": "Understand how Flue agents and workflows handle server restarts, interrupted connections, and other disruptions.",
      "excerpt": "Durable execution is about recovering safely when running work is disrupted by a server restart, deployment, lost connec…",
      "score": 138.34
    }
  ]
}
```

## Examples

``` astro-code
flue docs
flue docs read guide/sandboxes
flue docs search "durable execution"
flue docs search sandbox adapter
```

For coding agents, the typical loop is `flue docs search <query>` to find a page, then `flue docs read <path>` to read it.


## Docs Navigation

Current page: [flue docs](/docs/cli/docs/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


