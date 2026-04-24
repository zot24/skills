> Source: https://hermes-agent.nousresearch.com/docs/getting-started/quickstart/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Quickstart


This guide gets you from zero to a working Hermes setup that survives real use. Install, choose a provider, verify a working chat, and know exactly what to do when something breaks.

## Who this is for<a href="#who-this-is-for" class="hash-link" aria-label="Direct link to Who this is for" translate="no" title="Direct link to Who this is for">​</a>

- Brand new and want the shortest path to a working setup
- Switching providers and don't want to lose time to config mistakes
- Setting up Hermes for a team, bot, or always-on workflow
- Tired of "it installed, but it still does nothing"

## The fastest path<a href="#the-fastest-path" class="hash-link" aria-label="Direct link to The fastest path" translate="no" title="Direct link to The fastest path">​</a>

Pick the row that matches your goal:

| Goal                                     | Do this first                          | Then do this                                            |
|------------------------------------------|----------------------------------------|---------------------------------------------------------|
| I just want Hermes working on my machine | `hermes setup`                         | Run a real chat and verify it responds                  |
| I already know my provider               | `hermes model`                         | Save the config, then start chatting                    |
| I want a bot or always-on setup          | `hermes gateway setup` after CLI works | Connect Telegram, Discord, Slack, or another platform   |
| I want a local or self-hosted model      | `hermes model` → custom endpoint       | Verify the endpoint, model name, and context length     |
| I want multi-provider fallback           | `hermes model` first                   | Add routing and fallback only after the base chat works |

**Rule of thumb:** if Hermes cannot complete a normal chat, do not add more features yet. Get one clean conversation working first, then layer on gateway, cron, skills, voice, or routing.

------------------------------------------------------------------------

## 1. Install Hermes Agent<a href="#1-install-hermes-agent" class="hash-link" aria-label="Direct link to 1. Install Hermes Agent" translate="no" title="Direct link to 1. Install Hermes Agent">​</a>

Run the one-line installer:


``` prism-code
# Linux / macOS / WSL2 / Android (Termux)
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```


If you're installing on a phone, see the dedicated [Termux guide](/docs/getting-started/termux) for the tested manual path, supported extras, and current Android-specific limitations.


Install <a href="https://learn.microsoft.com/en-us/windows/wsl/install" target="_blank" rel="noopener noreferrer">WSL2</a> first, then run the command above inside your WSL2 terminal.


After it finishes, reload your shell:


``` prism-code
source ~/.bashrc   # or source ~/.zshrc
```


For detailed installation options, prerequisites, and troubleshooting, see the [Installation guide](/docs/getting-started/installation).

## 2. Choose a Provider<a href="#2-choose-a-provider" class="hash-link" aria-label="Direct link to 2. Choose a Provider" translate="no" title="Direct link to 2. Choose a Provider">​</a>

The single most important setup step. Use `hermes model` to walk through the choice interactively:


``` prism-code
hermes model
```


Good defaults:

| Situation                             | Recommended path                                         |
|---------------------------------------|----------------------------------------------------------|
| Least friction                        | Nous Portal or OpenRouter                                |
| You already have Claude or Codex auth | Anthropic or OpenAI Codex                                |
| You want local/private inference      | Ollama or any custom OpenAI-compatible endpoint          |
| You want multi-provider routing       | OpenRouter                                               |
| You have a custom GPU server          | vLLM, SGLang, LiteLLM, or any OpenAI-compatible endpoint |

For most first-time users: choose a provider, accept the defaults unless you know why you're changing them. The full provider catalog with env vars and setup steps lives on the [Providers](/docs/integrations/providers) page.


Hermes Agent requires a model with at least **64,000 tokens** of context. Models with smaller windows cannot maintain enough working memory for multi-step tool-calling workflows and will be rejected at startup. Most hosted models (Claude, GPT, Gemini, Qwen, DeepSeek) meet this easily. If you're running a local model, set its context size to at least 64K (e.g. `--ctx-size 65536` for llama.cpp or `-c 65536` for Ollama).


You can switch providers at any time with `hermes model` — no lock-in. For a full list of all supported providers and setup details, see [AI Providers](/docs/integrations/providers).


