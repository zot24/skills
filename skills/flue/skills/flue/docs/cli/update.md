> Source: https://flueframework.com/docs/cli/update



# flue update


Last updated Jun 14, 2026 <a href="/docs/cli/update/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


## Synopsis

``` astro-code
flue update <kind> <name-or-url> [--print]
```

## Description

`flue update` fetches the same complete, current Markdown blueprint as [`flue add`](/docs/cli/add/). It does not edit project files itself.

Most integrations have a primary generated file with a marker identifying the blueprint version that produced it:

``` astro-code
// flue-blueprint: kind/name@N
```

Give the fetched blueprint to a coding agent. How the agent updates the integration depends on the argument:

- **Named update with a marker:** The agent applies each cumulative, versioned unified diff after the marked version in ascending order, preserves customizations, and updates the marker.
- **Named update without a marker:** The agent inspects the existing implementation, compares it against the complete current blueprint, applies every relevant change while preserving customizations, then adds the current marker when the blueprint has a primary marked file. If the blueprint has no primary marked file, comparison remains the durable update path; the agent does not invent a marker in an auxiliary or deployment file.
- **URL update:** The CLI returns the refreshed generic blueprint with the URL as a research starting point; it does not compare or edit the implementation. Because there is no provider-specific version history, the agent inspects the current implementation, compares it with the complete generic guide, the provider’s current primary source, and the current Flue contract, then infers and applies only relevant changes while preserving customizations. It adds or updates a marker only when the guide defines a primary marked file.

## Arguments

| Argument | Description |
|----|----|
| `<kind>` | Blueprint kind: `sandbox`, `channel`, `database`, or `tooling`. |
| `<name-or-url>` | Known blueprint slug or alias, or an absolute URL used as a research starting point. |

## Options

| Option | Description |
|----|----|
| `--print` | Write raw blueprint Markdown to stdout, matching [`flue add`](/docs/cli/add/). |

## Examples

``` astro-code
flue update channel slack
flue update sandbox daytona --print | codex
flue update channel https://provider.example/webhooks --print | claude
```


## Docs Navigation

Current page: [flue update](/docs/cli/update/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


