> Source: https://agent-browser.dev/selectors



<a href="/" class="flex @min-[1024px]:hidden items-center text-gray-1000"><span class="font-medium tracking-tight" style="font-family:var(--font-geist-pixel-square)">agent-browser</span></a>


<a href="https://github.com/vercel-labs/agent-browser" class="size-8 items-center justify-center @min-[768px]:inline-flex hidden shrink-0" data-geist-button="" data-prefix="false" data-suffix="false" data-version="v1" aria-label="GitHub repository" rel="noopener" target="_blank"><span class="truncate px-1.5 inline-flex shrink-0 items-center justify-center"></span></a>


        &quot;sidebar toc-popover toc&quot;
        &quot;sidebar main toc&quot; 1fr / minmax(var(--fd-sidebar-col), 1fr) minmax(0, calc(var(--fd-layout-width,97rem) - var(--fd-sidebar-width) - var(--fd-toc-width))) minmax(min-content, 1fr);--fd-docs-row-1:4rem;--fd-docs-row-2:calc(var(--fd-docs-row-1) + var(--fd-header-height));--fd-docs-row-3:calc(var(--fd-docs-row-2) + var(--fd-toc-popover-height));--fd-sidebar-col:var(--fd-sidebar-width)">


Menu


# Selectors


Copy for LLM


View Markdown


## <a href="#refs-recommended" class="peer" data-card="">Refs (recommended)</a>

Refs provide deterministic element selection from snapshots. Best for AI agents.


``` m-0
# 1. Get snapshot with refs
agent-browser snapshot
# Output:
# - heading "Example Domain" [ref=e1] [level=1]
# - button "Submit" [ref=e2]
# - textbox "Email" [ref=e3]
# - link "Learn more" [ref=e4]

# 2. Use refs to interact
agent-browser click @e2                   # Click the button
agent-browser fill @e3 "test@example.com" # Fill the textbox
agent-browser get text @e1                # Get heading text
agent-browser hover @e4                   # Hover the link
```


### <a href="#why-refs" class="peer" data-card="">Why refs?</a>

- **Deterministic** - Ref points to exact element from snapshot
- **Fast** - No DOM re-query needed
- **AI-friendly** - LLMs can reliably parse and use refs

## <a href="#css-selectors" class="peer" data-card="">CSS selectors</a>


``` m-0
agent-browser click "#id"
agent-browser click ".class"
agent-browser click "div > button"
agent-browser click "[data-testid='submit']"
```


## <a href="#text-xpath" class="peer" data-card="">Text &amp; XPath</a>


``` m-0
agent-browser click "text=Submit"
agent-browser click "xpath=//button[@type='submit']"
```


## <a href="#semantic-locators" class="peer" data-card="">Semantic locators</a>

Find elements by role, label, or other semantic properties:


``` m-0
agent-browser find role button click --name "Submit"
agent-browser find role heading text --name "Skills"     # implicit roles work: <h2>=heading, <ul>=list, top-level <header>=banner
agent-browser find label "Email" fill "test@test.com"
agent-browser find placeholder "Search..." fill "query"
agent-browser find testid "submit-btn" click
```


<a href="/plugins" class="group grid w-fit grid-cols-[auto_1fr] items-center gap-x-1.5 gap-y-1 text-gray-1000"><span class="text-gray-900 text-sm col-start-2">Previous</span><span class="row-start-2 font-medium col-start-2">Plugins</span></a><a href="/snapshots" class="group grid w-fit grid-cols-[1fr_auto] items-center gap-x-1.5 gap-y-1 justify-self-end text-right text-gray-1000"><span class="text-gray-900 text-sm col-start-1">Next</span><span class="row-start-2 font-medium col-start-1">Snapshots</span></a>


