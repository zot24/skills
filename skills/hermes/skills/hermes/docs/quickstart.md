> Source: https://hermes-agent.nousresearch.com/docs/getting-started/quickstart/



On this page


# Quickstart


This guide walks you through installing Hermes Agent, setting up a provider, and having your first conversation. By the end, you'll know the key features and how to explore further.

## 1. Install Hermes Agent<a href="#1-install-hermes-agent" class="hash-link" aria-label="Direct link to 1. Install Hermes Agent" translate="no" title="Direct link to 1. Install Hermes Agent">​</a>

Run the one-line installer:


``` bash
# Linux / macOS / WSL2
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```


Install <a href="https://learn.microsoft.com/en-us/windows/wsl/install" target="_blank" rel="noopener noreferrer">WSL2</a> first, then run the command above inside your WSL2 terminal.


After it finishes, reload your shell:


``` bash
source ~/.bashrc   # or source ~/.zshrc
```


## 2. Set Up a Provider<a href="#2-set-up-a-provider" class="hash-link" aria-label="Direct link to 2. Set Up a Provider" translate="no" title="Direct link to 2. Set Up a Provider">​</a>

The installer configures your LLM provider automatically. To change it later, use one of these commands:


``` bash
hermes model       # Choose your LLM provider and model
hermes tools       # Configure which tools are enabled
hermes setup       # Or configure everything at once
```


`hermes model` walks you through selecting an inference provider:

| Provider | What it is | How to set up |
|----|----|----|
| **Nous Portal** | Subscription-based, zero-config | OAuth login via `hermes model` |
| **OpenAI Codex** | ChatGPT OAuth, uses Codex models | Device code auth via `hermes model` |
| **Anthropic** | Claude models directly (Pro/Max or API key) | `hermes model` with Claude Code auth, or an Anthropic API key |
| **OpenRouter** | Multi-provider routing across many models | Enter your API key |
| **Z.AI** | GLM / Zhipu-hosted models | Set `GLM_API_KEY` / `ZAI_API_KEY` |
| **Kimi / Moonshot** | Moonshot-hosted coding and chat models | Set `KIMI_API_KEY` |
| **MiniMax** | International MiniMax endpoint | Set `MINIMAX_API_KEY` |
| **MiniMax China** | China-region MiniMax endpoint | Set `MINIMAX_CN_API_KEY` |
| **Alibaba Cloud** | Qwen models via DashScope | Set `DASHSCOPE_API_KEY` |
| **Hugging Face** | 20+ open models via unified router (Qwen, DeepSeek, Kimi, etc.) | Set `HF_TOKEN` |
| **Kilo Code** | KiloCode-hosted models | Set `KILOCODE_API_KEY` |
| **OpenCode Zen** | Pay-as-you-go access to curated models | Set `OPENCODE_ZEN_API_KEY` |
| **OpenCode Go** | \$10/month subscription for open models | Set `OPENCODE_GO_API_KEY` |
| **Vercel AI Gateway** | Vercel AI Gateway routing | Set `AI_GATEWAY_API_KEY` |
| **Custom Endpoint** | VLLM, SGLang, Ollama, or any OpenAI-compatible API | Set base URL + API key |


