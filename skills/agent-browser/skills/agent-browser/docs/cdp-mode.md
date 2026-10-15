> Source: https://agent-browser.dev/cdp-mode



<a href="/" class="flex @min-[1024px]:hidden items-center text-gray-1000"><span class="font-medium tracking-tight" style="font-family:var(--font-geist-pixel-square)">agent-browser</span></a>


<a href="https://github.com/vercel-labs/agent-browser" class="size-8 items-center justify-center @min-[768px]:inline-flex hidden shrink-0" data-geist-button="" data-prefix="false" data-suffix="false" data-version="v1" aria-label="GitHub repository" rel="noopener" target="_blank"><span class="truncate px-1.5 inline-flex shrink-0 items-center justify-center"></span></a>


        &quot;sidebar toc-popover toc&quot;
        &quot;sidebar main toc&quot; 1fr / minmax(var(--fd-sidebar-col), 1fr) minmax(0, calc(var(--fd-layout-width,97rem) - var(--fd-sidebar-width) - var(--fd-toc-width))) minmax(min-content, 1fr);--fd-docs-row-1:4rem;--fd-docs-row-2:calc(var(--fd-docs-row-1) + var(--fd-header-height));--fd-docs-row-3:calc(var(--fd-docs-row-2) + var(--fd-toc-popover-height));--fd-sidebar-col:var(--fd-sidebar-width)">


Menu


# CDP Mode


Copy for LLM


View Markdown


Connect to an existing browser via Chrome DevTools Protocol:


``` m-0
# Start Chrome with: google-chrome --remote-debugging-port=9222

# Connect once, then run commands without --cdp
agent-browser connect 9222
agent-browser snapshot
agent-browser tab
agent-browser close

# Or pass --cdp on each command
agent-browser --cdp 9222 snapshot
```


## <a href="#remote-websocket-urls" class="peer" data-card="">Remote WebSocket URLs</a>

Connect to remote browser services via WebSocket URL:


``` m-0
# Connect to remote browser service
agent-browser --cdp "wss://browser-service.com/cdp?token=..." snapshot

# Works with any CDP-compatible service
agent-browser --cdp "ws://localhost:9222/devtools/browser/abc123" open example.com
```


The `--cdp` flag accepts either:

- A port number (e.g., `9222`) for local connections via `http://localhost:{port}`
- A full WebSocket URL (e.g., `wss://...` or `ws://...`) for remote browser services

Root WebSocket endpoints accept query strings with or without an explicit slash, so both `wss://browser-service.com?token=...` and `wss://browser-service.com/?token=...` work.

## <a href="#auto-connect" class="peer" data-card="">Auto-Connect</a>

Use `--auto-connect` to automatically discover and connect to a running Chrome instance without specifying a port:


``` m-0
# Auto-discover running Chrome with remote debugging
agent-browser --auto-connect open example.com
agent-browser --auto-connect snapshot

# Or via environment variable
AGENT_BROWSER_AUTO_CONNECT=1 agent-browser snapshot
```


Auto-connect discovers Chrome by:

1.  Reading Chrome's `DevToolsActivePort` file from the default user data directory and connecting to its WebSocket endpoint, then HTTP discovery (`/json/version`, `/json/list`) for older Chrome versions
2.  Falling back to probing common debugging ports (9222, 9229)

Chrome 144+ shows a remote-debugging permission prompt on the first connection. Auto-connect waits up to 20 seconds for approval. If the prompt is still open after that, the command fails with a message asking you to approve it and retry, without opening a second prompt.

This is useful when:

- Chrome 144+ has remote debugging enabled via `chrome://inspect/#remote-debugging` (which uses a dynamic port)
- You want a zero-configuration connection to your existing browser
- You don't want to track which port Chrome is using

## <a href="#tab-pinning" class="peer" data-card="">Tab pinning</a>

When several sessions share one browser over CDP, each session remembers which tab it is bound to (by CDP target id, persisted across daemon restarts). A restarted daemon reattaches to the session's own tab instead of adopting whatever tab is currently active, which in a shared browser is usually another session's.

Pass `--pin-tab` (or set `AGENT_BROWSER_PIN_TAB=1`) to make the binding strict:


``` m-0
# Two agents sharing one Chrome, each pinned to its own tab
agent-browser --session agent1 --cdp 9222 --pin-tab open https://site-a.com
agent-browser --session agent2 --cdp 9222 --pin-tab open https://site-b.com
```


With `--pin-tab`:

- Attaching with no binding opens a fresh tab instead of adopting an existing one
- If the bound tab is closed, commands fail with a `tab_gone` error instead of silently acting on another tab. JSON responses carry `"code": "tab_gone"`, `data.targetId`, and optional `data.lastUrl`
- `tab list`, `tab new`, and `tab <ref>` still work in that state, so an agent can recover by binding a new tab
- Tabs opened by other sessions or the user never steal the pinned session's active tab

The flag is sticky per session: pass it once and later commands and daemon restarts keep the strict semantics. Pass `--no-pin-tab` to explicitly turn the pin off again. See <a href="/sessions" class="font-normal text-gray-1000! underline decoration-1 decoration-gray-700 underline-offset-4 hover:text-gray-1000! hover:decoration-gray-1000 hover:opacity-100!">Sessions</a> for the multi-session workflow and <a href="/commands" class="font-normal text-gray-1000! underline decoration-1 decoration-gray-700 underline-offset-4 hover:text-gray-1000! hover:decoration-gray-1000 hover:opacity-100!">Commands</a> for tab refs by CDP target id.

