> Source: https://pi.dev/docs/latest/usage



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Use Pi in the terminal


Run `pi` from the folder you want to work in. Pi uses that folder to discover files, instructions, and configuration, and to group saved sessions. If you have not installed Pi or chosen a model yet, follow the [Quickstart](/docs/latest/quickstart).

Pi may ask whether you trust the working folder before loading its project resources. See [Project trust](/docs/latest/security#understand-project-trust).

<img src="/docs/latest/images/interactive-mode.png" width="750" alt="Pi interactive mode showing a conversation, editor, and status information" />

The transcript shows your prompts, Pi's responses, tool calls, results, and errors. You write prompts and commands in the editor. The footer shows the current folder, session, model, context usage, and accumulated usage and cost.


## Enter a prompt

<a href="#enter-a-prompt" class="heading-anchor" aria-label="Permalink: Enter a prompt" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#enter-a-prompt"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Type a request and press `Enter` to send it. Use `Shift+Enter` to add a line, or press `Ctrl+G` to work on a longer prompt in your configured external editor.

To include files or images:

- Type `@` to search for a file and add it to your prompt.
- Press `Tab` to complete a path.
- Paste an image or drag it into a compatible terminal.


## Follow Pi's work

<a href="#follow-pis-work" class="heading-anchor" aria-label="Permalink: Follow Pi&#39;s work" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#follow-pis-work"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi shows each tool call and result while it works. Press `Ctrl+O` to expand or collapse tool output. Press `Ctrl+T` to show or hide thinking blocks.

The startup header lists the instructions and resources Pi loaded. The editor border indicates the current thinking level. The footer updates as the model uses context and reports usage.

Pi does not ask before every tool call. Review commands and changed files, and use a sandbox for untrusted or unattended work. See [Security](/docs/latest/security).


## Change direction

<a href="#change-direction" class="heading-anchor" aria-label="Permalink: Change direction" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#change-direction"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


You can send more input while Pi is working:

| What you want                        | Action                               |
|--------------------------------------|--------------------------------------|
| Adjust the current task              | Type a message and press `Enter`     |
| Add work after the current task      | Type a message and press `Alt+Enter` |
| Return queued messages to the editor | Press `Alt+Up`                       |
| Stop the current task                | Press `Escape`                       |

A message sent with `Enter` waits until the current response and its tool calls finish, then guides the next response. A follow-up sent with `Alt+Enter` waits until Pi finishes the current task. Aborting returns queued messages to the editor.

Windows Terminal reserves some Alt shortcuts. See [Terminal Setup](/docs/latest/terminal-setup) for the Windows alternatives.


## Change the model or settings

<a href="#change-the-model-or-settings" class="heading-anchor" aria-label="Permalink: Change the model or settings" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#change-the-model-or-settings"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Type `/` to search the available commands. The commands you will use most often are:

- `/model` selects a model. Press `Ctrl+L` to open the same selector.
- `/thinking` selects how much reasoning the current model uses. Press `Shift+Tab` to cycle through supported levels.
- `/login` and `/logout` manage provider access.
- `/settings` changes common preferences.

Prompt templates, skills, and extensions can add more commands to the same menu. See [Choose a Model](/docs/latest/models), [Configuration](/docs/latest/configuration), or the complete [Slash Commands reference](/docs/latest/slash-commands).


## Continue or start over

<a href="#continue-or-start-over" class="heading-anchor" aria-label="Permalink: Continue or start over" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#continue-or-start-over"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi saves sessions automatically unless session persistence is disabled.

- `/new` starts a new session.
- `/resume` opens another saved session.
- `/name` gives the current session a recognizable name.
- `/session` shows its file, ID, message count, token usage, and cost.

Use `/tree`, `/fork`, or `/clone` when you want to explore another approach without losing existing work. Use `/compact` to reduce the conversation history sent to the model. See [Sessions and Context](/docs/latest/sessions) for these workflows.

After leaving Pi, run `pi --continue` from the same folder to resume its most recent session.


## Run a terminal command

<a href="#run-a-terminal-command" class="heading-anchor" aria-label="Permalink: Run a terminal command" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#run-a-terminal-command"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Prefix a command with `!` to run it and include its output in the conversation:

``` text
!git status
```

Use `!!` when you want to run a command without sending its output to the model.


## Copy, export, or share results

<a href="#copy-export-or-share-results" class="heading-anchor" aria-label="Permalink: Copy, export, or share results" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#copy-export-or-share-results"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Press `Ctrl+X` or run `/copy` to copy the last assistant response. Use `/export` to save the session as HTML or JSONL.

Use `/share` to upload the session and get a viewer link. With Radius authentication, the artifact is visible to your Radius organization. Otherwise, Pi creates a private GitHub gist through the GitHub CLI. Review the session first because it can contain prompts, tool output, file contents, and credentials exposed during the conversation.


## Adjust the terminal

<a href="#adjust-the-terminal" class="heading-anchor" aria-label="Permalink: Adjust the terminal" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#adjust-the-terminal"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Regular mode uses the terminal's normal scrollback. Fullscreen mode keeps the editor and status area fixed while the transcript scrolls within the terminal window. Choose a mode through `/settings` or `--tui-mode`.

Terminal support for mouse input, keyboard shortcuts, and inline images varies. See [Terminal Setup](/docs/latest/terminal-setup) for platform-specific configuration and [Keybindings](/docs/latest/keybindings) for every configurable shortcut. Run `/hotkeys` to inspect the shortcuts active in your current session.


## Collect diagnostic information

<a href="#collect-diagnostic-information" class="heading-anchor" aria-label="Permalink: Collect diagnostic information" data-copy="" data-copy-text="https://pi.dev/docs/latest/usage#collect-diagnostic-information"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


When troubleshooting terminal rendering or conversation state, run `/debug`. Pi writes the rendered terminal lines and current session messages to `pi-debug.log` in your [agent directory](/docs/latest/configuration#agent-directory).

Review this file before sharing it. It can contain prompts, model responses, tool output, file contents, and terminal data.


