> Source: https://agent-browser.dev/sessions



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

## <a href="#changing-settings-on-a-running-session" class="peer" data-card="">Changing settings on a running session</a>

Each command carries the settings you set for it, whether from a flag, an environment variable, or the config file. The daemon compares them with what the session is running and acts on the difference:

- A setting you omit keeps its running value.
- A setting equal to the running value does nothing, so repeating `--profile ./work` on every command never relaunches the browser.
- Timeouts, `--action-policy`, `--confirm-actions`, `--no-auto-dialog`, and restore and pin settings apply in place.
- Launch settings such as `--profile`, `--args`, `--headed`, `--proxy`, `--state`, and `--allowed-domains` relaunch the browser. The daemon keeps running.

Each change that takes effect is printed on stderr, one line each, and every change is listed in `lifecycle.settings.changes` of the `--json` response with `applied: true` or `applied: false`. A launch setting changed while no browser is running is `applied: false` and has no stderr line, since it takes effect at the next launch. Secrets are redacted in both places: passwords and CDP headers are hidden, and CDP URLs lose their credentials and query string.

A command that never launches a browser, such as `get cdp-url` or `session info`, applies only live settings. `get cdp-url` sends no launch settings at all. For the others, launch settings are not applied and not kept; a command that launches carries them again. A launch setting is kept only after the launch that uses it succeeds; if the launch fails, the session keeps its previous launch settings, except `--allowed-domains`, which stays installed after a failed launch so containment is never widened. A command that is denied by policy or waits for confirmation changes no launch settings and leaves the browser running.

The security settings (`--allowed-domains`, `--action-policy`, `--confirm-actions`) also survive a daemon restart. They are kept in an owner-only file next to the session's socket (`<session>.settings` in the socket directory), written before a new value takes effect, so idle expiry, a crash, a kill or an upgrade does not silently drop containment. A restarted daemon starts with the stored values; the environment is used only when no file exists, and a value you pass replaces the stored one (`--allowed-domains ""` clears the filter and the clear is kept). A relative `--action-policy` path is resolved against the directory of the command that set it and stored as an absolute path, so a restarted daemon never reads another directory's policy. The file is removed when a `close` succeeds. `close --all` also closes sessions whose daemon is gone but whose file remains, by starting a daemon with the stored settings, so the same rules apply; a close that policy denies or that waits for confirmation keeps it, and so does a restart the CLI triggers (upgrade, changed daemon options). If the file exists but cannot be read or parsed, or on Unix is readable by other users, the daemon refuses to start and names the file; `agent-browser --session <name> close` clears it. Windows has no mode check, so the file relies on the access rules of the socket directory.

Settings that describe a browser agent-browser starts itself (`--profile`, `--args`, `--executable-path`, `--extension`, `--proxy`, `--user-agent`, `--state`, and similar) are ignored for a session attached over `--cdp`, `--auto-connect` or a provider. They never relaunch it or start a new cloud session, and they appear in `lifecycle.settings.changes` with `effect: "ignored"`. Values of the sensitive ones (`--state`, `--profile`, `--extension`, `--proxy` and its credentials, `--executable-path`, `--args`) inherited from before the switch are dropped, so a state file or proxy credentials from a local launch are never applied to an external browser. An empty `--provider` resets a provider session to a local launch, and `--no-auto-connect` does the same for a session attached with `--auto-connect`. Setting `--state` replaces an inherited `--profile` or `--extension`, and setting `--profile` or `--extension` replaces an inherited `--state`.

With `--relaunch` in a batch, the browser is relaunched once, for the first command.

The first command of a session still seeds its settings from the environment the daemon was spawned with, except the connection target (`--cdp`, `--auto-connect`, `--provider`): that one is kept only after an attach succeeds, so a failed attach never sticks.


``` m-0
agent-browser --profile ./a open https://example.com
agent-browser --profile ./b get url
# ⚠ profile: ./a → ./b (--profile), relaunched browser
```


`--state <path>` loads the file when the browser launches. Passing the same path again does not reload it; pass `--relaunch` to relaunch the browser and load it again.

## <a href="#tab-pinning-in-a-shared-browser" class="peer" data-card="">Tab pinning in a shared browser</a>

