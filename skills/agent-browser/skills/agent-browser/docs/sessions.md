> Source: https://agent-browser.dev/sessions



[](https://vercel.com "Made with love by Vercel")<span class="text-border"></span>[<span class="font-medium tracking-tight text-lg" style="font-family:var(--font-geist-pixel-square)">agent-browser</span>](/)


# Sessions

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


## Session isolation

Each session has its own:

- Browser instance
- Cookies and storage
- Navigation history
- Authentication state

## Persistent profiles

By default, browser state is lost when the browser closes. Use `--profile` to persist state across restarts:


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

## Session persistence

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

### Session name rules

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


## State encryption

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


## State auto-expiration

Automatically delete old state files to prevent accumulation:


``` shiki
# Set expiration (default: 30 days)
export AGENT_BROWSER_STATE_EXPIRE_DAYS=7

# Manually clean old states
agent-browser state clean --older-than 7
```


## State management commands


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


## Authenticated sessions

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

## Multiple origins


``` shiki
agent-browser open api.example.com --headers '{"Authorization": "Bearer token1"}'
agent-browser open api.acme.com --headers '{"Authorization": "Bearer token2"}'
```


## Global headers

For headers on all domains:


``` shiki
agent-browser set headers '{"X-Custom-Header": "value"}'
```


## Environment variables

| Variable                          | Description                                        |
|-----------------------------------|----------------------------------------------------|
| `AGENT_BROWSER_SESSION`           | Browser session ID (default: "default")            |
| `AGENT_BROWSER_SESSION_NAME`      | Auto-save/load state persistence name              |
| `AGENT_BROWSER_ENCRYPTION_KEY`    | 64-char hex key for AES-256-GCM encryption         |
| `AGENT_BROWSER_STATE_EXPIRE_DAYS` | Auto-delete states older than N days (default: 30) |


Ask AI<span class="kbd hidden sm:inline-flex items-center gap-0.5 text-xs opacity-60 font-mono">⌘K</span>
