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

| Option                               | Description                                                                                                        |
|--------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| `--version`, `-V`                    | Show version and exit.                                                                                             |
| `--profile <name>`, `-p <name>`      | Select which Hermes profile to use for this invocation. Overrides the sticky default set by `hermes profile use`.  |
| `--resume <session>`, `-r <session>` | Resume a previous session by ID or title.                                                                          |
| `--continue [name]`, `-c [name]`     | Resume the most recent session, or the most recent session matching a title.                                       |
| `--worktree`, `-w`                   | Start in an isolated git worktree for parallel-agent workflows.                                                    |
| `--yolo`                             | Bypass dangerous-command approval prompts.                                                                         |
| `--pass-session-id`                  | Include the session ID in the agent's system prompt.                                                               |
| `--ignore-user-config`               | Ignore `~/.hermes/config.yaml` and fall back to built-in defaults. Credentials in `.env` are still loaded.         |
| `--ignore-rules`                     | Skip auto-injection of `AGENTS.md`, `SOUL.md`, `.cursorrules`, memory, and preloaded skills.                       |
| `--tui`                              | Launch the [TUI](/docs/user-guide/tui) instead of the classic CLI. Equivalent to `HERMES_TUI=1`.                   |
| `--dev`                              | With `--tui`: run the TypeScript sources directly via `tsx` instead of the prebuilt bundle (for TUI contributors). |

## Top-level commands<a href="#top-level-commands" class="hash-link" aria-label="Direct link to Top-level commands" translate="no" title="Direct link to Top-level commands">​</a>

| Command                   | Purpose                                                                                                    |
|---------------------------|------------------------------------------------------------------------------------------------------------|
| `hermes chat`             | Interactive or one-shot chat with the agent.                                                               |
| `hermes model`            | Interactively choose the default provider and model.                                                       |
| `hermes gateway`          | Run or manage the messaging gateway service.                                                               |
| `hermes setup`            | Interactive setup wizard for all or part of the configuration.                                             |
| `hermes whatsapp`         | Configure and pair the WhatsApp bridge.                                                                    |
| `hermes slack`            | Slack helpers (currently: generate the app manifest with every command as a native slash).                 |
| `hermes auth`             | Manage credentials — add, list, remove, reset, set strategy. Handles OAuth flows for Codex/Nous/Anthropic. |
| `hermes login` / `logout` | **Deprecated** — use `hermes auth` instead.                                                                |
| `hermes status`           | Show agent, auth, and platform status.                                                                     |
| `hermes cron`             | Inspect and tick the cron scheduler.                                                                       |
| `hermes webhook`          | Manage dynamic webhook subscriptions for event-driven activation.                                          |
| `hermes doctor`           | Diagnose config and dependency issues.                                                                     |
| `hermes dump`             | Copy-pasteable setup summary for support/debugging.                                                        |
| `hermes debug`            | Debug tools — upload logs and system info for support.                                                     |
| `hermes backup`           | Back up Hermes home directory to a zip file.                                                               |
| `hermes import`           | Restore a Hermes backup from a zip file.                                                                   |
| `hermes logs`             | View, tail, and filter agent/gateway/error log files.                                                      |
| `hermes config`           | Show, edit, migrate, and query configuration files.                                                        |
| `hermes pairing`          | Approve or revoke messaging pairing codes.                                                                 |
| `hermes skills`           | Browse, install, publish, audit, and configure skills.                                                     |
| `hermes honcho`           | Manage Honcho cross-session memory integration.                                                            |
| `hermes memory`           | Configure external memory provider.                                                                        |
| `hermes acp`              | Run Hermes as an ACP server for editor integration.                                                        |
| `hermes mcp`              | Manage MCP server configurations and run Hermes as an MCP server.                                          |
| `hermes plugins`          | Manage Hermes Agent plugins (install, enable, disable, remove).                                            |
| `hermes tools`            | Configure enabled tools per platform.                                                                      |
| `hermes sessions`         | Browse, export, prune, rename, and delete sessions.                                                        |
| `hermes insights`         | Show token/cost/activity analytics.                                                                        |
| `hermes claw`             | OpenClaw migration helpers.                                                                                |
| `hermes dashboard`        | Launch the web dashboard for managing config, API keys, and sessions.                                      |
| `hermes profile`          | Manage profiles — multiple isolated Hermes instances.                                                      |
| `hermes completion`       | Print shell completion scripts (bash/zsh).                                                                 |
| `hermes version`          | Show version information.                                                                                  |
| `hermes update`           | Pull latest code and reinstall dependencies.                                                               |
| `hermes uninstall`        | Remove Hermes from the system.                                                                             |

