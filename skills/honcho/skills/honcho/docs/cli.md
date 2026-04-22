<!-- Source: https://docs.honcho.dev/v3/documentation/reference/cli + honcho-cli v0.1.0 source -->

# Honcho CLI Reference

> `honcho-cli` — a terminal for Honcho. Admin & debugging tool for Honcho workspaces.

## Installation

```bash
uv tool install honcho-cli    # persistent install
uvx honcho-cli                # ephemeral one-shot
```

## Quick Start

```bash
honcho init       # configure API key + server URL
honcho doctor     # verify connectivity
honcho            # display banner and available commands
```

## Configuration

Settings resolve in order: **flag > env var > config file > default**.

| Setting | Config Key | Env Var | Flag | Persisted |
|---------|-----------|---------|------|-----------|
| API key | `apiKey` | `HONCHO_API_KEY` | — | Yes |
| API URL | `environmentUrl` | `HONCHO_BASE_URL` | — | Yes |
| Workspace | — | `HONCHO_WORKSPACE_ID` | `-w` / `--workspace` | No |
| Peer | — | `HONCHO_PEER_ID` | `-p` / `--peer` | No |
| Session | — | `HONCHO_SESSION_ID` | `-s` / `--session` | No |
| JSON output | — | `HONCHO_JSON` | `--json` | No |

Config file: `~/.honcho/config.json` (stores `apiKey` and `environmentUrl`).

## Output & Exit Codes

**Output adapts by context:**
- TTY → human-readable Rich tables
- Piped/redirected → JSON automatically
- `--json` flag or `HONCHO_JSON=1` → force JSON

**Exit codes:**
- `0` — Success
- `1` — Client error (bad input, not found)
- `2` — Server error
- `3` — Auth error (missing/invalid API key)

## Global Options

| Flag | Short | Description |
|------|-------|-------------|
| `--json` | | Force JSON output |
| `--version` | `-V` | Show version |
| `--workspace` | `-w` | Override workspace ID |
| `--peer` | `-p` | Override peer ID |
| `--session` | `-s` | Override session ID |

---

## Top-Level Commands

### `honcho init`

Set API key and server URL. Interactive prompts in TTY; flags/env in non-interactive mode.

```bash
honcho init [--api-key <key>] [--base-url <url>]
```

### `honcho doctor`

Verify config and connectivity. Scope with `-w`/`-p` to check workspace, peer, and queue health.

```bash
honcho doctor
honcho doctor -w my-workspace -p user-123
```

**Checks**: Config file exists, API key configured, API connectivity, workspace reachable (if `-w`), queue health, peer exists (if `-p`).

### `honcho config`

Show current configuration (API key redacted).

```bash
honcho config
```

---

## `honcho workspace`

List, create, inspect, delete, and search workspaces.

### Commands

| Command | Description |
|---------|-------------|
| `list` | List all accessible workspaces |
| `create <id> [--metadata <json>]` | Create or get a workspace |
| `inspect [<id>]` | Inspect: peers, sessions, config |
| `delete <id> [--yes] [--cascade] [--dry-run]` | Delete a workspace (destructive) |
| `search <query> [--limit N]` | Search messages across workspace |
| `queue-status [--observer <id>] [--sender <id>]` | Get queue processing status |

### `workspace delete` flags

- `--yes` / `-y` — Skip confirmation
- `--cascade` — Delete all sessions first
- `--dry-run` — Preview what would be deleted

---

## `honcho peer`

List, create, chat with, search, and manage peers and their representations.

### Commands

| Command | Description |
|---------|-------------|
| `list` | List all peers in workspace |
| `create <id> [--observe-me/--no-observe-me] [--metadata <json>]` | Create or get a peer |
| `inspect [<id>]` | Inspect: card, session count, recent conclusions |
| `card [<id>] [--target <peer>]` | Get raw peer card content |
| `chat <query> [--target <peer>] [--reasoning <level>]` | Query the dialectic about a peer |
| `search <query> [--limit N]` | Search a peer's messages |
| `representation [<id>] [--target <peer>] [--search-query <q>] [--max-conclusions N]` | Get formatted peer representation |
| `get-metadata [<id>]` | Get peer metadata |
| `set-metadata <json> [-p <id>]` | Set peer metadata |

### `peer chat` reasoning levels

`minimal`, `low`, `medium`, `high`, `max` (via `--reasoning` / `-r`)

---

## `honcho session`

List, inspect, create, delete, and manage conversation sessions.

### Commands

