# The gates file format

A gates file is a Markdown checklist. Each item is one observable outcome. The checker parses it,
runs the commands, flips the boxes, and writes the evidence back into the same file.

## The shape

```markdown
# Gates: <job name>

Scope: <one line>

- [ ] G1: <observable outcome>
  CHECK: <shell command>
  EXPECT: <line-anchored prefix token, or /regex/>
  EVIDENCE: pending

- [ ] G2: <another outcome>
  CHECK: <command>
  EXPECT: <line-anchored prefix token, or /regex/>
  EVIDENCE: pending
```

`templates/gates.md` holds this shape. Copy it and fill it in.

## The parts

| Part | Rule |
|---|---|
| `- [ ] G1: title` | One gate. The id is the token before the first colon. The rest is the title |
| `CHECK:` | A shell command. Indent it under the gate. Optional — omit it for a manual gate |
| `EXPECT:` | Line-anchored prefix at a token boundary, or `/regex/flags`. Optional. The success token must never be a suffix or interior substring of the failure token |
| `EVIDENCE:` | `pending` until the checker fills it, or your own quote for a manual gate |

The attribute lines must be indented. An unindented line that starts with `#` or `- ` ends the
current gate.

## How a gate passes

- **With `EXPECT`** — any trimmed line of combined stdout and stderr must **start with** the
  token, and the next character must be end-of-line or a non-word character (`[^A-Za-z0-9_]`).
  Or a `/regex/flags` must match the combined output. The exit code is ignored, because a
  useful check may exit non-zero by design.

  Worked example (`cited` / `undercited`, hit twice 2026-08-25):

  | Output line | EXPECT | Result |
  |---|---|---|
  | `ALL MET (4 met)` | `ALL MET` | PASS — space after the token |
  | `WORDS_OK     2393` | `WORDS_OK` | PASS — space after the token |
  | `undercited` | `cited` | FAIL — the line does not start with `cited` |
  | `under-swept` | `swept` | FAIL — the line does not start with `swept` |
  | `not-pushed` | `pushed` | FAIL — the line does not start with `pushed` |
  | `cited` | `cited` | PASS — exact line |
- **Without `EXPECT`** — the exit code decides. Zero passes.

On a pass the checker rewrites `- [ ]` to `- [x]` and replaces `EVIDENCE: pending` with the last two
non-empty output lines, joined by ` | ` and cut to 200 characters.

A gate counts as met only when the box is checked **and** the evidence is not `pending`. A hand-ticked
box with `EVIDENCE: pending` is unmet. That is the point of the format.

## Writing a gate that means something

- **Name the outcome, not the task.** "zot24/skills has an open PR for this work" beats "open a PR".
- **One outcome per gate.** A gate that checks two things tells you nothing when it fails.
- **Make the command cheap and repeatable.** The parent re-runs it later, on a different machine,
  after the fact.
- **Pin the `EXPECT` to something the command controls.** `echo checker-ok` at the end of a `test`
  is a stable marker. A version string is not.
- **Put the success token at the start of a line.** The checker does a line-anchored prefix
  match at a token boundary, not a substring search. `EXPECT: cited` passed on output
  `undercited` under containment (twice, 2026-08-25). A failure token must not *start with* the
  success token followed by a word character. `citation-ok` / `undercited` is safe; `cited` /
  `undercited` is not.
- **Prefer a check that fails when the work is undone.** A gate that passes on an empty repo is
  decoration.
- **Anchor `EVIDENCE: pending` greps.** `grep -q 'EVIDENCE: pending'` matches a marker line that
  says "no EVIDENCE: pending". Use
  `grep -qE '^[[:space:]]*EVIDENCE: pending[[:space:]]*$'`.
- **Assert a property of the work, not a transient state of the world.** A remote
  branch, a live PID, "the PR is still OPEN" as the proof that you opened one —
  those are world-state. They fail when the work *succeeds* (merge deletes the
  branch). See trap (b) below.
- **Scan credential *values*, never dictionary words.** `grep -E 'password|secret|api_key'`
  flags prose. See trap (c) below.

Add a final marker-completeness gate (copy from `templates/gates.md`):

```markdown
- [ ] G9: marker observed, not pending
  CHECK: test -f "$m" && ! grep -qE '^[[:space:]]*EVIDENCE: pending[[:space:]]*$' "$m" && echo marker-observed || echo marker-missing-or-pending
  EXPECT: marker-observed
  EVIDENCE: pending
```

Good:

```markdown
- [ ] G4: zot24/skills has an OPEN PR whose title names tower
  CHECK: gh pr list --repo zot24/skills --state open --json number,title --jq '[.[] | select(.title | test("tower";"i")) | .number] | if length>0 then "pr-open" else "none" end'
  EXPECT: pr-open
  EVIDENCE: pending
```

Weak:

```markdown
- [ ] G4: PR looks good
  CHECK: gh pr list --repo zot24/skills
  EVIDENCE: pending
```

The weak one passes whenever `gh` runs. It proves nothing about this job.

