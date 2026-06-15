> Source: https://docs.firecrawl.dev/features/agent



> ## Documentation Index
>
> Fetch the complete documentation index at: [/llms.txt](/llms.txt)
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="https://firecrawl.dev" class="select-none" data-state="closed" data-slot="context-menu-trigger" style="-webkit-touch-callout:none"><span class="sr-only">Firecrawl Docs home page</span><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=c45b3c967c19a39190e76fe8e9c2ed5a" class="nav-logo w-auto relative object-contain shrink-0 block dark:hidden h-6" alt="light logo" /><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=3fee4abe033bd3c26e8ad92043a91c17" class="nav-logo w-auto relative object-contain shrink-0 hidden dark:block h-6" alt="dark logo" /></a>


Search...


More


Agent


<a href="/introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor] hover:text-primary dark:hover:text-primary-light text-gray-800 dark:text-gray-200" data-active="true" aria-current="location">Documentation</a>


<a href="/sdks/overview" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">SDKs</a>


<a href="https://www.firecrawl.dev/app" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200" target="_blank" rel="noreferrer">Integrations</a>


<a href="/api-reference/v2-introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">API Reference</a>


<a href="/ai-onboarding" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">Build with AI</a>


More


# Agent


Copy page


Gather data wherever it lives on the web.


Copy page


- For **a single known URL**, <a href="/features/llm-extract" class="link">JSON mode on <code>/scrape</code></a> is cheaper and synchronous.
- Full comparison: <a href="/developer-guides/usage-guides/choosing-the-data-extractor" class="link">Choosing the Data Extractor</a>.


- **No URLs Required**: Just describe what you need via `prompt` parameter. URLs are optional
- **Deep Web Search**: Autonomously searches and navigates deep into sites to find your data
- **Reliable and Accurate**: Works with a wide variety of queries and use cases
- **Faster**: Processes multiple sources in parallel for quicker results


## Try it in the Playground


## 


<a href="#using-/agent" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


``` shiki
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


### 


<a href="#response" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{
  "success": true,
  "status": "completed",
  "data": {
    "founders": [
      {
        "name": "Eric Ciarla",
        "role": "Co-founder",
        "background": "Previously at Mendable"
      },
      {
        "name": "Nicolas Camara",
        "role": "Co-founder",
        "background": "Previously at Mendable"
      },
      {
        "name": "Caleb Peffer",
        "role": "Co-founder",
        "background": "Previously at Mendable"
      }
    ]
  },
  "expiresAt": "2024-12-15T00:00:00.000Z",
  "creditsUsed": 15
}
```


## 


<a href="#providing-urls-optional" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


``` shiki
from firecrawl import Firecrawl

app = Firecrawl(api_key="fc-YOUR_API_KEY")

result = app.agent(
    urls=["https://docs.firecrawl.dev", "https://firecrawl.dev/pricing"],
    prompt="Compare the features and pricing information from these pages"
)

print(result.data)
```


## 


<a href="#job-status-and-completion" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **Default method**: `agent()` waits and returns final results
- **Start then poll**: Use `start_agent` (Python) or `startAgent` (Node) to get a Job ID immediately, then poll with `get_agent_status` / `getAgentStatus`


Job results are available via the API for 24 hours after completion. After this period, you can still view your agent history and results in the <a href="https://www.firecrawl.dev/app/logs" class="link" target="_blank" rel="noreferrer">activity logs</a>.


Python


Node


cURL


``` shiki
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


### 


<a href="#possible-states" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Status       | Description                                |
|--------------|--------------------------------------------|
| `processing` | The agent is still working on your request |
| `completed`  | Extraction finished successfully           |
| `failed`     | An error occurred during extraction        |
| `cancelled`  | The job was cancelled by the user          |


#### 


<a href="#pending-example" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{
  "success": true,
  "status": "processing",
  "expiresAt": "2024-12-15T00:00:00.000Z"
}
```


#### 


<a href="#completed-example" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{
  "success": true,
  "status": "completed",
  "data": {
    "founders": [
      {
        "name": "Eric Ciarla",
        "role": "Co-founder"
      },
      {
        "name": "Nicolas Camara",
        "role": "Co-founder"
      },
      {
        "name": "Caleb Peffer",
        "role": "Co-founder"
      }
    ]
  },
  "expiresAt": "2024-12-15T00:00:00.000Z",
  "creditsUsed": 15
}
```


## 


<a href="#share-agent-runs" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#model-selection" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Model          | Cost            | Accuracy | Best For                              |
|----------------|-----------------|----------|---------------------------------------|
| `spark-1-mini` | **60% cheaper** | Standard | Most tasks (default)                  |
| `spark-1-pro`  | Standard        | Higher   | Complex research, critical extraction |


### 


<a href="#spark-1-mini-default" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- Extracting simple data points (contact info, pricing, etc.)
- Working with well-structured websites
- Cost efficiency is a priority
- Running high-volume extraction jobs

### 


<a href="#spark-1-pro" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- Performing complex competitive analysis
- Extracting data that requires deep reasoning
- Accuracy is critical for your use case
- Dealing with ambiguous or hard-to-find data

### 


<a href="#specifying-a-model" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Python


Node


cURL


``` shiki
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


