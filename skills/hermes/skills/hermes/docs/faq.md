> Source: https://hermes-agent.nousresearch.com/docs/reference/faq/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# FAQ & Troubleshooting


Quick answers and fixes for the most common questions and issues.

------------------------------------------------------------------------

## Frequently Asked Questions<a href="#frequently-asked-questions" class="hash-link" aria-label="Direct link to Frequently Asked Questions" translate="no" title="Direct link to Frequently Asked Questions">​</a>

### What LLM providers work with Hermes?<a href="#what-llm-providers-work-with-hermes" class="hash-link" aria-label="Direct link to What LLM providers work with Hermes?" translate="no" title="Direct link to What LLM providers work with Hermes?">​</a>

Hermes Agent works with any OpenAI-compatible API. Supported providers include:

- **<a href="https://openrouter.ai/" target="_blank" rel="noopener noreferrer">OpenRouter</a>** — access hundreds of models through one API key (recommended for flexibility)
- **Nous Portal** — Nous Research's own inference endpoint
- **OpenAI** — GPT-4o, o1, o3, etc.
- **Anthropic** — Claude models (via OpenRouter or compatible proxy)
- **Google** — Gemini models (via OpenRouter or compatible proxy)
- **z.ai / ZhipuAI** — GLM models
- **Kimi / Moonshot AI** — Kimi models
- **MiniMax** — global and China endpoints
- **Local models** — via <a href="https://ollama.com/" target="_blank" rel="noopener noreferrer">Ollama</a>, <a href="https://docs.vllm.ai/" target="_blank" rel="noopener noreferrer">vLLM</a>, <a href="https://github.com/ggerganov/llama.cpp" target="_blank" rel="noopener noreferrer">llama.cpp</a>, <a href="https://github.com/sgl-project/sglang" target="_blank" rel="noopener noreferrer">SGLang</a>, or any OpenAI-compatible server

Set your provider with `hermes model` or by editing `~/.hermes/.env`. See the [Environment Variables](/docs/reference/environment-variables) reference for all provider keys.

### Does it work on Windows?<a href="#does-it-work-on-windows" class="hash-link" aria-label="Direct link to Does it work on Windows?" translate="no" title="Direct link to Does it work on Windows?">​</a>

**Not natively.** Hermes Agent requires a Unix-like environment. On Windows, install <a href="https://learn.microsoft.com/en-us/windows/wsl/install" target="_blank" rel="noopener noreferrer">WSL2</a> and run Hermes from inside it. The standard install command works perfectly in WSL2:


``` prism-code
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```


### Is my data sent anywhere?<a href="#is-my-data-sent-anywhere" class="hash-link" aria-label="Direct link to Is my data sent anywhere?" translate="no" title="Direct link to Is my data sent anywhere?">​</a>

API calls go **only to the LLM provider you configure** (e.g., OpenRouter, your local Ollama instance). Hermes Agent does not collect telemetry, usage data, or analytics. Your conversations, memory, and skills are stored locally in `~/.hermes/`.

### Can I use it offline / with local models?<a href="#can-i-use-it-offline--with-local-models" class="hash-link" aria-label="Direct link to Can I use it offline / with local models?" translate="no" title="Direct link to Can I use it offline / with local models?">​</a>

Yes. Run `hermes model`, select **Custom endpoint**, and enter your server's URL:


``` prism-code
hermes model
# Select: Custom endpoint (enter URL manually)
# API base URL: http://localhost:11434/v1
# API key: ollama
# Model name: qwen3.5:27b
# Context length: 32768   ← set this to match your server's actual context window
```


Or configure it directly in `config.yaml`:


``` prism-code
model:
  default: qwen3.5:27b
  provider: custom
  base_url: http://localhost:11434/v1
```


Hermes persists the endpoint, provider, and base URL in `config.yaml` so it survives restarts. If your local server has exactly one model loaded, `/model custom` auto-detects it. You can also set `provider: custom` in config.yaml — it's a first-class provider, not an alias for anything else.

This works with Ollama, vLLM, llama.cpp server, SGLang, LocalAI, and others. See the [Configuration guide](/docs/user-guide/configuration) for details.


If you set a custom `num_ctx` in Ollama (e.g., `ollama run --num_ctx 16384`), make sure to set the matching context length in Hermes — Ollama's `/api/show` reports the model's *maximum* context, not the effective `num_ctx` you configured.


### How much does it cost?<a href="#how-much-does-it-cost" class="hash-link" aria-label="Direct link to How much does it cost?" translate="no" title="Direct link to How much does it cost?">​</a>

Hermes Agent itself is **free and open-source** (MIT license). You pay only for the LLM API usage from your chosen provider. Local models are completely free to run.

### Can multiple people use one instance?<a href="#can-multiple-people-use-one-instance" class="hash-link" aria-label="Direct link to Can multiple people use one instance?" translate="no" title="Direct link to Can multiple people use one instance?">​</a>

