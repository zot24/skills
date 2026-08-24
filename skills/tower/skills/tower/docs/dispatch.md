# Dispatch — from question to a working pane

Distilled from a live control tower's `CLAUDE.md` ("The one rule", "Delegation protocol",
"Guardrails every spec carries", "Writing specs") and its `herdr-fleet` skill.

## The one rule

**Delegate. Listen. Wait. Loop. Then talk.**

All project work goes to a herdr agent: coding, research, audits, migrations, production version
checks, log reads, and any judgement against a repo. The tower's own jobs are exactly six —
write the spec, launch the pane, land-check the prompt, watch the marker, verify a *finished*
deliverable, report a table to the owner.

The only inline exception is **one cheap fact needed to write the spec**: `gh pr view --json
number,title`, `git remote get-url`, an `ls` of a checkout. Not a second investigation, not a
log read, not a production SHA census. If it takes judgement, it is already a pane.

Work done inline burns the tower's context, is invisible in the fleet UI, and dies with the
session. Agents in panes are inspectable, persistent, and parallel.

If a PM pane is already live for the project, prompt the PM — never a worker. A one-shot with
no space still starts one worker; see [staffing](staffing.md).

## Planes

Ranked. Do not invent a runner this skill does not name.

| Rank | Plane | Use it for |
|---|---|---|
| 1 | **herdr** | Default for project work. Always for audits, deploys, version checks, any judgement against a repo |
| 0 | **inline** | One cheap fact to fill the spec: `gh`, `git`, `ls`. Not the investigation |

Other runners (local subagents, sandboxes, queues) are instance config. They are not this skill.
Short tower-local reads stay in this session; they are not the investigation.

## Step 1 — the spec is a file

Write the spec to a file before touching herdr. Prompts get truncated and echoed back into the
pane; files do not. The prompt itself is one line:

```
read the spec at <absolute-path> and follow it exactly.
Write the deliverable to <absolute-path>.
Write the completion marker to <absolute-path> when fully done.
```

**Name the deliverable as a file path, and a completion marker distinct from the deliverable
itself.** Scrollback is not a deliverable: agents that run on the terminal's alternate screen
lose it, and rows that leave the alternate screen never enter herdr's host scrollback, so no
`--lines` value can recover them.

Keep specs and markers outside the product repo — a scratchpad directory, or the project's wiki
topic for anything worth keeping.

## Step 2 — what a spec must contain

A spec that omits these hands the agent every unlisted gap as licence.

| Section | Why it is load-bearing |
|---|---|
| **The question** | One sentence. What decision does the answer change? |
| **The standard** | What counts as an answer — a number, a diff, a verdict, a file |
| **Repo path + project name** | Where the work lives. Colour is optional instance convention |
| **RoutingDecision** | Plane, kind, model if known, reason. Kind must be an installed herdr kind — do not invent one |
| **The deliverable path + marker path** | Both absolute, both distinct |
| **Verification contract** | The central claim, and how the tower re-checks it (`gh`, disk, DB) |
| **Read-only, or not** | Investigation and audit passes read and report. Say so. |
| **Phase A / Phase B** | A task that both investigates *and* changes gets split. Phase A ends in `STOP`; the owner decides; Phase B is released separately. |
| **Out of scope** | Do not do this |
| **Not yet specified** | In scope, undecided — **stop and ask.** The opposite instruction to out-of-scope, and a spec carrying only "out of scope" is missing half its boundary. |
| **Grading** | Every load-bearing claim VERIFIED / INFERRED / NOT DETERMINED |
| **`file:line` citations** | Without them a report is unfalsifiable prose |

Two more standing guardrails, written out because agents do not infer them:

- **Outward-facing actions stop and ask** — `git push`, force-push, merge, PR comment, label
  change, issue close — unless that action is the explicit point of the task.
- **A repo's own hooks are its rules working.** A hook that blocks an agent gets routed around
  properly, with a worktree, or surfaced to the human. Copying past it defeats the repo's guard.

