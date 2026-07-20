> Source: https://hermes-agent.nousresearch.com/docs/user-guide/messaging/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Messaging Gateway


Chat with Hermes from Telegram, Discord, Slack, WhatsApp, Signal, SMS, Email, Home Assistant, Mattermost, Matrix, DingTalk, Feishu/Lark, WeCom, Weixin, BlueBubbles (iMessage), QQ, Yuanbao, Microsoft Teams, LINE, ntfy, or your browser. The gateway is a single background process that connects to all your configured platforms, handles sessions, runs cron jobs, and delivers voice messages.

For the full voice feature set — including CLI microphone mode, spoken replies in messaging, and Discord voice-channel conversations — see [Voice Mode](/docs/user-guide/features/voice-mode) and [Use Voice Mode with Hermes](/docs/guides/use-voice-mode-with-hermes).


Bots need both a model provider and tool providers (TTS, web). A [Nous Portal](/docs/integrations/nous-portal) subscription bundles all of them.


## Platform Comparison<a href="#platform-comparison" class="hash-link" aria-label="Direct link to Platform Comparison" translate="no" title="Direct link to Platform Comparison">​</a>

| Platform        | Voice | Images | Files | Threads | Reactions | Typing | Streaming |
|-----------------|:-----:|:------:|:-----:|:-------:|:---------:|:------:|:---------:|
| Telegram        |  ✅   |   ✅   |  ✅   |   ✅    |     —     |   ✅   |    ✅     |
| Discord         |  ✅   |   ✅   |  ✅   |   ✅    |    ✅     |   ✅   |    ✅     |
| Slack           |  ✅   |   ✅   |  ✅   |   ✅    |    ✅     |   ✅   |    ✅     |
| Google Chat     |   —   |   ✅   |  ✅   |   ✅    |     —     |   ✅   |     —     |
| WhatsApp        |   —   |   ✅   |  ✅   |    —    |     —     |   ✅   |    ✅     |
| Signal          |   —   |   ✅   |  ✅   |    —    |     —     |   ✅   |    ✅     |
| SMS             |   —   |   —    |   —   |    —    |     —     |   —    |     —     |
| Email           |   —   |   ✅   |  ✅   |   ✅    |     —     |   —    |     —     |
| Home Assistant  |   —   |   —    |   —   |    —    |     —     |   —    |     —     |
| Mattermost      |  ✅   |   ✅   |  ✅   |   ✅    |     —     |   ✅   |    ✅     |
| Matrix          |  ✅   |   ✅   |  ✅   |   ✅    |    ✅     |   ✅   |    ✅     |
| DingTalk        |   —   |   ✅   |  ✅   |    —    |    ✅     |   —    |    ✅     |
| Feishu/Lark     |  ✅   |   ✅   |  ✅   |   ✅    |    ✅     |   ✅   |    ✅     |
| WeCom           |  ✅   |   ✅   |  ✅   |    —    |     —     |   —    |     —     |
| WeCom Callback  |   —   |   —    |   —   |    —    |     —     |   —    |     —     |
| Weixin          |  ✅   |   ✅   |  ✅   |    —    |     —     |   ✅   |    ✅     |
| BlueBubbles     |   —   |   ✅   |  ✅   |    —    |    ✅     |   ✅   |     —     |
| QQ              |  ✅   |   ✅   |  ✅   |    —    |     —     |   ✅   |     —     |
| Yuanbao         |  ✅   |   ✅   |  ✅   |    —    |     —     |   ✅   |    ✅     |
| Microsoft Teams |   —   |   ✅   |   —   |   ✅    |     —     |   ✅   |     —     |
| LINE            |   —   |   ✅   |  ✅   |    —    |     —     |   ✅   |     —     |
| ntfy            |   —   |   —    |   —   |    —    |     —     |   —    |     —     |
| Raft            |   —   |   —    |   —   |    —    |     —     |   —    |     —     |
| IRC             |   —   |   —    |   —   |    —    |     —     |   —    |     —     |

**Voice** = TTS audio replies and/or voice message transcription. **Images** = send/receive images. **Files** = send/receive file attachments. **Threads** = threaded conversations. **Reactions** = emoji reactions on messages. **Typing** = typing indicator while processing. **Streaming** = progressive message updates via editing.

## Architecture<a href="#architecture" class="hash-link" aria-label="Direct link to Architecture" translate="no" title="Direct link to Architecture">​</a>

Each platform adapter receives messages, routes them through a per-chat session store, and dispatches them to the AIAgent for processing. The gateway also runs the cron scheduler, ticking every 60 seconds to execute any due jobs.

## Intentional Silence Tokens<a href="#intentional-silence-tokens" class="hash-link" aria-label="Direct link to Intentional Silence Tokens" translate="no" title="Direct link to Intentional Silence Tokens">​</a>

For group chats, hooks, and automation flows, Hermes supports explicit silence tokens. If the agent's final response is exactly one supported token, the gateway suppresses outbound delivery and sends nothing to the chat.

Supported tokens:

