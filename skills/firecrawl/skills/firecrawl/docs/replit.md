> Source: https://docs.firecrawl.dev/integrations/replit.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Replit

> Official Replit Connector for Firecrawl web search, scraping, and browser interaction

> [!NOTE]
>
> **Official Replit Connector:** [Open Integrations in Replit](https://replit.com/~?settings.show=true\&settings.tab=integrations)
>
> Search, scrape, and interact with the web • Built for Replit Agent • Core, Pro, or Enterprise plan required

## Replit Connector Overview

Firecrawl is available as an official Replit Connector. Once connected in your workspace, Replit Agent can use Firecrawl while building apps that need live web data.

> [card] Built for Replit Agent
>
> Enable Firecrawl in Integrations so Agent can search, scrape, and interact while building

> [card] Start without an API key
>
> Default: billed to your Replit account. Custom configuration: use a Firecrawl key or claim the 10,000-credit offer

## Firecrawl Capabilities in Replit

Replit Agent can build apps with Firecrawl's **search**, **scrape**, **interact**, **monitor**, **crawl**, and **parse** endpoints. Your connector configuration determines which account supplies the API key and pays for Firecrawl usage; it does not change which Firecrawl APIs an app can use.

> [accordion] Search
>
> Find relevant live web sources and excerpts for research, competitor discovery, and enrichment.
>
> **Use Cases:** Competitor discovery, research assistants, lead enrichment.

> [accordion] Scrape
>
> Turn any URL into clean data ready for LLMs, including summaries, structured fields, and app content.
>
> **Use Cases:** Product data extraction, article scraping, company page enrichment.

> [accordion] Interact
>
> Click, fill forms, and navigate multi step flows on dynamic websites.
>
> **Use Cases:** Form workflows, dynamic pages, multi step data collection.

> [accordion] Monitor
>
> Watch pages, sites, or the web for meaningful updates on a schedule. Available through the Firecrawl API in apps you build.
>
> **Use Cases:** Keyword monitoring, changelog alerts, competitive tracking.

> [accordion] Crawl
>
> Discover and scrape reachable pages across a site. Available through the Firecrawl API in apps you build.
>
> **Use Cases:** Documentation ingestion, full site extraction, multi page research.

> [accordion] Parse
>
> Convert PDFs and Word documents into Markdown or JSON. Available through the Firecrawl API in apps you build.
>
> **Use Cases:** Report parsing, document knowledge bases, file to structured data flows.

## Getting Started

**1. Open Integrations**

In a Replit workspace on a **Core**, **Pro**, or **Enterprise** plan, open **Integrations**.

**2. Connect Firecrawl**

Select **Enable new connector**, choose **Firecrawl**, use the default configuration, and select **Submit**. On Core and Pro, an account admin manages the connector for the collaborative workspace. On Enterprise, an admin manages it for the organization.

**3. Choose billing**

Keep **Use Replit default configurations** selected (no Firecrawl account needed), or open **Manage**, select **Use custom configurations**, and either paste your Firecrawl API key or claim the 10,000-credit offer, which provisions and saves a new key.

**4. Verify the connection**

In an app in the connected workspace, ask Agent to run a server-side connector test:

```text theme={null}
Run a server-side Firecrawl test.
Use the Replit connector.
Scrape https://example.com.
Use the connector-relative /scrape path.
Return only the page title and first paragraph.
Do not reveal or ask me for an API key.
Do not publish the app.
```

Confirm the proposed Firecrawl integration if prompted. The connection is working when the app's server-side connector call returns **Example Domain** with the page's first paragraph and does not ask you to supply an API key in chat or application code.

> [!NOTE]
>
> Replit's Firecrawl connector base URL already includes `/v2`. With `@replit/connectors-sdk`, use the connector-relative path `/scrape`, not `/v1/scrape`.

## Billing and credentials

> [accordion] Replit default
>
> * **Credential and billing:** Replit supplies its API key. Firecrawl requests are billed through Replit and deducted from Replit credits.
> * **Firecrawl account:** Not required.
> * **10,000-credit offer:** Not included.

> [accordion] Claim partner credits
>
> * **Credential and billing:** Replit provisions a new Firecrawl key. Firecrawl usage consumes the claimed partner credits.
> * **Firecrawl account:** A partner-associated account and key are provisioned.
> * **10,000-credit offer:** Included once per user per partner and expires 3 months after application.
> * **Success signal:** The offer shows **Claimed**, and Replit states that it is using your API key instead of billing connector usage through Replit.

> [accordion] Existing Firecrawl key
>
> * **Credential and billing:** You supply the key. Usage follows that Firecrawl account's plan, credits, and limits.
> * **Firecrawl account:** Required.
> * **10,000-credit offer:** Not added to the existing key.

> [!WARNING]
>
> Keep Firecrawl API keys in the connector's custom configuration. Do not paste keys into Agent prompts, application source, screenshots, logs, or pull requests.

> [!TIP]
>
> **Launch offer:** Open **Manage**, select **Use custom configurations**, and claim **10,000 free Firecrawl credits** to provision a **new** key. The offer applies once per user per partner, expires 3 months after it is applied, and uses Firecrawl's Free-plan limits. Pasting an existing key does not add the offer to that key. Default Replit billing does not include it. See [Partner credits](https://docs.firecrawl.dev/partner-credits.md) for full terms.

## Usage Patterns

> [tab] Competitor analysis
>
> **Search + scrape competitors**
>
> 1. Ask Agent to find competitors with Firecrawl `/search`
> 2. Scrape each competitor site for key context
> 3. Present names, summaries, and details in a simple UI
>
> **Example prompt:**
>
> ```
> Build a competitor analysis app using Firecrawl. Search for competitors, scrape their sites, and show summaries.
> ```

> [tab] Web monitoring
>
> **Keyword monitoring app with `/monitor`**
>
> Uses the Firecrawl API in the app your Agent builds.
>
> 1. Ask Agent to build an app that calls Firecrawl `/monitor`
> 2. Let users add keywords and target sites
> 3. Run checks on a schedule, plus manual scans, and surface meaningful changes
>
> **Example prompt:**
>
> ```
> Build a keyword monitoring app with Firecrawl that watches selected sites and alerts on meaningful changes.
> ```

## Industry Use Cases

> [accordion] Ecommerce
>
> * Competitor pricing and assortment tracking
> * Product availability checks
> * Review and listing aggregation

> [accordion] Marketing & SEO
>
> * Competitor content monitoring
> * SEO audits from live pages
> * Research brief generation

> [accordion] Sales & Lead Gen
>
> * Company enrichment from public web pages
> * Lead research assistants
> * Account brief generation for outbound

> [accordion] Support & Knowledge
>
> * Always fresh documentation assistants
> * Help center and changelog monitoring
> * Internal tools that answer from live sources

## Official Blog Post

> [card] [Firecrawl is now an official Replit Connector](https://www.firecrawl.dev/blog/firecrawl-official-replit-connector)
>
> Launch overview: connect Firecrawl in your Replit workspace and build apps with live web data.

## Troubleshooting

### Firecrawl is missing from Integrations

* Confirm the workspace is on Core, Pro, or Enterprise.
* Ask the workspace or organization admin to open **Integrations → Enable new connector** and enable Firecrawl.
* Confirm the app belongs to the workspace or organization where Firecrawl was enabled.

### Agent asks for an API key

* Confirm Firecrawl is enabled for the current workspace or organization.
* Ask Agent to attach the **Firecrawl connector** to the app and use its server-side connector binding.
* If you intend to use your own key, open **Manage**, select **Use custom configurations**, and add it there instead of pasting it into the prompt.

### Agent reports withheld credentials

An inline Agent query can report an empty credential result even when Firecrawl is connected. Ask Agent to run the test through the app's server-side `@replit/connectors-sdk` binding instead. For Firecrawl v2 scraping, use the connector-relative path `/scrape`; using `/v1/scrape` produces an incorrect `/v2/v1/scrape` request.

If **Manage** shows the custom configuration as **Claimed** and says Replit is using your API key, the partner-credit claim succeeded even if the inline Agent sandbox cannot read the credential directly.

### The credit-claim option is unavailable

* Confirm you selected **Use custom configurations** under **Manage**.
* Check that the user has not already received the Replit partner offer; it applies once per user per partner.
* Ask the workspace or organization admin to confirm you have access to the connector configuration.

Replit usage can take up to 30 minutes to appear in the usage dashboard.

## FAQs

> [accordion] Do I need a Firecrawl API key?
>
> No. By default, the connector runs on Replit's API key and usage is billed to your Replit account per request. Under **Manage**, select **Use custom configurations** to paste your own Firecrawl API key or claim the 10,000-credit offer, which provisions a new key for you. The offer applies once per user per partner and expires after 3 months.

> [accordion] Which Replit plans include the Connector?
>
> Replit integrations are available on **Core**, **Pro**, or **Enterprise**. Open Integrations in your workspace and search for Firecrawl.

> [accordion] How is this different from Replit using Firecrawl internally?
>
> Replit Agent has used Firecrawl behind the scenes for fresh docs and web content. The official Connector makes Firecrawl available to your apps from the Integrations catalog.

## Related Resources

> [card] [Manage Replit Connectors](https://docs.replit.com/replitai/managing-connectors)
>
> Plan availability, setup, access, and connector administration

> [card] [Replit Agent Integrations](https://docs.replit.com/features/integrations/overview)
>
> How Agent finds and uses integrations

> [card] [Customer story](https://www.firecrawl.dev/blog/how-replit-uses-firecrawl-to-power-ai-agents)
>
> How Replit powers Agent with Firecrawl


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
