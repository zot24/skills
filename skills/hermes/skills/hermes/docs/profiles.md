> Source: https://hermes-agent.nousresearch.com/docs/user-guide/profiles/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Profiles: Running Multiple Agents


Run multiple independent Hermes agents on the same machine — each with its own config, API keys, memory, sessions, skills, and gateway state.

## What are profiles?<a href="#what-are-profiles" class="hash-link" aria-label="Direct link to What are profiles?" translate="no" title="Direct link to What are profiles?">​</a>

A profile is a separate Hermes home directory. Each profile gets its own directory containing its own `config.yaml`, `.env`, `SOUL.md`, memories, sessions, skills, cron jobs, and state database. Profiles let you run separate agents for different purposes — a coding assistant, a personal bot, a research agent — without mixing up Hermes state.

When you create a profile, it automatically becomes its own command. Create a profile called `coder` and you immediately have `coder chat`, `coder setup`, `coder gateway start`, etc.

## Quick start<a href="#quick-start" class="hash-link" aria-label="Direct link to Quick start" translate="no" title="Direct link to Quick start">​</a>


``` prism-code
hermes profile create coder       # creates profile + "coder" command alias
coder setup                       # configure API keys and model
coder chat                        # start chatting
```


That's it. `coder` is now its own Hermes profile with its own config, memory, and state.

## Creating a profile<a href="#creating-a-profile" class="hash-link" aria-label="Direct link to Creating a profile" translate="no" title="Direct link to Creating a profile">​</a>

### Blank profile<a href="#blank-profile" class="hash-link" aria-label="Direct link to Blank profile" translate="no" title="Direct link to Blank profile">​</a>


``` prism-code
hermes profile create mybot
```


Creates a fresh profile with bundled skills seeded. Run `mybot setup` to configure API keys, model, and gateway tokens.

### Clone config only (`--clone`)<a href="#clone-config-only---clone" class="hash-link" aria-label="Direct link to clone-config-only---clone" translate="no" title="Direct link to clone-config-only---clone">​</a>


``` prism-code
hermes profile create work --clone
```


Copies your current profile's `config.yaml`, `.env`, and `SOUL.md` into the new profile. Same API keys and model, but fresh sessions and memory. Edit `~/.hermes/profiles/work/.env` for different API keys, or `~/.hermes/profiles/work/SOUL.md` for a different personality.

### Clone everything (`--clone-all`)<a href="#clone-everything---clone-all" class="hash-link" aria-label="Direct link to clone-everything---clone-all" translate="no" title="Direct link to clone-everything---clone-all">​</a>


``` prism-code
hermes profile create backup --clone-all
```


Copies **everything** — config, API keys, personality, all memories, full session history, skills, cron jobs, plugins. A complete snapshot. Useful for backups or forking an agent that already has context.

### Clone from a specific profile<a href="#clone-from-a-specific-profile" class="hash-link" aria-label="Direct link to Clone from a specific profile" translate="no" title="Direct link to Clone from a specific profile">​</a>


``` prism-code
hermes profile create work --clone --clone-from coder
```


