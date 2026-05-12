<!-- Source: Authored — vault organization patterns -->

# Vault Organization

## Folder Structures

### Flat + MOCs (Recommended for most users)
```
vault/
├── Inbox/              # Capture new notes quickly
├── Templates/          # Templater and core templates
├── Attachments/        # Images, PDFs, files
├── Archive/            # Completed/inactive notes
└── (all notes at root or minimal folders)
```
Use MOCs (Maps of Content) instead of deep folder hierarchies. Notes link to MOCs, MOCs link to each other.

### PARA Structure
```
vault/
├── 1-Projects/         # Active projects with deadlines
├── 2-Areas/            # Ongoing responsibilities
├── 3-Resources/        # Topics of interest
├── 4-Archives/         # Inactive items
├── Templates/
└── Attachments/
```

### Zettelkasten Structure
```
vault/
├── Fleeting/           # Quick captures, inbox
├── Literature/         # Source notes (books, articles)
├── Permanent/          # Atomic, evergreen notes
├── Projects/           # Active project notes
├── Templates/
└── Attachments/
```

## Naming Conventions

### Notes
- Use descriptive titles: `How to configure Sonarr quality profiles`
- Avoid dates in filenames (use properties instead)
- Use title case or sentence case consistently
- No special characters that break links: `| # ^ [] \`

### Daily Notes
- Format: `YYYY-MM-DD` (sorts chronologically)
- Weekly: `YYYY-[W]WW` (e.g., `2024-W03`)
- Monthly: `YYYY-MM`

### Templates
- Prefix with purpose: `Template - Meeting`, `Template - Project`

## Maps of Content (MOCs)

MOCs are index notes that curate links to related notes:

```markdown
# Programming MOC

## Languages
- [[Python]] — scripting, data science
- [[Rust]] — systems programming
- [[TypeScript]] — web development

## Concepts
- [[Design Patterns]]
- [[Testing Strategies]]
- [[CI/CD]]

## Projects
- [[Project Alpha]] — current
- [[Project Beta]] — completed
```

**Why MOCs over folders**:
- A note can appear in multiple MOCs (cross-cutting concerns)
- MOCs are searchable and linkable
- You can add context/descriptions alongside links
- No structural lock-in

## Bulk Operations

### Find orphaned notes (no incoming links)
```dataview
LIST
WHERE length(file.inlinks) = 0
AND !contains(file.path, "Templates")
AND !contains(file.path, "Attachments")
SORT file.name ASC
```

### Find broken links
Use the Obsidian CLI:
```bash
obsidian search query="[[" | grep -v "→"
```
Or check the Graph View → filter for "orphans".

### Find large notes that should be split
```dataview
TABLE length(file.content) AS Characters, length(file.outlinks) AS "Out Links"
WHERE length(file.content) > 5000
SORT length(file.content) DESC
```

### Rename/move with link updates
Obsidian automatically updates all wikilinks when you rename or move a file through the app. Use the CLI:
```bash
obsidian move path="old/path/note.md" to="new/path/"
```

## Settings Recommendations

### Files & Links
- **Default location for new notes**: Same folder as current file, or Inbox/
- **New link format**: Shortest path when possible
- **Use Wikilinks**: On (unless sharing with non-Obsidian tools)
- **Default location for new attachments**: `Attachments/` subfolder

### Editor
- **Strict line breaks**: Off (natural Markdown flow)
- **Auto pair brackets**: On
- **Readable line length**: On
