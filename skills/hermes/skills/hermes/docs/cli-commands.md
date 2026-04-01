> Source: https://hermes-agent.nousresearch.com/docs/reference/cli-commands/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# CLI Commands Reference


This page covers the **terminal commands** you run from your shell.

For in-chat slash commands, see [Slash Commands Reference](/docs/reference/slash-commands).

## Global entrypoint<a href="#global-entrypoint" class="hash-link" aria-label="Direct link to Global entrypoint" translate="no" title="Direct link to Global entrypoint">​</a>


``` prism-code
hermes [global-options] <command> [subcommand/options]
```


### Global options<a href="#global-options" class="hash-link" aria-label="Direct link to Global options" translate="no" title="Direct link to Global options">​</a>

| Option                               | Description                                                                                                       |
|--------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| `--version`, `-V`                    | Show version and exit.                                                                                            |
| `--profile <name>`, `-p <name>`      | Select which Hermes profile to use for this invocation. Overrides the sticky default set by `hermes profile use`. |
| `--resume <session>`, `-r <session>` | Resume a previous session by ID or title.                                                                         |
| `--continue [name]`, `-c [name]`     | Resume the most recent session, or the most recent session matching a title.                                      |
| `--worktree`, `-w`                   | Start in an isolated git worktree for parallel-agent workflows.                                                   |
| `--yolo`                             | Bypass dangerous-command approval prompts.                                                                        |
| `--pass-session-id`                  | Include the session ID in the agent's system prompt.                                                              |

## Top-level commands<a href="#top-level-commands" class="hash-link" aria-label="Direct link to Top-level commands" translate="no" title="Direct link to Top-level commands">​</a>

| Command                   | Purpose                                                           |
|---------------------------|-------------------------------------------------------------------|
| `hermes chat`             | Interactive or one-shot chat with the agent.                      |
| `hermes model`            | Interactively choose the default provider and model.              |
| `hermes gateway`          | Run or manage the messaging gateway service.                      |
| `hermes setup`            | Interactive setup wizard for all or part of the configuration.    |
| `hermes whatsapp`         | Configure and pair the WhatsApp bridge.                           |
| `hermes login` / `logout` | Authenticate with OAuth-backed providers.                         |
| `hermes auth`             | Manage credential pools — add, list, remove, reset, set strategy. |
| `hermes status`           | Show agent, auth, and platform status.                            |
| `hermes cron`             | Inspect and tick the cron scheduler.                              |
| `hermes webhook`          | Manage dynamic webhook subscriptions for event-driven activation. |
| `hermes doctor`           | Diagnose config and dependency issues.                            |
| `hermes config`           | Show, edit, migrate, and query configuration files.               |
| `hermes pairing`          | Approve or revoke messaging pairing codes.                        |
| `hermes skills`           | Browse, install, publish, audit, and configure skills.            |
| `hermes honcho`           | Manage Honcho cross-session memory integration.                   |
| `hermes acp`              | Run Hermes as an ACP server for editor integration.               |
| `hermes mcp`              | Manage MCP server configurations and run Hermes as an MCP server. |
| `hermes plugins`          | Manage Hermes Agent plugins (install, enable, disable, remove).   |
| `hermes tools`            | Configure enabled tools per platform.                             |
| `hermes sessions`         | Browse, export, prune, rename, and delete sessions.               |
| `hermes insights`         | Show token/cost/activity analytics.                               |
| `hermes claw`             | OpenClaw migration helpers.                                       |
| `hermes profile`          | Manage profiles — multiple isolated Hermes instances.             |
| `hermes completion`       | Print shell completion scripts (bash/zsh).                        |
| `hermes version`          | Show version information.                                         |
| `hermes update`           | Pull latest code and reinstall dependencies.                      |
| `hermes uninstall`        | Remove Hermes from the system.                                    |

## `hermes chat`<a href="#hermes-chat" class="hash-link" aria-label="Direct link to hermes-chat" translate="no" title="Direct link to hermes-chat">​</a>


``` prism-code
hermes chat [options]
```


Common options:

