> Source: https://docs.firecrawl.dev/features/interact



> ## Documentation Index
>
> Fetch the complete documentation index at: <a href="/llms.txt" tabindex="-1">/llms.txt</a>
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="https://firecrawl.dev" class="select-none" style="-webkit-touch-callout:none"><span class="sr-only">Firecrawl Docs home page</span><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=c45b3c967c19a39190e76fe8e9c2ed5a" class="nav-logo w-auto relative object-contain shrink-0 block dark:hidden h-6" alt="light logo" /><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=3fee4abe033bd3c26e8ad92043a91c17" class="nav-logo w-auto relative object-contain shrink-0 hidden dark:block h-6" alt="dark logo" /></a>


Search...


Core Endpoints


Interact after scraping


<a href="/introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor] hover:text-primary dark:hover:text-primary-light text-gray-800 dark:text-gray-200" data-active="true" aria-current="location">Documentation</a>


<a href="/sdks/overview" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">SDKs</a>


<a href="/api-reference/v2-introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">API Reference</a>


<a href="/ai-onboarding" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">Build with AI</a>


Core Endpoints


# Interact after scraping


Interact with a page you fetched by prompting or running code.


<a href="" class="link firecrawl-cta-btn-primary firecrawl-cta-btn-inline" target="_blank" rel="noreferrer"><span data-as="p">Start the interview</span></a>


## 


<a href="#choose-the-right-interaction-model" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Need                                                      | Use                                           | Canonical docs                                                                                                                                                                                                                                                                                                                                                                                                                   | SDK methods (Node)                                                   |
|-----------------------------------------------------------|-----------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------|
| Start a standalone browser session without scraping first | Browser Sandbox / standalone Interact session | <a href="/features/browser" class="link">Browser Sandbox</a>, <a href="/api-reference/endpoint/browser-create" class="link">Create Browser Session</a>, <a href="/api-reference/endpoint/browser-execute" class="link">Execute Browser Code</a>, <a href="/api-reference/endpoint/browser-list" class="link">List Browser Sessions</a>, <a href="/api-reference/endpoint/browser-delete" class="link">Delete Browser Session</a> | `browser()`, `browserExecute()`, `listBrowsers()`, `deleteBrowser()` |
| Continue from a scrape result using `scrapeId`            | Interact after scraping                       | <a href="/api-reference/endpoint/scrape-execute" class="link">Execute Interact</a>, <a href="/api-reference/endpoint/scrape-browser-delete" class="link">Stop Interact</a>                                                                                                                                                                                                                                                       | `interact()`, `stopInteraction()`                                    |


## AI prompts


## Code execution


## Live view


## 


<a href="#how-it-works" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  **Scrape** a URL with `POST /v2/scrape`. The response includes a `scrapeId` in `data.metadata.scrapeId`. If you want persistent browser state, pass `profile` on this request.
2.  **Interact** by calling `POST /v2/scrape/{scrapeId}/interact` with a `prompt` or with playwright `code`. Do not pass `profile` here; the interact session inherits the profile from the scrape job.
3.  **Stop** the session with `DELETE /v2/scrape/{scrapeId}/interact` when you’re done. For writable profiles, changes are saved when the session stops.

## 


<a href="#quick-start" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


CLI


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(
  # No API key needed to get started — add one for higher rate limits:
  # api_key="fc-YOUR-API-KEY",
)

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


``` shiki
import { Firecrawl } from 'firecrawl';

const app = new Firecrawl({
  // No API key needed to get started — add one for higher rate limits:
  // apiKey: 'fc-YOUR-API-KEY',
});

// 1. Scrape Amazon's homepage
const result = await app.scrape('https://www.amazon.com', { formats: ['markdown'] });
const scrapeId = result.metadata?.scrapeId;

// 2. Interact — search for a product and get its price
await app.interact(scrapeId, { prompt: 'Search for iPhone 16 Pro Max' });
const response = await app.interact(scrapeId, { prompt: 'Click on the first result and tell me the price' });
console.log(response.output);

// 3. Stop the session
await app.stopInteraction(scrapeId);
```


