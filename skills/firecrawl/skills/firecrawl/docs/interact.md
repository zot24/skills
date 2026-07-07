> Source: https://docs.firecrawl.dev/features/interact.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Interact after scraping

> Interact with a page you fetched by prompting or running code.

Scrape a page to get clean data, then call `/interact` to start taking actions in that page: click buttons, fill forms, extract dynamic content, or navigate deeper. Just describe what you want, or write code if you need full control.


    Describe what action you want to take in the page


    Interact via code execution securely with playwright, agent-browser


    Watch or interact with the browser in real time via embeddable stream


## How It Works

1. **Scrape** a URL with `POST /v2/scrape`. The response includes a `scrapeId` in `data.metadata.scrapeId`. If you want persistent browser state, pass `profile` on this request.
2. **Interact** by calling `POST /v2/scrape/{scrapeId}/interact` with a `prompt` or with playwright `code`. Do not pass `profile` here; the interact session inherits the profile from the scrape job.
3. **Stop** the session with `DELETE /v2/scrape/{scrapeId}/interact` when you're done. For writable profiles, changes are saved when the session stops.

## Quick Start

Scrape a page, interact with it, and stop the session:

<CodeGroup>
  ```python Python
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

  ```js Node
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

  ```bash cURL
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

  ```bash CLI
  # 1. Scrape Amazon's homepage (scrape ID is saved automatically)
  firecrawl scrape https://www.amazon.com

  # 2. Interact — search for a product and get its price
  firecrawl interact "Search for iPhone 16 Pro Max"
  firecrawl interact "Click on the first result and tell me the price"

  # 3. Stop the session
  firecrawl interact stop
  ```
</CodeGroup>

```json Response theme={null}
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

## Interact via prompting

The simplest way to interact with a page. Describe what you want in natural language and it will click, type, scroll, and extract data automatically.

<CodeGroup>
  ```python Python
  response = app.interact(scrape_id, prompt="What are the customer reviews saying about battery life?")
  print(response.output)
  ```

  ```js Node
  const response = await app.interact(scrapeId, {
    prompt: 'What are the customer reviews saying about battery life?',
  });
  console.log(response.output);
  ```

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
    -H "Content-Type: application/json" \
    -d '{
      "prompt": "What are the customer reviews saying about battery life?"
    }'
  ```

  ```bash CLI
  firecrawl interact "What are the customer reviews saying about battery life?"
  ```
</CodeGroup>

The response includes an `output` field with the agent's answer:

```json Response theme={null}
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

### Keep Prompts Small and Focused

Prompts work best when each one is a **single, clear task**. Instead of asking the agent to do a complex multi-step workflow in one shot, break it into separate interact calls. Each call reuses the same browser session, so state carries over between them.

## Running Code

For full control, you can execute code directly in the browser sandbox. The `page` variable (a Playwright Page object) is available in Node.js and Python. Bash mode has [agent-browser](https://github.com/vercel-labs/agent-browser) pre-installed. You can also take screenshots within the session: use `(await page.screenshot()).toString("base64")` in Node.js, `await page.screenshot(path="/tmp/screenshot.png")` in Python, or `agent-browser screenshot` in Bash.

### Node.js (Playwright)

The default language. Write Playwright code directly. `page` is already connected to the browser.

<CodeGroup>
  ```python Python
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

  ```js Node
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

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
    -H "Content-Type: application/json" \
    -d '{
      "code": "await page.click(\"#next-page\"); await page.waitForLoadState(\"networkidle\"); const title = await page.title(); JSON.stringify({ title });",
      "language": "node",
      "timeout": 30
    }'
  ```

  ```bash CLI
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
</CodeGroup>

### Python

Set `language` to `"python"` for Playwright's Python API.

<CodeGroup>
  ```python Python
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

  ```js Node
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

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s -X POST "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact" \
    -H "Content-Type: application/json" \
    -d '{
      "code": "import json\nawait page.click(\"#load-more\")\nawait page.wait_for_load_state(\"networkidle\")\nitems = await page.query_selector_all(\".item\")\ndata = [await i.text_content() for i in items]\nprint(json.dumps(data))",
      "language": "python"
    }'
  ```

  ```bash CLI
  firecrawl interact --python -c "
  import json
  await page.click('#load-more')
  await page.wait_for_load_state('networkidle')
  items = await page.query_selector_all('.item')
  data = [await i.text_content() for i in items]
  print(json.dumps(data))
  "
  ```
</CodeGroup>

### Bash (agent-browser)

[agent-browser](https://github.com/vercel-labs/agent-browser) is a CLI pre-installed in the sandbox with 60+ commands. It provides an accessibility tree with element refs (`@e1`, `@e2`, ...), which is ideal for LLM-driven automation.

<CodeGroup>
  ```python Python
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

  ```js Node
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

  ```bash cURL
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

  ```bash CLI
  # Take a snapshot to see interactive elements
  firecrawl interact --bash -c "agent-browser snapshot -i"

  # Interact with elements using @refs
  firecrawl interact --bash -c 'agent-browser fill @e1 "firecrawl" && agent-browser click @e2'
  ```
