# CLI reference — the herdr surface a tower uses

**The installed binary is the authority.** Everything below was checked against `herdr 0.7.5` on
macOS — command groups from running the group with no subcommand (`herdr agent`, `herdr pane`, …),
leaf flags from `-h` where the leaf implements it (`herdr pane split -h`, `herdr agent start -h`)
and otherwise from `herdr api schema --json`, which carries the parameter set for every socket-API
method. Re-check after an update.

**Do not probe a mutating leaf by omitting arguments**: `herdr workspace create` is valid with
defaults and will execute. And never run bare `herdr` for discovery; it launches or attaches the
TUI.

Most commands return JSON on stdout. Server errors are JSON on stderr with exit status 1; CLI
syntax errors exit 2.

## Gate

```bash
test "${HERDR_ENV:-}" = 1
```

If this fails you are not inside herdr — say so and stop controlling the session. herdr also
injects `HERDR_WORKSPACE_ID`, `HERDR_TAB_ID`, and `HERDR_PANE_ID` into every managed pane.

## Discovery

```bash
herdr --version
herdr workspace list
herdr tab list --workspace "$HERDR_WORKSPACE_ID"
herdr pane list --workspace "$HERDR_WORKSPACE_ID"
herdr pane current --current
herdr agent list
```

Filter before it reaches your context:

```bash
herdr agent list | jq -c '.result.agents[] | {name, agent:.agent, agent_status, pane_id, tab_id, cwd}'
```

## Command groups (v0.7.5)

| Group | Subcommands |
|---|---|
| `workspace` | `list get create focus rename close report-metadata` |
| `worktree` | `list create open remove` — git-worktree-backed workspaces |
| `tab` | `list get create focus rename close` |
| `pane` | `list current get layout process-info neighbor edges focus resize zoom read rename split swap move close send-text send-keys wait-output run report-agent report-agent-session release-agent report-metadata` |
| `agent` | `list get read send-keys prompt rename focus wait attach start explain` |
| `session` | named persistent sessions (`herdr --session <name>`) |
| `api` | `snapshot`, `schema [--json\|--output PATH]` — live state and the socket-API schema |
| `integration` / `notification` / `config` / `channel` | installed integrations, notifications, config, update channel |

## Layout

```bash
herdr pane split [PANE_ID] [--pane <ID>|--current] [--direction right|down] \
                 [--ratio <FLOAT>] [--cwd <PATH>] [--env KEY=VALUE] [--focus|--no-focus]
herdr pane rename <pane_id> "<role> · <task>"
herdr pane move   <pane_id> ...            # destination flags; check `herdr pane move -h`
herdr pane close  <pane_id>

herdr tab create --workspace <wN> --cwd <path> --label "<task> · <branch>" --no-focus
herdr tab close  <tab_id>
herdr workspace close <wN>
```

New pane ID is `.result.pane.pane_id`. `tab create` returns `.result.tab` and
`.result.root_pane`; `workspace create` returns `.result.workspace`, `.result.tab`, and
`.result.root_pane`. After `pane move`, continue with `.result.move_result.pane.pane_id` — the
old ID (`.result.move_result.previous_pane_id`) only still resolves for the moved process's own
inherited context, so it is not a general target.

Use `--no-focus` for anything the human did not ask to be switched to.

## Agents

```bash
herdr agent start <name> --kind <KIND> --pane <ID> [--timeout <MS>] [-- <agent-args>...]
```

`--kind` accepts a fixed installed list — on 0.7.5: `pi, claude, codex, gemini, cursor, devin,
agy, cline, omp, mastracode, opencode, copilot, kimi, kiro, droid, amp, grok, hermes, kilo,
qodercli, maki`. **Do not invent kinds**; read the list from `herdr agent start -h`.

The pane must already be at an interactive shell prompt with no foreground command. `agent start`
never creates or moves layout, and returns only once herdr has detected the expected agent in
that same pane (default 30s startup timeout, max 300000ms). Native agent flags go **after `--`**.

```bash
herdr agent prompt <target> "<text>" [--wait] [--until <STATUS>] [--timeout <MS>]
herdr agent get    <target>
herdr agent wait   <target> [--until idle|working|blocked|done|unknown] [--timeout <MS>]
herdr agent read   <target> --source recent-unwrapped --format text --lines 40
herdr agent send-keys <target> enter|esc|ctrl+c
herdr agent explain <target>
herdr agent rename <pane_id|name> <new-name>
```

`agent prompt` atomically submits the text plus Enter, honouring the pane's bracketed-paste mode.
From a non-working state, `--wait` first requires an observed lifecycle change within 5000ms or
it returns `agent_prompt_stalled`. **It tracks lifecycle state, not turns** — if the agent is
already working, that *existing* turn's completion can satisfy the wait. That is exactly why the
tower's completion signal is a marker file and not a wait.

Targets are a unique live agent name or the pane ID currently hosting it — never a terminal ID or
a bare kind. Names match `[a-z][a-z0-9_-]{0,31}`.

`agent explain` before clearing any `blocked` state: it tells you *why* herdr thinks the agent is
blocked, so you do not approve a prompt that spends budget.

## Reading output

`--source` picks the snapshot: `visible` (rendered viewport) · `recent` (recent output with soft
wraps) · `recent-unwrapped` (soft wraps joined — **prefer this** for logs and transcripts) ·
`detection` (the plain-text bottom-buffer snapshot herdr uses for agent detection). Use
`--format ansi` only when colour is evidence.

If raising `--lines` stops revealing more, the agent is on the terminal's **alternate screen**.
Rows that leave it never enter herdr's host scrollback and no line count recovers them — ask the
agent to write its full answer to a file and read the file. Which is the standing rule anyway:
the deliverable is a path, named in the spec.

## Running an ordinary command elsewhere

```bash
herdr pane split --current --direction right --cwd "$PWD" --no-focus
herdr pane run <pane_id> "just test"
herdr pane wait-output <pane_id> --match "test result" --timeout 120000
herdr pane read <pane_id> --source recent-unwrapped --lines 120
```

`pane wait-output` searches the selected snapshot immediately, so output that already exists can
match. `--match` is a literal substring; `--regex` is a Rust regex.

## Worktrees

```bash
herdr worktree list
herdr worktree create ...     # creates and opens a git worktree as a workspace
herdr worktree open   ...
herdr worktree remove ...
```

`worktree create` takes a repo `cwd`, the `branch` to create, its `base`, a checkout `path`, and
an optional workspace `label` — so herdr can do the `git worktree add` and open the workspace in
one step.

An extra tab means an extra worktree ([layout](layout.md)); these commands are the shortcut.

## Server-level — handle with care

```bash
herdr server reload-config    # reload config.toml in the running server — safe
herdr status server           # liveness
herdr --session <name>        # isolated named session for experiments
herdr server stop             # STOPS the server and every pane process
```

Never `server stop` from inside an active session unless that is explicitly the intent, and never
kill the main herdr process. See [closing](closing.md).
