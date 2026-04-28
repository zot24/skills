> Source: https://docs.firecrawl.dev/sdks/cli.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Skill + CLI

> Firecrawl Skill is an easy way for AI agents such as Claude Code, Antigravity and  OpenCode to use Firecrawl through the CLI.

Search, scrape, and interact with the web directly from the terminal. The Firecrawl CLI works standalone or as a skill that AI coding agents like Claude Code, Antigravity, and OpenCode can discover and use automatically.

## Installation

If you are using an AI agent like Claude Code, you can install the Firecrawl skill below and the agent will set it up for you.

```bash
npx -y firecrawl-cli@latest init --all --browser
```

* `--all` installs the Firecrawl skill to every detected AI coding agent
* `--browser` opens the browser for Firecrawl authentication automatically


  After installing the skill, restart your agent for it to discover the new skill.


You can also manually install the Firecrawl CLI globally using npm:

```bash CLI
# Install globally with npm
npm install -g firecrawl-cli
```

## Authentication

Before using the CLI, you need to authenticate with your Firecrawl API key.

### Login

```bash CLI
# Interactive login (opens browser or prompts for API key)
firecrawl login

# Login with browser authentication (recommended for agents)
firecrawl login --browser

# Login with API key directly
firecrawl login --api-key fc-YOUR-API-KEY

# Or set via environment variable
export FIRECRAWL_API_KEY=fc-YOUR-API-KEY
```

### View Configuration

```bash CLI
# View current configuration and authentication status
firecrawl view-config
```

### Logout

```bash CLI
# Clear stored credentials
firecrawl logout
```

### Self-Hosted / Local Development

For self-hosted Firecrawl instances or local development, use the `--api-url` option:

```bash CLI
# Use a local Firecrawl instance (no API key required)
firecrawl --api-url http://localhost:3002 scrape https://example.com

# Or set via environment variable
export FIRECRAWL_API_URL=http://localhost:3002
firecrawl scrape https://example.com

# Configure and persist the custom API URL
firecrawl config --api-url http://localhost:3002
```

When using a custom API URL (anything other than `https://api.firecrawl.dev`), API key authentication is automatically skipped, allowing you to use local instances without an API key.

### Check Status

Verify installation, authentication, and view rate limits:

```bash CLI
firecrawl --status
```

Output when ready:

```
  🔥 firecrawl cli v1.1.1

  ● Authenticated via FIRECRAWL_API_KEY
  Concurrency: 0/100 jobs (parallel scrape limit)
  Credits: 500,000 remaining
```

* **Concurrency**: Maximum parallel jobs. Run parallel operations close to this limit but not above.
* **Credits**: Remaining API credits. Each scrape/crawl consumes credits.

## Commands

### Scrape

Scrape a single URL and extract its content in various formats.


  Use `--only-main-content` to get clean output without navigation, footers, and ads. This is recommended for most use cases where you want just the article or main page content.


```bash CLI
# Scrape a URL (default: markdown output)
firecrawl https://example.com

# Or use the explicit scrape command
firecrawl scrape https://example.com

# Recommended: use --only-main-content for clean output without nav/footer
firecrawl https://example.com --only-main-content
```

#### Output Formats

```bash CLI
# Get HTML output
firecrawl https://example.com --html

# Multiple formats (returns JSON)
firecrawl https://example.com --format markdown,links

# Get images from a page
firecrawl https://example.com --format images

# Get a summary of the page content
firecrawl https://example.com --format summary

# Track changes on a page
firecrawl https://example.com --format changeTracking

# Available formats: markdown, html, rawHtml, links, screenshot, json, images, summary, changeTracking, attributes, branding
```

#### Scrape Options

```bash CLI
# Extract only main content (removes navs, footers)
firecrawl https://example.com --only-main-content

# Wait for JavaScript rendering
firecrawl https://example.com --wait-for 3000

# Take a screenshot
firecrawl https://example.com --screenshot

# Include/exclude specific HTML tags
firecrawl https://example.com --include-tags article,main
firecrawl https://example.com --exclude-tags nav,footer

# Save output to file
firecrawl https://example.com -o output.md

# Pretty print JSON output
firecrawl https://example.com --format markdown,links --pretty

# Force JSON output even with single format
firecrawl https://example.com --json

# Show request timing information
firecrawl https://example.com --timing
```

**Available Options:**