### How settings are stored<a href="#how-settings-are-stored" class="hash-link" aria-label="Direct link to How settings are stored" translate="no" title="Direct link to How settings are stored">​</a>

Hermes separates secrets from normal config:

- **Secrets and tokens** → `~/.hermes/.env`
- **Non-secret settings** → `~/.hermes/config.yaml`

The easiest way to set values correctly is through the CLI:


``` prism-code
hermes config set model anthropic/claude-opus-4.6
hermes config set terminal.backend docker
hermes config set OPENROUTER_API_KEY sk-or-...
```


The right value goes to the right file automatically.

## 3. Run Your First Chat<a href="#3-run-your-first-chat" class="hash-link" aria-label="Direct link to 3. Run Your First Chat" translate="no" title="Direct link to 3. Run Your First Chat">​</a>


``` prism-code
hermes            # classic CLI
hermes --tui      # modern TUI (recommended)
```


You'll see a welcome banner with your model, available tools, and skills. Use a prompt that's specific and easy to verify:


Hermes ships with two terminal interfaces: the classic `prompt_toolkit` CLI and a newer [TUI](/docs/user-guide/tui) with modal overlays, mouse selection, and non-blocking input. Both share the same sessions, slash commands, and config — try each with `hermes` vs `hermes --tui`.


``` prism-code
Summarize this repo in 5 bullets and tell me what the main entrypoint is.
```


``` prism-code
Check my current directory and tell me what looks like the main project file.
```


``` prism-code
Help me set up a clean GitHub PR workflow for this codebase.
```


**What success looks like:**

- The banner shows your chosen model/provider
- Hermes replies without error
- It can use a tool if needed (terminal, file read, web search)
- The conversation continues normally for more than one turn

If that works, you're past the hardest part.

## 4. Verify Sessions Work<a href="#4-verify-sessions-work" class="hash-link" aria-label="Direct link to 4. Verify Sessions Work" translate="no" title="Direct link to 4. Verify Sessions Work">​</a>

Before moving on, make sure resume works:


``` prism-code
hermes --continue    # Resume the most recent session
hermes -c            # Short form
```


That should bring you back to the session you just had. If it doesn't, check whether you're in the same profile and whether the session actually saved. This matters later when you're juggling multiple setups or machines.

## 5. Try Key Features<a href="#5-try-key-features" class="hash-link" aria-label="Direct link to 5. Try Key Features" translate="no" title="Direct link to 5. Try Key Features">​</a>

### Use the terminal<a href="#use-the-terminal" class="hash-link" aria-label="Direct link to Use the terminal" translate="no" title="Direct link to Use the terminal">​</a>


``` prism-code
❯ What's my disk usage? Show the top 5 largest directories.
```


The agent runs terminal commands on your behalf and shows results.

### Slash commands<a href="#slash-commands" class="hash-link" aria-label="Direct link to Slash commands" translate="no" title="Direct link to Slash commands">​</a>

Type `/` to see an autocomplete dropdown of all commands:

| Command               | What it does                |
|-----------------------|-----------------------------|
| `/help`               | Show all available commands |
| `/tools`              | List available tools        |
| `/model`              | Switch models interactively |
| `/personality pirate` | Try a fun personality       |
| `/save`               | Save the conversation       |

### Multi-line input<a href="#multi-line-input" class="hash-link" aria-label="Direct link to Multi-line input" translate="no" title="Direct link to Multi-line input">​</a>

Press `Alt+Enter` or `Ctrl+J` to add a new line. Great for pasting code or writing detailed prompts.

### Interrupt the agent<a href="#interrupt-the-agent" class="hash-link" aria-label="Direct link to Interrupt the agent" translate="no" title="Direct link to Interrupt the agent">​</a>

If the agent is taking too long, type a new message and press Enter — it interrupts the current task and switches to your new instructions. `Ctrl+C` also works.

## 6. Add the Next Layer<a href="#6-add-the-next-layer" class="hash-link" aria-label="Direct link to 6. Add the Next Layer" translate="no" title="Direct link to 6. Add the Next Layer">​</a>

Only after the base chat works. Pick what you need:

### Bot or shared assistant<a href="#bot-or-shared-assistant" class="hash-link" aria-label="Direct link to Bot or shared assistant" translate="no" title="Direct link to Bot or shared assistant">​</a>


