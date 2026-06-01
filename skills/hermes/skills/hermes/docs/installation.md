> Source: https://hermes-agent.nousresearch.com/docs/getting-started/installation/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Installation


Get Hermes Agent up and running in under two minutes with the one-line installer.

## Quick Install<a href="#quick-install" class="hash-link" aria-label="Direct link to Quick Install" translate="no" title="Direct link to Quick Install">​</a>

### One-Line Installer (Linux / macOS / WSL2)<a href="#one-line-installer-linux--macos--wsl2" class="hash-link" aria-label="Direct link to One-Line Installer (Linux / macOS / WSL2)" translate="no" title="Direct link to One-Line Installer (Linux / macOS / WSL2)">​</a>

For a git-based install that tracks `main` and gives you the latest changes immediately:


``` prism-code
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```


### Windows (native, PowerShell)<a href="#windows-native-powershell" class="hash-link" aria-label="Direct link to Windows (native, PowerShell)" translate="no" title="Direct link to Windows (native, PowerShell)">​</a>

Native Windows runs Hermes without WSL — the CLI, gateway, TUI, and tools all work natively. (Both native and WSL2 installs coexist cleanly; see the feature note below for the one WSL2-only feature.) Found a bug? Please <a href="https://github.com/NousResearch/hermes-agent/issues" target="_blank" rel="noopener noreferrer">file issues</a>.

Open PowerShell and run:


``` prism-code
iex (irm https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.ps1)
```


The installer handles **everything**: `uv`, Python 3.11, Node.js 22, `ripgrep`, `ffmpeg`, **and a portable Git Bash** (PortableGit — a self-contained Git-for-Windows distribution that ships `bash.exe` and the full POSIX toolchain Hermes uses for shell commands; on 32-bit Windows the installer falls back to MinGit, which lacks bash and disables terminal-tool / agent-browser features). It clones the repo under `%LOCALAPPDATA%\hermes\hermes-agent`, creates a virtualenv, and adds `hermes` to your **User PATH**. Restart your terminal (or open a new PowerShell window) after the install so PATH picks up.

**How Git is handled:**

1.  If `git` is already on your PATH, the installer uses your existing install.
2.  Otherwise it downloads portable **PortableGit** (~50MB, from the official `git-for-windows` GitHub release) and unpacks it to `%LOCALAPPDATA%\hermes\git`. No admin rights required. Completely isolated — it won't interfere with any system Git install, broken or otherwise. (On 32-bit Windows it falls back to MinGit because PortableGit ships only 64-bit and ARM64 assets; bash-dependent Hermes features won't work on 32-bit hosts.)

**Why not use winget?** Earlier designs auto-installed Git via `winget install Git.Git`, but winget fails badly when a system Git install is in a partial or broken state (exactly when users need the installer to just work). The portable Git approach sidesteps winget, the Windows installer registry, and any existing system Git entirely. If the Hermes Git install itself ever breaks, `Remove-Item %LOCALAPPDATA%\hermes\git` and re-run the installer — no system impact, no uninstall drama.

The installer also sets `HERMES_GIT_BASH_PATH` to the located `bash.exe` so Hermes resolves it deterministically in fresh shells.

If you prefer WSL2, the Linux installer above works inside it; both native and WSL installs can coexist without conflict (native data lives under `%LOCALAPPDATA%\hermes`, WSL data lives under `~/.hermes`).

**Desktop installer (alternative):** A thin GUI installer is also available — download Hermes Desktop, run the `.exe`, and on first launch it calls `install.ps1` under the hood to provision Python (via `uv`), Node, PortableGit, and the rest of the dependencies. The desktop app and the PowerShell-installed CLI share the same install and data directories, so you can use either or both. See the [Windows (Native) guide](/docs/user-guide/windows-native#desktop-installer-alternative) for details.

### Android / Termux<a href="#android--termux" class="hash-link" aria-label="Direct link to Android / Termux" translate="no" title="Direct link to Android / Termux">​</a>

Hermes now ships a Termux-aware installer path too:


``` prism-code
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```


The installer detects Termux automatically and switches to a tested Android flow:

- uses Termux `pkg` for system dependencies (`git`, `python`, `nodejs`, `ripgrep`, `ffmpeg`, build tools)
- creates the virtualenv with `python -m venv`
- exports `ANDROID_API_LEVEL` automatically for Android wheel builds
- prefers the broad `.[termux-all]` extra and falls back to the smaller `.[termux]` extra (and finally a base install) if the first attempt fails to compile
- skips the untested browser / WhatsApp bootstrap by default

If you want the fully explicit path, follow the dedicated [Termux guide](/docs/getting-started/termux).


Everything except the browser-based dashboard chat terminal runs natively on Windows:

- **CLI (`hermes chat`, `hermes setup`, `hermes gateway`, …)** — native, uses your default terminal
- **Gateway (Telegram, Discord, Slack, …)** — native, runs as a background PowerShell process
- **Cron scheduler** — native
- **Browser tool** — native (Chromium via Node.js)
- **MCP servers** — native (stdio and HTTP transports both supported)
- **Dashboard `/chat` terminal pane** — **WSL2 only** (uses a POSIX PTY; native Windows has no equivalent). The rest of the dashboard (sessions, jobs, metrics) works natively — only the embedded PTY terminal tab is gated.

Set `HERMES_DISABLE_WINDOWS_UTF8=1` in your environment if you hit an encoding-related bug and want to fall back to the legacy cp1252 stdio path (useful for bisecting).


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

**pip install:** No prerequisites beyond Python 3.11+. Everything else is handled automatically.

**Git installer:** The only prerequisite is **Git**. The installer automatically handles everything else:

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
    curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
    ```

    </div>

    </div>

    If you want to skip the Playwright step entirely — for example because you're running headless and don't need browser automation — pass `--skip-browser`:

    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash -s -- --skip-browser
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
  - <a href="#one-line-installer-linux--macos--wsl2" class="table-of-contents__link toc-highlight">One-Line Installer (Linux / macOS / WSL2)</a>
  - <a href="#windows-native-powershell" class="table-of-contents__link toc-highlight">Windows (native, PowerShell)</a>
  - <a href="#android--termux" class="table-of-contents__link toc-highlight">Android / Termux</a>
  - <a href="#what-the-installer-does" class="table-of-contents__link toc-highlight">What the Installer Does</a>
  - <a href="#after-installation" class="table-of-contents__link toc-highlight">After Installation</a>
- <a href="#prerequisites" class="table-of-contents__link toc-highlight">Prerequisites</a>
- <a href="#manual--developer-installation" class="table-of-contents__link toc-highlight">Manual / Developer Installation</a>
- <a href="#non-sudo--system-service-user-installs" class="table-of-contents__link toc-highlight">Non-Sudo / System Service User Installs</a>
- <a href="#troubleshooting" class="table-of-contents__link toc-highlight">Troubleshooting</a>
- <a href="#install-method-auto-detection" class="table-of-contents__link toc-highlight">Install method auto-detection</a>


