> Source: https://honcho.dev/docs/v3/documentation/reference/cli.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# CLI Reference

> Command-line interface for Honcho — inspect workspaces, peers, sessions, and memory from your terminal

## Install

```bash uv (recommended) theme={null}
uv tool install honcho-cli
```

```bash uvx (ephemeral) theme={null}
uvx honcho-cli
```

This only installs the `honcho` command. It does not start a server. Use `honcho start --setup` (Docker + an LLM provider key) when you want a local stack.

## Quick Start

```bash theme={null}
honcho init                 # Honcho API key or browser login + server URL (talk *to* Honcho)
honcho start --setup basic  # local stack: LLM provider key + Docker (not set by init)
honcho doctor               # verify your config + connectivity
honcho                      # show banner + command list
```

`honcho init` authenticates the CLI against a Honcho server. It does **not** configure the LLM key a local stack needs — that is `honcho start --setup`.

## Local stack

`honcho start --setup basic` is the fastest way to run Honcho on your machine. It does **not** require cloning the Honcho repo. The wizard prompts for an LLM provider and API key, writes them into the profile `.env`, pulls `ghcr.io/plastic-labs/honcho:latest`, **pins that digest**, and starts API + deriver + Postgres + Redis via Docker.

Default profile is `local` (`--profile` / `HONCHO_PROFILE`). First start copies the image `config.toml.example` into the profile directory; later starts leave that file alone so your edits persist — including when you re-pin the image. Delete `config.toml` yourself if you want a fresh copy from a new image. Pass `--image` to pin a different tag or digest. Ports bind to `127.0.0.1`; if 8000/5432/6379 are taken, the CLI remaps them (or pass `--api-port` / `--db-port` / `--redis-port`). Auth is off (`AUTH_USE_AUTH=false`).

Pass `--setup basic` or `--setup advanced` for an interactive wizard that writes curated LLM/feature overrides into the profile `.env` (environment variables win over `config.toml`). This is TTY-only. `basic` covers provider and chat model; `advanced` also covers embeddings, deriver/dialectic models, dreams, and deriver flush. Re-running `--setup` while the stack is up recreates the API and deriver containers.

This does **not** change `environmentUrl` in the shared config file. To talk to the local stack:

```bash theme={null}
HONCHO_BASE_URL=http://127.0.0.1:8000 honcho workspace list
honcho init --base-url http://127.0.0.1:8000   # persist local as the CLI default
```

```bash theme={null}
honcho start --setup basic
honcho start --setup advanced
LLM_OPENAI_API_KEY=sk-... honcho start   # skip the wizard if the key is already in the env
honcho status
honcho stop            # keep data
honcho stop --wipe     # also delete volumes
```

