> Source: https://pi.dev/docs/latest/configuration



# Configuration


Pi supports user-level and project configuration. User-level configuration lives in the agent directory, which defaults to `~/.pi/agent`. Project configuration lives in `.pi` under the working directory and loads after <a href="/latest/security#understand-project-trust" class="link-module_root__svb26">project trust</a> is granted. The only exception is `sessionDir`, which Pi reads before resolving trust so it can locate sessions.

In interactive mode, use `/settings` to change common preferences. For other options, ask Pi to update the configuration or edit the relevant files directly. Run `/reload` after manually changing settings, keybindings, instructions, or resources.


## Agent directory


The agent directory is shown as `<agent-dir>` below. Set its location with the `PI_CODING_AGENT_DIR` environment variable or the SDK's <a href="/latest/sdk" class="link-module_root__svb26"><code class="inline-code-module_root__fGvLx" data-variant="soft">agentDir</code></a> option.


| Path | Responsibility |
|----|----|
| `<agent-dir>/settings.json` | User-level <a href="/latest/settings" class="link-module_root__svb26">settings</a>, including preferences, defaults, resource paths, and Pi package declarations. |
| `<agent-dir>/keybindings.json` | Custom terminal UI and application <a href="/latest/keybindings" class="link-module_root__svb26">keybindings</a>. |
| `<agent-dir>/mcp.json` | <a href="/latest/mcp" class="link-module_root__svb26">MCP servers</a> available in every project. |
| `<agent-dir>/models.json` | <a href="/latest/models#configure-a-compatible-endpoint" class="link-module_root__svb26">Compatible endpoints, models, and model overrides</a>. |
| `<agent-dir>/auth.json` | Saved API keys and OAuth credentials. |
| `<agent-dir>/AGENTS.override.md`, `AGENTS.md`, `AGENTS.MD`, `CLAUDE.md`, or `CLAUDE.MD` | User instructions applied across working directories. |
| `<agent-dir>/SYSTEM.md` | Replaces Pi’s default system prompt. |
| `<agent-dir>/APPEND_SYSTEM.md` | Adds instructions to Pi’s system prompt. |
| `<agent-dir>/extensions/` | User <a href="/latest/extensions" class="link-module_root__svb26">extensions</a>. |
| `<agent-dir>/skills/` | User <a href="/latest/skills" class="link-module_root__svb26">skills</a> and supporting files. |
| `<agent-dir>/prompts/` | User <a href="/latest/prompt-templates" class="link-module_root__svb26">prompt templates</a> exposed as slash commands. |
| `<agent-dir>/themes/` | User <a href="/latest/themes" class="link-module_root__svb26">theme</a> files. |


## Project `.pi` directory


| Path | Responsibility |
|----|----|
| `.pi/settings.json` | Project-level <a href="/latest/settings" class="link-module_root__svb26">settings</a>, resource paths, and Pi package declarations. |
| `.pi/mcp.json` | Project <a href="/latest/mcp" class="link-module_root__svb26">MCP servers</a>. |
| `.pi/SYSTEM.md` | Replaces the system prompt for the project. |
| `.pi/APPEND_SYSTEM.md` | Adds project-specific instructions to the system prompt. |
| `.pi/extensions/` | Project extensions. |
| `.pi/skills/` | Project skills and supporting files. |
| `.pi/prompts/` | Project prompt templates exposed as slash commands. |
| `.pi/themes/` | Project theme files. |


For `SYSTEM.md` and `APPEND_SYSTEM.md`, the trusted project file takes precedence over the corresponding agent-directory file. Files with the same name are not combined.


## Context files


Context files are separate from project `.pi` configuration. Pi loads them from the agent directory, the working directory, and its parent directories. A context file applies whenever Pi runs in its directory or anywhere below it.

An `AGENTS.override.md` replaces `AGENTS.md` or `CLAUDE.md` only in the same directory. It does not suppress context files from the agent directory or other directories.

Context-file discovery does not require project trust.


