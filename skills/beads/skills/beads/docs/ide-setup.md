> Source: https://beads.gascity.com/getting-started/ide-setup.md

> ## Documentation Index
> Fetch the complete documentation index at: https://beads.gascity.com/llms.txt
> Use this file to discover all available pages before exploring further.

# IDE Setup

> Configure bd setup recipes, hooks, and instruction files for Claude Code, Cursor, Gemini, Copilot, and other coding agents

Configure your IDE or coding agent for optimal beads integration.

Last reviewed: 2026-10-05

Freshness source: `cmd/bd/setup*.go` and `internal/recipes/`.

## How `bd setup` Works

The `bd setup` command uses a **recipe-based architecture**: recipes define where beads workflow instructions are written. Built-in recipes cover popular tools, and you can add custom recipes for any other tool (see Custom Recipes below). Integrations complement each other — you can install several at once.

```bash theme={null}
bd setup --list             # Show all available recipes
bd setup claude             # Install an integration (claude, cursor, gemini, ...)
bd setup claude --check     # Verify installation
bd setup claude --remove    # Uninstall
```

| Recipe | Files written | Details |
| - | - | - |
| `claude` | `.claude/settings.json` + `CLAUDE.md` section (or `~/.claude/settings.json` + `~/.claude/CLAUDE.md` with `--global`) | [Claude Code](https://beads.gascity.com/integrations/claude-code.md) |
| `cursor` | `.cursor/rules/beads.mdc` + `.agents/skills/beads/` + `.cursor/hooks.json` (with `--global`: `~/.cursor/hooks.json` + `~/.agents/skills/beads/`, no rules file) | [Cursor](https://beads.gascity.com/integrations/cursor.md) |
| `gemini` | `~/.gemini/settings.json` + `~/.gemini/GEMINI.md` section (or `.gemini/settings.json` + `GEMINI.md` section with `--project`, except from `~` or `~/.gemini`) | [Gemini CLI](https://beads.gascity.com/integrations/gemini.md) |
| `copilot` | `.copilot-plugin/plugin.json` + `.github/copilot-instructions.md` | [Copilot CLI](https://beads.gascity.com/integrations/copilot-cli.md) |
| `codex` | `.agents/skills/beads/` + `AGENTS.md` section + `.codex/` hooks (with `--global`: `~/.agents/skills/beads/` + `$CODEX_HOME` or `~/.codex`) | [Codex](https://beads.gascity.com/integrations/codex.md) |
| `factory` | `AGENTS.md` section | [Factory.ai Droid](https://beads.gascity.com/integrations/factory.md) |
| `mux` | `AGENTS.md` section (+ `.mux/` layers with `--project`/`--global`) | [Mux](https://beads.gascity.com/integrations/mux.md) |
| `opencode` | `AGENTS.md` section | [OpenCode](https://beads.gascity.com/integrations/opencode.md) |
| `aider` | `.aider.conf.yml` + `.aider/BEADS.md` + `.aider/README.md` | [Aider](https://beads.gascity.com/integrations/aider.md) |
| `junie` | `.junie/guidelines.md` + `.junie/mcp/mcp.json` | [Junie](https://beads.gascity.com/integrations/junie.md) |
| `windsurf` | `.windsurf/rules/beads.md` | [Windsurf](https://beads.gascity.com/integrations/windsurf.md) |
| `cody` | `.cody/rules/beads.md` | [Cody](https://beads.gascity.com/integrations/cody.md) |
| `kilocode` | `.kilocode/rules/beads.md` | [Kilo Code](https://beads.gascity.com/integrations/kilocode.md) |
| `kiro` | `.kiro/steering/beads.md` | [Kiro CLI](https://beads.gascity.com/integrations/kiro.md) |

`bd prime` is the single source of truth for operational workflow commands. Each integration's instruction file either points to `bd prime` (hook-enabled agents) or carries the full command reference (AGENTS-first agents).

> [!NOTE]
>
> Commit the instruction files (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, as applicable) to git so all team members and AI tools get the same instructions.

### Template Profiles

Each integration writes one of two **profiles** that control how much content goes into the tool's instruction file (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, or `.github/copilot-instructions.md`):

| Profile | Used by | Content |
| - | - | - |
| `full` | Factory, Mux, OpenCode | Complete command reference, issue types, priorities, workflow |
| `minimal` | Claude Code, GitHub Copilot CLI, Gemini CLI | Pointer to `bd prime`, quick reference only (\~60% smaller) |

Hook-enabled agents use the `minimal` profile because `bd prime` injects full context at session start. AGENTS-first agents use the `full` profile because their instruction file remains the primary integration surface. Codex is skill-based instead: it uses `.agents/skills/beads/SKILL.md`, with managed `AGENTS.md` guidance telling Codex when to use the skill.

**Profile precedence:** if a file already has a `full` profile section and a `minimal` profile tool installs to the same file (for example via symlinks), the `full` profile is preserved to avoid information loss.

### Policy Profiles

Template profiles control how much text gets installed. Policy profiles control what an agent is authorized to do at handoff:

| Policy | Default scope | Commit/push guidance |
| - | - | - |
| `conservative` | Standalone projects, unknown projects, and one-off assistance | Use `bd` for task tracking, then report changed files, validation, and proposed commands. Do not commit, push, or run Dolt remote sync without explicit user or orchestrator approval. |
| `minimal` | Hook-first integrations where `bd prime` carries the detailed workflow | Same git authority as conservative; the installed file stays short and points to `bd prime`. |
| `team-maintainer` | Repositories that explicitly delegate session close to agents | Agents may close beads, run quality gates, commit, run `bd dolt push`, and `git push` as part of routine work. Current "do not commit" or "do not push" instructions still override the profile. |

The generated beads section and `bd prime` default to conservative git authority. Set the profile explicitly with the `agent.profile` config key or the `BD_AGENT_PROFILE` environment variable (values: `conservative`, `minimal`, `team-maintainer`; the env var takes precedence; an unrecognized value falls back to `conservative`):

```bash theme={null}
bd config set agent.profile team-maintainer
# or, for a single session/process:
BD_AGENT_PROFILE=team-maintainer bd prime
```

`bd prime` layers this explicit knob on top of its per-branch git-authority checks (stealth mode, no git remote, ephemeral branch, `no-push`); those hard constraints still take precedence, and `team-maintainer` remains subordinate to any explicit "do not commit"/"do not push" instruction. Beads never infers team-maintainer authority merely because a remote exists — it must be set via this knob (or, for tools without config access, via top-level project instructions).

### Managed Sections

`bd setup factory`, `bd setup mux`, and `bd setup opencode` append a beads section to `AGENTS.md`, wrapped in `BEGIN/END BEADS INTEGRATION` HTML-comment markers. The begin marker carries version, profile, and hash metadata (e.g. `<!-- BEGIN BEADS INTEGRATION v:1 profile:full hash:19cc25d9 -->`) so `--check` can report `missing`, `stale`, or `current`; legacy markers without metadata are auto-upgraded on the next install or update. Re-running setup updates the existing section in place (idempotent), and `--remove` deletes only the managed section and the blank lines that set it off — the rest of your `AGENTS.md` is untouched. Running setup again after `--remove` appends the section to the end of the file after one blank line, so removing and re-adding it toggles between the same two files. The section `bd setup claude` and `bd setup gemini` manage in `CLAUDE.md` and `GEMINI.md` behaves the same way, except that in `~/.gemini/GEMINI.md` it goes ahead of the `## Gemini Added Memories` section older Gemini CLI releases keep there, so memories they save stay outside it.

`bd setup codex` uses its own marker pair (`BEGIN/END BEADS CODEX SETUP`). Running it alongside `bd setup factory` or `bd setup mux` against the same `AGENTS.md` leaves two managed sections side by side; each recipe's `--check` inspects only its own section, and each `--remove` removes only its own section.

One `AGENTS.md` works across many tools — Factory Droid, Mux, OpenCode, Cursor, Zed, Jules, and other AGENTS.md-aware assistants — so `bd setup factory` is a good starting point when your team mixes AI tools.

## Claude Code

The recommended approach for Claude Code:

```bash theme={null}
bd setup claude            # Project install: .claude/settings.json
bd setup claude --global   # Global install: ~/.claude/settings.json + ~/.claude/CLAUDE.md
```

This installs:

* **SessionStart hook** - Runs `bd prime --hook-json`, which wraps the workflow context in the JSON envelope Claude Code expects. SessionStart fires when a session starts, resumes, or clears, and again after context compaction — no separate compaction hook is needed.
* **Minimal beads section in `CLAUDE.md`** - A pointer to `bd prime`, managed with hash/version markers for safe updates and `--check` freshness detection. If `CLAUDE.md` is a thin stub that imports `AGENTS.md` (an `@AGENTS.md` line of its own), the section is written to `AGENTS.md` instead, and a stale beads block left in the stub by an older bd is removed. A `--global` install writes the section to your user-level `~/.claude/CLAUDE.md` and leaves the current directory's files alone. Claude Code loads that file in every project, so there the section applies only in repositories that use beads.

If the [beads Claude Code plugin](https://beads.gascity.com/integrations/claude-code-plugin.md) is enabled, its own hook runs `bd prime`, so `bd setup claude` skips writing one: Claude Code runs a plugin's hook beside a settings hook, and with both `bd prime` would fire twice per session. It reads the plugin's setting the way Claude Code does, from the first settings file that names it: managed settings, then `.claude/settings.local.json` (at the repository root, or the main checkout's root in a linked worktree), then the project's `.claude/settings.json`, then `~/.claude/settings.json`. So in a project that turns off a plugin your user settings enable, `bd setup claude` run there writes the hook; a `--global` install run there leaves the hook to the plugin and warns that the project needs `bd setup claude`. Whether teammates get the plugin is decided by the settings everyone shares, managed settings and the project's `.claude/settings.json`. When only your own settings enable it and the shared `.claude/settings.json` holds an older bare `bd prime` hook, `bd setup claude` replaces that hook with the current one rather than dropping it, since teammates without the plugin need it, and warns that `bd prime` runs twice per session for you. When the project's `.claude/settings.json` enables the plugin and only your `.claude/settings.local.json` turns it off, `bd setup claude` adds no hook to the shared file, where teammates with the plugin would run `bd prime` twice. It names the hook that already runs `bd prime` for you, keeping one in `.claude/settings.local.json`, or, when there is none, says how to run `bd prime` for yourself. A `--global` install skips the hook only when managed settings or `~/.claude/settings.json` enable the plugin, since a plugin enabled in a project's own settings runs in that project only. Run from such a project, `--global` still writes its hook for every other project, and there `bd prime` does fire twice per session; the install and `bd setup claude --check` say so and name the fix. To run it once there, turn the plugin off for yourself in that project's `.claude/settings.local.json`, or enable it in `~/.claude/settings.json` and remove the global hook with `bd setup claude --remove --global`, then run `bd setup claude --global` to put back the `~/.claude/CLAUDE.md` section.

**How it works:**

1. SessionStart hook runs `bd prime --hook-json` automatically
2. `bd prime` injects \~1-2k tokens of workflow context
3. You use `bd` CLI commands directly
4. Git hooks refresh exports and legacy fallbacks; Dolt remotes handle sync

**Flags:**

| Flag | Description |
| - | - |
| `--check` | Check both hooks and the managed `CLAUDE.md` beads section |
| `--remove` | Remove beads hooks and the managed `CLAUDE.md` beads section |
| `--global` | Install to `~/.claude/settings.json` and `~/.claude/CLAUDE.md` instead of the project |
| `--stealth` | Use `bd prime --stealth --hook-json` (flush only, no git operations) — useful in CI/CD where git operations might fail |

Restart Claude Code after installation for the hooks to take effect.

**Verify installation:**

```bash theme={null}
bd setup claude --check
```

### Manual Setup

If you prefer manual configuration, add the hook to your Claude Code settings:

```json theme={null}
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [
          { "type": "command", "command": "bd prime --hook-json" }
        ]
      }
    ]
  }
}
```

## Cursor IDE

```bash theme={null}
bd setup cursor            # Project install: rules file + agent skill + hooks
bd setup cursor --global   # Global install: hooks + agent skill (no rules file)
```

A project install writes three things:

* **`.cursor/rules/beads.mdc`** - an always-applied rules file that Cursor
  re-includes every turn.
* **`.agents/skills/beads/`** - the beads agent skill, the same one
  `bd setup codex` installs. `--remove` keeps it while the Codex integration
  still uses it.
* **`.cursor/hooks.json`** - `sessionStart`, `preCompact`, and `postToolUse`
  hooks that run `bd cursor-hook <event>`, so `bd` must be on `PATH` for
  Cursor. Your own entries in `hooks.json` are left alone.

`--global` writes the hooks to `~/.cursor/hooks.json` and the skill to
`~/.agents/skills/beads/`. Cursor has no file-based global rules location, so
add global rules in Cursor Settings or run `bd setup cursor` per project.

Restart Cursor (or start a new `cursor-agent` session) after installing.

**Verify:**

```bash theme={null}
bd setup cursor --check
```

See [Cursor](https://beads.gascity.com/integrations/cursor.md) for details.

## Gemini CLI

```bash theme={null}
bd setup gemini            # Global install: ~/.gemini/settings.json + ~/.gemini/GEMINI.md
bd setup gemini --project  # Project install: .gemini/settings.json + GEMINI.md
```

This installs a SessionStart hook running `bd prime --hook-json` — Gemini requires hook stdout to be valid JSON, and `--hook-json` wraps the markdown in the required envelope — plus a minimal beads section in your user-level `~/.gemini/GEMINI.md` (in the project's `GEMINI.md` with `--project`). Gemini CLI loads the user-level file in every project, so there the section applies only in repositories that use beads, and a global install leaves the current directory's files alone. Run from your home directory or from `~/.gemini`, `--project` is the global install: it uses `~/.gemini/settings.json` and `~/.gemini/GEMINI.md`, and does not create `~/GEMINI.md`. `--stealth` works the same as for Claude Code; `--check` and `--remove` cover both the hooks and the managed `GEMINI.md` section.

**Verify:**

```bash theme={null}
bd setup gemini --check
```

See [Gemini CLI](https://beads.gascity.com/integrations/gemini.md) for details.

## Aider

```bash theme={null}
# Setup Aider integration
bd setup aider
```

This writes three files:

| File | Purpose |
| - | - |
| `.aider.conf.yml` | Points Aider to read the instructions file |
| `.aider/BEADS.md` | Workflow instructions for the AI |
| `.aider/README.md` | Quick reference for humans |

Aider is human-in-the-loop: the AI **suggests** `bd` commands, and you run them with `/run`. See [Aider](https://beads.gascity.com/integrations/aider.md) for the workflow.

**Verify:**

```bash theme={null}
bd setup aider --check
```

## AGENTS.md Tools: Factory, Mux, OpenCode, Codex

```bash theme={null}
bd setup factory    # Factory.ai Droid — AGENTS.md section
bd setup mux        # Mux — AGENTS.md section (+ --project/--global layers)
bd setup opencode   # OpenCode — AGENTS.md section
bd setup codex      # Codex — beads skill + AGENTS.md guidance + native hooks
bd setup codex --global   # Same, under ~/.agents/skills/beads and $CODEX_HOME (or ~/.codex)
```

These create or update a managed section in `AGENTS.md` (see Managed Sections above). `bd init` runs the project Claude Code, Codex, and Cursor setup automatically unless `--skip-agents` or `--stealth` is used (or the repository is bare). In worktree, shared, or `BEADS_DIR` setups, use `bd where` to confirm the resolved workspace — these integrations do not require a local `./.beads`. Restart the tool after setup if it is already running.

Details: [Factory.ai Droid](https://beads.gascity.com/integrations/factory.md), [Mux](https://beads.gascity.com/integrations/mux.md), [OpenCode](https://beads.gascity.com/integrations/opencode.md), [Codex](https://beads.gascity.com/integrations/codex.md).

## GitHub Copilot

**Copilot CLI:**

```bash theme={null}
bd setup copilot
```

This installs a native Copilot CLI plugin manifest (`.copilot-plugin/plugin.json`, which registers `bd prime` hooks) and repository instructions (`.github/copilot-instructions.md`). See [Copilot CLI](https://beads.gascity.com/integrations/copilot-cli.md).

**For VS Code with GitHub Copilot**, use the MCP server:

```bash theme={null}
# Install MCP server
uv tool install beads-mcp
```

Create `.vscode/mcp.json` in your project:

```json theme={null}
{
  "servers": {
    "beads": {
      "command": "beads-mcp"
    }
  }
}
```

**For all projects:** Add to VS Code user-level MCP config:

| Platform | Path |
| - | - |
| macOS | `~/Library/Application Support/Code/User/mcp.json` |
| Linux | `~/.config/Code/User/mcp.json` |
| Windows | `%APPDATA%\Code\User\mcp.json` |

```json theme={null}
{
  "servers": {
    "beads": {
      "command": "beads-mcp",
      "args": []
    }
  }
}
```

Initialize beads and reload VS Code:

```bash theme={null}
bd init --quiet
```

See [GitHub Copilot Integration](https://beads.gascity.com/integrations/github-copilot.md) for detailed setup.

## Context Injection with `bd prime`

All integrations use `bd prime` to inject context:

```bash theme={null}
bd prime
```

This outputs a compact (\~1-2k tokens) workflow reference including:

* Available commands
* Current project status
* Workflow patterns
* Best practices
* Persistent memories from `bd remember`

`bd prime` prints memories near the top and starts with a truncation warning. If your host stores the full hook output in a file and only shows a preview, have the agent read the full file before continuing.

In hook contexts, `bd prime --hook-json` wraps the output in the SessionStart JSON envelope (Claude Code, Gemini CLI, Codex). For memory-only hooks:

```bash theme={null}
bd prime --memories-only
```

**Why context efficiency matters:**

* Compute cost scales with tokens
* Latency increases with context size
* Models attend better to smaller, focused contexts

## MCP Server (Alternative)

For MCP-only environments (Claude Desktop, no shell access):

```bash theme={null}
# Install MCP server
pip install beads-mcp
```

Add to Claude Desktop config:

```json theme={null}
{
  "mcpServers": {
    "beads": {
      "command": "beads-mcp"
    }
  }
}
```

**Trade-offs:**

* Works in MCP-only environments
* Higher context overhead (10-50k tokens for tool schemas)
* Additional latency from MCP protocol

See [MCP Server](https://beads.gascity.com/integrations/mcp-server.md) for detailed configuration.

## Custom Recipes

For editors or tools without a built-in recipe:

```bash theme={null}
bd setup --add myeditor .myeditor/rules.md   # Save a custom recipe
bd setup myeditor                            # Install it
bd setup myeditor --check                    # Check it
bd setup myeditor --remove                   # Remove it
```

Custom recipes are stored in `.beads/recipes.toml` (adding one requires an active beads workspace):

```toml theme={null}
[recipes.myeditor]
name = "myeditor"
path = ".myeditor/rules.md"
type = "file"
```

A recipe's `path` (or a `multifile` recipe's `paths`) must be a relative path inside the directory you run `bd setup` in: `bd setup` refuses a recipe, touching none of its files or directories, when a path is absolute, leaves that directory through `..`, leads out of it through a symbolic link (the directory holding the file included), or runs through a dangling or looping link, and `bd setup --add` does not save one. To write the template anywhere else, use `bd setup -o <path>`.

For a one-off install without saving a recipe, write the template to any path — or inspect it first:

```bash theme={null}
bd setup -o .my-custom-location/beads.md
bd setup --print
```

**Recipe types:**

| Type | Description | Used by |
| - | - | - |
| `file` | Write the template to a single file | windsurf, cody, kilocode, kiro, cursor (which also installs a skill and hooks) |
| `hooks` | Modify JSON settings to add hooks | claude, gemini |
| `section` | Inject a marked section into an existing file | factory, codex, mux, opencode |
| `multifile` | Write multiple files | aider, copilot, junie |

Custom recipes added via `--add` are always type `file`.

## Git Hooks

Ensure git hooks are installed for export refresh and legacy fallback behavior:

```bash theme={null}
bd hooks install
```

This installs:

* **pre-commit** - Runs chained hooks before commit
* **post-merge** - Runs chained hooks after pull/merge
* **pre-push** - Runs chained hooks before push
* **post-checkout** - Runs chained hooks after branch checkout
* **prepare-commit-msg** - Adds agent identity trailers for forensics

**Check hook status:**

```bash theme={null}
bd hooks list   # Installed, outdated, or missing
bd info         # Shows warnings if hooks are outdated
```

## Verifying Your Setup

Run a complete health check:

```bash theme={null}
# Check version
bd version

# Check project health (includes integration status)
bd doctor

# Check git hooks
bd hooks list

# Check editor integration
bd setup claude --check   # or cursor, gemini, aider, ...
```

**Troubleshooting:**

* *Hooks not working?* Restart your AI tool after installation, then re-run `bd setup claude --check` (or your tool's recipe) and check `bd doctor` output for integration status.
* *Context not appearing?* Make sure `bd prime` works standalone; if it fails, fix the underlying beads issue first.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
