> Source: https://pi.dev/docs/latest/usage



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Using Pi


This page collects day-to-day usage details that do not fit on the quickstart page.


## Interactive Mode

<a href="#interactive-mode" class="heading-anchor" aria-label="Permalink: Interactive Mode" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#interactive-mode"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


<img src="/docs/latest/images/interactive-mode.png" width="600" alt="Interactive Mode" />

The interface has four main areas:

- **Startup header** - shortcuts, loaded context files, prompt templates, skills, and extensions
- **Messages** - user messages, assistant responses, tool calls, tool results, notifications, errors, and extension UI
- **Editor** - where you type; border color indicates the current thinking level
- **Footer** - working directory, session name, token/cache usage, cost, context usage, and current model. Totals include assistant responses, usage reported by tools, and summary generation.

The editor can be replaced temporarily by built-in UI such as `/settings` or by custom extension UI.


### Editor Features

<a href="#editor-features" class="heading-anchor" aria-label="Permalink: Editor Features" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#editor-features"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Feature | How |
|----|----|
| File reference | Type `@` to fuzzy-search project files |
| Path completion | Press Tab to complete paths |
| Multi-line input | Shift+Enter, or Ctrl+Enter on Windows Terminal |
| Copy response | Ctrl+X copies the last assistant message; in `/tree`, it copies the selected message |
| Images | Paste with Ctrl+V, Alt+V on Windows, or drag into the terminal |
| Shell command | `!command` runs and sends output to the model |
| Hidden shell command | `!!command` runs without sending output to the model |
| External editor | Ctrl+G opens `externalEditor`, `$VISUAL`, `$EDITOR`, Notepad on Windows, or `nano` elsewhere |

See [Keybindings](/docs/latest/keybindings) for all shortcuts and customization.


## Slash Commands

<a href="#slash-commands" class="heading-anchor" aria-label="Permalink: Slash Commands" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#slash-commands"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Type `/` in the editor to open command completion. Extensions can register custom commands, skills are available as `/skill:name`, and prompt templates expand via `/templatename`.

| Command | Description |
|----|----|
| `/login`, `/logout` | Manage OAuth or API-key credentials |
| [`/llama`](/docs/latest/llama-cpp) | Download, load, and unload llama.cpp router models |
| `/model` | Switch models |
| `/scoped-models` | Enable/disable models for Ctrl+P cycling |
| `/settings` | Thinking level, theme, message delivery, transport |
| `/resume` | Pick from previous sessions |
| `/new` | Start a new session |
| `/name <name>` | Set session display name |
| `/session` | Show session file, ID, messages, tokens, and cost |
| `/tree` | Jump to any point in the session and continue from there |
| `/trust` | Save project trust decision for future sessions |
| `/fork` | Create a new session from a previous user message |
| `/clone` | Duplicate the current active branch into a new session |
| `/compact [prompt]` | Manually compact context, optionally with custom instructions |
| `/copy` | Copy last assistant message to clipboard |
| `/export [file]` | Export session to HTML or JSONL |
| `/import <file>` | Import and resume a session from a JSONL file |
| `/share` | Upload as private GitHub gist with shareable HTML link |
| `/reload` | Reload keybindings, extensions, skills, prompts, themes, and context files |
| `/hotkeys` | Show all keyboard shortcuts |
| `/changelog` | Display version history |
| `/quit` | Quit pi |


## Message Queue

<a href="#message-queue" class="heading-anchor" aria-label="Permalink: Message Queue" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#message-queue"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


You can submit messages while the agent is still working:

- **Enter** queues a steering message, delivered after the current assistant turn finishes executing its tool calls.
- **Alt+Enter** queues a follow-up message, delivered after the agent finishes all work.
- **Escape** aborts and restores queued messages to the editor.
- **Alt+Up** retrieves queued messages back to the editor.

On Windows Terminal, Alt+Enter is fullscreen by default. Remap it as described in [Terminal setup](/docs/latest/terminal-setup) if you want pi to receive the shortcut.

Configure delivery in [Settings](/docs/latest/settings) with `steeringMode` and `followUpMode`.


