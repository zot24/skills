> Source: https://pi.dev/docs/latest/slash-commands



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Slash commands


Type `/` in Pi's terminal editor to search the commands available in the current session. This page lists the built-in commands in the current Pi release.

Extensions, prompt templates, and skills can add commands. The command menu in Pi is therefore the exact reference for the resources loaded in your session.


## Models and settings

<a href="#models-and-settings" class="heading-anchor" aria-label="Permalink: Models and settings" data-copy="" data-copy-text="https://pi.dev/docs/latest/slash-commands#models-and-settings"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Command                   | Description                                      |
|---------------------------|--------------------------------------------------|
| `/settings`               | Open settings                                    |
| `/model [provider/model]` | Select a model                                   |
| `/thinking [level]`       | Set the thinking level                           |
| `/scoped-models`          | Configure the models used by interactive cycling |
| `/login [provider]`       | Add provider authentication                      |
| `/logout`                 | Remove provider authentication                   |
| `/llama`                  | Manage models on the configured llama.cpp router |


## Sessions and context

<a href="#sessions-and-context" class="heading-anchor" aria-label="Permalink: Sessions and context" data-copy="" data-copy-text="https://pi.dev/docs/latest/slash-commands#sessions-and-context"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Command                   | Description                                                         |
|---------------------------|---------------------------------------------------------------------|
| `/new`                    | Start a new session                                                 |
| `/resume`                 | Switch to another saved session                                     |
| `/name [name]`            | Set the session display name, or show the current name when omitted |
| `/session`                | Show current session information and statistics                     |
| `/tree`                   | Navigate the session tree                                           |
| `/fork`                   | Create a new session from an earlier user message                   |
| `/clone`                  | Duplicate the current session at its current position               |
| `/compact [instructions]` | Compact the current context, optionally with custom instructions    |
| `/import <path>`          | Import and resume a JSONL session                                   |


## Export and share

<a href="#export-and-share" class="heading-anchor" aria-label="Permalink: Export and share" data-copy="" data-copy-text="https://pi.dev/docs/latest/slash-commands#export-and-share"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Command              | Description                                        |
|----------------------|----------------------------------------------------|
| `/copy`              | Copy the last assistant message                    |
| `/export [path]`     | Export the session as HTML or JSONL                |
| `/share`             | Upload the session and return a viewer link        |
| `/bug [description]` | Prepare a private bug report for the Pi developers |

Review a session before exporting or sharing it. Sessions can contain prompts, tool arguments, command output, file contents, and credentials exposed during the conversation.


## Runtime and project

<a href="#runtime-and-project" class="heading-anchor" aria-label="Permalink: Runtime and project" data-copy="" data-copy-text="https://pi.dev/docs/latest/slash-commands#runtime-and-project"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Command      | Description                                                                  |
|--------------|------------------------------------------------------------------------------|
| `/trust`     | Save a project trust decision for future Pi processes                        |
| `/reload`    | Reload keybindings, extensions, skills, templates, themes, and context files |
| `/hotkeys`   | Show active keyboard shortcuts                                               |
| `/changelog` | Show changelog entries                                                       |
| `/quit`      | Quit Pi                                                                      |


## Commands added by resources

<a href="#commands-added-by-resources" class="heading-anchor" aria-label="Permalink: Commands added by resources" data-copy="" data-copy-text="https://pi.dev/docs/latest/slash-commands#commands-added-by-resources"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- Extensions can register commands with their own arguments and completion behavior.
- Each prompt template is available under its template name.
- Skills are available as `/skill:name` when skill commands are enabled.

Use `/reload` after adding or changing a discovered command resource. See [Extensions](/docs/latest/extensions), [Prompt Templates](/docs/latest/prompt-templates), and [Skills](/docs/latest/skills) for their loading and naming rules.


