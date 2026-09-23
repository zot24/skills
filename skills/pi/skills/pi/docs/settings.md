> Source: https://pi.dev/docs/latest/settings



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Settings Reference


This reference lists user-configurable settings, their types, defaults, and purposes. Project settings override agent-directory settings. Resource lists are combined. See [Configuration](/docs/latest/configuration) for file locations and trust behavior.


## Model and thinking

<a href="#model-and-thinking" class="heading-anchor" aria-label="Permalink: Model and thinking" data-copy="" data-copy-text="https://pi.dev/docs/latest/settings#model-and-thinking"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Setting                | Type                                                              | Default              | Description                                                                                                        |
|------------------------|-------------------------------------------------------------------|----------------------|--------------------------------------------------------------------------------------------------------------------|
| `defaultProvider`      | string                                                            | Automatic            | Startup AI provider.                                                                                               |
| `defaultModel`         | string                                                            | Automatic            | Startup model ID.                                                                                                  |
| `defaultThinkingLevel` | `"off" | "minimal" | "low" | "medium" | "high" | "xhigh" | "max"` | `"medium"`           | Startup thinking level.                                                                                            |
| `modelThinkingLevels`  | object                                                            | None                 | Per-model startup thinking levels keyed by exact `provider/modelId`.                                               |
| `thinkingBudgets`      | object                                                            | Built-in budgets     | Token budgets for `minimal`, `low`, `medium`, and `high` thinking levels.                                          |
| `enabledModels`        | `string[]`                                                        | All available models | Model patterns used for startup selection and model cycling. Uses the same format as `--models`.                   |
| `hideThinkingBlock`    | boolean                                                           | `false`              | Hide thinking blocks in the transcript.                                                                            |
| `showCacheMissNotices` | boolean                                                           | `false`              | Show notices for significant cache misses, successful cache warming, compaction usage, and provider recovery.      |
| `cacheWarming`         | `"off" | "streaming" | "idle"`                                    | `"streaming"`        | Keep eligible provider prompt caches warm during active runs or, with `"idle"`, between runs. Global setting only. |