| Option                                     | Description                                                                                                                                                                      |
|--------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `-q`, `--query "..."`                      | One-shot, non-interactive prompt.                                                                                                                                                |
| `-m`, `--model <model>`                    | Override the model for this run.                                                                                                                                                 |
| `-t`, `--toolsets <csv>`                   | Enable a comma-separated set of toolsets.                                                                                                                                        |
| `--provider <provider>`                    | Force a provider: `auto`, `openrouter`, `nous`, `openai-codex`, `copilot-acp`, `copilot`, `anthropic`, `huggingface`, `zai`, `kimi-coding`, `minimax`, `minimax-cn`, `kilocode`. |
| `-s`, `--skills <name>`                    | Preload one or more skills for the session (can be repeated or comma-separated).                                                                                                 |
| `-v`, `--verbose`                          | Verbose output.                                                                                                                                                                  |
| `-Q`, `--quiet`                            | Programmatic mode: suppress banner/spinner/tool previews.                                                                                                                        |
| `--resume <session>` / `--continue [name]` | Resume a session directly from `chat`.                                                                                                                                           |
| `--worktree`                               | Create an isolated git worktree for this run.                                                                                                                                    |
| `--checkpoints`                            | Enable filesystem checkpoints before destructive file changes.                                                                                                                   |
| `--yolo`                                   | Skip approval prompts.                                                                                                                                                           |
| `--pass-session-id`                        | Pass the session ID into the system prompt.                                                                                                                                      |
| `--source <tag>`                           | Session source tag for filtering (default: `cli`). Use `tool` for third-party integrations that should not appear in user session lists.                                         |

Examples:


``` prism-code
hermes
hermes chat -q "Summarize the latest PRs"
hermes chat --provider openrouter --model anthropic/claude-sonnet-4.6
hermes chat --toolsets web,terminal,skills
hermes chat --quiet -q "Return only JSON"
hermes chat --worktree -q "Review this repo and open a PR"
```


## `hermes model`<a href="#hermes-model" class="hash-link" aria-label="Direct link to hermes-model" translate="no" title="Direct link to hermes-model">​</a>

Interactive provider + model selector.


``` prism-code
hermes model
```


Use this when you want to:

- switch default providers
- log into OAuth-backed providers during model selection
- pick from provider-specific model lists
- configure a custom/self-hosted endpoint
- save the new default into config

### `/model` slash command (mid-session)<a href="#model-slash-command-mid-session" class="hash-link" aria-label="Direct link to model-slash-command-mid-session" translate="no" title="Direct link to model-slash-command-mid-session">​</a>

Switch models without leaving a session:


``` prism-code
/model                              # Show current model and available options
/model claude-sonnet-4              # Switch model (auto-detects provider)
/model zai:glm-5                    # Switch provider and model
/model custom:qwen-2.5              # Use model on your custom endpoint
/model custom                       # Auto-detect model from custom endpoint
/model custom:local:qwen-2.5        # Use a named custom provider
/model openrouter:anthropic/claude-sonnet-4  # Switch back to cloud
```


Provider and base URL changes are persisted to `config.yaml` automatically. When switching away from a custom endpoint, the stale base URL is cleared to prevent it leaking into other providers.

## `hermes gateway`<a href="#hermes-gateway" class="hash-link" aria-label="Direct link to hermes-gateway" translate="no" title="Direct link to hermes-gateway">​</a>


``` prism-code
hermes gateway <subcommand>
```


Subcommands:

| Subcommand  | Description                                                         |
|-------------|---------------------------------------------------------------------|
| `run`       | Run the gateway in the foreground.                                  |
| `start`     | Start the installed gateway service.                                |
| `stop`      | Stop the service.                                                   |
| `restart`   | Restart the service.                                                |
| `status`    | Show service status.                                                |
| `install`   | Install as a user service (`systemd` on Linux, `launchd` on macOS). |
| `uninstall` | Remove the installed service.                                       |
| `setup`     | Interactive messaging-platform setup.                               |

## `hermes setup`<a href="#hermes-setup" class="hash-link" aria-label="Direct link to hermes-setup" translate="no" title="Direct link to hermes-setup">​</a>


``` prism-code
hermes setup [model|terminal|gateway|tools|agent] [--non-interactive] [--reset]
```


Use the full wizard or jump into one section:

