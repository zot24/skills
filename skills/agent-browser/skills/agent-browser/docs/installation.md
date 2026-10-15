> Source: https://agent-browser.dev/installation



<a href="/" class="flex @min-[1024px]:hidden items-center text-gray-1000"><span class="font-medium tracking-tight" style="font-family:var(--font-geist-pixel-square)">agent-browser</span></a>


<a href="https://github.com/vercel-labs/agent-browser" class="size-8 items-center justify-center @min-[768px]:inline-flex hidden shrink-0" data-geist-button="" data-prefix="false" data-suffix="false" data-version="v1" aria-label="GitHub repository" rel="noopener" target="_blank"><span class="truncate px-1.5 inline-flex shrink-0 items-center justify-center"></span></a>


        &quot;sidebar toc-popover toc&quot;
        &quot;sidebar main toc&quot; 1fr / minmax(var(--fd-sidebar-col), 1fr) minmax(0, calc(var(--fd-layout-width,97rem) - var(--fd-sidebar-width) - var(--fd-toc-width))) minmax(min-content, 1fr);--fd-docs-row-1:4rem;--fd-docs-row-2:calc(var(--fd-docs-row-1) + var(--fd-header-height));--fd-docs-row-3:calc(var(--fd-docs-row-2) + var(--fd-toc-popover-height));--fd-sidebar-col:var(--fd-sidebar-width)">


Menu


# Installation


Copy for LLM


View Markdown


## <a href="#global-installation-recommended" class="peer" data-card="">Global installation (recommended)</a>

Installs the native Rust binary for maximum performance:


``` m-0
npm install -g agent-browser
agent-browser install  # Download Chrome from Chrome for Testing (first time)
```


This is the fastest option -- commands run through the native Rust CLI directly with sub-millisecond parsing overhead.

## <a href="#quick-start-no-install" class="peer" data-card="">Quick start (no install)</a>


``` m-0
npx agent-browser install   # Download Chrome (first time only)
npx agent-browser open example.com
```


## <a href="#project-installation-local-dependency" class="peer" data-card="">Project installation (local dependency)</a>

For projects that want to pin the version in `package.json`:


``` m-0
npm install agent-browser
npx agent-browser install  # Download Chrome (first time)
```


Then use via `npx` or `package.json` scripts.

## <a href="#homebrew-macos" class="peer" data-card="">Homebrew (macOS)</a>


``` m-0
brew install agent-browser
agent-browser install  # Download Chrome (first time)
```


## <a href="#cargo-rust" class="peer" data-card="">Cargo (Rust)</a>


``` m-0
cargo install agent-browser
agent-browser install  # Download Chrome (first time)
```


Compiles from source (~2-3 min). Requires Node.js 24+, pnpm 11+, and the Rust toolchain (<a href="https://rustup.rs" class="font-normal text-gray-1000! underline decoration-1 decoration-gray-700 underline-offset-4 hover:text-gray-1000! hover:decoration-gray-1000 hover:opacity-100!" rel="noreferrer noopener" target="_blank">rustup.rs</a>).

## <a href="#from-source" class="peer" data-card="">From source</a>


``` m-0
git clone https://github.com/vercel-labs/agent-browser
cd agent-browser
pnpm install
pnpm build
pnpm build:native
./bin/agent-browser install
pnpm link --global
```


## <a href="#windows-browser-sessions" class="peer" data-card="">Windows browser sessions</a>

Headless Chrome runs on a private Windows desktop. This prevents hidden browser windows from leaving visible rectangles on your desktop, including with affected Chrome 150 builds. It applies to bundled and custom Chrome executables and to windows created later in the session. Automation, screenshots, and GPU rendering continue through CDP.

Use `--headed` to show Chrome on the interactive desktop. Sessions with extensions also use the interactive desktop. Agent-browser owns the Chrome processes it launches: Windows terminates the entire Chrome tree when its daemon exits or is forcibly killed. Browsers attached with `--cdp` or `--auto-connect` remain externally owned.

## <a href="#linux-dependencies" class="peer" data-card="">Linux dependencies</a>

On Linux, install system dependencies:


``` m-0
agent-browser install --with-deps
```


This exits nonzero if the package manager cannot install every required browser library.

## <a href="#updating" class="peer" data-card="">Updating</a>

Upgrade to the latest version:


``` m-0
agent-browser upgrade
```


Detects your installation method (npm, Homebrew, or Cargo) and runs the appropriate update command automatically. Displays the version change on success, or informs you if you are already on the latest version.

## <a href="#doctor" class="peer" data-card="">Doctor</a>

`doctor` diagnoses your install and auto-cleans stale daemon files. Run it whenever something stops working unexpectedly, or after upgrades:


``` m-0
agent-browser doctor                     # Full diagnosis
agent-browser doctor --offline --quick   # Local-only, fastest (~<1s)
agent-browser doctor --fix               # Also run destructive repairs
agent-browser doctor --webgpu            # Also run a live WebGPU render probe
agent-browser doctor --json              # Structured output
```


It checks:

