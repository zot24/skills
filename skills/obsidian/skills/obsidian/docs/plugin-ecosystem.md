<!-- Source: Authored — essential Obsidian community plugins -->

# Essential Plugin Ecosystem

## Must-Have Plugins

### Dataview
Query your vault like a database. See [dataview.md](dataview.md).
```
Community Plugins → Browse → "Dataview" → Install → Enable
```

### Templater
Advanced templates with JavaScript. See [templater.md](templater.md).
```
Community Plugins → Browse → "Templater" → Install → Enable
Settings → Template folder: "Templates"
```

### Tasks
Task management with dates, priorities, recurrence. See [tasks-plugin.md](tasks-plugin.md).
```
Community Plugins → Browse → "Tasks" → Install → Enable
```

### Calendar
Visual calendar linked to daily notes.
```
Community Plugins → Browse → "Calendar" → Install → Enable
```

### Periodic Notes
Extends daily notes with weekly, monthly, quarterly, yearly notes.
```
Community Plugins → Browse → "Periodic Notes" → Install → Enable
```

## Organization Plugins

### Tag Wrangler
Rename, merge, and organize tags across the vault.

### Folder Note
Automatically create an index note for each folder.

### Auto Link Title
Automatically fetch page titles when pasting URLs.

### Paste URL into Selection
Select text, paste URL, creates a markdown link.

## Visual & Knowledge Graph

### Excalidraw
Embedded drawing tool. Create diagrams linked to your notes.

### Graph Analysis
Advanced graph metrics — find clusters, betweenness centrality, PageRank.

### Local Graph Settings
Customize local graph per note.

## Writing

### Linter
Auto-format notes on save — fix YAML, headings, spacing, trailing whitespace.

### Natural Language Dates
Type `@today`, `@next friday` and get proper dates inserted.

### Footnote Shortcut
Quick footnote insertion with keyboard shortcut.

## AI & Automation

### Obsidian Local REST API
REST API for programmatic vault access. See [local-rest-api.md](local-rest-api.md).

### Text Generator
AI text generation within notes (supports OpenAI, Anthropic).

### Smart Connections
AI-powered note linking suggestions based on content similarity.

## Developer Tools

### Hot Reload
Auto-reload plugins during development.

### Plugin Dev Tools
Console, DOM inspection, CSS debugging.

## Plugin Installation

```
Settings → Community Plugins → Turn on community plugins
→ Browse → Search for plugin → Install → Enable
```

### Manual Installation
```bash
# Clone plugin to vault's plugins folder
cd /path/to/vault/.obsidian/plugins/
git clone https://github.com/author/plugin-name
cd plugin-name && npm install && npm run build
# Restart Obsidian → Enable in Community Plugins
```

## Recommended Plugin Combinations

### Knowledge Worker
Dataview + Templater + Tasks + Calendar + Periodic Notes

### Writer
Linter + Natural Language Dates + Footnote Shortcut + Word Count

### Visual Thinker
Excalidraw + Graph Analysis + Canvas (built-in)

### AI-Powered
Local REST API + MCP Server + Smart Connections + Text Generator
