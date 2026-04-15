> Source: https://agent-browser.dev/quick-start



[](https://vercel.com "Made with love by Vercel")<span class="text-neutral-300 dark:text-neutral-700"></span>[<span class="font-medium tracking-tight text-lg" style="font-family:var(--font-geist-pixel-square)">agent-browser</span>](/)


Quick Start


Copy Page


# Quick Start<a href="#quick-start" aria-label="Link to this section">#</a>

## Core workflow<a href="#core-workflow" aria-label="Link to this section">#</a>

Every browser automation follows this pattern:


``` shiki
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


## Common commands<a href="#common-commands" aria-label="Link to this section">#</a>


``` shiki
agent-browser open example.com
agent-browser snapshot -i                # Get interactive elements with refs
agent-browser click @e2                  # Click by ref
agent-browser fill @e3 "test@example.com" # Fill input by ref
agent-browser get text @e1               # Get text content
agent-browser screenshot                 # Save to temp directory
agent-browser screenshot page.png        # Save to specific path
agent-browser close
```


## Traditional selectors<a href="#traditional-selectors" aria-label="Link to this section">#</a>

CSS selectors and semantic locators also supported:


``` shiki
agent-browser click "#submit"
agent-browser fill "#email" "test@example.com"
agent-browser find role button click --name "Submit"
```


## Headed mode<a href="#headed-mode" aria-label="Link to this section">#</a>

Show browser window for debugging:


``` shiki
agent-browser open example.com --headed
```


## Wait for content<a href="#wait-for-content" aria-label="Link to this section">#</a>


``` shiki
agent-browser wait @e1                   # Wait for element
agent-browser wait --load networkidle    # Wait for network idle
agent-browser wait --url "**/dashboard"  # Wait for URL pattern
agent-browser wait 2000                  # Wait milliseconds
```


## Command chaining<a href="#command-chaining" aria-label="Link to this section">#</a>

Chain commands with `&&` in a single shell call. The browser persists via a background daemon, so chaining is safe and efficient:


``` shiki
# Open, wait, and snapshot in one call
agent-browser open example.com && agent-browser wait --load networkidle && agent-browser snapshot -i

# Chain multiple interactions
agent-browser fill @e1 "user@example.com" && agent-browser fill @e2 "pass" && agent-browser click @e3

# Navigate and capture
agent-browser open example.com && agent-browser wait --load networkidle && agent-browser screenshot page.png
```


Use `&&` when you don't need intermediate output. Run commands separately when you need to parse output first (e.g., snapshot to discover refs before interacting).

## JSON output<a href="#json-output" aria-label="Link to this section">#</a>

For programmatic parsing in scripts:


``` shiki
agent-browser snapshot --json
agent-browser get text @e1 --json
```


Note: The default text output is more compact and preferred for AI agents.


Ask AI<span class="kbd hidden sm:inline-flex items-center gap-0.5 text-xs opacity-60 font-mono">⌘I</span>