| Option                  | Short | Description                                                                                                                                                     |
| ----------------------- | ----- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--url <url>`           | `-u`  | URL to scrape (alternative to positional argument)                                                                                                              |
| `--format <formats>`    | `-f`  | Output formats (comma-separated): `markdown`, `html`, `rawHtml`, `links`, `screenshot`, `json`, `images`, `summary`, `changeTracking`, `attributes`, `branding` |
| `--html`                | `-H`  | Shortcut for `--format html`                                                                                                                                    |
| `--only-main-content`   |       | Extract only main content                                                                                                                                       |
| `--wait-for <ms>`       |       | Wait time in milliseconds for JS rendering                                                                                                                      |
| `--screenshot`          |       | Take a screenshot                                                                                                                                               |
| `--include-tags <tags>` |       | HTML tags to include (comma-separated)                                                                                                                          |
| `--exclude-tags <tags>` |       | HTML tags to exclude (comma-separated)                                                                                                                          |
| `--output <path>`       | `-o`  | Save output to file                                                                                                                                             |
| `--json`                |       | Force JSON output even with single format                                                                                                                       |
| `--pretty`              |       | Pretty print JSON output                                                                                                                                        |
| `--timing`              |       | Show request timing and other useful information                                                                                                                |

***

### Search

Search the web and optionally scrape the results.

```bash CLI
# Search the web
firecrawl search "web scraping tutorials"

# Limit results
firecrawl search "AI news" --limit 10

# Pretty print results
firecrawl search "machine learning" --pretty
```

#### Search Options

```bash CLI
# Search specific sources
firecrawl search "AI" --sources web,news,images

# Search with category filters
firecrawl search "react hooks" --categories github
firecrawl search "machine learning" --categories research,pdf

# Time-based filtering
firecrawl search "tech news" --tbs qdr:h   # Last hour
firecrawl search "tech news" --tbs qdr:d   # Last day
firecrawl search "tech news" --tbs qdr:w   # Last week
firecrawl search "tech news" --tbs qdr:m   # Last month
firecrawl search "tech news" --tbs qdr:y   # Last year

# Location-based search
firecrawl search "restaurants" --location "Berlin,Germany" --country DE

# Search and scrape results
firecrawl search "documentation" --scrape --scrape-formats markdown

# Save to file
firecrawl search "firecrawl" --pretty -o results.json
```

**Available Options:**

| Option                       | Description                                                                                 |
| ---------------------------- | ------------------------------------------------------------------------------------------- |
| `--limit <number>`           | Maximum results (default: 5, max: 100)                                                      |
| `--sources <sources>`        | Sources to search: `web`, `images`, `news` (comma-separated)                                |
| `--categories <categories>`  | Filter by category: `github`, `research`, `pdf` (comma-separated)                           |
| `--tbs <value>`              | Time filter: `qdr:h` (hour), `qdr:d` (day), `qdr:w` (week), `qdr:m` (month), `qdr:y` (year) |
| `--location <location>`      | Geo-targeting (e.g., "Berlin,Germany")                                                      |
| `--country <code>`           | ISO country code (default: US)                                                              |
| `--timeout <ms>`             | Timeout in milliseconds (default: 60000)                                                    |
| `--ignore-invalid-urls`      | Exclude URLs invalid for other Firecrawl endpoints                                          |
| `--scrape`                   | Scrape search results                                                                       |
| `--scrape-formats <formats>` | Formats for scraped content (default: markdown)                                             |
| `--only-main-content`        | Include only main content when scraping (default: true)                                     |
| `--json`                     | Output as JSON                                                                              |
| `--output <path>`            | Save output to file                                                                         |
| `--pretty`                   | Pretty print JSON output                                                                    |

***

### Map

Discover all URLs on a website quickly.

```bash CLI
# Discover all URLs on a website
firecrawl map https://example.com

# Output as JSON
firecrawl map https://example.com --json

# Limit number of URLs
firecrawl map https://example.com --limit 500
```

#### Map Options

```bash CLI
# Filter URLs by search query
firecrawl map https://example.com --search "blog"

# Include subdomains
firecrawl map https://example.com --include-subdomains

# Control sitemap usage
firecrawl map https://example.com --sitemap include   # Use sitemap
firecrawl map https://example.com --sitemap skip      # Skip sitemap
firecrawl map https://example.com --sitemap only      # Only use sitemap

# Ignore query parameters (dedupe URLs)
firecrawl map https://example.com --ignore-query-parameters

# Wait for map to complete with timeout
firecrawl map https://example.com --wait --timeout 60

