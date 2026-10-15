> Source: https://chat-sdk.dev/docs/api/modals.md

---
title: Modals
description: Modal form components for collecting user input.
docs_index: /llms.txt
lastUpdated: 2026-10-14
type: reference
related:
  - /docs/modals
---

> For an index of all documentation, see [/llms.txt](/llms.txt).

Modals display form dialogs that collect structured user input. Modals are currently supported on Slack and Teams.

```typescript
import {
  Modal,
  TextInput,
  DateInput,
  NumberInput,
  Select,
  ExternalSelect,
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

| Property          | Type           | Description                                                               |
| ----------------- | -------------- | ------------------------------------------------------------------------- |
| `callbackId`      | `string`       | Unique ID for routing to onModalSubmit/onModalClose handlers.             |
| `title`           | `string`       | Modal title displayed in the header.                                      |
| `submitLabel`     | `string`       | Label for the submit button.                                              |
| `closeLabel`      | `string`       | Label for the close/cancel button.                                        |
| `notifyOnClose`   | `boolean`      | Whether to fire onModalClose when the user dismisses the modal.           |
| `callbackUrl`     | `string`       | URL to POST form values to when the modal is submitted.                   |
| `privateMetadata` | `string`       | Arbitrary string passed through the modal lifecycle (e.g., JSON context). |
| `children`        | `ModalChild[]` | Form input elements.                                                      |

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

| Property       | Type      | Description                                |
| -------------- | --------- | ------------------------------------------ |
| `id`           | `string`  | Input ID, used as the key in event.values. |
| `label`        | `string`  | Label displayed above the input.           |
| `placeholder`  | `string`  | Placeholder text.                          |
| `initialValue` | `string`  | Pre-filled value.                          |
| `multiline`    | `boolean` | Render as a textarea.                      |
| `optional`     | `boolean` | Whether the field can be left empty.       |
| `maxLength`    | `number`  | Maximum character length.                  |

## DateInput

A date picker. Renders a Slack `datepicker` and an Adaptive Card `Input.Date` on Teams.

```typescript
DateInput({
  id: "due_date",
  label: "Due date",
  placeholder: "Pick a date",
  initialValue: "2026-08-01",
})
```

| Property       | Type      | Description                                |
| -------------- | --------- | ------------------------------------------ |
| `id`           | `string`  | Input ID, used as the key in event.values. |
| `label`        | `string`  | Label displayed above the input.           |
| `placeholder`  | `string`  | Placeholder text.                          |
| `initialValue` | `string`  | Pre-filled date as YYYY-MM-DD.             |
| `optional`     | `boolean` | Whether the field can be left empty.       |

The submitted value arrives in `event.values` as an ISO `YYYY-MM-DD` string. An `initialValue` that is not a valid `YYYY-MM-DD` date is dropped with a warning rather than forwarded, because Slack rejects a malformed `initial_date` by failing the whole modal.

## NumberInput

A numeric input. Renders a Slack `number_input` and an Adaptive Card `Input.Number` on Teams.

```typescript
NumberInput({
  id: "quantity",
  label: "Quantity",
  min: 1,
  max: 10,
})
```

| Property       | Type      | Description                                                                                                          |
| -------------- | --------- | -------------------------------------------------------------------------------------------------------------------- |
| `id`           | `string`  | Input ID, used as the key in event.values.                                                                           |
| `label`        | `string`  | Label displayed above the input.                                                                                     |
| `placeholder`  | `string`  | Placeholder text.                                                                                                    |
| `initialValue` | `number`  | Pre-filled value.                                                                                                    |
| `min`          | `number`  | Minimum accepted value.                                                                                              |
| `max`          | `number`  | Maximum accepted value.                                                                                              |
| `decimal`      | `boolean` | Allow decimal values. Enforced by Slack; Adaptive Cards has no decimal switch, so Teams accepts decimals either way. |
| `optional`     | `boolean` | Whether the field can be left empty.                                                                                 |

Values in `event.values` are always strings. Parse with `Number(...)` when you need a number.

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

| Property         | Type                    | Description                                                                                      |
| ---------------- | ----------------------- | ------------------------------------------------------------------------------------------------ |
| `id`             | `string`                | Input ID, used as the key in event.values.                                                       |
| `label`          | `string`                | Label displayed above the select.                                                                |
| `placeholder`    | `string`                | Placeholder text.                                                                                |
| `initialOption`  | `string`                | Pre-selected option value.                                                                       |
| `optional`       | `boolean`               | Whether the field can be left empty.                                                             |
| `options`        | `SelectOptionElement[]` | Select options.                                                                                  |
| `dispatchAction` | `boolean`               | Dispatch onAction events when the selection changes in a Slack modal. Ignored by other adapters. |

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

| Property         | Type                               | Description                                                                                                                                                                                |
| ---------------- | ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `id`             | `string`                           | Input ID, used as the key in event.values.                                                                                                                                                 |
| `label`          | `string`                           | Label displayed above the select.                                                                                                                                                          |
| `placeholder`    | `string`                           | Placeholder text.                                                                                                                                                                          |
| `minQueryLength` | `number`                           | Minimum characters before the loader fires (Slack default: 3).                                                                                                                             |
| `initialOption`  | `{ label: string, value: string }` | Pre-selected option when the modal opens. Unlike static Select where initialOption is a value string, ExternalSelect needs the full label/value object because the loader has not run yet. |
| `optional`       | `boolean`                          | Whether the field can be left empty.                                                                                                                                                       |

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

| Property      | Type     | Description                                 |
| ------------- | -------- | ------------------------------------------- |
| `label`       | `string` | Display text.                               |
| `value`       | `string` | Value sent in event.values when selected.   |
| `description` | `string` | Optional description shown below the label. |

## ModalChild types

The `children` array in `Modal` accepts these element types:

| Type                 | Created by                        |
| -------------------- | --------------------------------- |
| `TextInputElement`   | `TextInput()`                     |
| `DateInputElement`   | `DateInput()`                     |
| `NumberInputElement` | `NumberInput()`                   |
| `SelectElement`      | `Select()`                        |
| `RadioSelectElement` | `RadioSelect()`                   |
| `TextElement`        | `Text()`, for static text content |
| `FieldsElement`      | `Fields()`, for key-value display |

---

For a semantic overview of all documentation, see [/sitemap.md](/sitemap.md)

For an index of all available documentation, see [/llms.txt](/llms.txt)

For agent-facing discovery, including API and MCP surfaces, see [/agents.md](/agents.md)
