> Source: https://agent-browser.dev/sessions



<a href="/" class="flex @min-[1024px]:hidden items-center text-gray-1000"><span class="font-medium tracking-tight" style="font-family:var(--font-geist-pixel-square)">agent-browser</span></a>


<a href="https://github.com/vercel-labs/agent-browser" class="size-8 items-center justify-center @min-[768px]:inline-flex hidden shrink-0" data-geist-button="" data-prefix="false" data-suffix="false" data-version="v1" aria-label="GitHub repository" rel="noopener" target="_blank"><span class="truncate px-1.5 inline-flex shrink-0 items-center justify-center"></span></a>


        &quot;sidebar toc-popover toc&quot;
        &quot;sidebar main toc&quot; 1fr / minmax(var(--fd-sidebar-col), 1fr) minmax(0, calc(var(--fd-layout-width,97rem) - var(--fd-sidebar-width) - var(--fd-toc-width))) minmax(min-content, 1fr);--fd-docs-row-1:4rem;--fd-docs-row-2:calc(var(--fd-docs-row-1) + var(--fd-header-height));--fd-docs-row-3:calc(var(--fd-docs-row-2) + var(--fd-toc-popover-height));--fd-sidebar-col:var(--fd-sidebar-width)">


Menu


# Sessions


Copy for LLM


View Markdown


Run multiple isolated browser instances:


``` m-0
# Different sessions
agent-browser --session agent1 open site-a.com
agent-browser --session agent2 open site-b.com

# Or via environment variable
AGENT_BROWSER_SESSION=agent1 agent-browser click "#btn"

# List active sessions
agent-browser session list
# Output:
# Active sessions:
# -> default
#    agent1

# Show current session
agent-browser session

# Generate a stable worktree-scoped session id
agent-browser session id --scope worktree --prefix next-dev-loop

# Inspect daemon, launch, and restore status
agent-browser session info --json
```


## <a href="#session-isolation" class="peer" data-card="">Session isolation</a>

Each session has its own:

- Browser instance
- Cookies and storage
- Navigation history
- Authentication state

## <a href="#tab-pinning-in-a-shared-browser" class="peer" data-card="">Tab pinning in a shared browser</a>

Full isolation applies when each session launches its own browser. When sessions instead share one Chrome over `--cdp`, only the tab selection separates them. Each session remembers which tab it is bound to (by CDP target id, persisted across daemon restarts), so a restarted daemon reattaches to the session's own tab instead of adopting the most recently active one.

Add `--pin-tab` (or set `AGENT_BROWSER_PIN_TAB=1`) to make the binding strict:


``` m-0
agent-browser --session agent1 --cdp 9222 --pin-tab open https://site-a.com
agent-browser --session agent2 --cdp 9222 --pin-tab open https://site-b.com
```


With `--pin-tab`, a session whose bound tab was closed gets a `tab_gone` error instead of silently acting on another session's tab; run `tab new <url>` or pick a tab from `tab list` to recover. JSON output includes `"code": "tab_gone"`, `data.targetId`, and optional sanitized `data.lastUrl`. Batch output uses `result` for the same recovery object. The flag is sticky per session; pass `--no-pin-tab` to turn it off again. See <a href="/cdp-mode" class="font-normal text-gray-1000! underline decoration-1 decoration-gray-700 underline-offset-4 hover:text-gray-1000! hover:decoration-gray-1000 hover:opacity-100!">CDP Mode</a> for details.

## <a href="#chrome-profile-reuse" class="peer" data-card="">Chrome profile reuse</a>

The simplest way to reuse your existing login state: pass a Chrome profile name to `--profile`. agent-browser copies the profile to a temp directory (read-only snapshot) and launches Chrome with your existing cookies and sessions.


``` m-0
# List available Chrome profiles
agent-browser profiles

# Reuse your default Chrome profile's login state
agent-browser --profile Default open https://gmail.com

# Use a named profile (by display name or directory name)
agent-browser --profile "Work" open https://app.example.com

# Or via environment variable
AGENT_BROWSER_PROFILE=Default agent-browser open https://gmail.com
```


| Detail             | Description                                                              |
|--------------------|--------------------------------------------------------------------------|
| Supported browsers | Chrome, Chrome Canary, Chromium, Brave                                   |
| What's copied      | Cookies, local storage, extensions state (cache dirs excluded for speed) |
| Original profile   | Never modified (read-only snapshot)                                      |
| Cleanup            | Temp copy deleted when browser closes                                    |
| Windows note       | Close Chrome before using `--profile <name>` if Chrome is running        |

