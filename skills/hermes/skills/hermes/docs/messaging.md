> Source: https://hermes-agent.nousresearch.com/docs/user-guide/messaging/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Messaging Gateway


Chat with Hermes from Telegram, Discord, Slack, WhatsApp, Signal, SMS, Email, Home Assistant, Mattermost, Matrix, DingTalk, Feishu/Lark, WeCom, Weixin, BlueBubbles (iMessage), QQ, Yuanbao, Microsoft Teams, LINE, ntfy, or your browser. The gateway is a single background process that connects to all your configured platforms, handles sessions, runs cron jobs, and delivers voice messages.

For the full voice feature set — including CLI microphone mode, spoken replies in messaging, and Discord voice-channel conversations — see [Voice Mode](/docs/user-guide/features/voice-mode) and [Use Voice Mode with Hermes](/docs/guides/use-voice-mode-with-hermes).


Bots need both a model provider and tool providers (TTS, web). A [Nous Portal](/docs/integrations/nous-portal) subscription bundles all of them.


## Messaging status in Desktop and the dashboard<a href="#messaging-status-in-desktop-and-the-dashboard" class="hash-link" aria-label="Direct link to Messaging status in Desktop and the dashboard" translate="no" title="Direct link to Messaging status in Desktop and the dashboard">​</a>

Messaging status belongs to the selected profile on the selected machine. Credentials saved by `hermes gateway setup` can enable a credential-based platform without a `platforms` entry in `config.yaml`; an explicit `platforms.<name>.enabled: false` still disables it. A different profile never inherits the server process's credentials. Platforms without required credential fields are not enabled merely because that list is empty.

Naming the server's own profile explicitly (for example `profile=default` on a default-profile server) gives the same status as an unscoped request. **Saved** means credentials are stored, not that the messaging gateway is running or the platform is connected. An enabled platform can correctly show **Messaging gateway stopped**.

## Platform Comparison<a href="#platform-comparison" class="hash-link" aria-label="Direct link to Platform Comparison" translate="no" title="Direct link to Platform Comparison">​</a>

| Platform           | Voice | Images | Files | Threads | Reactions | Typing | Streaming |
|--------------------|:-----:|:------:|:-----:|:-------:|:---------:|:------:|:---------:|
| Telegram           |  ✅   |   ✅   |  ✅   |   ✅    |     —     |   ✅   |    ✅     |
| Discord            |  ✅   |   ✅   |  ✅   |   ✅    |    ✅     |   ✅   |    ✅     |
| Slack              |  ✅   |   ✅   |  ✅   |   ✅    |    ✅     |   ✅   |    ✅     |
| Google Chat        |   —   |   ✅   |  ✅   |   ✅    |     —     |   ✅   |     —     |
| WhatsApp           |   —   |   ✅   |  ✅   |    —    |     —     |   ✅   |    ✅     |
| WhatsApp Cloud API |  ✅   |   ✅   |  ✅   |    —    |     —     |   ✅   |     —     |
| Signal             |   —   |   ✅   |  ✅   |    —    |     —     |   ✅   |     —     |
| SMS                |   —   |   —    |   —   |    —    |     —     |   —    |     —     |
| Email              |   —   |   ✅   |  ✅   |   ✅    |     —     |   —    |     —     |
| Home Assistant     |   —   |   —    |   —   |    —    |     —     |   —    |     —     |
| Mattermost         |  ✅   |   ✅   |  ✅   |   ✅    |     —     |   ✅   |    ✅     |
| Matrix             |  ✅   |   ✅   |  ✅   |   ✅    |    ✅     |   ✅   |    ✅     |
| DingTalk           |   —   |   ✅   |  ✅   |    —    |    ✅     |   —    |    ✅     |
| Feishu/Lark        |  ✅   |   ✅   |  ✅   |   ✅    |    ✅     |   ✅   |    ✅     |
| WeCom              |  ✅   |   ✅   |  ✅   |    —    |     —     |   —    |     —     |
| WeCom Callback     |   —   |   —    |   —   |    —    |     —     |   —    |     —     |
| Weixin             |  ✅   |   ✅   |  ✅   |    —    |     —     |   ✅   |     —     |
| BlueBubbles        |   —   |   ✅   |  ✅   |    —    |    ✅     |   ✅   |     —     |
| Photon (iMessage)  |  ✅   |   ✅   |  ✅   |    —    |    ✅     |   ✅   |     —     |
| QQ                 |  ✅   |   ✅   |  ✅   |    —    |     —     |   ✅   |     —     |
| Yuanbao            |  ✅   |   ✅   |  ✅   |    —    |     —     |   ✅   |    ✅     |
| Microsoft Teams    |   —   |   ✅   |   —   |   ✅    |     —     |   ✅   |     —     |
| LINE               |   —   |   ✅   |  ✅   |    —    |     —     |   ✅   |     —     |
| ntfy               |   —   |   —    |   —   |    —    |     —     |   —    |     —     |
| Raft               |   —   |   —    |   —   |    —    |     —     |   —    |     —     |
| IRC                |   —   |   —    |   —   |    —    |     —     |   —    |     —     |
| Buzz               |   —   |   ✅   |   —   |   ✅    |     —     |   —    |     —     |
| SimpleX            |  ✅   |   ✅   |  ✅   |    —    |     —     |   ✅   |     —     |

**Voice** = TTS audio replies and/or voice message transcription. **Images** = send/receive images. **Files** = send/receive file attachments. **Threads** = threaded conversations. **Reactions** = emoji reactions on messages. **Typing** = typing indicator while processing. **Streaming** = progressive message updates via editing.


