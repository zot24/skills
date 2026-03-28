> Source: https://agent-browser.dev/snapshots



[](https://vercel.com "Made with love by Vercel")<span class="text-neutral-300 dark:text-neutral-700"></span>[<span class="font-medium tracking-tight text-lg" style="font-family:var(--font-geist-pixel-square)">agent-browser</span>](/)


Snapshots


Copy Page


# Snapshots

The `snapshot` command returns a compact accessibility tree with refs for element interaction.

## Options

Filter output to reduce size:


``` shiki
agent-browser snapshot                    # Full accessibility tree
agent-browser snapshot -i                 # Interactive elements only (recommended)
agent-browser snapshot -c                 # Compact (remove empty elements)
agent-browser snapshot -d 3               # Limit depth to 3 levels
agent-browser snapshot -s "#main"         # Scope to CSS selector
agent-browser snapshot -i -c -d 5         # Combine options
```


| Option              | Description                                        |
|---------------------|----------------------------------------------------|
| `-i, --interactive` | Only interactive elements (buttons, links, inputs) |
| `-c, --compact`     | Remove empty structural elements                   |
| `-d, --depth`       | Limit tree depth                                   |
| `-s, --selector`    | Scope to CSS selector                              |

## Output format

The default text output is compact and AI-friendly:


``` shiki
agent-browser snapshot -i
# Output:
# @e1 [heading] "Example Domain" [level=1]
# @e2 [button] "Submit"
# @e3 [input type="email"] placeholder="Email"
# @e4 [link] "Learn more"
```


## Using refs

Refs from the snapshot map directly to commands:


``` shiki
agent-browser click @e2      # Click the Submit button
agent-browser fill @e3 "a@b.com"  # Fill the email input
agent-browser get text @e1        # Get heading text
```


## Ref lifecycle

Refs are invalidated when the page changes. Always re-snapshot after navigation or DOM updates:


``` shiki
agent-browser click @e4      # Navigates to new page
agent-browser snapshot -i    # Get fresh refs
agent-browser click @e1      # Use new refs
```


## Annotated screenshots

For visual context alongside text snapshots, use `screenshot --annotate` to overlay numbered labels on interactive elements. Each label `[N]` maps to ref `@eN`:

In native mode, annotated screenshots currently work on the CDP-backed browser path (Chromium/Lightpanda). The Safari/WebDriver backend does not yet support `--annotate`.


``` shiki
agent-browser screenshot --annotate ./page.png
# -> Screenshot saved to ./page.png
#    [1] @e1 button "Submit"
#    [2] @e2 link "Home"
#    [3] @e3 textbox "Email"
agent-browser click @e2
```


Annotated screenshots also cache refs, so you can interact with elements immediately. This is useful when the text snapshot is insufficient -- unlabeled icons, canvas content, or visual layout verification.

## Iframes

Snapshots automatically detect and inline iframe content. Each `Iframe` node in the main frame is resolved and its child accessibility tree is included directly beneath it. Refs assigned to elements inside iframes carry frame context, so interactions work without switching frames first.


``` shiki
agent-browser snapshot -i
# @e1 [heading] "Checkout"
# @e2 [Iframe] "payment-frame"
#   @e3 [input] "Card number"
#   @e4 [button] "Pay"

agent-browser fill @e3 "4111111111111111"
agent-browser click @e4
```


Only one level of iframe nesting is expanded. Cross-origin iframes that block accessibility tree access and empty iframes are silently omitted.

To scope a snapshot to a single iframe, switch into it first:


``` shiki
agent-browser frame @e2
agent-browser snapshot -i       # Only elements inside that iframe
agent-browser frame main        # Return to main frame
```


## Best practices

1.  Use `-i` to reduce output to actionable elements
2.  Re-snapshot after page changes to get updated refs
3.  Scope with `-s` for specific page sections
4.  Use `-d` to limit depth on complex pages
5.  Use `screenshot --annotate` when visual context is needed alongside refs

## JSON output

For programmatic parsing in scripts:


``` shiki
agent-browser snapshot --json
# {"success":true,"data":{"snapshot":"...","refs":{"e1":{"role":"heading","name":"Title"},...}}}
```


Note: JSON uses more tokens than text output. The default text format is preferred for AI agents.


Ask AI<span class="kbd hidden sm:inline-flex items-center gap-0.5 text-xs opacity-60 font-mono">⌘I</span>