## `hermes chat`<a href="#hermes-chat" class="hash-link" aria-label="Direct link to hermes-chat" translate="no" title="Direct link to hermes-chat">​</a>


``` prism-code
hermes chat [options]
```


Common options:

| Option                                     | Description                                                                                                                                                                                                                                                                                                                                                                                                               |
|--------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `-q`, `--query "..."`                      | One-shot, non-interactive prompt.                                                                                                                                                                                                                                                                                                                                                                                         |
| `-m`, `--model <model>`                    | Override the model for this run.                                                                                                                                                                                                                                                                                                                                                                                          |
| `-t`, `--toolsets <csv>`                   | Enable a comma-separated set of toolsets.                                                                                                                                                                                                                                                                                                                                                                                 |
| `--provider <provider>`                    | Force a provider: `auto`, `openrouter`, `nous`, `openai-codex`, `copilot-acp`, `copilot`, `anthropic`, `gemini`, `google-gemini-cli`, `huggingface`, `zai`, `kimi-coding`, `kimi-coding-cn`, `minimax`, `minimax-cn`, `kilocode`, `xiaomi`, `arcee`, `gmi`, `alibaba`, `deepseek`, `nvidia`, `ollama-cloud`, `xai` (alias `grok`), `qwen-oauth`, `bedrock`, `opencode-zen`, `opencode-go`, `ai-gateway`, `azure-foundry`. |
| `-s`, `--skills <name>`                    | Preload one or more skills for the session (can be repeated or comma-separated).                                                                                                                                                                                                                                                                                                                                          |
| `-v`, `--verbose`                          | Verbose output.                                                                                                                                                                                                                                                                                                                                                                                                           |
| `-Q`, `--quiet`                            | Programmatic mode: suppress banner/spinner/tool previews.                                                                                                                                                                                                                                                                                                                                                                 |
| `--image <path>`                           | Attach a local image to a single query.                                                                                                                                                                                                                                                                                                                                                                                   |
| `--resume <session>` / `--continue [name]` | Resume a session directly from `chat`.                                                                                                                                                                                                                                                                                                                                                                                    |
| `--worktree`                               | Create an isolated git worktree for this run.                                                                                                                                                                                                                                                                                                                                                                             |
| `--checkpoints`                            | Enable filesystem checkpoints before destructive file changes.                                                                                                                                                                                                                                                                                                                                                            |
| `--yolo`                                   | Skip approval prompts.                                                                                                                                                                                                                                                                                                                                                                                                    |
| `--pass-session-id`                        | Pass the session ID into the system prompt.                                                                                                                                                                                                                                                                                                                                                                               |
| `--ignore-user-config`                     | Ignore `~/.hermes/config.yaml` and use built-in defaults. Credentials in `.env` are still loaded. Useful for isolated CI runs, reproducible bug reports, and third-party integrations.                                                                                                                                                                                                                                    |
| `--ignore-rules`                           | Skip auto-injection of `AGENTS.md`, `SOUL.md`, `.cursorrules`, persistent memory, and preloaded skills. Combine with `--ignore-user-config` for a fully isolated run.                                                                                                                                                                                                                                                     |
| `--source <tag>`                           | Session source tag for filtering (default: `cli`). Use `tool` for third-party integrations that should not appear in user session lists.                                                                                                                                                                                                                                                                                  |
| `--max-turns <N>`                          | Maximum tool-calling iterations per conversation turn (default: 90, or `agent.max_turns` in config).                                                                                                                                                                                                                                                                                                                      |

Examples:


``` prism-code
hermes
hermes chat -q "Summarize the latest PRs"
hermes chat --provider openrouter --model anthropic/claude-sonnet-4.6
hermes chat --toolsets web,terminal,skills
hermes chat --quiet -q "Return only JSON"
hermes chat --worktree -q "Review this repo and open a PR"
hermes chat --ignore-user-config --ignore-rules -q "Repro without my personal setup"
```


## `hermes model`<a href="#hermes-model" class="hash-link" aria-label="Direct link to hermes-model" translate="no" title="Direct link to hermes-model">​</a>

Interactive provider + model selector. **This is the command for adding new providers, setting up API keys, and running OAuth flows.** Run it from your terminal — not from inside an active Hermes chat session.


``` prism-code
hermes model
```


Use this when you want to:

- **add a new provider** (OpenRouter, Anthropic, Copilot, DeepSeek, custom, etc.)
- log into OAuth-backed providers (Anthropic, Copilot, Codex, Nous Portal)
- enter or update API keys
- pick from provider-specific model lists
- configure a custom/self-hosted endpoint
- save the new default into config


**`hermes model`** (run from your terminal, outside any Hermes session) is the **full provider setup wizard**. It can add new providers, run OAuth flows, prompt for API keys, and configure endpoints.