Full isolation applies when each session launches its own browser. When sessions instead share one Chrome over `--cdp`, only the tab selection separates them. Each session remembers which tab it is bound to (by CDP target id, persisted across daemon restarts), so a restarted daemon reattaches to the session's own tab instead of adopting the most recently active one.

Add `--pin-tab` (or set `AGENT_BROWSER_PIN_TAB=1`) to make the binding strict:


``` m-0
agent-browser --session agent1 --cdp 9222 --pin-tab open https://site-a.com
agent-browser --session agent2 --cdp 9222 --pin-tab open https://site-b.com
```


With `--pin-tab`, a session whose bound tab was closed gets a `tab_gone` error instead of silently acting on another session's tab; run `tab new <url>` or pick a tab from `tab list` to recover. JSON output includes `"code": "tab_gone"`, `data.targetId`, and optional sanitized `data.lastUrl`. Batch output uses `result` for the same recovery object. The flag is sticky per session; pass `--no-pin-tab` to turn it off again. See <a href="/cdp-mode" class="font-normal text-gray-1000! underline decoration-1 decoration-gray-700 underline-offset-4 hover:text-gray-1000! hover:decoration-gray-1000 hover:opacity-100!">CDP Mode</a> for details.

Another session cannot take a pinned tab with `tab <ref>` while the pinning session is running (`tab_locked`), and an explicit `close` releases the pin.

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


| Detail | Description |
|----|----|
| Supported browsers | Chrome, Chrome Canary, Chromium, Brave |
| What's copied | Cookies, local storage, extensions state (cache dirs excluded for speed) |
| Original profile | Never modified (read-only snapshot) |
| Cleanup | Temp copy deleted when browser closes |
| Windows note | Close Chrome before using `--profile <name>` if Chrome is running |

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


Saved localStorage and sessionStorage are written through Chrome DevTools, not page JavaScript, and only while the page is on the saved origin. If an origin redirects elsewhere or fails to load, its storage is skipped, the rest still loads, and `state load` lists it under `skippedOrigins`. For `--state` and `--restore` at launch, `session info` lists it under `restoreSkippedOrigins`.

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

Session and restore names accept Unicode letters and numbers, hyphens, and underscores only. For example, `café-東京_7` is valid, while `my session` is rejected because it contains a space.

Use `agent-browser session id` to generate a valid key:


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

| Variable | Description |
|----|----|
| `AGENT_BROWSER_SESSION` | Browser session ID (default: "default") |
| `AGENT_BROWSER_NAMESPACE` | Namespace for daemon sockets and restore-state directories |
| `AGENT_BROWSER_PIN_TAB` | Pin the session to its bound tab (strict tab binding) |
| `AGENT_BROWSER_RESTORE` | Auto-save/load state persistence key |
| `AGENT_BROWSER_RESTORE_SAVE` | Restore save policy: `auto`, `always`, or `never` |
| `AGENT_BROWSER_AUTOSAVE_INTERVAL_MS` | Minimum ms between periodic session autosaves (default: 30000, `0` disables) |
| `AGENT_BROWSER_RESTORE_CHECK_URL` | URL pattern restored state must match |
| `AGENT_BROWSER_RESTORE_CHECK_TEXT` | Page text restored state must contain |
| `AGENT_BROWSER_RESTORE_CHECK_FN` | JavaScript expression restored state must satisfy |
| `AGENT_BROWSER_SESSION_NAME` | Legacy auto-save/load state persistence name |
| `AGENT_BROWSER_ENCRYPTION_KEY` | 64-char hex key for AES-256-GCM encryption |
| `AGENT_BROWSER_STATE_EXPIRE_DAYS` | Auto-delete states older than N days (default: 30) |


<a href="/snapshots" class="group grid w-fit grid-cols-[auto_1fr] items-center gap-x-1.5 gap-y-1 text-gray-1000"><span class="text-gray-900 text-sm col-start-2">Previous</span><span class="row-start-2 font-medium col-start-2">Snapshots</span></a><a href="/dashboard" class="group grid w-fit grid-cols-[1fr_auto] items-center gap-x-1.5 gap-y-1 justify-self-end text-right text-gray-1000"><span class="text-gray-900 text-sm col-start-1">Next</span><span class="row-start-2 font-medium col-start-1">Dashboard</span></a>


