<!-- Source: Authored — Maps of Content patterns -->

# Maps of Content (MOCs)

## What is a MOC?

A MOC is a note that curates links to related notes on a topic. It's an index, a table of contents, and a thinking tool — all in one note.

```markdown
# Machine Learning MOC

## Fundamentals
- [[Linear Regression]] — simplest supervised model
- [[Gradient Descent]] — optimization algorithm
- [[Bias-Variance Tradeoff]]

## Deep Learning
- [[Neural Networks]] — architecture basics
- [[Transformers]] — attention mechanism
- [[Fine-tuning LLMs]]

## Tools
- [[PyTorch Quickstart]]
- [[Hugging Face Transformers]]

## Projects
- [[Sentiment Analysis Project]]
- [[Image Classifier]]
```

## MOC Patterns

### Hub MOC (Top Level)
Links to other MOCs. Your vault's entry point.
```markdown
# Home MOC
- [[Programming MOC]]
- [[Health MOC]]
- [[Projects MOC]]
- [[People MOC]]
```

### Topic MOC
Groups notes on a specific subject with annotations.
```markdown
# Docker MOC
- [[Docker Basics]] — images, containers, volumes
- [[Docker Compose]] — multi-container apps
- [[Dockerfile Best Practices]] — layer caching, multi-stage
```

### Project MOC
Groups all notes related to a project.
```markdown
# Project Alpha MOC
- [[Project Alpha - Requirements]]
- [[Project Alpha - Architecture]]
- [[Project Alpha - Meeting Notes]]
```

### Temporal MOC
Groups notes by time period.
```markdown
# 2024 Q1 MOC
- [[2024-01 Monthly Review]]
- [[2024-02 Monthly Review]]
- [[2024-03 Monthly Review]]
Key projects: [[Launch Website]], [[Q1 Report]]
```

## Creating MOCs

### When to create a MOC
- You have 5+ notes on a topic
- You find yourself searching for the same cluster of notes
- A topic spans multiple folders

### Dataview-assisted MOC
Auto-populate a MOC with matching notes:
```dataview
LIST
FROM #machine-learning
SORT file.name ASC
```

### Template for new MOCs
```markdown
---
type: moc
date: <% tp.date.now("YYYY-MM-DD") %>
tags: [moc]
---
# <% tp.file.title %> MOC

## Overview


## Key Notes
- 

## Related MOCs
- 
```

## Finding Notes That Need MOCs

```dataview
TABLE length(file.outlinks) AS Links, file.tags AS Tags
FROM ""
WHERE length(file.inlinks) >= 5
AND !contains(file.tags, "moc")
SORT length(file.inlinks) DESC
LIMIT 20
```

Notes with many inlinks are natural MOC candidates.
