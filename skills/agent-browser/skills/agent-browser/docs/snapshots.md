> Source: https://agent-browser.dev/snapshots



<a href="/" class="flex @min-[1024px]:hidden items-center text-gray-1000"><span class="font-medium tracking-tight" style="font-family:var(--font-geist-pixel-square)">agent-browser</span></a>


<a href="https://github.com/vercel-labs/agent-browser" class="size-8 items-center justify-center @min-[768px]:inline-flex hidden shrink-0" data-geist-button="" data-prefix="false" data-suffix="false" data-version="v1" aria-label="GitHub repository" rel="noopener" target="_blank"><span class="truncate px-1.5 inline-flex shrink-0 items-center justify-center"></span></a>


        &quot;sidebar toc-popover toc&quot;
        &quot;sidebar main toc&quot; 1fr / minmax(var(--fd-sidebar-col), 1fr) minmax(0, calc(var(--fd-layout-width,97rem) - var(--fd-sidebar-width) - var(--fd-toc-width))) minmax(min-content, 1fr);--fd-docs-row-1:4rem;--fd-docs-row-2:calc(var(--fd-docs-row-1) + var(--fd-header-height));--fd-docs-row-3:calc(var(--fd-docs-row-2) + var(--fd-toc-popover-height));--fd-sidebar-col:var(--fd-sidebar-width)">


Menu


# Snapshots


Copy for LLM


View Markdown


The `snapshot` command returns a compact accessibility tree with refs for element interaction.

## <a href="#options" class="peer" data-card="">Options</a>

Filter output to reduce size:


``` m-0
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
| `-u, --urls`        | Include href URLs for link elements                |
| `-c, --compact`     | Remove empty structural elements                   |
| `-d, --depth`       | Limit tree depth                                   |
| `-s, --selector`    | Scope to CSS selector                              |

## <a href="#output-format" class="peer" data-card="">Output format</a>

The default text output is compact and AI-friendly:


``` m-0
agent-browser snapshot -i
# Output:
# @e1 [heading] "Example Domain" [level=1]
# @e2 [button] "Submit"
# @e3 [input type="email"] placeholder="Email"
# @e4 [link] "Learn more"
```


## <a href="#using-refs" class="peer" data-card="">Using refs</a>

Refs from the snapshot map directly to commands:


``` m-0
agent-browser click @e2      # Click the Submit button
agent-browser fill @e3 "a@b.com"  # Fill the email input
agent-browser get text @e1        # Get heading text
```


## <a href="#ref-lifecycle" class="peer" data-card="">Ref lifecycle</a>

Surviving DOM elements retain their refs across snapshots and same-document updates. Replacing an element or navigating its page or iframe invalidates its refs without recycling IDs. Virtual accessibility nodes have snapshot-local refs. Re-snapshot after interactions to observe changes, and always after navigation:


``` m-0
agent-browser click @e4      # Navigates to new page
agent-browser snapshot -i    # Get fresh refs
agent-browser click @e8      # Use a ref from the new snapshot
```


## <a href="#annotated-screenshots" class="peer" data-card="">Annotated screenshots</a>

For visual context alongside text snapshots, use `screenshot --annotate` to overlay numbered labels on interactive elements. Each label `[N]` maps to ref `@eN`:

In native mode, annotated screenshots currently work on the CDP-backed browser path (Chromium/Lightpanda). The Safari/WebDriver backend does not yet support `--annotate`.


``` m-0
agent-browser screenshot --annotate ./page.png
# -> Screenshot saved to ./page.png
#    [1] @e1 button "Submit"
#    [2] @e2 link "Home"
#    [3] @e3 textbox "Email"
agent-browser click @e2
```


Headless Chromium screenshots hide native scrollbars for consistent image output. Pass `--hide-scrollbars false` when launching to keep native scrollbars visible.

Annotated screenshots also cache refs, so you can interact with elements immediately. This is useful when the text snapshot is insufficient for unlabeled icons, canvas content, or visual layout verification.

## <a href="#iframes" class="peer" data-card="">Iframes</a>

Snapshots automatically detect and inline iframe content. Each `Iframe` node in the main frame is resolved and its child accessibility tree is included directly beneath it. Refs assigned to elements inside iframes carry frame context, so interactions work without switching frames first.


``` m-0
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


``` m-0
agent-browser frame @e2
agent-browser snapshot -i       # Only elements inside that iframe
agent-browser frame main        # Return to main frame
```


## <a href="#best-practices" class="peer" data-card="">Best practices</a>

1.  Use `-i` to reduce output to actionable elements
2.  Re-snapshot after page changes to get updated refs
3.  Scope with `-s` for specific page sections
4.  Use `-d` to limit depth on complex pages
5.  Use `screenshot --annotate` when visual context is needed alongside refs

## <a href="#json-output" class="peer" data-card="">JSON output</a>

For programmatic parsing in scripts:


``` m-0
agent-browser snapshot --json
# {"success":true,"data":{"snapshot":"...","refs":{"e1":{"role":"heading","name":"Title"},...}}}
```


Note: JSON uses more tokens than text output. The default text format is preferred for AI agents.


<a href="/selectors" class="group grid w-fit grid-cols-[auto_1fr] items-center gap-x-1.5 gap-y-1 text-gray-1000"><span class="text-gray-900 text-sm col-start-2">Previous</span><span class="row-start-2 font-medium col-start-2">Selectors</span></a><a href="/sessions" class="group grid w-fit grid-cols-[1fr_auto] items-center gap-x-1.5 gap-y-1 justify-self-end text-right text-gray-1000"><span class="text-gray-900 text-sm col-start-1">Next</span><span class="row-start-2 font-medium col-start-1">Sessions</span></a>