[Hermes Relay](/docs/user-guide/messaging/relay) (experimental) is not a chat platform itself — it is a connector system that fronts platforms like Discord, Telegram, Slack, and WhatsApp through an external connector that owns the platform credentials. Capabilities (media, native approval/clarify prompts, reactions, threads, typing, streaming) are negotiated per connector at handshake rather than fixed in the table above.


## Architecture<a href="#architecture" class="hash-link" aria-label="Direct link to Architecture" translate="no" title="Direct link to Architecture">​</a>

Each platform adapter receives messages, routes them through a per-chat session store, and dispatches them to the AIAgent for processing. The gateway also runs the cron scheduler, ticking every 60 seconds to execute any due jobs.

## Intentional Silence Tokens<a href="#intentional-silence-tokens" class="hash-link" aria-label="Direct link to Intentional Silence Tokens" translate="no" title="Direct link to Intentional Silence Tokens">​</a>

For group chats, hooks, and automation flows, Hermes supports explicit silence tokens. If the agent's final response is exactly one supported token, the gateway suppresses outbound delivery and sends nothing to the chat.

Supported tokens:

- `[SILENT]`
- `SILENT`
- `NO_REPLY`
- `NO REPLY`
- `[静默]` / `静默` and `[沉默]` / `沉默` — the Chinese renderings a model produces when it translates the sentinel instead of emitting it literally

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


### Stack dump on demand (`SIGUSR2`)<a href="#stack-dump-on-demand-sigusr2" class="hash-link" aria-label="Direct link to stack-dump-on-demand-sigusr2" translate="no" title="Direct link to stack-dump-on-demand-sigusr2">​</a>

On Linux and macOS, `kill -USR2 <gateway pid>` appends a dump of every thread's stack to `~/.hermes/logs/gateway_faulthandler.log` and the gateway keeps running — use it to see what a stalled or misbehaving gateway is doing without restarting it.

### Built-in event-loop liveness watchdog<a href="#built-in-event-loop-liveness-watchdog" class="hash-link" aria-label="Direct link to Built-in event-loop liveness watchdog" translate="no" title="Direct link to Built-in event-loop liveness watchdog">​</a>

On every platform the gateway runs an out-of-loop watchdog thread that probes the asyncio loop (`gateway.loop_watchdog_probe_interval_s`, default 30 s). When the loop stops dispatching for `gateway.loop_watchdog_max_strikes` consecutive probes (default 3), housekeeping, the cron scheduler and the embedded kanban dispatcher have all frozen with it, so the watchdog dumps every thread's stack to the log, stamps `gateway_state.json` with `gateway_state: degraded` and `exit_reason: loop_liveness_watchdog`, and exits with code `75` so the service supervisor restarts the process. `hermes gateway status` renders that record as `⚠ Gateway exited degraded: event loop stopped dispatching …` until a new gateway process overwrites it, and the dashboard's gateway badge shows **Degraded** with the same reason. Set `gateway.loop_watchdog: false` in `config.yaml` to disable the watchdog.

Housekeeping also re-stamps `gateway_state.json`'s `updated_at` every tick (60 s), so it doubles as a heartbeat: when the process is still alive but that stamp is more than 120 s old, `hermes gateway status` prints `⚠ Gateway heartbeat stale: housekeeping has not refreshed gateway_state.json for N s …` and the dashboard badge reads **Heartbeat stale** — the "looks running but nothing is scheduled" case. Restart the gateway.

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
| `/personality [name]`                   | Set a personality (`none` to reset)                                                             |
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
| `/sessions [all] [search <query>]`      | List previous sessions; `search <query>` filters by title or id                                 |
| `/usage`                                | Show token usage for this session (`/usage reset [--force]` redeems a banked Codex limit reset) |
| `/insights [days]`                      | Show usage insights and analytics                                                               |
| `/reasoning [level|show|hide]`          | Change reasoning effort or toggle reasoning display                                             |
| `/voice [on|off|tts|join|leave|status]` | Control messaging voice replies and Discord voice-channel behavior                              |
| `/rollback [number]`                    | List or restore filesystem checkpoints                                                          |
| `/bg <prompt>`                          | Run a prompt in a separate background session                                                   |
| `/btw <question>`                       | Ask a side question about the current conversation without interrupting it                      |
| `/reload-mcp`                           | Reload MCP servers from config                                                                  |
| `/update`                               | Update Hermes Agent to the latest version                                                       |
| `/help`                                 | Show available commands                                                                         |
| `/<skill-name>`                         | Invoke any installed skill                                                                      |

## Session Management<a href="#session-management" class="hash-link" aria-label="Direct link to Session Management" translate="no" title="Direct link to Session Management">​</a>

### Session Persistence<a href="#session-persistence" class="hash-link" aria-label="Direct link to Session Persistence" translate="no" title="Direct link to Session Persistence">​</a>

Sessions persist across messages until they reset. The agent remembers your conversation context.

### Finding Past Sessions (`/sessions`)<a href="#finding-past-sessions-sessions" class="hash-link" aria-label="Direct link to finding-past-sessions-sessions" translate="no" title="Direct link to finding-past-sessions-sessions">​</a>

`/sessions` lists your previous sessions for the current chat — including the one you're in now, marked `(current)` — and `/sessions <name>` resumes one (shorthand for `/resume`). When the list grows long, `/sessions search <query>` (alias `find`) filters by title or session-id match, ordered by most recently active. Cross-origin listing with `/sessions all` is admin-only — regular users get a notice explaining the list stayed chat-scoped, and only ever see sessions from their own chat origin.

### Persistent `/model` Overrides<a href="#persistent-model-overrides" class="hash-link" aria-label="Direct link to persistent-model-overrides" translate="no" title="Direct link to persistent-model-overrides">​</a>

