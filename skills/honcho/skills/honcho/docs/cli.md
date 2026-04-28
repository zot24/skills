> Source: https://docs.honcho.dev/v3/documentation/reference/cli.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# CLI Reference

> Command-line interface for Honcho — inspect workspaces, peers, sessions, and memory from your terminal

## Install

<CodeGroup>
  ```bash uv (recommended)
  uv tool install honcho-cli
  ```

  ```bash uvx (ephemeral)
  uvx honcho-cli
  ```
</CodeGroup>

## Quick Start

```bash
honcho init        # confirm/set apiKey + Honcho URL in ~/.honcho/config.json
honcho doctor      # verify your config + connectivity
honcho             # show banner + command list
```

## Configuration

The CLI resolves config in this order: **flag → env var → config file → default**.

| Value       | File key         | Env var               | Flag                 | Persisted? |
| ----------- | ---------------- | --------------------- | -------------------- | ---------- |
| API key     | `apiKey`         | `HONCHO_API_KEY`      | —                    | Yes        |
| API URL     | `environmentUrl` | `HONCHO_BASE_URL`     | —                    | Yes        |
| Workspace   | —                | `HONCHO_WORKSPACE_ID` | `-w` / `--workspace` | No         |
| Peer        | —                | `HONCHO_PEER_ID`      | `-p` / `--peer`      | No         |
| Session     | —                | `HONCHO_SESSION_ID`   | `-s` / `--session`   | No         |
| JSON output | —                | `HONCHO_JSON`         | `--json`             | No         |

### Persisted config

The CLI shares `~/.honcho/config.json` with sibling Honcho tools. It owns only
`apiKey` and `environmentUrl` at the top level — everything else (`hosts`,
`sessions`, etc.) is written by other tools and left untouched on save.

```json
{
  "apiKey": "hch-v3-...",
  "environmentUrl": "https://api.honcho.dev",
  "hosts": { "claude_code": { "...": "..." } }
}
```


  Per-command scoping (workspace / peer / session) is handled via `-w` / `-p` / `-s`
  flags or `HONCHO_*` env vars. **Not** persisted as CLI defaults. This is
  deliberate: every invocation is explicit about what it operates on.


### Runtime overrides

Workspace, peer, and session scoping are **per-command only** — pass flags or
`HONCHO_*` env vars on every invocation.

