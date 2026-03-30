> Source: https://hermes-agent.nousresearch.com/docs/user-guide/messaging/



On this page


# Messaging Gateway


Chat with Hermes from Telegram, Discord, Slack, WhatsApp, Signal, SMS, Email, Home Assistant, Mattermost, Matrix, DingTalk, Feishu/Lark, WeCom, or your browser. The gateway is a single background process that connects to all your configured platforms, handles sessions, runs cron jobs, and delivers voice messages.

For the full voice feature set — including CLI microphone mode, spoken replies in messaging, and Discord voice-channel conversations — see [Voice Mode](/docs/user-guide/features/voice-mode) and [Use Voice Mode with Hermes](/docs/guides/use-voice-mode-with-hermes).

## Architecture<a href="#architecture" class="hash-link" aria-label="Direct link to Architecture" translate="no" title="Direct link to Architecture">​</a>

Each platform adapter receives messages, routes them through a per-chat session store, and dispatches them to the AIAgent for processing. The gateway also runs the cron scheduler, ticking every 60 seconds to execute any due jobs.

## Quick Setup<a href="#quick-setup" class="hash-link" aria-label="Direct link to Quick Setup" translate="no" title="Direct link to Quick Setup">​</a>

The easiest way to configure messaging platforms is the interactive wizard:


``` bash
hermes gateway setup        # Interactive setup for all messaging platforms
```


This walks you through configuring each platform with arrow-key selection, shows which platforms are already configured, and offers to start/restart the gateway when done.

## Gateway Commands<a href="#gateway-commands" class="hash-link" aria-label="Direct link to Gateway Commands" translate="no" title="Direct link to Gateway Commands">​</a>


``` bash
hermes gateway              # Run in foreground
hermes gateway setup        # Configure messaging platforms interactively
hermes gateway install      # Install as a user service (Linux) / launchd service (macOS)
sudo hermes gateway install --system   # Linux only: install a boot-time system service
hermes gateway start        # Start the default service
hermes gateway stop         # Stop the default service
hermes gateway status       # Check default service status
hermes gateway status --system         # Linux only: inspect the system service explicitly
```


## Chat Commands (Inside Messaging)<a href="#chat-commands-inside-messaging" class="hash-link" aria-label="Direct link to Chat Commands (Inside Messaging)" translate="no" title="Direct link to Chat Commands (Inside Messaging)">​</a>

| Command | Description |
|----|----|
| `/new` or `/reset` | Start a fresh conversation |
| `/model [provider:model]` | Show or change the model (supports `provider:model` syntax) |
| `/provider` | Show available providers with auth status |
| `/personality [name]` | Set a personality |
| `/retry` | Retry the last message |
| `/undo` | Remove the last exchange |
| `/status` | Show session info |
| `/stop` | Stop the running agent |
| `/approve` | Approve a pending dangerous command |
| `/deny` | Reject a pending dangerous command |
| `/sethome` | Set this chat as the home channel |
| `/compress` | Manually compress conversation context |
| `/title [name]` | Set or show the session title |
| `/resume [name]` | Resume a previously named session |
| `/usage` | Show token usage for this session |
| `/insights [days]` | Show usage insights and analytics |
| `/reasoning [level|show|hide]` | Change reasoning effort or toggle reasoning display |
| `/voice [on|off|tts|join|leave|status]` | Control messaging voice replies and Discord voice-channel behavior |
| `/rollback [number]` | List or restore filesystem checkpoints |
| `/background <prompt>` | Run a prompt in a separate background session |
| `/reload-mcp` | Reload MCP servers from config |
| `/update` | Update Hermes Agent to the latest version |
| `/help` | Show available commands |
| `/<skill-name>` | Invoke any installed skill |

## Session Management<a href="#session-management" class="hash-link" aria-label="Direct link to Session Management" translate="no" title="Direct link to Session Management">​</a>

### Session Persistence<a href="#session-persistence" class="hash-link" aria-label="Direct link to Session Persistence" translate="no" title="Direct link to Session Persistence">​</a>

Sessions persist across messages until they reset. The agent remembers your conversation context.

### Reset Policies<a href="#reset-policies" class="hash-link" aria-label="Direct link to Reset Policies" translate="no" title="Direct link to Reset Policies">​</a>

Sessions reset based on configurable policies:

| Policy | Default    | Description                         |
|--------|------------|-------------------------------------|
| Daily  | 4:00 AM    | Reset at a specific hour each day   |
| Idle   | 1440 min   | Reset after N minutes of inactivity |
| Both   | (combined) | Whichever triggers first            |

