> Source: https://pi.dev/docs/latest/rpc-extension-ui



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# RPC Extension UI


Extensions can request user interaction through `ctx.ui`. In RPC mode, supported calls become a request/response subprotocol alongside normal [RPC commands](/docs/latest/rpc-commands) and [session events](/docs/latest/json).

There are two categories of extension UI methods:

- **Dialog methods** (`select`, `confirm`, `input`, `editor`): emit an `extension_ui_request` on stdout and block until the client sends back an `extension_ui_response` on stdin with the matching `id`.
- **Fire-and-forget methods** (`notify`, `setStatus`, `setWidget`, `setTitle`, `set_editor_text`): emit an `extension_ui_request` on stdout but do not expect a response. The client can display the information or ignore it.

If a dialog method includes a `timeout` field, the agent-side will auto-resolve with a default value when the timeout expires. The client does not need to track timeouts.


## Limitations

<a href="#limitations" class="heading-anchor" aria-label="Permalink: Limitations" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#limitations"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Some `ExtensionUIContext` methods are not supported or degraded in RPC mode because they require direct terminal UI access:

- `custom()` returns `undefined`.
- `onTerminalInput()` returns a no-op unsubscribe function.
- `setWorkingMessage()`, `setWorkingVisible()`, `setWorkingIndicator()`, `setHiddenThinkingLabel()`, `setFooter()`, `setHeader()`, `addAutocompleteProvider()`, `setEditorComponent()`, and `setToolsExpanded()` are no-ops.
- `getEditorText()` returns `""` and `getEditorComponent()` returns `undefined`.
- `getToolsExpanded()` returns `false`.
- `pasteToEditor()` delegates to `setEditorText()` without terminal paste handling.
- `getAllThemes()` returns `[]`, and `getTheme()` returns `undefined`.
- `setTheme()` returns `{ success: false, error: "Theme switching not supported in RPC mode" }`.

Note: `ctx.mode` is `"rpc"` and `ctx.hasUI` is `true` in RPC mode because the dialog and fire-and-forget methods are functional via the extension UI sub-protocol. Use `ctx.mode === "tui"` to guard TUI-specific features like `custom()` that require a real terminal.


## Requests from Pi

<a href="#requests-from-pi" class="heading-anchor" aria-label="Permalink: Requests from Pi" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#requests-from-pi"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


All requests have `type: "extension_ui_request"`, a unique `id`, and a `method` field.


### select

<a href="#select" class="heading-anchor" aria-label="Permalink: select" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#select"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Prompt the user to choose from a list. Dialog methods with a `timeout` field include the timeout in milliseconds; the agent auto-resolves with `undefined` if the client doesn't respond in time.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-1",
  "method": "select",
  "title": "Allow dangerous command?",
  "options": ["Allow", "Block"],
  "timeout": 10000
}
```

Expected response: `extension_ui_response` with `value` (the selected option string) or `cancelled: true`.


### confirm

<a href="#confirm" class="heading-anchor" aria-label="Permalink: confirm" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#confirm"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Prompt the user for yes/no confirmation.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-2",
  "method": "confirm",
  "title": "Clear session?",
  "message": "All messages will be lost.",
  "timeout": 5000
}
```

Expected response: `extension_ui_response` with `confirmed: true/false` or `cancelled: true`.


### input

<a href="#input" class="heading-anchor" aria-label="Permalink: input" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#input"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Prompt the user for free-form text.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-3",
  "method": "input",
  "title": "Enter a value",
  "placeholder": "type something..."
}
```

Expected response: `extension_ui_response` with `value` (the entered text) or `cancelled: true`.


### editor

<a href="#editor" class="heading-anchor" aria-label="Permalink: editor" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#editor"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Open a multi-line text editor with optional prefilled content.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-4",
  "method": "editor",
  "title": "Edit some text",
  "prefill": "Line 1\nLine 2\nLine 3"
}
```

Expected response: `extension_ui_response` with `value` (the edited text) or `cancelled: true`.


### notify

<a href="#notify" class="heading-anchor" aria-label="Permalink: notify" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#notify"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Display a notification. Fire-and-forget, no response expected.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-5",
  "method": "notify",
  "message": "Command blocked by user",
  "notifyType": "warning"
}
```

The `notifyType` field is `"info"`, `"warning"`, or `"error"`. Defaults to `"info"` if omitted.


### setStatus

<a href="#setstatus" class="heading-anchor" aria-label="Permalink: setStatus" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#setstatus"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Set or clear a status entry in the footer/status bar. Fire-and-forget.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-6",
  "method": "setStatus",
  "statusKey": "my-ext",
  "statusText": "Turn 3 running..."
}
```

Send `statusText: undefined` (or omit it) to clear the status entry for that key.


### setWidget

<a href="#setwidget" class="heading-anchor" aria-label="Permalink: setWidget" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#setwidget"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Set or clear a widget (block of text lines) displayed above or below the editor. Fire-and-forget.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-7",
  "method": "setWidget",
  "widgetKey": "my-ext",
  "widgetLines": ["--- My Widget ---", "Line 1", "Line 2"],
  "widgetPlacement": "aboveEditor"
}
```

Send `widgetLines: undefined` (or omit it) to clear the widget. The `widgetPlacement` field is `"aboveEditor"` (default) or `"belowEditor"`. Only string arrays are supported in RPC mode; component factories are ignored.


### setTitle

<a href="#settitle" class="heading-anchor" aria-label="Permalink: setTitle" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#settitle"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Set the terminal window/tab title. Fire-and-forget.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-8",
  "method": "setTitle",
  "title": "pi - my project"
}
```


### set_editor_text

<a href="#set_editor_text" class="heading-anchor" aria-label="Permalink: set_editor_text" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#set_editor_text"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Set the text in the input editor. Fire-and-forget.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-9",
  "method": "set_editor_text",
  "text": "prefilled text for the user"
}
```


## Responses to Pi

<a href="#responses-to-pi" class="heading-anchor" aria-label="Permalink: Responses to Pi" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#responses-to-pi"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Responses are sent for dialog methods only (`select`, `confirm`, `input`, `editor`). The `id` must match the request.


### Value response (select, input, editor)

<a href="#value-response-select-input-editor" class="heading-anchor" aria-label="Permalink: Value response (select, input, editor)" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#value-response-select-input-editor"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` json
{"type": "extension_ui_response", "id": "uuid-1", "value": "Allow"}
```


### Confirmation response (confirm)

<a href="#confirmation-response-confirm" class="heading-anchor" aria-label="Permalink: Confirmation response (confirm)" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#confirmation-response-confirm"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` json
{"type": "extension_ui_response", "id": "uuid-2", "confirmed": true}
```


### Cancellation response (any dialog)

<a href="#cancellation-response-any-dialog" class="heading-anchor" aria-label="Permalink: Cancellation response (any dialog)" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#cancellation-response-any-dialog"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Dismiss any dialog method. The extension receives `undefined` (for select/input/editor) or `false` (for confirm).

``` json
{"type": "extension_ui_response", "id": "uuid-3", "cancelled": true}
```


## Example

<a href="#example" class="heading-anchor" aria-label="Permalink: Example" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-extension-ui#example"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


See the checked [RPC extension UI client](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/rpc-extension-ui.ts) and its [demo extension](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/rpc-demo.ts).

The exported request and response unions are defined in [`rpc-types.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/modes/rpc/rpc-types.ts). See [Extensions](/docs/latest/extensions#ui-and-modes) for mode-independent extension guidance.


