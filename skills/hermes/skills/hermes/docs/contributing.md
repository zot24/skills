> Source: https://hermes-agent.nousresearch.com/docs/developer-guide/contributing/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Contributing


Thank you for contributing to Hermes Agent! This guide covers setting up your dev environment, understanding the codebase, and getting your PR merged.

## Contribution Priorities<a href="#contribution-priorities" class="hash-link" aria-label="Direct link to Contribution Priorities" translate="no" title="Direct link to Contribution Priorities">​</a>

We value contributions in this order:

1.  **Bug fixes** — crashes, incorrect behavior, data loss
2.  **Cross-platform compatibility** — macOS, different Linux distros, WSL2
3.  **Security hardening** — shell injection, prompt injection, path traversal
4.  **Performance and robustness** — retry logic, error handling, graceful degradation
5.  **New skills** — broadly useful ones (see [Creating Skills](/docs/developer-guide/creating-skills))
6.  **New tools** — rarely needed; most capabilities should be skills
7.  **Documentation** — fixes, clarifications, new examples

## Common contribution paths<a href="#common-contribution-paths" class="hash-link" aria-label="Direct link to Common contribution paths" translate="no" title="Direct link to Common contribution paths">​</a>

- Building a custom/local tool without modifying Hermes core? Start with [Build a Hermes Plugin](/docs/developer-guide/plugins)
- Building a new built-in core tool for Hermes itself? Start with [Adding Tools](/docs/developer-guide/adding-tools)
- Building a new skill? Start with [Creating Skills](/docs/developer-guide/creating-skills)
- Building a new inference provider? Start with [Adding Providers](/docs/developer-guide/adding-providers)

## Development Setup<a href="#development-setup" class="hash-link" aria-label="Direct link to Development Setup" translate="no" title="Direct link to Development Setup">​</a>

### Prerequisites<a href="#prerequisites" class="hash-link" aria-label="Direct link to Prerequisites" translate="no" title="Direct link to Prerequisites">​</a>

| Requirement          | Notes                                                                                                                    |
|----------------------|--------------------------------------------------------------------------------------------------------------------------|
| **Git**              | With the `git-lfs` extension installed                                                                                   |
| **Python 3.11–3.13** | uv will install it if missing                                                                                            |
| **uv**               | Fast Python package manager (<a href="https://docs.astral.sh/uv/" target="_blank" rel="noopener noreferrer">install</a>) |
| **Node.js 20+**      | Optional — needed for browser tools and WhatsApp bridge (matches root `package.json` engines)                            |

### Install with the standard installer<a href="#install-with-the-standard-installer" class="hash-link" aria-label="Direct link to Install with the standard installer" translate="no" title="Direct link to Install with the standard installer">​</a>

For most contributors, the best development bootstrap is the same path users take: run the standard installer, then work inside the repository it cloned. The installer creates the Hermes venv, wires the `hermes` command, stamps the install method for `hermes update`, and clones the full git project into `$HERMES_HOME/hermes-agent` (usually `~/.hermes/hermes-agent`). That keeps your development environment on the same layout the CLI, updater, lazy dependency installer, gateway, and docs assume.


``` prism-code
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
cd "${HERMES_HOME:-$HOME/.hermes}/hermes-agent"

# Add dev/test extras on top of the standard install.
uv pip install -e ".[all,dev]"

# Optional: browser tools / docs site dependencies.
npm install
```


After that, create branches and run tests from that checkout:


``` prism-code
git checkout -b fix/description
scripts/run_tests.sh
```


You can also run a fully isolated Hermes instance (throwaway HERMES_HOME, separate Electron userData, distinct Electron app name to avoid the single-instance lock):


``` prism-code
scripts/dev-sandbox.sh python -m hermes_cli.main
scripts/dev-sandbox.sh --persistent python -m hermes_cli.main desktop  # state survives restarts, but lives in the worktree :)
```


### Manual clone fallback<a href="#manual-clone-fallback" class="hash-link" aria-label="Direct link to Manual clone fallback" translate="no" title="Direct link to Manual clone fallback">​</a>

Use this only if you intentionally do not want Hermes' managed install layout (for example, a throwaway clone inside a container or CI job). If you install this way, make sure you run the `hermes` entrypoint from this venv; running the system `python3 -m hermes_cli.main` can pick up unrelated system Python packages.

Create the venv **outside** the cloned source tree. A venv that lives inside the directory the agent operates from can be wiped by a relative-path command the agent runs against its own checkout (`rm -rf venv`, `uv venv venv`, etc.), which silently destroys the running runtime mid-session. Keeping it outside the tree means no relative path from the workspace resolves to it.


