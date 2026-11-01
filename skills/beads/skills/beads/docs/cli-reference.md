> Source: https://beads.gascity.com/cli-reference/index.md

> ## Documentation Index
> Fetch the complete documentation index at: https://beads.gascity.com/llms.txt
> Use this file to discover all available pages before exploring further.

# CLI Reference

> Generated reference for every bd command

Generated from `bd help --docs-root`.

This reference covers all 118 live top-level `bd` commands. Regenerate it with:

```bash theme={null}
./scripts/generate-cli-docs.sh
```

## Global Flags

These flags apply to all commands:

```
      --actor string              Actor name for audit trail (default: $BEADS_ACTOR, git user.name, $USER)
      --cpu-profile               Generate CPU profile for performance analysis
      --database string           Run against a different server database for this invocation, without changing the project's configured database (proxied-server mode only)
      --db string                 Database path (default: auto-discover .beads/*.db). In proxied-server mode, a value that isn't an existing path is treated as a database name override (see --database)
  -C, --directory string          Change to this directory before running the command (like git -C)
      --dolt-auto-commit string   Dolt auto-commit policy (off|on|batch). 'on': commit after each write. 'batch': defer commits to bd dolt commit; uncommitted changes persist in the working set until then (a live batch-mode bd process also flushes on SIGTERM/SIGHUP, except in proxied-server mode, where bd dolt commit is the only flush point). In proxied-server mode the deferral covers the writes the CLI makes on that route, including config and version metadata; explicit commit points (bd batch, bd mol bond/pour/squash, bd mol wisp create, and the wisp half of bd mol burn) still commit, and a bd serve process on the same database is unaffected. Default: on. Override via config key dolt.auto-commit
      --global                    Use the global shared-server database (beads_global)
      --ignore-schema-skew        Proceed despite forward schema drift (some queries may fail)
      --json                      Output in JSON format
      --mem-profile string        Write heap profile to FILE on exit (also respects BEADS_MEM_PROFILE)
      --no-color                  Disable color output (also: NO_COLOR=1 or CLICOLOR=0)
  -q, --quiet                     Suppress non-essential output (errors only)
      --readonly                  Read-only mode: block write operations (for worker sandboxes)
      --sandbox                   Sandbox mode: disables Dolt auto-push
  -v, --verbose                   Enable verbose/debug output
```

## Commands