You can switch providers at any time with `hermes model` — no code changes, no lock-in. When configuring a custom endpoint, Hermes will prompt for the context window size and auto-detect it when possible. See [Context Length Detection](/docs/user-guide/configuration#context-length-detection) for details.


## 3. Start Chatting<a href="#3-start-chatting" class="hash-link" aria-label="Direct link to 3. Start Chatting" translate="no" title="Direct link to 3. Start Chatting">​</a>


``` bash
hermes
```


That's it! You'll see a welcome banner with your model, available tools, and skills. Type a message and press Enter.


``` text
❯ What can you help me with?
```


The agent has access to tools for web search, file operations, terminal commands, and more — all out of the box.

## 4. Try Key Features<a href="#4-try-key-features" class="hash-link" aria-label="Direct link to 4. Try Key Features" translate="no" title="Direct link to 4. Try Key Features">​</a>

### Ask it to use the terminal<a href="#ask-it-to-use-the-terminal" class="hash-link" aria-label="Direct link to Ask it to use the terminal" translate="no" title="Direct link to Ask it to use the terminal">​</a>


``` text
❯ What's my disk usage? Show the top 5 largest directories.
```


The agent will run terminal commands on your behalf and show you the results.

### Use slash commands<a href="#use-slash-commands" class="hash-link" aria-label="Direct link to Use slash commands" translate="no" title="Direct link to Use slash commands">​</a>

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

If the agent is taking too long, just type a new message and press Enter — it interrupts the current task and switches to your new instructions. `Ctrl+C` also works.

### Resume a session<a href="#resume-a-session" class="hash-link" aria-label="Direct link to Resume a session" translate="no" title="Direct link to Resume a session">​</a>

When you exit, hermes prints a resume command:


``` bash
hermes --continue    # Resume the most recent session
hermes -c            # Short form
```


## 5. Explore Further<a href="#5-explore-further" class="hash-link" aria-label="Direct link to 5. Explore Further" translate="no" title="Direct link to 5. Explore Further">​</a>

Here are some things to try next:

### Set up a sandboxed terminal<a href="#set-up-a-sandboxed-terminal" class="hash-link" aria-label="Direct link to Set up a sandboxed terminal" translate="no" title="Direct link to Set up a sandboxed terminal">​</a>

For safety, run the agent in a Docker container or on a remote server:


``` bash
hermes config set terminal.backend docker    # Docker isolation
hermes config set terminal.backend ssh       # Remote server
```


### Connect messaging platforms<a href="#connect-messaging-platforms" class="hash-link" aria-label="Direct link to Connect messaging platforms" translate="no" title="Direct link to Connect messaging platforms">​</a>

Chat with Hermes from your phone or other surfaces via Telegram, Discord, Slack, WhatsApp, Signal, Email, or Home Assistant:


``` bash
hermes gateway setup    # Interactive platform configuration
```


### Add voice mode<a href="#add-voice-mode" class="hash-link" aria-label="Direct link to Add voice mode" translate="no" title="Direct link to Add voice mode">​</a>

Want microphone input in the CLI or spoken replies in messaging?


``` bash
pip install "hermes-agent[voice]"

# Optional but recommended for free local speech-to-text
pip install faster-whisper
```


Then start Hermes and enable it inside the CLI:


``` text
/voice on
```


Press `Ctrl+B` to record, or use `/voice tts` to have Hermes speak its replies. See [Voice Mode](/docs/user-guide/features/voice-mode) for the full setup across CLI, Telegram, Discord, and Discord voice channels.

### Schedule automated tasks<a href="#schedule-automated-tasks" class="hash-link" aria-label="Direct link to Schedule automated tasks" translate="no" title="Direct link to Schedule automated tasks">​</a>


``` text
❯ Every morning at 9am, check Hacker News for AI news and send me a summary on Telegram.
```


The agent will set up a cron job that runs automatically via the gateway.

### Browse and install skills<a href="#browse-and-install-skills" class="hash-link" aria-label="Direct link to Browse and install skills" translate="no" title="Direct link to Browse and install skills">​</a>


``` bash
hermes skills search kubernetes
hermes skills search react --source skills-sh
hermes skills search https://mintlify.com/docs --source well-known
hermes skills install openai/skills/k8s
hermes skills install official/security/1password
hermes skills install skills-sh/vercel-labs/json-render/json-render-react --force
```


Tips:

- Use `--source skills-sh` to search the public `skills.sh` directory.
- Use `--source well-known` with a docs/site URL to discover skills from `/.well-known/skills/index.json`.
- Use `--force` only after reviewing a third-party skill. It can override non-dangerous policy blocks, but not a `dangerous` scan verdict.

Or use the `/skills` slash command inside chat.

### Use Hermes inside an editor via ACP<a href="#use-hermes-inside-an-editor-via-acp" class="hash-link" aria-label="Direct link to Use Hermes inside an editor via ACP" translate="no" title="Direct link to Use Hermes inside an editor via ACP">​</a>

Hermes can also run as an ACP server for ACP-compatible editors like VS Code, Zed, and JetBrains:


``` bash
pip install -e '.[acp]'
hermes acp
```


See [ACP Editor Integration](/docs/user-guide/features/acp) for setup details.

### Try MCP servers<a href="#try-mcp-servers" class="hash-link" aria-label="Direct link to Try MCP servers" translate="no" title="Direct link to Try MCP servers">​</a>

Connect to external tools via the Model Context Protocol:


``` yaml
# Add to ~/.hermes/config.yaml
mcp_servers:
  github:
    command: npx
    args: ["-y", "@modelcontextprotocol/server-github"]
    env:
      GITHUB_PERSONAL_ACCESS_TOKEN: "ghp_xxx"
```


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


- <a href="#1-install-hermes-agent" class="table-of-contents__link toc-highlight">1. Install Hermes Agent</a>
- <a href="#2-set-up-a-provider" class="table-of-contents__link toc-highlight">2. Set Up a Provider</a>
- <a href="#3-start-chatting" class="table-of-contents__link toc-highlight">3. Start Chatting</a>
- <a href="#4-try-key-features" class="table-of-contents__link toc-highlight">4. Try Key Features</a>
  - <a href="#ask-it-to-use-the-terminal" class="table-of-contents__link toc-highlight">Ask it to use the terminal</a>
  - <a href="#use-slash-commands" class="table-of-contents__link toc-highlight">Use slash commands</a>
  - <a href="#multi-line-input" class="table-of-contents__link toc-highlight">Multi-line input</a>
  - <a href="#interrupt-the-agent" class="table-of-contents__link toc-highlight">Interrupt the agent</a>
  - <a href="#resume-a-session" class="table-of-contents__link toc-highlight">Resume a session</a>
- <a href="#5-explore-further" class="table-of-contents__link toc-highlight">5. Explore Further</a>
  - <a href="#set-up-a-sandboxed-terminal" class="table-of-contents__link toc-highlight">Set up a sandboxed terminal</a>
  - <a href="#connect-messaging-platforms" class="table-of-contents__link toc-highlight">Connect messaging platforms</a>
  - <a href="#add-voice-mode" class="table-of-contents__link toc-highlight">Add voice mode</a>
  - <a href="#schedule-automated-tasks" class="table-of-contents__link toc-highlight">Schedule automated tasks</a>
  - <a href="#browse-and-install-skills" class="table-of-contents__link toc-highlight">Browse and install skills</a>
  - <a href="#use-hermes-inside-an-editor-via-acp" class="table-of-contents__link toc-highlight">Use Hermes inside an editor via ACP</a>
  - <a href="#try-mcp-servers" class="table-of-contents__link toc-highlight">Try MCP servers</a>
- <a href="#quick-reference" class="table-of-contents__link toc-highlight">Quick Reference</a>
- <a href="#next-steps" class="table-of-contents__link toc-highlight">Next Steps</a>


