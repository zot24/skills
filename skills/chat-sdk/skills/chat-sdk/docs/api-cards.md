> Source: https://chat-sdk.dev/docs/api/cards.md

---
title: Cards
description: Rich card components for cross-platform interactive messages.
type: reference
---

# Cards


Card components render natively on each platform — Block Kit on Slack, Adaptive Cards on Teams, Embeds on Discord, and Google Chat Cards.

```typescript
import { Card, Text, CardLink, Button, Actions, Section, Fields, Field, Divider, Image, LinkButton, Table } from "chat";
```

All components support both function-call and JSX syntax. Function-call syntax is recommended for better type inference.

## Card

Top-level container for a rich message.

```typescript
Card({
  title: "Order #1234",
  subtitle: "Pending approval",
  children: [Text("Total: $50.00")],
})
```


## Text

Text content element. Use `CardText` instead of `Text` in JSX to avoid conflicts with React's built-in types.

```typescript
Text("Hello, world!")
Text("Important", { style: "bold" })
Text("Subtle note", { style: "muted" })
```


## Button

Interactive button that triggers an `onAction` handler.

```typescript
Button({ id: "approve", label: "Approve", style: "primary" })
Button({ id: "delete", label: "Delete", style: "danger", value: "item-123" })
```


## CardLink

Inline hyperlink rendered as text. Can be placed directly in a card alongside other content, unlike `LinkButton` which must live inside `Actions`.

```typescript
CardLink({ url: "https://example.com", label: "Visit Site" })
```


## LinkButton

Button that opens a URL. No `onAction` handler needed for navigation. On
platforms that emit link-button click events, such as Slack, pass `id` when you
need a stable action identifier for routing or analytics.

```typescript
LinkButton({ url: "https://example.com", label: "View Docs" })
LinkButton({ id: "view_docs", url: "https://example.com", label: "View Docs" })
```


## Actions

Container for buttons and interactive elements. Required wrapper around `Button`, `LinkButton`, `Select`, and `RadioSelect`.

```typescript
Actions([
  Button({ id: "approve", label: "Approve", style: "primary" }),
  Button({ id: "reject", label: "Reject", style: "danger" }),
  LinkButton({ url: "https://example.com", label: "View" }),
])
```

## Section

Groups related content together.

```typescript
Section([
  Text("Grouped content"),
  Image({ url: "https://example.com/photo.png" }),
])
```

## Fields

Renders key-value pairs in a compact, multi-column layout.

```typescript
Fields([
  Field({ label: "Name", value: "Jane Smith" }),
  Field({ label: "Role", value: "Engineer" }),
])
```

## Field

A single key-value pair. Must be used inside `Fields`.


## Image

Embeds an image in the card.

```typescript
Image({ url: "https://example.com/screenshot.png", alt: "Screenshot" })
```


## Table

Structured data display with column headers and rows.

```typescript
Table({
  headers: ["Name", "Age", "Role"],
  rows: [
    ["Alice", "30", "Engineer"],
    ["Bob", "25", "Designer"],
  ],
})
```


On platforms with native table support (Teams, GitHub, Linear), tables render as formatted tables. On other platforms (Slack, Google Chat, Discord, Telegram), tables render as padded ASCII text.

## Divider

A visual separator between sections.

```typescript
Divider()
```

## CardChild types

The `children` array in `Card` and `Section` accepts these element types:

| Type             | Created by   |
| ---------------- | ------------ |
| `TextElement`    | `Text()`     |
| `LinkElement`    | `CardLink()` |
| `ImageElement`   | `Image()`    |
| `DividerElement` | `Divider()`  |
| `ActionsElement` | `Actions()`  |
| `SectionElement` | `Section()`  |
| `FieldsElement`  | `Fields()`   |
| `TableElement`   | `Table()`    |
