# Closing — panes, tabs, workspaces, and what never to close

A fleet that only grows becomes unreadable, and an unreadable fleet is one the tower stops
checking. But closing is destructive and asymmetric: a stale pane costs attention, a wrongly
closed one costs the context it held. Distilled from a live tower's `docs/org-model.md`
("Retiring agents") and `herdr-fleet` skill.

## Close one-shot panes when their marker exists

A pane created for a single task — an audit, a QA run, a census — is finished when its **marker
file exists and its deliverable has been read and verified**. Close it then. Leaving it is not
free: an idle pane with a stale label reads as live work.

**Read the pane record before any close.** Untitled, idle, or working is not evidence the pane
is leftover. Before `herdr pane close` or `herdr workspace close`, read: label,
`terminal_title`, agent name, `agent_session`, last `state_change_seq`, and any file that
pane wrote. Owner research and unnamed sessions stay. A live session id is a keep. Closing
without that read is a tower failure. Index: [herdr-fleet](herdr-fleet.md).

```bash
herdr pane close <pane_id>
herdr tab close <tab_id>        # a one-shot tab: its worktree task is done and merged/abandoned
```

There is no `herdr agent stop` — retiring an agent means closing its pane or tab. Audit before
you sweep:

```bash
herdr agent list | jq -c '.result.agents[] | {name, agent_status, pane_id, tab_id}'
```

Also close **empty shells** — panes whose `agent_status` is `unknown` with nothing running in
them. They are layout debt.

## Retire a long-lived agent only when all three hold

Warm agents are an asset and stale agents are noise, so the test is not "is it done" but
**"is there a plausible follow-up that would reuse this context?"**

1. The task is closed and its deliverable has been read **and verified**.
2. No queued or likely follow-up needs the context it holds.
3. The findings are durable elsewhere — a report, an issue, the wiki. **An agent whose only copy
   of the work is its own scrollback stays alive.**

Keep an agent warm while it holds expensive, still-relevant context: a `pr-audit` agent holding
every open PR diff, while those PRs are still open, is the type case.

**Reuse includes the human.** They attach to these sessions and work in them by hand, so an agent
is a live workspace someone may return to, not only a slot you dispatch into. **Default to
keeping. Propose the sweep, name each agent and why, and close only what is confirmed** — and
always ask before closing an agent that is `working` or `blocked`.

## When a workspace may close

A workspace is a project. Close it only when **that project's live and blocked threads are gone
or deferred in writing** — check the work graph, not your memory of it ([work-graph](work-graph.md)).

```bash
herdr workspace close <wN>
```

A workspace with a `blocked` thread in it is not finished; it is waiting. Closing it does not
resolve the edge, it hides it. Defer the thread explicitly, with a reason in the file, and *then*
the workspace may close.

## Do not `/exit` a whole space to pick up a plugin

Reloading configuration or a newly installed plugin does **not** require tearing down a space.
Restart only the panes that must reload:

```bash
herdr server reload-config      # picks up config.toml in the running server
```

Then restart the individual agents whose harness needs to re-read its plugin or settings — close
that pane, split a fresh one, `herdr agent start` again. Every other pane keeps its context.

`/exit`-ing a whole space to reload one plugin throws away every warm agent in it, including the
ones with the expensive context, and none of them needed the reload.

## Never

- **Never run `herdr server stop`** from an active session unless stopping the server and every
  pane process is the explicit intent.
- **Never kill the main herdr process.** Use a named session (`herdr --session <name>`) for
  experiments that need an isolated server.
- **Never close what you did not create** without being asked.

## Sweep cadence

Sweep at the end of a work session and whenever a project phase closes — not continuously.
Continuous sweeping is how a warm agent gets closed twenty minutes before the follow-up arrives.
