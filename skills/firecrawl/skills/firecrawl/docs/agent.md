[Skip to main content](https://docs.firecrawl.dev/features/agent#content-area)

[Firecrawl Docs home page![light logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=c45b3c967c19a39190e76fe8e9c2ed5a)![dark logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=3fee4abe033bd3c26e8ad92043a91c17)](https://firecrawl.dev/)

v2
![US](https://d3gk2c5xim1je2.cloudfront.net/flags/US.svg)

English

Search...

Ctrl K

Search...

Navigation

Agent (Research Preview)

Agent

[Documentation](https://docs.firecrawl.dev/introduction) [SDKs](https://docs.firecrawl.dev/sdks/overview) [Integrations](https://www.firecrawl.dev/app) [API Reference](https://docs.firecrawl.dev/api-reference/v2-introduction)

- [Playground](https://firecrawl.dev/playground)
- [Blog](https://firecrawl.dev/blog)
- [Community](https://discord.gg/firecrawl)
- [Changelog](https://firecrawl.dev/changelog)

##### Get Started

- [Introduction](https://docs.firecrawl.dev/introduction)
- [Skill + CLI](https://docs.firecrawl.dev/sdks/cli)
- [MCP Server](https://docs.firecrawl.dev/mcp-server)
- [Advanced Scraping Guide](https://docs.firecrawl.dev/advanced-scraping-guide)
- Plans & Billing


##### Core Endpoints

- [Search](https://docs.firecrawl.dev/features/search)
- Scrape

- [Interact](https://docs.firecrawl.dev/features/interact)

##### More

- [Map](https://docs.firecrawl.dev/features/map)
- [Crawl](https://docs.firecrawl.dev/features/crawl)
- Agent (Research Preview)



  - [Agent](https://docs.firecrawl.dev/features/agent)
  - [Models](https://docs.firecrawl.dev/features/models)

##### Quickstarts

- Node.js

- Serverless

- PHP

- Ruby

- Python

- [Go](https://docs.firecrawl.dev/quickstarts/go)
- [Rust](https://docs.firecrawl.dev/quickstarts/rust)
- [Elixir](https://docs.firecrawl.dev/quickstarts/elixir)
- Java

- .NET


##### Developer Guides

- [OpenClaw](https://docs.firecrawl.dev/developer-guides/openclaw)
- [Full-Stack Templates](https://docs.firecrawl.dev/developer-guides/examples)
- Usage Guides

- LLM SDKs and Frameworks

- Cookbooks

- MCP Setup Guides

- Common Sites

- Workflow Automation


##### Webhooks

- [Overview](https://docs.firecrawl.dev/webhooks/overview)
- [Event Types](https://docs.firecrawl.dev/webhooks/events)
- [Security](https://docs.firecrawl.dev/webhooks/security)
- [Testing](https://docs.firecrawl.dev/webhooks/testing)

##### Use Cases

- [Overview](https://docs.firecrawl.dev/use-cases/overview)
- [AI Platforms](https://docs.firecrawl.dev/use-cases/ai-platforms)
- [Lead Enrichment](https://docs.firecrawl.dev/use-cases/lead-enrichment)
- [SEO Platforms](https://docs.firecrawl.dev/use-cases/seo-platforms)
- [Deep Research](https://docs.firecrawl.dev/use-cases/deep-research)
- View more


##### Dashboard

- [Overview](https://docs.firecrawl.dev/dashboard)

##### Contributing

- [Open Source vs Cloud](https://docs.firecrawl.dev/contributing/open-source-or-cloud)
- [Running Locally](https://docs.firecrawl.dev/contributing/guide)
- [Self-hosting](https://docs.firecrawl.dev/contributing/self-host)

On this page

- [Using /agent](https://docs.firecrawl.dev/features/agent#using-%2Fagent)
- [Response](https://docs.firecrawl.dev/features/agent#response)
- [Providing URLs (Optional)](https://docs.firecrawl.dev/features/agent#providing-urls-optional)
- [Job Status and Completion](https://docs.firecrawl.dev/features/agent#job-status-and-completion)
- [Possible States](https://docs.firecrawl.dev/features/agent#possible-states)
- [Pending Example](https://docs.firecrawl.dev/features/agent#pending-example)
- [Completed Example](https://docs.firecrawl.dev/features/agent#completed-example)
- [Share agent runs](https://docs.firecrawl.dev/features/agent#share-agent-runs)
- [Model Selection](https://docs.firecrawl.dev/features/agent#model-selection)
- [Spark 1 Mini (Default)](https://docs.firecrawl.dev/features/agent#spark-1-mini-default)
- [Spark 1 Pro](https://docs.firecrawl.dev/features/agent#spark-1-pro)
- [Specifying a Model](https://docs.firecrawl.dev/features/agent#specifying-a-model)
- [Parameters](https://docs.firecrawl.dev/features/agent#parameters)
- [Agent vs Extract: What’s Improved](https://docs.firecrawl.dev/features/agent#agent-vs-extract-what%E2%80%99s-improved)
- [Example Use Cases](https://docs.firecrawl.dev/features/agent#example-use-cases)
- [CSV Upload in Agent Playground](https://docs.firecrawl.dev/features/agent#csv-upload-in-agent-playground)
- [API Reference](https://docs.firecrawl.dev/features/agent#api-reference)
- [Pricing](https://docs.firecrawl.dev/features/agent#pricing)
- [How Agent pricing works](https://docs.firecrawl.dev/features/agent#how-agent-pricing-works)
- [Parallel Agents Pricing](https://docs.firecrawl.dev/features/agent#parallel-agents-pricing)
- [Getting started](https://docs.firecrawl.dev/features/agent#getting-started)
- [Managing costs](https://docs.firecrawl.dev/features/agent#managing-costs)

![Firecrawl](https://docs.firecrawl.dev/logo/light.svg)![Firecrawl](https://docs.firecrawl.dev/logo/dark.svg)

### Ready to build?

Start getting web data for free and scale seamlessly as your project expands. **No credit card needed.**

[Start for free](https://www.firecrawl.dev/signin?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=start_for_free) [See our plans](https://www.firecrawl.dev/pricing?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=see_our_plans)

Firecrawl `/agent` is a magic API that searches, navigates, and gathers data from the widest range of websites, finding data in hard-to-reach places and uncovering data in ways no other API can. It accomplishes in a few minutes what would take a human many hours — end-to-end data collection, without scripts or manual work.
Whether you need one data point or entire datasets at scale, Firecrawl `/agent` works to get your data.**Think of `/agent` as deep research for data, wherever it is!**

**Research Preview**: Agent is in early access. Expect rough edges. It will get significantly better over time. [Share feedback →](mailto:product@firecrawl.com)

Agent builds on everything great about `/extract` and takes it further:

- **No URLs Required**: Just describe what you need via `prompt` parameter. URLs are optional
- **Deep Web Search**: Autonomously searches and navigates deep into sites to find your data
- **Reliable and Accurate**: Works with a wide variety of queries and use cases
- **Faster**: Processes multiple sources in parallel for quicker results

[**Try it in the Playground** \\
\\
Test the agent in the interactive playground — no code required.](https://www.firecrawl.dev/agent)

## [​](https://docs.firecrawl.dev/features/agent\#using-/agent)  Using `/agent`

The only required parameter is `prompt`. Simply describe what data you want to extract. For structured output, provide a JSON schema. The SDKs support Pydantic (Python) and Zod (Node) for type-safe schema definitions:

Python

Node

cURL

```
from firecrawl import Firecrawl
from pydantic import BaseModel, Field
from typing import List, Optional

app = Firecrawl(api_key="fc-YOUR_API_KEY")

class Founder(BaseModel):
    name: str = Field(description="Full name of the founder")
    role: Optional[str] = Field(None, description="Role or position")
    background: Optional[str] = Field(None, description="Professional background")

class FoundersSchema(BaseModel):
    founders: List[Founder] = Field(description="List of founders")

result = app.agent(
    prompt="Find the founders of Firecrawl",
    schema=FoundersSchema,
    model="spark-1-mini",
    max_credits=100
)

print(result.data)
```

### [​](https://docs.firecrawl.dev/features/agent\#response)  Response

JSON

```
{
  "success": true,
  "status": "completed",
  "data": {
    "founders": [\
      {\
        "name": "Eric Ciarla",\
        "role": "Co-founder",\
        "background": "Previously at Mendable"\
      },\
      {\
        "name": "Nicolas Camara",\
        "role": "Co-founder",\
        "background": "Previously at Mendable"\
      },\
      {\
        "name": "Caleb Peffer",\
        "role": "Co-founder",\
        "background": "Previously at Mendable"\
      }\
    ]
  },
  "expiresAt": "2024-12-15T00:00:00.000Z",
  "creditsUsed": 15
}
```

## [​](https://docs.firecrawl.dev/features/agent\#providing-urls-optional)  Providing URLs (Optional)

You can optionally provide URLs to focus the agent on specific pages:

Python

Node

cURL

```
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

result = app.agent(
    urls=["https://docs.firecrawl.dev", "https://firecrawl.dev/pricing"],
    prompt="Compare the features and pricing information from these pages"
)

print(result.data)
```

## [​](https://docs.firecrawl.dev/features/agent\#job-status-and-completion)  Job Status and Completion

Agent jobs run asynchronously. When you submit a job, you’ll receive a Job ID that you can use to check status:

- **Default method**: `agent()` waits and returns final results
- **Start then poll**: Use `start_agent` (Python) or `startAgent` (Node) to get a Job ID immediately, then poll with `get_agent_status` / `getAgentStatus`

Job results are available via the API for 24 hours after completion. After this period, you can still view your agent history and results in the [activity logs](https://www.firecrawl.dev/app/logs).

Python

Node

cURL

```
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

# Start an agent job
agent_job = app.start_agent(
    prompt="Find the founders of Firecrawl"
)

# Check the status
status = app.get_agent_status(agent_job.id)

print(status)
# Example output:
# status='completed'
# success=True
# data={ ... }
# expires_at=datetime.datetime(...)
# credits_used=15
```

### [​](https://docs.firecrawl.dev/features/agent\#possible-states)  Possible States

| Status | Description |
| --- | --- |
| `processing` | The agent is still working on your request |
| `completed` | Extraction finished successfully |
| `failed` | An error occurred during extraction |
| `cancelled` | The job was cancelled by the user |

#### [​](https://docs.firecrawl.dev/features/agent\#pending-example)  Pending Example

JSON

```
{
  "success": true,
  "status": "processing",
  "expiresAt": "2024-12-15T00:00:00.000Z"
}
```

#### [​](https://docs.firecrawl.dev/features/agent\#completed-example)  Completed Example

JSON

```
{
  "success": true,
  "status": "completed",
  "data": {
    "founders": [\
      {\
        "name": "Eric Ciarla",\
        "role": "Co-founder"\
      },\
      {\
        "name": "Nicolas Camara",\
        "role": "Co-founder"\
      },\
      {\
        "name": "Caleb Peffer",\
        "role": "Co-founder"\
      }\
    ]
  },
  "expiresAt": "2024-12-15T00:00:00.000Z",
  "creditsUsed": 15
}
```

## [​](https://docs.firecrawl.dev/features/agent\#share-agent-runs)  Share agent runs

You can share agent runs directly from the Agent playground. Shared links are public — anyone with the link can view the run output and activity — and you can revoke access at any time to disable the link. Shared pages are not indexed by search engines.

## [​](https://docs.firecrawl.dev/features/agent\#model-selection)  Model Selection

Firecrawl Agent offers two models. **Spark 1 Mini is 60% cheaper** and is the default — perfect for most use cases. Upgrade to Spark 1 Pro when you need maximum accuracy on complex tasks.

| Model | Cost | Accuracy | Best For |
| --- | --- | --- | --- |
| `spark-1-mini` | **60% cheaper** | Standard | Most tasks (default) |
| `spark-1-pro` | Standard | Higher | Complex research, critical extraction |

**Start with Spark 1 Mini** (default) — it handles most extraction tasks well at 60% lower cost. Switch to Pro only for complex multi-domain research or when accuracy is critical.

### [​](https://docs.firecrawl.dev/features/agent\#spark-1-mini-default)  Spark 1 Mini (Default)

`spark-1-mini` is our efficient model, ideal for straightforward data extraction tasks.**Use Mini when:**

- Extracting simple data points (contact info, pricing, etc.)
- Working with well-structured websites
- Cost efficiency is a priority
- Running high-volume extraction jobs

### [​](https://docs.firecrawl.dev/features/agent\#spark-1-pro)  Spark 1 Pro

`spark-1-pro` is our flagship model, designed for maximum accuracy on complex extraction tasks.**Use Pro when:**

- Performing complex competitive analysis
- Extracting data that requires deep reasoning
- Accuracy is critical for your use case
- Dealing with ambiguous or hard-to-find data

### [​](https://docs.firecrawl.dev/features/agent\#specifying-a-model)  Specifying a Model

Pass the `model` parameter to select which model to use:

Python

Node

cURL

```
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

# Using Spark 1 Mini (default - can be omitted)
result = app.agent(
    prompt="Find the pricing of Firecrawl",
    model="spark-1-mini"
)

# Using Spark 1 Pro for complex tasks
result = app.agent(
    prompt="Compare all enterprise features and pricing across Firecrawl, Apify, and ScrapingBee",
    model="spark-1-pro"
)

print(result.data)
```

## [​](https://docs.firecrawl.dev/features/agent\#parameters)  Parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `prompt` | string | **Yes** | Natural language description of the data you want to extract (max 10,000 characters) |
| `model` | string | No | Model to use: `spark-1-mini` (default) or `spark-1-pro` |
| `urls` | array | No | Optional list of URLs to focus the extraction |
| `schema` | object | No | Optional JSON schema for structured output |
| `maxCredits` | number | No | Maximum number of credits to spend on this agent task. Defaults to **2,500** if not set. The dashboard supports values up to **2,500**; for higher limits, set `maxCredits` via the API (values above 2,500 are always treated as paid requests). If the limit is reached, the job fails and **no data is returned**, though credits consumed for work performed are still charged. |

## [​](https://docs.firecrawl.dev/features/agent\#agent-vs-extract-what%E2%80%99s-improved)  Agent vs Extract: What’s Improved

| Feature | Agent (New) | Extract |
| --- | --- | --- |
| URLs Required | No | Yes |
| Speed | Faster | Standard |
| Cost | Lower | Standard |
| Reliability | Higher | Standard |
| Query Flexibility | High | Moderate |

## [​](https://docs.firecrawl.dev/features/agent\#example-use-cases)  Example Use Cases

- **Research**: “Find the top 5 AI startups and their funding amounts”
- **Competitive Analysis**: “Compare pricing plans between Slack and Microsoft Teams”
- **Data Gathering**: “Extract contact information from company websites”
- **Content Summarization**: “Summarize the latest blog posts about web scraping”

## [​](https://docs.firecrawl.dev/features/agent\#csv-upload-in-agent-playground)  CSV Upload in Agent Playground

The [Agent Playground](https://www.firecrawl.dev/app/agent) supports CSV upload for batch processing. Your CSV can contain one or more columns of input data. For example, a single column of company names, or multiple columns such as company name, product, and website URL. Each row represents one item for the agent to process.Upload your CSV, then add output columns using the ”+” button in the grid header. Each column has its own prompt — click a column header to describe what the agent should find for that field (e.g., “CEO or founder name”, “Total funding raised”). Hit Run, and the agent processes each row in parallel, filling in the results.

## [​](https://docs.firecrawl.dev/features/agent\#api-reference)  API Reference

Check out the [Agent API Reference](https://docs.firecrawl.dev/api-reference/endpoint/agent) for more details.Have feedback or need help? Email [help@firecrawl.com](mailto:help@firecrawl.com).

## [​](https://docs.firecrawl.dev/features/agent\#pricing)  Pricing

Firecrawl Agent uses **dynamic billing** that scales with the complexity of your data extraction request. You pay based on the actual work Agent performs, ensuring fair pricing whether you’re extracting simple data points or complex structured information from multiple sources.

### [​](https://docs.firecrawl.dev/features/agent\#how-agent-pricing-works)  How Agent pricing works

Agent pricing is **dynamic and credit-based** during Research Preview:

- **Simple extractions** (like contact info from a single page) typically use fewer credits and cost less
- **Complex research tasks** (like competitive analysis across multiple domains) use more credits but reflect the total effort involved
- **Transparent usage** shows you exactly how many credits each request consumed
- **Credit conversion** automatically converts agent credit usage to credits for easy billing

Credit usage varies based on the complexity of your prompt, the amount of data processed, and the structure of the output requested. As a rough guide, most agent runs consume **a few hundred credits**, though simpler single-page tasks may use less and complex multi-domain research may use more.

### [​](https://docs.firecrawl.dev/features/agent\#parallel-agents-pricing)  Parallel Agents Pricing

If you are running multiple agents in parallel with Spark-1 Fast, pricing is a lot more predictable at 10 credits per cell.

### [​](https://docs.firecrawl.dev/features/agent\#getting-started)  Getting started

**All users** receive **5 free daily runs**, which can be used from either the playground or the API, to explore Agent’s capabilities without any cost.Additional usage is billed based on credit consumption and converted to credits.

### [​](https://docs.firecrawl.dev/features/agent\#managing-costs)  Managing costs

Agent can be expensive, but there are some ways to decrease the cost:

- **Start with free runs**: Use your 5 daily free requests to understand pricing
- **Set a `maxCredits` parameter**: Limit your spending by setting a maximum number of credits you’re willing to spend. The dashboard caps this at 2,500 credits; to set a higher limit, use the `maxCredits` parameter directly via the API (note: values above 2,500 are always billed as paid requests)
- **Optimize prompts**: More specific prompts often use fewer credits
- **Break large tasks into smaller runs**: A single agent run has an output ceiling based on the underlying model’s generation capacity (~150-200 rows of structured data). For large extraction jobs, split by category, region, or URL batch (3-5 URLs per run) and merge the results. This also keeps each run well under the `maxCredits` limit.
- **Monitor usage**: Track your consumption through the dashboard
- **Set expectations**: Complex multi-domain research will use more credits than simple single-page extractions

Try Agent now at [firecrawl.dev/app/agent](https://www.firecrawl.dev/app/agent) to see how credit usage scales with your specific use cases.

Pricing is subject to change as we move from Research Preview to general availability. Current users will receive advance notice of any pricing updates.

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.

[Suggest edits](https://github.com/firecrawl/firecrawl-docs/edit/main/features/agent.mdx) [Raise issue](https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&body=Path:%20/features/agent)

[Crawl\\
\\
Previous](https://docs.firecrawl.dev/features/crawl) [Models\\
\\
Next](https://docs.firecrawl.dev/features/models)

Ctrl+I

Chat Widget

Loading...