- `[SILENT]`
- `SILENT`
- `NO_REPLY`
- `NO REPLY`

Whitespace and case are normalized, but the whole final response must be the token. A sentence like "Use `[SILENT]` when nothing changed" is delivered normally.

Silence is a delivery decision only. Hermes keeps the assistant silence turn in the session transcript, so the conversation still alternates normally:


``` prism-code
user: side-channel chatter
assistant: [SILENT]   # stored, not delivered
user: next message
```


Failed turns still surface as errors; Hermes does not hide failures just because the text resembles a silence token.

## Quick Setup<a href="#quick-setup" class="hash-link" aria-label="Direct link to Quick Setup" translate="no" title="Direct link to Quick Setup">​</a>

The easiest way to configure messaging platforms is the interactive wizard:


``` prism-code
hermes gateway setup        # Interactive setup for all messaging platforms
```


This walks you through configuring each platform with arrow-key selection, shows which platforms are already configured, and offers to start/restart the gateway when done.

## Gateway Commands<a href="#gateway-commands" class="hash-link" aria-label="Direct link to Gateway Commands" translate="no" title="Direct link to Gateway Commands">​</a>


``` prism-code
hermes gateway              # Run in foreground
hermes gateway setup        # Configure messaging platforms interactively
hermes gateway install      # Install as a user service (Linux) / launchd service (macOS)
sudo hermes gateway install --system   # Linux only: install a boot-time system service
hermes gateway start        # Start the default service
hermes gateway stop         # Stop the default service
hermes gateway status       # Check default service status
hermes gateway status --system         # Linux only: inspect the system service explicitly
```


### Optional Linux event-loop watchdog<a href="#optional-linux-event-loop-watchdog" class="hash-link" aria-label="Direct link to Optional Linux event-loop watchdog" translate="no" title="Direct link to Optional Linux event-loop watchdog">​</a>

A systemd-managed gateway can opt into process recovery when Python's asyncio event loop stops receiving scheduling time. This covers whole-process stalls that also prevent platform-specific liveness tasks from running:


~/.hermes/config.yaml


``` prism-code
gateway:
  systemd_watchdog_seconds: 120
```


Regenerate the service unit after changing this setting:


``` prism-code
hermes gateway install --force
```


A positive value makes the generated unit use `Type=notify`, `NotifyAccess=main`, and the matching `WatchdogSec`. Hermes sends heartbeats only while its event loop is making timely progress; systemd restarts the process when they stop. The default `0` keeps the existing `Type=simple` behavior. This setting is Linux/systemd-only and does not treat an ordinary platform network disconnect as an event-loop failure.

## Chat Commands (Inside Messaging)<a href="#chat-commands-inside-messaging" class="hash-link" aria-label="Direct link to Chat Commands (Inside Messaging)" translate="no" title="Direct link to Chat Commands (Inside Messaging)">​</a>

| Command                                 | Description                                                                                     |
|-----------------------------------------|-------------------------------------------------------------------------------------------------|
| `/new` or `/reset`                      | Start a fresh conversation                                                                      |
| `/model [provider:model]`               | Show or change the model (supports `provider:model` syntax)                                     |
| `/personality [name]`                   | Set a personality                                                                               |
| `/retry`                                | Retry the last message                                                                          |
| `/undo`                                 | Remove the last exchange                                                                        |
| `/status`                               | Show session info                                                                               |
| `/whoami`                               | Show your slash command access on this scope (admin / user / unrestricted)                      |
| `/stop`                                 | Stop the running agent                                                                          |
| `/approve`                              | Approve a pending dangerous command                                                             |
| `/deny`                                 | Reject a pending dangerous command                                                              |
| `/sethome`                              | Set this chat as the home channel                                                               |
| `/compress`                             | Manually compress conversation context                                                          |
| `/title [name]`                         | Set or show the session title                                                                   |
| `/resume [name]`                        | Resume a previously named session                                                               |
| `/usage`                                | Show token usage for this session (`/usage reset [--force]` redeems a banked Codex limit reset) |
| `/insights [days]`                      | Show usage insights and analytics                                                               |
| `/reasoning [level|show|hide]`          | Change reasoning effort or toggle reasoning display                                             |
| `/voice [on|off|tts|join|leave|status]` | Control messaging voice replies and Discord voice-channel behavior                              |
| `/rollback [number]`                    | List or restore filesystem checkpoints                                                          |
| `/background <prompt>`                  | Run a prompt in a separate background session                                                   |
| `/reload-mcp`                           | Reload MCP servers from config                                                                  |
| `/update`                               | Update Hermes Agent to the latest version                                                       |
| `/help`                                 | Show available commands                                                                         |
| `/<skill-name>`                         | Invoke any installed skill                                                                      |

## Session Management<a href="#session-management" class="hash-link" aria-label="Direct link to Session Management" translate="no" title="Direct link to Session Management">​</a>

### Session Persistence<a href="#session-persistence" class="hash-link" aria-label="Direct link to Session Persistence" translate="no" title="Direct link to Session Persistence">​</a>

Sessions persist across messages until they reset. The agent remembers your conversation context.

