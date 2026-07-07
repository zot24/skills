> Source: https://docs.firecrawl.dev/sdks/elixir.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Elixir

> Firecrawl Elixir SDK is an auto-generated client for the Firecrawl API v2, built with Req and NimbleOptions.

Scrape single pages, crawl entire sites, and map URLs from your Elixir application. The SDK validates all parameters at runtime with NimbleOptions and uses Req for HTTP, so you get clear errors for typos and invalid options before any request is made.

Every function has a bang (`!`) variant that raises on error instead of returning `{:error, ...}` tuples.

## Installation

Add `firecrawl` to your list of dependencies in `mix.exs` and configure your API key:

```elixir Elixir theme={null}
# Add to mix.exs
{:firecrawl, "~> 1.0"}

# Then configure your API key in config.exs
config :firecrawl, api_key: "fc-YOUR-API-KEY"
```

Or pass the API key per-request:

```elixir Elixir theme={null}
Firecrawl.scrape_and_extract_from_url([url: "https://example.com"], api_key: "fc-YOUR-API-KEY")
```

## Usage

1. Get an API key from [firecrawl.dev](https://firecrawl.dev)
2. Set the API key in your application config or pass it as an option to any function.

```elixir Elixir theme={null}
# Scrape a website:
{:ok, scrape_result} = Firecrawl.scrape_and_extract_from_url(
  url: "https://firecrawl.dev",
  formats: ["markdown", "html"]
)
IO.inspect(scrape_result.body)

# Crawl a website:
{:ok, crawl_result} = Firecrawl.crawl_urls(
  url: "https://firecrawl.dev",
  limit: 100,
  scrape_options: [
    formats: ["markdown", "html"]
  ]
)
IO.inspect(crawl_result.body)
```

### Scraping a URL

Scrape a single URL with `scrape_and_extract_from_url`. It returns the page content as structured data, including markdown, metadata, and any other formats you request.

```elixir Elixir theme={null}
# Scrape a website:
{:ok, result} = Firecrawl.scrape_and_extract_from_url(url: "https://firecrawl.dev", formats: ["markdown", "html"])
IO.inspect(result.body)
```

### Crawl a Website

To crawl a website, use `crawl_urls`. It takes the starting URL and optional parameters such as page limit, allowed domains, and output format.

```elixir Elixir theme={null}
{:ok, result} = Firecrawl.crawl_urls(url: "https://docs.firecrawl.dev", limit: 5)
IO.inspect(result.body)
```

### Start a Crawl

Start a crawl job and get back the job ID without blocking:

```elixir Elixir theme={null}
{:ok, job} = Firecrawl.crawl_urls(url: "https://docs.firecrawl.dev", limit: 10)
crawl_id = job.body["id"]
IO.puts(crawl_id)
```

### Checking Crawl Status

Check the status of a crawl job with `get_crawl_status`:

```elixir Elixir theme={null}
{:ok, status} = Firecrawl.get_crawl_status("<crawl-id>")
IO.inspect(status.body)
```

### Cancelling a Crawl

Cancel a crawl job with `cancel_crawl`:

```elixir Elixir theme={null}
{:ok, result} = Firecrawl.cancel_crawl("<crawl-id>")
IO.puts("Cancelled: #{inspect(result.body)}")
```

### Map a Website

Use `map_urls` to generate a list of URLs from a website:

```elixir Elixir theme={null}
{:ok, result} = Firecrawl.map_urls(url: "https://firecrawl.dev", limit: 10)
IO.inspect(result.body)
```

### Search

Search the web and optionally scrape results:

```elixir Elixir theme={null}
{:ok, result} = Firecrawl.search_and_scrape(query: "firecrawl web scraping", limit: 5)
IO.inspect(result.body["data"]["web"])
```

### Batch Scrape

Scrape multiple URLs in a single batch job:

```elixir Elixir theme={null}
{:ok, result} = Firecrawl.scrape_and_extract_from_urls(
  urls: ["https://firecrawl.dev", "https://docs.firecrawl.dev"],
  formats: ["markdown"]
)
IO.inspect(result.body)
```

### Agent

Start an agentic data extraction task:

```elixir Elixir theme={null}
{:ok, job} = Firecrawl.start_agent(
  prompt: "Extract all product names and prices",
  urls: ["https://example.com/products"]
)
job_id = job.body["id"]

# Poll for status
{:ok, status} = Firecrawl.get_agent_status(job_id)
IO.inspect(status.body)
```

## Browser

Launch cloud browser sessions and execute code remotely.

### Create a Session

```elixir Elixir theme={null}
{:ok, session} = Firecrawl.create_browser_session(ttl: 600)
session_id = session.body["id"]
cdp_url = session.body["cdpUrl"]
live_view_url = session.body["liveViewUrl"]
```

### Execute Code

```elixir Elixir theme={null}
{:ok, result} = Firecrawl.execute_browser_code(session_id,
  code: ~s(await page.goto("https://news.ycombinator.com")\ntitle = await page.title()\nprint(title)),
  language: "python"
)
IO.inspect(result.body)
```

### Profiles

Save and reuse browser state (cookies, localStorage, etc.) across sessions:

```elixir Elixir theme={null}
{:ok, session} = Firecrawl.create_browser_session(
  ttl: 600,
  profile: [
    name: "my-profile",
    save_changes: true
  ]
)
```

### List & Close Sessions

```elixir Elixir theme={null}
# List active sessions
{:ok, sessions} = Firecrawl.list_browser_sessions(status: "active")
IO.inspect(sessions.body)

# Close a session
{:ok, _} = Firecrawl.delete_browser_session(session_id)
```

## Self-Hosted Instances

To use a self-hosted Firecrawl instance, pass the `base_url` option:

```elixir Elixir theme={null}
{:ok, result} = Firecrawl.scrape_and_extract_from_url(
  [url: "https://example.com"],
  base_url: "https://your-instance.com/v2"
)
```

## Error Handling

Non-bang functions return `{:ok, response}` or `{:error, exception}`. Bang variants raise on error. NimbleOptions validates all parameters before the request is sent, catching typos, missing required fields, and type errors immediately.

```elixir Elixir theme={null}
case Firecrawl.scrape_and_extract_from_url(url: "https://example.com") do
  {:ok, response} -> IO.inspect(response.body)
  {:error, error} -> IO.puts("Error: #{Exception.message(error)}")
end

# Or use the bang variant to raise on error:
response = Firecrawl.scrape_and_extract_from_url!(url: "https://example.com")
IO.inspect(response.body)
```

## All Available Functions

| Function                       | Description                       |
| ------------------------------ | --------------------------------- |
| `scrape_and_extract_from_url`  | Scrape a single URL               |
| `scrape_and_extract_from_urls` | Batch scrape multiple URLs        |
| `crawl_urls`                   | Crawl a website                   |
| `get_crawl_status`             | Check crawl job status            |
| `get_crawl_errors`             | Get crawl job errors              |
| `get_active_crawls`            | List active crawls                |
| `cancel_crawl`                 | Cancel a crawl job                |
| `map_urls`                     | Map URLs on a website             |
| `search_and_scrape`            | Search and scrape results         |
| `start_agent`                  | Start an agent extraction task    |
| `get_agent_status`             | Check agent job status            |
| `cancel_agent`                 | Cancel an agent job               |
| `create_browser_session`       | Create a browser session          |
| `execute_browser_code`         | Execute code in a browser session |
| `list_browser_sessions`        | List browser sessions             |
| `delete_browser_session`       | Delete a browser session          |
| `get_batch_scrape_status`      | Check batch scrape status         |
| `get_batch_scrape_errors`      | Get batch scrape errors           |
| `cancel_batch_scrape`          | Cancel a batch scrape             |
| `get_credit_usage`             | Get remaining credits             |

Every function above has a bang (`!`) variant (e.g., `scrape_and_extract_from_url!`) that raises instead of returning error tuples.

For full API documentation, see [hexdocs.pm/firecrawl](https://hexdocs.pm/firecrawl).
