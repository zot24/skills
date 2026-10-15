> Source: https://agent-browser.dev/quick-start



<a href="/" class="flex @min-[1024px]:hidden items-center text-gray-1000"><span class="font-medium tracking-tight" style="font-family:var(--font-geist-pixel-square)">agent-browser</span></a>


<a href="https://github.com/vercel-labs/agent-browser" class="size-8 items-center justify-center @min-[768px]:inline-flex hidden shrink-0" data-geist-button="" data-prefix="false" data-suffix="false" data-version="v1" aria-label="GitHub repository" rel="noopener" target="_blank"><span class="truncate px-1.5 inline-flex shrink-0 items-center justify-center"></span></a>


        &quot;sidebar toc-popover toc&quot;
        &quot;sidebar main toc&quot; 1fr / minmax(var(--fd-sidebar-col), 1fr) minmax(0, calc(var(--fd-layout-width,97rem) - var(--fd-sidebar-width) - var(--fd-toc-width))) minmax(min-content, 1fr);--fd-docs-row-1:4rem;--fd-docs-row-2:calc(var(--fd-docs-row-1) + var(--fd-header-height));--fd-docs-row-3:calc(var(--fd-docs-row-2) + var(--fd-toc-popover-height));--fd-sidebar-col:var(--fd-sidebar-width)">


Menu


# Quick Start


Copy for LLM


View Markdown


## <a href="#core-workflow" class="peer" data-card="">Core workflow</a>

Every browser automation follows this pattern:


``` m-0
# 1. Navigate
agent-browser open example.com

# 2. Snapshot to get element refs
agent-browser snapshot -i
# Output:
# @e1 [heading] "Example Domain"
# @e2 [link] "More information..."

# 3. Interact using refs
agent-browser click @e2

# 4. Re-snapshot after page changes
agent-browser snapshot -i
```


## <a href="#common-commands" class="peer" data-card="">Common commands</a>


``` m-0
agent-browser open example.com
agent-browser snapshot -i                # Get interactive elements with refs
agent-browser click @e2                  # Click by ref
agent-browser fill @e3 "test@example.com" # Fill input by ref
agent-browser get text @e1               # Get text content
agent-browser screenshot                 # Save to temp directory
agent-browser screenshot page.png        # Save to specific path
agent-browser close
```


## <a href="#traditional-selectors" class="peer" data-card="">Traditional selectors</a>

CSS selectors and semantic locators also supported:


``` m-0
agent-browser click "#submit"
agent-browser fill "#email" "test@example.com"
agent-browser find role button click --name "Submit"
```


## <a href="#headed-mode" class="peer" data-card="">Headed mode</a>

Show browser window for debugging:


``` m-0
agent-browser open example.com --headed
```


## <a href="#wait-for-content" class="peer" data-card="">Wait for content</a>


``` m-0
agent-browser wait @e1                   # Wait for element
agent-browser wait --text "Welcome"      # Wait for expected text
agent-browser wait --url "**/dashboard"  # Wait for URL pattern
agent-browser wait --fn "window.appReady === true" # Wait for JS condition
agent-browser wait --load domcontentloaded # Wait for the DOM lifecycle event
```


After a page change, prefer the condition that represents the result you need. Use `load` or `domcontentloaded` only when the lifecycle event is the milestone. `networkidle` remains available for pages known to become quiet, but SSE, WebSockets, polling, and long-polling can keep it from resolving.

## <a href="#command-chaining" class="peer" data-card="">Command chaining</a>

Chain commands with `&&` in a single shell call. The browser persists via a background daemon, so chaining is safe and efficient:


``` m-0
# Open, wait, and snapshot in one call
agent-browser open example.com && agent-browser wait --load domcontentloaded && agent-browser snapshot -i

# Chain multiple interactions
agent-browser fill @e1 "user@example.com" && agent-browser fill @e2 "pass" && agent-browser click @e3

# Navigate and capture
agent-browser open example.com && agent-browser wait --load load && agent-browser screenshot page.png
```


Use `&&` when you don't need intermediate output. Run commands separately when you need to parse output first (e.g., snapshot to discover refs before interacting).

## <a href="#json-output" class="peer" data-card="">JSON output</a>

For programmatic parsing in scripts:


``` m-0
agent-browser snapshot --json
agent-browser get text @e1 --json
```


Note: The default text output is more compact and preferred for AI agents.


<a href="/installation" class="group grid w-fit grid-cols-[auto_1fr] items-center gap-x-1.5 gap-y-1 text-gray-1000"><span class="text-gray-900 text-sm col-start-2">Previous</span><span class="row-start-2 font-medium col-start-2">Installation</span></a><a href="/skills" class="group grid w-fit grid-cols-[1fr_auto] items-center gap-x-1.5 gap-y-1 justify-self-end text-right text-gray-1000"><span class="text-gray-900 text-sm col-start-1">Next</span><span class="row-start-2 font-medium col-start-1">Skills</span></a>


