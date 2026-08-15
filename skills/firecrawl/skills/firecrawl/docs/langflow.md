> Source: https://docs.firecrawl.dev/integrations/langflow.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Langflow

> Learn how to use Firecrawl on Langflow

## Sync web data in Langflow workflows

Firecrawl can be used inside of [Langflow, the AI workflow builder](https://www.langflow.org/). This page introduces how to configure and use a Firecrawl block inside of Langflow.

<img className="block" src="https://mintcdn.com/firecrawl/vlKm1oZYK3oSRVTM/images/fc_langflow_block.png?fit=max&auto=format&n=vlKm1oZYK3oSRVTM&q=85&s=3f52eef4ff7544fb3ca7a77f890e7e83" alt="Firecrawl Langflow block" width="798" height="1068" data-path="images/fc_langflow_block.png" />

### Scraping with Firecrawl blocks

1. Log in to your Firecrawl account and get your API Key, and then enter it on the block or pass it in from another part of the workflow.
2. (Optional) Connect Text Splitter.
3. Select the scrape mode to pick up a single page.
4. Input target URL to be scraped or pass it in from another part of the workflow.
5. Set up any scrape options depending on what website and data you are trying to get, such as the output formats and whether to return only the main content. You can also pass these in from another part of the workflow.
6. Use the data in your workflows.
