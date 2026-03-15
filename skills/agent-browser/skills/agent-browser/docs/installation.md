> Source: https://agent-browser.dev/installation



[](https://vercel.com "Made with love by Vercel")<span class="text-neutral-300 dark:text-neutral-700"></span>[<span class="font-medium tracking-tight text-lg" style="font-family:var(--font-geist-pixel-square)">agent-browser</span>](/)


Installation


Copy Page


# Installation

## Global installation (recommended)

Installs the native Rust binary for maximum performance:


``` shiki
npm install -g agent-browser
agent-browser install  # Download Chrome from Chrome for Testing (first time)
```


This is the fastest option -- commands run through the native Rust CLI directly with sub-millisecond parsing overhead.

## Quick start (no install)


``` shiki
npx agent-browser install   # Download Chrome (first time only)
npx agent-browser open example.com
```


## Project installation (local dependency)

For projects that want to pin the version in `package.json`:


``` shiki
npm install agent-browser
npx agent-browser install  # Download Chrome (first time)
```


Then use via `npx` or `package.json` scripts.

## Homebrew (macOS)


``` shiki
brew install agent-browser
agent-browser install  # Download Chrome (first time)
```


## Cargo (Rust)


``` shiki
cargo install agent-browser
agent-browser install  # Download Chrome (first time)
```


Compiles from source (~2-3 min). Requires the Rust toolchain (<a href="https://rustup.rs" target="_blank" rel="noopener noreferrer">rustup.rs</a>).

## From source


``` shiki
git clone https://github.com/vercel-labs/agent-browser
cd agent-browser
pnpm install
pnpm build
pnpm build:native
./bin/agent-browser install
pnpm link --global
```


## Linux dependencies

On Linux, install system dependencies:


``` shiki
agent-browser install --with-deps
```


## Custom browser

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


### Serverless example

Use `@sparticuz/chromium` or similar to obtain a Chromium executable path, then pass it via `--executable-path` or `AGENT_BROWSER_EXECUTABLE_PATH`.

## AI agent setup

agent-browser works with any AI agent out of the box. For richer context:

### AI coding assistants (recommended)

Install the skill for your AI coding assistant:


``` shiki
npx skills add vercel-labs/agent-browser
```


This works with Claude Code, Codex, Cursor, Gemini CLI, GitHub Copilot, Goose, OpenCode, and Windsurf. The skill is fetched from the repository and stays up to date automatically.

> **Do not** copy `SKILL.md` from `node_modules` -- it will become stale as new features are added. Always use `npx skills add` or reference the repository version.

### AGENTS.md / CLAUDE.md

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


Ask AI<span class="kbd hidden sm:inline-flex items-center gap-0.5 text-xs opacity-60 font-mono">⌘K</span>