Yes. The [messaging gateway](/docs/user-guide/messaging/) lets multiple users interact with the same Hermes Agent instance via Telegram, Discord, Slack, WhatsApp, or Home Assistant. Access is controlled through allowlists (specific user IDs) and DM pairing (first user to message claims access).

### What's the difference between memory and skills?<a href="#whats-the-difference-between-memory-and-skills" class="hash-link" aria-label="Direct link to What&#39;s the difference between memory and skills?" translate="no" title="Direct link to What&#39;s the difference between memory and skills?">​</a>

- **Memory** stores **facts** — things the agent knows about you, your projects, and preferences. Memories are retrieved automatically based on relevance.
- **Skills** store **procedures** — step-by-step instructions for how to do things. Skills are recalled when the agent encounters a similar task.

Both persist across sessions. See [Memory](/docs/user-guide/features/memory) and [Skills](/docs/user-guide/features/skills) for details.

### Can I use it in my own Python project?<a href="#can-i-use-it-in-my-own-python-project" class="hash-link" aria-label="Direct link to Can I use it in my own Python project?" translate="no" title="Direct link to Can I use it in my own Python project?">​</a>

Yes. Import the `AIAgent` class and use Hermes programmatically:


``` prism-code
from hermes.agent import AIAgent

agent = AIAgent(model="openrouter/nous/hermes-3-llama-3.1-70b")
response = agent.chat("Explain quantum computing briefly")
```


See the [Python Library guide](/docs/user-guide/features/code-execution) for full API usage.

------------------------------------------------------------------------

## Troubleshooting<a href="#troubleshooting" class="hash-link" aria-label="Direct link to Troubleshooting" translate="no" title="Direct link to Troubleshooting">​</a>

### Installation Issues<a href="#installation-issues" class="hash-link" aria-label="Direct link to Installation Issues" translate="no" title="Direct link to Installation Issues">​</a>

#### `hermes: command not found` after installation<a href="#hermes-command-not-found-after-installation" class="hash-link" aria-label="Direct link to hermes-command-not-found-after-installation" translate="no" title="Direct link to hermes-command-not-found-after-installation">​</a>

**Cause:** Your shell hasn't reloaded the updated PATH.

**Solution:**


``` prism-code
# Reload your shell profile
source ~/.bashrc    # bash
source ~/.zshrc     # zsh

# Or start a new terminal session
```


If it still doesn't work, verify the install location:


``` prism-code
which hermes
ls ~/.local/bin/hermes
```


The installer adds `~/.local/bin` to your PATH. If you use a non-standard shell config, add `export PATH="$HOME/.local/bin:$PATH"` manually.


#### Python version too old<a href="#python-version-too-old" class="hash-link" aria-label="Direct link to Python version too old" translate="no" title="Direct link to Python version too old">​</a>

**Cause:** Hermes requires Python 3.11 or newer.

**Solution:**


``` prism-code
python3 --version   # Check current version

# Install a newer Python
sudo apt install python3.12   # Ubuntu/Debian
brew install python@3.12      # macOS
```


The installer handles this automatically — if you see this error during manual installation, upgrade Python first.

#### `uv: command not found`<a href="#uv-command-not-found" class="hash-link" aria-label="Direct link to uv-command-not-found" translate="no" title="Direct link to uv-command-not-found">​</a>

**Cause:** The `uv` package manager isn't installed or not in PATH.

**Solution:**


``` prism-code
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.bashrc
```


#### Permission denied errors during install<a href="#permission-denied-errors-during-install" class="hash-link" aria-label="Direct link to Permission denied errors during install" translate="no" title="Direct link to Permission denied errors during install">​</a>

**Cause:** Insufficient permissions to write to the install directory.

**Solution:**


``` prism-code
# Don't use sudo with the installer — it installs to ~/.local/bin
# If you previously installed with sudo, clean up:
sudo rm /usr/local/bin/hermes
# Then re-run the standard installer
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```


------------------------------------------------------------------------

### Provider & Model Issues<a href="#provider--model-issues" class="hash-link" aria-label="Direct link to Provider &amp; Model Issues" translate="no" title="Direct link to Provider &amp; Model Issues">​</a>

#### API key not working<a href="#api-key-not-working" class="hash-link" aria-label="Direct link to API key not working" translate="no" title="Direct link to API key not working">​</a>

**Cause:** Key is missing, expired, incorrectly set, or for the wrong provider.

**Solution:**


``` prism-code
# Check your configuration
hermes config show

# Re-configure your provider
hermes model

# Or set directly
hermes config set OPENROUTER_API_KEY sk-or-v1-xxxxxxxxxxxx
```


Make sure the key matches the provider. An OpenAI key won't work with OpenRouter and vice versa. Check `~/.hermes/.env` for conflicting entries.


#### Model not available / model not found<a href="#model-not-available--model-not-found" class="hash-link" aria-label="Direct link to Model not available / model not found" translate="no" title="Direct link to Model not available / model not found">​</a>

**Cause:** The model identifier is incorrect or not available on your provider.

**Solution:**


