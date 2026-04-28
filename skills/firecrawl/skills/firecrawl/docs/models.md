> Source: https://docs.firecrawl.dev/features/models.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Models

> Choose the right model for your agent extraction tasks.

Firecrawl Agent offers two models optimized for different use cases. Choose the right model based on your extraction complexity and cost requirements.

## Available Models

| Model          | Cost            | Accuracy | Best For                              |
| -------------- | --------------- | -------- | ------------------------------------- |
| `spark-1-mini` | **60% cheaper** | Standard | Most tasks (default)                  |
| `spark-1-pro`  | Standard        | Higher   | Complex research, critical extraction |


  **Start with Spark 1 Mini** (default) — it handles most extraction tasks well at 60% lower cost. Switch to Pro only for complex multi-domain research or when accuracy is critical.


## Spark 1 Mini (Default)

`spark-1-mini` is our efficient model, ideal for straightforward data extraction tasks.

**Use Mini when:**

* Extracting simple data points (contact info, pricing, etc.)
* Working with well-structured websites
* Cost efficiency is a priority
* Running high-volume extraction jobs

**Example use cases:**

* Extracting product prices from e-commerce sites
* Gathering contact information from company pages
* Pulling basic metadata from articles
* Simple data point lookups

## Spark 1 Pro

`spark-1-pro` is our flagship model, designed for maximum accuracy on complex extraction tasks.

**Use Pro when:**

* Performing complex competitive analysis
* Extracting data that requires deep reasoning
* Accuracy is critical for your use case
* Dealing with ambiguous or hard-to-find data

**Example use cases:**

* Multi-domain competitive analysis
* Complex research tasks requiring reasoning
* Extracting nuanced information from multiple sources
* Critical business intelligence gathering

## Specifying a Model

Pass the `model` parameter to select which model to use:

<CodeGroup>
  ```python Python
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

  ```js Node
  import Firecrawl from '@mendable/firecrawl-js';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

  // Using Spark 1 Mini (default - can be omitted)
  const result = await firecrawl.agent({
    prompt: "Find the pricing of Firecrawl",
    model: "spark-1-mini"
  });

  // Using Spark 1 Pro for complex tasks
  const resultPro = await firecrawl.agent({
    prompt: "Compare all enterprise features and pricing across Firecrawl, Apify, and ScrapingBee",
    model: "spark-1-pro"
  });

  console.log(result.data);
  ```

  ```bash cURL
  # Using Spark 1 Mini (default)
  curl -X POST "https://api.firecrawl.dev/v2/agent" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "prompt": "Find the pricing of Firecrawl",
      "model": "spark-1-mini"
    }'

  # Using Spark 1 Pro for complex tasks
  curl -X POST "https://api.firecrawl.dev/v2/agent" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "prompt": "Compare all enterprise features and pricing across Firecrawl, Apify, and ScrapingBee",
      "model": "spark-1-pro"
    }'
  ```
</CodeGroup>

## Model Comparison

| Feature          | Spark 1 Mini | Spark 1 Pro   |
| ---------------- | ------------ | ------------- |
| **Cost**         | 60% cheaper  | Standard      |
| **Accuracy**     | Standard     | Higher        |
| **Speed**        | Fast         | Fast          |
| **Best for**     | Most tasks   | Complex tasks |
| **Reasoning**    | Standard     | Advanced      |
| **Multi-domain** | Good         | Excellent     |

## Pricing by Model

Both models use dynamic, credit-based pricing that scales with task complexity:

* **Spark 1 Mini**: Uses approximately 60% fewer credits than Pro for equivalent tasks
* **Spark 1 Pro**: Standard credit consumption for maximum accuracy


  Credit usage varies based on prompt complexity, data processed, and output structure — regardless of model selected.


## Choosing the Right Model

```
                    ┌─────────────────────────────────┐
                    │   What type of task?            │
                    └─────────────────────────────────┘
                                   │
                    ┌──────────────┴──────────────┐
                    ▼                             ▼
          ┌─────────────────┐           ┌─────────────────┐
          │  Simple/Direct  │           │ Complex/Research│
          │  extraction     │           │ multi-domain    │
          └─────────────────┘           └─────────────────┘
                    │                             │
                    ▼                             ▼
          ┌─────────────────┐           ┌─────────────────┐
          │  spark-1-mini   │           │  spark-1-pro    │
          │  (60% cheaper)  │           │  (higher acc.)  │
          └─────────────────┘           └─────────────────┘
```

## API Reference

See the [Agent API Reference](/api-reference/endpoint/agent) for complete parameter documentation.

Have questions about which model to use? Email [help@firecrawl.com](mailto:help@firecrawl.com).

> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.
