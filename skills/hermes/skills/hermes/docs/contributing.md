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

- Building a new tool? Start with [Adding Tools](/docs/developer-guide/adding-tools)
- Building a new skill? Start with [Creating Skills](/docs/developer-guide/creating-skills)
- Building a new inference provider? Start with [Adding Providers](/docs/developer-guide/adding-providers)

## Development Setup<a href="#development-setup" class="hash-link" aria-label="Direct link to Development Setup" translate="no" title="Direct link to Development Setup">​</a>

### Prerequisites<a href="#prerequisites" class="hash-link" aria-label="Direct link to Prerequisites" translate="no" title="Direct link to Prerequisites">​</a>

| Requirement      | Notes                                                                                                                    |
|------------------|--------------------------------------------------------------------------------------------------------------------------|
| **Git**          | With `--recurse-submodules` support, and the `git-lfs` extension installed                                               |
| **Python 3.11+** | uv will install it if missing                                                                                            |
| **uv**           | Fast Python package manager (<a href="https://docs.astral.sh/uv/" target="_blank" rel="noopener noreferrer">install</a>) |
| **Node.js 20+**  | Optional — needed for browser tools and WhatsApp bridge (matches root `package.json` engines)                            |

### Clone and Install<a href="#clone-and-install" class="hash-link" aria-label="Direct link to Clone and Install" translate="no" title="Direct link to Clone and Install">​</a>


``` prism-code
git clone --recurse-submodules https://github.com/NousResearch/hermes-agent.git
cd hermes-agent

# Create venv with Python 3.11
uv venv venv --python 3.11
export VIRTUAL_ENV="$(pwd)/venv"

# Install with all extras (messaging, cron, CLI menus, dev tools)
uv pip install -e ".[all,dev]"
uv pip install -e "./tinker-atropos"

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
# Symlink for global access
mkdir -p ~/.local/bin
ln -sf "$(pwd)/venv/bin/hermes" ~/.local/bin/hermes

# Verify
hermes doctor
hermes chat -q "Hello"
```


### Run Tests<a href="#run-tests" class="hash-link" aria-label="Direct link to Run Tests" translate="no" title="Direct link to Run Tests">​</a>


``` prism-code
pytest tests/ -v
```


## Code Style<a href="#code-style" class="hash-link" aria-label="Direct link to Code Style" translate="no" title="Direct link to Code Style">​</a>

- **PEP 8** with practical exceptions (no strict line length enforcement)
- **Comments**: Only when explaining non-obvious intent, trade-offs, or API quirks
- **Error handling**: Catch specific exceptions. Use `logger.warning()`/`logger.error()` with `exc_info=True` for unexpected errors
- **Cross-platform**: Never assume Unix (see below)
- **Profile-safe paths**: Never hardcode `~/.hermes` — use `get_hermes_home()` from `hermes_constants` for code paths and `display_hermes_home()` for user-facing messages. See <a href="https://github.com/NousResearch/hermes-agent/blob/main/AGENTS.md#profiles-multi-instance-support" target="_blank" rel="noopener noreferrer">AGENTS.md</a> for full rules.

## Cross-Platform Compatibility<a href="#cross-platform-compatibility" class="hash-link" aria-label="Direct link to Cross-Platform Compatibility" translate="no" title="Direct link to Cross-Platform Compatibility">​</a>

Hermes officially supports Linux, macOS, and WSL2. Native Windows is **not supported**, but the codebase includes some defensive coding patterns to avoid hard crashes in edge cases. Key rules:

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

1.  **Run tests**: `pytest tests/ -v`
2.  **Test manually**: Run `hermes` and exercise the code path you changed
3.  **Check cross-platform impact**: Consider macOS and different Linux distros
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
  - <a href="#clone-and-install" class="table-of-contents__link toc-highlight">Clone and Install</a>
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