``` prism-code
git clone https://github.com/NousResearch/hermes-agent.git
cd hermes-agent

# Create venv with Python 3.11, OUTSIDE the source tree
uv venv ~/.hermes/venvs/hermes-dev --python 3.11
export VIRTUAL_ENV="$HOME/.hermes/venvs/hermes-dev"
export PATH="$VIRTUAL_ENV/bin:$PATH"

# Install with all extras (messaging, cron, CLI menus, dev tools)
uv pip install -e ".[all,dev]"

# Optional: browser tools
npm install
```


### Configure for Development<a href="#configure-for-development" class="hash-link" aria-label="Direct link to Configure for Development" translate="no" title="Direct link to Configure for Development">​</a>


``` prism-code
mkdir -p ~/.hermes/{cron,sessions,logs,memories,skills}
cp cli-config.yaml.example ~/.hermes/config.yaml
touch ~/.hermes/.env

# Add at minimum an LLM provider key:
echo 'OPENROUTER_API_KEY=sk-or-v1-your-key' >> ~/.hermes/.env
```


### Run<a href="#run" class="hash-link" aria-label="Direct link to Run" translate="no" title="Direct link to Run">​</a>


``` prism-code
# The standard installer already put `hermes` on PATH.
hermes doctor
hermes chat -q "Hello"
```


If you used the manual clone fallback, run `./hermes` from the checkout or symlink this clone's venv explicitly:


``` prism-code
mkdir -p ~/.local/bin
ln -sf "$(pwd)/venv/bin/hermes" ~/.local/bin/hermes
```


### Run Tests<a href="#run-tests" class="hash-link" aria-label="Direct link to Run Tests" translate="no" title="Direct link to Run Tests">​</a>


``` prism-code
scripts/run_tests.sh
```


## Code Style<a href="#code-style" class="hash-link" aria-label="Direct link to Code Style" translate="no" title="Direct link to Code Style">​</a>

- **PEP 8** with practical exceptions (no strict line length enforcement)
- **Comments**: Only when explaining non-obvious intent, trade-offs, or API quirks
- **Error handling**: Catch specific exceptions. Use `logger.warning()`/`logger.error()` with `exc_info=True` for unexpected errors
- **Cross-platform**: Never assume Unix (see below)
- **Profile-safe paths**: Never hardcode `~/.hermes` — use `get_hermes_home()` from `hermes_constants` for code paths and `display_hermes_home()` for user-facing messages. See <a href="https://github.com/NousResearch/hermes-agent/blob/main/AGENTS.md#profiles-multi-instance-support" target="_blank" rel="noopener noreferrer">AGENTS.md</a> for full rules.

## Cross-Platform Compatibility<a href="#cross-platform-compatibility" class="hash-link" aria-label="Direct link to Cross-Platform Compatibility" translate="no" title="Direct link to Cross-Platform Compatibility">​</a>

See **[Platform Support](/docs/getting-started/platform-support)**. Native Windows uses Git Bash (from <a href="https://git-scm.com/download/win" target="_blank" rel="noopener noreferrer">Git for Windows</a>) for shell commands. A few features require POSIX kernel primitives and are gated: the dashboard's embedded PTY terminal pane (`/chat` tab) needs a POSIX PTY (Linux, macOS, or WSL2). If you're doing Windows-heavy dev, run the Windows-footgun lint (`scripts/check-windows-footguns.py`) before pushing.

When contributing code, keep these rules in mind:

- **Don't add unguarded `signal.SIGKILL` references.** It's not defined on Windows. Either route through `gateway.status.terminate_pid(pid, force=True)` (the centralized primitive that does `taskkill /T /F` on Windows and SIGKILL on POSIX), or fall back with `getattr(signal, "SIGKILL", signal.SIGTERM)`.
- **Catch `OSError` alongside `ProcessLookupError` on `os.kill(pid, 0)` probes.** Windows raises `OSError` (WinError 87, "parameter is incorrect") for an already-gone PID instead of `ProcessLookupError`.
- **Don't force the terminal to POSIX semantics.** `os.setsid`, `os.killpg`, `os.getpgid`, `os.fork` all raise on Windows — gate them with `if sys.platform != "win32":` or `if os.name != "nt":`.
- **Open files with an explicit `encoding="utf-8"`.** The Python default on Windows is the system locale (often cp1252), which mojibakes or crashes on non-Latin text.
- **Use `pathlib.Path` / `os.path.join` — never manually concat with `/`.** This matters less for strings the OS gives us back and more for strings we construct to hand to subprocesses.

Key patterns:

### 1. `termios` and `fcntl` are Unix-only<a href="#1-termios-and-fcntl-are-unix-only" class="hash-link" aria-label="Direct link to 1-termios-and-fcntl-are-unix-only" translate="no" title="Direct link to 1-termios-and-fcntl-are-unix-only">​</a>

