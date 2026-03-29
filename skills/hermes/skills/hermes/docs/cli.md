> Source: https://hermes-agent.nousresearch.com/docs/user-guide/cli/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# CLI Interface


Hermes Agent's CLI is a full terminal user interface (TUI) — not a web UI. It features multiline editing, slash-command autocomplete, conversation history, interrupt-and-redirect, and streaming tool output. Built for people who live in the terminal.

## Running the CLI<a href="#running-the-cli" class="hash-link" aria-label="Direct link to Running the CLI" translate="no" title="Direct link to Running the CLI">​</a>


``` prism-code
# Start an interactive session (default)
hermes

# Single query mode (non-interactive)
hermes chat -q "Hello"

# With a specific model
hermes chat --model "anthropic/claude-sonnet-4"

# With a specific provider
hermes chat --provider nous        # Use Nous Portal
hermes chat --provider openrouter  # Force OpenRouter

# With specific toolsets
hermes chat --toolsets "web,terminal,skills"

# Start with one or more skills preloaded
hermes -s hermes-agent-dev,github-auth
hermes chat -s github-pr-workflow -q "open a draft PR"

# Resume previous sessions
hermes --continue             # Resume the most recent CLI session (-c)
hermes --resume <session_id>  # Resume a specific session by ID (-r)

# Verbose mode (debug output)
hermes chat --verbose

# Isolated git worktree (for running multiple agents in parallel)
hermes -w                         # Interactive mode in worktree
hermes -w -q "Fix issue #123"     # Single query in worktree
```


## Interface Layout<a href="#interface-layout" class="hash-link" aria-label="Direct link to Interface Layout" translate="no" title="Direct link to Interface Layout">​</a>

<img src="/img/docs/cli-layout.svg" class="docs-terminal-figure" alt="Stylized preview of the Hermes CLI layout showing the banner, conversation area, and fixed input prompt." />

The Hermes CLI banner, conversation stream, and fixed input prompt rendered as a stable docs figure instead of fragile text art.

The welcome banner shows your model, terminal backend, working directory, available tools, and installed skills at a glance.

### Status Bar<a href="#status-bar" class="hash-link" aria-label="Direct link to Status Bar" translate="no" title="Direct link to Status Bar">​</a>

A persistent status bar sits above the input area, updating in real time:


``` prism-code
 ⚕ claude-sonnet-4-20250514 │ 12.4K/200K │ [██████░░░░] 6% │ $0.06 │ 15m
```


| Element     | Description                                                      |
|-------------|------------------------------------------------------------------|
| Model name  | Current model (truncated if longer than 26 chars)                |
| Token count | Context tokens used / max context window                         |
| Context bar | Visual fill indicator with color-coded thresholds                |
| Cost        | Estimated session cost (or `n/a` for unknown/zero-priced models) |
| Duration    | Elapsed session time                                             |

The bar adapts to terminal width — full layout at ≥ 76 columns, compact at 52–75, minimal (model + duration only) below 52.

**Context color coding:**

| Color  | Threshold | Meaning                              |
|--------|-----------|--------------------------------------|
| Green  | \< 50%    | Plenty of room                       |
| Yellow | 50–80%    | Getting full                         |
| Orange | 80–95%    | Approaching limit                    |
| Red    | ≥ 95%     | Near overflow — consider `/compress` |

Use `/usage` for a detailed breakdown including per-category costs (input vs output tokens).

### Session Resume Display<a href="#session-resume-display" class="hash-link" aria-label="Direct link to Session Resume Display" translate="no" title="Direct link to Session Resume Display">​</a>