``` prism-code
hermes gateway setup    # Interactive platform configuration
```


Connect [Telegram](/docs/user-guide/messaging/telegram), [Discord](/docs/user-guide/messaging/discord), [Slack](/docs/user-guide/messaging/slack), [WhatsApp](/docs/user-guide/messaging/whatsapp), [Signal](/docs/user-guide/messaging/signal), [Email](/docs/user-guide/messaging/email), or [Home Assistant](/docs/user-guide/messaging/homeassistant).

### Automation and tools<a href="#automation-and-tools" class="hash-link" aria-label="Direct link to Automation and tools" translate="no" title="Direct link to Automation and tools">​</a>

- `hermes tools` — tune tool access per platform
- `hermes skills` — browse and install reusable workflows
- Cron — only after your bot or CLI setup is stable

### Sandboxed terminal<a href="#sandboxed-terminal" class="hash-link" aria-label="Direct link to Sandboxed terminal" translate="no" title="Direct link to Sandboxed terminal">​</a>

For safety, run the agent in a Docker container or on a remote server:


``` prism-code
hermes config set terminal.backend docker    # Docker isolation
hermes config set terminal.backend ssh       # Remote server
```


### Voice mode<a href="#voice-mode" class="hash-link" aria-label="Direct link to Voice mode" translate="no" title="Direct link to Voice mode">​</a>


``` prism-code
pip install "hermes-agent[voice]"
# Includes faster-whisper for free local speech-to-text
```


Then in the CLI: `/voice on`. Press `Ctrl+B` to record. See [Voice Mode](/docs/user-guide/features/voice-mode).

### Skills<a href="#skills" class="hash-link" aria-label="Direct link to Skills" translate="no" title="Direct link to Skills">​</a>


``` prism-code
hermes skills search kubernetes
hermes skills install openai/skills/k8s
```


Or use `/skills` inside a chat session.

### MCP servers<a href="#mcp-servers" class="hash-link" aria-label="Direct link to MCP servers" translate="no" title="Direct link to MCP servers">​</a>


``` prism-code
# Add to ~/.hermes/config.yaml
mcp_servers:
  github:
    command: npx
    args: ["-y", "@modelcontextprotocol/server-github"]
    env:
      GITHUB_PERSONAL_ACCESS_TOKEN: "ghp_xxx"
```


### Editor integration (ACP)<a href="#editor-integration-acp" class="hash-link" aria-label="Direct link to Editor integration (ACP)" translate="no" title="Direct link to Editor integration (ACP)">​</a>


``` prism-code
pip install -e '.[acp]'
hermes acp
```


See [ACP Editor Integration](/docs/user-guide/features/acp).

------------------------------------------------------------------------

## Common Failure Modes<a href="#common-failure-modes" class="hash-link" aria-label="Direct link to Common Failure Modes" translate="no" title="Direct link to Common Failure Modes">​</a>

These are the problems that waste the most time:

| Symptom                                        | Likely cause                                                  | Fix                                                                  |
|------------------------------------------------|---------------------------------------------------------------|----------------------------------------------------------------------|
| Hermes opens but gives empty or broken replies | Provider auth or model selection is wrong                     | Run `hermes model` again and confirm provider, model, and auth       |
| Custom endpoint "works" but returns garbage    | Wrong base URL, model name, or not actually OpenAI-compatible | Verify the endpoint in a separate client first                       |
| Gateway starts but nobody can message it       | Bot token, allowlist, or platform setup is incomplete         | Re-run `hermes gateway setup` and check `hermes gateway status`      |
| `hermes --continue` can't find old session     | Switched profiles or session never saved                      | Check `hermes sessions list` and confirm you're in the right profile |
| Model unavailable or odd fallback behavior     | Provider routing or fallback settings are too aggressive      | Keep routing off until the base provider is stable                   |
| `hermes doctor` flags config problems          | Config values are missing or stale                            | Fix the config, retest a plain chat before adding features           |

## Recovery Toolkit<a href="#recovery-toolkit" class="hash-link" aria-label="Direct link to Recovery Toolkit" translate="no" title="Direct link to Recovery Toolkit">​</a>

When something feels off, use this order:

1.  `hermes doctor`
2.  `hermes model`
3.  `hermes setup`
4.  `hermes sessions list`
5.  `hermes --continue`
6.  `hermes gateway status`