``` prism-code
# List available models for your provider
hermes model

# Set a valid model
hermes config set HERMES_MODEL openrouter/nous/hermes-3-llama-3.1-70b

# Or specify per-session
hermes chat --model openrouter/meta-llama/llama-3.1-70b-instruct
```


#### Rate limiting (429 errors)<a href="#rate-limiting-429-errors" class="hash-link" aria-label="Direct link to Rate limiting (429 errors)" translate="no" title="Direct link to Rate limiting (429 errors)">​</a>

**Cause:** You've exceeded your provider's rate limits.

**Solution:** Wait a moment and retry. For sustained usage, consider:

- Upgrading your provider plan
- Switching to a different model or provider
- Using `hermes chat --provider <alternative>` to route to a different backend

#### Context length exceeded<a href="#context-length-exceeded" class="hash-link" aria-label="Direct link to Context length exceeded" translate="no" title="Direct link to Context length exceeded">​</a>

**Cause:** The conversation has grown too long for the model's context window, or Hermes detected the wrong context length for your model.

**Solution:**


``` prism-code
# Compress the current session
/compress

# Or start a fresh session
hermes chat

# Use a model with a larger context window
hermes chat --model openrouter/google/gemini-2.0-flash-001
```


If this happens on the first long conversation, Hermes may have the wrong context length for your model. Check what it detected:

Look at the CLI startup line — it shows the detected context length (e.g., `📊 Context limit: 128000 tokens`). You can also check with `/usage` during a session.

To fix context detection, set it explicitly:


``` prism-code
# In ~/.hermes/config.yaml
model:
  default: your-model-name
  context_length: 131072  # your model's actual context window
```


Or for custom endpoints, add it per-model:


``` prism-code
custom_providers:
  - name: "My Server"
    base_url: "http://localhost:11434/v1"
    models:
      qwen3.5:27b:
        context_length: 32768
```