</CodeGroup>

Common agent-browser commands:

| Command                   | Description                               |
| ------------------------- | ----------------------------------------- |
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

## Live View

Every interact response returns a `liveViewUrl` that you can embed to watch the browser in real time. Useful for debugging, demos, or building browser-powered UIs.

```json Response theme={null}
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

```html theme={null}
<iframe src="LIVE_VIEW_URL" width="100%" height="600" />
```

### Interactive Live View

The response also includes an `interactiveLiveViewUrl`. Unlike the standard live view which is view-only, the interactive live view allows users to click, type, and interact with the browser session directly through the embedded stream. This is useful for building user-facing browser UIs, such as login flows or guided workflows where end users need to control the browser.

```html theme={null}
<iframe src="INTERACTIVE_LIVE_VIEW_URL" width="100%" height="600" />
```

### CDP URL

Every interact response also returns a `cdpUrl`: the raw Chrome DevTools Protocol (CDP) WebSocket URL for the browser session. Use it to connect to the live session directly from Playwright, Puppeteer, or any CDP client and drive the browser with your own code.

```js theme={null}
import { chromium } from "playwright";

const browser = await chromium.connectOverCDP(cdpUrl);
const context = browser.contexts()[0];
const page = context.pages()[0];
```

## Session Lifecycle

### Creation

The first `POST /v2/scrape/{scrapeId}/interact` continues the scrape session and starts the interaction.

### Reuse

Subsequent interact calls on the same `scrapeId` reuse the existing session. The browser stays open and maintains its state between calls, so you can chain multiple interactions:

<CodeGroup>
  ```python Python
  # First call: click a tab
  app.interact(scrape_id, code="await page.click('#tab-2')")

  # Second call: the tab is still selected, extract its content
  result = app.interact(scrape_id, code="await page.$eval('#tab-2-content', el => el.textContent)")
  print(result.result)
  ```

  ```js Node
  // First call: click a tab
  await app.interact(scrapeId, { code: "await page.click('#tab-2')" });

  // Second call: the tab is still selected, extract its content
  const result = await app.interact(scrapeId, {
    code: "await page.$eval('#tab-2-content', el => el.textContent)",
  });
  console.log(result.result);
  ```

  ```bash CLI
  # First call: click a tab
  firecrawl interact -c "await page.click('#tab-2')"

  # Second call: the tab is still selected, extract its content
  firecrawl interact -c "await page.\$eval('#tab-2-content', el => el.textContent)"
  ```
</CodeGroup>

### Cleanup

Stop the session explicitly when done:

<CodeGroup>
  ```python Python
  app.stop_interaction(scrape_id)
  ```

  ```js Node
  await app.stopInteraction(scrapeId);
  ```

  ```bash cURL
  # No API key needed to get started — add -H "Authorization: Bearer $FIRECRAWL_API_KEY" for higher rate limits:
  curl -s -X DELETE "https://api.firecrawl.dev/v2/scrape/$SCRAPE_ID/interact"
  ```

  ```bash CLI
  # Stops the last scrape session
  firecrawl interact stop

  # Or stop a specific session by ID
  # firecrawl interact stop <scrape-id>
  ```
</CodeGroup>

Sessions also expire automatically based on TTL (default: 10 minutes) or inactivity timeout (default: 5 minutes).


  Always stop sessions when you're done to avoid unnecessary billing. Credits are prorated by the second.


## Persistent Profiles with Scrape + Interact

By default, each scrape + interact session starts with a clean browser. With `profile`, you can save and reuse browser state (cookies, localStorage, sessions) across scrapes. This is useful for staying logged in and preserving preferences.

Pass the `profile` object to the initial `POST /v2/scrape` request. Do not pass `profile` to `POST /v2/scrape/{scrapeId}/interact`; the interact session reuses the scrape job's browser session and profile settings. Stop the interact session with `DELETE /v2/scrape/{scrapeId}/interact` so writable profile changes can be saved.

```bash cURL theme={null}
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

The profile lifecycle is:

