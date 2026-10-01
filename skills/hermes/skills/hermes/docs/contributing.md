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

| Requirement     | Notes                                                                                                                                                              |
|-----------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Git**         | With the `git-lfs` extension installed                                                                                                                             |
| **Python 3.14** | Current development uses PM's pinned interpreter. The broader `>=3.11,<3.15` package metadata keeps old updaters working, not the current runtime on older Python. |
| **Node.js**     | Use the PM pin or a version accepted by root `package.json` engines                                                                                                |

### PM developer environment<a href="#pm-developer-environment" class="hash-link" aria-label="Direct link to PM developer environment" translate="no" title="Direct link to PM developer environment">​</a>

Use the [PM developer workflow](/docs/reference/package-management#developer-workflow) for preparation, activation, everyday commands, dependency changes, and test environments. Select your development home before setup so experimental code does not migrate production data.

Activate from the repository root in each new shell. Activation prepares the checkout through PM and syncs stale dependencies.

Bash:


``` prism-code
source ./activate
hermes --version
```


PowerShell:


``` prism-code
. .\activate.ps1
hermes --version
```


Run `hermes` for this checkout. Activation defines it as a function for this worktree, so it hides a global `hermes` alias and refuses outside the worktree. PM activation syncs tools and Python dependencies before adding them to the shell. It does not install JS workspaces or rewrite launchers and shell configuration. `deactivate` restores the prior shell environment and removes the function.

### Manual development and test environment<a href="#manual-development-and-test-environment" class="hash-link" aria-label="Direct link to Manual development and test environment" translate="no" title="Direct link to Manual development and test environment">​</a>

Use the [PM developer workflow](/docs/reference/package-management#developer-workflow) to prepare Python 3.14 first. Run these commands from that checkout with its prepared Python. Keep the same development `HERMES_HOME`. PM must be able to start before it can build another environment. On Windows, initialize the native C++ build environment for your architecture before building source dependencies.

Build an independent interpreter for tests and editor tools:


``` prism-code
python -m pm.build_env --source . --out .venv --group dev --group test
```


PM builds from the committed lock and checks dependency consistency before returning the new interpreter. The `test` group includes native launcher test dependencies and does not enter the application runtime. If tests require another declared feature, add its `--extra`.

The output must not exist, even as an empty directory or symlink. To regenerate it after a dependency change, stop its processes and intentionally remove only that disposable environment first. PM does not delete an existing destination. Do not run raw pip or uv commands to change a PM-built environment.

To keep the test environment outside the checkout, replace `.venv` with a fresh absolute path. Set `HERMES_PYTHON` to that environment's interpreter:

- POSIX: `export HERMES_PYTHON="/absolute/path/to/hermes-dev/bin/python"`
- PowerShell: `$env:HERMES_PYTHON = 'C:\absolute\path\to\hermes-dev\Scripts\python.exe'`

The canonical runner discovers repository `.venv` automatically. It clears `PYTHONPATH`, so pytest must be installed in the interpreter's own environment. This test environment does not replace PM's application selection or tool store. Do not point a bundled app at it or install into an MSIX payload.

For an isolated development instance, select a disposable `HERMES_HOME` before starting the source command. Use `hermes setup` to configure it rather than copying production credentials into the checkout.

### JavaScript workspaces and website<a href="#javascript-workspaces-and-website" class="hash-link" aria-label="Direct link to JavaScript workspaces and website" translate="no" title="Direct link to JavaScript workspaces and website">​</a>

From the repository root, run `npm ci` for the desktop, TUI, dashboard, and shared JS workspaces. The website is separate:


``` prism-code
npm ci --prefix website
npm run build:fast --prefix website
```


Use a Node/npm version accepted by the corresponding `package.json` engines. Native desktop dependencies can also require the platform build toolchain.

Logos and icons are generated from `assets/nous-girl-*.svg` and `assets/backgrounds/`. `node scripts/generate-icons.mjs` renders them with the Hermes runtime Python (`HERMES_PYTHON`, else `python` on PATH): Pillow and resvg-py are core dependencies. Do not commit generated PNG/ICO/ICNS outputs.

### Run tests<a href="#run-tests" class="hash-link" aria-label="Direct link to Run tests" translate="no" title="Direct link to Run tests">​</a>

Use the canonical runner on every host:


``` prism-code
scripts/run_tests.sh
scripts/run_tests.sh tests/agent/ -v
```


On Windows, run the script through Bash. When no local `.venv` or `venv` contains pytest, the runner accepts the explicit `HERMES_PYTHON` above. It clears credentials, isolates `HERMES_HOME`, and runs each test file in a separate subprocess through `scripts/run_tests_parallel.py`. It does not use xdist. When `tests/conftest.py` redirects a production `HERMES_HOME` to a temporary session home, it sets the internal `HERMES_TEST_SANDBOX_HOME` marker. This lets re-imported test fixtures recognize their own sandbox instead of flagging it as real-home I/O. Do not set this marker yourself; set `HERMES_HOME` for a disposable development home and let the test runner isolate it.

Run the relevant JS workspace checks for JS changes. Native install/update E2E runs on disposable CI hosts, never against the developer's live app. See [Package management](/docs/reference/package-management) for PM commands and runtime ownership.

## Code Style<a href="#code-style" class="hash-link" aria-label="Direct link to Code Style" translate="no" title="Direct link to Code Style">​</a>

- **PEP 8** with practical exceptions (no strict line length enforcement)
- **Comments**: Only when explaining non-obvious intent, trade-offs, or API quirks
- **Error handling**: Catch specific exceptions. Use `logger.warning()`/`logger.error()` with `exc_info=True` for unexpected errors
- **Cross-platform**: Never assume Unix (see below)
- **Profile-safe paths**: Never hardcode `~/.hermes` — use `get_hermes_home()` from `hermes_constants` for code paths and `display_hermes_home()` for user-facing messages. See <a href="https://github.com/NousResearch/hermes-agent/blob/main/AGENTS.md#profiles-multi-instance-support" target="_blank" rel="noopener noreferrer">AGENTS.md</a> for full rules.

## Cross-Platform Compatibility<a href="#cross-platform-compatibility" class="hash-link" aria-label="Direct link to Cross-Platform Compatibility" translate="no" title="Direct link to Cross-Platform Compatibility">​</a>

See **[Platform Support](/docs/getting-started/platform-support)**. Native Windows uses Git Bash (from <a href="https://git-scm.com/download/win" target="_blank" rel="noopener noreferrer">Git for Windows</a>) for shell commands. The dashboard uses POSIX PTYs on Unix and the `pywinpty`/ConPTY bridge on Windows. Availability depends on that host's native dependency support. If you're doing Windows-heavy dev, run the Windows-footgun lint (`scripts/check-windows-footguns.py`) before pushing.

When contributing code, keep these rules in mind:

- **Don't add unguarded `signal.SIGKILL` references.** It's not defined on Windows. Either route through `gateway.status.terminate_pid(pid, force=True)` (the centralized primitive that does `taskkill /T /F` on Windows and SIGKILL on POSIX), or fall back with `getattr(signal, "SIGKILL", signal.SIGTERM)`.
- **Use `psutil.pid_exists()` for process liveness.** Do not use `os.kill(pid, 0)` on Windows; it is not a safe probe.
- **Don't force the terminal to POSIX semantics.** `os.setsid`, `os.killpg`, `os.getpgid`, `os.fork` all raise on Windows — gate them with `if sys.platform != "win32":` or `if os.name != "nt":`.
- **Use explicit text encodings.** User-authored UTF-8 reads use `utf-8-sig` to accept a leading BOM. Writes use `utf-8` without adding a BOM.
- **Use `pathlib.Path` / `os.path.join` — never manually concat with `/`.** This matters less for strings the OS gives us back and more for strings we construct to hand to subprocesses.

Key patterns:

### 1. File encoding<a href="#1-file-encoding" class="hash-link" aria-label="Direct link to 1. File encoding" translate="no" title="Direct link to 1. File encoding">​</a>

Some environments may save `.env` files in non-UTF-8 encodings:


``` prism-code
try:
    load_dotenv(env_path)
except UnicodeDecodeError:
    load_dotenv(env_path, encoding="latin-1")
```


### 2. Process management<a href="#2-process-management" class="hash-link" aria-label="Direct link to 2. Process management" translate="no" title="Direct link to 2. Process management">​</a>

`os.setsid()`, `os.killpg()`, and signal handling differ across platforms:


``` prism-code
import platform
if platform.system() != "Windows":
    kwargs["preexec_fn"] = os.setsid
```


### 3. Path separators<a href="#3-path-separators" class="hash-link" aria-label="Direct link to 3. Path separators" translate="no" title="Direct link to 3. Path separators">​</a>

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


### Repo-local review checklists: `.agents/checks/*.md`<a href="#repo-local-review-checklists-agentschecksmd" class="hash-link" aria-label="Direct link to repo-local-review-checklists-agentschecksmd" translate="no" title="Direct link to repo-local-review-checklists-agentschecksmd">​</a>

Projects built on (or reviewed by) Hermes can keep reviewer checklists inside the repository under `.agents/checks/`. Each file is a focused, plain-markdown checklist that an agent loads before reviewing a change touching the matching area:


``` prism-code
.agents/
  checks/
    security.md        # e.g. "grep the diff for shell interpolation; check subprocess calls quote args"
    migrations.md      # e.g. "every schema change ships a backfill and a rollback note"
    public-api.md      # e.g. "exported signatures changed? flag for semver review"
```


Conventions that make these work well:

- **One concern per file**, named after the concern. Small files get read in full; a monolithic `checklist.md` gets skimmed.
- **Write checks as verifiable actions** ("run X and confirm Y"), not aspirations ("code should be secure").
- **State the trigger at the top** — which paths or change types the checklist applies to — so an agent (or human) can skip irrelevant ones cheaply.
- Keep them in version control next to the code they guard: they evolve with the codebase, and a PR that changes the rules changes the checklist in the same diff.

When you ask Hermes to review a PR in a repository that has `.agents/checks/`, tell it (or teach it via a skill) to read the relevant checklists first and report against them. This gives review agents the project-specific bar that generic review prompts miss.

## Reporting Issues<a href="#reporting-issues" class="hash-link" aria-label="Direct link to Reporting Issues" translate="no" title="Direct link to Reporting Issues">​</a>

- Use <a href="https://github.com/NousResearch/hermes-agent/issues" target="_blank" rel="noopener noreferrer">GitHub Issues</a>
- Include: OS, Python version, Hermes version (`hermes --version`), full error traceback
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
  - <a href="#pm-developer-environment" class="table-of-contents__link toc-highlight">PM developer environment</a>
  - <a href="#manual-development-and-test-environment" class="table-of-contents__link toc-highlight">Manual development and test environment</a>
  - <a href="#javascript-workspaces-and-website" class="table-of-contents__link toc-highlight">JavaScript workspaces and website</a>
  - <a href="#run-tests" class="table-of-contents__link toc-highlight">Run tests</a>
- <a href="#code-style" class="table-of-contents__link toc-highlight">Code Style</a>
- <a href="#cross-platform-compatibility" class="table-of-contents__link toc-highlight">Cross-Platform Compatibility</a>
  - <a href="#1-file-encoding" class="table-of-contents__link toc-highlight">1. File encoding</a>
  - <a href="#2-process-management" class="table-of-contents__link toc-highlight">2. Process management</a>
  - <a href="#3-path-separators" class="table-of-contents__link toc-highlight">3. Path separators</a>
- <a href="#security-considerations" class="table-of-contents__link toc-highlight">Security Considerations</a>
  - <a href="#existing-protections" class="table-of-contents__link toc-highlight">Existing Protections</a>
  - <a href="#contributing-security-sensitive-code" class="table-of-contents__link toc-highlight">Contributing Security-Sensitive Code</a>
- <a href="#pull-request-process" class="table-of-contents__link toc-highlight">Pull Request Process</a>
  - <a href="#branch-naming" class="table-of-contents__link toc-highlight">Branch Naming</a>
  - <a href="#before-submitting" class="table-of-contents__link toc-highlight">Before Submitting</a>
  - <a href="#pr-description" class="table-of-contents__link toc-highlight">PR Description</a>
  - <a href="#commit-messages" class="table-of-contents__link toc-highlight">Commit Messages</a>
  - <a href="#repo-local-review-checklists-agentschecksmd" class="table-of-contents__link toc-highlight">Repo-local review checklists: <code>.agents/checks/*.md</code></a>
- <a href="#reporting-issues" class="table-of-contents__link toc-highlight">Reporting Issues</a>
- <a href="#community" class="table-of-contents__link toc-highlight">Community</a>
- <a href="#license" class="table-of-contents__link toc-highlight">License</a>


