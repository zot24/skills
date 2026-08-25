# Boundaries and attribution

This skill is a thin wrapper. It takes one file from unlazy and the discipline around it, and
deliberately refuses the rest.

## What this skill takes

- `scripts/gate-check.mjs` — the checker, unmodified
- `templates/gates.md` — the gate file shape
- The rule: done is `--status` exiting `0`

## What this skill refuses

| Refused | Why |
|---|---|
| unlazy's **Stop hook** | It fights a herdr idle/done signal. Two things would decide when an agent is finished |
| unlazy **orchestrated mode** | The space PM owns dispatch. A second orchestrator competes with it |
| **depth-tree / subagent fan-out** | herdr worktrees already give isolation and parallelism |
| `npx skills add` | The checker is vendored on purpose. A network install can change under you |
| A **second checker** | Two checkers disagree eventually, and then "done" means nothing |

If you want behaviour the checker does not have, argue for it upstream or write a gate that calls
your own command. Do not fork the checker inside this skill.

## Attribution

`scripts/gate-check.mjs` is copyright (c) 2026 Leonxlnx, released under the MIT licence, and comes
from [Leonxlnx/unlazy](https://github.com/Leonxlnx/unlazy/blob/main/scripts/gate-check.mjs).

Two things travel with the file and must not be dropped:

1. The four-line header at the top of `gate-check.mjs`, which names the source and points at the
   licence.
2. `LICENSE.unlazy`, the upstream MIT text. It lives next to `SKILL.md` at the skill root.
   `scripts/` lives at the plugin root. They are sibling subtrees, not parent/child.
   The header's `../LICENSE.unlazy` is the upstream relative pointer, not this package's layout.

MIT requires the copyright notice and the permission notice in every copy. Moving the file without
them breaks the licence.

## Re-vendoring

The checker is copied by hand, not synced. `sync.json` carries an empty `sources` array for that
reason: an automated fetch would overwrite the attribution header.

To take a newer upstream version:

1. Read the upstream diff. Check whether the gate file format changed.
2. Copy the new file in.
3. Restore the four-line attribution header at the top.
4. Confirm `LICENSE.unlazy` still matches upstream's licence.
5. Run the checker against a known-green gates file and a known-red one. Both exit codes must be
   what you expect.