That sequence gets you from "broken vibes" back to a known state fast.

------------------------------------------------------------------------

## Quick Reference<a href="#quick-reference" class="hash-link" aria-label="Direct link to Quick Reference" translate="no" title="Direct link to Quick Reference">​</a>

| Command             | Description                                       |
|---------------------|---------------------------------------------------|
| `hermes`            | Start chatting                                    |
| `hermes model`      | Choose your LLM provider and model                |
| `hermes tools`      | Configure which tools are enabled per platform    |
| `hermes setup`      | Full setup wizard (configures everything at once) |
| `hermes doctor`     | Diagnose issues                                   |
| `hermes update`     | Update to latest version                          |
| `hermes gateway`    | Start the messaging gateway                       |
| `hermes --continue` | Resume last session                               |

## Next Steps<a href="#next-steps" class="hash-link" aria-label="Direct link to Next Steps" translate="no" title="Direct link to Next Steps">​</a>

- **[CLI Guide](/docs/user-guide/cli)** — Master the terminal interface
- **[Configuration](/docs/user-guide/configuration)** — Customize your setup
- **[Messaging Gateway](/docs/user-guide/messaging/)** — Connect Telegram, Discord, Slack, WhatsApp, Signal, Email, or Home Assistant
- **[Tools & Toolsets](/docs/user-guide/features/tools)** — Explore available capabilities
- **[AI Providers](/docs/integrations/providers)** — Full provider list and setup details
- **[Skills System](/docs/user-guide/features/skills)** — Reusable workflows and knowledge
- **[Tips & Best Practices](/docs/guides/tips)** — Power user tips


- <a href="#who-this-is-for" class="table-of-contents__link toc-highlight">Who this is for</a>
- <a href="#the-fastest-path" class="table-of-contents__link toc-highlight">The fastest path</a>
- <a href="#1-install-hermes-agent" class="table-of-contents__link toc-highlight">1. Install Hermes Agent</a>
- <a href="#2-choose-a-provider" class="table-of-contents__link toc-highlight">2. Choose a Provider</a>
  - <a href="#how-settings-are-stored" class="table-of-contents__link toc-highlight">How settings are stored</a>
- <a href="#3-run-your-first-chat" class="table-of-contents__link toc-highlight">3. Run Your First Chat</a>
- <a href="#4-verify-sessions-work" class="table-of-contents__link toc-highlight">4. Verify Sessions Work</a>
- <a href="#5-try-key-features" class="table-of-contents__link toc-highlight">5. Try Key Features</a>
  - <a href="#use-the-terminal" class="table-of-contents__link toc-highlight">Use the terminal</a>
  - <a href="#slash-commands" class="table-of-contents__link toc-highlight">Slash commands</a>
  - <a href="#multi-line-input" class="table-of-contents__link toc-highlight">Multi-line input</a>
  - <a href="#interrupt-the-agent" class="table-of-contents__link toc-highlight">Interrupt the agent</a>
- <a href="#6-add-the-next-layer" class="table-of-contents__link toc-highlight">6. Add the Next Layer</a>
  - <a href="#bot-or-shared-assistant" class="table-of-contents__link toc-highlight">Bot or shared assistant</a>
  - <a href="#automation-and-tools" class="table-of-contents__link toc-highlight">Automation and tools</a>
  - <a href="#sandboxed-terminal" class="table-of-contents__link toc-highlight">Sandboxed terminal</a>
  - <a href="#voice-mode" class="table-of-contents__link toc-highlight">Voice mode</a>
  - <a href="#skills" class="table-of-contents__link toc-highlight">Skills</a>
  - <a href="#mcp-servers" class="table-of-contents__link toc-highlight">MCP servers</a>
  - <a href="#editor-integration-acp" class="table-of-contents__link toc-highlight">Editor integration (ACP)</a>
- <a href="#common-failure-modes" class="table-of-contents__link toc-highlight">Common Failure Modes</a>
- <a href="#recovery-toolkit" class="table-of-contents__link toc-highlight">Recovery Toolkit</a>
- <a href="#quick-reference" class="table-of-contents__link toc-highlight">Quick Reference</a>
- <a href="#next-steps" class="table-of-contents__link toc-highlight">Next Steps</a>