* [`bd admin`](https://beads.gascity.com/cli-reference/admin)
* [`bd ado`](https://beads.gascity.com/cli-reference/ado)
* [`bd assign`](https://beads.gascity.com/cli-reference/assign)
* [`bd audit`](https://beads.gascity.com/cli-reference/audit)
* [`bd backup`](https://beads.gascity.com/cli-reference/backup)
* [`bd batch`](https://beads.gascity.com/cli-reference/batch)
* [`bd blocked`](https://beads.gascity.com/cli-reference/blocked)
* [`bd bootstrap`](https://beads.gascity.com/cli-reference/bootstrap)
* [`bd branch`](https://beads.gascity.com/cli-reference/branch)
* [`bd children`](https://beads.gascity.com/cli-reference/children)
* [`bd close`](https://beads.gascity.com/cli-reference/close)
* [`bd comment`](https://beads.gascity.com/cli-reference/comment)
* [`bd comments`](https://beads.gascity.com/cli-reference/comments)
* [`bd compact`](https://beads.gascity.com/cli-reference/compact)
* [`bd completion`](https://beads.gascity.com/cli-reference/completion)
* [`bd config`](https://beads.gascity.com/cli-reference/config)
* [`bd conflicts`](https://beads.gascity.com/cli-reference/conflicts)
* [`bd context`](https://beads.gascity.com/cli-reference/context)
* [`bd cook`](https://beads.gascity.com/cli-reference/cook)
* [`bd count`](https://beads.gascity.com/cli-reference/count)
* [`bd create`](https://beads.gascity.com/cli-reference/create)
* [`bd create-form`](https://beads.gascity.com/cli-reference/create-form)
* [`bd defer`](https://beads.gascity.com/cli-reference/defer)
* [`bd delete`](https://beads.gascity.com/cli-reference/delete)
* [`bd dep`](https://beads.gascity.com/cli-reference/dep)
* [`bd diff`](https://beads.gascity.com/cli-reference/diff)
* [`bd doctor`](https://beads.gascity.com/cli-reference/doctor)
* [`bd dolt`](https://beads.gascity.com/cli-reference/dolt)
* [`bd duplicate`](https://beads.gascity.com/cli-reference/duplicate)
* [`bd duplicates`](https://beads.gascity.com/cli-reference/duplicates)
* [`bd edit`](https://beads.gascity.com/cli-reference/edit)
* [`bd epic`](https://beads.gascity.com/cli-reference/epic)
* [`bd events`](https://beads.gascity.com/cli-reference/events)
* [`bd export`](https://beads.gascity.com/cli-reference/export)
* [`bd federation`](https://beads.gascity.com/cli-reference/federation)
* [`bd find-duplicates`](https://beads.gascity.com/cli-reference/find-duplicates)
* [`bd flatten`](https://beads.gascity.com/cli-reference/flatten)
* [`bd forget`](https://beads.gascity.com/cli-reference/forget)
* [`bd formula`](https://beads.gascity.com/cli-reference/formula)
* [`bd gate`](https://beads.gascity.com/cli-reference/gate)
* [`bd gc`](https://beads.gascity.com/cli-reference/gc)
* [`bd github`](https://beads.gascity.com/cli-reference/github)
* [`bd gitlab`](https://beads.gascity.com/cli-reference/gitlab)
* [`bd graph`](https://beads.gascity.com/cli-reference/graph)
* [`bd heartbeat`](https://beads.gascity.com/cli-reference/heartbeat)
* [`bd history`](https://beads.gascity.com/cli-reference/history)
* [`bd hooks`](https://beads.gascity.com/cli-reference/hooks)
* [`bd human`](https://beads.gascity.com/cli-reference/human)
* [`bd import`](https://beads.gascity.com/cli-reference/import)
* [`bd info`](https://beads.gascity.com/cli-reference/info)
* [`bd init`](https://beads.gascity.com/cli-reference/init)
* [`bd init-safety`](https://beads.gascity.com/cli-reference/init-safety)
* [`bd jira`](https://beads.gascity.com/cli-reference/jira)
* [`bd kv`](https://beads.gascity.com/cli-reference/kv)
* [`bd label`](https://beads.gascity.com/cli-reference/label)
* [`bd linear`](https://beads.gascity.com/cli-reference/linear)
* [`bd link`](https://beads.gascity.com/cli-reference/link)
* [`bd lint`](https://beads.gascity.com/cli-reference/lint)
* [`bd list`](https://beads.gascity.com/cli-reference/list)
* [`bd mail`](https://beads.gascity.com/cli-reference/mail)
* [`bd memories`](https://beads.gascity.com/cli-reference/memories)
* [`bd merge-slot`](https://beads.gascity.com/cli-reference/merge-slot)
* [`bd metrics`](https://beads.gascity.com/cli-reference/metrics)
* [`bd migrate`](https://beads.gascity.com/cli-reference/migrate)
* [`bd migrate-personal`](https://beads.gascity.com/cli-reference/migrate-personal)
* [`bd mol`](https://beads.gascity.com/cli-reference/mol)
* [`bd note`](https://beads.gascity.com/cli-reference/note)
* [`bd notion`](https://beads.gascity.com/cli-reference/notion)
* [`bd onboard`](https://beads.gascity.com/cli-reference/onboard)
* [`bd orphans`](https://beads.gascity.com/cli-reference/orphans)
* [`bd ping`](https://beads.gascity.com/cli-reference/ping)
* [`bd preflight`](https://beads.gascity.com/cli-reference/preflight)
* [`bd prime`](https://beads.gascity.com/cli-reference/prime)
* [`bd priority`](https://beads.gascity.com/cli-reference/priority)
* [`bd promote`](https://beads.gascity.com/cli-reference/promote)
* [`bd provenance`](https://beads.gascity.com/cli-reference/provenance)
* [`bd prune`](https://beads.gascity.com/cli-reference/prune)
* [`bd purge`](https://beads.gascity.com/cli-reference/purge)
* [`bd q`](https://beads.gascity.com/cli-reference/q)
* [`bd query`](https://beads.gascity.com/cli-reference/query)
* [`bd quickstart`](https://beads.gascity.com/cli-reference/quickstart)
* [`bd ready`](https://beads.gascity.com/cli-reference/ready)
* [`bd recall`](https://beads.gascity.com/cli-reference/recall)
* [`bd reclaim`](https://beads.gascity.com/cli-reference/reclaim)
* [`bd recompute-blocked`](https://beads.gascity.com/cli-reference/recompute-blocked)
* [`bd remember`](https://beads.gascity.com/cli-reference/remember)
* [`bd rename`](https://beads.gascity.com/cli-reference/rename)
* [`bd rename-prefix`](https://beads.gascity.com/cli-reference/rename-prefix)
* [`bd reopen`](https://beads.gascity.com/cli-reference/reopen)
* [`bd repo`](https://beads.gascity.com/cli-reference/repo)
* [`bd restore`](https://beads.gascity.com/cli-reference/restore)
* [`bd rules`](https://beads.gascity.com/cli-reference/rules)
* [`bd schema`](https://beads.gascity.com/cli-reference/schema)
* [`bd search`](https://beads.gascity.com/cli-reference/search)
* [`bd serve`](https://beads.gascity.com/cli-reference/serve)
* [`bd set-state`](https://beads.gascity.com/cli-reference/set-state)
* [`bd setup`](https://beads.gascity.com/cli-reference/setup)
* [`bd ship`](https://beads.gascity.com/cli-reference/ship)
* [`bd show`](https://beads.gascity.com/cli-reference/show)
* [`bd sql`](https://beads.gascity.com/cli-reference/sql)
* [`bd stale`](https://beads.gascity.com/cli-reference/stale)
* [`bd state`](https://beads.gascity.com/cli-reference/state)
* [`bd status`](https://beads.gascity.com/cli-reference/status)
* [`bd statuses`](https://beads.gascity.com/cli-reference/statuses)
* [`bd supersede`](https://beads.gascity.com/cli-reference/supersede)
* [`bd swarm`](https://beads.gascity.com/cli-reference/swarm)
* [`bd sync`](https://beads.gascity.com/cli-reference/sync)
* [`bd tag`](https://beads.gascity.com/cli-reference/tag)
* [`bd todo`](https://beads.gascity.com/cli-reference/todo)
* [`bd types`](https://beads.gascity.com/cli-reference/types)
* [`bd unclaim`](https://beads.gascity.com/cli-reference/unclaim)
* [`bd undefer`](https://beads.gascity.com/cli-reference/undefer)
* [`bd update`](https://beads.gascity.com/cli-reference/update)
* [`bd upgrade`](https://beads.gascity.com/cli-reference/upgrade)
* [`bd vc`](https://beads.gascity.com/cli-reference/vc)
* [`bd version`](https://beads.gascity.com/cli-reference/version)
* [`bd where`](https://beads.gascity.com/cli-reference/where)
* [`bd worktree`](https://beads.gascity.com/cli-reference/worktree)


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