When Honcho is enabled, `--clone` automatically creates a dedicated AI peer for the new profile while sharing the same user workspace. Each profile builds its own observations and identity. See [Honcho -- Multi-agent / Profiles](/docs/user-guide/features/memory-providers#honcho) for details.


## Using profiles<a href="#using-profiles" class="hash-link" aria-label="Direct link to Using profiles" translate="no" title="Direct link to Using profiles">​</a>

### Command aliases<a href="#command-aliases" class="hash-link" aria-label="Direct link to Command aliases" translate="no" title="Direct link to Command aliases">​</a>

Every profile automatically gets a command alias at `~/.local/bin/<name>`:


``` prism-code
coder chat                    # chat with the coder agent
coder setup                   # configure coder's settings
coder gateway start           # start coder's gateway
coder doctor                  # check coder's health
coder skills list             # list coder's skills
coder config set model.model anthropic/claude-sonnet-4
```


The alias works with every hermes subcommand — it's just `hermes -p <name>` under the hood.

### The `-p` flag<a href="#the--p-flag" class="hash-link" aria-label="Direct link to the--p-flag" translate="no" title="Direct link to the--p-flag">​</a>

You can also target a profile explicitly with any command:


``` prism-code
hermes -p coder chat
hermes --profile=coder doctor
hermes chat -p coder -q "hello"    # works in any position
```


### Sticky default (`hermes profile use`)<a href="#sticky-default-hermes-profile-use" class="hash-link" aria-label="Direct link to sticky-default-hermes-profile-use" translate="no" title="Direct link to sticky-default-hermes-profile-use">​</a>


``` prism-code
hermes profile use coder
hermes chat                   # now targets coder
hermes tools                  # configures coder's tools
hermes profile use default    # switch back
```


Sets a default so plain `hermes` commands target that profile. Like `kubectl config use-context`.

### Knowing where you are<a href="#knowing-where-you-are" class="hash-link" aria-label="Direct link to Knowing where you are" translate="no" title="Direct link to Knowing where you are">​</a>

The CLI always shows which profile is active:

- **Prompt**: `coder ❯` instead of `❯`
- **Banner**: Shows `Profile: coder` on startup
- **`hermes profile`**: Shows current profile name, path, model, gateway status

## Profiles vs workspaces vs sandboxing<a href="#profiles-vs-workspaces-vs-sandboxing" class="hash-link" aria-label="Direct link to Profiles vs workspaces vs sandboxing" translate="no" title="Direct link to Profiles vs workspaces vs sandboxing">​</a>

Profiles are often confused with workspaces or sandboxes, but they are different things:

- A **profile** gives Hermes its own state directory: `config.yaml`, `.env`, `SOUL.md`, sessions, memory, logs, cron jobs, and gateway state.
- A **workspace** or **working directory** is where terminal commands start. That is controlled separately by `terminal.cwd`.
- A **sandbox** is what limits filesystem access. Profiles do **not** sandbox the agent.

On the default `local` terminal backend, the agent still has the same filesystem access as your user account. A profile does not stop it from accessing folders outside the profile directory.

If you want a profile to start in a specific project folder, set an explicit absolute `terminal.cwd` in that profile's `config.yaml`:


``` prism-code
terminal:
  backend: local
  cwd: /absolute/path/to/project
```


Using `cwd: "."` on the local backend means "the directory Hermes was launched from", not "the profile directory".

Also note:

- `SOUL.md` can guide the model, but it does not enforce a workspace boundary.
- Changes to `SOUL.md` take effect cleanly on a new session. Existing sessions may still be using the old prompt state.
- Asking the model "what directory are you in?" is not a reliable isolation test. If you need a predictable starting directory for tools, set `terminal.cwd` explicitly.

## Running gateways<a href="#running-gateways" class="hash-link" aria-label="Direct link to Running gateways" translate="no" title="Direct link to Running gateways">​</a>

Each profile runs its own gateway as a separate process with its own bot token:


``` prism-code
coder gateway start           # starts coder's gateway
assistant gateway start       # starts assistant's gateway (separate process)
```


### Different bot tokens<a href="#different-bot-tokens" class="hash-link" aria-label="Direct link to Different bot tokens" translate="no" title="Direct link to Different bot tokens">​</a>

Each profile has its own `.env` file. Configure a different Telegram/Discord/Slack bot token in each:


``` prism-code
# Edit coder's tokens
nano ~/.hermes/profiles/coder/.env

# Edit assistant's tokens
nano ~/.hermes/profiles/assistant/.env
```


### Safety: token locks<a href="#safety-token-locks" class="hash-link" aria-label="Direct link to Safety: token locks" translate="no" title="Direct link to Safety: token locks">​</a>

If two profiles accidentally use the same bot token, the second gateway will be blocked with a clear error naming the conflicting profile. Supported for Telegram, Discord, Slack, WhatsApp, and Signal.

### Persistent services<a href="#persistent-services" class="hash-link" aria-label="Direct link to Persistent services" translate="no" title="Direct link to Persistent services">​</a>


``` prism-code
coder gateway install         # creates hermes-gateway-coder systemd/launchd service
assistant gateway install     # creates hermes-gateway-assistant service
```


Each profile gets its own service name. They run independently.

## Configuring profiles<a href="#configuring-profiles" class="hash-link" aria-label="Direct link to Configuring profiles" translate="no" title="Direct link to Configuring profiles">​</a>

Each profile has its own:

- **`config.yaml`** — model, provider, toolsets, all settings
- **`.env`** — API keys, bot tokens
- **`SOUL.md`** — personality and instructions


``` prism-code
coder config set model.model anthropic/claude-sonnet-4
echo "You are a focused coding assistant." > ~/.hermes/profiles/coder/SOUL.md
```


If you want this profile to work in a specific project by default, also set its own `terminal.cwd`:


``` prism-code
coder config set terminal.cwd /absolute/path/to/project
```


## Updating<a href="#updating" class="hash-link" aria-label="Direct link to Updating" translate="no" title="Direct link to Updating">​</a>

`hermes update` pulls code once (shared) and syncs new bundled skills to **all** profiles automatically:


``` prism-code
hermes update
# → Code updated (12 commits)
# → Skills synced: default (up to date), coder (+2 new), assistant (+2 new)
```


User-modified skills are never overwritten.

## Managing profiles<a href="#managing-profiles" class="hash-link" aria-label="Direct link to Managing profiles" translate="no" title="Direct link to Managing profiles">​</a>


``` prism-code
hermes profile list           # show all profiles with status
hermes profile show coder     # detailed info for one profile
hermes profile rename coder dev-bot   # rename (updates alias + service)
hermes profile export coder   # export to coder.tar.gz
hermes profile import coder.tar.gz   # import from archive
```


## Deleting a profile<a href="#deleting-a-profile" class="hash-link" aria-label="Direct link to Deleting a profile" translate="no" title="Direct link to Deleting a profile">​</a>


``` prism-code
hermes profile delete coder
```


This stops the gateway, removes the systemd/launchd service, removes the command alias, and deletes all profile data. You'll be asked to type the profile name to confirm.

Use `--yes` to skip confirmation: `hermes profile delete coder --yes`


You cannot delete the default profile (`~/.hermes`). To remove everything, use `hermes uninstall`.


## Tab completion<a href="#tab-completion" class="hash-link" aria-label="Direct link to Tab completion" translate="no" title="Direct link to Tab completion">​</a>


``` prism-code
# Bash
eval "$(hermes completion bash)"

# Zsh
eval "$(hermes completion zsh)"
```


Add the line to your `~/.bashrc` or `~/.zshrc` for persistent completion. Completes profile names after `-p`, profile subcommands, and top-level commands.

## How it works<a href="#how-it-works" class="hash-link" aria-label="Direct link to How it works" translate="no" title="Direct link to How it works">​</a>

Profiles use the `HERMES_HOME` environment variable. When you run `coder chat`, the wrapper script sets `HERMES_HOME=~/.hermes/profiles/coder` before launching hermes. Since 119+ files in the codebase resolve paths via `get_hermes_home()`, Hermes state automatically scopes to the profile's directory — config, sessions, memory, skills, state database, gateway PID, logs, and cron jobs.

This is separate from terminal working directory. Tool execution starts from `terminal.cwd` (or the launch directory when `cwd: "."` on the local backend), not automatically from `HERMES_HOME`.

The default profile is simply `~/.hermes` itself. No migration needed — existing installs work identically.


- <a href="#what-are-profiles" class="table-of-contents__link toc-highlight">What are profiles?</a>
- <a href="#quick-start" class="table-of-contents__link toc-highlight">Quick start</a>
- <a href="#creating-a-profile" class="table-of-contents__link toc-highlight">Creating a profile</a>
  - <a href="#blank-profile" class="table-of-contents__link toc-highlight">Blank profile</a>
  - <a href="#clone-config-only---clone" class="table-of-contents__link toc-highlight">Clone config only (<code>--clone</code>)</a>
  - <a href="#clone-everything---clone-all" class="table-of-contents__link toc-highlight">Clone everything (<code>--clone-all</code>)</a>
  - <a href="#clone-from-a-specific-profile" class="table-of-contents__link toc-highlight">Clone from a specific profile</a>
- <a href="#using-profiles" class="table-of-contents__link toc-highlight">Using profiles</a>
  - <a href="#command-aliases" class="table-of-contents__link toc-highlight">Command aliases</a>
  - <a href="#the--p-flag" class="table-of-contents__link toc-highlight">The <code>-p</code> flag</a>
  - <a href="#sticky-default-hermes-profile-use" class="table-of-contents__link toc-highlight">Sticky default (<code>hermes profile use</code>)</a>
  - <a href="#knowing-where-you-are" class="table-of-contents__link toc-highlight">Knowing where you are</a>
- <a href="#profiles-vs-workspaces-vs-sandboxing" class="table-of-contents__link toc-highlight">Profiles vs workspaces vs sandboxing</a>
- <a href="#running-gateways" class="table-of-contents__link toc-highlight">Running gateways</a>
  - <a href="#different-bot-tokens" class="table-of-contents__link toc-highlight">Different bot tokens</a>
  - <a href="#safety-token-locks" class="table-of-contents__link toc-highlight">Safety: token locks</a>
  - <a href="#persistent-services" class="table-of-contents__link toc-highlight">Persistent services</a>
- <a href="#configuring-profiles" class="table-of-contents__link toc-highlight">Configuring profiles</a>
- <a href="#updating" class="table-of-contents__link toc-highlight">Updating</a>
- <a href="#managing-profiles" class="table-of-contents__link toc-highlight">Managing profiles</a>
- <a href="#deleting-a-profile" class="table-of-contents__link toc-highlight">Deleting a profile</a>
- <a href="#tab-completion" class="table-of-contents__link toc-highlight">Tab completion</a>
- <a href="#how-it-works" class="table-of-contents__link toc-highlight">How it works</a>


