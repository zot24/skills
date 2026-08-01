> Source: https://chat-sdk.dev/docs/api/modals.md

---
title: Modals
description: Modal form components for collecting user input.
type: reference
---

# Modals


Modals display form dialogs that collect structured user input. Currently supported on Slack and Teams.

```typescript
import {
  Modal,
  TextInput,
  DateInput,
  NumberInput,
  Select,
  RadioSelect,
  SelectOption,
} from "chat";
```

## Modal

Top-level container for a form dialog. Open a modal from an `onAction` or `onSlashCommand` handler using `event.openModal()`.

```typescript
bot.onAction("open-form", async (event) => {
  await event.openModal(
    Modal({
      callbackId: "feedback",
      title: "Submit Feedback",
      submitLabel: "Send",
      children: [
        TextInput({ id: "comment", label: "Comment", multiline: true }),
      ],
    })
  );
});
```


## TextInput

A text input field.

```typescript
TextInput({
  id: "name",
  label: "Your name",
  placeholder: "Enter your name",
})

TextInput({
  id: "description",
  label: "Description",
  multiline: true,
  maxLength: 500,
  optional: true,
})
```


## DateInput

A date picker — a Slack `datepicker`, an Adaptive Card `Input.Date` on Teams.

```typescript
DateInput({
  id: "due_date",
  label: "Due date",
  placeholder: "Pick a date",
  initialValue: "2026-08-01",
})
```


The submitted value arrives in `event.values` as an ISO `YYYY-MM-DD` string. An `initialValue` that is not a valid `YYYY-MM-DD` date is ignored with a warning — Slack rejects a malformed `initial_date` by failing the whole modal, so it is dropped rather than forwarded.

## NumberInput

A numeric input — a Slack `number_input`, an Adaptive Card `Input.Number` on Teams.

```typescript
NumberInput({
  id: "quantity",
  label: "Quantity",
  min: 1,
  max: 10,
})
```


Values in `event.values` are always strings — parse with `Number(...)` when you need a number.

## Select

Dropdown menu.

```typescript
Select({
  id: "priority",
  label: "Priority",
  placeholder: "Select priority",
  options: [
    SelectOption({ label: "High", value: "high", description: "Urgent tasks" }),
    SelectOption({ label: "Medium", value: "medium" }),
    SelectOption({ label: "Low", value: "low" }),
  ],
})
```


## ExternalSelect

Dropdown that loads options dynamically from a handler as the user types. Slack-only. Pair with [`bot.onOptionsLoad`](/docs/api/chat#onoptionsload) to supply options. See [Modals → ExternalSelect](/docs/modals#externalselect) for a full example, grouped-options support, and Slack setup notes.

```typescript
ExternalSelect({
  id: "assignee",
  label: "Assignee",
  placeholder: "Search people",
  minQueryLength: 1,
  initialOption: { label: "Alice", value: "U123" },
})
```


The loader registered via `bot.onOptionsLoad("assignee", handler)` returns either a flat `SelectOptionElement[]` or `OptionsLoadGroup[]` (`{ label, options }[]`) for grouped options.

## RadioSelect

Radio button group for mutually exclusive choices.

```typescript
RadioSelect({
  id: "status",
  label: "Status",
  options: [
    SelectOption({ label: "Open", value: "open" }),
    SelectOption({ label: "Closed", value: "closed" }),
  ],
})
```

Same props as `Select` (except `placeholder`).

## SelectOption

An option used inside `Select` and `RadioSelect`.

```typescript
SelectOption({ label: "High", value: "high", description: "Urgent tasks" })
```


## ModalChild types

The `children` array in `Modal` accepts these element types:

| Type                 | Created by                     |
| -------------------- | ------------------------------ |
| `TextInputElement`   | `TextInput()`                  |
| `DateInputElement`   | `DateInput()`                  |
| `NumberInputElement` | `NumberInput()`                |
| `SelectElement`      | `Select()`                     |
| `RadioSelectElement` | `RadioSelect()`                |
| `TextElement`        | `Text()` — static text content |
| `FieldsElement`      | `Fields()` — key-value display |


---

For a semantic overview of all documentation, see [/sitemap.md](/sitemap.md)

For an index of all available documentation, see [/llms.txt](/llms.txt)

For agent-facing discovery, including API and MCP surfaces, see [/agents.md](/agents.md)