| Section    | Description                         |
|------------|-------------------------------------|
| `model`    | Provider and model setup.           |
| `terminal` | Terminal backend and sandbox setup. |
| `gateway`  | Messaging platform setup.           |
| `tools`    | Enable/disable tools per platform.  |
| `agent`    | Agent behavior settings.            |

Options:

| Option              | Description                                        |
|---------------------|----------------------------------------------------|
| `--non-interactive` | Use defaults / environment values without prompts. |
| `--reset`           | Reset configuration to defaults before setup.      |

## `hermes whatsapp`<a href="#hermes-whatsapp" class="hash-link" aria-label="Direct link to hermes-whatsapp" translate="no" title="Direct link to hermes-whatsapp">​</a>


``` prism-code
hermes whatsapp
```


Runs the WhatsApp pairing/setup flow, including mode selection and QR-code pairing.

## `hermes login` / `hermes logout`<a href="#hermes-login--hermes-logout" class="hash-link" aria-label="Direct link to hermes-login--hermes-logout" translate="no" title="Direct link to hermes-login--hermes-logout">​</a>


``` prism-code
hermes login [--provider nous|openai-codex] [--portal-url ...] [--inference-url ...]
hermes logout [--provider nous|openai-codex]
```


`login` supports:

- Nous Portal OAuth/device flow
- OpenAI Codex OAuth/device flow

Useful options for `login`:

- `--no-browser`
- `--timeout <seconds>`
- `--ca-bundle <pem>`
- `--insecure`

## `hermes auth`<a href="#hermes-auth" class="hash-link" aria-label="Direct link to hermes-auth" translate="no" title="Direct link to hermes-auth">​</a>

Manage credential pools for same-provider key rotation. See [Credential Pools](/docs/user-guide/features/credential-pools) for full documentation.


``` prism-code
hermes auth                                              # Interactive wizard
hermes auth list                                         # Show all pools
hermes auth list openrouter                              # Show specific provider
hermes auth add openrouter --api-key sk-or-v1-xxx        # Add API key
hermes auth add anthropic --type oauth                   # Add OAuth credential
hermes auth remove openrouter 2                          # Remove by index
hermes auth reset openrouter                             # Clear cooldowns
```


Subcommands: `add`, `list`, `remove`, `reset`. When called with no subcommand, launches the interactive management wizard.

## `hermes status`<a href="#hermes-status" class="hash-link" aria-label="Direct link to hermes-status" translate="no" title="Direct link to hermes-status">​</a>


``` prism-code
hermes status [--all] [--deep]
```


| Option   | Description                                      |
|----------|--------------------------------------------------|
| `--all`  | Show all details in a shareable redacted format. |
| `--deep` | Run deeper checks that may take longer.          |

## `hermes cron`<a href="#hermes-cron" class="hash-link" aria-label="Direct link to hermes-cron" translate="no" title="Direct link to hermes-cron">​</a>


``` prism-code
hermes cron <list|create|edit|pause|resume|run|remove|status|tick>
```


| Subcommand       | Description                                                                                                                                        |
|------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| `list`           | Show scheduled jobs.                                                                                                                               |
| `create` / `add` | Create a scheduled job from a prompt, optionally attaching one or more skills via repeated `--skill`.                                              |
| `edit`           | Update a job's schedule, prompt, name, delivery, repeat count, or attached skills. Supports `--clear-skills`, `--add-skill`, and `--remove-skill`. |
| `pause`          | Pause a job without deleting it.                                                                                                                   |
| `resume`         | Resume a paused job and compute its next future run.                                                                                               |
| `run`            | Trigger a job on the next scheduler tick.                                                                                                          |
| `remove`         | Delete a scheduled job.                                                                                                                            |
| `status`         | Check whether the cron scheduler is running.                                                                                                       |
| `tick`           | Run due jobs once and exit.                                                                                                                        |

## `hermes webhook`<a href="#hermes-webhook" class="hash-link" aria-label="Direct link to hermes-webhook" translate="no" title="Direct link to hermes-webhook">​</a>


``` prism-code
hermes webhook <subscribe|list|remove|test>
```


Manage dynamic webhook subscriptions for event-driven agent activation. Requires the webhook platform to be enabled in config — if not configured, prints setup instructions.