See [Context Length Detection](/docs/integrations/providers#context-length-detection) for how auto-detection works and all override options.

------------------------------------------------------------------------

### Terminal Issues<a href="#terminal-issues" class="hash-link" aria-label="Direct link to Terminal Issues" translate="no" title="Direct link to Terminal Issues">​</a>

#### Command blocked as dangerous<a href="#command-blocked-as-dangerous" class="hash-link" aria-label="Direct link to Command blocked as dangerous" translate="no" title="Direct link to Command blocked as dangerous">​</a>

**Cause:** Hermes detected a potentially destructive command (e.g., `rm -rf`, `DROP TABLE`). This is a safety feature.

**Solution:** When prompted, review the command and type `y` to approve it. You can also:

- Ask the agent to use a safer alternative
- See the full list of dangerous patterns in the [Security docs](/docs/user-guide/security)


This is working as intended — Hermes never silently runs destructive commands. The approval prompt shows you exactly what will execute.


#### `sudo` not working via messaging gateway<a href="#sudo-not-working-via-messaging-gateway" class="hash-link" aria-label="Direct link to sudo-not-working-via-messaging-gateway" translate="no" title="Direct link to sudo-not-working-via-messaging-gateway">​</a>

**Cause:** The messaging gateway runs without an interactive terminal, so `sudo` cannot prompt for a password.

**Solution:**

- Avoid `sudo` in messaging — ask the agent to find alternatives
- If you must use `sudo`, configure passwordless sudo for specific commands in `/etc/sudoers`
- Or switch to the terminal interface for administrative tasks: `hermes chat`

#### Docker backend not connecting<a href="#docker-backend-not-connecting" class="hash-link" aria-label="Direct link to Docker backend not connecting" translate="no" title="Direct link to Docker backend not connecting">​</a>

**Cause:** Docker daemon isn't running or the user lacks permissions.

**Solution:**


``` prism-code
# Check Docker is running
docker info

# Add your user to the docker group
sudo usermod -aG docker $USER
newgrp docker

# Verify
docker run hello-world
```


------------------------------------------------------------------------

### Messaging Issues<a href="#messaging-issues" class="hash-link" aria-label="Direct link to Messaging Issues" translate="no" title="Direct link to Messaging Issues">​</a>

#### Bot not responding to messages<a href="#bot-not-responding-to-messages" class="hash-link" aria-label="Direct link to Bot not responding to messages" translate="no" title="Direct link to Bot not responding to messages">​</a>

**Cause:** The bot isn't running, isn't authorized, or your user isn't in the allowlist.

**Solution:**


``` prism-code
# Check if the gateway is running
hermes gateway status

# Start the gateway
hermes gateway start

# Check logs for errors
cat ~/.hermes/logs/gateway.log | tail -50
```


#### Messages not delivering<a href="#messages-not-delivering" class="hash-link" aria-label="Direct link to Messages not delivering" translate="no" title="Direct link to Messages not delivering">​</a>

**Cause:** Network issues, bot token expired, or platform webhook misconfiguration.

**Solution:**

- Verify your bot token is valid with `hermes gateway setup`
- Check gateway logs: `cat ~/.hermes/logs/gateway.log | tail -50`
- For webhook-based platforms (Slack, WhatsApp), ensure your server is publicly accessible

#### Allowlist confusion — who can talk to the bot?<a href="#allowlist-confusion--who-can-talk-to-the-bot" class="hash-link" aria-label="Direct link to Allowlist confusion — who can talk to the bot?" translate="no" title="Direct link to Allowlist confusion — who can talk to the bot?">​</a>

**Cause:** Authorization mode determines who gets access.

**Solution:**

| Mode           | How it works                                         |
|----------------|------------------------------------------------------|
| **Allowlist**  | Only user IDs listed in config can interact          |
| **DM pairing** | First user to message in DM claims exclusive access  |
| **Open**       | Anyone can interact (not recommended for production) |

Configure in `~/.hermes/config.yaml` under your gateway's settings. See the [Messaging docs](/docs/user-guide/messaging/).

#### Gateway won't start<a href="#gateway-wont-start" class="hash-link" aria-label="Direct link to Gateway won&#39;t start" translate="no" title="Direct link to Gateway won&#39;t start">​</a>

**Cause:** Missing dependencies, port conflicts, or misconfigured tokens.

**Solution:**


``` prism-code
# Install messaging dependencies
pip install "hermes-agent[telegram]"   # or [discord], [slack], [whatsapp]

# Check for port conflicts
lsof -i :8080

# Verify configuration
hermes config show
```


#### macOS: Node.js / ffmpeg / other tools not found by gateway<a href="#macos-nodejs--ffmpeg--other-tools-not-found-by-gateway" class="hash-link" aria-label="Direct link to macOS: Node.js / ffmpeg / other tools not found by gateway" translate="no" title="Direct link to macOS: Node.js / ffmpeg / other tools not found by gateway">​</a>

**Cause:** launchd services inherit a minimal PATH (`/usr/bin:/bin:/usr/sbin:/sbin`) that doesn't include Homebrew, nvm, cargo, or other user-installed tool directories. This commonly breaks the WhatsApp bridge (`node not found`) or voice transcription (`ffmpeg not found`).

**Solution:** The gateway captures your shell PATH when you run `hermes gateway install`. If you installed tools after setting up the gateway, re-run the install to capture the updated PATH:


``` prism-code
hermes gateway install    # Re-snapshots your current PATH
hermes gateway start      # Detects the updated plist and reloads
```


You can verify the plist has the correct PATH:


``` prism-code
/usr/libexec/PlistBuddy -c "Print :EnvironmentVariables:PATH" \
  ~/Library/LaunchAgents/ai.hermes.gateway.plist
```


------------------------------------------------------------------------

### Performance Issues<a href="#performance-issues" class="hash-link" aria-label="Direct link to Performance Issues" translate="no" title="Direct link to Performance Issues">​</a>

#### Slow responses<a href="#slow-responses" class="hash-link" aria-label="Direct link to Slow responses" translate="no" title="Direct link to Slow responses">​</a>

**Cause:** Large model, distant API server, or heavy system prompt with many tools.

**Solution:**

- Try a faster/smaller model: `hermes chat --model openrouter/meta-llama/llama-3.1-8b-instruct`
- Reduce active toolsets: `hermes chat -t "terminal"`
- Check your network latency to the provider
- For local models, ensure you have enough GPU VRAM

#### High token usage<a href="#high-token-usage" class="hash-link" aria-label="Direct link to High token usage" translate="no" title="Direct link to High token usage">​</a>

**Cause:** Long conversations, verbose system prompts, or many tool calls accumulating context.

**Solution:**


``` prism-code
# Compress the conversation to reduce tokens
/compress

# Check session token usage
/usage
```


Use `/compress` regularly during long sessions. It summarizes the conversation history and reduces token usage significantly while preserving context.


#### Session getting too long<a href="#session-getting-too-long" class="hash-link" aria-label="Direct link to Session getting too long" translate="no" title="Direct link to Session getting too long">​</a>

**Cause:** Extended conversations accumulate messages and tool outputs, approaching context limits.

**Solution:**


``` prism-code
# Compress current session (preserves key context)
/compress

# Start a new session with a reference to the old one
hermes chat

# Resume a specific session later if needed
hermes chat --continue
```


------------------------------------------------------------------------

### MCP Issues<a href="#mcp-issues" class="hash-link" aria-label="Direct link to MCP Issues" translate="no" title="Direct link to MCP Issues">​</a>

#### MCP server not connecting<a href="#mcp-server-not-connecting" class="hash-link" aria-label="Direct link to MCP server not connecting" translate="no" title="Direct link to MCP server not connecting">​</a>

**Cause:** Server binary not found, wrong command path, or missing runtime.

**Solution:**


``` prism-code
# Ensure MCP dependencies are installed (already included in standard install)
cd ~/.hermes/hermes-agent && uv pip install -e ".[mcp]"

# For npm-based servers, ensure Node.js is available
node --version
npx --version

# Test the server manually
npx -y @modelcontextprotocol/server-filesystem /tmp
```


Verify your `~/.hermes/config.yaml` MCP configuration:


``` prism-code
mcp_servers:
  filesystem:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-filesystem", "/home/user/docs"]
```


#### Tools not showing up from MCP server<a href="#tools-not-showing-up-from-mcp-server" class="hash-link" aria-label="Direct link to Tools not showing up from MCP server" translate="no" title="Direct link to Tools not showing up from MCP server">​</a>

**Cause:** Server started but tool discovery failed, tools were filtered out by config, or the server does not support the MCP capability you expected.

**Solution:**

- Check gateway/agent logs for MCP connection errors
- Ensure the server responds to the `tools/list` RPC method
- Review any `tools.include`, `tools.exclude`, `tools.resources`, `tools.prompts`, or `enabled` settings under that server
- Remember that resource/prompt utility tools are only registered when the session actually supports those capabilities
- Use `/reload-mcp` after changing config


``` prism-code
# Verify MCP servers are configured
hermes config show | grep -A 12 mcp_servers

# Restart Hermes or reload MCP after config changes
hermes chat
```


See also:

- [MCP (Model Context Protocol)](/docs/user-guide/features/mcp)
- [Use MCP with Hermes](/docs/guides/use-mcp-with-hermes)
- [MCP Config Reference](/docs/reference/mcp-config-reference)

#### MCP timeout errors<a href="#mcp-timeout-errors" class="hash-link" aria-label="Direct link to MCP timeout errors" translate="no" title="Direct link to MCP timeout errors">​</a>

**Cause:** The MCP server is taking too long to respond, or it crashed during execution.

**Solution:**

- Increase the timeout in your MCP server config if supported
- Check if the MCP server process is still running
- For remote HTTP MCP servers, check network connectivity


If an MCP server crashes mid-request, Hermes will report a timeout. Check the server's own logs (not just Hermes logs) to diagnose the root cause.


------------------------------------------------------------------------

## Profiles<a href="#profiles" class="hash-link" aria-label="Direct link to Profiles" translate="no" title="Direct link to Profiles">​</a>

### How do profiles differ from just setting HERMES_HOME?<a href="#how-do-profiles-differ-from-just-setting-hermes_home" class="hash-link" aria-label="Direct link to How do profiles differ from just setting HERMES_HOME?" translate="no" title="Direct link to How do profiles differ from just setting HERMES_HOME?">​</a>

Profiles are a managed layer on top of `HERMES_HOME`. You *could* manually set `HERMES_HOME=/some/path` before every command, but profiles handle all the plumbing for you: creating the directory structure, generating shell aliases (`hermes-work`), tracking the active profile in `~/.hermes/active_profile`, and syncing skill updates across all profiles automatically. They also integrate with tab completion so you don't have to remember paths.

### Can two profiles share the same bot token?<a href="#can-two-profiles-share-the-same-bot-token" class="hash-link" aria-label="Direct link to Can two profiles share the same bot token?" translate="no" title="Direct link to Can two profiles share the same bot token?">​</a>

No. Each messaging platform (Telegram, Discord, etc.) requires exclusive access to a bot token. If two profiles try to use the same token simultaneously, the second gateway will fail to connect. Create a separate bot per profile — for Telegram, talk to <a href="https://t.me/BotFather" target="_blank" rel="noopener noreferrer">@BotFather</a> to make additional bots.

### Do profiles share memory or sessions?<a href="#do-profiles-share-memory-or-sessions" class="hash-link" aria-label="Direct link to Do profiles share memory or sessions?" translate="no" title="Direct link to Do profiles share memory or sessions?">​</a>

No. Each profile has its own memory store, session database, and skills directory. They are completely isolated. If you want to start a new profile with existing memories and sessions, use `hermes profile create newname --clone-all` to copy everything from the current profile.

### What happens when I run `hermes update`?<a href="#what-happens-when-i-run-hermes-update" class="hash-link" aria-label="Direct link to what-happens-when-i-run-hermes-update" translate="no" title="Direct link to what-happens-when-i-run-hermes-update">​</a>

`hermes update` pulls the latest code and reinstalls dependencies **once** (not per-profile). It then syncs updated skills to all profiles automatically. You only need to run `hermes update` once — it covers every profile on the machine.

### Can I move a profile to a different machine?<a href="#can-i-move-a-profile-to-a-different-machine" class="hash-link" aria-label="Direct link to Can I move a profile to a different machine?" translate="no" title="Direct link to Can I move a profile to a different machine?">​</a>

Yes. Export the profile to a portable archive and import it on the other machine:


``` prism-code
# On the source machine
hermes profile export work ./work-backup.tar.gz

# Copy the file to the target machine, then:
hermes profile import ./work-backup.tar.gz work
```


The imported profile will have all config, memories, sessions, and skills from the export. You may need to update paths or re-authenticate with providers if the new machine has a different setup.

### How many profiles can I run?<a href="#how-many-profiles-can-i-run" class="hash-link" aria-label="Direct link to How many profiles can I run?" translate="no" title="Direct link to How many profiles can I run?">​</a>

There is no hard limit. Each profile is just a directory under `~/.hermes/profiles/`. The practical limit depends on your disk space and how many concurrent gateways your system can handle (each gateway is a lightweight Python process). Running dozens of profiles is fine; each idle profile uses no resources.

------------------------------------------------------------------------

## Workflows & Patterns<a href="#workflows--patterns" class="hash-link" aria-label="Direct link to Workflows &amp; Patterns" translate="no" title="Direct link to Workflows &amp; Patterns">​</a>

### Using different models for different tasks (multi-model workflows)<a href="#using-different-models-for-different-tasks-multi-model-workflows" class="hash-link" aria-label="Direct link to Using different models for different tasks (multi-model workflows)" translate="no" title="Direct link to Using different models for different tasks (multi-model workflows)">​</a>

**Scenario:** You use GPT-5.4 as your daily driver, but Gemini or Grok writes better social media content. Manually switching models every time is tedious.

**Solution: Delegation config.** Hermes can route subagents to a different model automatically. Set this in `~/.hermes/config.yaml`:


``` prism-code
delegation:
  model: "google/gemini-3-flash-preview"   # subagents use this model
  provider: "openrouter"                    # provider for subagents
```


Now when you tell Hermes "write me a Twitter thread about X" and it spawns a `delegate_task` subagent, that subagent runs on Gemini instead of your main model. Your primary conversation stays on GPT-5.4.

You can also be explicit in your prompt: *"Delegate a task to write social media posts about our product launch. Use your subagent for the actual writing."* The agent will use `delegate_task`, which automatically picks up the delegation config.

For one-off model switches without delegation, use `/model` in the CLI:


``` prism-code
/model google/gemini-3-flash-preview    # switch for this session
# ... write your content ...
/model openai/gpt-5.4                   # switch back
```


See [Subagent Delegation](/docs/user-guide/features/delegation) for more on how delegation works.

### Running multiple agents on one WhatsApp number (per-chat binding)<a href="#running-multiple-agents-on-one-whatsapp-number-per-chat-binding" class="hash-link" aria-label="Direct link to Running multiple agents on one WhatsApp number (per-chat binding)" translate="no" title="Direct link to Running multiple agents on one WhatsApp number (per-chat binding)">​</a>

**Scenario:** In OpenClaw, you had multiple independent agents bound to specific WhatsApp chats — one for a family shopping list group, another for your private chat. Can Hermes do this?

**Current limitation:** Hermes profiles each require their own WhatsApp number/session. You cannot bind multiple profiles to different chats on the same WhatsApp number — the WhatsApp bridge (Baileys) uses one authenticated session per number.

**Workarounds:**

1.  **Use a single profile with personality switching.** Create different `AGENTS.md` context files or use the `/personality` command to change behavior per chat. The agent sees which chat it's in and can adapt.

2.  **Use cron jobs for specialized tasks.** For a shopping list tracker, set up a cron job that monitors a specific chat and manages the list — no separate agent needed.

3.  **Use separate numbers.** If you need truly independent agents, pair each profile with its own WhatsApp number. Virtual numbers from services like Google Voice work for this.

4.  **Use Telegram or Discord instead.** These platforms support per-chat binding more naturally — each Telegram group or Discord channel gets its own session, and you can run multiple bot tokens (one per profile) on the same account.

See [Profiles](/docs/user-guide/profiles) and [WhatsApp setup](/docs/user-guide/messaging/whatsapp) for more details.

### Controlling what shows up in Telegram (hiding logs and reasoning)<a href="#controlling-what-shows-up-in-telegram-hiding-logs-and-reasoning" class="hash-link" aria-label="Direct link to Controlling what shows up in Telegram (hiding logs and reasoning)" translate="no" title="Direct link to Controlling what shows up in Telegram (hiding logs and reasoning)">​</a>

**Scenario:** You see gateway exec logs, Hermes reasoning, and tool call details in Telegram instead of just the final output.

**Solution:** The `display.tool_progress` setting in `config.yaml` controls how much tool activity is shown:


``` prism-code
display:
  tool_progress: "off"   # options: off, new, all, verbose
```


- **`off`** — Only the final response. No tool calls, no reasoning, no logs.
- **`new`** — Shows new tool calls as they happen (brief one-liners).
- **`all`** — Shows all tool activity including results.
- **`verbose`** — Full detail including tool arguments and outputs.

For messaging platforms, `off` or `new` is usually what you want. After editing `config.yaml`, restart the gateway for changes to take effect.

You can also toggle this per-session with the `/verbose` command (if enabled):


``` prism-code
display:
  tool_progress_command: true   # enables /verbose in the gateway
```


### Managing skills on Telegram (slash command limit)<a href="#managing-skills-on-telegram-slash-command-limit" class="hash-link" aria-label="Direct link to Managing skills on Telegram (slash command limit)" translate="no" title="Direct link to Managing skills on Telegram (slash command limit)">​</a>

**Scenario:** Telegram has a 100 slash command limit, and your skills are pushing past it. You want to disable skills you don't need on Telegram, but `hermes skills config` settings don't seem to take effect.

**Solution:** Use `hermes skills config` to disable skills per-platform. This writes to `config.yaml`:


``` prism-code
skills:
  disabled: []                    # globally disabled skills
  platform_disabled:
    telegram: [skill-a, skill-b]  # disabled only on telegram
```


After changing this, **restart the gateway** (`hermes gateway restart` or kill and relaunch). The Telegram bot command menu rebuilds on startup.


Skills with very long descriptions are truncated to 40 characters in the Telegram menu to stay within payload size limits. If skills aren't appearing, it may be a total payload size issue rather than the 100 command count limit — disabling unused skills helps with both.


### Shared thread sessions (multiple users, one conversation)<a href="#shared-thread-sessions-multiple-users-one-conversation" class="hash-link" aria-label="Direct link to Shared thread sessions (multiple users, one conversation)" translate="no" title="Direct link to Shared thread sessions (multiple users, one conversation)">​</a>

**Scenario:** You have a Telegram or Discord thread where multiple people mention the bot. You want all mentions in that thread to be part of one shared conversation, not separate per-user sessions.

**Current behavior:** Hermes creates sessions keyed by user ID on most platforms, so each person gets their own conversation context. This is by design for privacy and context isolation.

**Workarounds:**

1.  **Use Slack.** Slack sessions are keyed by thread, not by user. Multiple users in the same thread share one conversation — exactly the behavior you're describing. This is the most natural fit.

2.  **Use a group chat with a single user.** If one person is the designated "operator" who relays questions, the session stays unified. Others can read along.

3.  **Use a Discord channel.** Discord sessions are keyed by channel, so all users in the same channel share context. Use a dedicated channel for the shared conversation.

### Exporting Hermes to another machine<a href="#exporting-hermes-to-another-machine" class="hash-link" aria-label="Direct link to Exporting Hermes to another machine" translate="no" title="Direct link to Exporting Hermes to another machine">​</a>

**Scenario:** You've built up skills, cron jobs, and memories on one machine and want to move everything to a new dedicated Linux box.

**Solution:**

1.  Install Hermes Agent on the new machine:

    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
    ```

    </div>

    </div>

2.  Copy your entire `~/.hermes/` directory **except** the `hermes-agent` subdirectory (that's the code repo — the new install has its own):

    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    # On the source machine
    rsync -av --exclude='hermes-agent' ~/.hermes/ newmachine:~/.hermes/
    ```

    </div>

    </div>

    Or use profile export/import:

    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    # On source machine
    hermes profile export default ./hermes-backup.tar.gz

    # On target machine
    hermes profile import ./hermes-backup.tar.gz default
    ```

    </div>

    </div>

3.  On the new machine, run `hermes setup` to verify API keys and provider config are working. Re-authenticate any messaging platforms (especially WhatsApp, which uses QR pairing).

The `~/.hermes/` directory contains everything: `config.yaml`, `.env`, `SOUL.md`, `memories/`, `skills/`, `state.db` (sessions), `cron/`, and any custom plugins. The code itself lives in `~/.hermes/hermes-agent/` and is installed fresh.

### Permission denied when reloading shell after install<a href="#permission-denied-when-reloading-shell-after-install" class="hash-link" aria-label="Direct link to Permission denied when reloading shell after install" translate="no" title="Direct link to Permission denied when reloading shell after install">​</a>

**Scenario:** After running the Hermes installer, `source ~/.zshrc` gives a permission denied error.

**Cause:** This usually happens when `~/.zshrc` (or `~/.bashrc`) has incorrect file permissions, or when the installer couldn't write to it cleanly. It's not a Hermes-specific issue — it's a shell config permissions problem.

**Solution:**


``` prism-code
# Check permissions
ls -la ~/.zshrc

# Fix if needed (should be -rw-r--r-- or 644)
chmod 644 ~/.zshrc

# Then reload
source ~/.zshrc

# Or just open a new terminal window — it picks up PATH changes automatically
```


If the installer added the PATH line but permissions are wrong, you can add it manually:


``` prism-code
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
```


### Error 400 on first agent run<a href="#error-400-on-first-agent-run" class="hash-link" aria-label="Direct link to Error 400 on first agent run" translate="no" title="Direct link to Error 400 on first agent run">​</a>

**Scenario:** Setup completes fine, but the first chat attempt fails with HTTP 400.

**Cause:** Usually a model name mismatch — the configured model doesn't exist on your provider, or the API key doesn't have access to it.

**Solution:**


``` prism-code
# Check what model and provider are configured
hermes config show | head -20

# Re-run model selection
hermes model

# Or test with a known-good model
hermes chat -q "hello" --model anthropic/claude-sonnet-4.6
```


If using OpenRouter, make sure your API key has credits. A 400 from OpenRouter often means the model requires a paid plan or the model ID has a typo.

------------------------------------------------------------------------

## Still Stuck?<a href="#still-stuck" class="hash-link" aria-label="Direct link to Still Stuck?" translate="no" title="Direct link to Still Stuck?">​</a>

If your issue isn't covered here:

1.  **Search existing issues:** <a href="https://github.com/NousResearch/hermes-agent/issues" target="_blank" rel="noopener noreferrer">GitHub Issues</a>
2.  **Ask the community:** <a href="https://discord.gg/nousresearch" target="_blank" rel="noopener noreferrer">Nous Research Discord</a>
3.  **File a bug report:** Include your OS, Python version (`python3 --version`), Hermes version (`hermes --version`), and the full error message


- <a href="#frequently-asked-questions" class="table-of-contents__link toc-highlight">Frequently Asked Questions</a>
  - <a href="#what-llm-providers-work-with-hermes" class="table-of-contents__link toc-highlight">What LLM providers work with Hermes?</a>
  - <a href="#does-it-work-on-windows" class="table-of-contents__link toc-highlight">Does it work on Windows?</a>
  - <a href="#is-my-data-sent-anywhere" class="table-of-contents__link toc-highlight">Is my data sent anywhere?</a>
  - <a href="#can-i-use-it-offline--with-local-models" class="table-of-contents__link toc-highlight">Can I use it offline / with local models?</a>
  - <a href="#how-much-does-it-cost" class="table-of-contents__link toc-highlight">How much does it cost?</a>
  - <a href="#can-multiple-people-use-one-instance" class="table-of-contents__link toc-highlight">Can multiple people use one instance?</a>
  - <a href="#whats-the-difference-between-memory-and-skills" class="table-of-contents__link toc-highlight">What's the difference between memory and skills?</a>
  - <a href="#can-i-use-it-in-my-own-python-project" class="table-of-contents__link toc-highlight">Can I use it in my own Python project?</a>
- <a href="#troubleshooting" class="table-of-contents__link toc-highlight">Troubleshooting</a>
  - <a href="#installation-issues" class="table-of-contents__link toc-highlight">Installation Issues</a>
  - <a href="#provider--model-issues" class="table-of-contents__link toc-highlight">Provider &amp; Model Issues</a>
  - <a href="#terminal-issues" class="table-of-contents__link toc-highlight">Terminal Issues</a>
  - <a href="#messaging-issues" class="table-of-contents__link toc-highlight">Messaging Issues</a>
  - <a href="#performance-issues" class="table-of-contents__link toc-highlight">Performance Issues</a>
  - <a href="#mcp-issues" class="table-of-contents__link toc-highlight">MCP Issues</a>
- <a href="#profiles" class="table-of-contents__link toc-highlight">Profiles</a>
  - <a href="#how-do-profiles-differ-from-just-setting-hermes_home" class="table-of-contents__link toc-highlight">How do profiles differ from just setting HERMES_HOME?</a>
  - <a href="#can-two-profiles-share-the-same-bot-token" class="table-of-contents__link toc-highlight">Can two profiles share the same bot token?</a>
  - <a href="#do-profiles-share-memory-or-sessions" class="table-of-contents__link toc-highlight">Do profiles share memory or sessions?</a>
  - <a href="#what-happens-when-i-run-hermes-update" class="table-of-contents__link toc-highlight">What happens when I run <code>hermes update</code>?</a>
  - <a href="#can-i-move-a-profile-to-a-different-machine" class="table-of-contents__link toc-highlight">Can I move a profile to a different machine?</a>
  - <a href="#how-many-profiles-can-i-run" class="table-of-contents__link toc-highlight">How many profiles can I run?</a>
- <a href="#workflows--patterns" class="table-of-contents__link toc-highlight">Workflows &amp; Patterns</a>
  - <a href="#using-different-models-for-different-tasks-multi-model-workflows" class="table-of-contents__link toc-highlight">Using different models for different tasks (multi-model workflows)</a>
  - <a href="#running-multiple-agents-on-one-whatsapp-number-per-chat-binding" class="table-of-contents__link toc-highlight">Running multiple agents on one WhatsApp number (per-chat binding)</a>
  - <a href="#controlling-what-shows-up-in-telegram-hiding-logs-and-reasoning" class="table-of-contents__link toc-highlight">Controlling what shows up in Telegram (hiding logs and reasoning)</a>
  - <a href="#managing-skills-on-telegram-slash-command-limit" class="table-of-contents__link toc-highlight">Managing skills on Telegram (slash command limit)</a>
  - <a href="#shared-thread-sessions-multiple-users-one-conversation" class="table-of-contents__link toc-highlight">Shared thread sessions (multiple users, one conversation)</a>
  - <a href="#exporting-hermes-to-another-machine" class="table-of-contents__link toc-highlight">Exporting Hermes to another machine</a>
  - <a href="#permission-denied-when-reloading-shell-after-install" class="table-of-contents__link toc-highlight">Permission denied when reloading shell after install</a>
  - <a href="#error-400-on-first-agent-run" class="table-of-contents__link toc-highlight">Error 400 on first agent run</a>
- <a href="#still-stuck" class="table-of-contents__link toc-highlight">Still Stuck?</a>


