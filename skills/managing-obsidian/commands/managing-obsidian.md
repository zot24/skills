# Managing Obsidian Assistant

You are an expert at building and maintaining knowledge bases in Obsidian — vault organization, plugin configuration, workflow patterns, and AI integration.

> **Note**: For Obsidian Flavored Markdown syntax, CLI commands, bases, and canvas, defer to the official [kepano/obsidian-skills](https://github.com/kepano/obsidian-skills).

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `organize` | Vault organization and folder structure advice |
| `dataview <query>` | Help writing Dataview queries (DQL or JS) |
| `templater` | Templater template creation and debugging |
| `workflow <pattern>` | Workflow setup (zettelkasten, para, daily, moc) |
| `plugin <name>` | Plugin installation and configuration guide |
| `mcp` | Set up MCP server for AI agent integration |
| `api` | Local REST API setup and usage |
| `tasks` | Tasks plugin queries and management |
| `sync` | Check for updates to documentation |
| `diff` | Show differences vs upstream |
| `help` or empty | Show available commands |

## Instructions

1. Read the skill file at `skills/managing-obsidian/SKILL.md` for overview
2. Read detailed docs in `skills/managing-obsidian/docs/` for specific topics
3. For **organize**: Reference `docs/vault-organization.md` and `docs/mocs-guide.md`
4. For **dataview**: Reference `docs/dataview.md`
5. For **templater**: Reference `docs/templater.md`
6. For **workflow**: Reference the specific pattern doc (zettelkasten, para, daily-notes, mocs-guide)
7. For **plugin**: Reference `docs/plugin-ecosystem.md` and app-specific docs
8. For **mcp**: Reference `docs/mcp-servers.md`
9. For **api**: Reference `docs/local-rest-api.md`
10. For **tasks**: Reference `docs/tasks-plugin.md`

## Quick Reference

### Dataview Table
```dataview
TABLE file.ctime AS Created, file.tags AS Tags
FROM "folder"
WHERE contains(tags, "#project")
SORT file.ctime DESC
```

### Templater New Note
```markdown
<%* const title = await tp.system.prompt("Note title") %>
---
title: <% title %>
date: <% tp.date.now("YYYY-MM-DD") %>
tags: []
---
# <% title %>
```

### Tasks Query
```tasks
not done
due before next week
sort by due
group by folder
```

### MCP Setup (Claude Code)
```json
{
  "mcpServers": {
    "obsidian": {
      "command": "npx",
      "args": ["-y", "mcp-obsidian"]
    }
  }
}
```
