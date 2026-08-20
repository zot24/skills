# The four-label pack

Every pull request carries four labels. One per slot. A missing slot makes the PR invisible to the
queries that triage uses.

| Slot | Values | Meaning |
|---|---|---|
| Type | `bug` \| `enhancement` \| `documentation` | What kind of change this is |
| Priority | `priority:critical` \| `priority:high` \| `priority:medium` | How soon it must land |
| Size | `t-shirt:small` \| `t-shirt:medium` \| `t-shirt:big` | How much review it needs |
| Area | that repo's existing `area:*` labels | Which part of the system moves |

---

## Type

| Label | Use it when |
|---|---|
| `bug` | The change repairs behaviour that was already wrong |
| `enhancement` | The change adds behaviour, or improves existing behaviour |
| `documentation` | The change touches prose, guides, or reference material only |

Pick one. A PR that fixes a bug and adds a feature is two PRs.

## Priority

| Label | Meaning |
|---|---|
| `priority:critical` | Production blocker |
| `priority:high` | Launch quality |
| `priority:medium` | Post-launch improvement |

## Size

| Label | Meaning |
|---|---|
| `t-shirt:small` | One file, or one obvious change |
| `t-shirt:medium` | Several files inside one area |
| `t-shirt:big` | Crosses areas, or changes a contract |

Size describes the review cost, not the line count. A one-line change to an authentication check is
`t-shirt:big`.

## Area — per repo

**`area:*` names differ per repo. Do not invent one.** Read the repo's labels first:

```bash
gh label list --limit 100
gh label list --limit 100 --search area
```

Pick from that output. When two areas fit, pick the one the reviewer owns.

When the repo carries no `area:*` label at all, set the other three slots. Say in the PR notes that
the repo defines no area labels. Do not create an `area:*` taxonomy inside a feature PR.

---

## Set the labels

At creation:

```bash
gh pr create --title "<title>" --body-file /tmp/pr-body.md \
  --label enhancement --label priority:high --label t-shirt:small --label area:api
```

On an open PR:

```bash
gh pr edit <number> --add-label priority:high --add-label t-shirt:medium
gh pr edit <number> --remove-label priority:medium
```

`gh pr create` fails when a label does not exist on the repo. Read the label list before you post.

---

## Create a missing slot

Create `priority:*` and `t-shirt:*` when the repo has neither. Use these names, colours, and
descriptions, so that queries work across repos.

```bash
gh label create "priority:critical" --color b60205 --description "Production blocker"
gh label create "priority:high"     --color d93f0b --description "Launch quality"
gh label create "priority:medium"   --color fbca04 --description "Post-launch improvement"

gh label create "t-shirt:small"  --color 1d76db
gh label create "t-shirt:medium" --color fbca04
gh label create "t-shirt:big"    --color b60205
```

`bug`, `enhancement`, and `documentation` ship with every new GitHub repo. Confirm they exist before
you create them.

---

## Query by label

```bash
gh pr list --label "priority:critical"
gh issue list --label "priority:high" --label "area:api"
```

These queries are the reason the pack exists. A PR with no priority label never appears in them.