## Step 3 — three spec-writing failures that cost real work

**1. Name the question, the standard, and the deliverable. Do not name the sources.**
A spec that lists the files an agent should read converts research into confirmation: it reads
what you named and finds what you expected. One agent said so outright — *"I read the corpus
directly rather than through the query tool, because the spec named specific files"* — and
returned five false findings. Ask for retrieval first.

**2. Verify the source before dispatching, not after.** Three times in one session an agent was
aimed at the wrong artefact: a project's *docs* instead of its code, then a fork instead of the
official repo, twice. Each round-trip cost a full agent run. One `ls`, `git ls-tree` or `grep`
beforehand would have caught all three.

**3. Rank hypotheses by likelihood and name the check that would confirm the top one.** Add
"say so if you cannot determine something" — it beats a confident guess every time.

## Step 4 — start the pane, labelled

Split on the home tab unless the task has its own worktree. Label **before** the first prompt:
agent names are for the CLI, pane labels are for the human looking at the grid.

```bash
herdr pane split --pane "$HERDR_PANE_ID" --direction right --ratio 0.42 --cwd <repo> --no-focus
herdr pane rename <new_pane_id> "<role> · <short-task>"      # from .result.pane.pane_id
herdr agent start <name> --kind <kind> --pane <new_pane_id> -- <agent-args>
```

Agent names match `[a-z][a-z0-9_-]{0,31}` and must be unique among live agents. Native agent
arguments go only after `--`. Common start argv:

| Kind | Start argv |
|---|---|
| claude | `-- --model opus` (effort set in-session) |
| grok | `-- --model grok-4.6 --reasoning-effort high` |
| pi | `-- --model grok-4.6 --thinking medium` |
| kimi | `-- --auto` — **required.** Without it kimi blocks on every tool call and looks idle. |
| hermes | `-- --model grok-4.6` |

**Do not invent kinds.** `herdr agent start --help` prints the installed list; anything outside
it is a guess. Omit `--permission-mode` and the harness default applies — passing the flag
*overrides* the user's own setting, which is how agents ended up starting in accept-edits.

Prefer reusing a warm idle agent with the right cwd and kind over a cold start, and rename its
pane to the new task when you do.

## Step 5 — land-check the prompt

`herdr agent prompt` with a long payload can time out, get backgrounded, and be killed before
delivery **while `send-keys` still returns `"ok"`**. A correction was once reported as sent and
never arrived.

```bash
herdr agent prompt <name> "read the spec at <abs> and follow it exactly. …"
herdr agent get <name>                       # agent_status must be `working`
herdr agent send-keys <name> enter           # only if it is still `idle`
```

`prompt` returning ok is not landed. The status check is the landing.

A live kimi sitting in ask-mode looks idle and stuck: `herdr agent prompt <name> "/auto"` once,
then land-check `working` again.

## Step 6 — then leave

Start the watch ([watch & poke](watch-and-poke.md)) and stop analysing in this chat. When the
marker lands, verify, then reconvene with two tables: the fleet table (every live agent, tab,
pane, run, and what is done / blocked / waiting) and the owner table in
[operating loop](operating-loop.md). Then the owner decides the next dispatch.

## Step 7 — relay, don't dump

The owner sees your summary, not the agent's report. Lead with what changes their decision, not
with a chronology. Corrections to your own earlier statements go first and plainly. Inherit the
three grades from the agents rather than flattening them, and name every ticket — "#917 (paying
customer blocked on Convert)", never a bare number.

## Step 8 — route the deliverable somewhere durable

A report that exists only under `reports/` has taught the system nothing. Route it into the
project's knowledge base, or the task is not closed. One tower measured this: 5 of 95 dated
reports were traceable in its corpus, all five from two days — the habit lapsed exactly as the
fleet scaled up.

Decisions the tower cannot make itself go to a single owner queue file, not into a loop log
nobody reads.
