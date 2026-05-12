<!-- Source: Authored — PARA method in Obsidian -->

# PARA Method

## Overview

PARA organizes all information by **actionability**:

| Folder | What goes here | Timeframe |
|--------|---------------|-----------|
| **Projects** | Tasks with a deadline and goal | Days–Months |
| **Areas** | Ongoing responsibilities | Indefinite |
| **Resources** | Topics of interest | Reference |
| **Archives** | Inactive items from above | Done |

## Folder Structure

```
vault/
├── 1-Projects/
│   ├── Launch Website/
│   ├── Q1 Report/
│   └── Home Renovation/
├── 2-Areas/
│   ├── Health/
│   ├── Finances/
│   ├── Career/
│   └── Home/
├── 3-Resources/
│   ├── Programming/
│   ├── Photography/
│   └── Recipes/
├── 4-Archives/
│   ├── (completed projects)
│   └── (inactive areas/resources)
├── Templates/
└── Attachments/
```

## Project Notes

Each project gets a folder with a main note:

```markdown
---
type: project
status: active
start: 2024-01-01
deadline: 2024-03-15
area: "Career"
tags: [project]
---
# Launch Website

## Outcome
Live website with portfolio and blog

## Tasks
- [ ] Design mockups
- [ ] Build frontend
- [ ] Write content
- [ ] Deploy

## Notes
- [[Website Requirements]]
- [[Design Inspiration]]

## Log
- 2024-01-15: Started mockups
```

## Area Notes

Areas are ongoing with no end date:

```markdown
---
type: area
tags: [area, health]
---
# Health

## Current Focus
- Morning exercise routine
- Sleep optimization

## Related
- [[Exercise Log]]
- [[Nutrition Notes]]
- [[Sleep Tracking]]
```

## Moving Between PARA Categories

When a project completes → move to Archives.
When an area becomes inactive → move to Archives.
When a resource inspires a project → create in Projects, link to Resource.

```bash
# Move completed project to archives
obsidian move path="1-Projects/Launch Website" to="4-Archives/"
```

## Dataview Dashboards

### Active Projects
```dataview
TABLE status, deadline, area
FROM "1-Projects"
WHERE type = "project" AND status = "active"
SORT deadline ASC
```

### Projects Due This Month
```dataview
TASK
FROM "1-Projects"
WHERE !completed AND deadline <= date(today) + dur(30d)
SORT deadline ASC
```

### Recently Modified Across PARA
```dataview
TABLE file.folder AS Location, file.mtime AS Modified
FROM "1-Projects" OR "2-Areas" OR "3-Resources"
SORT file.mtime DESC
LIMIT 15
```
