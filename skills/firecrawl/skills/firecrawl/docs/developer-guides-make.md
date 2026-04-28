> Source: https://docs.firecrawl.dev/developer-guides/workflow-automation/make.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Firecrawl + Make

> Official integration and workflow automation for Firecrawl + Make


  **Official Make Integration:** [make.com/en/integrations/firecrawl](https://www.make.com/en/integrations/firecrawl)

  Connect with 3,000+ apps • Visual workflow builder • Enterprise-grade automation • AI-powered scenarios


## Make Integration Overview

Make (formerly Integromat) provides a verified, officially supported Firecrawl integration maintained by Mendable.


    Design complex automations with Make's intuitive visual interface


    Scale securely with enterprise-grade automation and controls


## Firecrawl Modules in Make


    ### Crawl a Website

    Crawl a URL and get its content from multiple pages

    ***

    ### Extract a Website

    Extract structured data from pages using LLMs

    ***

    ### Scrape a Website

    Scrape a URL and get its content from a single page

    ***

    ### Map a Website

    Map multiple URLs based on options

    ***

    ### Search a Website

    Web search with Firecrawl's scraping capabilities

    ***

    ### Get Crawl Status

    Get the status of a given crawl event ID

    ***

    ### Get Extract Status

    Get the status of a given extraction event ID


    ### Search a Website

    Full-page content retrieval for any search query


    ### Make an API Call

    Perform arbitrary authorized API calls for custom use cases


## Popular App Integrations


    **Google Sheets** - Track and log scraped data in spreadsheets

    **Airtable** - Build structured databases with scraped content

    **Google Drive** - Store scraped files and reports

    **Notion** - Organize research and web data


    **Slack** - Get alerts for website changes and updates

    **Telegram Bot** - Instant notifications for monitoring

    **Gmail** - Email reports and digests

    **Microsoft 365 Email** - Enterprise email automation


    **HubSpot CRM** - Enrich leads with web data

    **monday.com** - Track competitor intelligence

    **ClickUp** - Manage research tasks


    **OpenAI (ChatGPT, DALL-E)** - Analyze and summarize scraped content

    **Google Gemini AI** - Process and extract insights

    **Perplexity AI** - Enhanced research workflows

    **Make AI Agents** - Build adaptive AI-powered automations


## Common Workflow Patterns


    **Schedule** → Firecrawl (Scrape) → Google Sheets (Log) → Slack (Alert)

    Track competitor websites and get instant notifications


    **Google Forms** → Firecrawl (Scrape company site) → HubSpot CRM (Update)

    Automatically enrich leads with company data


    **Schedule** → Firecrawl (Crawl blog) → OpenAI (Summarize) → Gmail (Send digest)

    Automated content curation and distribution


    **Schedule (Hourly)** → Firecrawl (Scrape) → Filter → Telegram (Alert)

    Real-time price tracking and alerts


## Getting Started


    Get your API key at [firecrawl.dev](https://firecrawl.dev)


    Log into [Make](https://make.com) and click "Create a new scenario"


    Search for "Firecrawl" and select your desired action


    Add your Firecrawl API key to authenticate


    Set up your workflow parameters and run a test


## Firecrawl Actions Overview

| Module                | Use Case                         | Best For            |
| --------------------- | -------------------------------- | ------------------- |
| **Scrape a Website**  | Single-page data extraction      | Quick data capture  |
| **Crawl a Website**   | Multi-page content collection    | Full site scraping  |
| **Extract a Website** | AI-powered structured extraction | Complex data needs  |
| **Search a Website**  | Search + full content            | Research automation |
| **Map a Website**     | URL discovery                    | SEO analysis        |

## Best Practices


    * Use **Scrape** for single pages (fastest)
    * Use **Crawl** with limits for large sites
    * Schedule appropriately to avoid rate limits
    * Add error handling modules


    * Schedule strategically (hourly/daily/weekly)
    * Use filters to prevent unnecessary runs
    * Set crawl limits to control API usage
    * Test in Firecrawl playground first


## Industry Use Cases


    * Competitor price monitoring
    * Product availability tracking
    * Review aggregation and analysis
    * Inventory level monitoring


    * Listing aggregation from multiple sources
    * Market trend analysis
    * Property data enrichment
    * Competitive pricing intelligence


    * Competitor content monitoring
    * SEO performance tracking
    * Backlink analysis
    * Social media mention tracking


    * Market data collection
    * News and sentiment aggregation
    * Regulatory filing monitoring
    * Stock price tracking


    * Job posting aggregation
    * Company research automation
    * Candidate background enrichment
    * Salary benchmarking


## Make vs Zapier vs n8n

| Feature            | Make                              | Zapier           | n8n                  |
| ------------------ | --------------------------------- | ---------------- | -------------------- |
| **Setup**          | Visual builder, cloud             | No-code, cloud   | Self-hosted or cloud |
| **Pricing**        | Operations-based                  | Per-task pricing | Flat monthly         |
| **Integrations**   | 3,000+ apps                       | 8,000+ apps      | 400+ integrations    |
| **Complexity**     | Advanced workflows                | Simple workflows | Complex workflows    |
| **Best For**       | Visual automation, mid-complexity | Quick automation | Developer control    |
| **Learning Curve** | Moderate                          | Easy             | Moderate-Advanced    |


  **Pro Tip:** Make excels at visual workflow design and complex automations. Perfect for teams that need more control than Zapier but prefer visual building over n8n's code-first approach.