**`/model`** (typed inside an active Hermes chat session) can only **switch between providers and models you've already set up**. It cannot add new providers, run OAuth, or prompt for API keys.

**If you need to add a new provider:** Exit your Hermes session first (`Ctrl+C` or `/quit`), then run `hermes model` from your terminal prompt.


### `/model` slash command (mid-session)<a href="#model-slash-command-mid-session" class="hash-link" aria-label="Direct link to model-slash-command-mid-session" translate="no" title="Direct link to model-slash-command-mid-session">​</a>

Switch between already-configured models without leaving a session:


``` prism-code
/model                              # Show current model and available options
/model claude-sonnet-4              # Switch model (auto-detects provider)
/model zai:glm-5                    # Switch provider and model
/model custom:qwen-2.5              # Use model on your custom endpoint
/model custom                       # Auto-detect model from custom endpoint
/model custom:local:qwen-2.5        # Use a named custom provider
/model openrouter:anthropic/claude-sonnet-4  # Switch back to cloud
```


By default, `/model` changes apply **to the current session only**. Add `--global` to persist the change to `config.yaml`:


``` prism-code
/model claude-sonnet-4 --global     # Switch and save as new default
```


If you've only configured OpenRouter, `/model` will only show OpenRouter models. To add another provider (Anthropic, DeepSeek, Copilot, etc.), exit your session and run `hermes model` from the terminal.


Provider and base URL changes are persisted to `config.yaml` automatically. When switching away from a custom endpoint, the stale base URL is cleared to prevent it leaking into other providers.

## `hermes gateway`<a href="#hermes-gateway" class="hash-link" aria-label="Direct link to hermes-gateway" translate="no" title="Direct link to hermes-gateway">​</a>


``` prism-code
hermes gateway <subcommand>
```


Subcommands:

| Subcommand  | Description                                                                 |
|-------------|-----------------------------------------------------------------------------|
| `run`       | Run the gateway in the foreground. Recommended for WSL, Docker, and Termux. |
| `start`     | Start the installed systemd/launchd background service.                     |
| `stop`      | Stop the service (or foreground process).                                   |
| `restart`   | Restart the service.                                                        |
| `status`    | Show service status.                                                        |
| `install`   | Install as a systemd (Linux) or launchd (macOS) background service.         |
| `uninstall` | Remove the installed service.                                               |
| `setup`     | Interactive messaging-platform setup.                                       |


Use `hermes gateway run` instead of `hermes gateway start` — WSL's systemd support is unreliable. Wrap it in tmux for persistence: `tmux new -s hermes 'hermes gateway run'`. See [WSL FAQ](/docs/reference/faq#wsl-gateway-keeps-disconnecting-or-hermes-gateway-start-fails) for details.


## `hermes setup`<a href="#hermes-setup" class="hash-link" aria-label="Direct link to hermes-setup" translate="no" title="Direct link to hermes-setup">​</a>


``` prism-code
hermes setup [model|tts|terminal|gateway|tools|agent] [--non-interactive] [--reset] [--quick] [--reconfigure]
```


**First run:** launches the first-time wizard.

**Returning user (already configured):** drops straight into the full reconfigure wizard — every prompt shows your current value as its default, press Enter to keep or type a new value. No menu.

Jump into one section instead of the full wizard:

| Section    | Description                         |
|------------|-------------------------------------|
| `model`    | Provider and model setup.           |
| `terminal` | Terminal backend and sandbox setup. |
| `gateway`  | Messaging platform setup.           |
| `tools`    | Enable/disable tools per platform.  |
| `agent`    | Agent behavior settings.            |

Options:

| Option              | Description                                                                                                      |
|---------------------|------------------------------------------------------------------------------------------------------------------|
| `--quick`           | On returning-user runs: only prompt for items that are missing or unset. Skip items you already have configured. |
| `--non-interactive` | Use defaults / environment values without prompts.                                                               |
| `--reset`           | Reset configuration to defaults before setup.                                                                    |
| `--reconfigure`     | Backwards-compat alias — bare `hermes setup` on an existing install now does this by default.                    |

## `hermes whatsapp`<a href="#hermes-whatsapp" class="hash-link" aria-label="Direct link to hermes-whatsapp" translate="no" title="Direct link to hermes-whatsapp">​</a>


``` prism-code
hermes whatsapp
```


Runs the WhatsApp pairing/setup flow, including mode selection and QR-code pairing.

## `hermes slack`<a href="#hermes-slack" class="hash-link" aria-label="Direct link to hermes-slack" translate="no" title="Direct link to hermes-slack">​</a>