``` shiki
# 1. Scrape Amazon's homepage
# No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
RESPONSE=$(curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://www.amazon.com", "formats": ["markdown"]}')

SCRAPE_ID=$(echo $RESPONSE | jq -r '.data.metadata.scrapeId')

# 2. Interact — search for a product and get its price
curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
  -H "Content-Type: application/json" \
  -d '{"prompt": "Search for iPhone 16 Pro Max"}'

curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
  -H "Content-Type: application/json" \
  -d '{"prompt": "Click on the first result and tell me the price"}'

# 3. Stop the session
curl -s -X DELETE "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact"
```


``` shiki
# 1. Scrape Amazon's homepage (scrape ID is saved automatically)
firecrawl scrape https://www.amazon.com

# 2. Interact — search for a product and get its price
firecrawl interact "Search for iPhone 16 Pro Max"
firecrawl interact "Click on the first result and tell me the price"

# 3. Stop the session
firecrawl interact stop
```


``` shiki
{
  "success": true,
  "cdpUrl": "wss://browser.firecrawl.dev/...",
  "liveViewUrl": "https://liveview.firecrawl.dev/...",
  "interactiveLiveViewUrl": "https://liveview.firecrawl.dev/...",
  "output": "The iPhone 16 Pro Max (256GB) is priced at $1,199.00.",
  "exitCode": 0,
  "killed": false
}
```


## 


<a href="#interact-via-prompting" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


CLI


``` shiki
response = app.interact(scrape_id, prompt="What are the customer reviews saying about battery life?")
print(response.output)
```


``` shiki
const response = await app.interact(scrapeId, {
  prompt: 'What are the customer reviews saying about battery life?',
});
console.log(response.output);
```


``` shiki
# No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "What are the customer reviews saying about battery life?"
  }'
```


``` shiki
firecrawl interact "What are the customer reviews saying about battery life?"
```


``` shiki
{
  "success": true,
  "cdpUrl": "wss://browser.firecrawl.dev/...",
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


### 


<a href="#keep-prompts-small-and-focused" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#running-code" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#node-js-playwright" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


CLI


``` shiki
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


``` shiki
const response = await app.interact(scrapeId, {
  code: `
    // Click a button and wait for navigation
    await page.click('#next-page');
    await page.waitForLoadState('networkidle');

    // Extract content from the new page
    const title = await page.title();
    const content = await page.$eval('.article-body', el => el.textContent);
    JSON.stringify({ title, content });
  `,
});
console.log(response.result);
```


``` shiki
# No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
  -H "Content-Type: application/json" \
  -d '{
    "code": "await page.click(\"#next-page\"); await page.waitForLoadState(\"networkidle\"); const title = await page.title(); JSON.stringify({ title });",
    "language": "node",
    "timeout": 30
  }'
```


``` shiki
# Uses the last scrape automatically
firecrawl interact -c "
  await page.click('#next-page');
  await page.waitForLoadState('networkidle');
  const title = await page.title();
  const content = await page.\$eval('.article-body', el => el.textContent);
  JSON.stringify({ title, content });
"

# Or pass a scrape ID explicitly
# firecrawl interact <scrape-id> -c "await page.title()"
```


### 


<a href="#python" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


CLI


``` shiki
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


``` shiki
const response = await app.interact(scrapeId, {
  code: `
import json

await page.click('#load-more')
await page.wait_for_load_state('networkidle')

items = await page.query_selector_all('.item')
data = []
for item in items:
    text = await item.text_content()
    data.append(text.strip())

print(json.dumps(data))
`,
  language: 'python',
});
console.log(response.stdout);
```


``` shiki
# No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
  -H "Content-Type: application/json" \
  -d '{
    "code": "import json\nawait page.click(\"#load-more\")\nawait page.wait_for_load_state(\"networkidle\")\nitems = await page.query_selector_all(\".item\")\ndata = [await i.text_content() for i in items]\nprint(json.dumps(data))",
    "language": "python"
  }'
```


``` shiki
firecrawl interact --python -c "
import json
await page.click('#load-more')
await page.wait_for_load_state('networkidle')
items = await page.query_selector_all('.item')
data = [await i.text_content() for i in items]
print(json.dumps(data))
"
```


### 


<a href="#bash-agent-browser" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


CLI


``` shiki
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


``` shiki
// Take a snapshot to see interactive elements
const snapshot = await app.interact(scrapeId, {
  code: 'agent-browser snapshot -i',
  language: 'bash',
});
console.log(snapshot.stdout);
// Output:
// [document]
//   @e1 [input type="text"] "Search..."
//   @e2 [button] "Search"
//   @e3 [link] "About"

// Interact with elements using @refs
await app.interact(scrapeId, {
  code: 'agent-browser fill @e1 "firecrawl" && agent-browser click @e2',
  language: 'bash',
});
```


