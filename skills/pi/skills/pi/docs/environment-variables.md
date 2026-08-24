> Source: https://pi.dev/docs/latest/environment-variables



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Environment Variables


Pi uses environment variables in three ways:

- Variables such as `PI_OFFLINE` configure the Pi process.
- Pi sets process markers so child processes can identify Pi as the launching agent.
- Commands run by the LLM-callable shell tools receive `PI_*` variables describing the current session.

Provider API-key variables are documented separately in [Providers](/docs/latest/providers#environment-variables-or-auth-file).


## Process Marker

<a href="#process-marker" class="heading-anchor" aria-label="Permalink: Process Marker" data-copy="" data-copy-text="https://pi.dev/docs/latest/environment-variables#process-marker"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


The CLI and RPC entry points set two process markers:

- `AI_AGENT=pi` is a generic marker that lets tooling identify Pi as the agent that launched the process.
- `PI_CODING_AGENT=true` is Pi-specific and lets child processes detect that they run inside Pi.

Child processes inherit both markers. They are not session-specific and are not set automatically when Pi is embedded through the SDK.


## Shell Tool Session Environment

<a href="#shell-tool-session-environment" class="heading-anchor" aria-label="Permalink: Shell Tool Session Environment" data-copy="" data-copy-text="https://pi.dev/docs/latest/environment-variables#shell-tool-session-environment"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Commands run by the `bash` and `powershell` tools receive the current Pi session state:

| Variable             | Description                                                                                     |
|----------------------|-------------------------------------------------------------------------------------------------|
| `PI_SESSION_ID`      | Current session ID                                                                              |
| `PI_SESSION_FILE`    | Absolute path to the current session JSONL file; unset for ephemeral sessions                   |
| `PI_PROVIDER`        | Currently selected model provider                                                               |
| `PI_MODEL`           | Currently selected model ID                                                                     |
| `PI_REASONING_LEVEL` | Current effective reasoning level: `off`, `minimal`, `low`, `medium`, `high`, `xhigh`, or `max` |

The values are resolved when each command starts. Switching models or changing the reasoning level therefore affects the next shell command without restarting Pi. `PI_PROVIDER` and `PI_MODEL` identify the selected Pi model, not a different upstream model that a router may choose internally.

When asked which model or provider is running, inspect these variables instead of inferring the answer from the system prompt:

``` bash
printf '%s/%s\n' "$PI_PROVIDER" "$PI_MODEL"
printf 'reasoning=%s session=%s\n' "$PI_REASONING_LEVEL" "$PI_SESSION_ID"
```

The session file can be inspected directly when the session is persistent:

``` bash
if [ -n "$PI_SESSION_FILE" ]; then
  tail -n 1 "$PI_SESSION_FILE"
fi
```

These variables are injected into the LLM-callable `bash` and `powershell` tools. They are not injected into user-entered `!` or `!!` commands.


### Custom Shell Tools

<a href="#custom-shell-tools" class="heading-anchor" aria-label="Permalink: Custom Shell Tools" data-copy="" data-copy-text="https://pi.dev/docs/latest/environment-variables#custom-shell-tools"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Tools created with `createBashTool()` or `createPowerShellTool()` expose the session environment by default when registered with Pi. Injection happens before `spawnHook`, so a hook receives the variables in `ctx.env`:

``` typescript
const bashTool = createBashTool(cwd, {
  spawnHook: (ctx) => ({
    ...ctx,
    env: { ...ctx.env, CI: "1" },
  }),
});
```

Disable session metadata independently of the spawn hook:

``` typescript
const powershellTool = createPowerShellTool(cwd, {
  exposeSessionEnvironment: false,
  spawnHook: (ctx) => ctx,
});
```

When disabled, Pi removes inherited values for these variables so nested Pi processes do not expose stale parent-session metadata.


## Pi Process Configuration

<a href="#pi-process-configuration" class="heading-anchor" aria-label="Permalink: Pi Process Configuration" data-copy="" data-copy-text="https://pi.dev/docs/latest/environment-variables#pi-process-configuration"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


These variables are read by Pi itself:

| Variable                      | Description                                                                                                                                                                    |
|-------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `PI_CODING_AGENT_DIR`         | Override the config directory; default is `~/.pi/agent`                                                                                                                        |
| `PI_CODING_AGENT_SESSION_DIR` | Override session storage; overridden by `--session-dir`                                                                                                                        |
| `PI_PACKAGE_DIR`              | Override the package directory, useful for Nix/Guix store paths                                                                                                                |
| `PI_OFFLINE`                  | Disable startup network operations, including update checks, package updates, and install/update telemetry                                                                     |
| `PI_SKIP_VERSION_CHECK`       | Disable the `pi.dev` latest-version request                                                                                                                                    |
| `PI_TELEMETRY`                | Override install/update telemetry and provider attribution headers: `1`/`true`/`yes` or `0`/`false`/`no`                                                                       |
| `PI_CACHE_RETENTION`          | Set to `long` for extended provider prompt caching where supported                                                                                                             |
| `PI_SHARE_VIEWER_URL`         | Override the base URL used by `/share`                                                                                                                                         |
| `PI_HARDWARE_CURSOR`          | Set to `1` to show the hardware cursor; see [Terminal setup](/docs/latest/terminal-setup)                                                                                      |
| `PI_TUI_ESC_TIMEOUT`          | How long to wait after a lone ESC before treating it as Escape, in milliseconds; defaults to `100` over SSH and `10` otherwise. Increase if Alt-key input is misread as Escape |
| `VISUAL`, `EDITOR`            | External editor fallback when `externalEditor` is unset                                                                                                                        |
| `HTTP_PROXY`, `HTTPS_PROXY`   | Proxy outbound HTTP requests                                                                                                                                                   |

Provider credentials such as `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, and cloud-provider configuration are listed in [Providers](/docs/latest/providers#environment-variables-or-auth-file).