``` prism-code
hermes slack manifest              # print manifest to stdout
hermes slack manifest --write      # write to ~/.hermes/slack-manifest.json
hermes slack manifest --slashes-only  # just the features.slash_commands array
```


Generates a Slack app manifest that registers every gateway command in `COMMAND_REGISTRY` (`/btw`, `/stop`, `/model`, …) as a first-class Slack slash command — matching Discord and Telegram parity. Paste the output into your Slack app config at <a href="https://api.slack.com/apps" target="_blank" rel="noopener noreferrer">https://api.slack.com/apps</a> → your app → **Features → App Manifest → Edit**, then **Save**. Slack prompts for reinstall if scopes or slash commands changed.

| Flag                 | Default       | Purpose                                                                                      |
|----------------------|---------------|----------------------------------------------------------------------------------------------|
| `--write [PATH]`     | stdout        | Write to a file instead of stdout. Bare `--write` writes `$HERMES_HOME/slack-manifest.json`. |
| `--name NAME`        | `Hermes`      | Bot display name in Slack.                                                                   |
| `--description DESC` | default blurb | Bot description shown in the Slack app directory.                                            |
| `--slashes-only`     | off           | Emit only `features.slash_commands` for merging into a manually-maintained manifest.         |

Run `hermes slack manifest --write` again after `hermes update` to pick up any new commands.

## `hermes login` / `hermes logout` *(Deprecated)*<a href="#hermes-login--hermes-logout-deprecated" class="hash-link" aria-label="Direct link to hermes-login--hermes-logout-deprecated" translate="no" title="Direct link to hermes-login--hermes-logout-deprecated">​</a>


`hermes login` has been removed. Use `hermes auth` to manage OAuth credentials, `hermes model` to select a provider, or `hermes setup` for full interactive setup.


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

## `hermes dump`<a href="#hermes-dump" class="hash-link" aria-label="Direct link to hermes-dump" translate="no" title="Direct link to hermes-dump">​</a>


``` prism-code
hermes dump [--show-keys]
```


Outputs a compact, plain-text summary of your entire Hermes setup. Designed to be copy-pasted into Discord, GitHub issues, or Telegram when asking for support — no ANSI colors, no special formatting, just data.

| Option        | Description                                                                                   |
|---------------|-----------------------------------------------------------------------------------------------|
| `--show-keys` | Show redacted API key prefixes (first and last 4 characters) instead of just `set`/`not set`. |

### What it includes<a href="#what-it-includes" class="hash-link" aria-label="Direct link to What it includes" translate="no" title="Direct link to What it includes">​</a>

| Section              | Details                                             |
|----------------------|-----------------------------------------------------|
| **Header**           | Hermes version, release date, git commit hash       |
| **Environment**      | OS, Python version, OpenAI SDK version              |
| **Identity**         | Active profile name, HERMES_HOME path               |
| **Model**            | Configured default model and provider               |
| **Terminal**         | Backend type (local, docker, ssh, etc.)             |
| **API keys**         | Presence check for all 22 provider/tool API keys    |
| **Features**         | Enabled toolsets, MCP server count, memory provider |
| **Services**         | Gateway status, configured messaging platforms      |
| **Workload**         | Cron job counts, installed skill count              |
| **Config overrides** | Any config values that differ from defaults         |

### Example output<a href="#example-output" class="hash-link" aria-label="Direct link to Example output" translate="no" title="Direct link to Example output">​</a>


``` prism-code
--- hermes dump ---
version:          0.8.0 (2026.4.8) [af4abd2f]
os:               Linux 6.14.0-37-generic x86_64
python:           3.11.14
openai_sdk:       2.24.0
profile:          default
hermes_home:      ~/.hermes
model:            anthropic/claude-opus-4.6
provider:         openrouter
terminal:         local

api_keys:
  openrouter           set
  openai               not set
  anthropic            set
  nous                 not set
  firecrawl            set
  ...

features:
  toolsets:           all
  mcp_servers:        0
  memory_provider:    built-in
  gateway:            running (systemd)
  platforms:          telegram, discord
  cron_jobs:          3 active / 5 total
  skills:             42

config_overrides:
  agent.max_turns: 250
  compression.threshold: 0.85
  display.streaming: True
--- end dump ---
```


### When to use<a href="#when-to-use" class="hash-link" aria-label="Direct link to When to use" translate="no" title="Direct link to When to use">​</a>

- Reporting a bug on GitHub — paste the dump into your issue
- Asking for help in Discord — share it in a code block
- Comparing your setup to someone else's
- Quick sanity check when something isn't working


`hermes dump` is specifically designed for sharing. For interactive diagnostics, use `hermes doctor`. For a visual overview, use `hermes status`.


