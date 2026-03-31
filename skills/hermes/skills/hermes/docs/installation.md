> Source: https://hermes-agent.nousresearch.com/docs/getting-started/installation/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Installation


Get Hermes Agent up and running in under two minutes with the one-line installer, or follow the manual steps for full control.

## Quick Install<a href="#quick-install" class="hash-link" aria-label="Direct link to Quick Install" translate="no" title="Direct link to Quick Install">​</a>

### Linux / macOS / WSL2<a href="#linux--macos--wsl2" class="hash-link" aria-label="Direct link to Linux / macOS / WSL2" translate="no" title="Direct link to Linux / macOS / WSL2">​</a>


``` prism-code
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```


Native Windows is **not supported**. Please install <a href="https://learn.microsoft.com/en-us/windows/wsl/install" target="_blank" rel="noopener noreferrer">WSL2</a> and run Hermes Agent from there. The install command above works inside WSL2.


### What the Installer Does<a href="#what-the-installer-does" class="hash-link" aria-label="Direct link to What the Installer Does" translate="no" title="Direct link to What the Installer Does">​</a>

The installer handles everything automatically — all dependencies (Python, Node.js, ripgrep, ffmpeg), the repo clone, virtual environment, global `hermes` command setup, and LLM provider configuration. By the end, you're ready to chat.

### After Installation<a href="#after-installation" class="hash-link" aria-label="Direct link to After Installation" translate="no" title="Direct link to After Installation">​</a>

Reload your shell and start chatting:


``` prism-code
source ~/.bashrc   # or: source ~/.zshrc
hermes             # Start chatting!
```


To reconfigure individual settings later, use the dedicated commands:


``` prism-code
hermes model          # Choose your LLM provider and model
hermes tools          # Configure which tools are enabled
hermes gateway setup  # Set up messaging platforms
hermes config set     # Set individual config values
hermes setup          # Or run the full setup wizard to configure everything at once
```


------------------------------------------------------------------------

## Prerequisites<a href="#prerequisites" class="hash-link" aria-label="Direct link to Prerequisites" translate="no" title="Direct link to Prerequisites">​</a>

The only prerequisite is **Git**. The installer automatically handles everything else:

- **uv** (fast Python package manager)
- **Python 3.11** (via uv, no sudo needed)
- **Node.js v22** (for browser automation and WhatsApp bridge)
- **ripgrep** (fast file search)
- **ffmpeg** (audio format conversion for TTS)


You do **not** need to install Python, Node.js, ripgrep, or ffmpeg manually. The installer detects what's missing and installs it for you. Just make sure `git` is available (`git --version`).


If you use Nix (on NixOS, macOS, or Linux), there's a dedicated setup path with a Nix flake, declarative NixOS module, and optional container mode. See the **[Nix & NixOS Setup](/docs/getting-started/nix-setup)** guide.


------------------------------------------------------------------------

## Manual Installation<a href="#manual-installation" class="hash-link" aria-label="Direct link to Manual Installation" translate="no" title="Direct link to Manual Installation">​</a>

If you prefer full control over the installation process, follow these steps.

### Step 1: Clone the Repository<a href="#step-1-clone-the-repository" class="hash-link" aria-label="Direct link to Step 1: Clone the Repository" translate="no" title="Direct link to Step 1: Clone the Repository">​</a>

Clone with `--recurse-submodules` to pull the required submodules:


``` prism-code
git clone --recurse-submodules https://github.com/NousResearch/hermes-agent.git
cd hermes-agent
```


If you already cloned without `--recurse-submodules`:


``` prism-code
git submodule update --init --recursive
```


### Step 2: Install uv & Create Virtual Environment<a href="#step-2-install-uv--create-virtual-environment" class="hash-link" aria-label="Direct link to Step 2: Install uv &amp; Create Virtual Environment" translate="no" title="Direct link to Step 2: Install uv &amp; Create Virtual Environment">​</a>


``` prism-code
# Install uv (if not already installed)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Create venv with Python 3.11 (uv downloads it if not present — no sudo needed)
uv venv venv --python 3.11
```


You do **not** need to activate the venv to use `hermes`. The entry point has a hardcoded shebang pointing to the venv Python, so it works globally once symlinked.


### Step 3: Install Python Dependencies<a href="#step-3-install-python-dependencies" class="hash-link" aria-label="Direct link to Step 3: Install Python Dependencies" translate="no" title="Direct link to Step 3: Install Python Dependencies">​</a>


``` prism-code
# Tell uv which venv to install into
export VIRTUAL_ENV="$(pwd)/venv"

# Install with all extras
uv pip install -e ".[all]"
```


If you only want the core agent (no Telegram/Discord/cron support):


``` prism-code
uv pip install -e "."
```


**Optional extras breakdown**


