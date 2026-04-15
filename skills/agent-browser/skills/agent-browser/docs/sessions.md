> Source: https://agent-browser.dev/sessions



[](https://vercel.com "Made with love by Vercel")<span class="text-neutral-300 dark:text-neutral-700"></span>[<span class="font-medium tracking-tight text-lg" style="font-family:var(--font-geist-pixel-square)">agent-browser</span>](/)


Sessions


Copy Page


# Sessions<a href="#sessions" aria-label="Link to this section">#</a>

Run multiple isolated browser instances:


``` shiki
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
```


## Session isolation<a href="#session-isolation" aria-label="Link to this section">#</a>

Each session has its own:

- Browser instance
- Cookies and storage
- Navigation history
- Authentication state

## Chrome profile reuse<a href="#chrome-profile-reuse" aria-label="Link to this section">#</a>

The simplest way to reuse your existing login state: pass a Chrome profile name to `--profile`. agent-browser copies the profile to a temp directory (read-only snapshot) and launches Chrome with your existing cookies and sessions.


``` shiki
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

## Persistent profiles<a href="#persistent-profiles" aria-label="Link to this section">#</a>

For a custom profile directory that persists state across browser restarts, pass a path to `--profile`:


``` shiki
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

## Import auth from your browser<a href="#import-auth-from-your-browser" aria-label="Link to this section">#</a>

If you are already logged in to a site in Chrome, you can grab that auth state and reuse it in agent-browser. This is the fastest way to bypass login flows, OAuth, SSO, or 2FA.

**Step 1:** Start Chrome with remote debugging:


``` shiki
# macOS
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --remote-debugging-port=9222

# Linux
google-chrome --remote-debugging-port=9222
```


Log in to your target site(s) in this Chrome window.

`--remote-debugging-port` exposes full browser control on localhost. Any local process can connect. Only use on trusted machines and close Chrome when done.

**Step 2:** Connect and save the authenticated state:


``` shiki
agent-browser --auto-connect state save ./my-auth.json
```


**Step 3:** Use the saved auth in future sessions:


``` shiki
# Load auth at launch
agent-browser --state ./my-auth.json open https://app.example.com/dashboard

# Or load into an existing session
agent-browser state load ./my-auth.json
agent-browser open https://app.example.com/dashboard
```


Combine with `--session-name` so the imported auth auto-persists across restarts:


``` shiki
agent-browser --session-name myapp state load ./my-auth.json
# From now on, state auto-saves/restores for "myapp"
```


State files contain session tokens in plaintext. Add them to `.gitignore` and delete when no longer needed. For encryption at rest, see <a href="#state-encryption" target="_blank" rel="noopener noreferrer">State encryption</a> below.

## Session persistence<a href="#session-persistence" aria-label="Link to this section">#</a>

Use `--session-name` to automatically save and restore cookies and localStorage across browser restarts:


``` shiki
# Auto-save/load state for "twitter" session
agent-browser --session-name twitter open twitter.com

# Login once, then state persists automatically
agent-browser --session-name twitter click "#login"

# Or via environment variable
export AGENT_BROWSER_SESSION_NAME=twitter
agent-browser open twitter.com
```


State files are stored in `~/.agent-browser/sessions/` and automatically loaded on daemon start.

### Session name rules<a href="#session-name-rules" aria-label="Link to this section">#</a>

Session names must contain only alphanumeric characters, hyphens, and underscores:


``` shiki
# Valid session names
agent-browser --session-name my-project open example.com
agent-browser --session-name test_session_v2 open example.com

# Invalid (will be rejected)
agent-browser --session-name "../bad" open example.com    # path traversal
agent-browser --session-name "my session" open example.com # spaces
agent-browser --session-name "foo/bar" open example.com    # slashes
```


## State encryption<a href="#state-encryption" aria-label="Link to this section">#</a>

Encrypt saved state files (cookies, localStorage) using AES-256-GCM:


``` shiki
# Generate a 256-bit key (64 hex characters)
openssl rand -hex 32

# Set the encryption key
export AGENT_BROWSER_ENCRYPTION_KEY=<your-64-char-hex-key>

# State files are now encrypted automatically
agent-browser --session-name secure-session open example.com

# List states shows encryption status
agent-browser state list
```


## State auto-expiration<a href="#state-auto-expiration" aria-label="Link to this section">#</a>

Automatically delete old state files to prevent accumulation:


``` shiki
# Set expiration (default: 30 days)
export AGENT_BROWSER_STATE_EXPIRE_DAYS=7

# Manually clean old states
agent-browser state clean --older-than 7
```


## State management commands<a href="#state-management-commands" aria-label="Link to this section">#</a>


``` shiki
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


## Authenticated sessions<a href="#authenticated-sessions" aria-label="Link to this section">#</a>

Use `--headers` to set HTTP headers for a specific origin:


``` shiki
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

## Multiple origins<a href="#multiple-origins" aria-label="Link to this section">#</a>


``` shiki
agent-browser open api.example.com --headers '{"Authorization": "Bearer token1"}'
agent-browser open api.acme.com --headers '{"Authorization": "Bearer token2"}'
```


## Global headers<a href="#global-headers" aria-label="Link to this section">#</a>

For headers on all domains:


``` shiki
agent-browser set headers '{"X-Custom-Header": "value"}'
```


## Environment variables<a href="#environment-variables" aria-label="Link to this section">#</a>

| Variable                          | Description                                        |
|-----------------------------------|----------------------------------------------------|
| `AGENT_BROWSER_SESSION`           | Browser session ID (default: "default")            |
| `AGENT_BROWSER_SESSION_NAME`      | Auto-save/load state persistence name              |
| `AGENT_BROWSER_ENCRYPTION_KEY`    | 64-char hex key for AES-256-GCM encryption         |
| `AGENT_BROWSER_STATE_EXPIRE_DAYS` | Auto-delete states older than N days (default: 30) |


Ask AI<span class="kbd hidden sm:inline-flex items-center gap-0.5 text-xs opacity-60 font-mono">⌘I</span>
