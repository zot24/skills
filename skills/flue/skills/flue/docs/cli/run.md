> Source: https://flueframework.com/docs/cli/run

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# flue run


Last updated Jun 22, 2026 <a href="/docs/cli/run/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


## Synopsis

``` astro-code
flue run <name> [--target <node|cloudflare>] [--id <id>] [--input <json>] [--server <path|url>] [--header 'Name: value'] [--root <path>] [--output <path>] [--config <path>] [--env <path>]
```

## Description

`flue run` executes one discovered agent prompt or workflow invocation, streams its activity, prints the terminal result, and exits. With no absolute `--server`, it starts a temporary Node.js or Cloudflare HTTP runtime and calls the resource through the normal application.

The authored `app.ts`, outer middleware, and authored resource middleware run as they do for an HTTP caller. The temporary runtime also makes route-free discovered resources available through an existing authored `flue()` mount, without changing authored metadata or deployment output. It does not create a mount or bypass application composition.

## Resource names

`<name>` may identify an agent or workflow. If both kinds use the same name, qualify it:

``` astro-code
flue run agent:report --input '{"message":"Prepare the report."}'
flue run workflow:report --input '{"period":"week"}'
```

An absolute `--server` always requires `agent:<name>` or `workflow:<name>` because no local project is available for discovery.

## Input and identity

Agent `--input` is required and uses the public prompt body:

``` astro-code
{ "message": "Summarize the open issues." }
```

It may also include the public `images` field. `--id` selects the persistent agent-instance ID. If omitted, Flue generates and displays a bare ULID. Reusing an ID resumes persisted state only when the configured persistence adapter survives the temporary process.

Workflow `--input` is parsed as JSON and passed unchanged. It may be omitted when the workflow accepts omitted input. Workflow `--id` is not supported; workflows use their generated run IDs.

## Server and headers

`--server` selects the Flue base URL:

``` astro-code
flue run summarize --server /api/flue --input '{"text":"hello"}'
flue run workflow:summarize --server https://example.com/api/flue --input '{"text":"hello"}'
```

A path starts a temporary local runtime and points the SDK at that authored `flue()` mount. An absolute URL attaches to an existing local or deployed application and skips local configuration, discovery, build, and startup. `--server` never creates, moves, or alters routes; a wrong path receives the application’s normal response.

Repeat `--header` to send authentication or application context on admission, stream reads, and reconnects:

``` astro-code
flue run report --header 'Authorization: Bearer ...'
```

For repeated header names, the final value wins case-insensitively.

## Project options

| Option            | Default                                                    | Description                                                                                                                         |
|-------------------|------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| `--target <name>` | Configuration value                                        | Select `node` or `cloudflare` for a temporary local runtime.                                                                        |
| `--root <path>`   | Selected config-file directory, or config search directory | Select the project root.                                                                                                            |
| `--output <path>` | `<root>/dist`                                              | Configure deployment build output. Temporary Node execution does not write runtime artifacts there.                                 |
| `--config <path>` | Auto-discovered `flue.config.*`                            | Select a configuration file.                                                                                                        |
| `--env <path>`    | `<config-base>/.env`, when present                         | Select one alternate `.env`-format file loaded before configuration. Relative paths resolve from `<config-base>`. Shell values win. |

These project options are not resolved for an absolute `--server` attachment.

## Output and target support

Run identity and streamed events are written to stderr. A successful non-null terminal result is written as formatted JSON to stdout. The temporary runtime stops after settlement and does not watch or reload source files.

Local execution supports both Node.js and Cloudflare. Cloudflare uses the normal local Vite/workerd runtime and its persisted development state.

## Examples

``` astro-code
flue run assistant --input '{"message":"Draft a release summary."}'
flue run summarize --target cloudflare --input '{"text":"hello"}' --env .env.staging
```


## Docs Navigation

Current page: [flue run](/docs/cli/run/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