## `hermes debug`<a href="#hermes-debug" class="hash-link" aria-label="Direct link to hermes-debug" translate="no" title="Direct link to hermes-debug">​</a>


``` prism-code
hermes debug share [options]
```


Upload a debug report (system info + recent logs) to a paste service and get a shareable URL. Useful for quick support requests — includes everything a helper needs to diagnose your issue.

| Option            | Description                                                 |
|-------------------|-------------------------------------------------------------|
| `--lines <N>`     | Number of log lines to include per log file (default: 200). |
| `--expire <days>` | Paste expiry in days (default: 7).                          |
| `--local`         | Print the report locally instead of uploading.              |

The report includes system info (OS, Python version, Hermes version), recent agent and gateway logs (512 KB limit per file), and redacted API key status. Keys are always redacted — no secrets are uploaded.

Paste services tried in order: paste.rs, dpaste.com.

### Examples<a href="#examples" class="hash-link" aria-label="Direct link to Examples" translate="no" title="Direct link to Examples">​</a>


``` prism-code
hermes debug share              # Upload debug report, print URL
hermes debug share --lines 500  # Include more log lines
hermes debug share --expire 30  # Keep paste for 30 days
hermes debug share --local      # Print report to terminal (no upload)
```


## `hermes backup`<a href="#hermes-backup" class="hash-link" aria-label="Direct link to hermes-backup" translate="no" title="Direct link to hermes-backup">​</a>


``` prism-code
hermes backup [options]
```


Create a zip archive of your Hermes configuration, skills, sessions, and data. The backup excludes the hermes-agent codebase itself.

| Option                  | Description                                                                                                               |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------|
| `-o`, `--output <path>` | Output path for the zip file (default: `~/hermes-backup-<timestamp>.zip`).                                                |
| `-q`, `--quick`         | Quick snapshot: only critical state files (config.yaml, state.db, .env, auth, cron jobs). Much faster than a full backup. |
| `-l`, `--label <name>`  | Label for the snapshot (only used with `--quick`).                                                                        |

The backup uses SQLite's `backup()` API for safe copying, so it works correctly even when Hermes is running (WAL-mode safe).

### Examples<a href="#examples-1" class="hash-link" aria-label="Direct link to Examples" translate="no" title="Direct link to Examples">​</a>


``` prism-code
hermes backup                           # Full backup to ~/hermes-backup-*.zip
hermes backup -o /tmp/hermes.zip        # Full backup to specific path
hermes backup --quick                   # Quick state-only snapshot
hermes backup --quick --label "pre-upgrade"  # Quick snapshot with label
```


## `hermes import`<a href="#hermes-import" class="hash-link" aria-label="Direct link to hermes-import" translate="no" title="Direct link to hermes-import">​</a>


``` prism-code
hermes import <zipfile> [options]
```


Restore a previously created Hermes backup into your Hermes home directory.

| Option          | Description                                    |
|-----------------|------------------------------------------------|
| `-f`, `--force` | Overwrite existing files without confirmation. |

## `hermes logs`<a href="#hermes-logs" class="hash-link" aria-label="Direct link to hermes-logs" translate="no" title="Direct link to hermes-logs">​</a>


``` prism-code
hermes logs [log_name] [options]
```


View, tail, and filter Hermes log files. All logs are stored in `~/.hermes/logs/` (or `<profile>/logs/` for non-default profiles).

### Log files<a href="#log-files" class="hash-link" aria-label="Direct link to Log files" translate="no" title="Direct link to Log files">​</a>

| Name              | File          | What it captures                                                                    |
|-------------------|---------------|-------------------------------------------------------------------------------------|
| `agent` (default) | `agent.log`   | All agent activity — API calls, tool dispatch, session lifecycle (INFO and above)   |
| `errors`          | `errors.log`  | Warnings and errors only — a filtered subset of agent.log                           |
| `gateway`         | `gateway.log` | Messaging gateway activity — platform connections, message dispatch, webhook events |

### Options<a href="#options" class="hash-link" aria-label="Direct link to Options" translate="no" title="Direct link to Options">​</a>

