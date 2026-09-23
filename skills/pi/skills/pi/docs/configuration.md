> Source: https://pi.dev/docs/latest/configuration



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Configuration


Pi supports user-level and project configuration. User-level configuration lives in the agent directory, which defaults to `~/.pi/agent`. Project configuration lives in `.pi` under the working directory and loads after [project trust](/docs/latest/security#understand-project-trust) is granted. The only exception is `sessionDir`, which Pi reads before resolving trust so it can locate sessions.

In interactive mode, use `/settings` to change common preferences. For other options, ask Pi to update the configuration or edit the relevant files directly. Run `/reload` after manually changing settings, keybindings, instructions, or resources.


## Agent directory

<a href="#agent-directory" class="heading-anchor" aria-label="Permalink: Agent directory" data-copy="" data-copy-text="https://pi.dev/docs/latest/configuration#agent-directory"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


The agent directory is shown as `<agent-dir>` below. Set its location with the `PI_CODING_AGENT_DIR` environment variable or the SDK's [`agentDir`](/docs/latest/sdk) option.

| Path                                                                                    | Responsibility                                                                                                              |
|-----------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
| `<agent-dir>/settings.json`                                                             | User-level [settings](/docs/latest/settings), including preferences, defaults, resource paths, and Pi package declarations. |
| `<agent-dir>/keybindings.json`                                                          | Custom terminal UI and application [keybindings](/docs/latest/keybindings).                                                 |
| `<agent-dir>/models.json`                                                               | [Compatible endpoints, models, and model overrides](/docs/latest/models#configure-a-compatible-endpoint).                   |
| `<agent-dir>/auth.json`                                                                 | Saved API keys and OAuth credentials.                                                                                       |
| `<agent-dir>/AGENTS.override.md`, `AGENTS.md`, `AGENTS.MD`, `CLAUDE.md`, or `CLAUDE.MD` | User instructions applied across working directories.                                                                       |
| `<agent-dir>/SYSTEM.md`                                                                 | Replaces Pi’s default system prompt.                                                                                        |
| `<agent-dir>/APPEND_SYSTEM.md`                                                          | Adds instructions to Pi’s system prompt.                                                                                    |
| `<agent-dir>/extensions/`                                                               | User [extensions](/docs/latest/extensions).                                                                                 |
| `<agent-dir>/skills/`                                                                   | User [skills](/docs/latest/skills) and supporting files.                                                                    |
| `<agent-dir>/prompts/`                                                                  | User [prompt templates](/docs/latest/prompt-templates) exposed as slash commands.                                           |
| `<agent-dir>/themes/`                                                                   | User [theme](/docs/latest/themes) files.                                                                                    |


## Project `.pi` directory

<a href="#project-pi-directory" class="heading-anchor" aria-label="Permalink: Project .pi directory" data-copy="" data-copy-text="https://pi.dev/docs/latest/configuration#project-pi-directory"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Path                   | Responsibility                                                                                |
|------------------------|-----------------------------------------------------------------------------------------------|
| `.pi/settings.json`    | Project-level [settings](/docs/latest/settings), resource paths, and Pi package declarations. |
| `.pi/SYSTEM.md`        | Replaces the system prompt for the project.                                                   |
| `.pi/APPEND_SYSTEM.md` | Adds project-specific instructions to the system prompt.                                      |
| `.pi/extensions/`      | Project extensions.                                                                           |
| `.pi/skills/`          | Project skills and supporting files.                                                          |
| `.pi/prompts/`         | Project prompt templates exposed as slash commands.                                           |
| `.pi/themes/`          | Project theme files.                                                                          |

For `SYSTEM.md` and `APPEND_SYSTEM.md`, the trusted project file takes precedence over the corresponding agent-directory file. Files with the same name are not combined.


## Context files

<a href="#context-files" class="heading-anchor" aria-label="Permalink: Context files" data-copy="" data-copy-text="https://pi.dev/docs/latest/configuration#context-files"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Context files are separate from project `.pi` configuration. Pi loads them from the agent directory, the working directory, and its parent directories. A context file applies whenever Pi runs in its directory or anywhere below it.

An `AGENTS.override.md` replaces `AGENTS.md` or `CLAUDE.md` only in the same directory. It does not suppress context files from the agent directory or other directories.

Context-file discovery does not require project trust.


