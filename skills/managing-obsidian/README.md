# Managing Obsidian Skill

Expert assistant for building and maintaining knowledge bases in Obsidian — beyond syntax, into systems.

> **Companion to official skills**: Install [kepano/obsidian-skills](https://github.com/kepano/obsidian-skills) for markdown syntax, CLI, bases, and canvas.

## What This Skill Covers

| Category | Topics |
|----------|--------|
| Vault Management | Folder structures, naming, MOCs, bulk operations, orphan detection |
| Dataview | DQL queries, tables, lists, task queries, JavaScript API |
| Templater | Dynamic templates, JS execution, file creation, date handling |
| Workflows | Zettelkasten, PARA, daily notes, periodic reviews, MOCs |
| Plugins | Dataview, Templater, Tasks, Calendar, Excalidraw, and more |
| AI Integration | MCP servers, Local REST API, agent workflows |
| Sync & Publish | Obsidian Sync, git-based sync, Obsidian Publish, digital gardens |

## Usage

```
/managing-obsidian:managing-obsidian organize           # Vault structure advice
/managing-obsidian:managing-obsidian dataview "tasks"    # Dataview query help
/managing-obsidian:managing-obsidian templater           # Template creation
/managing-obsidian:managing-obsidian workflow zettelkasten  # Workflow setup
/managing-obsidian:managing-obsidian plugin dataview     # Plugin guide
/managing-obsidian:managing-obsidian mcp                 # MCP server setup
/managing-obsidian:managing-obsidian sync                # Update docs
```

## Documentation Sources

- **Obsidian Help**: https://help.obsidian.md
- **Dataview**: https://blacksmithgu.github.io/obsidian-dataview/
- **Templater**: https://silentvoid13.github.io/Templater/
- **Tasks**: https://publish.obsidian.md/tasks/

## Skill Structure

```
skills/managing-obsidian/
├── .claude-plugin/plugin.json
├── commands/managing-obsidian.md
├── skills/managing-obsidian/
│   ├── SKILL.md
│   └── docs/
│       ├── dataview.md, templater.md     # Key plugins
│       ├── vault-organization.md         # Vault management
│       ├── zettelkasten.md, para-method.md  # Workflows
│       ├── mcp-servers.md                # AI integration
│       └── ...
├── sync.json
└── README.md
```