| Option               | Description                                                                                                                  |
|----------------------|------------------------------------------------------------------------------------------------------------------------------|
| `log_name`           | Which log to view: `agent` (default), `errors`, `gateway`, or `list` to show available files with sizes.                     |
| `-n`, `--lines <N>`  | Number of lines to show (default: 50).                                                                                       |
| `-f`, `--follow`     | Follow the log in real time, like `tail -f`. Press Ctrl+C to stop.                                                           |
| `--level <LEVEL>`    | Minimum log level to show: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`.                                                  |
| `--session <ID>`     | Filter lines containing a session ID substring.                                                                              |
| `--since <TIME>`     | Show lines from a relative time ago: `30m`, `1h`, `2d`, etc. Supports `s` (seconds), `m` (minutes), `h` (hours), `d` (days). |
| `--component <NAME>` | Filter by component: `gateway`, `agent`, `tools`, `cli`, `cron`.                                                             |

### Examples<a href="#examples-2" class="hash-link" aria-label="Direct link to Examples" translate="no" title="Direct link to Examples">​</a>


``` prism-code
# View the last 50 lines of agent.log (default)
hermes logs

# Follow agent.log in real time
hermes logs -f

# View the last 100 lines of gateway.log
hermes logs gateway -n 100

# Show only warnings and errors from the last hour
hermes logs --level WARNING --since 1h

# Filter by a specific session
hermes logs --session abc123

# Follow errors.log, starting from 30 minutes ago
hermes logs errors --since 30m -f

# List all log files with their sizes
hermes logs list
```


### Filtering<a href="#filtering" class="hash-link" aria-label="Direct link to Filtering" translate="no" title="Direct link to Filtering">​</a>

Filters can be combined. When multiple filters are active, a log line must pass **all** of them to be shown:


``` prism-code
# WARNING+ lines from the last 2 hours containing session "tg-12345"
hermes logs --level WARNING --since 2h --session tg-12345
```


Lines without a parseable timestamp are included when `--since` is active (they may be continuation lines from a multi-line log entry). Lines without a detectable level are included when `--level` is active.

### Log rotation<a href="#log-rotation" class="hash-link" aria-label="Direct link to Log rotation" translate="no" title="Direct link to Log rotation">​</a>

Hermes uses Python's `RotatingFileHandler`. Old logs are rotated automatically — look for `agent.log.1`, `agent.log.2`, etc. The `hermes logs list` subcommand shows all log files including rotated ones.

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
hermes skills install https://sharethis.chat/SKILL.md                     # Direct URL (single-file SKILL.md)
hermes skills install https://example.com/SKILL.md --name my-skill        # Override name when frontmatter has none
hermes skills check
hermes skills update
hermes skills config
```


Notes:

- `--force` can override non-dangerous policy blocks for third-party/community skills.
- `--force` does not override a `dangerous` scan verdict.
- `--source skills-sh` searches the public `skills.sh` directory.
- `--source well-known` lets you point Hermes at a site exposing `/.well-known/skills/index.json`.
- Passing an `http(s)://…/*.md` URL installs a single-file SKILL.md directly. When frontmatter has no `name:` and the URL slug isn't a valid identifier, an interactive terminal prompts for a name; non-interactive surfaces (`/skills install` inside the TUI, gateway platforms) require `--name <x>` instead.

## `hermes honcho`<a href="#hermes-honcho" class="hash-link" aria-label="Direct link to hermes-honcho" translate="no" title="Direct link to hermes-honcho">​</a>


``` prism-code
hermes honcho [--target-profile NAME] <subcommand>
```


Manage Honcho cross-session memory integration. This command is provided by the Honcho memory provider plugin and is only available when `memory.provider` is set to `honcho` in your config.

The `--target-profile` flag lets you manage another profile's Honcho config without switching to it.

Subcommands:

| Subcommand                 | Description                                                                                                        |
|----------------------------|--------------------------------------------------------------------------------------------------------------------|
| `setup`                    | Redirects to `hermes memory setup` (unified setup path).                                                           |
| `status [--all]`           | Show current Honcho config and connection status. `--all` shows a cross-profile overview.                          |
| `peers`                    | Show peer identities across all profiles.                                                                          |
| `sessions`                 | List known Honcho session mappings.                                                                                |
| `map [name]`               | Map the current directory to a Honcho session name. Omit `name` to list current mappings.                          |
| `peer`                     | Show or update peer names and dialectic reasoning level. Options: `--user NAME`, `--ai NAME`, `--reasoning LEVEL`. |
| `mode [mode]`              | Show or set recall mode: `hybrid`, `context`, or `tools`. Omit to show current.                                    |
| `tokens`                   | Show or set token budgets for context and dialectic. Options: `--context N`, `--dialectic N`.                      |
| `identity [file] [--show]` | Seed or show the AI peer identity representation.                                                                  |
| `enable`                   | Enable Honcho for the active profile.                                                                              |
| `disable`                  | Disable Honcho for the active profile.                                                                             |
| `sync`                     | Sync Honcho config to all existing profiles (creates missing host blocks).                                         |
| `migrate`                  | Step-by-step migration guide from openclaw-honcho to Hermes Honcho.                                                |

