<!-- Source: Authored — Zettelkasten workflow in Obsidian -->

# Zettelkasten Workflow

## Core Principles

1. **Atomic notes** — One idea per note. If a note covers two concepts, split it.
2. **Note types** — Fleeting (captures) → Literature (sources) → Permanent (your thinking)
3. **Links over folders** — Structure emerges from connections, not hierarchy
4. **Write in your own words** — Permanent notes are YOUR understanding, not quotes

## Note Types

### Fleeting Notes (Inbox)
Quick captures. Process within 1-2 days into literature or permanent notes, then delete.
```markdown
---
type: fleeting
date: 2024-01-15
---
Interesting idea about spaced repetition from podcast...
```

### Literature Notes (Source Notes)
Summarize a source in your own words. Link to permanent notes.
```markdown
---
type: literature
source: "How to Take Smart Notes by Sönke Ahrens"
date: 2024-01-15
tags: [book, pkm]
---
# How to Take Smart Notes

Key ideas:
- Writing is not the result of thinking, it IS thinking
- The slip-box forces you to [[elaborate on ideas]]
- [[Connections between notes]] matter more than categories
```

### Permanent Notes (Evergreen)
Your own atomic insights. These are the core of your knowledge base.
```markdown
---
type: permanent
date: 2024-01-15
tags: [learning, memory]
---
# Spaced repetition strengthens long-term memory

Reviewing material at increasing intervals creates stronger neural pathways
than massed practice. The spacing effect works because [[retrieval practice]]
forces active recall, which is more effortful than passive review.

This connects to [[desirable difficulties]] — learning that feels harder
in the moment produces better long-term retention.

Source: [[How to Take Smart Notes]]
```

## Daily Workflow

1. **Capture** — Throughout the day, dump thoughts into fleeting notes
2. **Process** — At end of day, review fleeting notes:
   - Does this connect to an existing permanent note? → Add link
   - Is this a new idea? → Create a permanent note
   - Is this from a source? → Create a literature note first
3. **Connect** — For every new permanent note, find 2-3 existing notes to link to
4. **Review** — Weekly, review recent permanent notes and strengthen connections

## Templater Templates

### Fleeting Note Template
```markdown
---
type: fleeting
date: <% tp.date.now("YYYY-MM-DD") %>
---
<%* const content = await tp.system.prompt("Quick thought") %>
<% content %>
```

### Permanent Note Template
```markdown
---
type: permanent
date: <% tp.date.now("YYYY-MM-DD") %>
tags: []
---
# <% tp.file.title %>


---
## References
- 

## Connected Ideas
- 
```

## Dataview Queries for Zettelkasten

### Unprocessed fleeting notes
```dataview
LIST
FROM ""
WHERE type = "fleeting"
SORT file.ctime DESC
```

### Recent permanent notes without enough links
```dataview
TABLE length(file.outlinks) AS Links
FROM ""
WHERE type = "permanent" AND length(file.outlinks) < 2
SORT file.ctime DESC
LIMIT 20
```

### Literature notes and their permanent note connections
```dataview
TABLE file.outlinks AS "Connected Notes"
FROM ""
WHERE type = "literature"
SORT file.ctime DESC
```
