> Source: https://agent-browser.dev/installation



[](https://vercel.com "Made with love by Vercel")<span class="text-neutral-300 dark:text-neutral-700"></span>[<span class="font-medium tracking-tight text-lg" style="font-family:var(--font-geist-pixel-square)">agent-browser</span>](/)


Installation


Copy Page


# Installation<a href="#installation" aria-label="Link to this section">#</a>

## Global installation (recommended)<a href="#global-installation-recommended" aria-label="Link to this section">#</a>

Installs the native Rust binary for maximum performance:


``` shiki
npm install -g agent-browser
agent-browser install  # Download Chrome from Chrome for Testing (first time)
```


This is the fastest option -- commands run through the native Rust CLI directly with sub-millisecond parsing overhead.

## Quick start (no install)<a href="#quick-start-no-install" aria-label="Link to this section">#</a>


``` shiki
npx agent-browser install   # Download Chrome (first time only)
npx agent-browser open example.com
```


## Project installation (local dependency)<a href="#project-installation-local-dependency" aria-label="Link to this section">#</a>

For projects that want to pin the version in `package.json`:


``` shiki
npm install agent-browser
npx agent-browser install  # Download Chrome (first time)
```


Then use via `npx` or `package.json` scripts.

## Homebrew (macOS)<a href="#homebrew-macos" aria-label="Link to this section">#</a>


``` shiki
brew install agent-browser
agent-browser install  # Download Chrome (first time)
```


## Cargo (Rust)<a href="#cargo-rust" aria-label="Link to this section">#</a>


``` shiki
cargo install agent-browser
agent-browser install  # Download Chrome (first time)
```


Compiles from source (~2-3 min). Requires the Rust toolchain (<a href="https://rustup.rs" target="_blank" rel="noopener noreferrer">rustup.rs</a>).

## From source<a href="#from-source" aria-label="Link to this section">#</a>


``` shiki
git clone https://github.com/vercel-labs/agent-browser
cd agent-browser
pnpm install
pnpm build
pnpm build:native
./bin/agent-browser install
pnpm link --global
```


## Linux dependencies<a href="#linux-dependencies" aria-label="Link to this section">#</a>

On Linux, install system dependencies:


``` shiki
agent-browser install --with-deps
```


## Updating<a href="#updating" aria-label="Link to this section">#</a>

Upgrade to the latest version:


``` shiki
agent-browser upgrade
```


Detects your installation method (npm, Homebrew, or Cargo) and runs the appropriate update command automatically. Displays the version change on success, or informs you if you are already on the latest version.

## Doctor<a href="#doctor" aria-label="Link to this section">#</a>

`doctor` diagnoses your install and auto-cleans stale daemon files. Run it whenever something stops working unexpectedly, or after upgrades:


``` shiki
agent-browser doctor                     # Full diagnosis
agent-browser doctor --offline --quick   # Local-only, fastest (~<1s)
agent-browser doctor --fix               # Also run destructive repairs
agent-browser doctor --json              # Structured output
```


It checks:

| Category    | What it checks                                                                                                                                                                  |
|-------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Environment | CLI version, platform, home directory, state and socket dirs, free disk space                                                                                                   |
| Chrome      | Chrome install path and version, cache dir, Puppeteer fallback, user-data dir and profile count, optional `lightpanda` engine                                                   |
| Daemons     | Running daemons per session, stale `.sock` / `.pid` / `.version` / `.stream` files (auto-cleaned), version mismatch with the CLI, dashboard process liveness                    |
| Config      | `~/.agent-browser/config.json`, `./agent-browser.json`, and any file at `AGENT_BROWSER_CONFIG` parse as valid JSON                                                              |
| Security    | Encryption key env var or `~/.agent-browser/.encryption-key` (with 0600 permissions on unix), state file count and age vs `AGENT_BROWSER_STATE_EXPIRE_DAYS`, action policy file |
| Providers   | Env vars for Browserless, Browserbase, Browser Use, Kernel, AgentCore (AWS creds), Appium (for `--provider ios`), and `AI_GATEWAY_API_KEY` for chat                             |
| Network     | Reachability of the Chrome for Testing CDN, AI Gateway (if configured), and any currently selected provider endpoint (skipped under `--offline`)                                |
| Launch test | Spawns a scratch session, launches headless Chrome, navigates to `about:blank`, then closes. Measures wall time (skipped under `--quick`)                                       |

Stale sidecar files are always cleaned. Destructive actions are opt-in via `--fix`:

| Check                      | What `--fix` does                                                                                        |
|----------------------------|----------------------------------------------------------------------------------------------------------|
| Chrome missing             | Runs `agent-browser install`                                                                             |
| Version-mismatched daemons | Sends `close` to each and cleans files                                                                   |
| Old state files            | Deletes state files older than `AGENT_BROWSER_STATE_EXPIRE_DAYS` (default 30)                            |
| Missing encryption key     | Generates a new key at `~/.agent-browser/.encryption-key` (0600, unix); never overwrites an existing key |

Exit code is `0` if all checks pass (warnings are fine), `1` if any fail.

## Custom browser<a href="#custom-browser" aria-label="Link to this section">#</a>

Use a custom browser executable instead of bundled Chromium:

- **Serverless** - Use `@sparticuz/chromium` (~50MB vs ~684MB)
- **System browser** - Use existing Chrome installation
- **Custom builds** - Use modified browser builds


``` shiki
# Via flag
agent-browser --executable-path /path/to/chromium open example.com

# Via environment variable
AGENT_BROWSER_EXECUTABLE_PATH=/path/to/chromium agent-browser open example.com
```


### Serverless example<a href="#serverless-example" aria-label="Link to this section">#</a>

Use `@sparticuz/chromium` or similar to obtain a Chromium executable path, then pass it via `--executable-path` or `AGENT_BROWSER_EXECUTABLE_PATH`.

## AI agent setup<a href="#ai-agent-setup" aria-label="Link to this section">#</a>

agent-browser works with any AI agent out of the box. For richer context:

### AI coding assistants (recommended)<a href="#ai-coding-assistants-recommended" aria-label="Link to this section">#</a>

Install the skill for your AI coding assistant:


``` shiki
npx skills add vercel-labs/agent-browser
```


This works with Claude Code, Codex, Cursor, Gemini CLI, GitHub Copilot, Goose, OpenCode, and Windsurf. The skill is fetched from the repository and stays up to date automatically.

> **Do not** copy `SKILL.md` from `node_modules` -- it will become stale as new features are added. Always use `npx skills add` or reference the repository version.

### AGENTS.md / CLAUDE.md<a href="#agentsmd-claudemd" aria-label="Link to this section">#</a>

Add to your instructions file:


``` shiki
## Browser Automation

Use `agent-browser` for web automation. Run `agent-browser --help` for all commands.

Core workflow:
1. `agent-browser open <url>` - Navigate to page
2. `agent-browser snapshot -i` - Get interactive elements with refs (@e1, @e2)
3. `agent-browser click @e1` / `fill @e2 "text"` - Interact using refs
4. Re-snapshot after page changes
```


Ask AI<span class="kbd hidden sm:inline-flex items-center gap-0.5 text-xs opacity-60 font-mono">⌘I</span>
