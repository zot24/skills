---
name: pi
description: Expert on Pi (pi.dev, @earendil-works/pi-coding-agent) — the minimal terminal coding harness. Use when extending or improving Pi, adding a custom provider, writing Pi extensions, Pi skills, Pi themes, or a pi package, forking pi-mono, working in pi-agent-core, pi-ai, pi-coding-agent, or pi-tui, running Pi from source, or debugging the agent loop. Triggers on pi.dev, pi-coding-agent, pi-agent-core, pi-ai, custom provider, pi package, fork pi-mono, extend Pi, improve Pi.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Pi — extend and improve the coding harness

Pi is the minimal terminal coding harness at [pi.dev](https://pi.dev) (`@earendil-works/pi-coding-agent`). This skill is the procedure for changing it.

## Procedure

1. **Classify the job.** Match one row in the package table: extend loop / custom provider / extension / skill / theme / pi package / CLI-TUI / fork / debug / from-source / evals / telemetry / remote protocol. **Done when** one row matches.
2. **Open a local clone** of `https://github.com/earendil-works/pi` (canonical; `pi-mono` 301s here). Clone outside `skills/pi/`. **Done when** `packages/` is present in that clone.
3. **Read the matching `docs/` file.** Open the file named in the table and read the **section** that covers this job. For `extensions.md`, use its Table of Contents and grep to the section. Size warning: `extensions.md` (~162 KB), `rpc.md` (~69 KB), `sdk.md` (~48 KB), `tui.md` (~44 KB). When the table says not cached, open that clone README / package path instead. **Done when** the named section is in context, or — if the cell says not cached — the clone README / package path is in context.
4. **Change the package path in the clone.** Edit that clone. **Done when** the edit is under that package path.
5. **From-source checks** (after a code change):
   - `npm install --ignore-scripts` (README; `docs/development.md` omits the flag — follow README).
   - **`npm run check`** after any code change, full output (`docs/agents-upstream.md` / AGENTS.md:31). Fix every error, warning, and info.
   - Tests: `./test.sh` from repo root for non-e2e; a specific test from the package root otherwise. Run the full vitest suite only through those wrappers.
   - Run `npm run build` or `npm test` only when the user asks (`docs/agents-upstream.md` / AGENTS.md:32). `./pi-test.sh` runs Pi from source without a full build.
   - Debug a TUI/render bug: `/debug` → `~/.pi/agent/pi-debug.log`.
   - `docs/development.md` offers `npm test` and plain `npm install`; `docs/agents-upstream.md` overrides it.
   - **Done when** `npm run check` is clean **and** the touched package's test passes (or the debug log exists for a TUI/render bug).
6. **Contributing.** Read `docs/contributing.md` before opening an upstream PR. New-contributor PRs auto-close until a maintainer posts `lgtm`. **Done when** that file is in context.

Fork/rebrand: read `docs/development.md` section **Forking / Rebranding**. Platform setup (Windows / Termux / tmux / terminal / aliases) lives on the live site — open `https://pi.dev/docs/latest/<slug>` only when that is the job.

## Package table

`docs/development.md` lists a four-package tree. Live `packages/` has ten directories. This table wins.

| Job | Open path | Doc (read the named section) |
|-----|-----------|------------------------------|
| agent loop | `packages/agent` | [package-agent.md](docs/package-agent.md), [sdk.md](docs/sdk.md) (large) |
| custom provider | `packages/ai` + `packages/coding-agent/examples/extensions/custom-provider-*` | [custom-provider.md](docs/custom-provider.md), [package-ai.md](docs/package-ai.md) |
| extension | `packages/coding-agent` + `packages/coding-agent/examples/extensions/` | [extensions.md](docs/extensions.md) (large — ToC + grep) |
| skill | `packages/coding-agent` | [skills.md](docs/skills.md) |
| theme | `packages/tui` + `packages/coding-agent` | [themes.md](docs/themes.md), [tui.md](docs/tui.md) (large) |
| pi package | `packages/coding-agent` | [packages.md](docs/packages.md) |
| CLI / TUI | `packages/coding-agent` + `packages/tui` | [usage.md](docs/usage.md), [tui.md](docs/tui.md) (large) |
| fork / rebrand | `packages/coding-agent` (`package.json`) | [development.md](docs/development.md) Forking / Rebranding |
| from-source | clone root | [agents-upstream.md](docs/agents-upstream.md), [development.md](docs/development.md) |
| debug | clone; log at `~/.pi/agent/pi-debug.log` | [development.md](docs/development.md) section **Debug Command** (`/debug` → `~/.pi/agent/pi-debug.log`) |
| remote protocol | `packages/protocol`, `packages/client`, `packages/server` (experimental) | not cached; read `packages/protocol/README.md`, `packages/client/README.md`, `packages/server/README.md` in the clone (`rpc.md` / `sdk.md` are JSONL RPC / SDK, not this CBOR protocol) |
| evals | `packages/evals` (private) | not cached; read `packages/evals/` in the clone |
| telemetry | `packages/telemetry` | [readme-upstream.md](docs/readme-upstream.md) All Packages row + [settings.md](docs/settings.md) |
| sqlite sessions | `packages/session-backends/sqlite-node` | [package-agent.md](docs/package-agent.md) section **SQLite session backends** |

## Documentation

- **[Quickstart](docs/quickstart.md)** · **[Usage](docs/usage.md)** · **[Settings](docs/settings.md)** · **[Keybindings](docs/keybindings.md)**
- **[Providers](docs/providers.md)** · **[llama.cpp](docs/llama-cpp.md)** · **[Models](docs/models.md)** · **[Custom provider](docs/custom-provider.md)**
- **[Extensions](docs/extensions.md)** (large) · **[Skills](docs/skills.md)** · **[Themes](docs/themes.md)** · **[Packages](docs/packages.md)** · **[Prompt templates](docs/prompt-templates.md)**
- **[Sessions](docs/sessions.md)** · **[Session format](docs/session-format.md)** · **[Compaction](docs/compaction.md)**
- **[SDK](docs/sdk.md)** (large) · **[RPC](docs/rpc.md)** (large) · **[JSON](docs/json.md)** · **[TUI](docs/tui.md)** (large)
- **[Development](docs/development.md)** · **[AGENTS.md](docs/agents-upstream.md)** · **[Contributing](docs/contributing.md)**
- **[Security](docs/security.md)** · **[Containerization](docs/containerization.md)** · **[Environment variables](docs/environment-variables.md)**
- **[README](docs/readme-upstream.md)** · **[package-agent](docs/package-agent.md)** · **[package-ai](docs/package-ai.md)** · **[package-tui](docs/package-tui.md)**

Coding-agent's GitHub README overlaps `usage.md`; open the clone README only when that overlap is the question.

## Upstream

- Docs: https://pi.dev/docs/latest
- Repo: https://github.com/earendil-works/pi
- Slack/chat: https://github.com/earendil-works/pi-chat — open only when the job is chat

## Sync

Run `.github/workflows/scripts/sync-skill.sh skills/pi` to refresh `docs/`. Compare with `.github/workflows/scripts/sync-skill.sh skills/pi --dry-run`.