### Delivery Reliability<a href="#delivery-reliability" class="hash-link" aria-label="Direct link to Delivery Reliability" translate="no" title="Direct link to Delivery Reliability">​</a>

Final agent responses are recorded in a durable **delivery ledger** (`state.db`) around each platform send. If the gateway crashes or restarts between producing a response and the platform confirming receipt, the next boot redelivers the stored response instead of losing it — or re-running the whole turn.

Semantics are honest at-least-once:

- A response whose send **never started** is redelivered as-is.
- A response that was **mid-send** when the gateway died (the platform may or may not have received it) is redelivered with a visible "♻️ Recovered reply — … may be a duplicate" prefix. Ambiguity is labeled, never silently resent.
- Redelivery is bounded: 3 attempts, 24-hour freshness, then the row is abandoned. Delivered rows are pruned after 7 days.

Disable with `gateway.delivery_ledger: false` in `config.yaml` (restores the old behavior: in-flight responses are lost on crash).

### Reset Policies<a href="#reset-policies" class="hash-link" aria-label="Direct link to Reset Policies" translate="no" title="Direct link to Reset Policies">​</a>

**By default sessions never auto-reset** — context lives until you `/reset` manually or context compression kicks in. If you want automatic resets, opt in with the `session_reset` section in `~/.hermes/config.yaml`:


``` prism-code
session_reset:
  mode: idle        # "idle", "daily", "both", or "none" (default)
  idle_minutes: 1440  # for idle/both: minutes of inactivity before reset
  at_hour: 4          # for daily/both: hour of day (0-23, local time)
```


| Mode    | Description                         |
|---------|-------------------------------------|
| `none`  | Never auto-reset (default)          |
| `daily` | Reset at a specific hour each day   |
| `idle`  | Reset after N minutes of inactivity |
| `both`  | Whichever triggers first            |

A live background process (started with `terminal(background=true)`) normally protects its session from resetting so output isn't lost. To stop a forgotten process — say a preview server — from pinning a session open forever, a background process older than `bg_process_max_age_hours` (default **24**) no longer blocks reset. The process is **not** killed, only ignored by the reset guard. Set it to `0` to disable the cutoff (any live process blocks reset, the old behavior), or raise it if you run legitimate multi-day jobs whose liveness should keep the conversation open.

Configure per-platform overrides in `~/.hermes/gateway.json`:


``` prism-code
{
  "reset_by_platform": {
    "telegram": { "mode": "idle", "idle_minutes": 240 },
    "discord": { "mode": "idle", "idle_minutes": 60 }
  }
}
```


## Security<a href="#security" class="hash-link" aria-label="Direct link to Security" translate="no" title="Direct link to Security">​</a>

**By default, the gateway denies all users who are not in an allowlist or paired via DM.** This is the safe default for a bot with terminal access.


``` prism-code
# Restrict to specific users (recommended):
TELEGRAM_ALLOWED_USERS=123456789,987654321
DISCORD_ALLOWED_USERS=123456789012345678
SIGNAL_ALLOWED_USERS=+155****4567,+155****6543
SMS_ALLOWED_USERS=+155****4567,+155****6543
EMAIL_ALLOWED_USERS=trusted@example.com,colleague@work.com
MATTERMOST_ALLOWED_USERS=3uo8dkh1p7g1mfk49ear5fzs5c
MATRIX_ALLOWED_USERS=@alice:matrix.org
DINGTALK_ALLOWED_USERS=user-id-1
FEISHU_ALLOWED_USERS=ou_xxxxxxxx,ou_yyyyyyyy
WECOM_ALLOWED_USERS=user-id-1,user-id-2
WECOM_CALLBACK_ALLOWED_USERS=user-id-1,user-id-2
TEAMS_ALLOWED_USERS=aad-object-id-1,aad-object-id-2

# Or allow
GATEWAY_ALLOWED_USERS=123456789,987654321

# Or explicitly allow all users (NOT recommended for bots with terminal access):
GATEWAY_ALLOW_ALL_USERS=true
```


### DM Pairing (Alternative to Allowlists)<a href="#dm-pairing-alternative-to-allowlists" class="hash-link" aria-label="Direct link to DM Pairing (Alternative to Allowlists)" translate="no" title="Direct link to DM Pairing (Alternative to Allowlists)">​</a>

Instead of manually configuring user IDs, unknown users receive a one-time pairing code when they DM the bot. Email is the exception: unknown email senders are ignored unless email pairing is explicitly enabled.


``` prism-code
# The user sees: "Pairing code: XKGH5N7P"
# You approve them with:
hermes pairing approve telegram XKGH5N7P

# Other pairing commands:
hermes pairing list          # View pending + approved users
hermes pairing revoke telegram 123456789  # Remove access
```


Pairing codes expire after 1 hour, are rate-limited, and use cryptographic randomness.

### Admins vs Regular Users<a href="#admins-vs-regular-users" class="hash-link" aria-label="Direct link to Admins vs Regular Users" translate="no" title="Direct link to Admins vs Regular Users">​</a>