A `/model` switch in a gateway chat applies to that session and now **survives gateway restarts**: the model/provider choice is persisted to the session store and rehydrated on first use after a restart (credentials are re-resolved at load time and never written to disk). `/new` (or `/reset`) clears the override, and `/model <name> --global` writes it through to `config.yaml` instead. `/model <name> --once` applies for a single turn only.

### Delivery Reliability<a href="#delivery-reliability" class="hash-link" aria-label="Direct link to Delivery Reliability" translate="no" title="Direct link to Delivery Reliability">​</a>

Final agent responses are recorded in a durable **delivery ledger** (`state.db`) around each platform send. If the gateway crashes or restarts between producing a response and the platform confirming receipt, the next boot redelivers the stored response instead of losing it — or re-running the whole turn. The ledger lives in the home the gateway was started from; a multiplexed gateway keeps every served profile's replies there too.

Semantics are honest at-least-once:

- A response whose send **never started** is redelivered as-is.
- A response that was **mid-send** when the gateway died (the platform may or may not have received it), including a redelivery an earlier boot was still sending, is redelivered with a visible "♻️ Recovered reply — … may be a duplicate" prefix. Ambiguity is labeled, never silently resent.
- A final send refused by **flood control** (such as Telegram rate limits) is retried automatically after the recorded penalty expires, without requiring a reconnect or restart. A restart during the penalty adopts the stored reply without spending a retry attempt or re-running the agent. Retries retain the original bot profile, chat and thread. A rate-limit recovery prefix warns that earlier chunks may already have arrived; the ledger cannot infer partial delivery from message length.
- Any other rejected final send (a platform 5xx, an unclassified error) is retried the same way after a growing backoff (30 s, then 2 min); the last budgeted attempt is left for the next gateway start, so an outage that outlasts the timer never strands the reply. A permanently unreachable chat (blocked bot, deleted group) is not retried.
- Redelivery is bounded: 3 attempts, 24-hour freshness, then the row is abandoned. Delivered rows are pruned after 7 days.

Disable with `gateway.delivery_ledger: false` in `config.yaml` (restores the old behavior: in-flight responses are lost on crash).

### Session continuity<a href="#session-continuity" class="hash-link" aria-label="Direct link to Session continuity" translate="no" title="Direct link to Session continuity">​</a>

Gateway conversations do not reset after inactivity or at a daily boundary. Use `/new` or `/reset` for an explicit new conversation; context compression remains automatic. Legacy `session_reset` settings, reset-policy overrides and reset-timer environment variables are ignored. Cached agents may be released to reclaim resources without replacing the durable conversation. Restart-recovery freshness limits automatic continuation, not the history loaded when you send a message.

## Per-Channel Model & System Prompt Overrides<a href="#per-channel-model--system-prompt-overrides" class="hash-link" aria-label="Direct link to Per-Channel Model &amp; System Prompt Overrides" translate="no" title="Direct link to Per-Channel Model &amp; System Prompt Overrides">​</a>

Different channels can run different models and personas from a **single gateway** — e.g. a cheap fast model in `#daily` and a frontier model with a specialist prompt in `#dev`. Configure `channel_overrides` under the platform in `~/.hermes/config.yaml`:


``` prism-code
platforms:
  discord:
    enabled: true
    channel_overrides:
      "123456789012345678":        # channel/thread id
        model: anthropic/claude-sonnet-4.6
        provider: anthropic
        system_prompt: "You are the #dev channel code-review specialist."
      "987654321098765432":
        model: openai/gpt-5-mini
```


Details:

- All three keys are optional — set only `model`, only `system_prompt`, or any combination. Unset fields fall back to the global defaults.
- Lookup order is exact channel/thread id first, then the **parent** channel/forum id — so Discord threads inherit their parent channel's override automatically.
- Resolution priority for the model is: session `/model` override → `channel_overrides` → global config. A user running `/model` in a chat still wins over the channel default.
- The `system_prompt` override replaces the global gateway prompt for that channel (it is ephemeral — injected per turn, not stored in history).

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

