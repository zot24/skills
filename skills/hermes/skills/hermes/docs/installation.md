> Source: https://hermes-agent.nousresearch.com/docs/getting-started/installation/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Installation


Get Hermes Agent up and running in under two minutes!

## Quick Install<a href="#quick-install" class="hash-link" aria-label="Direct link to Quick Install" translate="no" title="Direct link to Quick Install">​</a>

### With the Hermes Desktop installer on macOS or Windows (recommended)<a href="#with-the-hermes-desktop-installer-on-macos-or-windows-recommended" class="hash-link" aria-label="Direct link to With the Hermes Desktop installer on macOS or Windows (recommended)" translate="no" title="Direct link to With the Hermes Desktop installer on macOS or Windows (recommended)">​</a>

To easily install the command-line and desktop applications, <a href="https://hermes-agent.nousresearch.com/desktop" target="_blank" rel="noopener noreferrer">download the Hermes Desktop installer</a> from our website and run it.

### Without Hermes Desktop:<a href="#without-hermes-desktop" class="hash-link" aria-label="Direct link to Without Hermes Desktop:" translate="no" title="Direct link to Without Hermes Desktop:">​</a>

For a command-line only install without Hermes Desktop, run:

#### Linux / macOS / WSL2 / Android (Termux)<a href="#linux--macos--wsl2--android-termux" class="hash-link" aria-label="Direct link to Linux / macOS / WSL2 / Android (Termux)" translate="no" title="Direct link to Linux / macOS / WSL2 / Android (Termux)">​</a>


``` prism-code
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
```


#### Windows (native)<a href="#windows-native" class="hash-link" aria-label="Direct link to Windows (native)" translate="no" title="Direct link to Windows (native)">​</a>

Run in powershell:


``` prism-code
iex (irm https://hermes-agent.nousresearch.com/install.ps1) 
```


If you want to install & run Hermes Desktop after a command-line only install, simply run


``` prism-code
hermes desktop
```


### What the Installer Does<a href="#what-the-installer-does" class="hash-link" aria-label="Direct link to What the Installer Does" translate="no" title="Direct link to What the Installer Does">​</a>

The installer handles everything automatically — all dependencies (Python, Node.js, ripgrep, ffmpeg), the repo clone, virtual environment, global `hermes` command setup, and LLM provider configuration. By the end, you're ready to chat.

#### Install Layout<a href="#install-layout" class="hash-link" aria-label="Direct link to Install Layout" translate="no" title="Direct link to Install Layout">​</a>

Where the installer puts things depends on whether you're installing as a normal user or as root:

| Installer                             | Code lives at                  | `hermes` binary                         | Data directory                       |
|---------------------------------------|--------------------------------|-----------------------------------------|--------------------------------------|
| pip install                           | Python site-packages           | `~/.local/bin/hermes` (console_scripts) | `~/.hermes/`                         |
| Per-user (git installer)              | `~/.hermes/hermes-agent/`      | `~/.local/bin/hermes` (symlink)         | `~/.hermes/`                         |
| Root-mode (`sudo curl … | sudo bash`) | `/usr/local/lib/hermes-agent/` | `/usr/local/bin/hermes`                 | `/root/.hermes/` (or `$HERMES_HOME`) |

The root-mode **FHS layout** (`/usr/local/lib/…`, `/usr/local/bin/hermes`) matches where other system-wide developer tools land on Linux. It's useful for shared-machine deployments where one system install should serve every user. Per-user config (auth, skills, sessions) still lives under each user's `~/.hermes/` or explicit `HERMES_HOME`.

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


One subscription covers 300+ models plus the [Tool Gateway](/docs/user-guide/features/tool-gateway) (web search, image generation, TTS, cloud browser). Skip the per-tool key juggling:


``` prism-code
hermes setup --portal
```


That logs you in, sets Nous as your provider, and turns on the Tool Gateway in one command.


------------------------------------------------------------------------

## Prerequisites<a href="#prerequisites" class="hash-link" aria-label="Direct link to Prerequisites" translate="no" title="Direct link to Prerequisites">​</a>

**Installer:** On non-Windows platforms, the only prerequisite is **Git**. The installer automatically handles everything else:

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

## Non-Sudo / System Service User Installs<a href="#non-sudo--system-service-user-installs" class="hash-link" aria-label="Direct link to Non-Sudo / System Service User Installs" translate="no" title="Direct link to Non-Sudo / System Service User Installs">​</a>