``` shiki
# Take a snapshot to see interactive elements
# No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
  -H "Content-Type: application/json" \
  -d '{"code": "agent-browser snapshot -i", "language": "bash"}'

# Interact with elements using @refs
curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
  -H "Content-Type: application/json" \
  -d '{"code": "agent-browser fill @e1 \"firecrawl\" && agent-browser click @e2", "language": "bash"}'
```


``` shiki
# Take a snapshot to see interactive elements
firecrawl interact --bash -c "agent-browser snapshot -i"

# Interact with elements using @refs
firecrawl interact --bash -c 'agent-browser fill @e1 "firecrawl" && agent-browser click @e2'
```


| Command                   | Description                               |
|---------------------------|-------------------------------------------|
| `snapshot`                | Full accessibility tree with element refs |
| `snapshot -i`             | Interactive elements only                 |
| `click @e1`               | Click element by ref                      |
| `fill @e1 "text"`         | Clear field and type text                 |
| `type @e1 "text"`         | Type without clearing                     |
| `press Enter`             | Press a keyboard key                      |
| `scroll down 500`         | Scroll down by pixels                     |
| `get text @e1`            | Get text content                          |
| `get url`                 | Get current URL                           |
| `wait @e1`                | Wait for element                          |
| `wait --load networkidle` | Wait for network idle                     |
| `find text "X" click`     | Find element by text and click            |
| `screenshot`              | Take a screenshot of the current page     |
| `eval "js code"`          | Run JavaScript in page                    |


## 


<a href="#live-view" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{
  "success": true,
  "cdpUrl": "wss://browser.firecrawl.dev/...",
  "liveViewUrl": "https://liveview.firecrawl.dev/...",
  "interactiveLiveViewUrl": "https://liveview.firecrawl.dev/...",
  "stdout": "",
  "result": "...",
  "exitCode": 0
}
```


``` shiki
<iframe src="LIVE_VIEW_URL" width="100%" height="600" />
```


### 


<a href="#interactive-live-view" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
<iframe src="INTERACTIVE_LIVE_VIEW_URL" width="100%" height="600" />
```


### 


<a href="#cdp-url" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
import { chromium } from "playwright";

const browser = await chromium.connectOverCDP(cdpUrl);
const context = browser.contexts()[0];
const page = context.pages()[0];
```


## 


<a href="#session-lifecycle" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#creation" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#reuse" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


CLI


``` shiki
# First call: click a tab
app.interact(scrape_id, code="await page.click('#tab-2')")

# Second call: the tab is still selected, extract its content
result = app.interact(scrape_id, code="await page.$eval('#tab-2-content', el => el.textContent)")
print(result.result)
```


``` shiki
// First call: click a tab
await app.interact(scrapeId, { code: "await page.click('#tab-2')" });

// Second call: the tab is still selected, extract its content
const result = await app.interact(scrapeId, {
  code: "await page.$eval('#tab-2-content', el => el.textContent)",
});
console.log(result.result);
```


``` shiki
# First call: click a tab
firecrawl interact -c "await page.click('#tab-2')"

# Second call: the tab is still selected, extract its content
firecrawl interact -c "await page.\$eval('#tab-2-content', el => el.textContent)"
```


### 


<a href="#cleanup" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


CLI


``` shiki
app.stop_interaction(scrape_id)
```


``` shiki
await app.stopInteraction(scrapeId);
```


``` shiki
# No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
curl -s -X DELETE "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact"
```


``` shiki
# Stops the last scrape session
firecrawl interact stop

# Or stop a specific session by ID
# firecrawl interact stop <scrape-id>
```


## 


<a href="#persistent-profiles-with-scrape-+-interact" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
curl -X POST "https://api.firecrawl.dev/v2/scrape" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://example.com",
    "formats": ["markdown"],
    "profile": {
      "name": "my-profile",
      "saveChanges": true
    }
  }'

curl -X POST "https://api.firecrawl.dev/v2/scrape/SCRAPE_ID/interact" \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Click the login button"
  }'

curl -X DELETE "https://api.firecrawl.dev/v2/scrape/SCRAPE_ID/interact" \
  -H "Authorization: Bearer fc-YOUR_API_KEY"
```