Configure per-platform overrides in `~/.hermes/gateway.json`:


``` json
{
  "reset_by_platform": {
    "telegram": { "mode": "idle", "idle_minutes": 240 },
    "discord": { "mode": "idle", "idle_minutes": 60 }
  }
}
```


## Security<a href="#security" class="hash-link" aria-label="Direct link to Security" translate="no" title="Direct link to Security">​</a>

**By default, the gateway denies all users who are not in an allowlist or paired via DM.** This is the safe default for a bot with terminal access.


``` bash
# Restrict to specific users (recommended):
TELEGRAM_ALLOWED_USERS=123456789,987654321
DISCORD_ALLOWED_USERS=123456789012345678
SIGNAL_ALLOWED_USERS=+155****4567,+155****6543
SMS_ALLOWED_USERS=+155****4567,+155****6543
EMAIL_ALLOWED_USERS=trusted@example.com,colleague@work.com
MATTERMOST_ALLOWED_USERS=3uo8dkh1p7g1mfk49ear5fzs5c
MATRIX_ALLOWED_USERS=@alice:matrix.org
DINGTALK_ALLOWED_USERS=user-id-1

# Or allow
GATEWAY_ALLOWED_USERS=123456789,987654321

# Or explicitly allow all users (NOT recommended for bots with terminal access):
GATEWAY_ALLOW_ALL_USERS=true
```


### DM Pairing (Alternative to Allowlists)<a href="#dm-pairing-alternative-to-allowlists" class="hash-link" aria-label="Direct link to DM Pairing (Alternative to Allowlists)" translate="no" title="Direct link to DM Pairing (Alternative to Allowlists)">​</a>

Instead of manually configuring user IDs, unknown users receive a one-time pairing code when they DM the bot:


``` bash
# The user sees: "Pairing code: XKGH5N7P"
# You approve them with:
hermes pairing approve telegram XKGH5N7P

# Other pairing commands:
hermes pairing list          # View pending + approved users
hermes pairing revoke telegram 123456789  # Remove access
```


Pairing codes expire after 1 hour, are rate-limited, and use cryptographic randomness.

## Interrupting the Agent<a href="#interrupting-the-agent" class="hash-link" aria-label="Direct link to Interrupting the Agent" translate="no" title="Direct link to Interrupting the Agent">​</a>

Send any message while the agent is working to interrupt it. Key behaviors:

- **In-progress terminal commands are killed immediately** (SIGTERM, then SIGKILL after 1s)
- **Tool calls are cancelled** — only the currently-executing one runs, the rest are skipped
- **Multiple messages are combined** — messages sent during interruption are joined into one prompt
- **`/stop` command** — interrupts without queuing a follow-up message

## Tool Progress Notifications<a href="#tool-progress-notifications" class="hash-link" aria-label="Direct link to Tool Progress Notifications" translate="no" title="Direct link to Tool Progress Notifications">​</a>

Control how much tool activity is displayed in `~/.hermes/config.yaml`:


``` yaml
display:
  tool_progress: all    # off | new | all | verbose
  tool_progress_command: false  # set to true to enable /verbose in messaging
```


When enabled, the bot sends status messages as it works:


``` text
💻 `ls -la`...
🔍 web_search...
📄 web_extract...
🐍 execute_code...
```


## Background Sessions<a href="#background-sessions" class="hash-link" aria-label="Direct link to Background Sessions" translate="no" title="Direct link to Background Sessions">​</a>

Run a prompt in a separate background session so the agent works on it independently while your main chat stays responsive:


``` text
/background Check all servers in the cluster and report any that are down
```


Hermes confirms immediately:


``` text
🔄 Background task started: "Check all servers in the cluster..."
   Task ID: bg_143022_a1b2c3
```


### How It Works<a href="#how-it-works" class="hash-link" aria-label="Direct link to How It Works" translate="no" title="Direct link to How It Works">​</a>

Each `/background` prompt spawns a **separate agent instance** that runs asynchronously:

- **Isolated session** — the background agent has its own session with its own conversation history. It has no knowledge of your current chat context and receives only the prompt you provide.
- **Same configuration** — inherits your model, provider, toolsets, reasoning settings, and provider routing from the current gateway setup.
- **Non-blocking** — your main chat stays fully interactive. Send messages, run other commands, or start more background tasks while it works.
- **Result delivery** — when the task finishes, the result is sent back to the **same chat or channel** where you issued the command, prefixed with "✅ Background task complete". If it fails, you'll see "❌ Background task failed" with the error.