1. Create the scrape with `profile.name` and `saveChanges: true`.
2. Run prompt or code interactions against the returned `scrapeId`.
3. Stop the session to save cookies, localStorage, and other browser state.
4. Start a later scrape with the same `profile.name`. Use `saveChanges: false` when you only want to read existing state without writing changes back.

<CodeGroup>
  ```python Python
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

  ```js Node
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

  ```bash cURL
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

  ```bash CLI
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
</CodeGroup>

| Parameter     | Default | Description                                                                                                                                                                                               |
| ------------- | ------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`        | None    | A name for the persistent profile. Scrapes with the same name share browser state.                                                                                                                        |
| `saveChanges` | `true`  | When `true`, browser state is saved back to the profile when the interact session stops. Set to `false` to load existing data without writing, which is useful when you need multiple concurrent readers. |


  Only one session can save to a profile at a time. If another session is already saving, you'll get a `409` error. You can still open the same profile with `saveChanges: false`, or try again later.


The browser state is saved when the interact session is stopped. Always stop the session when you're done so the profile can be reused.

### Validate Persistence

You can test persistence without relying on a real login flow by writing a localStorage value in one session, stopping it, then reading the value in a second session with the same profile.

```bash cURL theme={null}
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

The second interact response should show `localStorage` as `"saved"` and `cookie` as `true`.


  Profiles created through the API may not appear in Dashboard > Interact > Profiles yet. The dashboard currently does not provide a complete inventory of API-created persistent profiles.


## When to Use What

| Use Case                         | Recommended                | Why                             |
| -------------------------------- | -------------------------- | ------------------------------- |
| Web search                       | [Search](/features/search) | Dedicated search endpoint       |
| Get clean content from a URL     | [Scrape](/features/scrape) | One API call, no session needed |
| Click, type, navigate on a page  | **Interact** (prompt)      | Just describe it in English     |
| Extract data behind interactions | **Interact** (prompt)      | No selectors needed             |
| Complex scraping logic           | **Interact** (code)        | Full Playwright control         |


  **Interact vs Browser Sandbox**: Interact is built on the same infrastructure as [Browser Sandbox](/features/browser) but provides a better interface for the most common pattern: scrape a page, then go deeper. Browser Sandbox is better when you need a standalone browser session that isn't tied to a specific scrape.


## Pricing

* **Code-only** (no `prompt`): 2 credits per session minute
* **With AI prompts**: 7 credits per session minute
* **Scrape**: billed separately (1 credit per scrape, plus any format-specific costs)

## API Reference

* [Execute Interact](/api-reference/endpoint/scrape-execute): `POST /v2/scrape/{scrapeId}/interact`
* [Stop Interact](/api-reference/endpoint/scrape-browser-delete): `DELETE /v2/scrape/{scrapeId}/interact`

### Request Body (POST)

| Field      | Type     | Default  | Description                                                                                          |
| ---------- | -------- | -------- | ---------------------------------------------------------------------------------------------------- |
| `prompt`   | `string` | None     | Natural language task for the AI agent. Required if `code` is not set. Max 10,000 characters.        |
| `code`     | `string` | None     | Code to execute (Node.js, Python, or Bash). Required if `prompt` is not set. Max 100,000 characters. |
| `language` | `string` | `"node"` | `"node"`, `"python"`, or `"bash"`. Only used with `code`.                                            |
| `timeout`  | `number` | `30`     | Timeout in seconds (1–300).                                                                          |
| `origin`   | `string` | None     | Caller identifier for activity tracking.                                                             |

### Response

| Field                    | Description                                                                                                                                           |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| `success`                | `true` if the execution completed without errors                                                                                                      |
| `cdpUrl`                 | Raw Chrome DevTools Protocol (CDP) WebSocket URL for the browser session. Connect directly with Playwright, Puppeteer, or any CDP client              |
| `liveViewUrl`            | Read-only live view URL for the browser session                                                                                                       |
| `interactiveLiveViewUrl` | Interactive live view URL (viewers can control the browser)                                                                                           |
| `output`                 | The agent's natural language answer to your prompt. Only present when using `prompt`.                                                                 |
| `stdout`                 | Standard output from the code execution                                                                                                               |
| `result`                 | Raw return value from the sandbox. For `code`: the last expression evaluated. For `prompt`: the raw page snapshot the agent used to produce `output`. |
| `stderr`                 | Standard error output                                                                                                                                 |
| `exitCode`               | Exit code (`0` = success)                                                                                                                             |
| `killed`                 | `true` if the execution was terminated due to timeout                                                                                                 |

***

Have feedback or need help? Email [help@firecrawl.com](mailto:help@firecrawl.com) or reach out on [Discord](https://discord.gg/firecrawl).
