> Source: https://beads.gascity.com/index.md

> ## Documentation Index
> Fetch the complete documentation index at: https://beads.gascity.com/llms.txt
> Use this file to discover all available pages before exploring further.

# Introduction

> Dependency-aware, Dolt-backed issue tracker built for AI coding agents that survive context loss

**Beads** (`bd`) is a Dolt-powered issue tracker designed for AI-supervised coding workflows.

These docs are for the 1.3.2 release of beads — see the [v1.3.2 release notes](https://github.com/gastownhall/beads/releases/tag/v1.3.2). Upgrading from 1.2.2 or earlier crosses a schema migration; read [Upgrading](https://beads.gascity.com/getting-started/upgrading.md) first. After upgrading from 1.3.0 or earlier, run `bd recompute-blocked` once per workspace.

## Why Beads?

Traditional issue trackers (Jira, GitHub Issues) weren't designed for AI agents. Beads was built from the ground up for:

* **AI-native workflows** - Hash-based IDs prevent collisions when multiple agents work concurrently
* **Dolt-backed storage** - Issues stored in a version-controlled SQL database, enabling collaboration via Dolt-native replication
* **Dependency-aware execution** - `bd ready` shows only unblocked work
* **Formula system** - Declarative templates for repeatable workflows
* **Multi-agent coordination** - Routing, gates, and molecules for complex workflows

## Quick Start

```bash theme={null}
# Install via Homebrew (macOS/Linux)
brew install beads

# Or quick install (macOS/Linux/FreeBSD)
curl -fsSL https://raw.githubusercontent.com/gastownhall/beads/main/scripts/install.sh | bash

# Initialize in your project
cd your-project
bd init --quiet

# Create your first issue
bd create "Set up database" -p 1 -t task

# See ready work
bd ready
```

## Core Concepts

The whole model on one page: [How Beads Works](https://beads.gascity.com/core-concepts/index.md).

| Concept | Description |
| - | - |
| [**Beads (issues)**](https://beads.gascity.com/core-concepts/issues.md) | Work items with priorities, types, labels, and dependencies |
| [**Dependencies**](https://beads.gascity.com/core-concepts/dependencies.md) | `blocks`, `parent-child`, `discovered-from`, `related` |
| [**Sync**](https://beads.gascity.com/core-concepts/sync-concepts.md) | Dolt push/pull over your git remote — no server to run |
| [**Formulas**](https://beads.gascity.com/workflows/formulas.md) | Declarative workflow templates (TOML or JSON) |
| [**Molecules**](https://beads.gascity.com/workflows/molecules.md) | Work graphs instantiated from formulas |
| [**Gates**](https://beads.gascity.com/workflows/gates.md) | Async coordination primitives (human, timer, GitHub) |

## For AI Agents

Beads is optimized for AI coding agents:

```bash theme={null}
# Always use --json for programmatic access
bd list --json
bd show bd-42 --json

# Track discovered work during implementation
bd create "Found bug in auth" --description="Details..." \
  --deps discovered-from:bd-100 --json

# Push changes at end of session
bd dolt push
```

See the [Claude Code integration](https://beads.gascity.com/integrations/claude-code.md) for detailed agent instructions.

## Architecture

```
Dolt DB (.beads/embeddeddolt/ in embedded mode,
         .beads/dolt/ in server mode; gitignored)
    ↕ dolt commit
Local Dolt history
    ↕ dolt push/pull
Remote Dolt repository (shared across machines)
```

The magic is automatic synchronization via Dolt's version-controlled database with built-in replication.

## Next Steps

* [Installation](https://beads.gascity.com/getting-started/installation.md) - Get bd installed
* [Quick Start](https://beads.gascity.com/getting-started/quickstart.md) - Create your first issues
* [How Beads Works](https://beads.gascity.com/core-concepts/index.md) - The concept model on one page
* [CLI Reference](https://beads.gascity.com/cli-reference/index.md) - All available commands
* [Workflows](https://beads.gascity.com/workflows/index.md) - Formulas, molecules, and gates


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
