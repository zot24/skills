> Source: https://flueframework.com/docs/cli/docs

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# flue docs


Last updated Jul 21, 2026<a href="/docs/cli/docs/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


## Synopsis

``` astro-code
flue docs
flue docs read <path>
flue docs search <query>
```

## Description

`flue docs` browses the documentation that ships inside the `@flue/cli` package — the same pages published on this site. With no arguments it lists every page (`<path> -- <title>`, one per line). `read` prints one page as markdown. `search` runs a full-text query and prints JSON results.

The command reads from the local installation and makes no network requests, so the content always matches the installed CLI version rather than the live website.

## flue docs read

`flue docs read <path>` prints one page to stdout as markdown. `<path>` accepts the catalog path as printed by the listing (`guide/sandboxes`), the website URL or absolute path (`https://flueframework.com/docs/guide/sandboxes/`, `/docs/guide/sandboxes/`), or the source filename (`guide/sandboxes.md`).

## flue docs search

`flue docs search <query>` searches page titles, headings, descriptions, and body text. Everything after `search` is joined into a single query, so quoting a multi-word query is optional. Results print to stdout as JSON, best match first (at most 8):

``` astro-code
{
  "query": "durable execution",
  "results": [
    {
      "path": "guide/durability",
      "title": "Durability",
      "description": "The accepted-work contract — what survives crashes, restarts, and redeploys...",
      "excerpt": "Durability is Flue's contract for accepted work: once an input is admitted…",
      "score": 35.8
    }
  ]
}
```

Pass a result’s `path` to `flue docs read`.

## Examples

``` astro-code
# List every page with its path and description
flue docs

# Print one page as markdown
flue docs read guide/sandboxes

# Search, then read the top result
flue docs search durable execution
flue docs read guide/durability
```

For coding agents, the typical loop is `flue docs search <query>` to find a page, then `flue docs read <path>` to read it.

See the [CLI overview](/docs/cli/overview/) for the other `flue` commands.


## Docs Navigation

Current page: [flue docs](/docs/cli/docs/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