Always catch both `ImportError` and `NotImplementedError`:


``` prism-code
try:
    from simple_term_menu import TerminalMenu
    menu = TerminalMenu(options)
    idx = menu.show()
except (ImportError, NotImplementedError):
    # Fallback: numbered menu
    for i, opt in enumerate(options):
        print(f"  {i+1}. {opt}")
    idx = int(input("Choice: ")) - 1
```


### 2. File encoding<a href="#2-file-encoding" class="hash-link" aria-label="Direct link to 2. File encoding" translate="no" title="Direct link to 2. File encoding">​</a>

Some environments may save `.env` files in non-UTF-8 encodings:


``` prism-code
try:
    load_dotenv(env_path)
except UnicodeDecodeError:
    load_dotenv(env_path, encoding="latin-1")
```


### 3. Process management<a href="#3-process-management" class="hash-link" aria-label="Direct link to 3. Process management" translate="no" title="Direct link to 3. Process management">​</a>

`os.setsid()`, `os.killpg()`, and signal handling differ across platforms:


``` prism-code
import platform
if platform.system() != "Windows":
    kwargs["preexec_fn"] = os.setsid
```


### 4. Path separators<a href="#4-path-separators" class="hash-link" aria-label="Direct link to 4. Path separators" translate="no" title="Direct link to 4. Path separators">​</a>

Use `pathlib.Path` instead of string concatenation with `/`.

## Security Considerations<a href="#security-considerations" class="hash-link" aria-label="Direct link to Security Considerations" translate="no" title="Direct link to Security Considerations">​</a>

Hermes has terminal access. Security matters.

### Existing Protections<a href="#existing-protections" class="hash-link" aria-label="Direct link to Existing Protections" translate="no" title="Direct link to Existing Protections">​</a>

| Layer                           | Implementation                                                              |
|---------------------------------|-----------------------------------------------------------------------------|
| **Sudo password piping**        | Uses `shlex.quote()` to prevent shell injection                             |
| **Dangerous command detection** | Regex patterns in `tools/approval.py` with user approval flow               |
| **Cron prompt injection**       | Scanner blocks instruction-override patterns                                |
| **Write deny list**             | Protected paths resolved via `os.path.realpath()` to prevent symlink bypass |
| **Skills guard**                | Security scanner for hub-installed skills                                   |
| **Code execution sandbox**      | Child process runs with API keys stripped                                   |
| **Container hardening**         | Docker: all capabilities dropped, no privilege escalation, PID limits       |

### Contributing Security-Sensitive Code<a href="#contributing-security-sensitive-code" class="hash-link" aria-label="Direct link to Contributing Security-Sensitive Code" translate="no" title="Direct link to Contributing Security-Sensitive Code">​</a>

- Always use `shlex.quote()` when interpolating user input into shell commands
- Resolve symlinks with `os.path.realpath()` before access control checks
- Don't log secrets
- Catch broad exceptions around tool execution
- Test on all platforms if your change touches file paths or processes

## Pull Request Process<a href="#pull-request-process" class="hash-link" aria-label="Direct link to Pull Request Process" translate="no" title="Direct link to Pull Request Process">​</a>

### Branch Naming<a href="#branch-naming" class="hash-link" aria-label="Direct link to Branch Naming" translate="no" title="Direct link to Branch Naming">​</a>


``` prism-code
fix/description        # Bug fixes
feat/description       # New features
docs/description       # Documentation
test/description       # Tests
refactor/description   # Code restructuring
```


### Before Submitting<a href="#before-submitting" class="hash-link" aria-label="Direct link to Before Submitting" translate="no" title="Direct link to Before Submitting">​</a>

1.  **Run tests**: `scripts/run_tests.sh` for CI-parity. Use direct `python -m pytest ...` only when the wrapper is unavailable or you are intentionally debugging outside the wrapper.
2.  **Test manually**: Run `hermes` and exercise the code path you changed
3.  **Check cross-platform impact**: Consider macOS, Linux, WSL2, and native Windows. If you touch file I/O, process management, terminal handling, subprocesses, or signals, run `scripts/check-windows-footguns.py`.
4.  **Keep PRs focused**: One logical change per PR

### PR Description<a href="#pr-description" class="hash-link" aria-label="Direct link to PR Description" translate="no" title="Direct link to PR Description">​</a>

Include:

- **What** changed and **why**
- **How to test** it
- **What platforms** you tested on
- Reference any related issues

### Commit Messages<a href="#commit-messages" class="hash-link" aria-label="Direct link to Commit Messages" translate="no" title="Direct link to Commit Messages">​</a>

