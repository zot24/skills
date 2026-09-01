> Source: https://agent-browser.dev/cdp-mode



[](https://vercel.com "Made with love by Vercel")<span class="text-neutral-300 dark:text-neutral-700"></span>[<span class="font-medium tracking-tight text-lg" style="font-family:var(--font-geist-pixel-square)">agent-browser</span>](/)


CDP Mode


Copy Page


# CDP Mode<a href="#cdp-mode" aria-label="Link to this section">#</a>

Connect to an existing browser via Chrome DevTools Protocol:


``` shiki
# Start Chrome with: google-chrome --remote-debugging-port=9222

# Connect once, then run commands without --cdp
agent-browser connect 9222
agent-browser snapshot
agent-browser tab
agent-browser close

# Or pass --cdp on each command
agent-browser --cdp 9222 snapshot
```


## Remote WebSocket URLs<a href="#remote-websocket-urls" aria-label="Link to this section">#</a>

Connect to remote browser services via WebSocket URL:


``` shiki
# Connect to remote browser service
agent-browser --cdp "wss://browser-service.com/cdp?token=..." snapshot

# Works with any CDP-compatible service
agent-browser --cdp "ws://localhost:9222/devtools/browser/abc123" open example.com
```


The `--cdp` flag accepts either:

- A port number (e.g., `9222`) for local connections via `http://localhost:{port}`
- A full WebSocket URL (e.g., `wss://...` or `ws://...`) for remote browser services

Root WebSocket endpoints accept query strings with or without an explicit slash, so both `wss://browser-service.com?token=...` and `wss://browser-service.com/?token=...` work.

## Auto-Connect<a href="#auto-connect" aria-label="Link to this section">#</a>

Use `--auto-connect` to automatically discover and connect to a running Chrome instance without specifying a port:


``` shiki
# Auto-discover running Chrome with remote debugging
agent-browser --auto-connect open example.com
agent-browser --auto-connect snapshot

# Or via environment variable
AGENT_BROWSER_AUTO_CONNECT=1 agent-browser snapshot
```


Auto-connect discovers Chrome by:

1.  Reading Chrome's `DevToolsActivePort` file from the default user data directory
2.  Falling back to probing common debugging ports (9222, 9229)
3.  If HTTP-based discovery (`/json/version`, `/json/list`) fails, falling back to a direct WebSocket connection

This is useful when:

- Chrome 144+ has remote debugging enabled via `chrome://inspect/#remote-debugging` (which uses a dynamic port)
- You want a zero-configuration connection to your existing browser
- You don't want to track which port Chrome is using

## Tab pinning<a href="#tab-pinning" aria-label="Link to this section">#</a>

When several sessions share one browser over CDP, each session remembers which tab it is bound to (by CDP target id, persisted across daemon restarts). A restarted daemon reattaches to the session's own tab instead of adopting whatever tab is currently active, which in a shared browser is usually another session's.

Pass `--pin-tab` (or set `AGENT_BROWSER_PIN_TAB=1`) to make the binding strict:


``` shiki
# Two agents sharing one Chrome, each pinned to its own tab
agent-browser --session agent1 --cdp 9222 --pin-tab open https://site-a.com
agent-browser --session agent2 --cdp 9222 --pin-tab open https://site-b.com
```


With `--pin-tab`:

- Attaching with no binding opens a fresh tab instead of adopting an existing one
- If the bound tab is closed, commands fail with a `tab_gone` error instead of silently acting on another tab. JSON responses carry `"code": "tab_gone"`, `data.targetId`, and optional `data.lastUrl`
- `tab list`, `tab new`, and `tab <ref>` still work in that state, so an agent can recover by binding a new tab
- Tabs opened by other sessions or the user never steal the pinned session's active tab

The flag is sticky per session: pass it once and later commands and daemon restarts keep the strict semantics. Pass `--no-pin-tab` to explicitly turn the pin off again. See [Sessions](/sessions) for the multi-session workflow and [Commands](/commands) for tab refs by CDP target id.

The structured `lastUrl` is emitted only for sanitized HTTP(S) URLs and `about:blank`. Credentials, query strings, and fragments are removed from HTTP(S) URLs, while opaque URLs such as `data:` are omitted. Batch JSON exposes the recovery object under `result`.

When re-running a shared-tab script such as the repro from \#1530, add `--pin-tab` to the first command for every session. Without it, `open` intentionally preserves the legacy behavior and navigates the shared active tab, so the original script still collides. The same rule applies when sessions attach with `--auto-connect` instead of `--cdp`.

## Color scheme<a href="#color-scheme" aria-label="Link to this section">#</a>

Use `--color-scheme` to set a persistent preference when connecting via CDP:


``` shiki
agent-browser --cdp 9222 --color-scheme dark open https://example.com
agent-browser --cdp 9222 snapshot  # stays in dark mode
```


Or set it globally via config or environment variable:


``` shiki
AGENT_BROWSER_COLOR_SCHEME=dark agent-browser --cdp 9222 open https://example.com
```


## Use cases<a href="#use-cases" aria-label="Link to this section">#</a>

This enables control of:

- Electron apps
- Chrome/Chromium with remote debugging
- WebView2 applications
- Remote browser services (via WebSocket URL)
- Any browser exposing a CDP endpoint

## Global options<a href="#global-options" aria-label="Link to this section">#</a>

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

## Cloud providers<a href="#cloud-providers" aria-label="Link to this section">#</a>

Use the `-p` flag to connect to a cloud browser provider or configured `browser.provider` plugin instead of launching a local browser:


``` shiki
agent-browser -p browserbase open https://example.com
```


See the [Providers](/providers/browser-use) section for setup and configuration of each built-in provider: [Browser Use](/providers/browser-use), [Browserbase](/providers/browserbase), [Browserless](/providers/browserless), [Kernel](/providers/kernel), and [AgentCore](/providers/agentcore).


Ask AI<span class="kbd hidden sm:inline-flex items-center gap-0.5 text-xs opacity-60 font-mono">⌘I</span>