To **develop the server** (live reload, from-source image), see [Local Environment Setup](https://honcho.dev/docs/v3/contributing/self-hosting.md).

## Configuration

The CLI resolves config in this order: **flag → env var → config file → default**.

| Value | File key | Env var | Flag | Persisted? |
| - | - | - | - | - |
| API key | `apiKey` | `HONCHO_API_KEY` | — | Yes |
| API URL | `environmentUrl` | `HONCHO_BASE_URL` | — | Yes |
| Workspace | — | `HONCHO_WORKSPACE_ID` | `-w` / `--workspace` | No |
| Peer | — | `HONCHO_PEER_ID` | `-p` / `--peer` | No |
| Session | — | `HONCHO_SESSION_ID` | `-s` / `--session` | No |
| JSON output | — | `HONCHO_JSON` | `--json` | No |
| Update nag | — | `HONCHO_NO_UPDATE_CHECK` | — | No |
| Local stack | — | `HONCHO_PROFILE` | `--profile` | No |

### Persisted config

The CLI shares `~/.honcho/config.json` with sibling Honcho tools. It owns
`apiKey` and `environmentUrl` at the top level — everything else (`hosts`,
`sessions`, etc.) is written by other tools and left untouched on save.
On managed servers that advertise the device grant in OAuth metadata,
`honcho init` can log you in via the browser; tokens auto-refresh
and are stored under `oauth` without deleting a shared `apiKey`.

```json theme={null}
{
  "apiKey": "hch-v3-...",
  "environmentUrl": "https://api.honcho.dev",
  "hosts": { "claude_code": { "...": "..." } }
}
```

> [!NOTE]
>
> Per-command targeting (workspace / peer / session) is handled via `-w` / `-p` / `-s`
> flags or `HONCHO_*` env vars. **Not** persisted as CLI defaults. This is
> deliberate: every invocation is explicit about what it operates on.

### Runtime overrides

Workspace, peer, and session targeting are **per-command only** — pass flags or
`HONCHO_*` env vars on every invocation.

```bash theme={null}
# Per-command flags
honcho peer card -w prod -p user

# Or export once per shell
export HONCHO_WORKSPACE_ID=prod
export HONCHO_PEER_ID=user
honcho peer card

# One-off against a different server
HONCHO_BASE_URL=http://localhost:8000 honcho workspace list

# CI/CD — env vars only, no config file needed
export HONCHO_API_KEY=hch-v3-xxx
export HONCHO_BASE_URL=https://api.honcho.dev
honcho workspace list
```

## Output & exit codes

Every command adapts its output to the context:

* **TTY** — human-readable tables via Rich.
* **Piped or redirected** — JSON automatically (detected via `isatty`).
* **`--json` flag / `HONCHO_JSON=1`** — force JSON regardless of terminal.

Interactive sessions may print a one-line upgrade hint on stderr at most once a day when a newer `honcho-cli` is on PyPI (`uv tool upgrade honcho-cli`). JSON/piped output skips it; set `HONCHO_NO_UPDATE_CHECK=1` to disable it.

Collection commands emit JSON arrays; single-resource commands emit JSON objects. Errors are always structured:

```json theme={null}
{
  "error": {
    "code": "PEER_NOT_FOUND",
    "message": "Peer 'abc' not found in workspace 'my-ws'",
    "details": {"workspace_id": "my-ws", "peer_id": "abc"}
  }
}
```

| Exit code | Meaning |
| - | - |
| `0` | Success |
| `1` | Client error (bad input, resource not found) |
| `2` | Server error |
| `3` | Auth error (missing or invalid API key) |

CI pipelines and agent runtimes can branch on these without parsing stderr.

## Command reference

## honcho conclusion

List, search, create, and delete peer conclusions (Honcho's memory atoms).

> [accordion] create
>
> Create a conclusion.
>
> ```bash
> honcho conclusion create <content>
> ```
>
> **content** `string` *required*
>
> **--observer** `string`
>
> Observer peer ID.
>
> **--observed** `string`
>
> Observed peer ID.
>
> **--session** `string`
>
> Session context. Short alias: `-s`.

> [accordion] delete
>
> Delete a conclusion.
>
> ```bash
> honcho conclusion delete <conclusion_id>
> ```
>
> **conclusion\_id** `string` *required*
>
> **--observer** `string`
>
> Observer peer ID.
>
> **--observed** `string`
>
> Observed peer ID.
>
> **--yes** `boolean`
>
> Skip confirmation. Short alias: `-y`.

> [accordion] derived
>
> List the conclusions derived FROM a conclusion.
>
> Walks the reasoning tree upward (premise -> conclusion); `conclusion get`
> on a conclusion's source\_ids walks it downward. Worth checking before
> deleting or correcting a fact.
>
> ```bash
> honcho conclusion derived <conclusion_id>
> ```
>
> **conclusion\_id** `string` *required*
>
> **--limit** `number` (default: 10)
>
> Max results.

> [accordion] get
>
> Fetch conclusions by ID, from anywhere in the workspace.
>
> Pass a conclusion's source\_ids to see the premises it was derived from,
> and repeat to walk a reasoning chain down to the explicit facts it rests
> on. IDs that no longer exist are reported rather than failing the command.
>
> ```bash
> honcho conclusion get <conclusion_ids>
> ```
>
> **conclusion\_ids** `string` *required*

> [accordion] list
>
> List conclusions.
>
> ```bash
> honcho conclusion list
> ```
>
> **--observer** `string`
>
> Observer peer ID.
>
> **--observed** `string`
>
> Observed peer ID.
>
> **--limit** `number` (default: 10)
>
> Max results.
>
> **--level** `string`
>
> Only this reasoning level: explicit, deductive, inductive, contradiction.
>
> **--derived-from** `string`
>
> Only conclusions derived from this conclusion ID.
>
> **--cites** `string`
>
> Only explicit conclusions that cite this message ID as evidence.

> [accordion] search
>
> Semantic search over conclusions.
>
> ```bash
> honcho conclusion search <query>
> ```
>
> **query** `string` *required*
>
> **--observer** `string`
>
> Observer peer ID.
>
> **--observed** `string`
>
> Observed peer ID.
>
> **--top-k** `number` (default: 10)
>
> Max results.
>
> **--level** `string`
>
> Only this reasoning level: explicit, deductive, inductive, contradiction.

## honcho config

Inspect CLI configuration.

```bash theme={null}
honcho config
```

## honcho doctor

Verify config and connectivity. Scope with -w / -p to check workspace, peer, and queue health.

```bash theme={null}
honcho doctor
```

## honcho help

Show help message.

```bash theme={null}
honcho help
```

## honcho init

Set API key and server URL in \~/.honcho/config.json.

Press Enter to keep the current value or type a replacement.
Workspace / peer / session scoping is per-command via -w / -p / -s
or HONCHO\_\* env vars — never persisted.

```bash theme={null}
honcho init
```

**--api-key** `string`

API key (admin JWT).

**--base-url** `string`

Honcho API URL (e.g. [https://api.honcho.dev](https://api.honcho.dev), [http://localhost:8000](http://localhost:8000)).

## honcho install

Find the AI agents on this machine and add Honcho to them.

Claude Code, Hermes, OpenClaw and Pi get their Honcho plugin, and Codex the
Honcho MCP server and skill, each through the agent's own commands and the
API key in \~/.honcho/config.json. Other agents link to their setup guide.

```bash theme={null}
honcho install [<targets>]
```

**targets** `string`

**--list** `boolean`

Only show what was found; install nothing.

## honcho message

List, create, and get messages within a session.

> [accordion] create
>
> Create a message in a session.
>
> ```bash
> honcho message create <content>
> ```
>
> **content** `string` *required*
>
> **--peer** `string` *required*
>
> Peer ID of the message sender. Short alias: `-p`.
>
> **--metadata** `string`
>
> JSON metadata to associate with the message.
>
> **--session** `string`
>
> Session ID. Short alias: `-s`.

> [accordion] get
>
> Get a single message by ID.
>
> ```bash
> honcho message get <message_id>
> ```
>
> **message\_id** `string` *required*
>
> **--session** `string`
>
> Session ID. Short alias: `-s`.

> [accordion] list
>
> List messages in a session. Scoped to a peer with -p.
>
> ```bash
> honcho message list [<session_id>]
> ```
>
> **session\_id** `string`
>
> **--last** `number` (default: 20)
>
> Number of recent messages.
>
> **--reverse** `boolean`
>
> Show oldest first (default is newest first).
>
> **--brief** `boolean`
>
> Show only IDs, peer, token count, and created\_at (no content).
>
> **--peer** `string`
>
> Filter by peer ID. Short alias: `-p`.

## honcho peer

List, create, chat with, search, and manage peers and their representations.

> [accordion] card
>
> Get raw peer card content.
>
> ```bash
> honcho peer card [<peer_id>]
> ```
>
> **peer\_id** `string`
>
> **--target** `string`
>
> Target peer for relationship card.

> [accordion] chat
>
> Query the dialectic about a peer.
>
> ```bash
> honcho peer chat <query>
> ```
>
> **query** `string` *required*
>
> **--target** `string`
>
> Target peer for perspective.
>
> **--reasoning** `string`
>
> Reasoning level: minimal, low, medium, high, max. Short alias: `-r`.
>
> **--scope** `string`
>
> Recall only from this scope. Repeat or comma-separate for several (explicit conclusions only). Excludes -s and --sessions.
>
> **--sessions** `string`
>
> Recall only from these session IDs (repeat or comma-separate); explicit conclusions only. Excludes -s and --scope.
>
> **--evidence** `boolean`
>
> Also report what the answer was built from: the conclusions and messages read and the tools called.

> [accordion] create
>
> Create or get a peer.
>
> ```bash
> honcho peer create <peer_id>
> ```
>
> **peer\_id** `string` *required*
>
> **--observe-me** `boolean`
>
> Whether Honcho will form a representation of this peer. Negate with `--no-observe-me`.
>
> **--metadata** `string`
>
> JSON metadata to associate with the peer.

> [accordion] get-metadata
>
> Get metadata for a peer.
>
> ```bash
> honcho peer get-metadata [<peer_id>]
> ```
>
> **peer\_id** `string`

> [accordion] inspect
>
> Inspect a peer: card, session count, recent conclusions.
>
> ```bash
> honcho peer inspect [<peer_id>]
> ```
>
> **peer\_id** `string`

> [accordion] list
>
> List all peers in the workspace.
>
> ```bash
> honcho peer list
> ```

> [accordion] representation
>
> Get the formatted representation for a peer.
>
> ```bash
> honcho peer representation [<peer_id>]
> ```
>
> **peer\_id** `string`
>
> **--target** `string`
>
> Target peer to get representation about.
>
> **--search-query** `string`
>
> Semantic search query to filter conclusions.
>
> **--max-conclusions** `number`
>
> Maximum number of conclusions to include.

> [accordion] search
>
> Search a peer's messages.
>
> ```bash
> honcho peer search <query>
> ```
>
> **query** `string` *required*
>
> **--limit** `number` (default: 10)
>
> Max results.

> [accordion] set-metadata
>
> Set metadata for a peer.
>
> ```bash
> honcho peer set-metadata <metadata>
> ```
>
> **metadata** `string` *required*
>
> **--peer** `string`
>
> Peer ID (uses default if omitted). Short alias: `-p`.

## honcho scope

List, create, inspect, and manage scopes — named session sets that bound recall.

> [accordion] add-sessions
>
> Add existing sessions to a scope. History is backfilled asynchronously — poll `honcho scope status`.
>
> ```bash
> honcho scope add-sessions <name> <session_ids>
> ```
>
> **name** `string` *required*
>
> **session\_ids** `string` *required*

> [accordion] create
>
> Create or get a scope, optionally adding sessions to it.
>
> ```bash
> honcho scope create <name>
> ```
>
> **name** `string` *required*
>
> **--sessions** `string`
>
> Sessions to add (repeat or comma-separate). History backfills asynchronously; see `honcho scope status`.
>
> **--metadata** `string`
>
> JSON metadata to associate with the scope.

> [accordion] inspect
>
> Inspect a scope: metadata, member sessions, and backfill state.
>
> ```bash
> honcho scope inspect <name>
> ```
>
> **name** `string` *required*

> [accordion] list
>
> List scopes in the workspace.
>
> ```bash
> honcho scope list
> ```

> [accordion] remove-session
>
> Remove a session from a scope. Its conclusions are reconciled out asynchronously.
>
> ```bash
> honcho scope remove-session <name> <session_id>
> ```
>
> **name** `string` *required*
>
> **session\_id** `string` *required*

> [accordion] sessions
>
> List the sessions that are members of a scope (longest-standing first).
>
> ```bash
> honcho scope sessions <name>
> ```
>
> **name** `string` *required*

> [accordion] status
>
> Per-session backfill state. Recall through the scope is complete once nothing is pending.
>
> ```bash
> honcho scope status <name>
> ```
>
> **name** `string` *required*

## honcho session

List, inspect, view, create, delete, and manage conversation sessions and their peers.

> [accordion] add-peers
>
> Add peers to a session.
>
> ```bash
> honcho session add-peers <session_id> <peer_ids>
> ```
>
> **session\_id** `string` *required*
>
> **peer\_ids** `string` *required*

> [accordion] context
>
> Get session context (what an agent would see).
>
> ```bash
> honcho session context [<session_id>]
> ```
>
> **session\_id** `string`
>
> **--tokens** `number`
>
> Token budget.
>
> **--summary** `boolean` (default: true)
>
> Include summary. Negate with `--no-summary`.

> [accordion] create
>
> Create or get a session.
>
> ```bash
> honcho session create <session_id>
> ```
>
> **session\_id** `string` *required*
>
> **--peers** `string`
>
> Comma-separated peer IDs to add to the session.
>
> **--metadata** `string`
>
> JSON metadata to associate with the session.

> [accordion] delete
>
> Delete a session and all its data. Destructive — requires --yes or interactive confirm.
>
> ```bash
> honcho session delete [<session_id>]
> ```
>
> **session\_id** `string`
>
> **--yes** `boolean`
>
> Skip confirmation. Short alias: `-y`.

> [accordion] get-metadata
>
> Get metadata for a session.
>
> ```bash
> honcho session get-metadata [<session_id>]
> ```
>
> **session\_id** `string`

> [accordion] inspect
>
> Inspect a session: peers, message count, summaries, config.
>
> ```bash
> honcho session inspect [<session_id>]
> ```
>
> **session\_id** `string`

> [accordion] list
>
> List sessions in the workspace.
>
> ```bash
> honcho session list
> ```
>
> **--peer** `string`
>
> Filter by peer. Short alias: `-p`.

> [accordion] peers
>
> List peers in a session.
>
> ```bash
> honcho session peers [<session_id>]
> ```
>
> **session\_id** `string`

> [accordion] remove-peers
>
> Remove peers from a session.
>
> ```bash
> honcho session remove-peers <session_id> <peer_ids>
> ```
>
> **session\_id** `string` *required*
>
> **peer\_ids** `string` *required*

> [accordion] representation
>
> Get the representation of a peer within a session.
>
> ```bash
> honcho session representation <peer_id> [<session_id>]
> ```
>
> **peer\_id** `string` *required*
>
> **session\_id** `string`
>
> **--target** `string`
>
> Target peer (what peer\_id knows about target).
>
> **--search-query** `string`
>
> Semantic search query to filter conclusions.
>
> **--max-conclusions** `number`
>
> Maximum number of conclusions to include.

> [accordion] search
>
> Search messages in a session.
>
> ```bash
> honcho session search <query> [<session_id>]
> ```
>
> **query** `string` *required*
>
> **session\_id** `string`
>
> **--limit** `number` (default: 10)
>
> Max results.

> [accordion] set-metadata
>
> Set metadata for a session.
>
> ```bash
> honcho session set-metadata [<session_id>]
> ```
>
> **session\_id** `string`
>
> **--data** `string` *required*
>
> JSON metadata to set (e.g. '\{"key": "value"}'). Short alias: `-d`.

> [accordion] summaries
>
> Get session summaries (short + long).
>
> ```bash
> honcho session summaries [<session_id>]
> ```
>
> **session\_id** `string`

> [accordion] view
>
> View a session transcript as a chat log.
>
> Modes (pick one):
>
> * default / --last N: tail of the conversation (most recent N)
> * \--page N \[--size M]: page through the full transcript
> * \--all: every message
>
> Paging follows the requested order: --page 1 starts at the oldest message,
> or the newest with --reverse.
>
> Human mode prints a row-delimited table. JSON mode emits the message list
> (same shape as message list).
>
> ```bash
> honcho session view [<session_id>]
> ```
>
> **session\_id** `string`
>
> **--last** `number`
>
> Show only the N most recent messages (default when no --page/--all: 50).
>
> **--page** `number`
>
> 1-indexed page of the full transcript. Use for page 2+.
>
> **--size** `number`
>
> Messages per page; requires --page (1-100, default: 50).
>
> **--all** `boolean`
>
> Show the full transcript (every page).
>
> **--reverse** `boolean`
>
> Newest first (default is chronological: oldest at top).
>
> **--ids** `boolean`
>
> Include message IDs in the transcript.
>
> **--peer** `string`
>
> Filter by peer ID. Short alias: `-p`.

## honcho start

Start a local Honcho stack (API, deriver, Postgres, Redis).

Requires Docker. Uses cloud LLM providers. Does not change the CLI's
configured server URL — pass HONCHO\_BASE\_URL to talk to this stack.
`--setup basic` or `--setup advanced` runs an interactive config wizard.

```bash theme={null}
honcho start
```

**--profile** `string` (default: local)

Local stack profile name.

**--api-port** `string`

Host port for the API.

**--db-port** `string`

Host port for Postgres.

**--redis-port** `string`

Host port for Redis.

**--setup** `string`

Interactive config wizard: basic (provider/model) or advanced (embeddings, deriver, dialectic, dreams, flush).

**--image** `string`

Honcho image to pull and pin by digest (default: ghcr.io/plastic-labs/honcho:latest).

**--timeout** `string` (default: 180)

Seconds to wait for /health after compose up.

## honcho status

Show local stack endpoints and container health.

With no `--profile`, lists every stack under `~/.honcho/profiles/`.

```bash theme={null}
honcho status
```

**--profile** `string`

Limit to this profile. Omit to show every local stack.

## honcho stop

Stop the local stack started by `honcho start`. Keeps data unless --wipe.

```bash theme={null}
honcho stop
```

**--profile** `string` (default: local)

Local stack profile name.

**--wipe** `boolean`

Also delete volumes (Postgres data).

## honcho workspace

List, create, inspect, chat, delete, and search workspaces.

> [accordion] chat
>
> Query the dialectic across all peers in the workspace.
>
> ```bash
> honcho workspace chat <query>
> ```
>
> **query** `string` *required*
>
> **--reasoning** `string`
>
> Reasoning level: minimal, low, medium, high, max. Short alias: `-r`.
>
> **--scope** `string`
>
> Recall only from this scope. Repeat or comma-separate for several (explicit conclusions only). Excludes -s.
>
> **--evidence** `boolean`
>
> Also report what the answer was built from: the conclusions and messages read and the tools called.

> [accordion] create
>
> Create or get a workspace.
>
> ```bash
> honcho workspace create <workspace_id>
> ```
>
> **workspace\_id** `string` *required*
>
> **--metadata** `string`
>
> JSON metadata to associate with the workspace.

> [accordion] delete
>
> Delete a workspace. Use --dry-run first to see what will be deleted.
>
> Requires --yes to skip confirmation, or will prompt interactively.
> If sessions exist, requires --cascade to delete them first.
>
> ```bash
> honcho workspace delete <workspace_id>
> ```
>
> **workspace\_id** `string` *required*
>
> **--yes** `boolean`
>
> Skip confirmation prompt (for scripted/agent use). Short alias: `-y`.
>
> **--cascade** `boolean`
>
> Delete all sessions before deleting the workspace.
>
> **--dry-run** `boolean`
>
> Show what would be deleted without deleting.

> [accordion] inspect
>
> Inspect a workspace: peers, sessions, config.
>
> ```bash
> honcho workspace inspect [<workspace_id>]
> ```
>
> **workspace\_id** `string`

> [accordion] list
>
> List all accessible workspaces.
>
> ```bash
> honcho workspace list
> ```

> [accordion] queue-status
>
> Get queue processing status.
>
> ```bash
> honcho workspace queue-status
> ```
>
> **--observer** `string`
>
> Filter by observer peer.
>
> **--sender** `string`
>
> Filter by sender peer.

> [accordion] search
>
> Search messages across workspace.
>
> ```bash
> honcho workspace search <query>
> ```
>
> **query** `string` *required*
>
> **--limit** `number` (default: 10)
>
> Max results.

> [!NOTE]
>
> `honcho peer chat` covers peer chat only. [Workspace chat](https://honcho.dev/docs/v3/documentation/features/chat.md#workspace-chat) has no CLI command yet; use the API or SDKs.

## Workflows

### Inspect an unfamiliar workspace

When you pick up a workspace and need to orient — start broad, narrow to the peer and session you care about.

**1. Survey the workspace**

```bash theme={null}
honcho workspace inspect --json
honcho peer list --json
```

**2. Inspect a specific peer**

```bash theme={null}
honcho peer inspect <peer_id> --json
honcho peer card <peer_id> --json
```

**3. Review the peer's memory**

```bash theme={null}
honcho conclusion list --observer <peer_id> --json
honcho conclusion search "topic" --observer <peer_id> --json
```

**4. Debug a session**

```bash theme={null}
honcho session inspect <session_id> --json
honcho session view <session_id> --last 20
honcho session context <session_id> --json
honcho session summaries <session_id> --json
```

> [!TIP]
>
> `honcho session context` shows exactly what an agent would receive at inference time — check it before `honcho peer chat` if a response surprises you. `honcho session view` shows the raw transcript that context was built from; it prints content verbatim, so tag-delimited and multi-line messages appear exactly as stored.

### A peer isn't learning

If new messages aren't producing new conclusions, work down the diagnostic ladder.

```bash theme={null}
# Is observation enabled for this peer?
honcho peer inspect <peer_id> --json | jq '.configuration'

# Is the deriver actually processing?
honcho workspace queue-status --json

# Do any conclusions exist at all? Any for the expected topic?
honcho conclusion list --observer <peer_id> --json
honcho conclusion search "expected topic" --observer <peer_id> --json
```

### Session context looks wrong

When an agent's responses don't reflect what you expect it to know.

```bash theme={null}
honcho session context <session_id> --json
honcho session summaries <session_id> --json
honcho session view <session_id> --last 50
```

### Dialectic returns bad answers

When `honcho peer chat`, `honcho workspace chat`, or the dialectic API is hallucinating or missing context.

```bash theme={null}
# What does the peer card actually say?
honcho peer card <peer_id> --json

# Any conclusions for this topic?
honcho conclusion search "topic" --observer <peer_id> --json

# Reproduce the query against the CLI
honcho peer chat <peer_id> "what do you know about X?" --json

# Confine recall to a named scope
honcho peer chat <peer_id> "what happened here?" --scope my-project --json

# Cross-peer question — not tied to one peer
honcho workspace chat "what themes show up across peers?" --json
honcho workspace chat "what happened in this project?" --scope my-project --json
```

## Scripting & automation

Pipe commands into `jq` for inline transforms, or set `HONCHO_*` env vars for a CI/CD environment with no config file:

```bash theme={null}
# Pipe to jq
honcho peer list --json | jq '.[].id'
honcho workspace inspect --json | jq '.peers'

# Machine-parseable health check — exit code for CI, details for logs
honcho doctor --json

# CI/CD — env vars only, no ~/.honcho/config.json
export HONCHO_API_KEY=hch-v3-xxx
export HONCHO_BASE_URL=https://api.honcho.dev
honcho workspace list
```

Non-interactive onboarding:

```bash theme={null}
# Pre-seed via flags / env vars; init still prompts for anything missing
HONCHO_API_KEY=hch-v3-xxx honcho init --base-url https://api.honcho.dev
```


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
