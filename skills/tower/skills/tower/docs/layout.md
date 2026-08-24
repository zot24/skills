# Layout — workspaces, tabs, panes, and names

Distilled from a live tower's `herdr-fleet` skill and `docs/org-model.md`. herdr's own ID and
topology rules are in [herdr-skill-upstream.md](herdr-skill-upstream.md); this is the tower's
convention layered on top.

## The three primitives

Public IDs are opaque, stable handles — `w1` (workspace), `w1:t1` (tab), `w1:p1` (pane). Parse
them out of JSON responses; never derive them from sidebar order. Closed tab and pane IDs are
not reused, and a pane moved into another workspace gets a **new** workspace-qualified ID.

herdr injects the caller's context into every managed pane:

```bash
printf '%s\n' "$HERDR_WORKSPACE_ID" "$HERDR_TAB_ID" "$HERDR_PANE_ID"
```

Use those, or `--current`. Omitting a target may act on whatever pane some *other* client has
focused.

## One workspace per project

A workspace is a project. It carries the project's colour marker in its name so a glance at the
sidebar answers "which product is this". Do not create a workspace for a single task — create one
when a project is being *staffed*.

## One tab per checkout — an extra tab means an extra worktree

**This is the rule people break first.** Roles are splits, not tabs.

- Same repo checkout → **split** the home tab. A `main` checkout never gets a tab-per-kind or a
  tab-per-dispatch.
- A **second task on a different branch** → `herdr tab create`, `--cwd` pointed at a **git
  worktree** for that branch, labelled for the *task* (`rebase · #994`), not for a role.

```bash
# same checkout → split on the home tab
herdr pane split --pane <home> --direction right --cwd <repo> --no-focus

# different branch → new tab, cwd is the worktree
git -C <repo> worktree add -b <branch> .worktrees/<name> origin/main
herdr tab create --workspace <wN> --cwd <repo>/.worktrees/<name> \
  --label "<task> · <branch>" --no-focus
```

herdr can also do the checkout for you: `herdr worktree create` / `open` / `list` / `remove`
manage worktree-backed workspaces directly.

Two agents editing one checkout on two branches is how a fleet loses work: one agent's
`git checkout` silently rewrites the other's working tree mid-edit. The worktree is not
ceremony, it is the isolation.

## Pane layout inside a tab

Developers on top, supervision beneath, so a human watches work and review side by side.

```
wX  <marker> <project>  ── one tab
┌───────────────┬────────────────┐
│ dev · <task>  │ dev·k3 · <task>│   ← 1..N developers
├───────────────┼────────────────┤
│ mentor · …    │ pm · …         │   ← supervision (+ reviewer pane when active)
└───────────────┴────────────────┘
```

Build it developer first, then split right for the mentor, then down for the PM. Split a **wide**
pane to the right and a **narrow or tall** pane down; avoid repeated same-direction splits that
produce unusable slivers. `herdr pane layout --pane <id>` tells you which you have.

```bash
herdr pane split <pane> --direction right --ratio 0.5 --cwd <repo> --no-focus
herdr pane split <pane> --direction down  --ratio 0.5 --cwd <repo> --no-focus
herdr pane move  <pane> --tab <tab> --split right --target-pane <p> --ratio 0.5   # fold a stray tab in
```

Always `--no-focus` for background work. The human's focus is theirs.

## Name every pane

**Label a pane before its first prompt.** An agent name says *who* it is; a pane label says
*what it is on right now*, and labels render on the pane borders — so a glance at the grid
answers "what is this fleet working on".

```bash
herdr pane rename wX:p1 "dev · lead-convert audit"
herdr pane rename wX:p3 "mentor · reviews both"
herdr pane rename wX:p5 "🗼 tower"
```

Format: `role · what it is doing`, with the kind appended when it is not the default
(`dev·k3`, `dev·grok`). Keep it short enough to survive a narrow pane.

**Relabelling is part of dispatching work**, done by whoever hands the agent its new task — the
mentor releasing a cycle, the tower re-tasking a warm agent. A pane still carrying last week's
label is worse than a blank one, because it is confidently wrong.

Agent names are a separate namespace: `[a-z][a-z0-9_-]{0,31}`, unique among live agents. A name
follows the current pane occupant and is cleared when that agent exits or is replaced.

## Don't

- Don't open a second tab on the same checkout — an extra tab means an extra worktree.
- Don't create a workspace unless you are staffing a project.
- Don't leave idle unnamed splits lying around; close them ([closing](closing.md)).
- Don't dump full herdr JSON into the tower's context — filter with `jq -c`.
- Don't close workspaces, tabs, panes, or sessions you did not create unless asked.