| Category     | What it checks                                                                                                                                                                                                                                         |
|--------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Environment  | CLI version, platform, home directory, state and socket dirs, free disk space                                                                                                                                                                          |
| Chrome       | Chrome install path and version, cache dir, Puppeteer fallback, user-data dir and profile count, optional `lightpanda` engine                                                                                                                          |
| Daemons      | Running daemons per session, stale `.sock` / `.pid` / `.version` / `.stream` files (auto-cleaned), version mismatch with the CLI, dashboard process liveness                                                                                           |
| Config       | `~/.agent-browser/config.json`, `./agent-browser.json`, and any file at `AGENT_BROWSER_CONFIG` parse as valid JSON                                                                                                                                     |
| Security     | Encryption key env var or `~/.agent-browser/.encryption-key` (with 0600 permissions on unix), state file count and age vs `AGENT_BROWSER_STATE_EXPIRE_DAYS`, action policy file                                                                        |
| Providers    | Env vars for Browserless, Browserbase, Browser Use, Kernel, AgentCore (AWS creds), Appium (for `--provider ios`), and `AI_GATEWAY_API_KEY` for chat                                                                                                    |
| Network      | Reachability of the Chrome for Testing CDN, AI Gateway (if configured), and any currently selected provider endpoint (skipped under `--offline`)                                                                                                       |
| Launch test  | Spawns a scratch session, launches headless Chrome, navigates to `about:blank`, then closes. Measures wall time (skipped under `--quick`)                                                                                                              |
| WebGPU probe | Opt-in via `--webgpu`: launches a scratch session with the [WebGPU preset](/webgpu), renders through a real WebGPU pass, and pixel-checks both an offscreen readback and a decoded screenshot. Add `--headed` to validate the headed/Xvfb capture path |

Stale sidecar files are always cleaned. Destructive actions are opt-in via `--fix`:

| Check                      | What `--fix` does                                                                                        |
|----------------------------|----------------------------------------------------------------------------------------------------------|
| Chrome missing             | Runs `agent-browser install`                                                                             |
| Version-mismatched daemons | Sends `close` to each and cleans files                                                                   |
| Old state files            | Deletes state files older than `AGENT_BROWSER_STATE_EXPIRE_DAYS` (default 30)                            |
| Missing encryption key     | Generates a new key at `~/.agent-browser/.encryption-key` (0600, unix); never overwrites an existing key |

Exit code is `0` if all checks pass (warnings are fine), `1` if any fail.

## <a href="#custom-browser" class="peer" data-card="">Custom browser</a>

Use a custom browser executable instead of bundled Chromium:

- **Serverless** - Use `@sparticuz/chromium` (~50MB vs ~684MB)
- **System browser** - Use existing Chrome installation
- **Custom builds** - Use modified browser builds


``` m-0
# Via flag
agent-browser --executable-path /path/to/chromium open example.com

# Via environment variable
AGENT_BROWSER_EXECUTABLE_PATH=/path/to/chromium agent-browser open example.com
```


### <a href="#serverless-example" class="peer" data-card="">Serverless example</a>

Use `@sparticuz/chromium` or similar to obtain a Chromium executable path, then pass it via `--executable-path` or `AGENT_BROWSER_EXECUTABLE_PATH`.

## <a href="#ai-agent-setup" class="peer" data-card="">AI agent setup</a>

agent-browser works with any AI agent out of the box. For richer context:

### <a href="#ai-coding-assistants-recommended" class="peer" data-card="">AI coding assistants (recommended)</a>

Install the skill for your AI coding assistant:


``` m-0
npx skills add vercel-labs/agent-browser
```


This works with Claude Code, Codex, Cursor, Gemini CLI, GitHub Copilot, Goose, OpenCode, and Windsurf. The skill is fetched from the repository and stays up to date automatically.

> **Do not** copy `SKILL.md` from `node_modules` -- it will become stale as new features are added. Always use `npx skills add` or reference the repository version.

### <a href="#agentsmd-claudemd" class="peer" data-card="">AGENTS.md / CLAUDE.md</a>

Add to your instructions file:


``` m-0
## Browser Automation

Use `agent-browser` for web automation. Run `agent-browser --help` for all commands.

Core workflow:
1. `agent-browser open <url>` - Navigate to page
2. `agent-browser snapshot -i` - Get interactive elements with refs (@e1, @e2)
3. `agent-browser click @e1` / `fill @e2 "text"` - Interact using refs
4. Re-snapshot after page changes
```


<a href="/" class="group grid w-fit grid-cols-[auto_1fr] items-center gap-x-1.5 gap-y-1 text-gray-1000"><span class="text-gray-900 text-sm col-start-2">Previous</span><span class="row-start-2 font-medium col-start-2">Introduction</span></a><a href="/quick-start" class="group grid w-fit grid-cols-[1fr_auto] items-center gap-x-1.5 gap-y-1 justify-self-end text-right text-gray-1000"><span class="text-gray-900 text-sm col-start-1">Next</span><span class="row-start-2 font-medium col-start-1">Quick Start</span></a>


