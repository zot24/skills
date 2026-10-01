> Source: https://hermes-agent.nousresearch.com/docs/getting-started/installation/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Installation


Get Hermes Agent up and running in under two minutes!


For the full platform support matrix (which OSes, distribution methods, and platform-gated features are supported), see **[Platform Support](/docs/getting-started/platform-support)**.


## Quick Install<a href="#quick-install" class="hash-link" aria-label="Direct link to Quick Install" translate="no" title="Direct link to Quick Install">​</a>

### Desktop packages on macOS or Windows<a href="#desktop-packages-on-macos-or-windows" class="hash-link" aria-label="Direct link to Desktop packages on macOS or Windows" translate="no" title="Direct link to Desktop packages on macOS or Windows">​</a>

Download the package for your platform from the <a href="https://hermes-agent.nousresearch.com/" target="_blank" rel="noopener noreferrer">Hermes website</a>.

- **Windows:** open the `.appinstaller` download with Windows App Installer. It installs the signed MSIX bundle and records its update source. Microsoft Store packages have separate Store ownership.
- **macOS:** open the DMG, then copy `Hermes.app` to Applications. The ZIP artifact carries the signed app used by the automatic updater.

Bundled packages contain the agent, Python, supported dependencies, and prebuilt interfaces. First launch does not build that base runtime. Provider access and optional integrations can still require network access.

A `Hermes-Setup` bootstrap installer is different: it downloads a source installation and builds the desktop app. Light is a remote-only build variant, not a bundled local runtime. See [Hermes Desktop](/docs/user-guide/desktop).


