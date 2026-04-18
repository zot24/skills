[Skip to main content](https://docs.firecrawl.dev/features/interact#content-area)

[Firecrawl Docs home page![light logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=c45b3c967c19a39190e76fe8e9c2ed5a)![dark logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=3fee4abe033bd3c26e8ad92043a91c17)](https://firecrawl.dev/)

v2
![US](https://d3gk2c5xim1je2.cloudfront.net/flags/US.svg)

English

Search...

Ctrl K

Search...

Navigation

Core Endpoints

Interact after scraping

[Documentation](https://docs.firecrawl.dev/introduction) [SDKs](https://docs.firecrawl.dev/sdks/overview) [Integrations](https://www.firecrawl.dev/app) [API Reference](https://docs.firecrawl.dev/api-reference/v2-introduction)

- [Playground](https://firecrawl.dev/playground)
- [Blog](https://firecrawl.dev/blog)
- [Community](https://discord.gg/firecrawl)
- [Changelog](https://firecrawl.dev/changelog)

##### Get Started

- [Introduction](https://docs.firecrawl.dev/introduction)
- [Skill + CLI](https://docs.firecrawl.dev/sdks/cli)
- [MCP Server](https://docs.firecrawl.dev/mcp-server)
- [Advanced Scraping Guide](https://docs.firecrawl.dev/advanced-scraping-guide)
- Plans & Billing


##### Core Endpoints

- [Search](https://docs.firecrawl.dev/features/search)
- Scrape

- [Interact](https://docs.firecrawl.dev/features/interact)

##### More

- [Map](https://docs.firecrawl.dev/features/map)
- [Crawl](https://docs.firecrawl.dev/features/crawl)
- Agent (Research Preview)


##### Quickstarts

- Node.js

- Serverless

- PHP

- Ruby

- Python

- [Go](https://docs.firecrawl.dev/quickstarts/go)
- [Rust](https://docs.firecrawl.dev/quickstarts/rust)
- [Elixir](https://docs.firecrawl.dev/quickstarts/elixir)
- Java

- .NET


##### Developer Guides

- [OpenClaw](https://docs.firecrawl.dev/developer-guides/openclaw)
- [Full-Stack Templates](https://docs.firecrawl.dev/developer-guides/examples)
- Usage Guides

- LLM SDKs and Frameworks

- Cookbooks

- MCP Setup Guides

- Common Sites

- Workflow Automation


##### Webhooks

- [Overview](https://docs.firecrawl.dev/webhooks/overview)
- [Event Types](https://docs.firecrawl.dev/webhooks/events)
- [Security](https://docs.firecrawl.dev/webhooks/security)
- [Testing](https://docs.firecrawl.dev/webhooks/testing)

##### Use Cases

- [Overview](https://docs.firecrawl.dev/use-cases/overview)
- [AI Platforms](https://docs.firecrawl.dev/use-cases/ai-platforms)
- [Lead Enrichment](https://docs.firecrawl.dev/use-cases/lead-enrichment)
- [SEO Platforms](https://docs.firecrawl.dev/use-cases/seo-platforms)
- [Deep Research](https://docs.firecrawl.dev/use-cases/deep-research)
- View more


##### Dashboard

- [Overview](https://docs.firecrawl.dev/dashboard)

##### Contributing

- [Open Source vs Cloud](https://docs.firecrawl.dev/contributing/open-source-or-cloud)
- [Running Locally](https://docs.firecrawl.dev/contributing/guide)
- [Self-hosting](https://docs.firecrawl.dev/contributing/self-host)

On this page

- [How It Works](https://docs.firecrawl.dev/features/interact#how-it-works)
- [Quick Start](https://docs.firecrawl.dev/features/interact#quick-start)
- [Interact via prompting](https://docs.firecrawl.dev/features/interact#interact-via-prompting)
- [Keep Prompts Small and Focused](https://docs.firecrawl.dev/features/interact#keep-prompts-small-and-focused)
- [Running Code](https://docs.firecrawl.dev/features/interact#running-code)
- [Node.js (Playwright)](https://docs.firecrawl.dev/features/interact#node-js-playwright)
- [Python](https://docs.firecrawl.dev/features/interact#python)
- [Bash (agent-browser)](https://docs.firecrawl.dev/features/interact#bash-agent-browser)
- [Live View](https://docs.firecrawl.dev/features/interact#live-view)
- [Interactive Live View](https://docs.firecrawl.dev/features/interact#interactive-live-view)
- [Session Lifecycle](https://docs.firecrawl.dev/features/interact#session-lifecycle)
- [Creation](https://docs.firecrawl.dev/features/interact#creation)
- [Reuse](https://docs.firecrawl.dev/features/interact#reuse)
- [Cleanup](https://docs.firecrawl.dev/features/interact#cleanup)
- [Persistent Profiles](https://docs.firecrawl.dev/features/interact#persistent-profiles)
- [When to Use What](https://docs.firecrawl.dev/features/interact#when-to-use-what)
- [Pricing](https://docs.firecrawl.dev/features/interact#pricing)
- [API Reference](https://docs.firecrawl.dev/features/interact#api-reference)
- [Request Body (POST)](https://docs.firecrawl.dev/features/interact#request-body-post)
- [Response](https://docs.firecrawl.dev/features/interact#response)

![Firecrawl](https://docs.firecrawl.dev/logo/light.svg)![Firecrawl](https://docs.firecrawl.dev/logo/dark.svg)

### Ready to build?

Start getting web data for free and scale seamlessly as your project expands. **No credit card needed.**

[Start for free](https://www.firecrawl.dev/signin?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=start_for_free) [See our plans](https://www.firecrawl.dev/pricing?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=see_our_plans)

Scrape a page to get clean data, then call `/interact` to start taking actions in that page - click buttons, fill forms, extract dynamic content, or navigate deeper. Just describe what you want, or write code if you need full control.

## AI prompts

Describe what action you want to take in the page

## Code execution

Interact via code execution securely with playwright, agent-browser

## Live view

Watch or interact with the browser in real time via embeddable stream

## [​](https://docs.firecrawl.dev/features/interact\#how-it-works)  How It Works

1. **Scrape** a URL with `POST /v2/scrape`. The response includes a `scrapeId` in `data.metadata.scrapeId`. Optionally pass a `profile` to persist browser state across sessions.
2. **Interact** by calling `POST /v2/scrape/{scrapeId}/interact` with a `prompt` or with playwright `code`. On the first call, the scraped session is resumed and you can start interacting with the page.
3. **Stop** the session with `DELETE /v2/scrape/{scrapeId}/interact` when you’re done.

## [​](https://docs.firecrawl.dev/features/interact\#quick-start)  Quick Start

Scrape a page, interact with it, and stop the session:

Python

Node

cURL

CLI

```
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR-API-KEY")

# 1. Scrape Amazon's homepage
result = app.scrape("https://www.amazon.com", formats=["markdown"])
scrape_id = result.metadata.scrape_id

# 2. Interact — search for a product and get its price
app.interact(scrape_id, prompt="Search for iPhone 16 Pro Max")
response = app.interact(scrape_id, prompt="Click on the first result and tell me the price")
print(response.output)

# 3. Stop the session
app.stop_interaction(scrape_id)
```

Response

```
{
  "success": true,
  "liveViewUrl": "https://liveview.firecrawl.dev/...",
  "interactiveLiveViewUrl": "https://liveview.firecrawl.dev/...",
  "output": "The iPhone 16 Pro Max (256GB) is priced at $1,199.00.",
  "exitCode": 0,
  "killed": false
}
```

## [​](https://docs.firecrawl.dev/features/interact\#interact-via-prompting)  Interact via prompting

The simplest way to interact with a page. Describe what you want in natural language and it will click, type, scroll, and extract data automatically.

Python

Node

cURL

CLI

```
response = app.interact(scrape_id, prompt="What are the customer reviews saying about battery life?")
print(response.output)
```

The response includes an `output` field with the agent’s answer:

Response

```
{
  "success": true,
  "liveViewUrl": "https://liveview.firecrawl.dev/...",
  "interactiveLiveViewUrl": "https://liveview.firecrawl.dev/...",
  "output": "Customers are generally positive about battery life. Most reviewers report 8-10 hours of use on a single charge. A few noted it drains faster with heavy multitasking.",
  "stdout": "...",
  "result": "...",
  "stderr": "",
  "exitCode": 0,
  "killed": false
}
```

### [​](https://docs.firecrawl.dev/features/interact\#keep-prompts-small-and-focused)  Keep Prompts Small and Focused

Prompts work best when each one is a **single, clear task**. Instead of asking the agent to do a complex multi-step workflow in one shot, break it into separate interact calls. Each call reuses the same browser session, so state carries over between them.

## [​](https://docs.firecrawl.dev/features/interact\#running-code)  Running Code

For full control, you can execute code directly in the browser sandbox. The `page` variable (a Playwright Page object) is available in Node.js and Python. Bash mode has [agent-browser](https://github.com/vercel-labs/agent-browser) pre-installed. You can also take screenshots within the session — use `(await page.screenshot()).toString("base64")` in Node.js, `await page.screenshot(path="/tmp/screenshot.png")` in Python, or `agent-browser screenshot` in Bash.

### [​](https://docs.firecrawl.dev/features/interact\#node-js-playwright)  Node.js (Playwright)

The default language. Write Playwright code directly — `page` is already connected to the browser.

Python

Node

cURL

CLI

```
response = app.interact(scrape_id, code="""
// Click a button and wait for navigation
await page.click('#next-page');
await page.waitForLoadState('networkidle');

// Extract content from the new page
const title = await page.title();
const content = await page.$eval('.article-body', el => el.textContent);
JSON.stringify({ title, content });
""")
print(response.result)
```

### [​](https://docs.firecrawl.dev/features/interact\#python)  Python

Set `language` to `"python"` for Playwright’s Python API.

Python

Node

cURL

CLI

```
response = app.interact(
    scrape_id,
    code="""
import json

await page.click('#load-more')
await page.wait_for_load_state('networkidle')

items = await page.query_selector_all('.item')
data = []
for item in items:
    text = await item.text_content()
    data.append(text.strip())

print(json.dumps(data))
""",
    language="python",
)
print(response.stdout)
```

### [​](https://docs.firecrawl.dev/features/interact\#bash-agent-browser)  Bash (agent-browser)

[agent-browser](https://github.com/vercel-labs/agent-browser) is a CLI pre-installed in the sandbox with 60+ commands. It provides an accessibility tree with element refs (`@e1`, `@e2`, …) — ideal for LLM-driven automation.

Python

Node

cURL

CLI

```
# Take a snapshot to see interactive elements
snapshot = app.interact(
    scrape_id,
    code="agent-browser snapshot -i",
    language="bash",
)
print(snapshot.stdout)
# Output:
# [document]
#   @e1 [input type="text"] "Search..."
#   @e2 [button] "Search"
#   @e3 [link] "About"

# Interact with elements using @refs
app.interact(
    scrape_id,
    code='agent-browser fill @e1 "firecrawl" && agent-browser click @e2',
    language="bash",
)
```

Common agent-browser commands:

| Command | Description |
| --- | --- |
| `snapshot` | Full accessibility tree with element refs |
| `snapshot -i` | Interactive elements only |
| `click @e1` | Click element by ref |
| `fill @e1 "text"` | Clear field and type text |
| `type @e1 "text"` | Type without clearing |
| `press Enter` | Press a keyboard key |
| `scroll down 500` | Scroll down by pixels |
| `get text @e1` | Get text content |
| `get url` | Get current URL |
| `wait @e1` | Wait for element |
| `wait --load networkidle` | Wait for network idle |
| `find text "X" click` | Find element by text and click |
| `screenshot` | Take a screenshot of the current page |
| `eval "js code"` | Run JavaScript in page |

## [​](https://docs.firecrawl.dev/features/interact\#live-view)  Live View

Every interact response returns a `liveViewUrl` that you can embed to watch the browser in real time. Useful for debugging, demos, or building browser-powered UIs.

Response

```
{
  "success": true,
  "liveViewUrl": "https://liveview.firecrawl.dev/...",
  "interactiveLiveViewUrl": "https://liveview.firecrawl.dev/...",
  "stdout": "",
  "result": "...",
  "exitCode": 0
}
```

```
<iframe src="LIVE_VIEW_URL" width="100%" height="600" />
```

### [​](https://docs.firecrawl.dev/features/interact\#interactive-live-view)  Interactive Live View

The response also includes an `interactiveLiveViewUrl`. Unlike the standard live view which is view-only, the interactive live view allows users to click, type, and interact with the browser session directly through the embedded stream. This is useful for building user-facing browser UIs — such as login flows, or guided workflows where end users need to control the browser.

```
<iframe src="INTERACTIVE_LIVE_VIEW_URL" width="100%" height="600" />
```

## [​](https://docs.firecrawl.dev/features/interact\#session-lifecycle)  Session Lifecycle

### [​](https://docs.firecrawl.dev/features/interact\#creation)  Creation

The first `POST /v2/scrape/{scrapeId}/interact` continues the scrape session and starts the interaction.

### [​](https://docs.firecrawl.dev/features/interact\#reuse)  Reuse

Subsequent interact calls on the same `scrapeId` reuse the existing session. The browser stays open and maintains its state between calls, so you can chain multiple interactions:

Python

Node

CLI

```
# First call — click a tab
app.interact(scrape_id, code="await page.click('#tab-2')")

# Second call — the tab is still selected, extract its content
result = app.interact(scrape_id, code="await page.$eval('#tab-2-content', el => el.textContent)")
print(result.result)
```

### [​](https://docs.firecrawl.dev/features/interact\#cleanup)  Cleanup

Stop the session explicitly when done:

Python

Node

cURL

CLI

```
app.stop_interaction(scrape_id)
```

Sessions also expire automatically based on TTL (default: 10 minutes) or inactivity timeout (default: 5 minutes).

Always stop sessions when you’re done to avoid unnecessary billing. Credits are prorated by the second.

## [​](https://docs.firecrawl.dev/features/interact\#persistent-profiles)  Persistent Profiles

By default, each scrape + interact session starts with a clean browser. With `profile`, you can save and reuse browser state (cookies, localStorage, sessions) across scrapes. This is useful for staying logged in and preserving preferences.Pass the `profile` parameter when calling scrape. Sessions with the same profile name share state.

Python

Node

cURL

CLI

```
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR-API-KEY")

# Session 1: Scrape with a profile, log in, then stop (state is saved)
result = app.scrape(
    "https://app.example.com/login",
    formats=["markdown"],
    profile={"name": "my-app", "save_changes": True},
)
scrape_id = result.metadata.scrape_id

app.interact(scrape_id, prompt="Fill in user@example.com and password, then click Login")
app.stop_interaction(scrape_id)

# Session 2: Scrape with the same profile — already logged in
result = app.scrape(
    "https://app.example.com/dashboard",
    formats=["markdown"],
    profile={"name": "my-app", "save_changes": True},
)
scrape_id = result.metadata.scrape_id

response = app.interact(scrape_id, prompt="Extract the dashboard data")
print(response.output)
app.stop_interaction(scrape_id)
```

| Parameter | Default | Description |
| --- | --- | --- |
| `name` | — | A name for the persistent profile. Scrapes with the same name share browser state. |
| `saveChanges` | `true` | When `true`, browser state is saved back to the profile when the interact session stops. Set to `false` to load existing data without writing — useful when you need multiple concurrent readers. |

Only one session can save to a profile at a time. If another session is already saving, you’ll get a `409` error. You can still open the same profile with `saveChanges: false`, or try again later.

The browser state is saved when the interact session is stopped. Always stop the session when you’re done so the profile can be reused.

## [​](https://docs.firecrawl.dev/features/interact\#when-to-use-what)  When to Use What

| Use Case | Recommended | Why |
| --- | --- | --- |
| Web search | [Search](https://docs.firecrawl.dev/features/search) | Dedicated search endpoint |
| Get clean content from a URL | [Scrape](https://docs.firecrawl.dev/features/scrape) | One API call, no session needed |
| Click, type, navigate on a page | **Interact** (prompt) | Just describe it in English |
| Extract data behind interactions | **Interact** (prompt) | No selectors needed |
| Complex scraping logic | **Interact** (code) | Full Playwright control |

**Interact vs Browser Sandbox**: Interact is built on the same infrastructure as [Browser Sandbox](https://docs.firecrawl.dev/features/browser) but provides a better interface for the most common pattern — scrape a page, then go deeper. Browser Sandbox is better when you need a standalone browser session that isn’t tied to a specific scrape.

## [​](https://docs.firecrawl.dev/features/interact\#pricing)  Pricing

- **Code-only** (no `prompt`) — 2 credits per session minute
- **With AI prompts** — 7 credits per session minute
- **Scrape** — billed separately (1 credit per scrape, plus any format-specific costs)

## [​](https://docs.firecrawl.dev/features/interact\#api-reference)  API Reference

- [Execute Interact](https://docs.firecrawl.dev/api-reference/endpoint/scrape-execute) — `POST /v2/scrape/{scrapeId}/interact`
- [Stop Interact](https://docs.firecrawl.dev/api-reference/endpoint/scrape-browser-delete) — `DELETE /v2/scrape/{scrapeId}/interact`

### [​](https://docs.firecrawl.dev/features/interact\#request-body-post)  Request Body (POST)

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `prompt` | `string` | — | Natural language task for the AI agent. Required if `code` is not set. Max 10,000 characters. |
| `code` | `string` | — | Code to execute (Node.js, Python, or Bash). Required if `prompt` is not set. Max 100,000 characters. |
| `language` | `string` | `"node"` | `"node"`, `"python"`, or `"bash"`. Only used with `code`. |
| `timeout` | `number` | `30` | Timeout in seconds (1–300). |
| `origin` | `string` | — | Caller identifier for activity tracking. |

### [​](https://docs.firecrawl.dev/features/interact\#response)  Response

| Field | Description |
| --- | --- |
| `success` | `true` if the execution completed without errors |
| `liveViewUrl` | Read-only live view URL for the browser session |
| `interactiveLiveViewUrl` | Interactive live view URL (viewers can control the browser) |
| `output` | The agent’s natural language answer to your prompt. Only present when using `prompt`. |
| `stdout` | Standard output from the code execution |
| `result` | Raw return value from the sandbox. For `code`: the last expression evaluated. For `prompt`: the raw page snapshot the agent used to produce `output`. |
| `stderr` | Standard error output |
| `exitCode` | Exit code (`0` = success) |
| `killed` | `true` if the execution was terminated due to timeout |

* * *

Have feedback or need help? Email [help@firecrawl.com](mailto:help@firecrawl.com) or reach out on [Discord](https://discord.gg/firecrawl).

[Suggest edits](https://github.com/firecrawl/firecrawl-docs/edit/main/features/interact.mdx) [Raise issue](https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&body=Path:%20/features/interact)

[Document Parsing\\
\\
Previous](https://docs.firecrawl.dev/features/document-parsing) [Map\\
\\
Next](https://docs.firecrawl.dev/features/map)

Ctrl+I

Chat Widget

Loading...