## Three traps that shipped 2026-08-25

Abstract rules did not survive contact. These three did. Copy the fixed shape,
not the slogan.

### (a) Self-referential `EVIDENCE: pending` grep — hit on thread #215

A completeness gate shipped as:

```bash
test -f "$m" && ! grep -q 'EVIDENCE: pending' "$m" && echo marker-observed
```

A **complete** marker whose evidence line read `no EVIDENCE: pending` contains
that substring. The gate failed the finished job. The substring `EVIDENCE: pending`
is not the same object as an unmet evidence attribute.

Fixed (this is what `templates/gates.md` ships):

```bash
test -f "$m" && ! grep -qE '^[[:space:]]*EVIDENCE: pending[[:space:]]*$' "$m" && echo marker-observed || echo marker-missing-or-pending
```

Only a whole attribute line of `EVIDENCE: pending` (optional indent, optional
trailing space) counts. Prose that *mentions* the phrase does not.

### (b) Transient world-state encoded as an invariant — hit on PR #224

A gate asserted "branch `fix/tower-gate-matching` still exists on the remote":

```bash
gh pr view fix/tower-gate-matching --json state -q .state
# EXPECT: OPEN
```

The owner merged. GitHub deleted the branch. The sweep had done nothing wrong.
The gate failed because success removed the thing it was watching.

That is a transient state of the world. A gate must assert a **property of the
work**.

| Wrong (world-state) | Right (property of the work) |
|---|---|
| Branch `fix/…` still exists | `main` contains the merge commit / PR state is `MERGED` |
| PID 41211 is running | the binary at this path is executable and its `--help` matches |
| "the PR is still OPEN" as proof you opened one | `gh pr view <n> --json number,title` names this change; state may be OPEN or MERGED |

Worked rewrite for a "we shipped a PR" gate after the merge is allowed:

```markdown
- [ ] G8: zot24/skills has PR #<n> for this change (OPEN or MERGED)
  CHECK: s=$(gh pr view <n> --json state,title -q '[.state,.title] | join(" ")'); echo "$s" | grep -qE '^(OPEN|MERGED) ' && echo pr-present || echo pr-absent
  EXPECT: pr-present
  EVIDENCE: pending
```

`OPEN` is a snapshot, not an invariant, unless the spec says "do not merge"
*and* the gate's job is to catch a merge. Even then, pin a PR *number* or a
title, not a branch that GitHub will delete.

### (c) Dictionary-word secret scanner — hit on digest Phase B, n=8 false positives

A gate used:

```bash
grep -rlE '(api[_-]?key|secret|password|Bearer [A-Za-z0-9]{20,}|sk-[A-Za-z0-9]{20,})'
```

It flagged 8 session digests whose only matches were the English phrases
**"offline password vault"** and **"NO new secret"**. Zero real credentials.
A security gate that cries wolf every run is one you learn to wave through,
and then it misses a real key.

Scan **values**, not words:

```bash
grep -RE '(ghp_[A-Za-z0-9]{36}|github_pat_[A-Za-z0-9_]{20,}|AKIA[0-9A-Z]{16}|xox[baprs]-[A-Za-z0-9-]{10,}|sk-[A-Za-z0-9]{20,}|eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}|(api[_-]?key|password)\s*=\s*["'\''][^"'\'']{16,}["'\''])'
```

| Match this | Do not match this |
|---|---|
| `ghp_` + 36 alphanumerics (GitHub PAT) | the word `password` |
| `AKIA` + 16 alphanumerics (AWS key id) | the word `secret` |
| `xox[baprs]-` Slack token | `api_key` as English |
| `sk-` + 20+ alphanumerics (vendor secret) | `NO new secret` |
| JWT `eyJ` header.payload.sig | `offline password vault` |
| `key="…"` / `password="…"` with 16+ chars | the bare identifier |

`Bearer` + a long token is a value. `Bearer` alone is a word. Keep the
length-bound token; drop the English.

## Manual gates

When no command can prove an outcome, omit `CHECK` and write the evidence yourself:

```markdown
- [ ] G5: the licence header survives the copy
  EVIDENCE: pending
```

Replace `pending` with a quote, a `file:line`, or a URL, and tick the box:

```markdown
- [x] G5: the licence header survives the copy
  EVIDENCE: skills/tower/scripts/gate-check.mjs:2 "Vendored from Leonxlnx/unlazy (MIT)"
```

`pending` is still unmet. The checker never fills a manual gate for you.

## Abandon, honestly

Delete nothing. Record the decision:

```markdown
ABANDON: G3 the upstream API exposes no endpoint for this
```

The id must match the gate id. An abandoned gate does not block exit 0, and the summary line counts
it separately: `ALL MET (4 met, 1 abandoned)`.

Abandoning is a decision that stays in the file. Deleting a gate hides one.

## Where the files live

With no file argument the checker looks in the current directory for `GATES.md`, then every
`gates/*.md`. Pass explicit paths when the gates live elsewhere.