1.  Create the scrape with `profile.name` and `saveChanges: true`.
2.  Run prompt or code interactions against the returned `scrapeId`.
3.  Stop the session to save cookies, localStorage, and other browser state.
4.  Start a later scrape with the same `profile.name`. Use `saveChanges: false` when you only want to read existing state without writing changes back.


Python


Node


cURL


CLI


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(
  # No API key needed to get started — add one for higher rate limits:
  # api_key="fc-YOUR-API-KEY",
)

# Session 1: Scrape with a profile, log in, then stop (state is saved)
result = app.scrape(
    "https://app.example.com/login",
    formats=["markdown"],
    profile={"name": "my-app", "save_changes": True},
)
scrape_id = result.metadata.scrape_id

app.interact(scrape_id, prompt="Fill in user@example.com and password, then click Login")
app.stop_interaction(scrape_id)

# Session 2: Scrape with the same profile in read-only mode - already logged in
result = app.scrape(
    "https://app.example.com/dashboard",
    formats=["markdown"],
    profile={"name": "my-app", "save_changes": False},
)
scrape_id = result.metadata.scrape_id

response = app.interact(scrape_id, prompt="Extract the dashboard data")
print(response.output)
app.stop_interaction(scrape_id)
```


``` shiki
import { Firecrawl } from 'firecrawl';

const app = new Firecrawl({
  // No API key needed to get started — add one for higher rate limits:
  // apiKey: 'fc-YOUR-API-KEY',
});

// Session 1: Scrape with a profile, log in, then stop (state is saved)
const result1 = await app.scrape('https://app.example.com/login', {
  formats: ['markdown'],
  profile: { name: 'my-app', saveChanges: true },
});
const scrapeId1 = result1.metadata?.scrapeId;

await app.interact(scrapeId1, { prompt: 'Fill in user@example.com and password, then click Login' });
await app.stopInteraction(scrapeId1);

// Session 2: Scrape with the same profile in read-only mode - already logged in
const result2 = await app.scrape('https://app.example.com/dashboard', {
  formats: ['markdown'],
  profile: { name: 'my-app', saveChanges: false },
});
const scrapeId2 = result2.metadata?.scrapeId;

const response = await app.interact(scrapeId2, { prompt: 'Extract the dashboard data' });
console.log(response.output);
await app.stopInteraction(scrapeId2);
```


``` shiki
# Session 1: Scrape with a profile
# No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
RESPONSE=$(curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://app.example.com/login",
    "formats": ["markdown"],
    "profile": { "name": "my-app", "saveChanges": true }
  }')

SCRAPE_ID=$(echo $RESPONSE | jq -r '.data.metadata.scrapeId')

# Log in via interact
curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
  -H "Content-Type: application/json" \
  -d '{"prompt": "Fill in user@example.com and password, then click Login"}'

# Stop - state is saved to the profile
curl -s -X DELETE "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact"

# Session 2: Scrape again with the same profile in read-only mode - already logged in
RESPONSE=$(curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://app.example.com/dashboard",
    "formats": ["markdown"],
    "profile": { "name": "my-app", "saveChanges": false }
  }')

SCRAPE_ID=$(echo $RESPONSE | jq -r '.data.metadata.scrapeId')

curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
  -H "Content-Type: application/json" \
  -d '{"prompt": "Extract the dashboard data"}'
```


``` shiki
# Session 1: Scrape with a profile, log in, then stop (state is saved)
firecrawl scrape https://app.example.com/login --profile my-app
firecrawl interact "Fill in user@example.com and password, then click Login"
firecrawl interact stop

# Session 2: Scrape with the same profile — already logged in
firecrawl scrape https://app.example.com/dashboard --profile my-app
firecrawl interact "Extract the dashboard data"
firecrawl interact stop