## Sessions

<a href="#sessions" class="heading-anchor" aria-label="Permalink: Sessions" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#sessions"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Sessions are saved automatically to `~/.pi/agent/sessions/`, organized by working directory.

``` bash
pi -c                  # Continue most recent session
pi -r                  # Browse and select a session
pi --no-session        # Ephemeral mode; do not save
pi --name "my task"    # Set session display name at startup
pi --session <path|id> # Use a specific session file or session ID
pi --fork <path|id>    # Fork a session into a new session file
```

Useful session commands:

- `/session` shows the current session file and ID.
- `/tree` navigates the in-file session tree and can summarize abandoned branches.
- `/fork` creates a new session from an earlier user message.
- `/clone` duplicates the current active branch into a new session file.
- `/compact` summarizes older messages to free context.

See [Sessions](/docs/latest/sessions) and [Compaction](/docs/latest/compaction) for details.


## Context Files

<a href="#context-files" class="heading-anchor" aria-label="Permalink: Context Files" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#context-files"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi loads `AGENTS.md` or `CLAUDE.md` at startup from:

- `~/.pi/agent/AGENTS.md` for global instructions
- parent directories, walking up from the current working directory
- the current directory

If a directory contains `AGENTS.override.md`, Pi loads it instead of `AGENTS.md` or `CLAUDE.md` from that directory. Context files from other directories still layer normally.

Use context files for project conventions, commands, safety rules, and preferences. Disable loading with `--no-context-files` or `-nc`.


### System Prompt Files

<a href="#system-prompt-files" class="heading-anchor" aria-label="Permalink: System Prompt Files" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#system-prompt-files"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Replace the default system prompt with:

- `.pi/SYSTEM.md` for a project
- `~/.pi/agent/SYSTEM.md` globally

Append to the default prompt without replacing it with `APPEND_SYSTEM.md` in either location.


### Project Trust

<a href="#project-trust" class="heading-anchor" aria-label="Permalink: Project Trust" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#project-trust"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


On interactive startup, pi asks before trusting a project folder that contains project-local settings, resources, or project `.agents/skills` and has no saved decision for the folder or a parent folder in `~/.pi/agent/trust.json`. Trusting a project allows pi to load `.pi/settings.json` and `.pi` resources, install missing project packages, and execute project extensions.

Before the trust decision, pi loads only context files, user/global extensions, and CLI `-e` extensions so they can handle the `project_trust` event. Project-local extensions, project package-managed extensions, and project settings are loaded only after the project is trusted. This split also applies when switching to a session from a different cwd whose trust has not been resolved in the current process.

Non-interactive modes (`-p`, `--mode json`, and `--mode rpc`) do not show a trust prompt. Without an applicable saved trust decision, they use `defaultProjectTrust` from global settings: `ask` (default) and `never` ignore those project resources, while `always` trusts them. Pass `--approve`/`-a` or `--no-approve`/`-na` to override project trust for one run.

If no extension or saved decision applies, `defaultProjectTrust` controls the fallback behavior. Set it to `"ask"`, `"always"`, or `"never"` in `~/.pi/agent/settings.json`, or change it with `/settings`.

`pi config` and package commands use the same project trust flow, except `pi update` never prompts. Pass `--approve` to trust project-local settings for one command or `--no-approve` to ignore them.

Use `/trust` in interactive mode to save a project trust decision for future sessions, including trust for the immediate parent folder. It writes `~/.pi/agent/trust.json` only; the current session is not reloaded, so restart pi for changes to take effect.


## Exporting and Sharing Sessions

<a href="#exporting-and-sharing-sessions" class="heading-anchor" aria-label="Permalink: Exporting and Sharing Sessions" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#exporting-and-sharing-sessions"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Use `/export [file]` to write a session to HTML.

Use `/share` to upload a private GitHub gist with a shareable HTML link.

