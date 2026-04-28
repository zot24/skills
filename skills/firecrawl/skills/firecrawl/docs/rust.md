> Source: https://docs.firecrawl.dev/quickstarts/rust.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Rust

> Get started with Firecrawl in Rust. Search, scrape, and interact with web data using the official SDK.

## Prerequisites

* Rust 1.70+ with Cargo
* A Firecrawl API key — [get one free](https://www.firecrawl.dev/app/api-keys)

## Install the crate

Add `firecrawl` to your `Cargo.toml`:

```toml
[dependencies]
firecrawl = "2"
tokio = { version = "1", features = ["full"] }
serde_json = "1"
```

## Search the web

```rust
use firecrawl::{Client, SearchOptions};

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let client = Client::new("fc-YOUR-API-KEY")?;

    let results = client.search(
        "firecrawl web scraping",
        SearchOptions { limit: Some(5), ..Default::default() },
    ).await?;

    if let Some(web) = results.data.web {
        for item in web {
            if let firecrawl::SearchResultOrDocument::WebResult(r) = item {
                println!("{} - {}", r.url, r.title.unwrap_or_default());
            }
        }
    }
    Ok(())
}
```

## Scrape a page

```rust
let doc = client.scrape("https://example.com", None).await?;
println!("{}", doc.markdown.unwrap_or_default());
```


  ```json
  {
    "markdown": "# Example Domain\n\nThis domain is for use in illustrative examples...",
    "metadata": {
      "title": "Example Domain",
      "sourceURL": "https://example.com"
    }
  }
  ```


## Interact with a page

Scrape a page to get a `scrapeId`, then use the interact API to control the browser session:

```rust
use firecrawl::{Client, ScrapeOptions, Format, ScrapeExecuteOptions};

let doc = client.scrape(
    "https://www.amazon.com",
    ScrapeOptions {
        formats: Some(vec![Format::Markdown]),
        ..Default::default()
    },
).await?;

let scrape_id = doc.metadata
    .as_ref()
    .and_then(|m| m.scrape_id.as_deref())
    .expect("scrapeId not found");

// Send a prompt to interact with the page
let run = client.interact(
    scrape_id,
    ScrapeExecuteOptions {
        prompt: Some("Search for iPhone 16 Pro Max".to_string()),
        ..Default::default()
    },
).await?;

let run = client.interact(
    scrape_id,
    ScrapeExecuteOptions {
        prompt: Some("Click on the first result and tell me the price".to_string()),
        ..Default::default()
    },
).await?;

println!("{:?}", run.output);

// Close the session
client.stop_interaction(scrape_id).await?;
```

## Environment variable

Set `FIRECRAWL_API_KEY` instead of passing the key directly:

```bash
export FIRECRAWL_API_KEY=fc-YOUR-API-KEY
```

```rust
let api_key = std::env::var("FIRECRAWL_API_KEY")?;
let client = Client::new(api_key)?;
```

## Next steps


    Search the web and get full page content


    All scrape options including formats, actions, and proxies


    Click, fill forms, and extract dynamic content


    Full SDK reference with crawl, map, batch scrape, and more