## `hermes memory`<a href="#hermes-memory" class="hash-link" aria-label="Direct link to hermes-memory" translate="no" title="Direct link to hermes-memory">​</a>


``` prism-code
hermes memory <subcommand>
```


Set up and manage external memory provider plugins. Available providers: honcho, openviking, mem0, hindsight, holographic, retaindb, byterover, supermemory. Only one external provider can be active at a time. Built-in memory (MEMORY.md/USER.md) is always active.

Subcommands:

| Subcommand | Description                                       |
|------------|---------------------------------------------------|
| `setup`    | Interactive provider selection and configuration. |
| `status`   | Show current memory provider config.              |
| `off`      | Disable external provider (built-in only).        |

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


Unified plugin management — general plugins, memory providers, and context engines in one place. Running `hermes plugins` with no subcommand opens a composite interactive screen with two sections:

- **General Plugins** — multi-select checkboxes to enable/disable installed plugins
- **Provider Plugins** — single-select configuration for Memory Provider and Context Engine. Press ENTER on a category to open a radio picker.

| Subcommand                                   | Description                                                                        |
|----------------------------------------------|------------------------------------------------------------------------------------|
| *(none)*                                     | Composite interactive UI — general plugin toggles + provider plugin configuration. |
| `install <identifier> [--force]`             | Install a plugin from a Git URL or `owner/repo`.                                   |
| `update <name>`                              | Pull latest changes for an installed plugin.                                       |
| `remove <name>` (aliases: `rm`, `uninstall`) | Remove an installed plugin.                                                        |
| `enable <name>`                              | Enable a disabled plugin.                                                          |
| `disable <name>`                             | Disable a plugin without removing it.                                              |
| `list` (alias: `ls`)                         | List installed plugins with enabled/disabled status.                               |

Provider plugin selections are saved to `config.yaml`:

- `memory.provider` — active memory provider (empty = built-in only)
- `context.engine` — active context engine (`"compressor"` = built-in default)

General plugin disabled list is stored in `config.yaml` under `plugins.disabled`.

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


Migrate your OpenClaw setup to Hermes. Reads from `~/.openclaw` (or a custom path) and writes to `~/.hermes`. Automatically detects legacy directory names (`~/.clawdbot`, `~/.moltbot`) and config filenames (`clawdbot.json`, `moltbot.json`).

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

### Examples<a href="#examples-3" class="hash-link" aria-label="Direct link to Examples" translate="no" title="Direct link to Examples">​</a>


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


## `hermes dashboard`<a href="#hermes-dashboard" class="hash-link" aria-label="Direct link to hermes-dashboard" translate="no" title="Direct link to hermes-dashboard">​</a>


``` prism-code
hermes dashboard [options]
```


Launch the web dashboard — a browser-based UI for managing configuration, API keys, and monitoring sessions. Requires `pip install hermes-agent[web]` (FastAPI + Uvicorn). See [Web Dashboard](/docs/user-guide/features/web-dashboard) for full documentation.

| Option      | Default     | Description                   |
|-------------|-------------|-------------------------------|
| `--port`    | `9119`      | Port to run the web server on |
| `--host`    | `127.0.0.1` | Bind address                  |
| `--no-open` | —           | Don't auto-open the browser   |


``` prism-code
# Default — opens browser to http://127.0.0.1:9119
hermes dashboard

# Custom port, no browser
hermes dashboard --port 8080 --no-open
```


## `hermes profile`<a href="#hermes-profile" class="hash-link" aria-label="Direct link to hermes-profile" translate="no" title="Direct link to hermes-profile">​</a>


``` prism-code
hermes profile <subcommand>
```


Manage profiles — multiple isolated Hermes instances, each with its own config, sessions, skills, and home directory.