# Save to file
firecrawl map https://example.com -o urls.txt
firecrawl map https://example.com --json --pretty -o urls.json
```

**Available Options:**

| Option                      | Description                                     |
| --------------------------- | ----------------------------------------------- |
| `--url <url>`               | URL to map (alternative to positional argument) |
| `--limit <number>`          | Maximum URLs to discover                        |
| `--search <query>`          | Filter URLs by search query                     |
| `--sitemap <mode>`          | Sitemap handling: `include`, `skip`, `only`     |
| `--include-subdomains`      | Include subdomains                              |
| `--ignore-query-parameters` | Treat URLs with different params as same        |
| `--wait`                    | Wait for map to complete                        |
| `--timeout <seconds>`       | Timeout in seconds                              |
| `--json`                    | Output as JSON                                  |
| `--output <path>`           | Save output to file                             |
| `--pretty`                  | Pretty print JSON output                        |

***

### Browser

Have your agents interact with the web using a secure browser sandbox.

Launch cloud browser sessions and execute Python, JavaScript, or bash code remotely. Each session runs a full Chromium instance — no local browser install required. Code runs server-side with a pre-configured [Playwright](https://playwright.dev/) `page` object ready to use.

```bash CLI
# Launch a cloud browser session
firecrawl browser launch-session

# Execute agent-browser commands (default - "agent-browser" is auto-prefixed)
firecrawl browser execute "open https://example.com"
firecrawl browser execute "snapshot"
firecrawl browser execute "click @e5"
firecrawl browser execute "scrape"

# Execute Playwright Python code
firecrawl browser execute --python 'await page.goto("https://example.com")
print(await page.title())'

# Execute Playwright JavaScript code
firecrawl browser execute --node 'await page.goto("https://example.com"); console.log(await page.title());'

# List all sessions (or: list active / list destroyed)
firecrawl browser list

# Close the active session
firecrawl browser close
```

#### Browser Options

```bash CLI
# Launch with custom TTL (10 minutes) and live view
firecrawl browser launch-session --ttl 600 --stream

# Launch with inactivity timeout
firecrawl browser launch-session --ttl 120 --ttl-inactivity 60

# agent-browser commands (default - "agent-browser" is auto-prefixed)
firecrawl browser execute "open https://news.ycombinator.com"
firecrawl browser execute "snapshot"
firecrawl browser execute "click @e3"
firecrawl browser execute "scrape"

# Playwright Python - navigate, interact, extract
firecrawl browser execute --python '
await page.goto("https://news.ycombinator.com")
items = await page.query_selector_all(".titleline > a")
for item in items[:5]:
    print(await item.text_content())
'

# Playwright JavaScript - same page object
firecrawl browser execute --node '
await page.goto("https://example.com");
const title = await page.title();
console.log(title);
'

# Explicit bash mode - runs in the sandbox
firecrawl browser execute --bash "agent-browser snapshot"

# Target a specific session
firecrawl browser execute --session <id> --python 'print(await page.title())'

# Save output to file
firecrawl browser execute "scrape" -o result.txt

# Close a specific session
firecrawl browser close --session <id>

# List sessions (all / active / destroyed)
firecrawl browser list
firecrawl browser list active --json
```

**Subcommands:**

| Subcommand       | Description                                                                         |
| ---------------- | ----------------------------------------------------------------------------------- |
| `launch-session` | Launch a new cloud browser session (returns session ID, CDP URL, and live view URL) |
| `execute <code>` | Execute Playwright Python/JS code or bash commands in a session                     |
| `list [status]`  | List browser sessions (filter by `active` or `destroyed`)                           |
| `close`          | Close a browser session                                                             |

**Execute Options:**

| Option           | Description                                                                                                                                                                                                                                                                                |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `--bash`         | Execute bash commands remotely in the sandbox (default). [agent-browser](https://github.com/vercel-labs/agent-browser) (40+ commands) is pre-installed and auto-prefixed. `CDP_URL` is auto-injected so agent-browser connects to your session automatically. Best approach for AI agents. |
| `--python`       | Execute as Playwright Python code. A Playwright `page` object is available — use `await page.goto()`, `await page.title()`, etc.                                                                                                                                                           |
| `--node`         | Execute as Playwright JavaScript code. Same `page` object available.                                                                                                                                                                                                                       |
| `--session <id>` | Target a specific session (default: active session)                                                                                                                                                                                                                                        |

**Launch Options:**

| Option                       | Description                                                         |
| ---------------------------- | ------------------------------------------------------------------- |
| `--ttl <seconds>`            | Total session TTL (default: 600, range: 30–3600)                    |
| `--ttl-inactivity <seconds>` | Auto-close after inactivity (range: 10–3600)                        |
| `--profile <name>`           | Name for a profile (saves and reuses browser state across sessions) |
| `--no-save-changes`          | Load existing profile data without saving changes back              |
| `--stream`                   | Enable live view streaming                                          |

**Common Options:**

| Option            | Description           |
| ----------------- | --------------------- |
| `--output <path>` | Save output to file   |
| `--json`          | Output as JSON format |

***

### Crawl

Crawl an entire website starting from a URL.

```bash CLI
# Start a crawl (returns job ID immediately)
firecrawl crawl https://example.com