Running Hermes as a dedicated unprivileged user (e.g. a `hermes` systemd service account, or any user without `sudo` access) is supported. The only thing on the install path that genuinely needs root is Playwright's `--with-deps` step, which `apt`-installs shared libraries (`libnss3`, `libxkbcommon`, etc.) used by Chromium. The installer detects whether sudo is available and gracefully degrades when it isn't — it will install the Chromium binary into the service user's own Playwright cache and print the exact command an administrator needs to run separately.

**Recommended split (Debian/Ubuntu):**

1.  **One time, as an admin user with sudo**, install the system libraries Chromium needs:

    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    sudo npx playwright install-deps chromium
    ```

    </div>

    </div>

    (You can run this from anywhere — `npx` will fetch Playwright on the fly.)

2.  **As the unprivileged service user**, run the regular installer. It will detect the missing sudo, skip `--with-deps`, and install Chromium into the user's local Playwright cache:

    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
    ```

    </div>

    </div>

    If you want to skip the Playwright step entirely — for example because you're running headless and don't need browser automation — pass `--skip-browser`:

    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash -s -- --skip-browser
    ```

    </div>

    </div>

3.  **Make `hermes` available to the service user's shells.** The installer writes the launcher to `~/.local/bin/hermes`. System service accounts often have a minimal PATH that doesn't include `~/.local/bin`. Either add it to the user's environment, or symlink the launcher into a system location:

    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    # Option A — add to the service user's profile
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

    # Option B — symlink system-wide (run as an admin)
    sudo ln -s /home/hermes/.hermes/hermes-agent/venv/bin/hermes /usr/local/bin/hermes
    ```

    </div>

    </div>

4.  **Verify:** `hermes doctor` should now run cleanly. If you get `ModuleNotFoundError: No module named 'dotenv'`, you're invoking the repo source `hermes` file (`~/.hermes/hermes-agent/hermes`) with system Python instead of the venv launcher (`~/.hermes/hermes-agent/venv/bin/hermes`) — fix step 3.

The same pattern works on Arch (the installer uses pacman with the same sudo-detection logic), Fedora/RHEL, and openSUSE — those distros don't support `--with-deps` at all, so an administrator always installs the system libraries separately. The relevant `dnf`/`zypper` commands are printed by the installer.

------------------------------------------------------------------------

## Troubleshooting<a href="#troubleshooting" class="hash-link" aria-label="Direct link to Troubleshooting" translate="no" title="Direct link to Troubleshooting">​</a>

| Problem                     | Solution                                                                                          |
|-----------------------------|---------------------------------------------------------------------------------------------------|
| `hermes: command not found` | Reload your shell (`source ~/.bashrc`) or check PATH                                              |
| `API key not set`           | Run `hermes model` to configure your provider, or `hermes config set OPENROUTER_API_KEY your_key` |
| Missing config after update | Run `hermes config check` then `hermes config migrate`                                            |

For more diagnostics, run `hermes doctor` — it will tell you exactly what's missing and how to fix it.

## Install method auto-detection<a href="#install-method-auto-detection" class="hash-link" aria-label="Direct link to Install method auto-detection" translate="no" title="Direct link to Install method auto-detection">​</a>

Hermes auto-detects whether it was installed via `pip`, the git installer, Homebrew, or NixOS, and `hermes update` prints the matching update command for that path. There's no env var to set — the detection is based on the install layout (Python site-packages, `~/.hermes/hermes-agent/`, Homebrew prefix, or Nix store path). `hermes doctor` also surfaces the detected method under its environment summary.


- <a href="#quick-install" class="table-of-contents__link toc-highlight">Quick Install</a>
  - <a href="#with-the-hermes-desktop-installer-on-macos-or-windows-recommended" class="table-of-contents__link toc-highlight">With the Hermes Desktop installer on macOS or Windows (recommended)</a>
  - <a href="#without-hermes-desktop" class="table-of-contents__link toc-highlight">Without Hermes Desktop:</a>
  - <a href="#what-the-installer-does" class="table-of-contents__link toc-highlight">What the Installer Does</a>
  - <a href="#after-installation" class="table-of-contents__link toc-highlight">After Installation</a>
- <a href="#prerequisites" class="table-of-contents__link toc-highlight">Prerequisites</a>
- <a href="#manual--developer-installation" class="table-of-contents__link toc-highlight">Manual / Developer Installation</a>
- <a href="#non-sudo--system-service-user-installs" class="table-of-contents__link toc-highlight">Non-Sudo / System Service User Installs</a>
- <a href="#troubleshooting" class="table-of-contents__link toc-highlight">Troubleshooting</a>
- <a href="#install-method-auto-detection" class="table-of-contents__link toc-highlight">Install method auto-detection</a>