| Subcommand                                                                   | Description                                                                                                                                                              |
|------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `list`                                                                       | List all profiles.                                                                                                                                                       |
| `use <name>`                                                                 | Set a sticky default profile.                                                                                                                                            |
| `create <name> [--clone] [--clone-all] [--clone-from <source>] [--no-alias]` | Create a new profile. `--clone` copies config, `.env`, and `SOUL.md` from the active profile. `--clone-all` copies all state. `--clone-from` specifies a source profile. |
| `delete <name> [-y]`                                                         | Delete a profile.                                                                                                                                                        |
| `show <name>`                                                                | Show profile details (home directory, config, etc.).                                                                                                                     |
| `alias <name> [--remove] [--name NAME]`                                      | Manage wrapper scripts for quick profile access.                                                                                                                         |
| `rename <old> <new>`                                                         | Rename a profile.                                                                                                                                                        |
| `export <name> [-o FILE]`                                                    | Export a profile to a `.tar.gz` archive.                                                                                                                                 |
| `import <archive> [--name NAME]`                                             | Import a profile from a `.tar.gz` archive.                                                                                                                               |

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
- <a href="#hermes-slack" class="table-of-contents__link toc-highlight"><code>hermes slack</code></a>
- <a href="#hermes-login--hermes-logout-deprecated" class="table-of-contents__link toc-highlight"><code>hermes login</code> / <code>hermes logout</code> <em>(Deprecated)</em></a>
- <a href="#hermes-auth" class="table-of-contents__link toc-highlight"><code>hermes auth</code></a>
- <a href="#hermes-status" class="table-of-contents__link toc-highlight"><code>hermes status</code></a>
- <a href="#hermes-cron" class="table-of-contents__link toc-highlight"><code>hermes cron</code></a>
- <a href="#hermes-webhook" class="table-of-contents__link toc-highlight"><code>hermes webhook</code></a>
  - <a href="#hermes-webhook-subscribe" class="table-of-contents__link toc-highlight"><code>hermes webhook subscribe</code></a>
- <a href="#hermes-doctor" class="table-of-contents__link toc-highlight"><code>hermes doctor</code></a>
- <a href="#hermes-dump" class="table-of-contents__link toc-highlight"><code>hermes dump</code></a>
  - <a href="#what-it-includes" class="table-of-contents__link toc-highlight">What it includes</a>
  - <a href="#example-output" class="table-of-contents__link toc-highlight">Example output</a>
  - <a href="#when-to-use" class="table-of-contents__link toc-highlight">When to use</a>
- <a href="#hermes-debug" class="table-of-contents__link toc-highlight"><code>hermes debug</code></a>
  - <a href="#examples" class="table-of-contents__link toc-highlight">Examples</a>
- <a href="#hermes-backup" class="table-of-contents__link toc-highlight"><code>hermes backup</code></a>
  - <a href="#examples-1" class="table-of-contents__link toc-highlight">Examples</a>
- <a href="#hermes-import" class="table-of-contents__link toc-highlight"><code>hermes import</code></a>
- <a href="#hermes-logs" class="table-of-contents__link toc-highlight"><code>hermes logs</code></a>
  - <a href="#log-files" class="table-of-contents__link toc-highlight">Log files</a>
  - <a href="#options" class="table-of-contents__link toc-highlight">Options</a>
  - <a href="#examples-2" class="table-of-contents__link toc-highlight">Examples</a>
  - <a href="#filtering" class="table-of-contents__link toc-highlight">Filtering</a>
  - <a href="#log-rotation" class="table-of-contents__link toc-highlight">Log rotation</a>
- <a href="#hermes-config" class="table-of-contents__link toc-highlight"><code>hermes config</code></a>
- <a href="#hermes-pairing" class="table-of-contents__link toc-highlight"><code>hermes pairing</code></a>
- <a href="#hermes-skills" class="table-of-contents__link toc-highlight"><code>hermes skills</code></a>
- <a href="#hermes-honcho" class="table-of-contents__link toc-highlight"><code>hermes honcho</code></a>
- <a href="#hermes-memory" class="table-of-contents__link toc-highlight"><code>hermes memory</code></a>
- <a href="#hermes-acp" class="table-of-contents__link toc-highlight"><code>hermes acp</code></a>
- <a href="#hermes-mcp" class="table-of-contents__link toc-highlight"><code>hermes mcp</code></a>
- <a href="#hermes-plugins" class="table-of-contents__link toc-highlight"><code>hermes plugins</code></a>
- <a href="#hermes-tools" class="table-of-contents__link toc-highlight"><code>hermes tools</code></a>
- <a href="#hermes-sessions" class="table-of-contents__link toc-highlight"><code>hermes sessions</code></a>
- <a href="#hermes-insights" class="table-of-contents__link toc-highlight"><code>hermes insights</code></a>
- <a href="#hermes-claw" class="table-of-contents__link toc-highlight"><code>hermes claw</code></a>
  - <a href="#what-gets-migrated" class="table-of-contents__link toc-highlight">What gets migrated</a>
  - <a href="#examples-3" class="table-of-contents__link toc-highlight">Examples</a>
- <a href="#hermes-dashboard" class="table-of-contents__link toc-highlight"><code>hermes dashboard</code></a>
- <a href="#hermes-profile" class="table-of-contents__link toc-highlight"><code>hermes profile</code></a>
- <a href="#hermes-completion" class="table-of-contents__link toc-highlight"><code>hermes completion</code></a>
- <a href="#maintenance-commands" class="table-of-contents__link toc-highlight">Maintenance commands</a>
- <a href="#see-also" class="table-of-contents__link toc-highlight">See also</a>