| Subcommand          | Description                                                                           |
|---------------------|---------------------------------------------------------------------------------------|
| `subscribe` / `add` | Create a webhook route. Returns the URL and HMAC secret to configure on your service. |
| `list` / `ls`       | Show all agent-created subscriptions.                                                 |
| `remove` / `rm`     | Delete a dynamic subscription. Static routes from config.yaml are not affected.       |
| `test`              | Send a test POST to verify a subscription is working.                                 |

### `hermes webhook subscribe`<a href="#hermes-webhook-subscribe" class="hash-link" aria-label="Direct link to hermes-webhook-subscribe" translate="no" title="Direct link to hermes-webhook-subscribe">​</a>


``` prism-code
hermes webhook subscribe <name> [options]
```


| Option              | Description                                                                         |
|---------------------|-------------------------------------------------------------------------------------|
| `--prompt`          | Prompt template with `{dot.notation}` payload references.                           |
| `--events`          | Comma-separated event types to accept (e.g. `issues,pull_request`). Empty = all.    |
| `--description`     | Human-readable description.                                                         |
| `--skills`          | Comma-separated skill names to load for the agent run.                              |
| `--deliver`         | Delivery target: `log` (default), `telegram`, `discord`, `slack`, `github_comment`. |
| `--deliver-chat-id` | Target chat/channel ID for cross-platform delivery.                                 |
| `--secret`          | Custom HMAC secret. Auto-generated if omitted.                                      |

Subscriptions persist to `~/.hermes/webhook_subscriptions.json` and are hot-reloaded by the webhook adapter without a gateway restart.

## `hermes doctor`<a href="#hermes-doctor" class="hash-link" aria-label="Direct link to hermes-doctor" translate="no" title="Direct link to hermes-doctor">​</a>


``` prism-code
hermes doctor [--fix]
```


| Option  | Description                               |
|---------|-------------------------------------------|
| `--fix` | Attempt automatic repairs where possible. |

## `hermes config`<a href="#hermes-config" class="hash-link" aria-label="Direct link to hermes-config" translate="no" title="Direct link to hermes-config">​</a>


``` prism-code
hermes config <subcommand>
```


Subcommands:

| Subcommand          | Description                                 |
|---------------------|---------------------------------------------|
| `show`              | Show current config values.                 |
| `edit`              | Open `config.yaml` in your editor.          |
| `set <key> <value>` | Set a config value.                         |
| `path`              | Print the config file path.                 |
| `env-path`          | Print the `.env` file path.                 |
| `check`             | Check for missing or stale config.          |
| `migrate`           | Add newly introduced options interactively. |

## `hermes pairing`<a href="#hermes-pairing" class="hash-link" aria-label="Direct link to hermes-pairing" translate="no" title="Direct link to hermes-pairing">​</a>


``` prism-code
hermes pairing <list|approve|revoke|clear-pending>
```


| Subcommand                    | Description                      |
|-------------------------------|----------------------------------|
| `list`                        | Show pending and approved users. |
| `approve <platform> <code>`   | Approve a pairing code.          |
| `revoke <platform> <user-id>` | Revoke a user's access.          |
| `clear-pending`               | Clear pending pairing codes.     |

## `hermes skills`<a href="#hermes-skills" class="hash-link" aria-label="Direct link to hermes-skills" translate="no" title="Direct link to hermes-skills">​</a>


``` prism-code
hermes skills <subcommand>
```


Subcommands:

| Subcommand  | Description                                                      |
|-------------|------------------------------------------------------------------|
| `browse`    | Paginated browser for skill registries.                          |
| `search`    | Search skill registries.                                         |
| `install`   | Install a skill.                                                 |
| `inspect`   | Preview a skill without installing it.                           |
| `list`      | List installed skills.                                           |
| `check`     | Check installed hub skills for upstream updates.                 |
| `update`    | Reinstall hub skills with upstream changes when available.       |
| `audit`     | Re-scan installed hub skills.                                    |
| `uninstall` | Remove a hub-installed skill.                                    |
| `publish`   | Publish a skill to a registry.                                   |
| `snapshot`  | Export/import skill configurations.                              |
| `tap`       | Manage custom skill sources.                                     |
| `config`    | Interactive enable/disable configuration for skills by platform. |

