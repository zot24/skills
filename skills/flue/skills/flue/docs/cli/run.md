<!-- Source: https://flueframework.com/docs/cli/run -->

## Synopsis [\#](https://flueframework.com/docs/cli/run/\#synopsis)

```
flue run <workflow> [--target node] [--payload <json>] [--root <path>] [--output <path>] [--config <path>] [--env <path>]
```

## Description [\#](https://flueframework.com/docs/cli/run/\#description)

`flue run` builds the selected Node project and executes one discovered workflow locally. It uses private child-process communication, so the workflow does not need public HTTP exposure and application ingress middleware is not executed.

A workflow invocation is a finite run with a run ID. Use `flue connect` for interactive agent-instance sessions.

## Arguments [\#](https://flueframework.com/docs/cli/run/\#arguments)

| Argument | Description |
| --- | --- |
| `<workflow>` | Workflow module name to invoke. |

## Options [\#](https://flueframework.com/docs/cli/run/\#options)

| Option | Default | Description |
| --- | --- | --- |
| `--payload <json>` | `{}` | Supply the workflow payload as JSON. |
| `--target node` | Configuration value | Select the supported local execution target. |
| `--root <path>` | Selected config-file directory, or config search directory | Select the project root. |
| `--output <path>` | `<root>/dist` | Select the build output directory. |
| `--config <path>` | Auto-discovered `flue.config.*` | Select a configuration file. |
| `--env <path>` | `<config-base>/.env`, when present | Select one alternate `.env`-format file loaded before configuration. Relative paths resolve from `<config-base>`. Shell values win. |

## Output and events [\#](https://flueframework.com/docs/cli/run/\#output-and-events)

Build diagnostics are written to stdout before execution. Run identity and streamed events are written to stderr. A successful non-null terminal workflow result is written as formatted JSON to stdout.

The printed run ID identifies this workflow invocation in inline output and CI logs. The temporary child process owns its run record and streams events directly to the command. It does not publish run-inspection routes, and its history disappears when the command exits. Use `flue logs` only for runs owned by a selected running server.

## Target support [\#](https://flueframework.com/docs/cli/run/\#target-support)

`flue run` supports Node builds only. To exercise a Cloudflare-target workflow locally, start `flue dev --target cloudflare` and call its public ingress surface.

## Examples [\#](https://flueframework.com/docs/cli/run/\#examples)

```
flue run hello --target node
flue run summarize --target node --payload '{"text":"hello"}' --env .env.staging
```

See [Workflows](https://flueframework.com/docs/guide/workflows/) for authoring and invoking workflows.

## Docs Navigation

Current page: [flue run](https://flueframework.com/docs/cli/run/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
