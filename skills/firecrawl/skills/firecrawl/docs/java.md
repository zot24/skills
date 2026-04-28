> Source: https://docs.firecrawl.dev/quickstarts/java.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Java

> Get started with Firecrawl in Java. Search, scrape, and interact with web data using the official SDK.

## Prerequisites

* Java 11+
* A Firecrawl API key — [get one free](https://www.firecrawl.dev/app/api-keys)

## Install the SDK


    ```kotlin
    dependencies {
        implementation("com.firecrawl:firecrawl-java:1.2.0")
    }
    ```


    ```xml
    <dependency>
        <groupId>com.firecrawl</groupId>
        <artifactId>firecrawl-java</artifactId>
        <version>1.2.0</version>
    </dependency>
    ```


## Search the web

```java
import com.firecrawl.client.FirecrawlClient;
import com.firecrawl.models.SearchData;
import com.firecrawl.models.SearchOptions;

public class Main {
    public static void main(String[] args) {
        FirecrawlClient client = FirecrawlClient.builder()
            .apiKey("fc-YOUR-API-KEY")
            .build();

        SearchData results = client.search(
            "firecrawl web scraping",
            SearchOptions.builder().limit(5).build()
        );

        if (results.getWeb() != null) {
            for (var result : results.getWeb()) {
                System.out.println(result.get("title") + " - " + result.get("url"));
            }
        }
    }
}
```

## Scrape a page

```java
import com.firecrawl.models.Document;

Document doc = client.scrape("https://example.com");
System.out.println(doc.getMarkdown());
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

Open a browser session, run Playwright code against it, and close it when done:

```java
import com.firecrawl.models.ScrapeOptions;
import com.firecrawl.models.BrowserExecuteResponse;
import java.util.List;

Document doc = client.scrape("https://www.amazon.com",
    ScrapeOptions.builder().formats(List.of((Object) "markdown")).build());
String scrapeId = (String) doc.getMetadata().get("scrapeId");

BrowserExecuteResponse run = client.interact(scrapeId,
    "const title = await page.title(); console.log(title);");
System.out.println(run.getStdout());

client.stopInteractiveBrowser(scrapeId);
```

## Environment variable

Instead of passing `apiKey` directly, set the `FIRECRAWL_API_KEY` environment variable:

```bash
export FIRECRAWL_API_KEY=fc-YOUR-API-KEY
```

```java
FirecrawlClient client = FirecrawlClient.fromEnv();
```

## Next steps


    Search the web and get full page content


    All scrape options including formats, actions, and proxies


    Click, fill forms, and extract dynamic content


    Full SDK reference with crawl, map, batch scrape, and more