Common examples:


``` prism-code
hermes skills browse
hermes skills browse --source official
hermes skills search react --source skills-sh
hermes skills search https://mintlify.com/docs --source well-known
hermes skills inspect official/security/1password
hermes skills inspect skills-sh/vercel-labs/json-render/json-render-react
hermes skills install official/migration/openclaw-migration
hermes skills install skills-sh/anthropics/skills/pdf --force
hermes skills check
hermes skills update
hermes skills config
```


Notes:

- `--force` can override non-dangerous policy blocks for third-party/community skills.
- `--force` does not override a `dangerous` scan verdict.
- `--source skills-sh` searches the public `skills.sh` directory.
- `--source well-known` lets you point Hermes at a site exposing `/.well-known/skills/index.json`.

## `hermes honcho`<a href="#hermes-honcho" class="hash-link" aria-label="Direct link to hermes-honcho" translate="no" title="Direct link to hermes-honcho">​</a>


``` prism-code
hermes honcho <subcommand>
```


Subcommands:

| Subcommand | Description                                              |
|------------|----------------------------------------------------------|
| `setup`    | Interactive Honcho setup wizard.                         |
| `status`   | Show current Honcho config and connection status.        |
| `sessions` | List known Honcho session mappings.                      |
| `map`      | Map the current directory to a Honcho session name.      |
| `peer`     | Show or update peer names and dialectic reasoning level. |
| `mode`     | Show or set memory mode: `hybrid`, `honcho`, or `local`. |
| `tokens`   | Show or set token budgets for context and dialectic.     |
| `identity` | Seed or show the AI peer identity representation.        |
| `migrate`  | Migration guide from openclaw-honcho to Hermes Honcho.   |

## `hermes acp`<a href="#hermes-acp" class="hash-link" aria-label="Direct link to hermes-acp" translate="no" title="Direct link to hermes-acp">​</a>


``` prism-code
hermes acp
```


Starts Hermes as an ACP (Agent Client Protocol) stdio server for editor integration.

Related entrypoints:


``` prism-code
hermes-acp
python -m acp_adapter
```


Install support first:


``` prism-code
pip install -e '.[acp]'
```


See [ACP Editor Integration](/docs/user-guide/features/acp) and [ACP Internals](/docs/developer-guide/acp-internals).

## `hermes mcp`<a href="#hermes-mcp" class="hash-link" aria-label="Direct link to hermes-mcp" translate="no" title="Direct link to hermes-mcp">​</a>


``` prism-code
hermes mcp <subcommand>
```


Manage MCP (Model Context Protocol) server configurations and run Hermes as an MCP server.

| Subcommand                                                                  | Description                                                         |
|-----------------------------------------------------------------------------|---------------------------------------------------------------------|
| `serve [-v|--verbose]`                                                      | Run Hermes as an MCP server — expose conversations to other agents. |
| `add <name> [--url URL] [--command CMD] [--args ...] [--auth oauth|header]` | Add an MCP server with automatic tool discovery.                    |
| `remove <name>` (alias: `rm`)                                               | Remove an MCP server from config.                                   |
| `list` (alias: `ls`)                                                        | List configured MCP servers.                                        |
| `test <name>`                                                               | Test connection to an MCP server.                                   |
| `configure <name>` (alias: `config`)                                        | Toggle tool selection for a server.                                 |