The structured `lastUrl` is emitted only for sanitized HTTP(S) URLs and `about:blank`. Credentials, query strings, and fragments are removed from HTTP(S) URLs, while opaque URLs such as `data:` are omitted. Batch JSON exposes the recovery object under `result`.

When re-running a shared-tab script such as the repro from \#1530, add `--pin-tab` to the first command for every session. Without it, `open` intentionally preserves the legacy behavior and navigates the shared active tab, so the original script still collides. The same rule applies when sessions attach with `--auto-connect` instead of `--cdp`.

## <a href="#color-scheme" class="peer" data-card="">Color scheme</a>

Use `--color-scheme` to set a persistent preference when connecting via CDP:


``` m-0
agent-browser --cdp 9222 --color-scheme dark open https://example.com
agent-browser --cdp 9222 snapshot  # stays in dark mode
```


Or set it globally via config or environment variable:


``` m-0
AGENT_BROWSER_COLOR_SCHEME=dark agent-browser --cdp 9222 open https://example.com
```


## <a href="#use-cases" class="peer" data-card="">Use cases</a>

This enables control of:

- Electron apps
- Chrome/Chromium with remote debugging
- WebView2 applications
- Remote browser services (via WebSocket URL)
- Any browser exposing a CDP endpoint

## <a href="#global-options" class="peer" data-card="">Global options</a>

| Option                    | Description                                                                                                                     |
|---------------------------|---------------------------------------------------------------------------------------------------------------------------------|
| `--session <name>`        | Use isolated session                                                                                                            |
| `--profile <path>`        | Persistent browser profile directory                                                                                            |
| `-p <provider>`           | Browser provider (`browserbase`, `browseruse`, `kernel`, `browserless`, `agentcore`, or a configured `browser.provider` plugin) |
| `--headers <json>`        | HTTP headers scoped to origin                                                                                                   |
| `--executable-path`       | Custom browser executable                                                                                                       |
| `--args <args>`           | Browser launch args (comma-separated)                                                                                           |
| `--user-agent <ua>`       | Custom User-Agent string                                                                                                        |
| `--proxy <url>`           | Proxy server URL                                                                                                                |
| `--proxy-bypass <hosts>`  | Hosts to bypass proxy                                                                                                           |
| `--json`                  | JSON output for scripts                                                                                                         |
| `--name, -n`              | Locator name filter                                                                                                             |
| `--exact`                 | Exact, case-sensitive match (accessible name for role)                                                                          |
| `--headed`                | Show browser window                                                                                                             |
| `--cdp <port|url>`        | CDP connection (port or WebSocket URL)                                                                                          |
| `--auto-connect`          | Auto-discover and connect to running Chrome                                                                                     |
| `--pin-tab`               | Pin the session to its bound tab (strict tab binding)                                                                           |
| `--no-pin-tab`            | Disable a sticky pin previously enabled with `--pin-tab`                                                                        |
| `--color-scheme <scheme>` | Persistent color scheme (`dark`, `light`, `no-preference`)                                                                      |
| `--debug`                 | Debug output                                                                                                                    |

## <a href="#cloud-providers" class="peer" data-card="">Cloud providers</a>

Use the `-p` flag to connect to a cloud browser provider or configured `browser.provider` plugin instead of launching a local browser:


``` m-0
agent-browser -p browserbase open https://example.com
```


See the <a href="/providers/browser-use" class="font-normal text-gray-1000! underline decoration-1 decoration-gray-700 underline-offset-4 hover:text-gray-1000! hover:decoration-gray-1000 hover:opacity-100!">Providers</a> section for setup and configuration of each built-in provider: <a href="/providers/browser-use" class="font-normal text-gray-1000! underline decoration-1 decoration-gray-700 underline-offset-4 hover:text-gray-1000! hover:decoration-gray-1000 hover:opacity-100!">Browser Use</a>, <a href="/providers/browserbase" class="font-normal text-gray-1000! underline decoration-1 decoration-gray-700 underline-offset-4 hover:text-gray-1000! hover:decoration-gray-1000 hover:opacity-100!">Browserbase</a>, <a href="/providers/browserless" class="font-normal text-gray-1000! underline decoration-1 decoration-gray-700 underline-offset-4 hover:text-gray-1000! hover:decoration-gray-1000 hover:opacity-100!">Browserless</a>, <a href="/providers/kernel" class="font-normal text-gray-1000! underline decoration-1 decoration-gray-700 underline-offset-4 hover:text-gray-1000! hover:decoration-gray-1000 hover:opacity-100!">Kernel</a>, and <a href="/providers/agentcore" class="font-normal text-gray-1000! underline decoration-1 decoration-gray-700 underline-offset-4 hover:text-gray-1000! hover:decoration-gray-1000 hover:opacity-100!">AgentCore</a>.


<a href="/network" class="group grid w-fit grid-cols-[auto_1fr] items-center gap-x-1.5 gap-y-1 text-gray-1000"><span class="text-gray-900 text-sm col-start-2">Previous</span><span class="row-start-2 font-medium col-start-2">Network</span></a><a href="/webmcp" class="group grid w-fit grid-cols-[1fr_auto] items-center gap-x-1.5 gap-y-1 justify-self-end text-right text-gray-1000"><span class="text-gray-900 text-sm col-start-1">Next</span><span class="row-start-2 font-medium col-start-1">WebMCP</span></a>