Allowlists answer "can this person reach the bot at all?" The **admin / user split** answers "now that they're in, what are they allowed to do?"

Every allowed user falls into one of two tiers per scope (DM vs group/channel):

- **Admin** — full access. Can run every registered slash command (built-in + plugin) and use every gated capability.
- **Regular user** — restricted access. Can chat with the agent normally, but can only run the slash commands you explicitly enable. The always-allowed floor is `/help` and `/whoami`.

The tiers are configured per platform and per scope. DM admin status does not imply group/channel admin status — each scope has its own admin list.

**What the tiers gate today:** slash commands. The split runs through the live command registry, so it covers built-ins and plugin-registered commands without per-feature wiring. Plain chat is not affected — non-admins can still talk to the agent.

**What may be gated in the future:** more capability surfaces (tool access, model switching, expensive operations) will hang off the same admin / user distinction as we add them. Configuring the split now means those future restrictions land cleanly without you having to re-model who's an admin.

#### Configuration<a href="#configuration" class="hash-link" aria-label="Direct link to Configuration" translate="no" title="Direct link to Configuration">​</a>


``` prism-code
gateway:
  platforms:
    discord:
      extra:
        allow_from: ["111", "222", "333"]
        allow_admin_from: ["111"]                    # admins → all slash commands
        user_allowed_commands: [status, model]       # what non-admins may run
        # Optional: separate group/channel scope
        group_allow_admin_from: ["111"]
        group_user_allowed_commands: [status]
```


**Backward compat:** if `allow_admin_from` is not set for a scope, the tier split is disabled for that scope and every allowed user has full access. Existing installs keep working with no changes — opt in when you want the distinction.

#### Inspecting your access<a href="#inspecting-your-access" class="hash-link" aria-label="Direct link to Inspecting your access" translate="no" title="Direct link to Inspecting your access">​</a>

