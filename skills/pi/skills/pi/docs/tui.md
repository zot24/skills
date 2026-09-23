> Source: https://pi.dev/docs/latest/tui



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Terminal UI


`@earendil-works/pi-tui` provides the terminal component system used by Pi. Extensions use it when built-in dialogs, notifications, status text, and widgets are not enough for the interaction they need.

Start with `ctx.ui` methods from an [extension](/docs/latest/extensions#interact-with-the-user). Build a custom component only when the UI needs its own rendering, keyboard or mouse input, focus, layout, or lifecycle.


## Choose an integration point

<a href="#choose-an-integration-point" class="heading-anchor" aria-label="Permalink: Choose an integration point" data-copy="" data-copy-text="https://pi.dev/docs/latest/tui#choose-an-integration-point"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Need                                         | Use                                                      |
|----------------------------------------------|----------------------------------------------------------|
| Select, confirm, input, or multi-line editor | `ctx.ui.select()`, `confirm()`, `input()`, or `editor()` |
| Non-blocking feedback                        | `ctx.ui.notify()` or `setStatus()`                       |
| Persistent content near the editor           | `ctx.ui.setWidget()`                                     |
| Replace the header, footer, or editor        | The corresponding `ctx.ui` component factory             |
| Temporary interactive screen or overlay      | `ctx.ui.custom()`                                        |
| Custom rendering for a tool or session entry | An extension renderer                                    |

These APIs receive Pi’s active theme and keybindings where needed. Do not create a second terminal renderer inside an extension.


## Understand the component model

<a href="#understand-the-component-model" class="heading-anchor" aria-label="Permalink: Understand the component model" data-copy="" data-copy-text="https://pi.dev/docs/latest/tui#understand-the-component-model"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


A component renders an array of terminal lines for an available width. It can optionally handle keyboard and mouse input, and it must invalidate cached output when its state or theme-dependent content changes.

Every rendered line must fit within the supplied width. Measure visible terminal columns rather than string length because ANSI escapes, wide characters, emoji, and combining characters change display width.

Use `visibleWidth()`, `truncateToWidth()`, `sliceByColumn()`, and `wrapTextWithAnsi()` instead of implementing terminal-width handling yourself. Pi resets styling and hyperlinks after every line, so reapply styles on each rendered line.

After changing component state, invalidate the affected component and call the injected `tui.requestRender()`. The TUI coalesces render requests and updates the terminal.


## Compose built-in components

<a href="#compose-built-in-components" class="heading-anchor" aria-label="Permalink: Compose built-in components" data-copy="" data-copy-text="https://pi.dev/docs/latest/tui#compose-built-in-components"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


The package includes components for common layouts and controls:

- `Text`, `Markdown`, `Image`, and `TruncatedText` render content.
- `Container`, `VStack`, `HStack`, `Box`, and `Spacer` compose layouts.
- `Input` and `Editor` accept text.
- `SelectList` and `SettingsList` implement searchable selection and settings flows.
- `ScrollView` provides a bounded scrollable viewport.
- `Loader` and `CancellableLoader` report ongoing work.
- `MouseRegion` adds pointer behavior around another component.

Prefer these components over rebuilding selection, scrolling, text editing, or width handling. The extension examples show how to combine them with Pi’s borders and themes.


## Handle keyboard input and focus

<a href="#handle-keyboard-input-and-focus" class="heading-anchor" aria-label="Permalink: Handle keyboard input and focus" data-copy="" data-copy-text="https://pi.dev/docs/latest/tui#handle-keyboard-input-and-focus"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Use `matchesKey()` and `Key` for terminal keyboard input. The parser accounts for supported terminal protocols and key modifiers. Extension components should use the injected `KeybindingsManager` for configurable application actions.

A component that displays a text cursor should implement `Focusable` and place `CURSOR_MARKER` immediately before its visual cursor. The TUI uses that marker to position the hardware cursor for input method editors.

Containers that wrap an `Input` or `Editor` must propagate their `focused` state to that child. Without propagation, Chinese, Japanese, Korean, and other IME candidate windows can appear at the wrong screen position.

Extend Pi’s `CustomEditor` when replacing the main editor. It preserves application shortcuts and agent controls.

Forward keys your editor does not own to the base implementation, and restore the default by clearing the custom editor factory.


## Handle mouse input

<a href="#handle-mouse-input" class="heading-anchor" aria-label="Permalink: Handle mouse input" data-copy="" data-copy-text="https://pi.dev/docs/latest/tui#handle-mouse-input"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Fullscreen mode routes normalized mouse events to components. A handler can mark an event handled, capture a drag sequence, request focus, or request a render.

Unhandled wheel events scroll the nearest `ScrollView`. Unhandled primary-button drags remain available for transcript selection. OSC 8 links take precedence over enclosing click regions.

Regular mode leaves mouse input to the terminal because the terminal owns scrollback. Design every interaction with a keyboard path even when fullscreen mouse input is available.


## Use custom screens and overlays

<a href="#use-custom-screens-and-overlays" class="heading-anchor" aria-label="Permalink: Use custom screens and overlays" data-copy="" data-copy-text="https://pi.dev/docs/latest/tui#use-custom-screens-and-overlays"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


`ctx.ui.custom()` temporarily gives one component control of the interactive area and resolves when that component calls the supplied completion callback.

Pass `overlay: true` to draw above existing content. Overlay options control size, anchors, offsets, margins, and responsive visibility. An overlay handle can change focus or temporarily hide and show the overlay with `setHidden()` while the interaction remains active.

Focused overlays retain input ownership across ordinary renders. If another component should receive input while an overlay remains visible, explicitly release or redirect focus through the handle.

Treat each custom component instance as belonging to one interaction. Create a new instance when starting that interaction again.

Finish the interaction with the completion callback supplied to the component factory. It resolves the `ctx.ui.custom()` promise and disposes the component. Do not call `OverlayHandle.hide()` on an overlay created by `ctx.ui.custom()`.

See [`overlay-qa-tests.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/overlay-qa-tests.ts) for positioning, stacking, focus, responsive visibility, and animation behavior.


## Apply themes correctly

<a href="#apply-themes-correctly" class="heading-anchor" aria-label="Permalink: Apply themes correctly" data-copy="" data-copy-text="https://pi.dev/docs/latest/tui#apply-themes-correctly"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Use the theme passed to the extension or component callback. Theme helpers produce ANSI-styled strings for semantic colors such as accent, muted text, success, warnings, errors, tool output, and Markdown.

Do not permanently store strings with theme colors unless `invalidate()` rebuilds them. A theme change clears render caches, but it cannot remove old ANSI colors embedded in application state.

Theme callbacks evaluated during rendering do not need special rebuilding. Stateless components can also calculate themed output on every render.

Use [Themes](/docs/latest/themes) to create terminal palettes. Use Pi’s `getMarkdownTheme()` when rendering Markdown that should match the active application theme.


## Keep rendering responsive

<a href="#keep-rendering-responsive" class="heading-anchor" aria-label="Permalink: Keep rendering responsive" data-copy="" data-copy-text="https://pi.dev/docs/latest/tui#keep-rendering-responsive"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Rendering runs on the interactive path. Cache expensive layout and highlighting work by width and content, then clear that cache from `invalidate()`.

Keep the default view compact and reveal detail through expansion or a dedicated screen. For custom tool rendering, handle partial results and reuse the previous component when it can be updated safely.

Use `PI_TUI_WRITE_LOG` to capture the raw ANSI stream when diagnosing rendering problems. Test narrow widths, wide characters, resize events, theme changes, focus transitions, and both regular and fullscreen modes.


## Examples and source

<a href="#examples-and-source" class="heading-anchor" aria-label="Permalink: Examples and source" data-copy="" data-copy-text="https://pi.dev/docs/latest/tui#examples-and-source"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


The checked extension examples cover the main patterns:

- [`preset.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/preset.ts) and [`tools.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/tools.ts) use selection and settings lists.
- [`qna.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/qna.ts) uses cancellable asynchronous UI.
- [`modal-editor.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/modal-editor.ts) replaces the editor.
- [`custom-footer.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/custom-footer.ts) replaces the footer.
- [`widget-placement.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/widget-placement.ts) places persistent content around the editor.
- [`doom-overlay/`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/doom-overlay) demonstrates a continuously rendered overlay.

The public exports are defined in [`packages/tui/src/index.ts`](https://github.com/earendil-works/pi/blob/main/packages/tui/src/index.ts). See [Extensions](/docs/latest/extensions) for extension lifecycle, state, tools, events, and mode behavior.