```bash
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

Collection commands emit JSON arrays; single-resource commands emit JSON objects. Errors are always structured:

```json
{
  "error": {
    "code": "PEER_NOT_FOUND",
    "message": "Peer 'abc' not found in workspace 'my-ws'",
    "details": {"workspace_id": "my-ws", "peer_id": "abc"}
  }
}
```

| Exit code | Meaning                                      |
| --------- | -------------------------------------------- |
| `0`       | Success                                      |
| `1`       | Client error (bad input, resource not found) |
| `2`       | Server error                                 |
| `3`       | Auth error (missing or invalid API key)      |

CI pipelines and agent runtimes can branch on these without parsing stderr.

## Command reference

## honcho conclusion

List, search, create, and delete peer conclusions (Honcho's memory atoms).


    Create a conclusion.

    ```bash
    honcho conclusion create <content>
    ```

    <ParamField path="content" type="string" required />

    <ParamField path="--observer" type="string">
      Observer peer ID.
    </ParamField>

    <ParamField path="--observed" type="string">
      Observed peer ID.
    </ParamField>

    <ParamField path="--session" type="string">
      Session context. Short alias: `-s`.
    </ParamField>


    Delete a conclusion.

    ```bash
    honcho conclusion delete <conclusion_id>
    ```

    <ParamField path="conclusion_id" type="string" required />

    <ParamField path="--observer" type="string">
      Observer peer ID.
    </ParamField>

    <ParamField path="--observed" type="string">
      Observed peer ID.
    </ParamField>

    <ParamField path="--yes" type="boolean">
      Skip confirmation. Short alias: `-y`.
    </ParamField>


    List conclusions.

    ```bash
    honcho conclusion list
    ```

    <ParamField path="--observer" type="string">
      Observer peer ID.
    </ParamField>

    <ParamField path="--observed" type="string">
      Observed peer ID.
    </ParamField>

    <ParamField path="--limit" type="number" default="10">
      Max results.
    </ParamField>


    Semantic search over conclusions.

    ```bash
    honcho conclusion search <query>
    ```

    <ParamField path="query" type="string" required />

    <ParamField path="--observer" type="string">
      Observer peer ID.
    </ParamField>

    <ParamField path="--observed" type="string">
      Observed peer ID.
    </ParamField>

    <ParamField path="--top-k" type="number" default="10">
      Max results.
    </ParamField>


## honcho config

Inspect CLI configuration.

```bash
honcho config
```

## honcho doctor

Verify config and connectivity. Scope with -w / -p to check workspace, peer, and queue health.

```bash
honcho doctor
```

## honcho help

Show help message.

```bash
honcho help
```

## honcho init

Set API key and server URL in \~/.honcho/config.json.

Press Enter to keep the current value or type a replacement.
Workspace / peer / session scoping is per-command via -w / -p / -s
or HONCHO\_\* env vars — never persisted.

```bash
honcho init
```

<ParamField path="--api-key" type="string">
  API key (admin JWT).
</ParamField>

<ParamField path="--base-url" type="string">
  Honcho API URL (e.g. [https://api.honcho.dev](https://api.honcho.dev), [http://localhost:8000](http://localhost:8000)).
</ParamField>

## honcho message

List, create, and get messages within a session.


    Create a message in a session.

    ```bash
    honcho message create <content>
    ```

    <ParamField path="content" type="string" required />

    <ParamField path="--peer" type="string" required>
      Peer ID of the message sender. Short alias: `-p`.
    </ParamField>

    <ParamField path="--metadata" type="string">
      JSON metadata to associate with the message.
    </ParamField>

    <ParamField path="--session" type="string">
      Session ID. Short alias: `-s`.
    </ParamField>


    Get a single message by ID.

    ```bash
    honcho message get <message_id>
    ```

    <ParamField path="message_id" type="string" required />

    <ParamField path="--session" type="string">
      Session ID. Short alias: `-s`.
    </ParamField>


    List messages in a session. Scoped to a peer with -p.

    ```bash
    honcho message list [<session_id>]
    ```

    <ParamField path="session_id" type="string" />

    <ParamField path="--last" type="number" default="20">
      Number of recent messages.
    </ParamField>

    <ParamField path="--reverse" type="boolean">
      Show oldest first (default is newest first).
    </ParamField>

    <ParamField path="--brief" type="boolean">
      Show only IDs, peer, token count, and created\_at (no content).
    </ParamField>

    <ParamField path="--peer" type="string">
      Filter by peer ID. Short alias: `-p`.
    </ParamField>


## honcho peer

List, create, chat with, search, and manage peers and their representations.


    Get raw peer card content.

    ```bash
    honcho peer card [<peer_id>]
    ```

    <ParamField path="peer_id" type="string" />

    <ParamField path="--target" type="string">
      Target peer for relationship card.
    </ParamField>


    Query the dialectic about a peer.

    ```bash
    honcho peer chat <query>
    ```

    <ParamField path="query" type="string" required />

    <ParamField path="--target" type="string">
      Target peer for perspective.
    </ParamField>

    <ParamField path="--reasoning" type="string">
      Reasoning level: minimal, low, medium, high, max. Short alias: `-r`.
    </ParamField>


    Create or get a peer.

    ```bash
    honcho peer create <peer_id>
    ```

    <ParamField path="peer_id" type="string" required />

    <ParamField path="--observe-me" type="boolean">
      Whether Honcho will form a representation of this peer. Negate with `--no-observe-me`.
    </ParamField>

    <ParamField path="--metadata" type="string">
      JSON metadata to associate with the peer.
    </ParamField>


    Get metadata for a peer.

    ```bash
    honcho peer get-metadata [<peer_id>]
    ```

    <ParamField path="peer_id" type="string" />


    Inspect a peer: card, session count, recent conclusions.

    ```bash
    honcho peer inspect [<peer_id>]
    ```

    <ParamField path="peer_id" type="string" />


    List all peers in the workspace.

    ```bash
    honcho peer list
    ```


    Get the formatted representation for a peer.

    ```bash
    honcho peer representation [<peer_id>]
    ```

    <ParamField path="peer_id" type="string" />

    <ParamField path="--target" type="string">
      Target peer to get representation about.
    </ParamField>

    <ParamField path="--search-query" type="string">
      Semantic search query to filter conclusions.
    </ParamField>

    <ParamField path="--max-conclusions" type="number">
      Maximum number of conclusions to include.
    </ParamField>


    Search a peer's messages.

    ```bash
    honcho peer search <query>
    ```

    <ParamField path="query" type="string" required />

    <ParamField path="--limit" type="number" default="10">
      Max results.
    </ParamField>


    Set metadata for a peer.

    ```bash
    honcho peer set-metadata <metadata>
    ```

    <ParamField path="metadata" type="string" required />

    <ParamField path="--peer" type="string">
      Peer ID (uses default if omitted). Short alias: `-p`.
    </ParamField>


## honcho session

List, inspect, create, delete, and manage conversation sessions and their peers.


    Add peers to a session.

    ```bash
    honcho session add-peers <session_id> <peer_ids>
    ```

    <ParamField path="session_id" type="string" required />

    <ParamField path="peer_ids" type="string" required />


    Get session context (what an agent would see).

    ```bash
    honcho session context [<session_id>]
    ```

    <ParamField path="session_id" type="string" />

    <ParamField path="--tokens" type="number">
      Token budget.
    </ParamField>

    <ParamField path="--summary" type="boolean" default="true">
      Include summary. Negate with `--no-summary`.
    </ParamField>


    Create or get a session.

    ```bash
    honcho session create <session_id>
    ```

    <ParamField path="session_id" type="string" required />

    <ParamField path="--peers" type="string">
      Comma-separated peer IDs to add to the session.
    </ParamField>

    <ParamField path="--metadata" type="string">
      JSON metadata to associate with the session.
    </ParamField>


    Delete a session and all its data. Destructive — requires --yes or interactive confirm.

    ```bash
    honcho session delete [<session_id>]
    ```

    <ParamField path="session_id" type="string" />

    <ParamField path="--yes" type="boolean">
      Skip confirmation. Short alias: `-y`.
    </ParamField>


    Get metadata for a session.

    ```bash
    honcho session get-metadata [<session_id>]
    ```

    <ParamField path="session_id" type="string" />


    Inspect a session: peers, message count, summaries, config.

    ```bash
    honcho session inspect [<session_id>]
    ```

    <ParamField path="session_id" type="string" />


    List sessions in the workspace.

    ```bash
    honcho session list
    ```

    <ParamField path="--peer" type="string">
      Filter by peer. Short alias: `-p`.
    </ParamField>


    List peers in a session.

    ```bash
    honcho session peers [<session_id>]
    ```

    <ParamField path="session_id" type="string" />


    Remove peers from a session.

    ```bash
    honcho session remove-peers <session_id> <peer_ids>
    ```

    <ParamField path="session_id" type="string" required />

    <ParamField path="peer_ids" type="string" required />


    Get the representation of a peer within a session.

    ```bash
    honcho session representation <peer_id> [<session_id>]
    ```

    <ParamField path="peer_id" type="string" required />

    <ParamField path="session_id" type="string" />

    <ParamField path="--target" type="string">
      Target peer (what peer\_id knows about target).
    </ParamField>

    <ParamField path="--search-query" type="string">
      Semantic search query to filter conclusions.
    </ParamField>

    <ParamField path="--max-conclusions" type="number">
      Maximum number of conclusions to include.
    </ParamField>


    Search messages in a session.

    ```bash
    honcho session search <query> [<session_id>]
    ```

    <ParamField path="query" type="string" required />

    <ParamField path="session_id" type="string" />

    <ParamField path="--limit" type="number" default="10">
      Max results.
    </ParamField>


    Set metadata for a session.

    ```bash
    honcho session set-metadata [<session_id>]
    ```

    <ParamField path="session_id" type="string" />

    <ParamField path="--data" type="string" required>
      JSON metadata to set (e.g. '\{"key": "value"}'). Short alias: `-d`.
    </ParamField>


    Get session summaries (short + long).

    ```bash
    honcho session summaries [<session_id>]
    ```

    <ParamField path="session_id" type="string" />


## honcho workspace

List, create, inspect, delete, and search workspaces.


    Create or get a workspace.

    ```bash
    honcho workspace create <workspace_id>
    ```

    <ParamField path="workspace_id" type="string" required />

    <ParamField path="--metadata" type="string">
      JSON metadata to associate with the workspace.
    </ParamField>


    Delete a workspace. Use --dry-run first to see what will be deleted.

    Requires --yes to skip confirmation, or will prompt interactively.
    If sessions exist, requires --cascade to delete them first.

    ```bash
    honcho workspace delete <workspace_id>
    ```

    <ParamField path="workspace_id" type="string" required />

    <ParamField path="--yes" type="boolean">
      Skip confirmation prompt (for scripted/agent use). Short alias: `-y`.
    </ParamField>

    <ParamField path="--cascade" type="boolean">
      Delete all sessions before deleting the workspace.
    </ParamField>

    <ParamField path="--dry-run" type="boolean">
      Show what would be deleted without deleting.
    </ParamField>


    Inspect a workspace: peers, sessions, config.

    ```bash
    honcho workspace inspect [<workspace_id>]
    ```

    <ParamField path="workspace_id" type="string" />


    List all accessible workspaces.

    ```bash
    honcho workspace list
    ```


    Get queue processing status.

    ```bash
    honcho workspace queue-status
    ```

    <ParamField path="--observer" type="string">
      Filter by observer peer.
    </ParamField>

    <ParamField path="--sender" type="string">
      Filter by sender peer.
    </ParamField>


    Search messages across workspace.

    ```bash
    honcho workspace search <query>
    ```

    <ParamField path="query" type="string" required />

    <ParamField path="--limit" type="number" default="10">
      Max results.
    </ParamField>


## Workflows

### Inspect an unfamiliar workspace

When you pick up a workspace and need to orient — start broad, narrow to the peer and session you care about.


    ```bash
    honcho workspace inspect --json
    honcho peer list --json
    ```


    ```bash
    honcho peer inspect <peer_id> --json
    honcho peer card <peer_id> --json
    ```


    ```bash
    honcho conclusion list --observer <peer_id> --json
    honcho conclusion search "topic" --observer <peer_id> --json
    ```


    ```bash
    honcho session inspect <session_id> --json
    honcho message list <session_id> --last 20 --json
    honcho session context <session_id> --json
    honcho session summaries <session_id> --json
    ```


  `honcho session context` shows exactly what an agent would receive at inference time — check it before `honcho peer chat` if a response surprises you.


### A peer isn't learning

If new messages aren't producing new conclusions, work down the diagnostic ladder.

```bash
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

```bash
honcho session context <session_id> --json
honcho session summaries <session_id> --json
honcho message list <session_id> --last 50 --json
```

### Dialectic returns bad answers

When `honcho peer chat` or the dialectic API is hallucinating or missing context.

```bash
# What does the peer card actually say?
honcho peer card <peer_id> --json

# Any conclusions for this topic?
honcho conclusion search "topic" --observer <peer_id> --json

# Reproduce the query against the CLI
honcho peer chat <peer_id> "what do you know about X?" --json
```

## Scripting & automation

Pipe commands into `jq` for inline transforms, or set `HONCHO_*` env vars for a CI/CD environment with no config file:

```bash
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

```bash
# Pre-seed via flags / env vars; init still prompts for anything missing
HONCHO_API_KEY=hch-v3-xxx honcho init --base-url https://api.honcho.dev
```