Use `/whoami` from any platform to see the active scope, your tier (admin / user / unrestricted), and which slash commands you can run. See the [Telegram](/docs/user-guide/messaging/telegram#slash-command-access-control) and [Discord](/docs/user-guide/messaging/discord#slash-command-access-control) pages for platform-specific examples.

## Interrupting the Agent<a href="#interrupting-the-agent" class="hash-link" aria-label="Direct link to Interrupting the Agent" translate="no" title="Direct link to Interrupting the Agent">​</a>

Send any message while the agent is working to interrupt it. Key behaviors:

- **In-progress terminal commands are killed immediately** (SIGTERM, then SIGKILL after 1s)
- **Tool calls are cancelled** — only the currently-executing one runs, the rest are skipped
- **Multiple messages are combined** — messages sent during interruption are joined into one prompt
- **`/stop` command** — interrupts without queuing a follow-up message

### Queue vs interrupt vs steer (busy-input mode)<a href="#queue-vs-interrupt-vs-steer-busy-input-mode" class="hash-link" aria-label="Direct link to Queue vs interrupt vs steer (busy-input mode)" translate="no" title="Direct link to Queue vs interrupt vs steer (busy-input mode)">​</a>

By default, messaging a busy agent interrupts it. Two other modes are available:

- `queue` — follow-up messages wait and run as the next turn after the current task finishes.
- `steer` — follow-up messages are injected into the current run via `/steer`, arriving at the agent after the next tool call. No interrupt, no new turn. Falls back to `queue` behavior if the agent hasn't started yet.


``` prism-code
display:
  busy_input_mode: steer   # or queue, or interrupt (default)
  busy_ack_enabled: true   # set to false to suppress the ⚡/⏳/⏩ chat reply entirely
```


The first time you message a busy agent on any platform, Hermes appends a one-line reminder to the busy-ack explaining the knob (`"💡 First-time tip — …"`). The reminder fires once per install — a flag under `onboarding.seen.busy_input_prompt` latches it. Delete that key to see the tip again.

If you find the busy-ack noisy — especially with voice input or rapid-fire messages — set `display.busy_ack_enabled: false`. Your input is still queued/steered/interrupts as normal, only the chat reply is silenced.

## Tool Progress Notifications<a href="#tool-progress-notifications" class="hash-link" aria-label="Direct link to Tool Progress Notifications" translate="no" title="Direct link to Tool Progress Notifications">​</a>

Control how much tool activity is displayed in `~/.hermes/config.yaml`:


``` prism-code
display:
  tool_progress: all    # off | new | all | verbose
  tool_progress_command: false  # set to true to enable /verbose in messaging
  # How progress is grouped on platforms that support message editing:
  #   accumulate (default) — edit one bubble in place as tools run
  #   separate             — send one message per tool (pre-v0.9 style; noisier)
  # Only applies where tool_progress is already enabled.
  tool_progress_grouping: accumulate   # accumulate | separate
```


### Message timestamps in model context<a href="#message-timestamps-in-model-context" class="hash-link" aria-label="Direct link to Message timestamps in model context" translate="no" title="Direct link to Message timestamps in model context">​</a>

Off by default. When enabled, Hermes prepends a human-readable timestamp (e.g. `[Tue 2026-04-28 13:40:53 CEST]`) onto each **user** message *in the model's context* so the agent knows when messages were sent — useful for temporal reasoning ("you asked this morning…", noticing a long gap). It is **not** added to assistant messages or the system prompt.


``` prism-code
gateway:
  message_timestamps:
    enabled: false   # set true to show send-times to the model
```


Persisted transcripts always stay clean — the timestamp is stored as message metadata regardless of this toggle, so enabling it later also surfaces send-times for past messages, and replay never accumulates duplicate prefixes.

When enabled, the bot sends status messages as it works:


``` prism-code
💻 `ls -la`...
🔍 web_search...
📄 web_extract...
🐍 execute_code...
```


## Background Sessions<a href="#background-sessions" class="hash-link" aria-label="Direct link to Background Sessions" translate="no" title="Direct link to Background Sessions">​</a>

Run a prompt in a separate background session so the agent works on it independently while your main chat stays responsive:


``` prism-code
/background Check all servers in the cluster and report any that are down
```


Hermes confirms immediately:


``` prism-code
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


``` prism-code
display:
  background_process_notifications: all    # all | result | error | off
```


| Mode     | What you receive                                                      |
|----------|-----------------------------------------------------------------------|
| `all`    | Running-output updates **and** the final completion message (default) |
| `result` | Only the final completion message (regardless of exit code)           |
| `error`  | Only the final message when the exit code is non-zero                 |
| `off`    | No process watcher messages at all                                    |

You can also set this via environment variable:


``` prism-code
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


``` prism-code
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


The unit Hermes installs already shuts the gateway down cleanly with `KillMode=mixed` + `KillSignal=SIGTERM`, and uses `Restart=always` with `RestartForceExitStatus` so updates and `/restart` respawn correctly. Do **not** add a systemd drop-in such as `ExecStopPost=/bin/kill -9 $MAINPID` — `ExecStopPost` fires on *every* stop, including clean restarts, so it `SIGKILL`s the freshly spawned instance before it stabilizes and `Restart=always` immediately respawns it. The result is an infinite restart loop (and, on Telegram, a flood of restart messages). If you've added such a drop-in, remove it: `systemctl --user edit hermes-gateway` (or `sudo systemctl edit hermes-gateway` for a system service) and delete the `ExecStopPost` line, then `systemctl --user daemon-reload`.


A system service needs root for every restart — including the automatic gateway restart at the end of `hermes update`. When `hermes update` runs as a non-root user, it tries passwordless `sudo systemctl`; if that's unavailable, it skips the restart and prints the manual `sudo systemctl restart hermes-gateway` command (it never blocks on an interactive password prompt).

For a headless VM you never log into, a **user** service with lingering enabled gives you the same start-at-boot behavior with zero root involvement:


``` prism-code
hermes gateway install          # user service
sudo loginctl enable-linger $USER   # one-time: start at boot, survive logout
```


After that, `hermes update` can restart the gateway without any privileges. If you prefer to keep the system service, either run updates with `sudo hermes update`, or grant the service account passwordless sudo for systemctl, e.g. in `sudo visudo -f /etc/sudoers.d/hermes-gateway`:


``` prism-code
hermes ALL=(root) NOPASSWD: /usr/bin/systemctl --no-ask-password reset-failed hermes-gateway*, /usr/bin/systemctl --no-ask-password start hermes-gateway*, /usr/bin/systemctl --no-ask-password restart hermes-gateway*
```


Avoid keeping both the user and system gateway units installed at once unless you really mean to. Hermes will warn if it detects both because start/stop/status behavior gets ambiguous.


If you run multiple Hermes installations on the same machine (with different `HERMES_HOME` directories), each gets its own systemd service name. The default `~/.hermes` uses `hermes-gateway`; other installations use `hermes-gateway-<hash>`. The `hermes gateway` commands automatically target the correct service for your current `HERMES_HOME`.


### macOS (launchd)<a href="#macos-launchd" class="hash-link" aria-label="Direct link to macOS (launchd)" translate="no" title="Direct link to macOS (launchd)">​</a>


``` prism-code
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

| Platform           | Toolset                 | Capabilities                                                                                          |
|--------------------|-------------------------|-------------------------------------------------------------------------------------------------------|
| CLI                | `hermes-cli`            | Full access                                                                                           |
| Telegram           | `hermes-telegram`       | Full tools including terminal                                                                         |
| Discord            | `hermes-discord`        | Full tools including terminal                                                                         |
| WhatsApp           | `hermes-whatsapp`       | Full tools including terminal                                                                         |
| WhatsApp Cloud API | `hermes-whatsapp`       | Full tools including terminal (shares toolset with the Baileys bridge)                                |
| Slack              | `hermes-slack`          | Full tools including terminal                                                                         |
| Google Chat        | `hermes-google_chat`    | Full tools including terminal                                                                         |
| Signal             | `hermes-signal`         | Full tools including terminal                                                                         |
| SMS                | `hermes-sms`            | Full tools including terminal                                                                         |
| Email              | `hermes-email`          | Full tools including terminal                                                                         |
| Home Assistant     | `hermes-homeassistant`  | Full tools + HA device control (ha_list_entities, ha_get_state, ha_call_service, ha_list_services)    |
| Mattermost         | `hermes-mattermost`     | Full tools including terminal                                                                         |
| Matrix             | `hermes-matrix`         | Full tools including terminal                                                                         |
| DingTalk           | `hermes-dingtalk`       | Full tools including terminal                                                                         |
| Feishu/Lark        | `hermes-feishu`         | Full tools including terminal                                                                         |
| WeCom              | `hermes-wecom`          | Full tools including terminal                                                                         |
| WeCom Callback     | `hermes-wecom-callback` | Full tools including terminal                                                                         |
| Weixin             | `hermes-weixin`         | Full tools including terminal                                                                         |
| BlueBubbles        | `hermes-bluebubbles`    | Full tools including terminal                                                                         |
| QQBot              | `hermes-qqbot`          | Full tools including terminal                                                                         |
| Yuanbao            | `hermes-yuanbao`        | Full tools including terminal                                                                         |
| Microsoft Teams    | `hermes-teams`          | Full tools including terminal                                                                         |
| API Server         | `hermes-api-server`     | Full tools (drops `clarify`, `text_to_speech` — programmatic access doesn't have an interactive user) |
| Webhooks           | `hermes-webhook`        | Full tools including terminal                                                                         |
| Raft               | `hermes-raft`           | Wake-only channel; agent uses Raft CLI for message I/O                                                |

## Operating a multi-platform gateway<a href="#operating-a-multi-platform-gateway" class="hash-link" aria-label="Direct link to Operating a multi-platform gateway" translate="no" title="Direct link to Operating a multi-platform gateway">​</a>

A gateway typically runs several adapters at once (Telegram + Discord + Slack, etc.). The sections below cover day-2 operations that span all platforms.

### `/platform` command<a href="#platform-command" class="hash-link" aria-label="Direct link to platform-command" translate="no" title="Direct link to platform-command">​</a>

Once the gateway is running, use the `/platform` slash command from any connected CLI session or chat to inspect and steer individual adapters without restarting the whole gateway:


``` prism-code
/platform list                  # show all adapters and their state
/platform pause <name>          # stop dispatching new messages to one adapter
/platform resume <name>         # re-enable a paused adapter
```


`/platform list` shows whether each adapter is `running`, `paused` (manually), or `paused-by-breaker` (see below). Pausing keeps the adapter loaded and its background loops alive — incoming messages are dropped on the floor, but the connection itself stays open so resume is instant.

See also the broader status summary command [`/platforms`](/docs/reference/slash-commands#info).

### Automatic circuit breaker<a href="#automatic-circuit-breaker" class="hash-link" aria-label="Direct link to Automatic circuit breaker" translate="no" title="Direct link to Automatic circuit breaker">​</a>

Each adapter is wrapped in a circuit breaker. Repeated retryable failures (network blips, rate-limit replies, 5xx upstream responses, websocket disconnects) cause the breaker to trip — the adapter is auto-paused, an operator notification is sent to the home channel of another live platform when one is configured, and a structured log line is emitted.

The breaker does **not** auto-resume — it stays open until you run `/platform resume <name>` manually. This is intentional: if a platform is in a sustained outage, you don't want the gateway thrashing reconnects.

### Where to look when a platform is paused<a href="#where-to-look-when-a-platform-is-paused" class="hash-link" aria-label="Direct link to Where to look when a platform is paused" translate="no" title="Direct link to Where to look when a platform is paused">​</a>

When an adapter is paused, check:

1.  **Gateway log** (`~/.hermes/logs/gateway.log` or the systemd / launchd unit log). Search for the platform name and `circuit breaker`, `paused`, or `disabled`. The trip event includes the failure count and the last error.
2.  **`/platform list`** output — shows the current state and last reason.
3.  **The provider's status page** (Telegram bot API status, Discord status, etc.). The breaker tripped because the platform was unhealthy; don't try to resume until it's back.

Once upstream is healthy, `/platform resume <name>` clears the breaker and re-arms the adapter.

### Restart notifications<a href="#restart-notifications" class="hash-link" aria-label="Direct link to Restart notifications" translate="no" title="Direct link to Restart notifications">​</a>

When the gateway restarts (or is shut down with in-flight sessions), it can send a one-shot "the agent is back" / "the agent was interrupted" message to each platform's home channel. This is controlled per-platform by the `gateway_restart_notification` flag in `gateway-config.yaml`, which defaults to `true`:


``` prism-code
gateway:
  platforms:
    telegram:
      home_chat_id: "123456789"
      gateway_restart_notification: false   # opt out for this platform
    discord:
      home_chat_id: "987654321"
      # gateway_restart_notification omitted → defaults to true
```


Disable it on noisy or low-priority platforms while leaving it on for your primary chat. The notification is sent once per restart, regardless of how many sessions were in flight.

### Typing indicators<a href="#typing-indicators" class="hash-link" aria-label="Direct link to Typing indicators" translate="no" title="Direct link to Typing indicators">​</a>

While the agent is processing a message, the gateway shows a live typing status on platforms that support it — a "typing…" bubble on Telegram/Discord/Signal, or the "is thinking…" assistant status on Slack. This is controlled per-platform by the `typing_indicator` flag in `gateway-config.yaml`, which defaults to `true`:


``` prism-code
gateway:
  platforms:
    slack:
      typing_indicator: false   # don't show "is thinking…" on Slack
    telegram:
      # typing_indicator omitted → defaults to true
```


Set `typing_indicator: false` on any platform where the indicator is unwanted. Some users find Slack's "is thinking…" status noisy (it also briefly disables the compose box while shown, since it uses Slack's Assistant API). Disabling it only suppresses the indicator — message delivery and everything else is unchanged. The flag is generic, so the same key works for every platform.

### Session resume across gateway restarts<a href="#session-resume-across-gateway-restarts" class="hash-link" aria-label="Direct link to Session resume across gateway restarts" translate="no" title="Direct link to Session resume across gateway restarts">​</a>

When the gateway shuts down with an in-flight tool call or generation, the affected sessions are flagged as `restart_interrupted`. On the next startup, the gateway schedules an auto-resume for each one — the user gets a short heads-up in the chat ("Send any message after restart and I'll try to resume where you left off.") and the session picks up from the last committed turn when they reply.

This behaviour is on by default and is logged at gateway start:


``` prism-code
Scheduled auto-resume for N restart-interrupted session(s)
```


No configuration is required. If you don't want the heads-up, set `gateway_restart_notification: false` on the platform.

### Mobile-friendly progress defaults<a href="#mobile-friendly-progress-defaults" class="hash-link" aria-label="Direct link to Mobile-friendly progress defaults" translate="no" title="Direct link to Mobile-friendly progress defaults">​</a>

Telegram is usually a mobile inbox, so the defaults are tuned for that surface:

- **`tool_progress`** defaults to **`off`** — no per-tool breadcrumb stream filling up the chat.
- **`busy_ack_detail`** defaults to **`off`** — busy-state acknowledgments and long-running heartbeats stay terse (no `iteration 21/60` debug detail).
- **`interim_assistant_messages`** stays **on** — real mid-turn assistant commentary (the model literally telling you what it's about to do) is signal, not noise.
- **`long_running_notifications`** stays **on** — a single edit-in-place "⏳ Working — N min" bubble updates every few minutes so you have a heartbeat instead of staring at `typing…` for half an hour.

Opt out of either of the kept-on defaults or opt back into verbose progress per platform:


``` prism-code
display:
  platforms:
    telegram:
      # Re-enable the tool-progress stream
      tool_progress: new
      # Show "iteration N/M, running: tool" in heartbeats and busy acks
      busy_ack_detail: true
      # Or quiet them entirely
      interim_assistant_messages: false
      long_running_notifications: false
```


### Progress bubble cleanup (opt-in)<a href="#progress-bubble-cleanup-opt-in" class="hash-link" aria-label="Direct link to Progress bubble cleanup (opt-in)" translate="no" title="Direct link to Progress bubble cleanup (opt-in)">​</a>

Tool-progress messages, the "still working…" heartbeat, and status-callback bubbles can also be auto-deleted after the final response lands. Enable per-platform via `display.platforms.<platform>.cleanup_progress`:


``` prism-code
display:
  platforms:
    telegram:
      cleanup_progress: true
    discord:
      cleanup_progress: true
```


Defaults to `false`. Only platforms whose adapter implements `delete_message` honor the setting (currently Telegram and Discord). Failed runs **skip** cleanup so the bubbles remain as breadcrumbs.

## Next Steps<a href="#next-steps" class="hash-link" aria-label="Direct link to Next Steps" translate="no" title="Direct link to Next Steps">​</a>

- [Telegram Setup](/docs/user-guide/messaging/telegram)
- [Discord Setup](/docs/user-guide/messaging/discord)
- [Slack Setup](/docs/user-guide/messaging/slack)
- [Google Chat Setup](/docs/user-guide/messaging/google_chat)
- [WhatsApp Setup](/docs/user-guide/messaging/whatsapp)
- [WhatsApp Business Cloud API Setup](/docs/user-guide/messaging/whatsapp-cloud)
- [Signal Setup](/docs/user-guide/messaging/signal)
- [SMS Setup (Twilio)](/docs/user-guide/messaging/sms)
- [Email Setup](/docs/user-guide/messaging/email)
- [Home Assistant Integration](/docs/user-guide/messaging/homeassistant)
- [Mattermost Setup](/docs/user-guide/messaging/mattermost)
- [Matrix Setup](/docs/user-guide/messaging/matrix)
- [DingTalk Setup](/docs/user-guide/messaging/dingtalk)
- [Feishu/Lark Setup](/docs/user-guide/messaging/feishu)
- [WeCom Setup](/docs/user-guide/messaging/wecom)
- [WeCom Callback Setup](/docs/user-guide/messaging/wecom-callback)
- [Weixin Setup (WeChat)](/docs/user-guide/messaging/weixin)
- [BlueBubbles Setup (iMessage)](/docs/user-guide/messaging/bluebubbles)
- [QQBot Setup](/docs/user-guide/messaging/qqbot)
- [Yuanbao Setup](/docs/user-guide/messaging/yuanbao)
- [Microsoft Teams Setup](/docs/user-guide/messaging/teams)
- [Teams Meetings Pipeline](/docs/user-guide/messaging/teams-meetings)
- [Open WebUI + API Server](/docs/user-guide/messaging/open-webui)
- [Raft Setup](/docs/user-guide/messaging/raft)
- [IRC Setup](/docs/user-guide/messaging/irc)
- [Webhooks](/docs/user-guide/messaging/webhooks)


- <a href="#platform-comparison" class="table-of-contents__link toc-highlight">Platform Comparison</a>
- <a href="#architecture" class="table-of-contents__link toc-highlight">Architecture</a>
- <a href="#intentional-silence-tokens" class="table-of-contents__link toc-highlight">Intentional Silence Tokens</a>
- <a href="#quick-setup" class="table-of-contents__link toc-highlight">Quick Setup</a>
- <a href="#gateway-commands" class="table-of-contents__link toc-highlight">Gateway Commands</a>
  - <a href="#optional-linux-event-loop-watchdog" class="table-of-contents__link toc-highlight">Optional Linux event-loop watchdog</a>
- <a href="#chat-commands-inside-messaging" class="table-of-contents__link toc-highlight">Chat Commands (Inside Messaging)</a>
- <a href="#session-management" class="table-of-contents__link toc-highlight">Session Management</a>
  - <a href="#session-persistence" class="table-of-contents__link toc-highlight">Session Persistence</a>
  - <a href="#delivery-reliability" class="table-of-contents__link toc-highlight">Delivery Reliability</a>
  - <a href="#reset-policies" class="table-of-contents__link toc-highlight">Reset Policies</a>
- <a href="#security" class="table-of-contents__link toc-highlight">Security</a>
  - <a href="#dm-pairing-alternative-to-allowlists" class="table-of-contents__link toc-highlight">DM Pairing (Alternative to Allowlists)</a>
  - <a href="#admins-vs-regular-users" class="table-of-contents__link toc-highlight">Admins vs Regular Users</a>
- <a href="#interrupting-the-agent" class="table-of-contents__link toc-highlight">Interrupting the Agent</a>
  - <a href="#queue-vs-interrupt-vs-steer-busy-input-mode" class="table-of-contents__link toc-highlight">Queue vs interrupt vs steer (busy-input mode)</a>
- <a href="#tool-progress-notifications" class="table-of-contents__link toc-highlight">Tool Progress Notifications</a>
  - <a href="#message-timestamps-in-model-context" class="table-of-contents__link toc-highlight">Message timestamps in model context</a>
- <a href="#background-sessions" class="table-of-contents__link toc-highlight">Background Sessions</a>
  - <a href="#how-it-works" class="table-of-contents__link toc-highlight">How It Works</a>
  - <a href="#background-process-notifications" class="table-of-contents__link toc-highlight">Background Process Notifications</a>
  - <a href="#use-cases" class="table-of-contents__link toc-highlight">Use Cases</a>
- <a href="#service-management" class="table-of-contents__link toc-highlight">Service Management</a>
  - <a href="#linux-systemd" class="table-of-contents__link toc-highlight">Linux (systemd)</a>
  - <a href="#macos-launchd" class="table-of-contents__link toc-highlight">macOS (launchd)</a>
- <a href="#platform-specific-toolsets" class="table-of-contents__link toc-highlight">Platform-Specific Toolsets</a>
- <a href="#operating-a-multi-platform-gateway" class="table-of-contents__link toc-highlight">Operating a multi-platform gateway</a>
  - <a href="#platform-command" class="table-of-contents__link toc-highlight"><code>/platform</code> command</a>
  - <a href="#automatic-circuit-breaker" class="table-of-contents__link toc-highlight">Automatic circuit breaker</a>
  - <a href="#where-to-look-when-a-platform-is-paused" class="table-of-contents__link toc-highlight">Where to look when a platform is paused</a>
  - <a href="#restart-notifications" class="table-of-contents__link toc-highlight">Restart notifications</a>
  - <a href="#typing-indicators" class="table-of-contents__link toc-highlight">Typing indicators</a>
  - <a href="#session-resume-across-gateway-restarts" class="table-of-contents__link toc-highlight">Session resume across gateway restarts</a>
  - <a href="#mobile-friendly-progress-defaults" class="table-of-contents__link toc-highlight">Mobile-friendly progress defaults</a>
  - <a href="#progress-bubble-cleanup-opt-in" class="table-of-contents__link toc-highlight">Progress bubble cleanup (opt-in)</a>
- <a href="#next-steps" class="table-of-contents__link toc-highlight">Next Steps</a>