See [MCP Config Reference](/docs/reference/mcp-config-reference), [Use MCP with Hermes](/docs/guides/use-mcp-with-hermes), and [MCP Server Mode](/docs/user-guide/features/mcp#running-hermes-as-an-mcp-server).

## `hermes plugins`<a href="#hermes-plugins" class="hash-link" aria-label="Direct link to hermes-plugins" translate="no" title="Direct link to hermes-plugins">​</a>


``` prism-code
hermes plugins [subcommand]
```


Manage Hermes Agent plugins. Running `hermes plugins` with no subcommand launches an interactive curses checklist to enable/disable installed plugins.

| Subcommand                                   | Description                                                               |
|----------------------------------------------|---------------------------------------------------------------------------|
| *(none)*                                     | Interactive toggle UI — enable/disable plugins with arrow keys and space. |
| `install <identifier> [--force]`             | Install a plugin from a Git URL or `owner/repo`.                          |
| `update <name>`                              | Pull latest changes for an installed plugin.                              |
| `remove <name>` (aliases: `rm`, `uninstall`) | Remove an installed plugin.                                               |
| `enable <name>`                              | Enable a disabled plugin.                                                 |
| `disable <name>`                             | Disable a plugin without removing it.                                     |
| `list` (alias: `ls`)                         | List installed plugins with enabled/disabled status.                      |

Disabled plugins are stored in `config.yaml` under `plugins.disabled` and skipped during loading.

See [Plugins](/docs/user-guide/features/plugins) and [Build a Hermes Plugin](/docs/guides/build-a-hermes-plugin).

## `hermes tools`<a href="#hermes-tools" class="hash-link" aria-label="Direct link to hermes-tools" translate="no" title="Direct link to hermes-tools">​</a>


``` prism-code
hermes tools [--summary]
```


| Option      | Description                                       |
|-------------|---------------------------------------------------|
| `--summary` | Print the current enabled-tools summary and exit. |

Without `--summary`, this launches the interactive per-platform tool configuration UI.

## `hermes sessions`<a href="#hermes-sessions" class="hash-link" aria-label="Direct link to hermes-sessions" translate="no" title="Direct link to hermes-sessions">​</a>


``` prism-code
hermes sessions <subcommand>
```


Subcommands:

| Subcommand                          | Description                                        |
|-------------------------------------|----------------------------------------------------|
| `list`                              | List recent sessions.                              |
| `browse`                            | Interactive session picker with search and resume. |
| `export <output> [--session-id ID]` | Export sessions to JSONL.                          |
| `delete <session-id>`               | Delete one session.                                |
| `prune`                             | Delete old sessions.                               |
| `stats`                             | Show session-store statistics.                     |
| `rename <session-id> <title>`       | Set or change a session title.                     |

## `hermes insights`<a href="#hermes-insights" class="hash-link" aria-label="Direct link to hermes-insights" translate="no" title="Direct link to hermes-insights">​</a>


``` prism-code
hermes insights [--days N] [--source platform]
```


| Option                | Description                                               |
|-----------------------|-----------------------------------------------------------|
| `--days <n>`          | Analyze the last `n` days (default: 30).                  |
| `--source <platform>` | Filter by source such as `cli`, `telegram`, or `discord`. |

## `hermes claw`<a href="#hermes-claw" class="hash-link" aria-label="Direct link to hermes-claw" translate="no" title="Direct link to hermes-claw">​</a>


``` prism-code
hermes claw migrate [options]
```


Migrate your OpenClaw setup to Hermes. Reads from `~/.openclaw` (or a custom path) and writes to `~/.hermes`. Automatically detects legacy directory names (`~/.clawdbot`, `~/.moldbot`) and config filenames (`clawdbot.json`, `moldbot.json`).

| Option                      | Description                                                                              |
|-----------------------------|------------------------------------------------------------------------------------------|
| `--dry-run`                 | Preview what would be migrated without writing anything.                                 |
| `--preset <name>`           | Migration preset: `full` (default, includes secrets) or `user-data` (excludes API keys). |
| `--overwrite`               | Overwrite existing Hermes files on conflicts (default: skip).                            |
| `--migrate-secrets`         | Include API keys in migration (enabled by default with `--preset full`).                 |
| `--source <path>`           | Custom OpenClaw directory (default: `~/.openclaw`).                                      |
| `--workspace-target <path>` | Target directory for workspace instructions (AGENTS.md).                                 |
| `--skill-conflict <mode>`   | Handle skill name collisions: `skip` (default), `overwrite`, or `rename`.                |
| `--yes`                     | Skip the confirmation prompt.                                                            |

### What gets migrated<a href="#what-gets-migrated" class="hash-link" aria-label="Direct link to What gets migrated" translate="no" title="Direct link to What gets migrated">​</a>

The migration covers 30+ categories across persona, memory, skills, model providers, messaging platforms, agent behavior, session policies, MCP servers, TTS, and more. Items are either **directly imported** into Hermes equivalents or **archived** for manual review.

**Directly imported:** SOUL.md, MEMORY.md, USER.md, AGENTS.md, skills (4 source directories), default model, custom providers, MCP servers, messaging platform tokens and allowlists (Telegram, Discord, Slack, WhatsApp, Signal, Matrix, Mattermost), agent defaults (reasoning effort, compression, human delay, timezone, sandbox), session reset policies, approval rules, TTS config, browser settings, tool settings, exec timeout, command allowlist, gateway config, and API keys from 3 sources.

**Archived for manual review:** Cron jobs, plugins, hooks/webhooks, memory backend (QMD), skills registry config, UI/identity, logging, multi-agent setup, channel bindings, IDENTITY.md, TOOLS.md, HEARTBEAT.md, BOOTSTRAP.md.

**API key resolution** checks three sources in priority order: config values → `~/.openclaw/.env` → `auth-profiles.json`. All token fields handle plain strings, env templates (`${VAR}`), and SecretRef objects.

For the complete config key mapping, SecretRef handling details, and post-migration checklist, see the **[full migration guide](/docs/guides/migrate-from-openclaw)**.

### Examples<a href="#examples" class="hash-link" aria-label="Direct link to Examples" translate="no" title="Direct link to Examples">​</a>


``` prism-code
# Preview what would be migrated
hermes claw migrate --dry-run

# Full migration including API keys
hermes claw migrate --preset full

# Migrate user data only (no secrets), overwrite conflicts
hermes claw migrate --preset user-data --overwrite

# Migrate from a custom OpenClaw path
hermes claw migrate --source /home/user/old-openclaw
```


## `hermes profile`<a href="#hermes-profile" class="hash-link" aria-label="Direct link to hermes-profile" translate="no" title="Direct link to hermes-profile">​</a>


``` prism-code
hermes profile <subcommand>
```


Manage profiles — multiple isolated Hermes instances, each with its own config, sessions, skills, and home directory.

| Subcommand                              | Description                                                                                   |
|-----------------------------------------|-----------------------------------------------------------------------------------------------|
| `list`                                  | List all profiles.                                                                            |
| `use <name>`                            | Set a sticky default profile.                                                                 |
| `create <name> [--clone] [--no-alias]`  | Create a new profile. `--clone` copies config, `.env`, and `SOUL.md` from the active profile. |
| `delete <name> [-y]`                    | Delete a profile.                                                                             |
| `show <name>`                           | Show profile details (home directory, config, etc.).                                          |
| `alias <name> [--remove] [--name NAME]` | Manage wrapper scripts for quick profile access.                                              |
| `rename <old> <new>`                    | Rename a profile.                                                                             |
| `export <name> [-o FILE]`               | Export a profile to a `.tar.gz` archive.                                                      |
| `import <archive> [--name NAME]`        | Import a profile from a `.tar.gz` archive.                                                    |

Examples:


``` prism-code
hermes profile list
hermes profile create work --clone
hermes profile use work
hermes profile alias work --name h-work
hermes profile export work -o work-backup.tar.gz
hermes profile import work-backup.tar.gz --name restored
hermes -p work chat -q "Hello from work profile"
```


## `hermes completion`<a href="#hermes-completion" class="hash-link" aria-label="Direct link to hermes-completion" translate="no" title="Direct link to hermes-completion">​</a>


``` prism-code
hermes completion [bash|zsh]
```


Print a shell completion script to stdout. Source the output in your shell profile for tab-completion of Hermes commands, subcommands, and profile names.

Examples:


``` prism-code
# Bash
hermes completion bash >> ~/.bashrc

# Zsh
hermes completion zsh >> ~/.zshrc
```


## Maintenance commands<a href="#maintenance-commands" class="hash-link" aria-label="Direct link to Maintenance commands" translate="no" title="Direct link to Maintenance commands">​</a>

| Command                             | Description                                         |
|-------------------------------------|-----------------------------------------------------|
| `hermes version`                    | Print version information.                          |
| `hermes update`                     | Pull latest changes and reinstall dependencies.     |
| `hermes uninstall [--full] [--yes]` | Remove Hermes, optionally deleting all config/data. |

## See also<a href="#see-also" class="hash-link" aria-label="Direct link to See also" translate="no" title="Direct link to See also">​</a>

- [Slash Commands Reference](/docs/reference/slash-commands)
- [CLI Interface](/docs/user-guide/cli)
- [Sessions](/docs/user-guide/sessions)
- [Skills System](/docs/user-guide/features/skills)
- [Skins & Themes](/docs/user-guide/features/skins)


- <a href="#global-entrypoint" class="table-of-contents__link toc-highlight">Global entrypoint</a>
  - <a href="#global-options" class="table-of-contents__link toc-highlight">Global options</a>
- <a href="#top-level-commands" class="table-of-contents__link toc-highlight">Top-level commands</a>
- <a href="#hermes-chat" class="table-of-contents__link toc-highlight"><code>hermes chat</code></a>
- <a href="#hermes-model" class="table-of-contents__link toc-highlight"><code>hermes model</code></a>
  - <a href="#model-slash-command-mid-session" class="table-of-contents__link toc-highlight"><code>/model</code> slash command (mid-session)</a>
- <a href="#hermes-gateway" class="table-of-contents__link toc-highlight"><code>hermes gateway</code></a>
- <a href="#hermes-setup" class="table-of-contents__link toc-highlight"><code>hermes setup</code></a>
- <a href="#hermes-whatsapp" class="table-of-contents__link toc-highlight"><code>hermes whatsapp</code></a>
- <a href="#hermes-login--hermes-logout" class="table-of-contents__link toc-highlight"><code>hermes login</code> / <code>hermes logout</code></a>
- <a href="#hermes-auth" class="table-of-contents__link toc-highlight"><code>hermes auth</code></a>
- <a href="#hermes-status" class="table-of-contents__link toc-highlight"><code>hermes status</code></a>
- <a href="#hermes-cron" class="table-of-contents__link toc-highlight"><code>hermes cron</code></a>
- <a href="#hermes-webhook" class="table-of-contents__link toc-highlight"><code>hermes webhook</code></a>
  - <a href="#hermes-webhook-subscribe" class="table-of-contents__link toc-highlight"><code>hermes webhook subscribe</code></a>
- <a href="#hermes-doctor" class="table-of-contents__link toc-highlight"><code>hermes doctor</code></a>
- <a href="#hermes-config" class="table-of-contents__link toc-highlight"><code>hermes config</code></a>
- <a href="#hermes-pairing" class="table-of-contents__link toc-highlight"><code>hermes pairing</code></a>
- <a href="#hermes-skills" class="table-of-contents__link toc-highlight"><code>hermes skills</code></a>
- <a href="#hermes-honcho" class="table-of-contents__link toc-highlight"><code>hermes honcho</code></a>
- <a href="#hermes-acp" class="table-of-contents__link toc-highlight"><code>hermes acp</code></a>
- <a href="#hermes-mcp" class="table-of-contents__link toc-highlight"><code>hermes mcp</code></a>
- <a href="#hermes-plugins" class="table-of-contents__link toc-highlight"><code>hermes plugins</code></a>
- <a href="#hermes-tools" class="table-of-contents__link toc-highlight"><code>hermes tools</code></a>
- <a href="#hermes-sessions" class="table-of-contents__link toc-highlight"><code>hermes sessions</code></a>
- <a href="#hermes-insights" class="table-of-contents__link toc-highlight"><code>hermes insights</code></a>
- <a href="#hermes-claw" class="table-of-contents__link toc-highlight"><code>hermes claw</code></a>
  - <a href="#what-gets-migrated" class="table-of-contents__link toc-highlight">What gets migrated</a>
  - <a href="#examples" class="table-of-contents__link toc-highlight">Examples</a>
- <a href="#hermes-profile" class="table-of-contents__link toc-highlight"><code>hermes profile</code></a>
- <a href="#hermes-completion" class="table-of-contents__link toc-highlight"><code>hermes completion</code></a>
- <a href="#maintenance-commands" class="table-of-contents__link toc-highlight">Maintenance commands</a>
- <a href="#see-also" class="table-of-contents__link toc-highlight">See also</a>