## <a href="#persistent-profiles" class="peer" data-card="">Persistent profiles</a>

For a custom profile directory that persists state across browser restarts, pass a path to `--profile`:


``` m-0
# Use a persistent profile directory
agent-browser --profile ~/.myapp-profile open myapp.com

# Login once, then reuse the authenticated session
agent-browser --profile ~/.myapp-profile open myapp.com/dashboard

# Or via environment variable
AGENT_BROWSER_PROFILE=~/.myapp-profile agent-browser open myapp.com
```


The profile directory stores:

- Cookies and localStorage
- IndexedDB data
- Service workers
- Browser cache
- Login sessions

## <a href="#import-auth-from-your-browser" class="peer" data-card="">Import auth from your browser</a>

If you are already logged in to a site in Chrome, you can grab that auth state and reuse it in agent-browser. This is the fastest way to bypass login flows, OAuth, SSO, or 2FA.

**Step 1:** Start Chrome with remote debugging:


``` m-0
# macOS
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```


Log in to your target site(s) in this Chrome window.

`--remote-debugging-port` exposes full browser control on localhost. Any local process can connect. Only use on trusted machines and close Chrome when done.

**Step 2:** Connect and save the authenticated state:


``` m-0
agent-browser --auto-connect state save ./my-auth.json
```


**Step 3:** Use the saved auth in future sessions:


``` m-0
# Load auth at launch
agent-browser --state ./my-auth.json open https://app.example.com/dashboard

# Or load into an already-launched session
agent-browser open about:blank
agent-browser state load ./my-auth.json
agent-browser open https://app.example.com/dashboard
```


Combine with `--session <id> --restore` so the imported auth auto-persists across restarts:


``` m-0
SESSION="$(agent-browser session id --scope worktree --prefix myapp)"
agent-browser --session "$SESSION" --restore --state ./my-auth.json open https://app.example.com/dashboard
# From now on, state auto-saves/restores for this session
```


State files contain session tokens in plaintext. Add them to `.gitignore` and delete when no longer needed. For encryption at rest, see <a href="#state-encryption" class="font-normal text-gray-1000! underline decoration-1 decoration-gray-700 underline-offset-4 hover:text-gray-1000! hover:decoration-gray-1000 hover:opacity-100!">State encryption</a> below.

## <a href="#session-persistence" class="peer" data-card="">Session persistence</a>

Use `--restore` with a stable `--session` to automatically save and restore cookies and localStorage across browser restarts:


``` m-0
# Auto-save/load state for this worktree
SESSION="$(agent-browser session id --scope worktree --prefix twitter)"
agent-browser --session "$SESSION" --restore open twitter.com

# Login once, then state persists automatically
agent-browser --session "$SESSION" --restore click "#login"

# Optional validation prevents a bad restore from overwriting the previous good state
agent-browser --session "$SESSION" --restore --restore-check-text Dashboard open twitter.com
```


State files are stored in `~/.agent-browser/sessions/` and automatically loaded before navigation. With the default `--restore-save auto` policy, failed restore or failed validation skips auto-save.

When `--restore` or another restore key is configured, state is saved when the browser closes (explicit `close`, idle timeout, or daemon shutdown) and also periodically while the browser is open, so a browser window you close by hand still leaves a recent save behind. A session ID by itself only isolates the daemon and does not enable persistence; without a restore key, shutdown discards transient browser state and open tabs. Periodic autosave waits for commands to settle, then saves at most once per `AGENT_BROWSER_AUTOSAVE_INTERVAL_MS` (default 30000; set to `0` to save only on close). Idle sessions with configured persistence keep saving on the same interval, so changes the page makes on its own (token refreshes, background requests) are captured too. The daemon exits after one hour without commands or dashboard input by default; `--idle-timeout <time>` or `AGENT_BROWSER_IDLE_TIMEOUT_MS` tunes this, and `0` disables it. Headed, Safari/iOS WebDriver, and user-attached browsers are exempt from the default timeout; provider-owned cloud browsers are not. State saving respects the `--restore-save` policy.

### <a href="#restore-key-rules" class="peer" data-card="">Restore key rules</a>

Session and restore names must contain only alphanumeric characters, hyphens, and underscores. Use `agent-browser session id` to generate a valid key:


``` m-0
# Valid generated key
agent-browser session id --scope worktree --prefix my-project

# Invalid (will be rejected)
agent-browser --session "../bad" --restore open example.com    # path traversal
agent-browser --session "my session" --restore open example.com # spaces
agent-browser --session "foo/bar" --restore open example.com    # slashes
```


## <a href="#state-encryption" class="peer" data-card="">State encryption</a>