### Background Process Notifications<a href="#background-process-notifications" class="hash-link" aria-label="Direct link to Background Process Notifications" translate="no" title="Direct link to Background Process Notifications">​</a>

When the agent running a background session uses `terminal(background=true)` to start long-running processes (servers, builds, etc.), the gateway can push status updates to your chat. Control this with `display.background_process_notifications` in `~/.hermes/config.yaml`:


``` yaml
display:
  background_process_notifications: all    # all | result | error | off
```


| Mode | What you receive |
|----|----|
| `all` | Running-output updates **and** the final completion message (default) |
| `result` | Only the final completion message (regardless of exit code) |
| `error` | Only the final message when the exit code is non-zero |
| `off` | No process watcher messages at all |

You can also set this via environment variable:


``` bash
HERMES_BACKGROUND_NOTIFICATIONS=result
```


### Use Cases<a href="#use-cases" class="hash-link" aria-label="Direct link to Use Cases" translate="no" title="Direct link to Use Cases">​</a>

- **Server monitoring** — "/background Check the health of all services and alert me if anything is down"
- **Long builds** — "/background Build and deploy the staging environment" while you continue chatting
- **Research tasks** — "/background Research competitor pricing and summarize in a table"
- **File operations** — "/background Organize the photos in ~/Downloads by date into folders"


Background tasks on messaging platforms are fire-and-forget — you don't need to wait or check on them. Results arrive in the same chat automatically when the task finishes.


## Service Management<a href="#service-management" class="hash-link" aria-label="Direct link to Service Management" translate="no" title="Direct link to Service Management">​</a>

### Linux (systemd)<a href="#linux-systemd" class="hash-link" aria-label="Direct link to Linux (systemd)" translate="no" title="Direct link to Linux (systemd)">​</a>


``` bash
hermes gateway install               # Install as user service
hermes gateway start                 # Start the service
hermes gateway stop                  # Stop the service
hermes gateway status                # Check status
journalctl --user -u hermes-gateway -f  # View logs

# Enable lingering (keeps running after logout)
sudo loginctl enable-linger $USER

# Or install a boot-time system service that still runs as your user
sudo hermes gateway install --system
sudo hermes gateway start --system
sudo hermes gateway status --system
journalctl -u hermes-gateway -f
```


Use the user service on laptops and dev boxes. Use the system service on VPS or headless hosts that should come back at boot without relying on systemd linger.

Avoid keeping both the user and system gateway units installed at once unless you really mean to. Hermes will warn if it detects both because start/stop/status behavior gets ambiguous.


If you run multiple Hermes installations on the same machine (with different `HERMES_HOME` directories), each gets its own systemd service name. The default `~/.hermes` uses `hermes-gateway`; other installations use `hermes-gateway-<hash>`. The `hermes gateway` commands automatically target the correct service for your current `HERMES_HOME`.


### macOS (launchd)<a href="#macos-launchd" class="hash-link" aria-label="Direct link to macOS (launchd)" translate="no" title="Direct link to macOS (launchd)">​</a>


``` bash
hermes gateway install               # Install as launchd agent
hermes gateway start                 # Start the service
hermes gateway stop                  # Stop the service
hermes gateway status                # Check status
tail -f ~/.hermes/logs/gateway.log   # View logs
```


The generated plist lives at `~/Library/LaunchAgents/ai.hermes.gateway.plist`. It includes three environment variables:

- **PATH** — your full shell PATH at install time, with the venv `bin/` and `node_modules/.bin` prepended. This ensures user-installed tools (Node.js, ffmpeg, etc.) are available to gateway subprocesses like the WhatsApp bridge.
- **VIRTUAL_ENV** — points to the Python virtualenv so tools can resolve packages correctly.
- **HERMES_HOME** — scopes the gateway to your Hermes installation.


launchd plists are static — if you install new tools (e.g. a new Node.js version via nvm, or ffmpeg via Homebrew) after setting up the gateway, run `hermes gateway install` again to capture the updated PATH. The gateway will detect the stale plist and reload automatically.


Like the Linux systemd service, each `HERMES_HOME` directory gets its own launchd label. The default `~/.hermes` uses `ai.hermes.gateway`; other installations use `ai.hermes.gateway-<suffix>`.


## Platform-Specific Toolsets<a href="#platform-specific-toolsets" class="hash-link" aria-label="Direct link to Platform-Specific Toolsets" translate="no" title="Direct link to Platform-Specific Toolsets">​</a>

Each platform has its own toolset:

