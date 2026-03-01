> Source: https://agent-browser.dev/selectors



[](https://vercel.com "Made with love by Vercel")<span class="text-border"></span>[<span class="font-medium tracking-tight text-lg" style="font-family:var(--font-geist-pixel-square)">agent-browser</span>](/)


# Selectors

## Refs (recommended)

Refs provide deterministic element selection from snapshots. Best for AI agents.


``` shiki
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


### Why refs?

- **Deterministic** - Ref points to exact element from snapshot
- **Fast** - No DOM re-query needed
- **AI-friendly** - LLMs can reliably parse and use refs

## CSS selectors


``` shiki
agent-browser click "#id"
agent-browser click ".class"
agent-browser click "div > button"
agent-browser click "[data-testid='submit']"
```


## Text & XPath


``` shiki
agent-browser click "text=Submit"
agent-browser click "xpath=//button[@type='submit']"
```


## Semantic locators

Find elements by role, label, or other semantic properties:


``` shiki
agent-browser find role button click --name "Submit"
agent-browser find label "Email" fill "test@test.com"
agent-browser find placeholder "Search..." fill "query"
agent-browser find testid "submit-btn" click
```


Ask AI<span class="kbd hidden sm:inline-flex items-center gap-0.5 text-xs opacity-60 font-mono">⌘K</span>
