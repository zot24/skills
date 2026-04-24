> Source: https://hermes-agent.nousresearch.com/docs/getting-started/installation/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Installation


Get Hermes Agent up and running in under two minutes with the one-line installer.

## Quick Install<a href="#quick-install" class="hash-link" aria-label="Direct link to Quick Install" translate="no" title="Direct link to Quick Install">​</a>

### Linux / macOS / WSL2<a href="#linux--macos--wsl2" class="hash-link" aria-label="Direct link to Linux / macOS / WSL2" translate="no" title="Direct link to Linux / macOS / WSL2">​</a>


``` prism-code
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```


### Android / Termux<a href="#android--termux" class="hash-link" aria-label="Direct link to Android / Termux" translate="no" title="Direct link to Android / Termux">​</a>

Hermes now ships a Termux-aware installer path too:


``` prism-code
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```


The installer detects Termux automatically and switches to a tested Android flow:

- uses Termux `pkg` for system dependencies (`git`, `python`, `nodejs`, `ripgrep`, `ffmpeg`, build tools)
- creates the virtualenv with `python -m venv`
- exports `ANDROID_API_LEVEL` automatically for Android wheel builds
- installs a curated `.[termux]` extra with `pip`
- skips the untested browser / WhatsApp bootstrap by default

If you want the fully explicit path, follow the dedicated [Termux guide](/docs/getting-started/termux).


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

## Manual / Developer Installation<a href="#manual--developer-installation" class="hash-link" aria-label="Direct link to Manual / Developer Installation" translate="no" title="Direct link to Manual / Developer Installation">​</a>

If you want to clone the repo and install from source — for contributing, running from a specific branch, or having full control over the virtual environment — see the [Development Setup](/docs/developer-guide/contributing#development-setup) section in the Contributing guide.

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
  - <a href="#android--termux" class="table-of-contents__link toc-highlight">Android / Termux</a>
  - <a href="#what-the-installer-does" class="table-of-contents__link toc-highlight">What the Installer Does</a>
  - <a href="#after-installation" class="table-of-contents__link toc-highlight">After Installation</a>
- <a href="#prerequisites" class="table-of-contents__link toc-highlight">Prerequisites</a>
- <a href="#manual--developer-installation" class="table-of-contents__link toc-highlight">Manual / Developer Installation</a>
- <a href="#troubleshooting" class="table-of-contents__link toc-highlight">Troubleshooting</a>