When resuming a previous session (`hermes -c` or `hermes --resume <id>`), a "Previous Conversation" panel appears between the banner and the input prompt, showing a compact recap of the conversation history. See [Sessions — Conversation Recap on Resume](/docs/user-guide/sessions#conversation-recap-on-resume) for details and configuration.

## Keybindings<a href="#keybindings" class="hash-link" aria-label="Direct link to Keybindings" translate="no" title="Direct link to Keybindings">​</a>

| Key                     | Action                                                                                        |
|-------------------------|-----------------------------------------------------------------------------------------------|
| `Enter`                 | Send message                                                                                  |
| `Alt+Enter` or `Ctrl+J` | New line (multi-line input)                                                                   |
| `Alt+V`                 | Paste an image from the clipboard when supported by the terminal                              |
| `Ctrl+V`                | Paste text and opportunistically attach clipboard images                                      |
| `Ctrl+B`                | Start/stop voice recording when voice mode is enabled (`voice.record_key`, default: `ctrl+b`) |
| `Ctrl+C`                | Interrupt agent (double-press within 2s to force exit)                                        |
| `Ctrl+D`                | Exit                                                                                          |
| `Tab`                   | Accept auto-suggestion (ghost text) or autocomplete slash commands                            |

## Slash Commands<a href="#slash-commands" class="hash-link" aria-label="Direct link to Slash Commands" translate="no" title="Direct link to Slash Commands">​</a>

Type `/` to see the autocomplete dropdown. Hermes supports a large set of CLI slash commands, dynamic skill commands, and user-defined quick commands.

Common examples:

| Command                | Description                                        |
|------------------------|----------------------------------------------------|
| `/help`                | Show command help                                  |
| `/model`               | Show or change the current model                   |
| `/tools`               | List currently available tools                     |
| `/skills browse`       | Browse the skills hub and official optional skills |
| `/background <prompt>` | Run a prompt in a separate background session      |
| `/skin`                | Show or switch the active CLI skin                 |
| `/voice on`            | Enable CLI voice mode (press `Ctrl+B` to record)   |
| `/voice tts`           | Toggle spoken playback for Hermes replies          |
| `/reasoning high`      | Increase reasoning effort                          |
| `/title My Session`    | Name the current session                           |

For the full built-in CLI and messaging lists, see [Slash Commands Reference](/docs/reference/slash-commands).

For setup, providers, silence tuning, and messaging/Discord voice usage, see [Voice Mode](/docs/user-guide/features/voice-mode).


Commands are case-insensitive — `/HELP` works the same as `/help`. Installed skills also become slash commands automatically.


## Quick Commands<a href="#quick-commands" class="hash-link" aria-label="Direct link to Quick Commands" translate="no" title="Direct link to Quick Commands">​</a>

You can define custom commands that run shell commands instantly without invoking the LLM. These work in both the CLI and messaging platforms (Telegram, Discord, etc.).


``` prism-code
# ~/.hermes/config.yaml
quick_commands:
  status:
    type: exec
    command: systemctl status hermes-agent
  gpu:
    type: exec
    command: nvidia-smi --query-gpu=utilization.gpu,memory.used --format=csv,noheader
```


Then type `/status` or `/gpu` in any chat. See the [Configuration guide](/docs/user-guide/configuration#quick-commands) for more examples.

## Preloading Skills at Launch<a href="#preloading-skills-at-launch" class="hash-link" aria-label="Direct link to Preloading Skills at Launch" translate="no" title="Direct link to Preloading Skills at Launch">​</a>

If you already know which skills you want active for the session, pass them at launch time:


``` prism-code
hermes -s hermes-agent-dev,github-auth
hermes chat -s github-pr-workflow -s github-auth
```


Hermes loads each named skill into the session prompt before the first turn. The same flag works in interactive mode and single-query mode.

## Skill Slash Commands<a href="#skill-slash-commands" class="hash-link" aria-label="Direct link to Skill Slash Commands" translate="no" title="Direct link to Skill Slash Commands">​</a>

Every installed skill in `~/.hermes/skills/` is automatically registered as a slash command. The skill name becomes the command:


``` prism-code
/gif-search funny cats
/axolotl help me fine-tune Llama 3 on my dataset
/github-pr-workflow create a PR for the auth refactor

# Just the skill name loads it and lets the agent ask what you need:
/excalidraw
```


## Personalities<a href="#personalities" class="hash-link" aria-label="Direct link to Personalities" translate="no" title="Direct link to Personalities">​</a>

Set a predefined personality to change the agent's tone:


``` prism-code
/personality pirate
/personality kawaii
/personality concise
```


Built-in personalities include: `helpful`, `concise`, `technical`, `creative`, `teacher`, `kawaii`, `catgirl`, `pirate`, `shakespeare`, `surfer`, `noir`, `uwu`, `philosopher`, `hype`.

You can also define custom personalities in `~/.hermes/config.yaml`:


``` prism-code
personalities:
  helpful: "You are a helpful, friendly AI assistant."
  kawaii: "You are a kawaii assistant! Use cute expressions..."
  pirate: "Arrr! Ye be talkin' to Captain Hermes..."
  # Add your own!
```


## Multi-line Input<a href="#multi-line-input" class="hash-link" aria-label="Direct link to Multi-line Input" translate="no" title="Direct link to Multi-line Input">​</a>

There are two ways to enter multi-line messages:

1.  **`Alt+Enter` or `Ctrl+J`** — inserts a new line
2.  **Backslash continuation** — end a line with `\` to continue:


``` prism-code
❯ Write a function that:\
  1. Takes a list of numbers\
  2. Returns the sum
```


Pasting multi-line text is supported — use `Alt+Enter` or `Ctrl+J` to insert newlines, or simply paste content directly.


## Interrupting the Agent<a href="#interrupting-the-agent" class="hash-link" aria-label="Direct link to Interrupting the Agent" translate="no" title="Direct link to Interrupting the Agent">​</a>

You can interrupt the agent at any point:

- **Type a new message + Enter** while the agent is working — it interrupts and processes your new instructions
- **`Ctrl+C`** — interrupt the current operation (press twice within 2s to force exit)
- In-progress terminal commands are killed immediately (SIGTERM, then SIGKILL after 1s)
- Multiple messages typed during interrupt are combined into one prompt

## Tool Progress Display<a href="#tool-progress-display" class="hash-link" aria-label="Direct link to Tool Progress Display" translate="no" title="Direct link to Tool Progress Display">​</a>

The CLI shows animated feedback as the agent works:

**Thinking animation** (during API calls):


``` prism-code
  ◜ (｡•́︿•̀｡) pondering... (1.2s)
  ◠ (⊙_⊙) contemplating... (2.4s)
  ✧٩(ˊᗜˋ*)و✧ got it! (3.1s)
```


**Tool execution feed:**


``` prism-code
  ┊ 💻 terminal `ls -la` (0.3s)
  ┊ 🔍 web_search (1.2s)
  ┊ 📄 web_extract (2.1s)
```


Cycle through display modes with `/verbose`: `off → new → all → verbose`. This command can also be enabled for messaging platforms — see [configuration](/docs/user-guide/configuration#display-settings).

## Session Management<a href="#session-management" class="hash-link" aria-label="Direct link to Session Management" translate="no" title="Direct link to Session Management">​</a>

### Resuming Sessions<a href="#resuming-sessions" class="hash-link" aria-label="Direct link to Resuming Sessions" translate="no" title="Direct link to Resuming Sessions">​</a>

When you exit a CLI session, a resume command is printed:


``` prism-code
Resume this session with:
  hermes --resume 20260225_143052_a1b2c3

Session:        20260225_143052_a1b2c3
Duration:       12m 34s
Messages:       28 (5 user, 18 tool calls)
```


Resume options:


``` prism-code
hermes --continue                          # Resume the most recent CLI session
hermes -c                                  # Short form
hermes -c "my project"                     # Resume a named session (latest in lineage)
hermes --resume 20260225_143052_a1b2c3     # Resume a specific session by ID
hermes --resume "refactoring auth"         # Resume by title
hermes -r 20260225_143052_a1b2c3           # Short form
```


Resuming restores the full conversation history from SQLite. The agent sees all previous messages, tool calls, and responses — just as if you never left.

Use `/title My Session Name` inside a chat to name the current session, or `hermes sessions rename <id> <title>` from the command line. Use `hermes sessions list` to browse past sessions.

### Session Storage<a href="#session-storage" class="hash-link" aria-label="Direct link to Session Storage" translate="no" title="Direct link to Session Storage">​</a>

CLI sessions are stored in Hermes's SQLite state database under `~/.hermes/state.db`. The database keeps:

- session metadata (ID, title, timestamps, token counters)
- message history
- lineage across compressed/resumed sessions
- full-text search indexes used by `session_search`

Some messaging adapters also keep per-platform transcript files alongside the database, but the CLI itself resumes from the SQLite session store.

### Context Compression<a href="#context-compression" class="hash-link" aria-label="Direct link to Context Compression" translate="no" title="Direct link to Context Compression">​</a>

Long conversations are automatically summarized when approaching context limits:


``` prism-code
# In ~/.hermes/config.yaml
compression:
  enabled: true
  threshold: 0.50    # Compress at 50% of context limit by default
  summary_model: "google/gemini-3-flash-preview"  # Model used for summarization
```


When compression triggers, middle turns are summarized while the first 3 and last 4 turns are always preserved.

## Background Sessions<a href="#background-sessions" class="hash-link" aria-label="Direct link to Background Sessions" translate="no" title="Direct link to Background Sessions">​</a>

Run a prompt in a separate background session while continuing to use the CLI for other work:


``` prism-code
/background Analyze the logs in /var/log and summarize any errors from today
```


Hermes immediately confirms the task and gives you back the prompt:


``` prism-code
🔄 Background task #1 started: "Analyze the logs in /var/log and summarize..."
   Task ID: bg_143022_a1b2c3
```


### How It Works<a href="#how-it-works" class="hash-link" aria-label="Direct link to How It Works" translate="no" title="Direct link to How It Works">​</a>

Each `/background` prompt spawns a **completely separate agent session** in a daemon thread:

- **Isolated conversation** — the background agent has no knowledge of your current session's history. It receives only the prompt you provide.
- **Same configuration** — the background agent inherits your model, provider, toolsets, reasoning settings, and fallback model from the current session.
- **Non-blocking** — your foreground session stays fully interactive. You can chat, run commands, or even start more background tasks.
- **Multiple tasks** — you can run several background tasks simultaneously. Each gets a numbered ID.

### Results<a href="#results" class="hash-link" aria-label="Direct link to Results" translate="no" title="Direct link to Results">​</a>

When a background task finishes, the result appears as a panel in your terminal:


``` prism-code
╭─ ⚕ Hermes (background #1) ──────────────────────────────────╮
│ Found 3 errors in syslog from today:                         │
│ 1. OOM killer invoked at 03:22 — killed process nginx        │
│ 2. Disk I/O error on /dev/sda1 at 07:15                      │
│ 3. Failed SSH login attempts from 192.168.1.50 at 14:30      │
╰──────────────────────────────────────────────────────────────╯
```


If the task fails, you'll see an error notification instead. If `display.bell_on_complete` is enabled in your config, the terminal bell rings when the task finishes.

### Use Cases<a href="#use-cases" class="hash-link" aria-label="Direct link to Use Cases" translate="no" title="Direct link to Use Cases">​</a>

- **Long-running research** — "/background research the latest developments in quantum error correction" while you work on code
- **File processing** — "/background analyze all Python files in this repo and list any security issues" while you continue a conversation
- **Parallel investigations** — start multiple background tasks to explore different angles simultaneously


Background sessions do not appear in your main conversation history. They are standalone sessions with their own task ID (e.g., `bg_143022_a1b2c3`).


## Quiet Mode<a href="#quiet-mode" class="hash-link" aria-label="Direct link to Quiet Mode" translate="no" title="Direct link to Quiet Mode">​</a>

By default, the CLI runs in quiet mode which:

- Suppresses verbose logging from tools
- Enables kawaii-style animated feedback
- Keeps output clean and user-friendly

For debug output:


``` prism-code
hermes chat --verbose
```


- <a href="#running-the-cli" class="table-of-contents__link toc-highlight">Running the CLI</a>
- <a href="#interface-layout" class="table-of-contents__link toc-highlight">Interface Layout</a>
  - <a href="#status-bar" class="table-of-contents__link toc-highlight">Status Bar</a>
  - <a href="#session-resume-display" class="table-of-contents__link toc-highlight">Session Resume Display</a>
- <a href="#keybindings" class="table-of-contents__link toc-highlight">Keybindings</a>
- <a href="#slash-commands" class="table-of-contents__link toc-highlight">Slash Commands</a>
- <a href="#quick-commands" class="table-of-contents__link toc-highlight">Quick Commands</a>
- <a href="#preloading-skills-at-launch" class="table-of-contents__link toc-highlight">Preloading Skills at Launch</a>
- <a href="#skill-slash-commands" class="table-of-contents__link toc-highlight">Skill Slash Commands</a>
- <a href="#personalities" class="table-of-contents__link toc-highlight">Personalities</a>
- <a href="#multi-line-input" class="table-of-contents__link toc-highlight">Multi-line Input</a>
- <a href="#interrupting-the-agent" class="table-of-contents__link toc-highlight">Interrupting the Agent</a>
- <a href="#tool-progress-display" class="table-of-contents__link toc-highlight">Tool Progress Display</a>
- <a href="#session-management" class="table-of-contents__link toc-highlight">Session Management</a>
  - <a href="#resuming-sessions" class="table-of-contents__link toc-highlight">Resuming Sessions</a>
  - <a href="#session-storage" class="table-of-contents__link toc-highlight">Session Storage</a>
  - <a href="#context-compression" class="table-of-contents__link toc-highlight">Context Compression</a>
- <a href="#background-sessions" class="table-of-contents__link toc-highlight">Background Sessions</a>
  - <a href="#how-it-works" class="table-of-contents__link toc-highlight">How It Works</a>
  - <a href="#results" class="table-of-contents__link toc-highlight">Results</a>
  - <a href="#use-cases" class="table-of-contents__link toc-highlight">Use Cases</a>
- <a href="#quiet-mode" class="table-of-contents__link toc-highlight">Quiet Mode</a>


