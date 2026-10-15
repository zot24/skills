> Source: https://chat-sdk.dev/docs/api/cards.md

---
title: Cards
description: Rich card components for cross-platform interactive messages.
docs_index: /llms.txt
lastUpdated: 2026-10-14
type: reference
related:
  - /docs/cards
  - /docs/actions
---

> For an index of all documentation, see [/llms.txt](/llms.txt).

Each adapter renders card components in its platform's native format: Block Kit on Slack, Adaptive Cards on Teams, embeds or Components on Discord, and Cards on Google Chat.

```typescript
import { Card, Text, CardLink, Button, Actions, Section, Fields, Field, Divider, Image, LinkButton, Table, Chart } from "chat";
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

| Property   | Type                  | Description                                                                                               |
| ---------- | --------------------- | --------------------------------------------------------------------------------------------------------- |
| `title`    | `string`              | Card title.                                                                                               |
| `subtitle` | `string`              | Card subtitle.                                                                                            |
| `imageUrl` | `string`              | Header image URL.                                                                                         |
| `children` | `CardChild[]`         | Card content elements.                                                                                    |
| `width`    | `"default" \| "full"` | Width hint for platforms that can render a card wider than the default (Teams). Other adapters ignore it. |

## Text

Text content element. Use `CardText` instead of `Text` in JSX to avoid conflicts with React's built-in types.

```typescript
Text("Hello, world!")
Text("Important", { style: "bold" })
Text("Subtle note", { style: "muted" })
```

| Property        | Type                           | Description                    |
| --------------- | ------------------------------ | ------------------------------ |
| `content`       | `string`                       | Text content (first argument). |
| `options.style` | `"plain" \| "bold" \| "muted"` | Text style.                    |

## Button

Interactive button that triggers an `onAction` handler.

```typescript
Button({ id: "approve", label: "Approve", style: "primary" })
Button({ id: "delete", label: "Delete", style: "danger", value: "item-123" })
```

| Property      | Type                                 | Description                                                                            |
| ------------- | ------------------------------------ | -------------------------------------------------------------------------------------- |
| `id`          | `string`                             | Unique action ID for callback routing.                                                 |
| `label`       | `string`                             | Button label text.                                                                     |
| `style`       | `"primary" \| "danger" \| "default"` | Visual style.                                                                          |
| `value`       | `string`                             | Optional payload sent with the action callback.                                        |
| `actionType`  | `"action" \| "modal"`                | Hints to adapters like Teams that this button will open a modal via event.openModal(). |
| `callbackUrl` | `string`                             | URL to POST action data to when this button is clicked.                                |
| `tooltip`     | `string`                             | Hover text for the button. Rendered by Teams only; other adapters ignore it.           |

## CardLink

Inline hyperlink rendered as text. Can be placed directly in a card alongside other content, unlike `LinkButton` which must live inside `Actions`.

```typescript
CardLink({ url: "https://example.com", label: "Visit Site" })
```

| Property | Type     | Description      |
| -------- | -------- | ---------------- |
| `url`    | `string` | URL to link to.  |
| `label`  | `string` | Link label text. |

## LinkButton

Button that opens a URL. No `onAction` handler needed for navigation. On
platforms that emit link-button click events, such as Slack, pass `id` when you
need a stable action identifier for routing or analytics.

```typescript
LinkButton({ url: "https://example.com", label: "View Docs" })
LinkButton({ id: "view_docs", url: "https://example.com", label: "View Docs" })
```

| Property  | Type                                 | Description                                                                  |
| --------- | ------------------------------------ | ---------------------------------------------------------------------------- |
| `id`      | `string`                             | Optional action identifier emitted by platforms that report link clicks.     |
| `url`     | `string`                             | URL to open when clicked.                                                    |
| `label`   | `string`                             | Button label text.                                                           |
| `style`   | `"primary" \| "danger" \| "default"` | Visual style.                                                                |
| `tooltip` | `string`                             | Hover text for the button. Rendered by Teams only; other adapters ignore it. |

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

| Property | Type     | Description  |
| -------- | -------- | ------------ |
| `label`  | `string` | Field label. |
| `value`  | `string` | Field value. |

## Image

Embeds an image in the card.

```typescript
Image({ url: "https://example.com/screenshot.png", alt: "Screenshot" })
```

| Property | Type     | Description                 |
| -------- | -------- | --------------------------- |
| `url`    | `string` | Image URL.                  |
| `alt`    | `string` | Alt text for accessibility. |

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

| Property        | Type                                                                        | Description                                                                                                                        |
| --------------- | --------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `headers`       | `string[]`                                                                  | Column header labels.                                                                                                              |
| `rows`          | `string[][]`                                                                | Data rows (each row is an array of cell strings).                                                                                  |
| `align`         | `"left" \| "center" \| "right"[]`                                           | Column alignment.                                                                                                                  |
| `caption`       | `string`                                                                    | Accessible table caption (used by platforms with native table support).                                                            |
| `pageSize`      | `number`                                                                    | Rows per page on platforms that paginate tables (Slack: 1-100, default 5).                                                         |
| `widths`        | `number[]`                                                                  | Relative column widths, one positive integer weight per column (default 1 each). Rendered by Teams only; other adapters ignore it. |
| `verticalAlign` | `"top" \| "center" \| "bottom"`                                             | Vertical alignment of cell content. Rendered by Teams only; other adapters ignore it.                                              |
| `gridLines`     | `boolean`                                                                   | Draw grid lines between cells. Rendered by Teams only; other adapters ignore it.                                                   |
| `gridStyle`     | `"default" \| "emphasis" \| "accent" \| "good" \| "attention" \| "warning"` | Style of the grid lines between cells. Rendered by Teams only; other adapters ignore it.                                           |

On platforms with native table support (Slack, Teams, GitHub, Linear), tables render as formatted tables. On Slack, tables render as paginated, sortable data table blocks. On Teams, tables render as the Adaptive Card `Table` element with grid lines and weighted column widths. Discord card payloads preserve GFM markdown tables. On other platforms (Google Chat, Telegram), tables render as padded ASCII text.

## Chart

Data visualization with pie, bar, area, and line charts.

```typescript
Chart({
  title: "My Favorite Candy Bars",
  chart: {
    type: "pie",
    segments: [
      { label: "Kit Kat", value: 45 },
      { label: "Twix", value: 28 },
    ],
  },
})
```

| Property | Type              | Description                                                                         |
| -------- | ----------------- | ----------------------------------------------------------------------------------- |
| `title`  | `string`          | Chart title (Slack: max 50 characters).                                             |
| `chart`  | `ChartDefinition` | Chart definition, discriminated by chart type ("pie" \| "bar" \| "area" \| "line"). |

Pie charts take `segments` (label + value, rendered as percentages of the total). Bar, area, and line charts take `series` (named lists of data points) plotted against shared `categories`, with optional `xLabel`/`yLabel` axis titles.

On Slack, charts render as native data visualization blocks. On other platforms, charts fall back to the underlying data rendered as a text table.

## Divider

A visual separator between sections.

```typescript
Divider()
```

## CardChild types

The `children` array in `Card` and `Section` accepts these element types:

| Type               | Created by    |
| ------------------ | ------------- |
| `TextElement`      | `Text()`      |
| `LinkElement`      | `CardLink()`  |
| `ImageElement`     | `Image()`     |
| `DividerElement`   | `Divider()`   |
| `ActionsElement`   | `Actions()`   |
| `SectionElement`   | `Section()`   |
| `FieldsElement`    | `Fields()`    |
| `TableElement`     | `Table()`     |
| `ChartElement`     | `Chart()`     |
| `TextInputElement` | `TextInput()` |

`TextInput` is the same element [modals](/docs/api/modals) use. On a card, only Teams renders it. Slack, Google Chat, Discord, GitHub, and Linear show its label as text. WhatsApp, Messenger, Twilio, and X omit it.

---

For a semantic overview of all documentation, see [/sitemap.md](/sitemap.md)

For an index of all available documentation, see [/llms.txt](/llms.txt)

For agent-facing discovery, including API and MCP surfaces, see [/agents.md](/agents.md)