# Wait for crawl to complete
firecrawl crawl https://example.com --wait

# Wait with progress indicator
firecrawl crawl https://example.com --wait --progress
```

#### Check Crawl Status

```bash CLI
# Check crawl status using job ID
firecrawl crawl <job-id>

# Example with a real job ID
firecrawl crawl 550e8400-e29b-41d4-a716-446655440000
```

#### Crawl Options

```bash CLI
# Limit crawl depth and pages
firecrawl crawl https://example.com --limit 100 --max-depth 3 --wait

# Include only specific paths
firecrawl crawl https://example.com --include-paths /blog,/docs --wait

# Exclude specific paths
firecrawl crawl https://example.com --exclude-paths /admin,/login --wait

# Include subdomains
firecrawl crawl https://example.com --allow-subdomains --wait

# Crawl entire domain
firecrawl crawl https://example.com --crawl-entire-domain --wait

# Rate limiting
firecrawl crawl https://example.com --delay 1000 --max-concurrency 2 --wait

# Custom polling interval and timeout
firecrawl crawl https://example.com --wait --poll-interval 10 --timeout 300

# Save results to file
firecrawl crawl https://example.com --wait --pretty -o results.json
```

**Available Options:**

| Option                      | Description                                       |
| --------------------------- | ------------------------------------------------- |
| `--url <url>`               | URL to crawl (alternative to positional argument) |
| `--wait`                    | Wait for crawl to complete                        |
| `--progress`                | Show progress indicator while waiting             |
| `--poll-interval <seconds>` | Polling interval (default: 5)                     |
| `--timeout <seconds>`       | Timeout when waiting                              |
| `--status`                  | Check status of existing crawl job                |
| `--limit <number>`          | Maximum pages to crawl                            |
| `--max-depth <number>`      | Maximum crawl depth                               |
| `--include-paths <paths>`   | Paths to include (comma-separated)                |
| `--exclude-paths <paths>`   | Paths to exclude (comma-separated)                |
| `--sitemap <mode>`          | Sitemap handling: `include`, `skip`, `only`       |
| `--allow-subdomains`        | Include subdomains                                |
| `--allow-external-links`    | Follow external links                             |
| `--crawl-entire-domain`     | Crawl entire domain                               |
| `--ignore-query-parameters` | Treat URLs with different params as same          |
| `--delay <ms>`              | Delay between requests                            |
| `--max-concurrency <n>`     | Maximum concurrent requests                       |
| `--output <path>`           | Save output to file                               |
| `--pretty`                  | Pretty print JSON output                          |

***

### Agent

Search and gather data from the web using natural language prompts.

```bash CLI
# Basic usage - URLs are optional
firecrawl agent "Find the top 5 AI startups and their funding amounts" --wait

# Focus on specific URLs
firecrawl agent "Compare pricing plans" --urls https://slack.com/pricing,https://teams.microsoft.com/pricing --wait

# Use a schema for structured output
firecrawl agent "Get company information" --urls https://example.com --schema '{"name": "string", "founded": "number"}' --wait

# Use schema from a file
firecrawl agent "Get product details" --urls https://example.com --schema-file schema.json --wait
```

#### Agent Options

```bash CLI
# Use Spark 1 Pro for higher accuracy
firecrawl agent "Competitive analysis across multiple domains" --model spark-1-pro --wait

# Set max credits to limit costs
firecrawl agent "Gather contact information from company websites" --max-credits 100 --wait

# Check status of an existing job
firecrawl agent <job-id> --status

# Custom polling interval and timeout
firecrawl agent "Summarize recent blog posts" --wait --poll-interval 10 --timeout 300

# Save output to file
firecrawl agent "Find pricing information" --urls https://example.com --wait -o pricing.json --pretty
```

**Available Options:**

| Option                      | Description                                                                            |
| --------------------------- | -------------------------------------------------------------------------------------- |
| `--urls <urls>`             | Optional list of URLs to focus the agent on (comma-separated)                          |
| `--model <model>`           | Model to use: `spark-1-mini` (default, 60% cheaper) or `spark-1-pro` (higher accuracy) |
| `--schema <json>`           | JSON schema for structured output (inline JSON string)                                 |
| `--schema-file <path>`      | Path to JSON schema file for structured output                                         |
| `--max-credits <number>`    | Maximum credits to spend (job fails if limit reached)                                  |
| `--status`                  | Check status of existing agent job                                                     |
| `--wait`                    | Wait for agent to complete before returning results                                    |
| `--poll-interval <seconds>` | Polling interval when waiting (default: 5)                                             |
| `--timeout <seconds>`       | Timeout when waiting (default: no timeout)                                             |
| `--output <path>`           | Save output to file                                                                    |
| `--json`                    | Output as JSON format                                                                  |

***

### Credit Usage

Check your team's credit balance and usage.

```bash CLI
# View credit usage
firecrawl credit-usage