Encrypt saved state files (cookies, localStorage) using AES-256-GCM:


``` m-0
# Generate a 256-bit key (64 hex characters)
openssl rand -hex 32

# Set the encryption key
export AGENT_BROWSER_ENCRYPTION_KEY=<your-64-char-hex-key>

# State files are now encrypted automatically
agent-browser --session secure-session --restore open example.com

# List states shows encryption status
agent-browser state list
```


## <a href="#state-auto-expiration" class="peer" data-card="">State auto-expiration</a>

Automatically delete old state files to prevent accumulation:


``` m-0
# Set expiration (default: 30 days)
export AGENT_BROWSER_STATE_EXPIRE_DAYS=7

# Manually clean old states
agent-browser state clean --older-than 7
```


## <a href="#state-management-commands" class="peer" data-card="">State management commands</a>


``` m-0
# List all saved states
agent-browser state list

# Show state summary (cookies, origins, domains)
agent-browser state show my-session-default.json

# Rename a state file
agent-browser state rename old-name new-name

# Clear states for a specific session name
agent-browser state clear my-session

# Clear all saved states
agent-browser state clear --all

# Manual save/load (for custom paths)
agent-browser state save ./backup.json
agent-browser state load ./backup.json
```


## <a href="#authenticated-sessions" class="peer" data-card="">Authenticated sessions</a>

Use `--headers` to set HTTP headers for a specific origin:


``` m-0
# Headers scoped to api.example.com only
agent-browser open api.example.com --headers '{"Authorization": "Bearer <token>"}'

# Requests to api.example.com include the auth header
agent-browser snapshot -i --json
agent-browser click @e2

# Navigate to another domain - headers NOT sent
agent-browser open other-site.com
```


Useful for:

- **Skipping login flows** - Authenticate via headers
- **Switching users** - Different auth tokens per session
- **API testing** - Access protected endpoints
- **Security** - Headers scoped to origin, not leaked

## <a href="#multiple-origins" class="peer" data-card="">Multiple origins</a>


``` m-0
agent-browser open api.example.com --headers '{"Authorization": "Bearer token1"}'
agent-browser open api.acme.com --headers '{"Authorization": "Bearer token2"}'
```


## <a href="#global-headers" class="peer" data-card="">Global headers</a>

For headers on all domains:


``` m-0
agent-browser set headers '{"X-Custom-Header": "value"}'
```


## <a href="#environment-variables" class="peer" data-card="">Environment variables</a>

| Variable                             | Description                                                                  |
|--------------------------------------|------------------------------------------------------------------------------|
| `AGENT_BROWSER_SESSION`              | Browser session ID (default: "default")                                      |
| `AGENT_BROWSER_NAMESPACE`            | Namespace for daemon sockets and restore-state directories                   |
| `AGENT_BROWSER_PIN_TAB`              | Pin the session to its bound tab (strict tab binding)                        |
| `AGENT_BROWSER_RESTORE`              | Auto-save/load state persistence key                                         |
| `AGENT_BROWSER_RESTORE_SAVE`         | Restore save policy: `auto`, `always`, or `never`                            |
| `AGENT_BROWSER_AUTOSAVE_INTERVAL_MS` | Minimum ms between periodic session autosaves (default: 30000, `0` disables) |
| `AGENT_BROWSER_RESTORE_CHECK_URL`    | URL pattern restored state must match                                        |
| `AGENT_BROWSER_RESTORE_CHECK_TEXT`   | Page text restored state must contain                                        |
| `AGENT_BROWSER_RESTORE_CHECK_FN`     | JavaScript expression restored state must satisfy                            |
| `AGENT_BROWSER_SESSION_NAME`         | Legacy auto-save/load state persistence name                                 |
| `AGENT_BROWSER_ENCRYPTION_KEY`       | 64-char hex key for AES-256-GCM encryption                                   |
| `AGENT_BROWSER_STATE_EXPIRE_DAYS`    | Auto-delete states older than N days (default: 30)                           |


<a href="/snapshots" class="group grid w-fit grid-cols-[auto_1fr] items-center gap-x-1.5 gap-y-1 text-gray-1000"><span class="text-gray-900 text-sm col-start-2">Previous</span><span class="row-start-2 font-medium col-start-2">Snapshots</span></a><a href="/dashboard" class="group grid w-fit grid-cols-[1fr_auto] items-center gap-x-1.5 gap-y-1 justify-self-end text-right text-gray-1000"><span class="text-gray-900 text-sm col-start-1">Next</span><span class="row-start-2 font-medium col-start-1">Dashboard</span></a>