| Extra           | What it adds                                | Install command                        |
|-----------------|---------------------------------------------|----------------------------------------|
| `all`           | Everything below                            | `uv pip install -e ".[all]"`           |
| `messaging`     | Telegram & Discord gateway                  | `uv pip install -e ".[messaging]"`     |
| `cron`          | Cron expression parsing for scheduled tasks | `uv pip install -e ".[cron]"`          |
| `cli`           | Terminal menu UI for setup wizard           | `uv pip install -e ".[cli]"`           |
| `modal`         | Modal cloud execution backend               | `uv pip install -e ".[modal]"`         |
| `tts-premium`   | ElevenLabs premium voices                   | `uv pip install -e ".[tts-premium]"`   |
| `voice`         | CLI microphone input + audio playback       | `uv pip install -e ".[voice]"`         |
| `pty`           | PTY terminal support                        | `uv pip install -e ".[pty]"`           |
| `honcho`        | AI-native memory (Honcho integration)       | `uv pip install -e ".[honcho]"`        |
| `mcp`           | Model Context Protocol support              | `uv pip install -e ".[mcp]"`           |
| `homeassistant` | Home Assistant integration                  | `uv pip install -e ".[homeassistant]"` |
| `acp`           | ACP editor integration support              | `uv pip install -e ".[acp]"`           |
| `slack`         | Slack messaging                             | `uv pip install -e ".[slack]"`         |
| `dev`           | pytest & test utilities                     | `uv pip install -e ".[dev]"`           |

You can combine extras: `uv pip install -e ".[messaging,cron]"`


### Step 4: Install Optional Submodules (if needed)<a href="#step-4-install-optional-submodules-if-needed" class="hash-link" aria-label="Direct link to Step 4: Install Optional Submodules (if needed)" translate="no" title="Direct link to Step 4: Install Optional Submodules (if needed)">​</a>


``` prism-code
# RL training backend (optional)
uv pip install -e "./tinker-atropos"
```


Both are optional — if you skip them, the corresponding toolsets simply won't be available.

### Step 5: Install Node.js Dependencies (Optional)<a href="#step-5-install-nodejs-dependencies-optional" class="hash-link" aria-label="Direct link to Step 5: Install Node.js Dependencies (Optional)" translate="no" title="Direct link to Step 5: Install Node.js Dependencies (Optional)">​</a>

Only needed for **browser automation** (Browserbase-powered) and **WhatsApp bridge**:


``` prism-code
npm install
```


### Step 6: Create the Configuration Directory<a href="#step-6-create-the-configuration-directory" class="hash-link" aria-label="Direct link to Step 6: Create the Configuration Directory" translate="no" title="Direct link to Step 6: Create the Configuration Directory">​</a>


``` prism-code
# Create the directory structure
mkdir -p ~/.hermes/{cron,sessions,logs,memories,skills,pairing,hooks,image_cache,audio_cache,whatsapp/session}

# Copy the example config file
cp cli-config.yaml.example ~/.hermes/config.yaml

# Create an empty .env file for API keys
touch ~/.hermes/.env
```


### Step 7: Add Your API Keys<a href="#step-7-add-your-api-keys" class="hash-link" aria-label="Direct link to Step 7: Add Your API Keys" translate="no" title="Direct link to Step 7: Add Your API Keys">​</a>

Open `~/.hermes/.env` and add at minimum an LLM provider key:


``` prism-code
# Required — at least one LLM provider:
OPENROUTER_API_KEY=sk-or-v1-your-key-here

# Optional — enable additional tools:
FIRECRAWL_API_KEY=fc-your-key          # Web search & scraping (or self-host, see docs)
FAL_KEY=your-fal-key                   # Image generation (FLUX)
```


Or set them via the CLI:


``` prism-code
hermes config set OPENROUTER_API_KEY sk-or-v1-your-key-here
```


### Step 8: Add `hermes` to Your PATH<a href="#step-8-add-hermes-to-your-path" class="hash-link" aria-label="Direct link to step-8-add-hermes-to-your-path" translate="no" title="Direct link to step-8-add-hermes-to-your-path">​</a>


``` prism-code
mkdir -p ~/.local/bin
ln -sf "$(pwd)/venv/bin/hermes" ~/.local/bin/hermes
```


If `~/.local/bin` isn't on your PATH, add it to your shell config:


``` prism-code
# Bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc

# Zsh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc

# Fish
fish_add_path $HOME/.local/bin
```


### Step 9: Configure Your Provider<a href="#step-9-configure-your-provider" class="hash-link" aria-label="Direct link to Step 9: Configure Your Provider" translate="no" title="Direct link to Step 9: Configure Your Provider">​</a>


``` prism-code
hermes model       # Select your LLM provider and model
```