# Output as JSON
firecrawl credit-usage --json --pretty
```

***

### Version

Display the CLI version.

```bash CLI
firecrawl version
# or
firecrawl --version
```

## Global Options

These options are available for all commands:

| Option            | Short | Description                                            |
| ----------------- | ----- | ------------------------------------------------------ |
| `--status`        |       | Show version, auth, concurrency, and credits           |
| `--api-key <key>` | `-k`  | Override stored API key for this command               |
| `--api-url <url>` |       | Use custom API URL (for self-hosted/local development) |
| `--help`          | `-h`  | Show help for a command                                |
| `--version`       | `-V`  | Show CLI version                                       |

## Output Handling

The CLI outputs to stdout by default, making it easy to pipe or redirect:

```bash CLI
# Pipe markdown to another command
firecrawl https://example.com | head -50

# Redirect to a file
firecrawl https://example.com > output.md

# Save JSON with pretty formatting
firecrawl https://example.com --format markdown,links --pretty -o data.json
```

### Format Behavior

* **Single format**: Outputs raw content (markdown text, HTML, etc.)
* **Multiple formats**: Outputs JSON with all requested data

```bash CLI
# Raw markdown output
firecrawl https://example.com --format markdown

# JSON output with multiple formats
firecrawl https://example.com --format markdown,links
```

## Examples

### Quick Scrape

```bash CLI
# Get markdown content from a URL (use --only-main-content for clean output)
firecrawl https://docs.firecrawl.dev --only-main-content

# Get HTML content
firecrawl https://example.com --html -o page.html
```

### Full Site Crawl

```bash CLI
# Crawl a docs site with limits
firecrawl crawl https://docs.example.com --limit 50 --max-depth 2 --wait --progress -o docs.json
```

### Site Discovery

```bash CLI
# Find all blog posts
firecrawl map https://example.com --search "blog" -o blog-urls.txt
```

### Research Workflow

```bash CLI
# Search and scrape results for research
firecrawl search "machine learning best practices 2024" --scrape --scrape-formats markdown --pretty
```

### Agent

```bash CLI
# URLs are optional
firecrawl agent "Find the top 5 AI startups and their funding amounts" --wait

# Focus on specific URLs
firecrawl agent "Compare pricing plans" --urls https://slack.com/pricing,https://teams.microsoft.com/pricing --wait
```

### Browser Automation

```bash CLI
# Launch a session, scrape a page, and close
firecrawl browser launch-session
firecrawl browser execute "open https://news.ycombinator.com"
firecrawl browser execute "snapshot"
firecrawl browser execute "scrape"
firecrawl browser close

# Use agent-browser via bash mode (default — recommended for AI agents)
firecrawl browser launch-session
firecrawl browser execute "open https://example.com"
firecrawl browser execute "snapshot"
# snapshot returns @ref IDs — use them to interact
firecrawl browser execute "click @e5"
firecrawl browser execute "fill @e3 'search query'"
firecrawl browser execute "scrape"
# Run --help to see all 40+ commands
firecrawl browser execute --bash "agent-browser --help"
firecrawl browser close
```

### Combine with Other Tools

```bash CLI
# Extract URLs from search results
jq -r '.data.web[].url' search-results.json

# Get titles from search results
jq -r '.data.web[] | "\(.title): \(.url)"' search-results.json

# Extract links and process with jq
firecrawl https://example.com --format links | jq '.links[].url'

# Count URLs from map
firecrawl map https://example.com | wc -l
```

## Telemetry

The CLI collects anonymous usage data during authentication to help improve the product:

* CLI version, OS, and Node.js version
* Development tool detection (e.g., Cursor, VS Code, Claude Code)

**No command data, URLs, or file contents are collected via the CLI.**

To disable telemetry, set the environment variable:

```bash CLI
export FIRECRAWL_NO_TELEMETRY=1
```

## Open Source

The Firecrawl CLI and Skill are open source and available on GitHub: [firecrawl/cli](https://github.com/firecrawl/cli)

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.