| Command | Description |
|---------|-------------|
| `list [--peer <id>]` | List sessions (optionally filter by peer) |
| `create <id> [--peers <ids>] [--metadata <json>]` | Create or get a session |
| `inspect [<id>]` | Inspect: peers, message count, summaries, config |
| `context [<id>] [--tokens N] [--summary/--no-summary]` | Get session context (what an agent sees) |
| `summaries [<id>]` | Get short + long summaries |
| `delete [<id>] [--yes]` | Delete session and all data (destructive) |
| `peers [<id>]` | List peers in a session |
| `add-peers <session_id> <peer_ids...>` | Add peers to a session |
| `remove-peers <session_id> <peer_ids...>` | Remove peers from a session |
| `search <query> [<session_id>] [--limit N]` | Search messages in a session |
| `representation <peer_id> [<session_id>] [--target <peer>] [--search-query <q>] [--max-conclusions N]` | Get peer representation within session |
| `get-metadata [<id>]` | Get session metadata |
| `set-metadata [<id>] --data <json>` | Set session metadata |

---

## `honcho message`

List, create, and get messages within sessions.

### Commands

| Command | Description |
|---------|-------------|
| `list [<session_id>] [--peer <id>] [--last N] [--reverse] [--brief]` | List messages (default: last 20, newest at bottom) |
| `create <content> --peer <id> [--metadata <json>]` | Create a message (peer is required) |
| `get <message_id>` | Get a single message by ID |

### `message list` flags

- `--last N` — Number of recent messages (default: 20)
- `--reverse` — Show oldest first
- `--brief` — Show only IDs, peer, token count, timestamp (no content)
- `-p <id>` — Filter by peer

---

## `honcho conclusion`

List, search, create, and delete peer conclusions (memory atoms).

### Commands

| Command | Description |
|---------|-------------|
| `list [--observer <id>] [--observed <id>] [--limit N]` | List conclusions (default: 10) |
| `search <query> [--observer <id>] [--observed <id>] [--top-k N]` | Semantic search over conclusions |
| `create <content> [--observer <id>] [--observed <id>] [--session <id>]` | Create a conclusion |
| `delete <conclusion_id> [--observer <id>] [--observed <id>] [--yes]` | Delete a conclusion (destructive) |

**Note**: Requires an observer peer (from `--observer`, `-p`, or `HONCHO_PEER_ID`).

---

## Common Usage Patterns

### Scoping per command

```bash
honcho peer card -w prod -p user-123
honcho session context -w prod -s conv-1
```

### Export env vars for multiple commands

```bash
export HONCHO_WORKSPACE_ID=prod
export HONCHO_PEER_ID=user-123
honcho peer card
honcho conclusion list
```

### JSON piping with jq

```bash
honcho peer list --json | jq '.[].id'
honcho workspace inspect --json | jq '.peers'
```

### One-off server override

```bash
HONCHO_BASE_URL=http://localhost:8000 honcho workspace list
```

---

## Diagnostic Workflows

### Inspecting an unfamiliar workspace

```bash
honcho workspace inspect --json
honcho peer list --json
honcho peer inspect <peer_id> --json
honcho peer card <peer_id> --json
```

### When a peer isn't learning

```bash
honcho peer inspect <peer_id> --json | jq '.configuration'
honcho workspace queue-status --json
honcho conclusion list --observer <peer_id> --json
honcho conclusion search "topic" --observer <peer_id> --json
```

### When session context looks wrong

```bash
honcho session context <session_id> --json
honcho session summaries <session_id> --json
honcho message list <session_id> --last 50 --json
```

### When dialectic returns bad answers

```bash
honcho peer card <peer_id> --json
honcho conclusion search "topic" --observer <peer_id> --json
honcho peer chat "what do you know about X?" --json
```

---

## Destructive Operations

Three commands require `--yes/-y` to skip interactive confirmation:

1. **`workspace delete`** — Also supports `--dry-run` and `--cascade`
2. **`session delete`** — Shows preview (peers, message count) before confirming
3. **`conclusion delete`** — Shows id, observer, observed before confirming

## Error Codes

| Exception | Error Code | Exit |
|-----------|------------|------|
| Not found | `{RESOURCE}_NOT_FOUND` | 1 |
| Auth error | `AUTH_ERROR` | 3 |
| Permission denied | `PERMISSION_ERROR` | 3 |
| Server error | `SERVER_ERROR` | 2 |
| API error | `API_ERROR` | 1 |

## Input Validation

All resource IDs reject: empty strings, unsafe chars (`?#%`), control characters, path separators (`/\`), and path traversal (`..`).
