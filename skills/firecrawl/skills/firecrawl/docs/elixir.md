> Source: https://docs.firecrawl.dev/quickstarts/elixir.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Elixir

> Get started with Firecrawl in Elixir. Search, scrape, and interact with web data using the official SDK.

## Prerequisites

* Elixir 1.14+ and OTP 25+
* A Firecrawl API key — [get one free](https://www.firecrawl.dev/app/api-keys)

## Install the SDK

Add `firecrawl` to your `mix.exs`:

```elixir
defp deps do
  [
    {:firecrawl, "~> 1.0"}
  ]
end
```

Configure your API key in `config/config.exs`:

```elixir
config :firecrawl, api_key: System.get_env("FIRECRAWL_API_KEY")
```

## Search the web

```elixir
{:ok, result} = Firecrawl.search_and_scrape(query: "firecrawl web scraping", limit: 5)

for entry <- result.body["data"]["web"] do
  IO.puts("#{entry["title"]} - #{entry["url"]}")
end
```

## Scrape a page

```elixir
{:ok, result} = Firecrawl.scrape_and_extract_from_url(url: "https://example.com")
IO.puts(result.body["data"]["markdown"])
```


  ```json
  {
    "success": true,
    "data": {
      "markdown": "# Example Domain\n\nThis domain is for use in illustrative examples...",
      "metadata": {
        "title": "Example Domain",
        "sourceURL": "https://example.com"
      }
    }
  }
  ```


## Interact with a page

Scrape a page, then keep working with it using the browser session API.

```elixir
{:ok, scrape} = Firecrawl.scrape_and_extract_from_url(
  url: "https://www.amazon.com",
  formats: ["markdown"]
)

scrape_id = get_in(scrape.body, ["data", "metadata", "scrapeId"])

# Use the REST API for interact (prompt-based)
headers = [
  {"Authorization", "Bearer #{Application.get_env(:firecrawl, :api_key)}"},
  {"Content-Type", "application/json"}
]

{:ok, _} = Req.post(
  "https://api.firecrawl.dev/v2/scrape/#{scrape_id}/interact",
  json: %{prompt: "Search for iPhone 16 Pro Max"},
  headers: headers
)

{:ok, response} = Req.post(
  "https://api.firecrawl.dev/v2/scrape/#{scrape_id}/interact",
  json: %{prompt: "Click on the first result and tell me the price"},
  headers: headers
)

IO.inspect(response.body)

# Stop the session
Req.delete(
  "https://api.firecrawl.dev/v2/scrape/#{scrape_id}/interact",
  headers: headers
)
```

## Environment variable

Set `FIRECRAWL_API_KEY` instead of hardcoding:

```bash
export FIRECRAWL_API_KEY=fc-YOUR-API-KEY
```

## Next steps


    All scrape options including formats, actions, and proxies


    Search the web and get full page content


    Click, fill forms, and extract dynamic content


    Full SDK reference with crawl, map, batch scrape, and more