If you use pi for open source work and want to publish sessions for model, prompt, tool, and evaluation research, see [`badlogic/pi-share-hf`](https://github.com/badlogic/pi-share-hf). It publishes sessions to Hugging Face datasets.


## CLI Reference

<a href="#cli-reference" class="heading-anchor" aria-label="Permalink: CLI Reference" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#cli-reference"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` bash
pi [options] [--] [@files...] [messages...]
```


### Package Commands

<a href="#package-commands" class="heading-anchor" aria-label="Permalink: Package Commands" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#package-commands"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` bash
pi install <source> [-l]     # Install package, -l for project-local
pi remove <source> [-l]      # Remove package
pi uninstall <source> [-l]   # Alias for remove
pi update [source|self|pi]   # Update pi only, or one package source
pi update --all              # Update pi and packages; reconcile pinned git refs
pi update --extensions       # Update packages only; reconcile pinned git refs
pi update --models           # Refresh model catalogs only
pi update --self             # Update pi only
pi update --extension <src>  # Update one package
pi list                      # List installed packages
pi config                    # Enable/disable package resources
```

These commands manage pi packages and `pi update` can update the pi CLI installation. To uninstall pi itself, see [Quickstart](/docs/latest/quickstart#uninstall). `pi config` and project package commands accept `--approve`/`--no-approve` to trust or ignore project-local settings for one command. `pi update` never prompts for project trust.

See [Pi Packages](/docs/latest/packages) for package sources and security notes.


### Modes

<a href="#modes" class="heading-anchor" aria-label="Permalink: Modes" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#modes"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Flag | Description |
|----|----|
| default | Interactive mode |
| `-p`, `--print` | Print response and exit |
| `--mode json` | Output all events as JSON lines; see [JSON mode](/docs/latest/json) |
| `--mode rpc` | RPC mode over stdin/stdout; see [RPC mode](/docs/latest/rpc) |
| `--export <in> [out]` | Export a session to HTML |

In print mode, pi also reads piped stdin and merges it into the initial prompt:

``` bash
cat README.md | pi -p "Summarize this text"
```


### Model Options

<a href="#model-options" class="heading-anchor" aria-label="Permalink: Model Options" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#model-options"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Option | Description |
|----|----|
| `--provider <name>` | Provider, such as `anthropic`, `openai`, or `google` |
| `--model <pattern>` | Model pattern or ID; supports `provider/id` and optional `:<thinking>` |
| `--api-key <key>` | API key, overriding environment variables |
| `--thinking <level>` | `off`, `minimal`, `low`, `medium`, `high`, `xhigh`, `max` |
| `--models <patterns>` | Comma-separated patterns for Ctrl+P cycling |
| `--list-models [search]` | List available models |


### Session Options

<a href="#session-options" class="heading-anchor" aria-label="Permalink: Session Options" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#session-options"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Option | Description |
|----|----|
| `-c`, `--continue` | Continue the most recent session |
| `-r`, `--resume` | Browse and select a session |
| `--session <path|id>` | Use a specific session file or partial UUID |
| `--fork <path|id>` | Fork a session file or partial UUID into a new session |
| `--session-dir <dir>` | Custom session storage directory |
| `--no-session` | Ephemeral mode; do not save |
| `--name <name>`, `-n <name>` | Set session display name at startup |


### Tool Options

<a href="#tool-options" class="heading-anchor" aria-label="Permalink: Tool Options" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#tool-options"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Option | Description |
|----|----|
| `--tools <list>`, `-t <list>` | Allowlist specific built-in, extension, and custom tools |
| `--exclude-tools <list>`, `-xt <list>` | Disable specific built-in, extension, and custom tools |
| `--no-builtin-tools`, `-nbt` | Disable built-in tools but keep extension/custom tools enabled |
| `--no-tools`, `-nt` | Disable all tools |

Built-in tools: `read`, `bash`, `edit`, `write`, `grep`, `find`, `ls`.


### Resource Options

<a href="#resource-options" class="heading-anchor" aria-label="Permalink: Resource Options" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#resource-options"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Option | Description |
|----|----|
| `-e`, `--extension <source>` | Load an extension from path, npm, or git; repeatable |
| `--no-extensions` | Disable extension discovery |
| `--skill <path>` | Load a skill; repeatable |
| `--no-skills` | Disable skill discovery |
| `--prompt-template <path>` | Load a prompt template; repeatable |
| `--no-prompt-templates` | Disable prompt template discovery |
| `--theme <path>` | Load a theme; repeatable |
| `--no-themes` | Disable theme discovery |
| `--no-context-files`, `-nc` | Disable `AGENTS.md` and `CLAUDE.md` discovery |

Combine `--no-*` with explicit flags to load exactly what you need, ignoring settings. Example:

``` bash
pi --no-extensions -e ./my-extension.ts
```


### Other Options

<a href="#other-options" class="heading-anchor" aria-label="Permalink: Other Options" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#other-options"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Option | Description |
|----|----|
| `--system-prompt <text>` | Replace default prompt; context files and skills are still appended |
| `--append-system-prompt <text>` | Append to system prompt |
| `--tui-mode <mode>` | TUI mode: `regular` (default) or experimental `fullscreen` |
| `--use-theme <name[/name]>` | Set the initial interactive theme for this run without changing settings |
| `--verbose` | Force verbose startup |
| `-a`, `--approve` | Trust project-local files for this run |
| `-na`, `--no-approve` | Ignore project-local files for this run |
| `--` | Stop option parsing; remaining arguments are prompts or `@file` inputs |
| `-h`, `--help` | Show help |
| `-v`, `--version` | Show version |

In `fullscreen` mode, the transcript scrolls inside the terminal viewport while queued messages, working status, extension widgets, editor, and footer remain fixed at the bottom. Mouse/trackpad input scrolls the region under the pointer; keyboard viewport actions always remain available. Inline images work in terminals that support the Kitty graphics protocol, including Kitty and Ghostty. In iTerm2 they render as text placeholders because its inline-image protocol cannot delete or crop placements during application-owned scrolling. In `regular` mode, pi uses the main screen and terminal-owned scrollback, and iTerm2 inline images continue to render normally. See [Terminal setup](/docs/latest/terminal-setup) for terminal-specific settings and workarounds.

Set **TUI mode** in `/settings` to switch between `regular` and `fullscreen` immediately and choose the default for future sessions. **Fullscreen exit output** controls whether exiting fullscreen prints the final transcript or restores the previous screen and prints only the session resume hint.


### File Arguments

<a href="#file-arguments" class="heading-anchor" aria-label="Permalink: File Arguments" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#file-arguments"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Prefix files with `@` to include them in the message:

``` bash
pi @prompt.md "Answer this"
pi -p @screenshot.png "What's in this image?"
pi @code.ts @test.ts "Review these files"
```


### Examples

<a href="#examples" class="heading-anchor" aria-label="Permalink: Examples" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#examples"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` bash
# Interactive with initial prompt
pi "List all .ts files in src/"

# Non-interactive
pi -p "Summarize this codebase"

# Prompt beginning with a dash
pi -p -- "- Summarize these points"

# Non-interactive with piped stdin
cat README.md | pi -p "Summarize this text"

# Named one-shot session
pi --name "release audit" -p "Audit this repository"

# Different model
pi --provider openai --model gpt-4o "Help me refactor"

# Model with provider prefix
pi --model openai/gpt-4o "Help me refactor"

# Model with thinking level shorthand
pi --model sonnet:high "Solve this complex problem"

# Limit model cycling
pi --models "claude-*,gpt-4o"

# Read-only mode
pi --tools read,grep,find,ls -p "Review the code"

# Disable one extension or built-in tool while keeping the rest available
pi --exclude-tools ask_question
```


## Design Principles

<a href="#design-principles" class="heading-anchor" aria-label="Permalink: Design Principles" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#design-principles"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi keeps the core small and pushes workflow-specific behavior into extensions, skills, prompt templates, and packages.

It intentionally does not include built-in MCP, sub-agents, permission popups, plan mode, to-dos, or background bash. You can build or install those workflows as extensions or packages, or use external tools such as containers and tmux.

For the full rationale, read the [blog post](https://mariozechner.at/posts/2025-11-30-pi-coding-agent/).


