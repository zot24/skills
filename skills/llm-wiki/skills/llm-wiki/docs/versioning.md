<!-- Source: authored for this skill from https://github.com/nvk/llm-wiki (README changelog + tag history). Not CI-synced. -->

# Versioning, pinning, and upgrades

llm-wiki installs as a **git checkout of the upstream repo**, so the installed
version is whatever commit that checkout sits on. For Claude Code that is:

```bash
git -C ~/.claude/plugins/marketplaces/llm-wiki describe --tags
git -C ~/.claude/plugins/marketplaces/llm-wiki status --porcelain   # blank = no local edits
```

This matters more than it looks: a plugin "upgrade" is a checkout move, and a
downgrade is the same move in reverse. **The plugin is cheap to roll back. A
corpus is not.** Everything below is about telling those two apart.

## Pin to a tag instead of tracking HEAD

Every release is tagged. To pin deliberately:

```bash
git -C ~/.claude/plugins/marketplaces/llm-wiki fetch --tags
git -C ~/.claude/plugins/marketplaces/llm-wiki checkout <tag>
```

Pinning is the right default when a release line is actively churning. Compare
the checkout against upstream before deciding:

```bash
git -C ~/.claude/plugins/marketplaces/llm-wiki fetch origin
git -C ~/.claude/plugins/marketplaces/llm-wiki log --oneline HEAD..origin/master
git -C ~/.claude/plugins/marketplaces/llm-wiki diff --stat HEAD..origin/master
```

## Classify the diff before upgrading

Not all changes carry the same risk to an existing corpus. Rank them this way:

**Dangerous — may require a migration pass over existing content:**

- Frontmatter schema changes: a new *required* field, a renamed field, or a
  **removed** enum value for `type`, `kind`, `status`, or `priority`.
- `_index.md` format changes — check whether `references/indexing.md` moved.
- `raw/` ↔ `wiki/` layout changes, or removals from the lint allowlists in
  `references/linting.md`.
- Query-protocol changes — check `references/query-lite.md`.

**Safe — additive, and inert for wikis that do not use the feature:**

- New optional directories under a topic wiki (a new `inventory/` subtree, for
  example). A wiki with no `inventory/` layer at all is unaffected by every
  change to it.
- New *values appended* to an enum, new optional frontmatter fields, new
  commands, new reference files.
- Template additions to an `_index.md` shape you do not currently generate.

A quick way to see which class you are in — if these two files are absent from
the diff, no corpus migration is implied:

```bash
git -C <checkout> diff --name-only <old>..<new> -- \
  '*/references/indexing.md' '*/references/query-lite.md'
```

**Behavioral — nothing on disk changes, but the agent responds differently:**

- **Router priority changes** in `commands/wiki.md`. This is the most
  commonly missed class. The fuzzy router matches natural language in priority
  order, so moving a destructive command to priority 0 and widening its trigger
  phrases changes what an ordinary sentence does — with no schema change to
  warn you. Diff that table on every upgrade.
- Changes to `retract`, whose scope has grown from "remove one ingested source"
  into a control plane that can also span archives and session context.
  Retraction is dry-run-first and requires an explicit apply step, but it is
  the one workflow that is *designed* to override raw immutability, so read
  `commands/retract.md` before upgrading across it.
- New external-effect surfaces such as private adapters and governed remote
  writes. These are inert until an adapter is explicitly registered — the
  registry is machine-local (`~/.config/llm-wiki/`) and never lives in the hub —
  but confirm `/wiki:adapter list` is empty if you do not intend to use them.

## What to check first, after any upgrade

1. **Baseline the corpus.** Hubs are plain files; keep them in git and commit
   before the upgrade so any delta is attributable.
2. **`/wiki:lint` with no `--fix`, on one small topic.** Compare the report to
   the pre-upgrade one. `--fix` rewrites indexes; never make it the first
   post-upgrade action, and never run it hub-wide before a single-topic dry run.
3. **Re-run a known `/wiki:query`.** If `query-lite.md` did not change, the
   answer shape should not either. A difference here means the diff review
   missed something — stop and re-read it.
4. **`/wiki:adapter list`** — confirm it is empty unless you deliberately
   registered one.
5. **Re-read the router table** for anything that now matches phrases you use
   conversationally.

## Choosing a target when the newest release is churning

Read the README changelog top-down and find the last tag *before* the feature
line you do not want. Tags are cheap to sit on, and a release line that has
shipped several supersessions in quick succession — especially one whose own
changelog says a prior release is "superseded in current source" — is a signal
to pin behind it and re-evaluate once it stops moving. Take the features you
will actually use; skip the surface you will not.
