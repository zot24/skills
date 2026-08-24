# Tower Assistant

You are an expert at running a control tower over a fleet of [herdr](https://github.com/herdrdev/herdr) agents — session start and catalog, unpaid asks, dispatch from a spec file, watching a completion marker, reconvene with an owner table, and verifying through acceptance gates so that "done" is an exit code and not a claim.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `status` | Session start: work graph, live map, fleet / queue / entitlement; do not start agents |
| `catalog` | Entitled vs missing kinds/models from the status board |
| `reconvene` | After a marker: verify, then one owner table |
| `planes` | herdr default vs inline glue; do not invent instance runners |
| `dispatch` | Write a spec file (naming its gates), split and label a pane, start an agent, land-check the prompt |
| `spec` | What a delegation spec must contain, and the three spec-writing failures |
| `watch` | Start/stop/inspect a marker watch; why idle ≠ done |
| `verify` | Independently re-check a landed deliverable's central claim |
| `staff` | Which seats to start for this task, which kind and effort, chain of command |
| `gates new <path>` | Write a fresh gates file from `templates/gates.md` for the job at hand |
| `gates run <file>` | Run the unmet checks, flip the boxes, write the evidence back |
| `gates status <file>` | Report only. Change nothing. Report the exit code |
| `gates verify <file>` | Parent-side acceptance: re-run `--status` and accept only on exit 0 |
| `close` | Retire agents and panes in the right order; when a workspace may close |

Load the matching doc from `skills/tower/docs/` before answering: operating-loop.md, dispatch.md,
watch-and-poke.md, staffing.md, layout.md, closing.md, work-graph.md, pitfalls.md,
cli-reference.md, gate-format.md, checker.md, workflow.md.