### Step 10: Verify the Installation<a href="#step-10-verify-the-installation" class="hash-link" aria-label="Direct link to Step 10: Verify the Installation" translate="no" title="Direct link to Step 10: Verify the Installation">​</a>


``` prism-code
hermes version    # Check that the command is available
hermes doctor     # Run diagnostics to verify everything is working
hermes status     # Check your configuration
hermes chat -q "Hello! What tools do you have available?"
```


------------------------------------------------------------------------

## Quick-Reference: Manual Install (Condensed)<a href="#quick-reference-manual-install-condensed" class="hash-link" aria-label="Direct link to Quick-Reference: Manual Install (Condensed)" translate="no" title="Direct link to Quick-Reference: Manual Install (Condensed)">​</a>

For those who just want the commands:


``` prism-code
# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Clone & enter
git clone --recurse-submodules https://github.com/NousResearch/hermes-agent.git
cd hermes-agent

# Create venv with Python 3.11
uv venv venv --python 3.11
export VIRTUAL_ENV="$(pwd)/venv"

# Install everything
uv pip install -e ".[all]"
uv pip install -e "./tinker-atropos"
npm install  # optional, for browser tools and WhatsApp

# Configure
mkdir -p ~/.hermes/{cron,sessions,logs,memories,skills,pairing,hooks,image_cache,audio_cache,whatsapp/session}
cp cli-config.yaml.example ~/.hermes/config.yaml
touch ~/.hermes/.env
echo 'OPENROUTER_API_KEY=sk-or-v1-your-key' >> ~/.hermes/.env

# Make hermes available globally
mkdir -p ~/.local/bin
ln -sf "$(pwd)/venv/bin/hermes" ~/.local/bin/hermes

# Verify
hermes doctor
hermes
```


------------------------------------------------------------------------

## Troubleshooting<a href="#troubleshooting" class="hash-link" aria-label="Direct link to Troubleshooting" translate="no" title="Direct link to Troubleshooting">​</a>

| Problem                     | Solution                                                                                          |
|-----------------------------|---------------------------------------------------------------------------------------------------|
| `hermes: command not found` | Reload your shell (`source ~/.bashrc`) or check PATH                                              |
| `API key not set`           | Run `hermes model` to configure your provider, or `hermes config set OPENROUTER_API_KEY your_key` |
| Missing config after update | Run `hermes config check` then `hermes config migrate`                                            |

For more diagnostics, run `hermes doctor` — it will tell you exactly what's missing and how to fix it.


- <a href="#quick-install" class="table-of-contents__link toc-highlight">Quick Install</a>
  - <a href="#linux--macos--wsl2" class="table-of-contents__link toc-highlight">Linux / macOS / WSL2</a>
  - <a href="#what-the-installer-does" class="table-of-contents__link toc-highlight">What the Installer Does</a>
  - <a href="#after-installation" class="table-of-contents__link toc-highlight">After Installation</a>
- <a href="#prerequisites" class="table-of-contents__link toc-highlight">Prerequisites</a>
- <a href="#manual-installation" class="table-of-contents__link toc-highlight">Manual Installation</a>
  - <a href="#step-1-clone-the-repository" class="table-of-contents__link toc-highlight">Step 1: Clone the Repository</a>
  - <a href="#step-2-install-uv--create-virtual-environment" class="table-of-contents__link toc-highlight">Step 2: Install uv &amp; Create Virtual Environment</a>
  - <a href="#step-3-install-python-dependencies" class="table-of-contents__link toc-highlight">Step 3: Install Python Dependencies</a>
  - <a href="#step-4-install-optional-submodules-if-needed" class="table-of-contents__link toc-highlight">Step 4: Install Optional Submodules (if needed)</a>
  - <a href="#step-5-install-nodejs-dependencies-optional" class="table-of-contents__link toc-highlight">Step 5: Install Node.js Dependencies (Optional)</a>
  - <a href="#step-6-create-the-configuration-directory" class="table-of-contents__link toc-highlight">Step 6: Create the Configuration Directory</a>
  - <a href="#step-7-add-your-api-keys" class="table-of-contents__link toc-highlight">Step 7: Add Your API Keys</a>
  - <a href="#step-8-add-hermes-to-your-path" class="table-of-contents__link toc-highlight">Step 8: Add <code>hermes</code> to Your PATH</a>
  - <a href="#step-9-configure-your-provider" class="table-of-contents__link toc-highlight">Step 9: Configure Your Provider</a>
  - <a href="#step-10-verify-the-installation" class="table-of-contents__link toc-highlight">Step 10: Verify the Installation</a>
- <a href="#quick-reference-manual-install-condensed" class="table-of-contents__link toc-highlight">Quick-Reference: Manual Install (Condensed)</a>
- <a href="#troubleshooting" class="table-of-contents__link toc-highlight">Troubleshooting</a>