# Read-only: load profile state without saving changes back
firecrawl scrape https://app.example.com/dashboard --profile my-app --no-save-changes
```


| Parameter     | Default | Description                                                                                                                                                                                               |
|---------------|---------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `name`        | None    | A name for the persistent profile. Scrapes with the same name share browser state.                                                                                                                        |
| `saveChanges` | `true`  | When `true`, browser state is saved back to the profile when the interact session stops. Set to `false` to load existing data without writing, which is useful when you need multiple concurrent readers. |


### 


<a href="#validate-persistence" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
# Session 1: write browser state and save it
RESPONSE=$(curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://example.com",
    "formats": ["markdown"],
    "profile": { "name": "profile-validation", "saveChanges": true }
  }')

SCRAPE_ID=$(echo "$RESPONSE" | jq -r ".data.metadata.scrapeId")

curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "code": "await page.evaluate(() => { localStorage.setItem(\"firecrawlProfileCheck\", \"saved\"); document.cookie = \"firecrawl_profile_check=saved; path=/; max-age=3600\"; return localStorage.getItem(\"firecrawlProfileCheck\"); });"
  }'

curl -s -X DELETE "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY"

# Session 2: load the same profile in read-only mode and verify the value
RESPONSE=$(curl -s -X POST "https://api.firecrawl.dev/v2/scrape" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://example.com",
    "formats": ["markdown"],
    "profile": { "name": "profile-validation", "saveChanges": false }
  }')

SCRAPE_ID=$(echo "$RESPONSE" | jq -r ".data.metadata.scrapeId")

curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "code": "await page.evaluate(() => ({ localStorage: localStorage.getItem(\"firecrawlProfileCheck\"), cookie: document.cookie.includes(\"firecrawl_profile_check=saved\") }));"
  }'

curl -s -X DELETE "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY"
```


## 


<a href="#when-to-use-what" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Use Case                         | Recommended                                        | Why                             |
|----------------------------------|----------------------------------------------------|---------------------------------|
| Web search                       | <a href="/features/search" class="link">Search</a> | Dedicated search endpoint       |
| Get clean content from a URL     | <a href="/features/scrape" class="link">Scrape</a> | One API call, no session needed |
| Click, type, navigate on a page  | **Interact** (prompt)                              | Just describe it in English     |
| Extract data behind interactions | **Interact** (prompt)                              | No selectors needed             |
| Complex scraping logic           | **Interact** (code)                                | Full Playwright control         |


## 


<a href="#pricing" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **Code-only** (no `prompt`): 2 credits per session minute
- **With AI prompts**: 7 credits per session minute
- **Scrape**: billed separately (1 credit per scrape, plus any format-specific costs)

## 


<a href="#api-reference" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/api-reference/endpoint/scrape-execute" class="link">Execute Interact</a>: `POST /v2/scrape/{scrapeId}/interact`
- <a href="/api-reference/endpoint/scrape-browser-delete" class="link">Stop Interact</a>: `DELETE /v2/scrape/{scrapeId}/interact`

### 


<a href="#request-body-post" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Field      | Type     | Default  | Description                                                                                          |
|------------|----------|----------|------------------------------------------------------------------------------------------------------|
| `prompt`   | `string` | None     | Natural language task for the AI agent. Required if `code` is not set. Max 10,000 characters.        |
| `code`     | `string` | None     | Code to execute (Node.js, Python, or Bash). Required if `prompt` is not set. Max 100,000 characters. |
| `language` | `string` | `"node"` | `"node"`, `"python"`, or `"bash"`. Only used with `code`.                                            |
| `timeout`  | `number` | `30`     | Timeout in seconds (1–300).                                                                          |
| `origin`   | `string` | None     | Caller identifier for activity tracking.                                                             |


### 


<a href="#response" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Field                    | Description                                                                                                                                           |
|--------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| `success`                | `true` if the execution completed without errors                                                                                                      |
| `cdpUrl`                 | Raw Chrome DevTools Protocol (CDP) WebSocket URL for the browser session. Connect directly with Playwright, Puppeteer, or any CDP client              |
| `liveViewUrl`            | Read-only live view URL for the browser session                                                                                                       |
| `interactiveLiveViewUrl` | Interactive live view URL (viewers can control the browser)                                                                                           |
| `output`                 | The agent’s natural language answer to your prompt. Only present when using `prompt`.                                                                 |
| `stdout`                 | Standard output from the code execution                                                                                                               |
| `result`                 | Raw return value from the sandbox. For `code`: the last expression evaluated. For `prompt`: the raw page snapshot the agent used to produce `output`. |
| `stderr`                 | Standard error output                                                                                                                                 |
| `exitCode`               | Exit code (`0` = success)                                                                                                                             |
| `killed`                 | `true` if the execution was terminated due to timeout                                                                                                 |


------------------------------------------------------------------------


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/features/interact.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/features/interact" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


