> Source: https://pi.dev/docs/latest/quickstart



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Quickstart


This page gets you from install to a useful first pi session.


## Install

<a href="#install" class="heading-anchor" aria-label="Permalink: Install" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#install"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi is distributed as an npm package:

``` bash
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
```

`--ignore-scripts` disables dependency lifecycle scripts during install. Pi does not require install scripts for normal npm installs.


### Uninstall

<a href="#uninstall" class="heading-anchor" aria-label="Permalink: Uninstall" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#uninstall"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Use the package manager that installed pi. The curl installer uses npm globally, so curl and npm installs are removed with npm:

``` bash
# curl installer or npm install -g
npm uninstall -g @earendil-works/pi-coding-agent

# pnpm
pnpm remove -g @earendil-works/pi-coding-agent

# Yarn
yarn global remove @earendil-works/pi-coding-agent

# Bun
bun uninstall -g @earendil-works/pi-coding-agent
```

Uninstalling pi leaves settings, credentials, sessions, and installed pi packages in `~/.pi/agent/`.

Then start pi in the project directory you want it to work on:

``` bash
cd /path/to/project
pi
```


## Authenticate

<a href="#authenticate" class="heading-anchor" aria-label="Permalink: Authenticate" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#authenticate"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi can use subscription providers through `/login`, or API-key providers through environment variables or the auth file.


### Option 1: subscription login

<a href="#option-1-subscription-login" class="heading-anchor" aria-label="Permalink: Option 1: subscription login" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#option-1-subscription-login"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Start pi and run:

``` text
/login
```

Then select a provider. Built-in subscription logins include Claude Pro/Max, ChatGPT Plus/Pro (Codex), and GitHub Copilot.


### Option 2: API key

<a href="#option-2-api-key" class="heading-anchor" aria-label="Permalink: Option 2: API key" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#option-2-api-key"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Set an API key before launching pi:

``` bash
export ANTHROPIC_API_KEY=sk-ant-...
pi
```

You can also run `/login` and select an API-key provider to store the key in `~/.pi/agent/auth.json`.

See [Providers](/docs/latest/providers) for all supported providers, environment variables, and cloud-provider setup.


## First session

<a href="#first-session" class="heading-anchor" aria-label="Permalink: First session" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#first-session"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Once pi starts, type a request and press Enter:

``` text
Summarize this repository and tell me how to run its checks.
```

By default, pi gives the model four tools:

- `read` - read files
- `write` - create or overwrite files
- `edit` - patch files
- `bash` - run shell commands

Additional built-in read-only tools (`grep`, `find`, `ls`) are available through tool options. Pi runs in your current working directory and can modify files there. Use git or another checkpointing workflow if you want easy rollback.


## Give pi project instructions

<a href="#give-pi-project-instructions" class="heading-anchor" aria-label="Permalink: Give pi project instructions" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#give-pi-project-instructions"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi loads context files at startup. Add an `AGENTS.md` file to tell it how to work in a project:

``` markdown
# Project Instructions

- Run `npm run check` after code changes.
- Do not run production migrations locally.
- Keep responses concise.
```

Pi loads:

- `~/.pi/agent/AGENTS.md` for global instructions
- `AGENTS.md` or `CLAUDE.md` from parent directories and the current directory

If a directory contains `AGENTS.override.md`, Pi loads it instead of `AGENTS.md` or `CLAUDE.md` from that directory.

Restart pi, or run `/reload`, after changing context files.


## Common things to try

<a href="#common-things-to-try" class="heading-anchor" aria-label="Permalink: Common things to try" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#common-things-to-try"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### Reference files

<a href="#reference-files" class="heading-anchor" aria-label="Permalink: Reference files" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#reference-files"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Type `@` in the editor to fuzzy-search files, or pass files on the command line:

``` bash
pi @README.md "Summarize this"
pi @src/app.ts @src/app.test.ts "Review these together"
```

Images or text can be pasted with Ctrl+V (Alt+V on Windows); images can also be dragged into supported terminals.


### Run shell commands

<a href="#run-shell-commands" class="heading-anchor" aria-label="Permalink: Run shell commands" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#run-shell-commands"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


In interactive mode:

``` text
!npm run lint
```

The command output is sent to the model. Use `!!command` to run a command without adding its output to the model context.


### Switch models

<a href="#switch-models" class="heading-anchor" aria-label="Permalink: Switch models" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#switch-models"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Use `/model` or Ctrl+L to choose a model. Use Shift+Tab to cycle thinking level. Use Ctrl+P / Shift+Ctrl+P to cycle through scoped models.


### Continue later

<a href="#continue-later" class="heading-anchor" aria-label="Permalink: Continue later" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#continue-later"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Sessions are saved automatically:

``` bash
pi -c                  # Continue most recent session
pi -r                  # Browse previous sessions
pi --name "my task"    # Set session display name at startup
pi --session <path|id> # Open a specific session
```

Inside pi, use `/resume`, `/new`, `/tree`, `/fork`, and `/clone` to manage sessions.


### Non-interactive mode

<a href="#non-interactive-mode" class="heading-anchor" aria-label="Permalink: Non-interactive mode" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#non-interactive-mode"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


For one-shot prompts:

``` bash
pi -p "Summarize this codebase"
cat README.md | pi -p "Summarize this text"
pi -p @screenshot.png "What's in this image?"
```

Use `--mode json` for JSON event output or `--mode rpc` for process integration.


## Next steps

<a href="#next-steps" class="heading-anchor" aria-label="Permalink: Next steps" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#next-steps"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- [Using Pi](/docs/latest/usage) - interactive mode, slash commands, sessions, context files, and CLI reference.
- [Providers](/docs/latest/providers) - authentication and model setup.
- [Settings](/docs/latest/settings) - global and project configuration.
- [Keybindings](/docs/latest/keybindings) - shortcuts and customization.
- [Pi Packages](/docs/latest/packages) - install shared extensions, skills, prompts, and themes.

Platform notes: [Windows](/docs/latest/windows), [Termux](/docs/latest/termux), [tmux](/docs/latest/tmux), [Terminal setup](/docs/latest/terminal-setup), [Shell aliases](/docs/latest/shell-aliases).