## 


<a href="#parameters" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Parameter    | Type   | Required | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|--------------|--------|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `prompt`     | string | **Yes**  | Natural language description of the data you want to extract (max 10,000 characters)                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `model`      | string | No       | Model to use: `spark-1-mini` (default) or `spark-1-pro`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| `urls`       | array  | No       | Optional list of URLs to focus the extraction                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `schema`     | object | No       | Optional JSON schema for structured output                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `maxCredits` | number | No       | Maximum number of credits to spend on this agent task. Defaults to **2,500** if not set. The dashboard supports values up to **2,500**; for higher limits, set `maxCredits` via the API (values above 2,500 are always treated as paid requests). If the limit is reached, the job fails and **no data is returned**. Failed runs are not billed: credits used for AI reasoning are never charged on failure, any credits used for tool calls during the run (scraping, search, mapping, etc.) are refunded, and the response reports `creditsUsed: 0`. |


## 


<a href="#agent-vs-extract-what’s-improved" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Feature           | Agent (New) | Extract  |
|-------------------|-------------|----------|
| URLs Required     | No          | Yes      |
| Speed             | Faster      | Standard |
| Cost              | Lower       | Standard |
| Reliability       | Higher      | Standard |
| Query Flexibility | High        | Moderate |


## 


<a href="#example-use-cases" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **Research**: “Find the top 5 AI startups and their funding amounts”
- **Competitive Analysis**: “Compare pricing plans between Slack and Microsoft Teams”
- **Data Gathering**: “Extract contact information from company websites”
- **Content Summarization**: “Summarize the latest blog posts about web scraping”

## 


<a href="#csv-upload-in-agent-playground" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#troubleshooting-with-ask" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
curl -X POST https://api.firecrawl.dev/v2/support/ask \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "question": "my agent returned incomplete results"
  }'
```


## 


<a href="#api-reference" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#pricing" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#how-agent-pricing-works" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **Simple extractions** (like contact info from a single page) typically use fewer credits and cost less
- **Complex research tasks** (like competitive analysis across multiple domains) use more credits but reflect the total effort involved
- **Transparent usage** shows you exactly how many credits each request consumed
- **Credit conversion** automatically converts agent credit usage to credits for easy billing


### 


<a href="#parallel-agents-pricing" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#getting-started" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#managing-costs" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **Start with free runs**: Use your 5 daily free requests to understand pricing
- **Set a `maxCredits` parameter**: Limit your spending by setting a maximum number of credits you’re willing to spend. The dashboard caps this at 2,500 credits; to set a higher limit, use the `maxCredits` parameter directly via the API (note: values above 2,500 are always billed as paid requests)
- **Optimize prompts**: More specific prompts often use fewer credits
- **Break large tasks into smaller runs**: A single agent run has an output ceiling based on the underlying model’s generation capacity (~150-200 rows of structured data). For large extraction jobs, split by category, region, or URL batch (3-5 URLs per run) and merge the results. This also keeps each run well under the `maxCredits` limit.
- **Monitor usage**: Track your consumption through the dashboard
- **Set expectations**: Complex multi-domain research will use more credits than simple single-page extractions


> <span data-as="p">Are you an AI agent that needs a Firecrawl API key? See <a href="https://www.firecrawl.dev/agent-onboarding/SKILL.md" class="link" target="_blank" rel="noreferrer">firecrawl.dev/agent-onboarding/SKILL.md</a> for automated onboarding instructions.</span>


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/features/agent.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/features/agent" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


<a href="/features/crawl" class="border border-gray-200/70 dark:border-gray-800/70 group flex items-center rounded-xl py-3 px-4 hover:border-gray-300 dark:hover:border-gray-700 justify-start"></a>


Crawl


<a href="/quickstarts/nodejs" class="border border-gray-200/70 dark:border-gray-800/70 group flex items-center rounded-xl py-3 px-4 hover:border-gray-300 dark:hover:border-gray-700 justify-end"></a>


Node.js