Use `/whoami` from any platform to see the active scope, your tier (admin / user / unrestricted), and which slash commands you can run. When an admin list is configured, `/help` and `/commands` show a non-admin only the commands they can actually run (`/help`, `/whoami`, plus `user_allowed_commands`); admins see the full catalog. See the [Telegram](/docs/user-guide/messaging/telegram#slash-command-access-control) and [Discord](/docs/user-guide/messaging/discord#slash-command-access-control) pages for platform-specific examples.

## Redirecting the Agent<a href="#redirecting-the-agent" class="hash-link" aria-label="Direct link to Redirecting the Agent" translate="no" title="Direct link to Redirecting the Agent">​</a>

Send a message while the agent is working to correct the active turn:

- **Model generation restarts with context** — reasoning already shown and visible partial text are retained as an ordinary assistant checkpoint
- **Completed work stays available** — prior tool calls and results remain in the turn
- **Running tools finish safely** — the correction is applied at the next tool-result boundary instead of killing the tool
- **`/stop` remains a hard stop** — use it to cancel the active turn and foreground work

### Queue vs interrupt vs steer (busy-input mode)<a href="#queue-vs-interrupt-vs-steer-busy-input-mode" class="hash-link" aria-label="Direct link to Queue vs interrupt vs steer (busy-input mode)" translate="no" title="Direct link to Queue vs interrupt vs steer (busy-input mode)">​</a>

By default, messaging a busy agent redirects its active turn (a running foreground terminal command is moved to the background rather than killed, so your message is read immediately). Two other modes are available:

- `queue` — follow-up messages wait and run as the next turn after the current task finishes. Each follow-up (text, voice note, video, document) gets its own turn in arrival order; only a rapid photo burst is merged into one album turn.
- `steer` — follow-up messages are injected into the current run via `/steer`, arriving at the agent after the next tool call. No interrupt, no new turn. Falls back to `queue` behavior if the agent hasn't started yet.

Gateway steers (including explicit `/steer`) and active-turn redirects carry the requesting event's available platform, chat, thread, sender, message, profile, and scope identifiers as per-message JSON context. With `privacy.redact_pii: true`, identifiers in this model-visible context are hashed on supported platforms, including alternate and parent identifiers; the original event identifiers remain internal for routing. Otherwise identifiers are preserved exactly. Neither mode changes the session's system prompt or chooses a fallback reply destination. The context is routing data, not authorization or a guarantee of automatic delivery.


``` prism-code
display:
  busy_input_mode: steer   # or queue, or interrupt (default)
  busy_ack_enabled: true   # set to false to suppress the ⚡/⏳/⏩ chat reply entirely
  busy_text_debounce_seconds: 0.35   # quiet window before merged busy text is delivered
  busy_text_hard_cap_seconds: 1.0    # never hold merged busy text longer than this
```


All four keys are read from each profile's own `config.yaml`, so multiplexed profiles keep independent busy policies; there is no process-environment override.

The first time you message a busy agent on any platform, Hermes appends a one-line reminder to the busy-ack explaining the knob (`"💡 First-time tip — …"`). The reminder fires once per install — a flag under `onboarding.seen.busy_input_prompt` latches it. Delete that key to see the tip again.

If you find the busy acknowledgment noisy, set `display.busy_ack_enabled: false`. Input handling is unchanged; only the confirmation message is hidden.

## Clarify Questions (Multi-Select)<a href="#clarify-questions-multi-select" class="hash-link" aria-label="Direct link to Clarify Questions (Multi-Select)" translate="no" title="Direct link to Clarify Questions (Multi-Select)">​</a>

When the agent uses the `clarify` tool to ask you a question, the gateway renders the choices as a numbered prompt (or native buttons on platforms that support them). Clarify supports **multi-select** questions too — the agent can let you pick several options at once:

- **Messaging platforms** — the prompt says "Multiple selections allowed"; reply with the numbers separated by commas or spaces (e.g. `1, 3`), the option text, or your own free-form answer.
- **Classic CLI / TUI** — multi-select renders as checkboxes: **Space** toggles an option, **Enter** submits the selection.

Single-select prompts behave as before: pick one option by number, button, or text, or type your own answer via the "Other" path.

## Tool Progress Notifications<a href="#tool-progress-notifications" class="hash-link" aria-label="Direct link to Tool Progress Notifications" translate="no" title="Direct link to Tool Progress Notifications">​</a>

Control how much tool activity is displayed in `~/.hermes/config.yaml`:


``` prism-code
display:
  tool_progress: all    # off | new | all | verbose | log
  tool_progress_command: false  # set to true to enable /verbose in messaging
  # How progress is grouped on platforms that support message editing:
  #   accumulate (default) — edit one bubble in place as tools run
  #   separate             — send one message per tool (pre-v0.9 style; noisier)
  # Only applies where tool_progress is already enabled.
  tool_progress_grouping: accumulate   # accumulate | separate
```


### `log` mode — audit file instead of chat messages<a href="#log-mode--audit-file-instead-of-chat-messages" class="hash-link" aria-label="Direct link to log-mode--audit-file-instead-of-chat-messages" translate="no" title="Direct link to log-mode--audit-file-instead-of-chat-messages">​</a>

Setting `display.tool_progress: log` sends **no** progress bubbles to chat. Instead, each tool call is appended as a line to `~/.hermes/logs/tool_calls.log` — a rotating audit file (5 MB × 3 backups) run through the same secret-redacting formatter as regular logs, so credentials never land on disk. Use it when you want a full tool-call trail without any chat noise.

### Configurable status phrases<a href="#configurable-status-phrases" class="hash-link" aria-label="Direct link to Configurable status phrases" translate="no" title="Direct link to Configurable status phrases">​</a>

Long-running gateway status lines ("still working…"-style heartbeats) draw from a phrase catalog. Built-in defaults ship in `gateway/assets/status_phrases.yaml`; you can add your own with profile-portable files under `HERMES_HOME`:

- `~/.hermes/status_phrases.yaml` or any `*.yaml` in `~/.hermes/status_phrases/` (conventional paths, auto-loaded), or
- point config at a relative path:


``` prism-code
display:
  status_phrases:
    path: status_phrases/whatsapp.yaml  # relative to HERMES_HOME
    mode: append                        # append (default) or replace
```


Phrase files map a surface (`status`, `generic`) to a list of strings (max 80 phrases per surface, 160 chars each). Absolute paths and `..` escapes are ignored so config stays profile-portable. Only your configured phrase strings are used — raw tool arguments, commands, and reasoning text are never interpolated into a status phrase.

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
/bg Check all servers in the cluster and report any that are down
```


Hermes confirms immediately:


``` prism-code
🔄 Background task started: "Check all servers in the cluster..."
   Task ID: bg_143022_a1b2c3
```


### How It Works<a href="#how-it-works" class="hash-link" aria-label="Direct link to How It Works" translate="no" title="Direct link to How It Works">​</a>

Each `/bg` prompt spawns a **separate agent instance** that runs asynchronously:

- **Isolated session** — the background agent has its own session with its own conversation history. It has no knowledge of your current chat context and receives only the prompt you provide.
- **Same configuration** — inherits your model, provider, toolsets, reasoning settings, and provider routing from the current gateway setup.
- **Non-blocking** — your main chat stays fully interactive. Send messages, run other commands, or start more background tasks while it works.
- **Result delivery** — when the task finishes, the result is sent back to the **same chat or channel** where you issued the command, prefixed with "✅ Background task complete". If it fails, you'll see "❌ Background task failed" with the error.

### Background Process Notifications<a href="#background-process-notifications" class="hash-link" aria-label="Direct link to Background Process Notifications" translate="no" title="Direct link to Background Process Notifications">​</a>

When the agent running a background session uses `terminal(background=true)` to start long-running processes (servers, builds, etc.), the gateway can push status updates to your chat. Control this with `display.background_process_notifications` in `~/.hermes/config.yaml`:


``` prism-code
display:
  background_process_notifications: concise    # concise | all | result | error | off
```


| Mode      | What you receive                                                                     |
|-----------|--------------------------------------------------------------------------------------|
| `concise` | One-line status message on completion; failures append a short output tail (default) |
| `all`     | Running-output updates **and** the final status message with the output tail         |
| `result`  | Only the final status message with the output tail (regardless of exit code)         |
| `error`   | Only the final status message with the output tail when the exit code is non-zero    |
| `off`     | No process watcher messages at all                                                   |

You can also set this via environment variable:


``` prism-code
HERMES_BACKGROUND_NOTIFICATIONS=result
```


With `terminal(background=true, notify_on_complete=true)` the finished process starts a new agent turn and the agent reports the result itself, so no separate status line is sent. The exception is a process that finishes while the turn that launched it is still running: the completion is queued as the agent's next turn and you get the one-line `concise` status right away (unless the mode is `off`, or `error` with a zero exit code), instead of silence until that turn ends.

### Use Cases<a href="#use-cases" class="hash-link" aria-label="Direct link to Use Cases" translate="no" title="Direct link to Use Cases">​</a>

- **Server monitoring** — "/bg Check the health of all services and alert me if anything is down"
- **Long builds** — "/bg Build and deploy the staging environment" while you continue chatting
- **Research tasks** — "/bg Research competitor pricing and summarize in a table"
- **File operations** — "/bg Organize the photos in ~/Downloads by date into folders"


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


### Direct `systemctl restart` / `stop` exits cleanly<a href="#direct-systemctl-restart--stop-exits-cleanly" class="hash-link" aria-label="Direct link to direct-systemctl-restart--stop-exits-cleanly" translate="no" title="Direct link to direct-systemctl-restart--stop-exits-cleanly">​</a>

The installed unit declares `ExecStop=` to record a planned-stop marker for `$MAINPID` before `SIGTERM` is delivered, so stopping or restarting the service directly is classified as intentional: the gateway drains, persists `gateway_state=stopped`, and exits `0` — the journal shows a clean stop/start with no `Failed with result exit-code` line.


``` prism-code
systemctl --user restart hermes-gateway   # or: sudo systemctl restart hermes-gateway
```


Prefer `hermes gateway restart` when in-flight agent turns matter: it asks the gateway to drain first (`SIGUSR1`, honoring the restart wait budget) and waits for the replacement, while a raw `systemctl restart` stops the current process on systemd's schedule. After updating Hermes, run `hermes gateway restart` once so the running service picks up the regenerated unit that contains the `ExecStop=` line (`hermes gateway status` warns while the installed unit is outdated).

The installed unit also maps `systemctl reload hermes-gateway` to `SIGUSR1`. For Hermes, `reload` therefore means a graceful drain, process exit, and supervisor relaunch; it is **not** an in-process configuration reload. Use `hermes gateway restart` when you want the CLI to wait for and verify the replacement process.


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


`hermes gateway install` (and the `hermes gateway setup` wizard) refuse to install a **user** service when Hermes detects it is running inside a container. A user unit lands in `~/.config/systemd/user`, and when that home is bind-mounted from the host (podman/distrobox), the host's own `systemd --user` enables and starts the same unit — a second gateway polling the same bot token. Run the gateway as the container's main process (`hermes gateway run`, with a container restart policy), or in a systemd container (systemd as PID 1) install the isolated system scope: `sudo hermes gateway install --system --run-as-user <user>`.


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


The plist sets `RunAtLoad`, so loading it starts the gateway. `hermes gateway install --no-start-now`, like answering No to "Start the gateway now?" in `hermes gateway setup`, writes the plist without loading it: the gateway starts at your next login, or when you run `hermes gateway start`. A gateway that launchd is already running is reloaded onto the new plist, not stopped.


macOS Local Network Privacy attributes a socket to the executable launchd spawned for the job. A bare venv Python has no application identity, so a launchd-run gateway could not reach LAN hosts (Home Assistant, local model servers) — every connect failed with `errno 65 No route to host` while the same URL worked from Terminal, and no prompt was ever shown to grant it. The generated plist therefore runs the gateway through `/usr/bin/osascript` (`do shell script "exec …"`), whose children macOS treats as osascript's own — an Apple platform binary, exempt from the check. `ps` shows `osascript → stderr_timestamp → gateway run`; stop/restart/KeepAlive behave exactly as before. A plist installed by an older Hermes is refreshed by `hermes gateway install` (or on the next `hermes gateway start`).


Agents run as threads inside the one gateway process; the only child processes are tool subprocesses (terminal commands, browsers), which never hold provider credentials. A running gateway also re-reads the `openai-codex` login it seeded from `auth.json` the next time its pool selects that entry after it had gone `exhausted` or `dead` (entries added with `hermes auth add openai-codex` are independent accounts and are not resynced). When you want every session on the fresh login at once, restart the gateway — but prefer the drain-aware path over a bare kill:

- `hermes gateway restart` asks the gateway (SIGUSR1) to refuse new turns, waits up to `agent.restart_after_turn_timeout` (default 1800 s) for in-flight turns to finish, exits, and lets launchd's `KeepAlive` relaunch it; the new process reads `auth.json` from scratch.
- `launchctl kickstart -k gui/$UID/ai.hermes.gateway` sends SIGTERM instead: the gateway interrupts in-flight chat turns after `agent.restart_drain_timeout` (default `0` — immediately; the user is told and the turn resumes on their next message), gives cron runs `agent.cron_drain_timeout` (default 30 s), kills tool subprocesses and exits, then launchd relaunches it. Nothing from the old process survives, so a session that still fails with `401` after the relaunch is talking to a different gateway process — check `hermes gateway status` (and `launchctl list | grep hermes`) for a second PID, such as a manually started `hermes gateway run`, and stop that one too.


Like the Linux systemd service, each `HERMES_HOME` directory gets its own launchd label. The default `~/.hermes` uses `ai.hermes.gateway`; other installations use `ai.hermes.gateway-<suffix>`.


### Windows (Task Scheduler)<a href="#windows-task-scheduler" class="hash-link" aria-label="Direct link to Windows (Task Scheduler)" translate="no" title="Direct link to Windows (Task Scheduler)">​</a>


``` prism-code
hermes gateway install               # Register the Hermes_Gateway Scheduled Task (runs at logon)
hermes gateway start                 # Start the gateway hidden, without a console window
hermes gateway stop                  # Drain and stop the service
hermes gateway status                # Check status, including registration drift
```


The Scheduled Task runs `wscript.exe` on a generated `.vbs` launcher under `%USERPROFILE%\.hermes\gateway-service\`. The launcher starts `python.exe -m hermes_cli.main gateway run` with a hidden window and **exits immediately** — by design: `wscript.exe` has no console, so at logon it never receives the `CTRL_CLOSE_EVENT` that kills a `cmd.exe`-hosted gateway, and the gateway inherits one hidden console instead of every subprocess flashing its own (see `hermes_cli/gateway_windows.py::_build_gateway_vbs_script`).


Because the launcher returns as soon as the gateway is spawned, Task Scheduler only ever sees the launcher's exit code. The `<RestartOnFailure>` policy in the registered task therefore fires only when `wscript.exe` itself fails to start the gateway — it does **not** restart a gateway that crashes or is killed later. Gateway auto-restart on Windows relies on the gateway's own in-process restart path (`/restart`, updates, and the `hermes gateway restart` command); a gateway killed from outside stays down until `hermes gateway start` or `schtasks /Run /TN <task>`.


`hermes gateway install` writes the task from the current template; a task registered by an older build would otherwise keep its old settings (no `RestartOnFailure`, no logon `Delay`, an older launcher command line) indefinitely. `hermes gateway status` compares the registered task with the current template and warns when it predates it:


``` prism-code
⚠ Scheduled Task registration predates the current template (missing: RestartOnFailure, LogonTrigger Delay; version 1.3 vs 1.4)
  Repair: hermes gateway start  (or: hermes gateway install)
```


`hermes gateway start` and `hermes update` run the same comparison and re-register a drifted task from the current template automatically (like the systemd unit refresh on Linux); when `schtasks` refuses without elevation, re-run `hermes gateway install`, which can request administrator approval. The check is silent when the task cannot be queried, and it only inspects a few settings Hermes owns (task version, `RestartOnFailure`, the logon trigger delay and the launcher arguments), so deliberate local edits elsewhere in the task are not flagged.

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

### Disabling a platform whose credentials are still in `.env`<a href="#disabling-a-platform-whose-credentials-are-still-in-env" class="hash-link" aria-label="Direct link to disabling-a-platform-whose-credentials-are-still-in-env" translate="no" title="Direct link to disabling-a-platform-whose-credentials-are-still-in-env">​</a>

`platforms.<name>.enabled: false` in `~/.hermes/config.yaml` is authoritative. Credentials for that platform left in the environment (`TELEGRAM_BOT_TOKEN`, `WEIXIN_TOKEN`, `HASS_TOKEN`, `EMAIL_*`, `TWILIO_ACCOUNT_SID`, ...) are still wired into the platform's config so send-only tooling keeps working, but they no longer start the adapter:


~/.hermes/config.yaml


``` prism-code
platforms:
  weixin:
    enabled: false   # wins over WEIXIN_TOKEN in .env
```


Earlier releases let the mere presence of credentials re-enable twelve platforms (Weixin, WhatsApp Cloud, Home Assistant, Email, SMS, DingTalk, Feishu, WeCom, WeCom callback, BlueBubbles, QQ Bot, Yuanbao) regardless of that key. If you relied on that, the gateway now logs one WARNING per affected platform at startup so it does not just go dark:


``` prism-code
Platform 'weixin' is explicitly disabled by platforms.weixin.enabled: false in config.yaml,
so the credentials found in the environment (WEIXIN_TOKEN, WEIXIN_ACCOUNT_ID) will NOT start
its adapter. Environment credentials no longer override an explicit disable. Remove the key
or set platforms.weixin.enabled: true to turn it back on.
```


Omitting the `enabled` key entirely keeps the env-only behaviour: credentials present → adapter starts.

### Ignoring an inherited proxy (`gateway.trust_env`)<a href="#ignoring-an-inherited-proxy-gatewaytrust_env" class="hash-link" aria-label="Direct link to ignoring-an-inherited-proxy-gatewaytrust_env" translate="no" title="Direct link to ignoring-an-inherited-proxy-gatewaytrust_env">​</a>

By default every platform adapter honors `HTTP_PROXY` / `HTTPS_PROXY` / `NO_PROXY` (and `SSL_CERT_FILE`) from the gateway's environment, and auto-detects the macOS system proxy. A gateway started by a Windows Scheduled Task or a service manager can inherit a proxy the interactive shell never sees — a local Clash/V2Ray listener that isn't running yet — and log `Cannot connect to host 127.0.0.1:7890` on every poll. Turn the inherited proxy off for all adapters at once:


~/.hermes/config.yaml


``` prism-code
gateway:
  trust_env: false
```


Explicit per-platform proxy variables (`DISCORD_PROXY`, `TELEGRAM_PROXY`, `MATRIX_PROXY`, ...) are still honored. Restart the gateway after changing it.

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

When the gateway restarts (or is shut down with in-flight sessions), it can send a one-shot "the agent is back" / "the agent was interrupted" message to each platform's home channel. This is controlled per-platform by the `gateway_restart_notification` flag in `config.yaml`, which defaults to `true`:


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

While the agent is processing a message, the gateway shows a live typing status on platforms that support it — a "typing…" bubble on Telegram/Discord/Signal, or the "is thinking…" assistant status on Slack. This is controlled per-platform by the `typing_indicator` flag in `config.yaml`, which defaults to `true`:


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

Only turns that were actually in flight are resumed, and each resumes once. A chat whose turn had already finished is never answered again just because it was active shortly before a crash. If the gateway was killed after the agent finished a reply but before it was sent, the stored reply is delivered (with a "Recovered reply" notice) instead of being regenerated.

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


### Warning and error notifications (opt-in suppression)<a href="#warning-and-error-notifications-opt-in-suppression" class="hash-link" aria-label="Direct link to Warning and error notifications (opt-in suppression)" translate="no" title="Direct link to Warning and error notifications (opt-in suppression)">​</a>

Automatic warning and error notifications are shown by default. To suppress these notifications, enable `suppress_warning_notifications` globally or for an individual surface:


``` prism-code
display:
  suppress_warning_notifications: true
  platforms:
    telegram:
      suppress_warning_notifications: false
```


This example suppresses notifications globally while keeping them visible on Telegram. Omit the setting or use `false` to preserve normal delivery. Platform overrides take precedence; `null` inherits. Invalid values do not enable suppression.

The setting controls automatic engine warnings, retry/fallback diagnostics, watchdog and database notices, cron failure notifications, Kanban failure notifications, background/delegation diagnostics, and adapter-generated error notices. It applies to messaging platforms, CLI/TUI presentation and API notification presentation. Classification belongs to the producer: warning-like text in a user request or an ordinary result is not filtered by its wording.

Suppression changes presentation, not execution. Existing logs, stored diagnostic content, retry decisions, failure state, scheduler bookkeeping and notification cursors remain available. A diagnostic-only internal wake (a subagent or credit failure, a Kanban crash notice) still runs its agent turn — so the agent can act on the failure and the session history stays consistent — and that turn is billed as usual; only its unsolicited text, media and streaming presentation are muted. Structured approval and clarification controls, direct command/API outcomes and requested results are not converted into success or discarded. API failure flags, status codes and usage remain truthful even when diagnostic text is hidden.

Cron `failure_deliver` still selects the destination; the destination's warning policy determines whether an automatic failure notice is presented there. Suppressed deliveries are settled without claiming a successful send. Already admitted deliveries retain their delivery identity and outcome.

Policy is resolved for the owning profile and logical destination. Agent turns use their turn policy; independent notifications and deferred deliveries evaluate policy at their own delivery boundary. Already delivered messages are not removed. Suppression does not fix an underlying failure or add another logging destination.

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
- [Photon Setup (iMessage)](/docs/user-guide/messaging/photon)
- [QQBot Setup](/docs/user-guide/messaging/qqbot)
- [Yuanbao Setup](/docs/user-guide/messaging/yuanbao)
- [Microsoft Teams Setup](/docs/user-guide/messaging/teams)
- [Teams Meetings Pipeline](/docs/user-guide/messaging/teams-meetings)
- [Microsoft Graph Webhook Listener](/docs/user-guide/messaging/msgraph-webhook)
- [LINE Setup](/docs/user-guide/messaging/line)
- [ntfy Setup](/docs/user-guide/messaging/ntfy)
- [SimpleX Chat Setup](/docs/user-guide/messaging/simplex)
- [Open WebUI + API Server](/docs/user-guide/messaging/open-webui)
- [Raft Setup](/docs/user-guide/messaging/raft)
- [IRC Setup](/docs/user-guide/messaging/irc)
- [Buzz Setup](/docs/user-guide/messaging/buzz)
- [A2A (Agent-to-Agent) Setup](/docs/user-guide/messaging/a2a)
- [Webhooks](/docs/user-guide/messaging/webhooks)


- <a href="#messaging-status-in-desktop-and-the-dashboard" class="table-of-contents__link toc-highlight">Messaging status in Desktop and the dashboard</a>
- <a href="#platform-comparison" class="table-of-contents__link toc-highlight">Platform Comparison</a>
- <a href="#architecture" class="table-of-contents__link toc-highlight">Architecture</a>
- <a href="#intentional-silence-tokens" class="table-of-contents__link toc-highlight">Intentional Silence Tokens</a>
- <a href="#quick-setup" class="table-of-contents__link toc-highlight">Quick Setup</a>
- <a href="#gateway-commands" class="table-of-contents__link toc-highlight">Gateway Commands</a>
  - <a href="#stack-dump-on-demand-sigusr2" class="table-of-contents__link toc-highlight">Stack dump on demand (<code>SIGUSR2</code>)</a>
  - <a href="#built-in-event-loop-liveness-watchdog" class="table-of-contents__link toc-highlight">Built-in event-loop liveness watchdog</a>
  - <a href="#optional-linux-event-loop-watchdog" class="table-of-contents__link toc-highlight">Optional Linux event-loop watchdog</a>
- <a href="#chat-commands-inside-messaging" class="table-of-contents__link toc-highlight">Chat Commands (Inside Messaging)</a>
- <a href="#session-management" class="table-of-contents__link toc-highlight">Session Management</a>
  - <a href="#session-persistence" class="table-of-contents__link toc-highlight">Session Persistence</a>
  - <a href="#finding-past-sessions-sessions" class="table-of-contents__link toc-highlight">Finding Past Sessions (<code>/sessions</code>)</a>
  - <a href="#persistent-model-overrides" class="table-of-contents__link toc-highlight">Persistent <code>/model</code> Overrides</a>
  - <a href="#delivery-reliability" class="table-of-contents__link toc-highlight">Delivery Reliability</a>
  - <a href="#session-continuity" class="table-of-contents__link toc-highlight">Session continuity</a>
- <a href="#per-channel-model--system-prompt-overrides" class="table-of-contents__link toc-highlight">Per-Channel Model &amp; System Prompt Overrides</a>
- <a href="#security" class="table-of-contents__link toc-highlight">Security</a>
  - <a href="#dm-pairing-alternative-to-allowlists" class="table-of-contents__link toc-highlight">DM Pairing (Alternative to Allowlists)</a>
  - <a href="#admins-vs-regular-users" class="table-of-contents__link toc-highlight">Admins vs Regular Users</a>
- <a href="#redirecting-the-agent" class="table-of-contents__link toc-highlight">Redirecting the Agent</a>
  - <a href="#queue-vs-interrupt-vs-steer-busy-input-mode" class="table-of-contents__link toc-highlight">Queue vs interrupt vs steer (busy-input mode)</a>
- <a href="#clarify-questions-multi-select" class="table-of-contents__link toc-highlight">Clarify Questions (Multi-Select)</a>
- <a href="#tool-progress-notifications" class="table-of-contents__link toc-highlight">Tool Progress Notifications</a>
  - <a href="#log-mode--audit-file-instead-of-chat-messages" class="table-of-contents__link toc-highlight"><code>log</code> mode — audit file instead of chat messages</a>
  - <a href="#configurable-status-phrases" class="table-of-contents__link toc-highlight">Configurable status phrases</a>
  - <a href="#message-timestamps-in-model-context" class="table-of-contents__link toc-highlight">Message timestamps in model context</a>
- <a href="#background-sessions" class="table-of-contents__link toc-highlight">Background Sessions</a>
  - <a href="#how-it-works" class="table-of-contents__link toc-highlight">How It Works</a>
  - <a href="#background-process-notifications" class="table-of-contents__link toc-highlight">Background Process Notifications</a>
  - <a href="#use-cases" class="table-of-contents__link toc-highlight">Use Cases</a>
- <a href="#service-management" class="table-of-contents__link toc-highlight">Service Management</a>
  - <a href="#linux-systemd" class="table-of-contents__link toc-highlight">Linux (systemd)</a>
  - <a href="#direct-systemctl-restart--stop-exits-cleanly" class="table-of-contents__link toc-highlight">Direct <code>systemctl restart</code> / <code>stop</code> exits cleanly</a>
  - <a href="#macos-launchd" class="table-of-contents__link toc-highlight">macOS (launchd)</a>
  - <a href="#windows-task-scheduler" class="table-of-contents__link toc-highlight">Windows (Task Scheduler)</a>
- <a href="#platform-specific-toolsets" class="table-of-contents__link toc-highlight">Platform-Specific Toolsets</a>
- <a href="#operating-a-multi-platform-gateway" class="table-of-contents__link toc-highlight">Operating a multi-platform gateway</a>
  - <a href="#platform-command" class="table-of-contents__link toc-highlight"><code>/platform</code> command</a>
  - <a href="#disabling-a-platform-whose-credentials-are-still-in-env" class="table-of-contents__link toc-highlight">Disabling a platform whose credentials are still in <code>.env</code></a>
  - <a href="#ignoring-an-inherited-proxy-gatewaytrust_env" class="table-of-contents__link toc-highlight">Ignoring an inherited proxy (<code>gateway.trust_env</code>)</a>
  - <a href="#automatic-circuit-breaker" class="table-of-contents__link toc-highlight">Automatic circuit breaker</a>
  - <a href="#where-to-look-when-a-platform-is-paused" class="table-of-contents__link toc-highlight">Where to look when a platform is paused</a>
  - <a href="#restart-notifications" class="table-of-contents__link toc-highlight">Restart notifications</a>
  - <a href="#typing-indicators" class="table-of-contents__link toc-highlight">Typing indicators</a>
  - <a href="#session-resume-across-gateway-restarts" class="table-of-contents__link toc-highlight">Session resume across gateway restarts</a>
  - <a href="#mobile-friendly-progress-defaults" class="table-of-contents__link toc-highlight">Mobile-friendly progress defaults</a>
  - <a href="#warning-and-error-notifications-opt-in-suppression" class="table-of-contents__link toc-highlight">Warning and error notifications (opt-in suppression)</a>
  - <a href="#progress-bubble-cleanup-opt-in" class="table-of-contents__link toc-highlight">Progress bubble cleanup (opt-in)</a>
- <a href="#next-steps" class="table-of-contents__link toc-highlight">Next Steps</a>