| Platform | Toolset | Capabilities |
|----|----|----|
| CLI | `hermes-cli` | Full access |
| Telegram | `hermes-telegram` | Full tools including terminal |
| Discord | `hermes-discord` | Full tools including terminal |
| WhatsApp | `hermes-whatsapp` | Full tools including terminal |
| Slack | `hermes-slack` | Full tools including terminal |
| Signal | `hermes-signal` | Full tools including terminal |
| SMS | `hermes-sms` | Full tools including terminal |
| Email | `hermes-email` | Full tools including terminal |
| Home Assistant | `hermes-homeassistant` | Full tools + HA device control (ha_list_entities, ha_get_state, ha_call_service, ha_list_services) |
| Mattermost | `hermes-mattermost` | Full tools including terminal |
| Matrix | `hermes-matrix` | Full tools including terminal |
| DingTalk | `hermes-dingtalk` | Full tools including terminal |
| Feishu/Lark | `hermes-feishu` | Full tools including terminal |
| WeCom | `hermes-wecom` | Full tools including terminal |
| API Server | `hermes` (default) | Full tools including terminal |
| Webhooks | `hermes-webhook` | Full tools including terminal |

## Next Steps<a href="#next-steps" class="hash-link" aria-label="Direct link to Next Steps" translate="no" title="Direct link to Next Steps">​</a>

- [Telegram Setup](/docs/user-guide/messaging/telegram)
- [Discord Setup](/docs/user-guide/messaging/discord)
- [Slack Setup](/docs/user-guide/messaging/slack)
- [WhatsApp Setup](/docs/user-guide/messaging/whatsapp)
- [Signal Setup](/docs/user-guide/messaging/signal)
- [SMS Setup (Twilio)](/docs/user-guide/messaging/sms)
- [Email Setup](/docs/user-guide/messaging/email)
- [Home Assistant Integration](/docs/user-guide/messaging/homeassistant)
- [Mattermost Setup](/docs/user-guide/messaging/mattermost)
- [Matrix Setup](/docs/user-guide/messaging/matrix)
- [DingTalk Setup](/docs/user-guide/messaging/dingtalk)
- [Feishu/Lark Setup](/docs/user-guide/messaging/feishu)
- [WeCom Setup](/docs/user-guide/messaging/wecom)
- [Open WebUI + API Server](/docs/user-guide/messaging/open-webui)
- [Webhooks](/docs/user-guide/messaging/webhooks)


- <a href="#architecture" class="table-of-contents__link toc-highlight">Architecture</a>
- <a href="#quick-setup" class="table-of-contents__link toc-highlight">Quick Setup</a>
- <a href="#gateway-commands" class="table-of-contents__link toc-highlight">Gateway Commands</a>
- <a href="#chat-commands-inside-messaging" class="table-of-contents__link toc-highlight">Chat Commands (Inside Messaging)</a>
- <a href="#session-management" class="table-of-contents__link toc-highlight">Session Management</a>
  - <a href="#session-persistence" class="table-of-contents__link toc-highlight">Session Persistence</a>
  - <a href="#reset-policies" class="table-of-contents__link toc-highlight">Reset Policies</a>
- <a href="#security" class="table-of-contents__link toc-highlight">Security</a>
  - <a href="#dm-pairing-alternative-to-allowlists" class="table-of-contents__link toc-highlight">DM Pairing (Alternative to Allowlists)</a>
- <a href="#interrupting-the-agent" class="table-of-contents__link toc-highlight">Interrupting the Agent</a>
- <a href="#tool-progress-notifications" class="table-of-contents__link toc-highlight">Tool Progress Notifications</a>
- <a href="#background-sessions" class="table-of-contents__link toc-highlight">Background Sessions</a>
  - <a href="#how-it-works" class="table-of-contents__link toc-highlight">How It Works</a>
  - <a href="#background-process-notifications" class="table-of-contents__link toc-highlight">Background Process Notifications</a>
  - <a href="#use-cases" class="table-of-contents__link toc-highlight">Use Cases</a>
- <a href="#service-management" class="table-of-contents__link toc-highlight">Service Management</a>
  - <a href="#linux-systemd" class="table-of-contents__link toc-highlight">Linux (systemd)</a>
  - <a href="#macos-launchd" class="table-of-contents__link toc-highlight">macOS (launchd)</a>
- <a href="#platform-specific-toolsets" class="table-of-contents__link toc-highlight">Platform-Specific Toolsets</a>
- <a href="#next-steps" class="table-of-contents__link toc-highlight">Next Steps</a>


