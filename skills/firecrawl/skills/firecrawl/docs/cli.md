> Source: https://docs.firecrawl.dev/sdks/cli.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Skills + CLI

> Firecrawl skills are an easy way for AI agents such as Claude Code, Antigravity and OpenCode to use Firecrawl through the CLI.

Search, scrape, interact, crawl, map, and run agent jobs directly from the terminal. The Firecrawl CLI works standalone or with skills that AI coding agents like Claude Code, Antigravity, and OpenCode can discover and use automatically.

## Installation

If you are using an AI agent like Claude Code, you can install the Firecrawl skills below and the agent will set them up for you.

```bash theme={null}
npx -y firecrawl-cli@latest init --all --browser
```

* `--all` installs every Firecrawl skill segment (CLI, build, workflows) to every detected AI coding agent
* `--browser` opens the browser for Firecrawl authentication automatically


  After installing the skills, restart your agent for it to discover them.


You can also manually install the Firecrawl CLI globally using npm:

```bash CLI theme={null}
# Install globally with npm
npm install -g firecrawl-cli
```

## Authentication

Before using the CLI, you need to authenticate with your Firecrawl API key.


  **Some CLI commands work without logging in.** With no API key configured, supported commands fall back to the keyless free tier — free, but rate-limited per IP. See [Rate Limits](/rate-limits#keyless-no-api-key) for the current keyless command list and caveats. [Sign up for a free key](https://firecrawl.dev) for 1,000 credits and higher limits; the CLI uses it automatically once configured.


### Login

```bash CLI theme={null}
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

```bash CLI theme={null}
# View current configuration and authentication status
firecrawl view-config
```

### Logout

```bash CLI theme={null}
# Clear stored credentials
firecrawl logout
```

### Self-Hosted / Local Development

For self-hosted Firecrawl instances or local development, use the `--api-url` option:

```bash CLI theme={null}
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

```bash CLI theme={null}
firecrawl --status
```

Output when ready:

```
  🔥 firecrawl cli v1.16.2

  ● Authenticated via FIRECRAWL_API_KEY
  Concurrency: 0/100 jobs (parallel scrape limit)
  Credits: 500,000 remaining
```

* **Concurrency**: Maximum parallel jobs. Run parallel operations close to this limit but not above.
* **Credits**: Remaining API credits. Each scrape/crawl consumes credits.

## Commands


  The hidden `firecrawl browser` command is deprecated for agent workflows. Use `firecrawl scrape <url>` first, then `firecrawl interact ...` with the resulting scrape session.


### Scrape

Scrape a single URL and extract its content in various formats.


  Use `--only-main-content` to get clean output without navigation, footers, and
  ads. This is recommended for most use cases where you want just the article or
  main page content.


```bash CLI theme={null}
# Scrape a URL (default: markdown output)
firecrawl https://example.com

# Or use the explicit scrape command
firecrawl scrape https://example.com

# Recommended: use --only-main-content for clean output without nav/footer
firecrawl https://example.com --only-main-content
```

#### Output Formats

```bash CLI theme={null}
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

# Available formats: markdown, html, rawHtml, links, screenshot, json, images, summary, changeTracking, attributes, branding, product
```

#### Scrape Options

```bash CLI theme={null}
# Extract only main content (removes navs, footers)
firecrawl https://example.com --only-main-content

# Wait for JavaScript rendering
firecrawl https://example.com --wait-for 3000

# Take a screenshot
firecrawl https://example.com --screenshot

# Extract structured JSON with a schema
firecrawl https://example.com --format json --schema '{"type":"object","properties":{"title":{"type":"string"}}}'

# Run lightweight scrape actions before extraction
firecrawl https://example.com --actions '[{"type":"wait","milliseconds":1000}]'

# Select proxy mode
firecrawl https://example.com --proxy basic

# Redact personally identifiable information
firecrawl https://example.com --redact-pii

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

| Option                   | Short | Description                                                                                                                                                     |
| ------------------------ | ----- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--url <url>`            | `-u`  | URL to scrape (alternative to positional argument)                                                                                                              |
| `--format <formats>`     | `-f`  | Output formats (comma-separated): `markdown`, `html`, `rawHtml`, `links`, `screenshot`, `json`, `images`, `summary`, `changeTracking`, `attributes`, `branding` |
| `--html`                 | `-H`  | Shortcut for `--format html`                                                                                                                                    |
| `--only-main-content`    |       | Extract only main content                                                                                                                                       |
| `--wait-for <ms>`        |       | Wait time in milliseconds for JS rendering                                                                                                                      |
| `--screenshot`           |       | Take a screenshot                                                                                                                                               |
| `--full-page-screenshot` |       | Take a full page screenshot                                                                                                                                     |
| `--include-tags <tags>`  |       | HTML tags to include (comma-separated)                                                                                                                          |
| `--exclude-tags <tags>`  |       | HTML tags to exclude (comma-separated)                                                                                                                          |
| `--schema <json>`        |       | JSON schema for structured extraction                                                                                                                           |
| `--schema-file <path>`   |       | Path to JSON schema file                                                                                                                                        |
| `--actions <json>`       |       | JSON actions array to run during scrape                                                                                                                         |
| `--actions-file <path>`  |       | Path to JSON actions file                                                                                                                                       |
| `--proxy <proxy>`        |       | Proxy mode for scraping (for example, `auto` or `basic`)                                                                                                        |
| `--redact-pii`           |       | Redact personally identifiable information from returned content                                                                                                |
| `--output <path>`        | `-o`  | Save output to file                                                                                                                                             |
| `--json`                 |       | Force JSON output even with single format                                                                                                                       |
| `--pretty`               |       | Pretty print JSON output                                                                                                                                        |
| `--timing`               |       | Show request timing and other useful information                                                                                                                |

***

### Search

Search the web and optionally scrape the results.

```bash CLI theme={null}
# Search the web
firecrawl search "web scraping tutorials"

# Limit results
firecrawl search "AI news" --limit 10

# Pretty print results
firecrawl search "machine learning" --pretty
```

#### Search Options

```bash CLI theme={null}
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

```bash CLI theme={null}
# Discover all URLs on a website
firecrawl map https://example.com

# Output as JSON
firecrawl map https://example.com --json

# Limit number of URLs
firecrawl map https://example.com --limit 500
```

#### Map Options

```bash CLI theme={null}
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

### Interact

Scrape a page, then interact with it using natural language or code. Interact uses the most recent scrape by default, or you can pass a specific scrape ID.

```bash CLI theme={null}
# 1. Scrape Amazon's homepage (scrape ID is saved automatically)
firecrawl scrape https://www.amazon.com

# 2. Interact — search for a product and get its price
firecrawl interact "Search for iPhone 16 Pro Max"
firecrawl interact "Click on the first result and tell me the price"

# 3. Stop the session
firecrawl interact stop
```

**Available Options:**

| Option                 | Description                                    |
| ---------------------- | ---------------------------------------------- |
| `-p, --prompt <text>`  | AI prompt (alternative to positional argument) |
| `-c, --code <code>`    | Code to execute in the live page session       |
| `-s, --scrape-id <id>` | Scrape job ID (default: last scrape)           |
| `--python`             | Execute code as Python/Playwright              |
| `--node`               | Execute code as Node.js/Playwright (default)   |
| `--bash`               | Execute code as Bash                           |
| `--timeout <seconds>`  | Timeout in seconds (1-300, default: 30)        |
| `--output <path>`      | Save output to file                            |
| `--json`               | Output as JSON format                          |

***

### Crawl

Crawl an entire website starting from a URL.

```bash CLI theme={null}
# Start a crawl (returns job ID immediately)
firecrawl crawl https://example.com

# Wait for crawl to complete
firecrawl crawl https://example.com --wait

# Wait with progress indicator
firecrawl crawl https://example.com --wait --progress
```

#### Check Crawl Status

```bash CLI theme={null}
# Check crawl status using job ID
firecrawl crawl <job-id>

# Example with a real job ID
firecrawl crawl 550e8400-e29b-41d4-a716-446655440000
```

#### Crawl Options

```bash CLI theme={null}
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

# Pass scrape options to each crawled page
firecrawl crawl https://example.com --scrape-options '{"formats":["markdown"],"onlyMainContent":true}'

# Send crawl completion events to a webhook
firecrawl crawl https://example.com --webhook '{"url":"https://example.com/webhook","events":["completed"]}'

# Cancel an active crawl
firecrawl crawl <job-id> --cancel

# Custom polling interval and timeout
firecrawl crawl https://example.com --wait --poll-interval 10 --timeout 300

# Save results to file
firecrawl crawl https://example.com --wait --pretty -o results.json
```

**Available Options:**

| Option                         | Description                                       |
| ------------------------------ | ------------------------------------------------- |
| `--url <url>`                  | URL to crawl (alternative to positional argument) |
| `--wait`                       | Wait for crawl to complete                        |
| `--progress`                   | Show progress indicator while waiting             |
| `--poll-interval <seconds>`    | Polling interval (default: 5)                     |
| `--timeout <seconds>`          | Timeout when waiting                              |
| `--status`                     | Check status of existing crawl job                |
| `--limit <number>`             | Maximum pages to crawl                            |
| `--max-depth <number>`         | Maximum crawl depth                               |
| `--include-paths <paths>`      | Paths to include (comma-separated)                |
| `--exclude-paths <paths>`      | Paths to exclude (comma-separated)                |
| `--sitemap <mode>`             | Sitemap handling: `include`, `skip`, `only`       |
| `--allow-subdomains`           | Include subdomains                                |
| `--allow-external-links`       | Follow external links                             |
| `--crawl-entire-domain`        | Crawl entire domain                               |
| `--ignore-query-parameters`    | Treat URLs with different params as same          |
| `--delay <ms>`                 | Delay between requests                            |
| `--max-concurrency <n>`        | Maximum concurrent requests                       |
| `--scrape-options <json>`      | JSON scrape options passed to each page           |
| `--scrape-options-file <path>` | Path to scrape options JSON file                  |
| `--webhook <url-or-json>`      | Webhook URL or configuration                      |
| `--cancel`                     | Cancel an active crawl job by job ID              |
| `--output <path>`              | Save output to file                               |
| `--pretty`                     | Pretty print JSON output                          |

***

### Monitor

Create recurring scrapes or crawls that diff each run against the previous snapshot. Add a goal when you want Firecrawl to judge which changed pages are meaningful for your use case.

```bash CLI theme={null}
firecrawl monitor create --name "Hacker News AI" \
  --schedule "every 30 minutes" \
  --goal "Alert when a new Hacker News story related to AI enters the top 10. Ignore changes to stories that are not about AI. Do not alert on changes outside the top 10." \
  --page https://news.ycombinator.com

firecrawl monitor run <monitorId>
firecrawl monitor checks <monitorId> --limit 10
firecrawl monitor check <monitorId> <checkId> --page-status changed
firecrawl monitor update <monitorId> \
  --goal "Alert when a new Hacker News story related to AI enters the top 10. Do not alert on changes outside the top 10."
firecrawl monitor delete <monitorId>
```

Monitor goals should stay short and faithful to the user's intent: say what should trigger an alert, restate any stated scope, and include exclusions only when they are obvious or explicitly requested. If the user asks for "any change", keep the goal broad.

**Available Options:**

| Option                    | Description                                          |
| ------------------------- | ---------------------------------------------------- |
| `--name <name>`           | Monitor name                                         |
| `--goal <goal>`           | Goal for meaningful-change judging                   |
| `--cron <expression>`     | Cron schedule, for example `*/30 * * * *`            |
| `--schedule <text>`       | Natural-language schedule, for example `hourly`      |
| `--timezone <tz>`         | Schedule timezone, default `UTC`                     |
| `--page <url>`            | Single page URL to scrape on each check              |
| `--scrape-urls <list>`    | Comma-separated page URLs to scrape on each check    |
| `--crawl-url <url>`       | Root URL for a crawl target                          |
| `--webhook-url <url>`     | Webhook destination                                  |
| `--webhook-events <list>` | Comma-separated monitor events                       |
| `--email <list>`          | Comma-separated email recipients                     |
| `--retention-days <n>`    | Snapshot retention window                            |
| `--page-status <state>`   | Filter pages on `monitor check`                      |
| `--state <state>`         | Set monitor state on `monitor update`: active/paused |

***

### Agent

Search and gather data from the web using natural language prompts.

```bash CLI theme={null}
# Basic usage - URLs are optional
firecrawl agent "Find the top 5 AI startups and their funding amounts" --wait

# Focus on specific URLs
firecrawl agent "Compare pricing plans" --urls https://slack.com/pricing,https://teams.microsoft.com/pricing --wait

# Use a schema for structured output
firecrawl agent "Get company information" --urls https://example.com --schema '{"type":"object","properties":{"name":{"type":"string"},"founded":{"type":"number"}}}' --wait

# Use schema from a file
firecrawl agent "Get product details" --urls https://example.com --schema-file schema.json --wait
```

#### Agent Options

```bash CLI theme={null}
# Use Spark 1 Pro for higher accuracy
firecrawl agent "Competitive analysis across multiple domains" --model spark-1-pro --wait

# Set max credits to limit costs
firecrawl agent "Gather contact information from company websites" --max-credits 100 --wait

# Check status of an existing job
firecrawl agent <job-id> --status

# Send agent events to a webhook
firecrawl agent "Extract product details" --urls https://example.com --webhook '{"url":"https://example.com/webhook","events":["completed","failed"]}'

# Cancel an active agent job
firecrawl agent <job-id> --cancel

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
| `--webhook <url-or-json>`   | Webhook URL or configuration                                                           |
| `--status`                  | Check status of existing agent job                                                     |
| `--cancel`                  | Cancel an active agent job by job ID                                                   |
| `--wait`                    | Wait for agent to complete before returning results                                    |
| `--poll-interval <seconds>` | Polling interval when waiting (default: 5)                                             |
| `--timeout <seconds>`       | Timeout when waiting (default: no timeout)                                             |
| `--output <path>`           | Save output to file                                                                    |
| `--json`                    | Output as JSON format                                                                  |

***

### Credit Usage

Check your team's credit balance and usage.

```bash CLI theme={null}
# View credit usage
firecrawl credit-usage

# Output as JSON
firecrawl credit-usage --json --pretty
```

***

### Version

Display the CLI version.

```bash CLI theme={null}
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

```bash CLI theme={null}
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

```bash CLI theme={null}
# Raw markdown output
firecrawl https://example.com --format markdown

# JSON output with multiple formats
firecrawl https://example.com --format markdown,links
```

## Examples

### Quick Scrape

```bash CLI theme={null}
# Get markdown content from a URL (use --only-main-content for clean output)
firecrawl https://docs.firecrawl.dev --only-main-content

# Get HTML content
firecrawl https://example.com --html -o page.html
```

### Full Site Crawl

```bash CLI theme={null}
# Crawl a docs site with limits
firecrawl crawl https://docs.example.com --limit 50 --max-depth 2 --wait --progress -o docs.json
```

### Site Discovery

```bash CLI theme={null}
# Find all blog posts
firecrawl map https://example.com --search "blog" -o blog-urls.txt
```

### Research Workflow

```bash CLI theme={null}
# Search and scrape results for research
firecrawl search "machine learning best practices 2024" --scrape --scrape-formats markdown --pretty
```

### Agent

```bash CLI theme={null}
# URLs are optional
firecrawl agent "Find the top 5 AI startups and their funding amounts" --wait

# Focus on specific URLs
firecrawl agent "Compare pricing plans" --urls https://slack.com/pricing,https://teams.microsoft.com/pricing --wait
```

### Combine with Other Tools

```bash CLI theme={null}
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

```bash CLI theme={null}
export FIRECRAWL_NO_TELEMETRY=1
```

## Open Source

The Firecrawl CLI and all three skill segments are open source on GitHub:

* [`firecrawl/cli`](https://github.com/firecrawl/cli) — the CLI and CLI skills (live web work)
* [`firecrawl/skills`](https://github.com/firecrawl/skills) — build skills (integrate Firecrawl into application code)
* [`firecrawl/firecrawl-workflows`](https://github.com/firecrawl/firecrawl-workflows) — workflow skills (repeatable deliverables such as research briefs, SEO audits, lead lists, and design clones)

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.
