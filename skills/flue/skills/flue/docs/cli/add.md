<!-- Source: https://flueframework.com/docs/cli/add -->

## Synopsis [\#](https://flueframework.com/docs/cli/add/\#synopsis)

```
flue add
flue add <kind> <name-or-url> [--print]
```

## Description [\#](https://flueframework.com/docs/cli/add/\#description)

`flue add` fetches a Markdown implementation blueprint for a coding agent. It does not install packages or write project files itself.

With no arguments, the command lists known blueprints. With a kind and known name, it fetches that blueprint. With a kind and absolute URL, it fetches the generic blueprint for that kind and uses the URL as the coding agent’s research starting point. Paths are not accepted.

## Arguments [\#](https://flueframework.com/docs/cli/add/\#arguments)

| Argument | Description |
| --- | --- |
| `<kind>` | Blueprint kind: `sandbox`, `channel`, `database`, or `tooling`. |
| `<name-or-url>` | Known blueprint slug or alias, or an absolute URL used as a research starting point. |

## Options [\#](https://flueframework.com/docs/cli/add/\#options)

| Option | Description |
| --- | --- |
| `--print` | Write raw blueprint Markdown to stdout regardless of coding-agent detection. |

## Blueprint kinds [\#](https://flueframework.com/docs/cli/add/\#blueprint-kinds)

| Kind | Description |
| --- | --- |
| `sandbox` | Build a sandbox adapter from provider documentation or source. |
| `channel` | Add verified provider ingress, a client, and app-owned tools. |
| `database` | Add a database-backed persistence adapter. |
| `tooling` | Add developer tooling such as observability or evaluation. |

Run `flue add` without arguments to list the currently known blueprints.

## Examples [\#](https://flueframework.com/docs/cli/add/\#examples)

```
flue add
flue add sandbox daytona --print
flue add sandbox daytona --print | claude
flue add channel github --print | codex
flue add channel stripe --print | codex
flue add channel notion --print | codex
flue add channel resend --print | codex
flue add channel shopify --print | codex
flue add channel intercom --print | codex
flue add channel zendesk --print | codex
flue add channel salesforce-marketing-cloud --print | codex
flue add channel slack --print | codex
flue add channel discord --print | codex
flue add channel teams --print | codex
flue add channel google-chat --print | codex
flue add channel linear --print | codex
flue add channel telegram --print | codex
flue add channel whatsapp --print | codex
flue add channel twilio --print | codex
flue add channel messenger --print | codex
flue add sandbox @cloudflare/shell --print | opencode
flue add database postgres --print | codex
flue add tooling braintrust --print | opencode
flue add tooling sentry --print | opencode
flue add sandbox https://e2b.dev --print | claude
flue add channel https://provider.example/webhooks --print | codex
flue add database https://database.example/docs --print | codex
flue add tooling https://tool.example/docs --print | opencode
```

See [Sandboxes](https://flueframework.com/docs/guide/sandboxes/), [Channels](https://flueframework.com/docs/guide/channels/), and the [Ecosystem](https://flueframework.com/docs/ecosystem/) for implementation guidance.

## Docs Navigation

Current page: [flue add](https://flueframework.com/docs/cli/add/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
