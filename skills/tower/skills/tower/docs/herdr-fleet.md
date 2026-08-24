# herdr-fleet — house dispatch and supervise

**HOUSE.** Folded from the former house skill `herdr-fleet`. Dispatch/supervise. Not a
separate plugin. **Not** the official herdr CLI skill (`ogulcancelik/herdr`, install
separately). Official CLI contract: [herdr-skill-upstream.md](herdr-skill-upstream.md)
(synced pointer only).

This file is the index of fleet cuts already published, plus the leftovers that had no home.

| Cut | Where |
|---|---|
| `HERDR_ENV=1` gate | SKILL.md Quick Start; [cli-reference](cli-reference.md) |
| Delegate by default; prompt the PM, never a worker | [dispatch](dispatch.md) |
| Tower never prompts scout/mentor when a PM is live | [space-loop](space-loop.md), [staffing](staffing.md) |
| Labels before the first prompt; thread in the name | [layout](layout.md) |
| Home on `main`; implement on `herdr worktree` (`list` / `open` / `create`, not `git worktree add`) | [layout](layout.md) |
| Start argv per kind; do not invent kinds | [dispatch](dispatch.md) |
| Spec on disk; land-check `working`; send-keys Enter | [dispatch](dispatch.md) |
| Kind from status board ∩ pin file | [model-router](model-router.md) |
| Watch the marker; idle ≠ done | [watch & poke](watch-and-poke.md) |
| Verify the central claim | [verify-deliverable](verify-deliverable.md) |
| Retire panes and workspaces | [closing](closing.md) |

## Read progress

```bash
herdr agent read <name> --source recent-unwrapped --format text --lines 40
```

Prefer this over dumping full herdr JSON. Filter with `jq -c` when you must read `agent get`.
See [cli-reference](cli-reference.md).

## Probe the model inside a kind

After start, if the kind supports it and the pin file names a model, send the kind-native
switch. **Probe; do not invent.** Record NOT DETERMINED if unknown.

## Read the pane record before any close

Untitled, idle, or working is not evidence the pane is leftover. Before `herdr pane close` or
`herdr workspace close`, read: label, `terminal_title`, agent name, `agent_session`, last
`state_change_seq`, and any file that pane wrote. Owner research and unnamed sessions stay.
A live session id is a keep. Closing without that read is a tower failure.

Full close rules: [closing](closing.md).