Cache warming runs only when the model declares a cache lifetime and Pi estimates at least \$0.05 in avoided cache-miss cost. Refresh usage counts toward session totals but does not enter model context. `/session` shows the next decision; extensions can override it with `cache_warming_decision`. See [Prompt Cache Lifetimes](/docs/latest/models#prompt-cache-lifetimes).

See [Choose a Model](/docs/latest/models) for model selection and thinking controls.


## Interaction

<a href="#interaction" class="heading-anchor" aria-label="Permalink: Interaction" data-copy="" data-copy-text="https://pi.dev/docs/latest/settings#interaction"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Setting               | Type                                                            | Default                                     | Description                                                                       |
|-----------------------|-----------------------------------------------------------------|---------------------------------------------|-----------------------------------------------------------------------------------|
| `steeringMode`        | `"all" | "one-at-a-time"`                                       | `"one-at-a-time"`                           | How queued steering messages are delivered.                                       |
| `followUpMode`        | `"all" | "one-at-a-time"`                                       | `"one-at-a-time"`                           | How queued follow-up messages are delivered.                                      |
| `externalEditor`      | string                                                          | `$VISUAL`, `$EDITOR`, then platform default | Command opened by the external-editor keybinding.                                 |
| `doubleEscapeAction`  | `"tree" | "fork" | "none"`                                      | `"tree"`                                    | Action for double Escape with an empty editor.                                    |
| `treeFilterMode`      | `"default" | "no-tools" | "user-only" | "labeled-only" | "all"` | `"default"`                                 | Initial filter used by `/tree`.                                                   |
| `defaultProjectTrust` | `"ask" | "always" | "never"`                                    | `"ask"`                                     | Fallback project-trust behavior. **Can only be set in agent-directory settings.** |


## Tools

<a href="#tools" class="heading-anchor" aria-label="Permalink: Tools" data-copy="" data-copy-text="https://pi.dev/docs/latest/settings#tools"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Setting        | Type       | Default                         | Description                                                                                                   |
|----------------|------------|---------------------------------|---------------------------------------------------------------------------------------------------------------|
| `defaultTools` | `string[]` | `read`, `bash`, `edit`, `write` | Built-in tools enabled at startup. An empty array disables all built-in tools but not extension or SDK tools. |

Available built-in tools are `read`, `bash`, `powershell`, `edit`, `write`, `grep`, `find`, and `ls`. CLI tool options override this setting for one invocation. See [Command Line](/docs/latest/cli#tools).


## Sessions and context

<a href="#sessions-and-context" class="heading-anchor" aria-label="Permalink: Sessions and context" data-copy="" data-copy-text="https://pi.dev/docs/latest/settings#sessions-and-context"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Setting      | Type   | Default                 | Description                                                                                                                                            |
|--------------|--------|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| `sessionDir` | string | Agent session directory | Session storage directory. Relative paths resolve from the working directory. `PI_CODING_AGENT_SESSION_DIR` and `--session-dir` override this setting. |


### Compaction

<a href="#compaction" class="heading-anchor" aria-label="Permalink: Compaction" data-copy="" data-copy-text="https://pi.dev/docs/latest/settings#compaction"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Setting                       | Type    | Default | Description                                                 |
|-------------------------------|---------|---------|-------------------------------------------------------------|
| `compaction.enabled`          | boolean | `true`  | Enable automatic compaction.                                |
| `compaction.reserveTokens`    | number  | `16384` | Tokens reserved for the model response.                     |
| `compaction.keepRecentTokens` | number  | `20000` | Recent tokens retained without summarization.               |
| `compaction.modelOverrides`   | object  | None    | Per-model token settings keyed by exact `provider/modelId`. |


Compaction token values must be non-negative safe integers. Each value resolves independently from the matching model override, then the ordinary compaction setting, then the built-in default. Project and user objects merge before model lookup.

See [Compaction Reference](/docs/latest/compaction) for trigger, summarization, and validation behavior.


### Branch summaries

<a href="#branch-summaries" class="heading-anchor" aria-label="Permalink: Branch summaries" data-copy="" data-copy-text="https://pi.dev/docs/latest/settings#branch-summaries"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Setting                       | Type    | Default | Description                                               |
|-------------------------------|---------|---------|-----------------------------------------------------------|
| `branchSummary.reserveTokens` | number  | `16384` | Tokens reserved when summarizing branch history.          |
| `branchSummary.skipPrompt`    | boolean | `false` | Skip the branch-summary prompt and default to no summary. |


## Terminal and display

<a href="#terminal-and-display" class="heading-anchor" aria-label="Permalink: Terminal and display" data-copy="" data-copy-text="https://pi.dev/docs/latest/settings#terminal-and-display"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Setting                         | Type                                  | Default        | Description                                                                  |
|---------------------------------|---------------------------------------|----------------|------------------------------------------------------------------------------|
| `theme`                         | string                                | Detected       | Built-in or custom theme name.                                               |
| `quietStartup`                  | boolean                               | `false`        | Hide the startup header.                                                     |
| `tuiMode`                       | `"regular" | "fullscreen"`            | `"regular"`    | Interactive terminal UI mode.                                                |
| `fullscreenExitOutput`          | `"transcript" | "resume-hint"`        | `"transcript"` | Output printed when fullscreen mode exits.                                   |
| `fullscreenScrollbar`           | `"auto" | "always" | "hidden"`        | `"auto"`       | Fullscreen transcript scrollbar behavior.                                    |
| `fullscreenCopyOnSelect`        | boolean                               | `true`         | Copy selected text automatically in fullscreen mode.                         |
| `editorPaddingX`                | number                                | `0`            | Horizontal editor padding from 0 to 3 cells.                                 |
| `outputPad`                     | `0 | 1`                               | `1`            | Horizontal transcript padding.                                               |
| `autocompleteMaxVisible`        | number                                | `5`            | Visible autocomplete entries, from 3 to 20.                                  |
| `showHardwareCursor`            | boolean                               | `false`        | Show the terminal cursor while Pi positions it for input methods.            |
| `terminal.showImages`           | boolean                               | `true`         | Display inline images when supported.                                        |
| `terminal.imageWidthCells`      | number                                | `60`           | Preferred inline image width in terminal cells.                              |
| `terminal.clearOnShrink`        | boolean                               | `false`        | Clear empty rows when rendered content shrinks.                              |
| `terminal.showTerminalProgress` | boolean                               | `false`        | Show OSC 9;4 progress in the terminal tab.                                   |
| `terminal.hyperlinks`           | `boolean | "auto"`                    | `"auto"`       | Override OSC 8 hyperlink detection.                                          |
| `terminal.images`               | `"kitty" | "iterm2" | "auto" | false` | `"auto"`       | Override inline-image protocol detection.                                    |
| `terminal.trueColor`            | `boolean | "auto"`                    | `"auto"`       | Override true-color detection.                                               |
| `images.autoResize`             | boolean                               | `true`         | Resize images to at most 2000 by 2000 pixels before sending them to a model. |
| `images.blockImages`            | boolean                               | `false`        | Prevent images from being sent to models.                                    |
| `markdown.codeBlockIndent`      | string                                | `" "`          | Prefix used to indent rendered code blocks.                                  |
| `markdown.mermaid`              | `"off" | "final" | "streaming"`       | `"streaming"`  | Mermaid rendering mode.                                                      |

See [Themes](/docs/latest/themes) and [Terminal Setup](/docs/latest/terminal-setup) for format and platform details.


## Network and retries

<a href="#network-and-retries" class="heading-anchor" aria-label="Permalink: Network and retries" data-copy="" data-copy-text="https://pi.dev/docs/latest/settings#network-and-retries"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Setting                          | Type                                                | Default             | Description                                                                                                                       |
|----------------------------------|-----------------------------------------------------|---------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| `transport`                      | `"auto" | "sse" | "websocket" | "websocket-cached"` | `"auto"`            | Preferred transport for AI providers that support multiple transports.                                                            |
| `httpProxy`                      | string                                              | None                | Proxy URL applied as `HTTP_PROXY` and `HTTPS_PROXY` for Pi-managed HTTP clients. **Can only be set in agent-directory settings.** |
| `httpIdleTimeoutMs`              | number                                              | `300000`            | HTTP header and body idle timeout in milliseconds. Set to `0` to disable.                                                         |
| `websocketConnectTimeoutMs`      | number                                              | `15000`             | WebSocket connection timeout in milliseconds. Set to `0` to disable.                                                              |
| `retry.enabled`                  | boolean                                             | `true`              | Enable automatic agent-level retry for transient failures.                                                                        |
| `retry.maxRetries`               | number                                              | `3`                 | Maximum agent-level retry attempts.                                                                                               |
| `retry.baseDelayMs`              | number                                              | `2000`              | Initial exponential-backoff delay in milliseconds.                                                                                |
| `retry.maxAgentDelayMs`          | number                                              | `60000`             | Maximum agent-level retry delay in milliseconds.                                                                                  |
| `retry.provider.timeoutMs`       | number                                              | `httpIdleTimeoutMs` | Provider request timeout in milliseconds.                                                                                         |
| `retry.provider.maxRetries`      | number                                              | `0`                 | Provider-level retry attempts.                                                                                                    |
| `retry.provider.maxRetryDelayMs` | number                                              | `60000`             | Maximum server-requested delay in milliseconds. Set to `0` to disable the limit.                                                  |

Keep `retry.provider.maxRetries` at `0` unless provider-level retries are required. Provider retries can delay Pi from handling quota and usage-limit errors itself.


## Shell

<a href="#shell" class="heading-anchor" aria-label="Permalink: Shell" data-copy="" data-copy-text="https://pi.dev/docs/latest/settings#shell"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Setting              | Type       | Default          | Description                                                         |
|----------------------|------------|------------------|---------------------------------------------------------------------|
| `shellPath`          | string     | Platform default | Custom shell executable path. Supports a leading `~`.               |
| `shellCommandPrefix` | string     | None             | Prefix prepended to every shell command.                            |
| `npmCommand`         | `string[]` | `npm`            | Command and arguments used for npm package lookup and installation. |

See [Shell aliases](/docs/latest/shell-aliases) for shell setup and [Pi Packages](/docs/latest/packages) for package-manager behavior.


## Resources

<a href="#resources" class="heading-anchor" aria-label="Permalink: Resources" data-copy="" data-copy-text="https://pi.dev/docs/latest/settings#resources"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Resource paths in user settings resolve from the agent directory. Paths in project settings resolve from the project `.pi` directory. Absolute paths and `~` are supported.

| Setting               | Type       | Default | Description                                                                      |
|-----------------------|------------|---------|----------------------------------------------------------------------------------|
| `packages`            | array      | `[]`    | npm, git, or local Pi package sources. See [Pi Packages](/docs/latest/packages). |
| `extensions`          | `string[]` | `[]`    | Extension files or directories.                                                  |
| `skills`              | `string[]` | `[]`    | Skill files or directories.                                                      |
| `prompts`             | `string[]` | `[]`    | Prompt-template files or directories.                                            |
| `themes`              | `string[]` | `[]`    | Theme files or directories.                                                      |
| `enableSkillCommands` | boolean    | `true`  | Register skills as `/skill:name` commands.                                       |

Resource arrays support glob exclusions with `!pattern`, exact inclusion with `+path`, and exact exclusion with `-path`. Pi loads resources listed in both user-level and project settings.


## Updates, telemetry, and warnings

<a href="#updates-telemetry-and-warnings" class="heading-anchor" aria-label="Permalink: Updates, telemetry, and warnings" data-copy="" data-copy-text="https://pi.dev/docs/latest/settings#updates-telemetry-and-warnings"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Setting                        | Type    | Default | Description                                                                                                          |
|--------------------------------|---------|---------|----------------------------------------------------------------------------------------------------------------------|
| `collapseChangelog`            | boolean | `false` | Show a condensed changelog after an update.                                                                          |
| `enableInstallTelemetry`       | boolean | `true`  | Enable anonymous install/update reporting and selected provider attribution headers. Does not control update checks. |
| `enableAnalytics`              | boolean | `false` | Opt in to analytics data sharing. Currently used only by the experimental first-run setup.                           |
| `warnings.anthropicExtraUsage` | boolean | `true`  | Warn when Anthropic subscription authentication may use paid extra usage.                                            |


