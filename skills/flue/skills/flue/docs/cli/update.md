> Source: https://flueframework.com/docs/cli/update



# flue update


Last updated Jul 21, 2026<a href="/docs/cli/update/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


## Synopsis

``` astro-code
flue update <kind> <name|url> [--print]
```

## Description

`flue update` fetches the Markdown implementation guide for a blueprint, for piping to a coding agent that will bring an existing integration up to the current blueprint version. The command does not inspect or modify your project — the guide carries the update instructions, including how to compare the existing integration against the current blueprint and preserve customizations.

[`flue add`](/docs/cli/add/) emits the same guide; the two commands differ only in intent and argument handling (`flue update` requires both arguments, while `flue add` alone lists the catalog). Output behavior matches `flue add`: the guide prints to stdout for coding agents or with `--print`.

## Arguments

| Argument | Description |
|----|----|
| `<kind>` | The integration category: `channel`, `database`, `sandbox`, or `tooling`. |
| `<name|url>` | A blueprint name matched within the kind, or an absolute URL to provider documentation for the build-from-scratch guide. |

## Options

| Option | Description |
|----|----|
| `--print` | Write the blueprint Markdown to stdout regardless of coding-agent detection. |

## Examples

``` astro-code
flue update channel slack --print | claude
flue update database mysql --print | codex
flue update sandbox @cloudflare/computer --print | opencode
flue update channel https://developers.notion.com/reference/webhooks --print | claude
```


## Docs Navigation

Current page: [flue update](/docs/cli/update/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


