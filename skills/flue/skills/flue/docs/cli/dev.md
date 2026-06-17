<!-- Source: https://flueframework.com/docs/cli/dev -->

## Synopsis [\#](https://flueframework.com/docs/cli/dev/\#synopsis)

```
flue dev [--target <node|cloudflare>] [--root <path>] [--output <path>] [--config <path>] [--port <number>] [--env <path>]
```

## Description [\#](https://flueframework.com/docs/cli/dev/\#description)

`flue dev` builds the selected project, starts a local server, watches project files, and reloads after relevant changes. Editing, creating, or deleting an auto-discovered `flue.config.*` file restarts the local development session with freshly resolved configuration. Explicit `--config <path>` files are watched even when they live outside the project root. A configuration restart interrupts active local requests and streaming connections. When an edited configuration is invalid, the command waits for the next configuration change and starts a new session after the error is corrected.

## Options [\#](https://flueframework.com/docs/cli/dev/\#options)

| Option | Default | Description |
| --- | --- | --- |
| `--target <node|cloudflare>` | Configuration value | Select the development target. Required unless supplied by configuration. |
| `--root <path>` | Selected config-file directory, or config search directory | Select the project root. |
| `--output <path>` | `<root>/dist` | Select the build output directory. |
| `--config <path>` | Auto-discovered `flue.config.*` | Select a configuration file. |
| `--port <number>` | `3583` | Select the local server port. |
| `--env <path>` | `<config-base>/.env`, when present | Select one alternate `.env`-format file loaded before configuration. Relative paths resolve from `<config-base>`. Shell values win. |

## Target-specific behavior [\#](https://flueframework.com/docs/cli/dev/\#target-specific-behavior)

### Node.js [\#](https://flueframework.com/docs/cli/dev/\#nodejs)

Builds the Node artifact, starts the generated server, and rebuilds and respawns it after relevant file changes.

### Cloudflare [\#](https://flueframework.com/docs/cli/dev/\#cloudflare)

Starts Vite with the official Workers integration. Cloudflare runtime bindings continue to use the official `.dev.vars`, `.env`, and `CLOUDFLARE_ENV` conventions.

## Examples [\#](https://flueframework.com/docs/cli/dev/\#examples)

```
flue dev
flue dev --target node
flue dev --target cloudflare --port 8787
flue dev --env .env.staging
```

See the [CLI overview](https://flueframework.com/docs/cli/overview/) for the complete development workflow.

## Docs Navigation

Current page: [flue dev](https://flueframework.com/docs/cli/dev/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