We use <a href="https://www.conventionalcommits.org/" target="_blank" rel="noopener noreferrer">Conventional Commits</a>:


``` prism-code
<type>(<scope>): <description>
```


| Type       | Use for                       |
|------------|-------------------------------|
| `fix`      | Bug fixes                     |
| `feat`     | New features                  |
| `docs`     | Documentation                 |
| `test`     | Tests                         |
| `refactor` | Code restructuring            |
| `chore`    | Build, CI, dependency updates |

Scopes: `cli`, `gateway`, `tools`, `skills`, `agent`, `install`, `whatsapp`, `security`

Examples:


``` prism-code
fix(cli): prevent crash in save_config_value when model is a string
feat(gateway): add WhatsApp multi-user session isolation
fix(security): prevent shell injection in sudo password piping
```


## Reporting Issues<a href="#reporting-issues" class="hash-link" aria-label="Direct link to Reporting Issues" translate="no" title="Direct link to Reporting Issues">​</a>

- Use <a href="https://github.com/NousResearch/hermes-agent/issues" target="_blank" rel="noopener noreferrer">GitHub Issues</a>
- Include: OS, Python version, Hermes version (`hermes version`), full error traceback
- Include steps to reproduce
- Check existing issues before creating duplicates
- For security vulnerabilities, please report privately

## Community<a href="#community" class="hash-link" aria-label="Direct link to Community" translate="no" title="Direct link to Community">​</a>

- **Discord**: <a href="https://discord.gg/NousResearch" target="_blank" rel="noopener noreferrer">discord.gg/NousResearch</a>
- **GitHub Discussions**: For design proposals and architecture discussions
- **Skills Hub**: Upload specialized skills and share with the community

## License<a href="#license" class="hash-link" aria-label="Direct link to License" translate="no" title="Direct link to License">​</a>

By contributing, you agree that your contributions will be licensed under the <a href="https://github.com/NousResearch/hermes-agent/blob/main/LICENSE" target="_blank" rel="noopener noreferrer">MIT License</a>.


- <a href="#contribution-priorities" class="table-of-contents__link toc-highlight">Contribution Priorities</a>
- <a href="#common-contribution-paths" class="table-of-contents__link toc-highlight">Common contribution paths</a>
- <a href="#development-setup" class="table-of-contents__link toc-highlight">Development Setup</a>
  - <a href="#prerequisites" class="table-of-contents__link toc-highlight">Prerequisites</a>
  - <a href="#install-with-the-standard-installer" class="table-of-contents__link toc-highlight">Install with the standard installer</a>
  - <a href="#manual-clone-fallback" class="table-of-contents__link toc-highlight">Manual clone fallback</a>
  - <a href="#configure-for-development" class="table-of-contents__link toc-highlight">Configure for Development</a>
  - <a href="#run" class="table-of-contents__link toc-highlight">Run</a>
  - <a href="#run-tests" class="table-of-contents__link toc-highlight">Run Tests</a>
- <a href="#code-style" class="table-of-contents__link toc-highlight">Code Style</a>
- <a href="#cross-platform-compatibility" class="table-of-contents__link toc-highlight">Cross-Platform Compatibility</a>
  - <a href="#1-termios-and-fcntl-are-unix-only" class="table-of-contents__link toc-highlight">1. <code>termios</code> and <code>fcntl</code> are Unix-only</a>
  - <a href="#2-file-encoding" class="table-of-contents__link toc-highlight">2. File encoding</a>
  - <a href="#3-process-management" class="table-of-contents__link toc-highlight">3. Process management</a>
  - <a href="#4-path-separators" class="table-of-contents__link toc-highlight">4. Path separators</a>
- <a href="#security-considerations" class="table-of-contents__link toc-highlight">Security Considerations</a>
  - <a href="#existing-protections" class="table-of-contents__link toc-highlight">Existing Protections</a>
  - <a href="#contributing-security-sensitive-code" class="table-of-contents__link toc-highlight">Contributing Security-Sensitive Code</a>
- <a href="#pull-request-process" class="table-of-contents__link toc-highlight">Pull Request Process</a>
  - <a href="#branch-naming" class="table-of-contents__link toc-highlight">Branch Naming</a>
  - <a href="#before-submitting" class="table-of-contents__link toc-highlight">Before Submitting</a>
  - <a href="#pr-description" class="table-of-contents__link toc-highlight">PR Description</a>
  - <a href="#commit-messages" class="table-of-contents__link toc-highlight">Commit Messages</a>
- <a href="#reporting-issues" class="table-of-contents__link toc-highlight">Reporting Issues</a>
- <a href="#community" class="table-of-contents__link toc-highlight">Community</a>
- <a href="#license" class="table-of-contents__link toc-highlight">License</a>


