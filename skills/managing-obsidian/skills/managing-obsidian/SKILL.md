---
name: managing-obsidian
description: Manage and optimize Obsidian vaults — organization, Dataview queries, Templater, workflow patterns (Zettelkasten, PARA, MOCs), MCP server setup, plugin ecosystem, Local REST API, sync, and publishing. Complements the official obsidian-skills (kepano/obsidian-skills) which covers markdown syntax, CLI, bases, and canvas. Use when organizing a vault, querying notes, setting up plugins, building workflows, or integrating Obsidian with AI agents. Triggers on mentions of Obsidian vault, Dataview, Templater, Zettelkasten, PARA, MOC, obsidian plugins, obsidian sync, obsidian publish, obsidian MCP.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Managing Obsidian

Expert at building and maintaining knowledge bases in Obsidian — beyond syntax, into systems.

> **Companion to official skills**: Install [kepano/obsidian-skills](https://github.com/kepano/obsidian-skills) for markdown syntax, CLI, bases, and canvas. This skill covers everything else.

## Overview

- **Vault organization** — folder structures, naming, MOCs, bulk operations, broken link detection
- **Dataview** — SQL-like queries over your vault (tables, lists, tasks, calendars)
- **Templater** — Advanced templating with JavaScript, dynamic dates, file creation
- **Workflow patterns** — Zettelkasten, PARA, daily notes, periodic reviews, MOCs
- **Plugin ecosystem** — Dataview, Templater, Tasks, Calendar, Excalidraw, and more
- **MCP & REST API** — AI agent integration via MCP servers and Local REST API
- **Sync & publish** — Obsidian Sync, git-based sync, Obsidian Publish, digital gardens

## Quick Start

```bash
# Install official CLI + companion skills
brew install obsidian-cli
npx skills add git@github.com:kepano/obsidian-skills.git

# Set up MCP server for AI integration
npm install -g mcp-obsidian
```

## Core Concepts

**MOC (Map of Content)** — A note that links to related notes on a topic. Acts as an entry point to a cluster of knowledge. Better than folders for cross-cutting topics.

**Dataview** — Treats your vault as a database. Query notes by properties, tags, links, and inline fields using DQL (Dataview Query Language) or JavaScript.

**Templater** — Template engine with JavaScript execution, dynamic dates, file/folder operations. Runs on note creation or manually.

## Documentation

### Vault Management
- **[Vault Organization](docs/vault-organization.md)** — Folder structures, naming, MOCs
- **[Graph Analysis](docs/graph-analysis.md)** — Find orphans, hubs, clusters

### Key Plugins
- **[Dataview](docs/dataview.md)** — Query language, tables, lists, tasks
- **[Templater](docs/templater.md)** — Advanced templates with JS
- **[Tasks Plugin](docs/tasks-plugin.md)** — Task management and queries
- **[Plugin Ecosystem](docs/plugin-ecosystem.md)** — Essential community plugins

### Workflow Patterns
- **[Zettelkasten](docs/zettelkasten.md)** — Atomic notes, fleeting→permanent
- **[PARA Method](docs/para-method.md)** — Projects, Areas, Resources, Archives
- **[Daily Notes Workflow](docs/daily-notes.md)** — Daily/weekly/periodic reviews
- **[MOCs Guide](docs/mocs-guide.md)** — Maps of Content patterns

### AI Integration
- **[MCP Servers](docs/mcp-servers.md)** — Set up Obsidian MCP for Claude/agents
- **[Local REST API](docs/local-rest-api.md)** — Programmatic vault access

### Sync & Publishing
- **[Sync & Backup](docs/sync-backup.md)** — Obsidian Sync, git, backups
- **[Publishing](docs/publishing.md)** — Obsidian Publish, digital gardens

## Common Workflows

### Query all tasks due this week
```dataview
TASK FROM ""
WHERE !completed AND due >= date(today) AND due <= date(today) + dur(7d)
SORT due ASC
```

### Create a MOC from existing notes
```markdown
# [[Topic]] MOC
- [[Note 1]] — brief description
- [[Note 2]] — brief description
Related: [[Other MOC]]
```

### Set up MCP for Claude Code
```json
// .claude/settings.json
{ "mcpServers": { "obsidian": { "command": "mcp-obsidian", "args": ["--vault", "/path/to/vault"] } } }
```

## Upstream Sources

- **Obsidian Help**: https://help.obsidian.md
- **Dataview**: https://blacksmithgu.github.io/obsidian-dataview/
- **Templater**: https://silentvoid13.github.io/Templater/
- **Official Skills**: https://github.com/kepano/obsidian-skills

## Sync & Update

When user runs `sync`: fetch latest from upstream, update docs/.
When user runs `diff`: compare current vs upstream, report changes.