The macOS installer is **Apple Silicon only**. macOS on x86 (Intel) processors is [not a supported platform](/docs/getting-started/platform-support#unsupported).


### Without Hermes Desktop:<a href="#without-hermes-desktop" class="hash-link" aria-label="Direct link to Without Hermes Desktop:" translate="no" title="Direct link to Without Hermes Desktop:">​</a>

For a command-line only install without Hermes Desktop, run:

#### Linux / macOS / WSL2<a href="#linux--macos--wsl2" class="hash-link" aria-label="Direct link to Linux / macOS / WSL2" translate="no" title="Direct link to Linux / macOS / WSL2">​</a>


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


### Android / Termux<a href="#android--termux" class="hash-link" aria-label="Direct link to Android / Termux" translate="no" title="Direct link to Android / Termux">​</a>

Use the [Termux APT package](/docs/getting-started/termux) on aarch64 Android devices. Configure its signed repository before running `pkg install hermes-agent`. The desktop/server scripts are not the Termux installation path.

### What the source installer does<a href="#what-the-source-installer-does" class="hash-link" aria-label="Direct link to What the source installer does" translate="no" title="Direct link to What the source installer does">​</a>

The scripts clone the source, bootstrap uv, and delegate dependency preparation to PM. PM provides pinned Python, Node.js, npm, ripgrep, and FFmpeg. The source installation selects the `all` Python extra, not every optional extra. PM also installs the browser and computer-use tools by default: `agent-browser` and its pinned Chromium, and `cua-driver` (the computer-use driver, on macOS, Windows and glibc Linux). If a download fails, the install still completes and prints the command to retry. The default browser driver (browser-harness, the engine of the Browser Use CLI) is a regular Python dependency, so every install, the Desktop app included, already has it. Other optional tools use their feature-specific installation paths.

To leave the browser tools out, pass `--skip-browser` on POSIX or `-SkipBrowser` on Windows; for the computer-use driver, `--skip-computer-use` / `-SkipComputerUse`. Hermes remembers these choices: later installs and `hermes update` do not add them back. Run `hermes pm install agent-browser` or `hermes pm install cua-driver` to install them and undo the choice.

The scripts create a launcher and prepare the data directory. Interactive runs also invoke setup and gateway configuration. `--non-interactive` on POSIX, or `-NonInteractive` on Windows, skips stages that need input. The optional `--include-desktop` / `-IncludeDesktop` stage builds the desktop from source.

On a terminal the scripts show one status line per step and write the output of git, uv and the builds to `logs/install.log` under the Hermes data directory; a failed step prints its last lines and the log path. CI (`CI` or `GITHUB_ACTIONS` set), redirected output, `--verbose` / `-Verbose` or `HERMES_INSTALL_VERBOSE=1` stream everything instead.

#### Install layout<a href="#install-layout" class="hash-link" aria-label="Direct link to Install layout" translate="no" title="Direct link to Install layout">​</a>

| Method                | Code                                  | CLI entry point                               | Default user data                      |
|-----------------------|---------------------------------------|-----------------------------------------------|----------------------------------------|
| POSIX source script   | `~/.hermes/hermes-agent/`             | `~/.local/bin/hermes` wrapper                 | `~/.hermes/`                           |
| Windows source script | `%LOCALAPPDATA%\hermes\hermes-agent\` | `%LOCALAPPDATA%\hermes\bin\`                  | `%LOCALAPPDATA%\hermes\`               |
| Desktop bundle        | Inside the installed app package      | Packaged launchers; Windows execution aliases | Platform default Hermes data directory |
| Docker                | `/opt/hermes/`                        | Image entrypoint and `hermes` shim            | Mounted `/opt/data/`                   |
| Termux APT            | `$PREFIX/lib/hermes-agent/`           | Symlinks in `$PREFIX/bin/`                    | `~/.hermes/`                           |

`HERMES_HOME` selects user data. The POSIX script's `--dir` selects its source checkout independently. Windows provides `-HermesHome` and `-InstallDir`. Running the POSIX script as root does not select an automatic FHS layout: it uses root's home unless you provide an explicit source path.

PM's tool store and per-install Python generations have separate lifetimes. See [Package management](/docs/reference/package-management) for their locations. Do not remove the data root to repair an application installation.

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
hermes config get     # Inspect individual config values
hermes setup          # Or run the full setup wizard to configure everything at once
```


One subscription covers 300+ models plus the [Tool Gateway](/docs/user-guide/features/tool-gateway) (web search, image generation, TTS, cloud browser). Skip the per-tool key juggling:


``` prism-code
hermes setup --portal
```


That logs you in, sets Nous as your provider, and turns on the Tool Gateway in one command.


You don't need to rebuild your setup from scratch. Restore a full backup with `hermes import` (see [Exporting Hermes to another machine](/docs/reference/faq#exporting-hermes-to-another-machine)), or bring over a single agent with `hermes profile import` (see [Moving a single profile to another machine](/docs/reference/faq#moving-a-single-profile-to-another-machine)). Note that a profile export excludes credentials by design, so an export alone is not a full backup — [`hermes backup` vs `hermes profile export`](/docs/reference/faq#hermes-backup-vs-hermes-profile-export) explains which to use.


------------------------------------------------------------------------

## Prerequisites<a href="#prerequisites" class="hash-link" aria-label="Direct link to Prerequisites" translate="no" title="Direct link to Prerequisites">​</a>

For the POSIX source script, provide Git, curl, tar, and SHA-256 utilities. Windows can bootstrap its pinned Git for Windows archive when Git is absent. The script always downloads its verified uv pin; a uv already on your PATH is never used.

Current first-party installations run on **Python 3.14**. The broader `>=3.11,<3.15` range in `pyproject.toml` lets older Python installations run the updater before PM switches them to 3.14; it does not promise current runtime support on 3.11–3.13. PM selects the managed tool versions from `pm/lock.json`; it does not adopt arbitrary system Node versions as the installed runtime.

Source builds can require a native compiler and platform development libraries. Building Electron from source adds Node native-module requirements. These build prerequisites do not apply to installing a complete desktop package. Linux Chromium also requires system libraries supplied by the distribution.


Nix is **no longer an explicitly supported install path** (best-effort only). If you already use Nix (on NixOS, macOS, or Linux), there's a dedicated setup path with a Nix flake, declarative NixOS module, and optional container mode. See the **[Nix & NixOS Setup](/docs/getting-started/nix-setup)** guide.


------------------------------------------------------------------------

## Manual / Developer Installation<a href="#manual--developer-installation" class="hash-link" aria-label="Direct link to Manual / Developer Installation" translate="no" title="Direct link to Manual / Developer Installation">​</a>

For a source checkout, start with the [PM developer workflow](/docs/reference/package-management#developer-workflow). It covers activation, daily commands, dependency refresh, and current bootstrap limits. [Development Setup](/docs/developer-guide/contributing#development-setup) covers the separate test environment and checks.

------------------------------------------------------------------------

## Non-Sudo / System Service User Installs<a href="#non-sudo--system-service-user-installs" class="hash-link" aria-label="Direct link to Non-Sudo / System Service User Installs" translate="no" title="Direct link to Non-Sudo / System Service User Installs">​</a>

Run the source installer as the intended service user. Its home, tool store, configuration, and launcher must belong to that user.

1.  As an administrator, install the source-build prerequisites and any Linux libraries needed by the selected browser backend.

2.  As the service user, run the regular installer:

    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
    ```

    </div>

    </div>

3.  Add the actual launcher directory to the service user's shell environment:

    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    export PATH="$HOME/.local/bin:$PATH"
    ```

    </div>

    </div>

4.  Run `hermes doctor` from that account. Use the installed wrapper, not a hardcoded `venv/bin/hermes` path.

5.  For a Linux user service that must survive logout, enable lingering as an administrator:

    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    sudo loginctl enable-linger SERVICE_USER
    ```

    </div>

    </div>

The current source installer does not run Playwright's `--with-deps` step or provide a package-manager-specific sudo fallback. PM manages tool binaries; the administrator supplies system libraries. See [Browser automation](/docs/user-guide/features/browser) and [Messaging Gateway](/docs/user-guide/messaging/).

------------------------------------------------------------------------

## Troubleshooting<a href="#troubleshooting" class="hash-link" aria-label="Direct link to Troubleshooting" translate="no" title="Direct link to Troubleshooting">​</a>

| Problem                     | Solution                                                                                          |
|-----------------------------|---------------------------------------------------------------------------------------------------|
| `hermes: command not found` | Reload your shell (`source ~/.bashrc`) or check PATH                                              |
| `API key not set`           | Run `hermes model` to configure your provider, or `hermes config set OPENROUTER_API_KEY your_key` |
| Missing config after update | Run `hermes config check` then `hermes config migrate`                                            |

For more diagnostics, run `hermes doctor` — it will tell you exactly what's missing and how to fix it.

### Symlinked home directories and external storage<a href="#symlinked-home-directories-and-external-storage" class="hash-link" aria-label="Direct link to Symlinked home directories and external storage" translate="no" title="Direct link to Symlinked home directories and external storage">​</a>

Hermes supports a symlinked `HERMES_HOME` and symlinked home subdirectories, including `hooks`, `skills`, `sessions`, and `logs`. During home initialization, existing directory links are preserved, and permissions on linked directories (and descendants such as `logs/curator`) are left to their owner.

If a link target is missing, inaccessible, or not a directory, initialization stops with a storage error naming the path and link target. Hermes does **not** replace the link or create its missing target: doing so could write data onto the local disk while an external or NAS volume is unmounted. Check the reported link, restore the mount or correct its target, and verify access permissions before retrying. For a deliberately new dotfiles target, create it yourself only after confirming the intended storage is available.

`hermes doctor` reports these failures as storage problems, not invalid YAML. Keep your existing `config.yaml`; running `hermes setup` is not the repair for an unavailable directory. This is a directory-availability check, not a mount monitor: an existing directory cannot establish that the intended volume is mounted.

## Install method auto-detection<a href="#install-method-auto-detection" class="hash-link" aria-label="Direct link to Install method auto-detection" translate="no" title="Direct link to Install method auto-detection">​</a>

The update owner depends on the running installation, not only its data home. Source checkouts use the managed Git update path. Desktop bundles, Docker, Nix, and Termux packages retain their package owner's update mechanism. `hermes doctor` reports installation provenance. See [Updating & Uninstalling](/docs/getting-started/updating) before changing package-owned files.


- <a href="#quick-install" class="table-of-contents__link toc-highlight">Quick Install</a>
  - <a href="#desktop-packages-on-macos-or-windows" class="table-of-contents__link toc-highlight">Desktop packages on macOS or Windows</a>
  - <a href="#without-hermes-desktop" class="table-of-contents__link toc-highlight">Without Hermes Desktop:</a>
  - <a href="#android--termux" class="table-of-contents__link toc-highlight">Android / Termux</a>
  - <a href="#what-the-source-installer-does" class="table-of-contents__link toc-highlight">What the source installer does</a>
  - <a href="#after-installation" class="table-of-contents__link toc-highlight">After Installation</a>
- <a href="#prerequisites" class="table-of-contents__link toc-highlight">Prerequisites</a>
- <a href="#manual--developer-installation" class="table-of-contents__link toc-highlight">Manual / Developer Installation</a>
- <a href="#non-sudo--system-service-user-installs" class="table-of-contents__link toc-highlight">Non-Sudo / System Service User Installs</a>
- <a href="#troubleshooting" class="table-of-contents__link toc-highlight">Troubleshooting</a>
  - <a href="#symlinked-home-directories-and-external-storage" class="table-of-contents__link toc-highlight">Symlinked home directories and external storage</a>
- <a href="#install-method-auto-detection" class="table-of-contents__link toc-highlight">Install method auto-detection</a>


