> Source: https://pi.dev/docs/latest/cli



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Command Line


This page documents Pi's built-in command-line commands and options. Run `pi --help` or append `--help` to a command for the exact interface in your installed version. The top-level help also includes options registered by loaded extensions.

``` sh
pi [options] [--] [@files...] [messages...]
pi install <source> [options]
pi remove <source> [options]
pi uninstall <source> [options]
pi update [target] [options]
pi list
pi config [options]
pi auth <check|print-api-key|print-bearer-token> [options]
```


## Invocation and output

<a href="#invocation-and-output" class="heading-anchor" aria-label="Permalink: Invocation and output" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli#invocation-and-output"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` sh
pi
pi --print "Summarize this repository"
git diff | pi --print "Review this change"
pi --mode json "Inspect this repository" > events.jsonl
```

With terminal stdin and stdout, Pi opens the terminal UI unless `--print`, `--mode json`, or `--mode rpc` selects another interface. When either stream is redirected and neither JSON nor RPC mode is selected, Pi uses print mode. See [CLI Integration](/docs/latest/cli-integration) for choosing between interactive, print, JSON, RPC, and SDK integration.

| Input       | Behavior                                           |
|-------------|----------------------------------------------------|
| `message`   | Provide an initial prompt                          |
| `@path`     | Include a text file or image in the first prompt   |
| Piped stdin | Prepend its contents to the first prompt           |
| `--`        | Stop option parsing so a prompt can begin with `-` |

Pi resolves `@path` from the current working directory. The working directory also controls project configuration, resource discovery, and session grouping.

`--print` controls whether Pi runs once and exits. `--mode` selects the output interface. `--mode text` does not force one-shot execution when stdin and stdout are terminals; use `--print` for that behavior.

| Option                      | Behavior                                                                                |
|-----------------------------|-----------------------------------------------------------------------------------------|
| `-p`, `--print`             | Run the supplied prompts, write the final assistant text to stdout, then exit           |
| `--mode text`               | Select text output; still open the terminal UI when stdin and stdout are terminals      |
| `--mode json`               | Run the supplied prompts, write JSONL events to stdout, then exit                       |
| `--mode rpc`                | Read JSONL commands from stdin and write responses and events to stdout until shutdown  |
| `--export <input> [output]` | Export a session file to HTML and exit; derive the destination when `output` is omitted |

RPC mode rejects `@file` arguments. JSON and RPC modes reserve stdout for protocol records. See [JSON Event Stream](/docs/latest/json) and [RPC Protocol](/docs/latest/rpc).


## Models

<a href="#models" class="heading-anchor" aria-label="Permalink: Models" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli#models"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` sh
pi --model sonnet:high
```

See [Choose a Model](/docs/latest/models) for model selection and [Provider Authentication](/docs/latest/providers) for credentials.

- `--provider <name>`  
  Restricts `--model` lookup to one provider.
- `--model <pattern>`  
  Selects by exact ID or fuzzy ID/name match. It accepts `provider/id` and an optional `:<thinking>` suffix.
- `--api-key <key>`  
  Uses a non-persistent API-key override. It requires a model selected through `--model` or `--models`.
- `--thinking <level>`  
  Sets `off`, `minimal`, `low`, `medium`, `high`, `xhigh`, or `max`. It overrides a `--model` suffix and is clamped to the model's capabilities.
- `--models <patterns>`  
  Sets a comma-separated scope for startup and cycling. It accepts exact IDs, fuzzy matches, case-insensitive globs, and optional `:<thinking>` suffixes.
- `--list-models [search]`  
  Lists available models, optionally filtered by a fuzzy search, then exits.


## Sessions

<a href="#sessions" class="heading-anchor" aria-label="Permalink: Sessions" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli#sessions"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` sh
pi --continue
```

See [Sessions and Context](/docs/latest/sessions) for resuming, forking, naming, and storing sessions.

- `-c`, `--continue`  
  Continues the most recent session for the current project.
- `-r`, `--resume`  
  Opens the session selector.
- `--session <path|id>`  
  Opens by file path, exact ID, or partial ID. Pi searches the current project first and offers to fork a cross-project match.
- `--session-id <id>`  
  Opens the exact project session ID or creates it if absent. IDs accept letters, numbers, `.`, `_`, and `-`.
- `--fork <path|id>`  
  Forks an existing session into a new session for the current project.
- `--session-dir <dir>`  
  Overrides storage and lookup. It takes precedence over `PI_CODING_AGENT_SESSION_DIR` and the `sessionDir` setting.
- `--no-session`  
  Uses an in-memory session that is not persisted.
- `-n`, `--name <name>`  
  Sets the session display name.

Constraints:

- Session IDs must start and end with a letter or number.
- `--fork` cannot be combined with `--session`, `--continue`, `--resume`, or `--no-session`.
- `--session-id` cannot be combined with `--session`, `--continue`, or `--resume`. Combine it with `--fork` to choose the new ID.


## Tools

<a href="#tools" class="heading-anchor" aria-label="Permalink: Tools" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli#tools"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` sh
pi --tools read,grep,find,ls --print "Review this project"
```

See [Settings](/docs/latest/settings#tools) for configuring the default tool selection.

- `-t`, `--tools <list>`  
  Replaces the default selection with a comma-separated allowlist of built-in, extension, or custom tools.
- `-xt`, `--exclude-tools <list>`  
  Disables comma-separated tool names after all other selection options.
- `-nbt`, `--no-builtin-tools`  
  Disables default built-in tools while retaining extension and custom tools.
- `-nt`, `--no-tools`  
  Starts with all built-in, extension, and custom tools disabled.

Default enabled tools are `read`, `bash`, `edit`, and `write`, unless `defaultTools` changes them.

| Built-in     | Purpose                                           |
|--------------|---------------------------------------------------|
| `read`       | Read text files and supported images              |
| `bash`       | Run shell commands                                |
| `powershell` | Run PowerShell commands on Windows                |
| `edit`       | Apply exact text replacements to an existing file |
| `write`      | Create or overwrite a file                        |
| `grep`       | Search file contents                              |
| `find`       | Find paths using glob patterns                    |
| `ls`         | List directory contents                           |


## Resources

<a href="#resources" class="heading-anchor" aria-label="Permalink: Resources" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli#resources"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` sh
pi --extension ./review.ts
```

See [Configuration](/docs/latest/configuration) for conventional directories and project trust, [Settings](/docs/latest/settings#resources) for configured paths, and [Pi Packages](/docs/latest/packages) for package sources.

- `-e`, `--extension <path>`  
  Loads an extension file or directory and is repeatable.
- `-ne`, `--no-extensions`  
  Disables discovered and configured extensions. Explicit `-e` paths still load.
- `--skill <path>`  
  Loads a skill file or directory and is repeatable.
- `-ns`, `--no-skills`  
  Disables discovered and configured skills. Explicit `--skill` paths still load.
- `--prompt-template <path>`  
  Loads a prompt-template file or directory and is repeatable.
- `-np`, `--no-prompt-templates`  
  Disables discovered and configured templates. Explicit `--prompt-template` paths still load.
- `--theme <path>`  
  Loads a theme file or directory and is repeatable.
- `--use-theme <name[/name]>`  
  Selects the initial interactive theme for this run.
- `--no-themes`  
  Disables discovered and configured themes. Explicit `--theme` paths still load.
- `-nc`, `--no-context-files`  
  Disables `AGENTS.md` and `CLAUDE.md` discovery.

Resource paths apply only to the current process. Relative paths resolve from the current working directory.


## Prompts and process

<a href="#prompts-and-process" class="heading-anchor" aria-label="Permalink: Prompts and process" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli#prompts-and-process"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` sh
pi --append-system-prompt ./instructions.md
```

See [Configuration](/docs/latest/configuration) for saved configuration, [Security](/docs/latest/security#understand-project-trust) for project trust, and [Environment Variables](/docs/latest/environment-variables) for process controls.

- `--system-prompt <text|path>`  
  Replaces the default system prompt with text or the contents of an existing file.
- `--append-system-prompt <text|path>`  
  Appends text or an existing file to the system prompt and is repeatable.
- `--tui-mode <mode>`  
  Uses `regular` or `fullscreen` terminal mode.
- `--verbose`  
  Shows verbose interactive startup information, overriding `quietStartup`.
- `-a`, `--approve`  
  Trusts project-local configuration and resources for this process.
- `-na`, `--no-approve`  
  Ignores trust-gated project-local configuration and resources for this process.
- `--offline`  
  Disables automatic network activity, including model catalog refreshes. Equivalent to `PI_OFFLINE=1`.
- `-h`, `--help`  
  Shows help, including flags registered by loaded extensions, then exits.
- `-v`, `--version`  
  Shows the Pi version, then exits.

Extensions may register additional long-form options. Unknown short options are rejected.


## Package commands

<a href="#package-commands" class="heading-anchor" aria-label="Permalink: Package commands" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli#package-commands"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` sh
pi install npm:@scope/package
```

See [Pi Packages](/docs/latest/packages) for source formats, filtering, installation, and project scope.


### Common tasks

<a href="#common-tasks" class="heading-anchor" aria-label="Permalink: Common tasks" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli#common-tasks"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Task                                    | Command               |
|-----------------------------------------|-----------------------|
| Install a package                       | `pi install <source>` |
| List configured packages                | `pi list`             |
| Remove a package and its settings entry | `pi remove <source>`  |
| Configure which package resources load  | `pi config`           |

Add `--local` or `-l` to `install`, `remove`, `uninstall`, or `config` to use project settings instead of global settings.


### Update Pi or packages

<a href="#update-pi-or-packages" class="heading-anchor" aria-label="Permalink: Update Pi or packages" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli#update-pi-or-packages"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Running `pi update` without a target updates Pi itself.

| Task                                 | Command                  |
|--------------------------------------|--------------------------|
| Update Pi                            | `pi update`              |
| Update all installed packages        | `pi update --extensions` |
| Update one installed package         | `pi update <source>`     |
| Refresh model catalogs               | `pi update --models`     |
| Update Pi and all installed packages | `pi update --all`        |

Add `--force` to reinstall Pi when the selected update includes Pi.


### Aliases and command options

<a href="#aliases-and-command-options" class="heading-anchor" aria-label="Permalink: Aliases and command options" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli#aliases-and-command-options"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- `pi uninstall <source>` is an alias for `pi remove <source>`.
- `pi update --self`, `pi update self`, and `pi update pi` are aliases for `pi update`.
- `pi update --extension <source>` is an alias for `pi update <source>`.
- `-a`, `--approve` trusts project-local files for one command. `-na`, `--no-approve` ignores trust-gated project-local files.
- Append `-h` or `--help` to a command for its exact usage and option constraints.


## Credential commands

<a href="#credential-commands" class="heading-anchor" aria-label="Permalink: Credential commands" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli#credential-commands"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` sh
pi auth check --provider openai --json
```

Authentication commands require `--provider <provider>` or `--model <model>`. See [Provider Authentication](/docs/latest/providers) for supported methods.

| Command                      | Description                                                                               |
|------------------------------|-------------------------------------------------------------------------------------------|
| `pi auth check`              | Print `ready`, `not_ready`, or `invalid`; exit with status `0`, `1`, or `2`, respectively |
| `pi auth print-api-key`      | Print the resolved API key                                                                |
| `pi auth print-bearer-token` | Print a resolved OAuth bearer token                                                       |

| Option                    | Applies to           | Description                                                                  |
|---------------------------|----------------------|------------------------------------------------------------------------------|
| `--provider <provider>`   | All                  | Resolve credentials for a provider                                           |
| `--model <model>`         | All                  | Resolve credentials from a model; may be combined with `--provider`          |
| `--json`                  | `auth check`         | Write the structured result as JSON                                          |
| `--credentials`           | `auth check`         | Emit the resolved credential when ready                                      |
| `--no-refresh`            | `auth check`         | Do not refresh expired OAuth credentials; refresh is the default             |
| `--min-expiry <duration>` | `print-bearer-token` | Require remaining token lifetime using `ms`, `s`, `m`, or `h`, such as `30m` |

Credential-printing commands write secrets to stdout.


