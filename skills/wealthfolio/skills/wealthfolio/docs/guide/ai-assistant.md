> Source: https://wealthfolio.app/docs/guide/ai-assistant



Docs


AI Assistant


# AI Assistant

Ask natural-language questions about your portfolio. Run fully local with Ollama, or BYO API key for Anthropic, OpenAI, Google AI, Groq, or OpenRouter.


Last updated November 12, 2026

The AI Assistant is a chat interface that answers questions about your portfolio by running typed queries against your local database. Ask “what did I earn in dividends last year?” and it’ll figure out the right query, run it, and answer with real numbers.

It’s not a financial advisor. It’s faster `SELECT`s.


Want an agent in your editor or Claude Desktop to reach your portfolio instead of chatting inside the app? The <a href="/docs/guide/mcp-server/" class="font-medium underline underline-offset-4">MCP Server</a> exposes these same typed tools to external AI agents over the Model Context Protocol. MCP agents also get tools the assistant doesn’t, for example to preview and then create or update accounts, save holdings snapshots, refresh prices, or change Spending budgets and events.


<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/ai/welcome.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="The AI assistant – ask about your portfolio in plain English" /> <img src="https://assets.wealthfolio.app/images/screenshots/ai/welcome-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="The AI assistant – ask about your portfolio in plain English" />
<figcaption>The AI assistant – ask about your portfolio in plain English</figcaption>
</figure>

------------------------------------------------------------------------

## 1 · What it can do

The assistant has access to a tool registry of typed, scoped functions over your portfolio. The read-only set covers the questions you usually want answered:

- `get_holdings` – current positions, optionally filtered by account or asset type.
- `get_accounts` – list your accounts and balances.
- `get_cash_balances` – cash positions per account and currency.
- `get_performance` – TWR / MWR / volatility / drawdown for a period.
- `search_activities` – query activities by date range, type, symbol, or account.
- `get_valuation_history` – portfolio valuation series over time.
- `get_income` – dividend / interest income, grouped however you ask.
- `get_asset_allocation` – composition by sector, region, asset class.
- `get_goals` – saved goals and progress.
- `get_health_status` – current Health Center findings.
- `get_portfolios` – your saved portfolios and the accounts in each.
- `get_net_worth` – net worth on a date, by asset category and liability, with an optional history.
- `get_contribution_limits` – contribution limits, what you’ve contributed, and the room left.
- `list_categorization_context` – cash transactions that still need a category, with your categories and recent examples.
- `list_asset_taxonomies` – your classification taxonomies and their categories.
- `get_asset_taxonomy_assignments` – how one asset is classified today.

With **Spending** on in the provider’s <a href="#provider-settings" class="font-medium underline underline-offset-4">Data access</a>, the assistant can also read your <a href="/docs/guide/spending-budgets/" class="font-medium underline underline-offset-4">Spending</a> data. These seven tools only read:

- `get_spending_context` – whether Spending is on, which accounts it includes, and its base currency and timezone.
- `search_spending_transactions` – search transactions in the accounts Spending includes.
- `get_budget` – a month’s budget, or the default budget, with how it’s going.
- `list_spending_events` – your events and event types.
- `get_event_spending_summaries` – totals, categories, and daily amounts for each event.
- `get_spending_report` – income, spending, saving, and net for a period, by category.
- `get_spending_insight` – a period’s groups, budgets, comparisons, pace, and amounts left.

Each Spending result shows as a card in the chat. When you hide balances in the app, the cards hide their amounts too.

There are also **safe-mutation** tools. They prepare a change for you to review, and nothing is saved until you confirm it in the chat:

- `record_activity` – record a single activity from the conversation.
- `record_activities` – record several at once.
- `import_csv` – feed a CSV into the importer.
- `propose_transaction_categories` – suggest categories for cash transactions.
- `create_categorization_rule` – draft a rule that categorizes matching transactions.
- `prepare_asset_classification` – draft new classifications for an asset.

A typical exchange:

> **You:** What dividend income did I get in 2024, grouped by asset?
>
> **Assistant:** *calls `get_income(period: "2024", group_by: "asset", type: "DIVIDEND")`*
>
> Here’s your 2024 dividend income by holding:
>
> - MSFT: \$312.40
> - JNJ: \$244.10
> - VTI: \$186.75
> - …

The LLM picks the tools, calls them, and summarizes the results. Your raw activities never go to the model. Only the tool call and its structured result.

------------------------------------------------------------------------

## 2 · What it can’t do (yet)

- **Give financial advice.** It’ll tell you what you own, not what you should own. We intentionally don’t fine-tune for advice. There’s no model the size that fits in consumer LLM constraints that gives advice we’d trust.
- **Browse the web.** The assistant only reads your local database. It can’t fetch news, pull updated prices, or check today’s market.
- **Mutate your portfolio without asking.** The safe-mutation tools listed above always require explicit user confirmation in the chat UI before anything is saved. No other write paths exist. You can’t `DELETE` your portfolio by asking nicely.
- **Change your Spending setup.** The Spending tools only read. To create or change budgets, events, or splits with an AI agent, use the <a href="/docs/guide/mcp-server/" class="font-medium underline underline-offset-4">MCP Server</a>, which shows each change for review first.

------------------------------------------------------------------------

## 3 · Choose a provider

Six providers are supported out of the box. Configure them under **Settings → AI providers**.


| Provider | Where it runs | Cost | Setup |
|----|----|----|----|
| **Ollama** | Your machine | Free | Install Ollama and pull a tool-capable model |
| **Groq** | Groq cloud | Per-token (paid) | Add your API key |
| **Google AI (Gemini)** | Google cloud | Per-token (paid) | Add your API key |
| **Anthropic (Claude)** | Anthropic’s servers | Per-token (paid; Claude Max and Team plans include monthly API credits) | Add your API key |
| **OpenAI** | OpenAI’s servers | Per-token (paid) | Add your API key |
| **OpenRouter** | OpenRouter cloud | Per-token (paid; free tier available) | Add your API key |


**Claude Max or Team plan?** It includes monthly API credits you can spend here. On claude.ai, open **Settings → Billing** (Team owners: **Organization settings → Billing**), link a Console organization under **API credits**, then create an API key in that organization and add it to the Anthropic provider. Free, Pro, and Enterprise plans aren’t eligible. See <a href="https://support.claude.com/en/articles/17154008" class="font-medium underline underline-offset-4">Claude’s help article</a> for details.

Use **Advanced options** to configure a custom endpoint compatible with the selected provider’s API.

### Provider settings

Open a provider’s settings to configure its API key and models:

- **API key:** enter the key and save it. You can remove a saved key when you stop using the provider.
- **Provider switch:** enable or disable the provider. Choose the model for a conversation in the chat model picker.
- **Enabled models:** select your favorite models to make them available in the chat model picker. You can include models discovered from the provider as well as catalog models.
- **Model capabilities:** for models without catalog presets, configure tool calling, vision, and thinking support to match the model. Turning on a capability does not add it to the model itself.
- **Data access:** choose which groups of tools this provider may use: **Accounts**, **Holdings**, **Transactions**, **Spending**, **Performance**, **Income**, **Goals**, **Allocation**, **Classifications**, and **History**. Review these permissions for each provider; tool results can be shared with its model when you chat. By default every group is on. That includes **Spending**, added in 3.13: if a provider’s Data access is still on its default, the assistant can read your Spending data and send it to that provider. A selection you saved yourself doesn’t gain Spending. To stop it, turn off **Spending** here.
- **Advanced options:** configure a custom endpoint and, where supported, temperature, output token limits, thinking token limits, and provider-specific tuning. Reset overrides to return to the catalog defaults. Available fields depend on the provider.

API keys and custom endpoint URLs have explicit **Save** buttons. Model selections and switches persist as you change them. Numeric and text tuning changes save when you click or tab away from the field. For a custom endpoint, use the API format expected by the selected provider; choose OpenAI for an OpenAI-compatible server.

### Ollama (recommended for privacy)

Models that support **tool calling** are required (the assistant relies on tool calls to fetch your data). Tool-capable models configured by default:

- `gemma4:e4b` (default)
- `qwen3.5:9b`
- `gpt-oss:20b`
- `ministral-3`

Setup:

``` mb-4
# Install Ollama from https://ollama.com
ollama pull gemma4:e4b
ollama serve
```

In Wealthfolio: **Settings → AI providers → Provider: Ollama**, Server URL `http://localhost:11434`, model `gemma4:e4b`.

### Anthropic, OpenAI, Google AI, Groq, OpenRouter

Paste your API key. Models configured by default:

- **Anthropic:** `claude-sonnet-5-5` (default), `claude-opus-5-5`, `claude-haiku-5-5`, `claude-haiku-4-5-20251001`.
- **OpenAI:** `gpt-6-astra` (default), `gpt-6.1-sol`, `gpt-6-luna`.
- **Google AI:** `gemini-3.8-flash` (default), `gemini-4-argon`, `gemini-3.5-flash-lite`.
- **Groq:** `openai/gpt-oss-120b` (default), `openai/gpt-oss-20b` (also writes chat titles).
- **OpenRouter:** `openrouter/free` (default) and a handful of free tier models via OpenRouter’s catalog.

API keys are encrypted in your Wealthfolio key store before being persisted. They never leave your device except in the API requests the assistant itself makes.

### OpenAI-compatible custom endpoints

Choose **OpenAI** and set its custom endpoint to use an OpenAI-compatible gateway such as LM Studio or vLLM, then select a model served by that endpoint. Other provider types expect their own API formats; a custom URL alone does not change the protocol.

**Reasoning models that hide their thinking** (DeepSeek-Reasoner, o1-style) may not return clean function-call output. Use a non-reasoning variant for the assistant – e.g. `deepseek-chat` rather than `deepseek-reasoner`.

------------------------------------------------------------------------

## 4 · What gets sent to the LLM

Each turn, the assistant sends:

1.  Your question.
2.  The system prompt describing the available tools.
3.  Whatever tool results you’ve fetched so far in this conversation.

It does **not** send:

- The raw contents of your database.
- Your API keys for other services.
- Any activity, holding, or balance unless an explicit tool call returned that data.

If you’re using Ollama, none of the above leaves your machine. If you’re using a hosted provider, the data sent is what’s in the conversation transcript: everything you asked plus everything the tool calls retrieved during the chat.

The assistant can only call the tool groups that are on in the provider’s <a href="#provider-settings" class="font-medium underline underline-offset-4">Data access</a>. That includes your Spending data: if a provider’s **Data access** is still on its default, the assistant can read your Spending transactions, budgets, events, and reports, and send the results to that provider. A selection you saved yourself doesn’t gain Spending. To stop it, turn off **Spending** in **Settings → AI providers → Data access** for that provider.


**Privacy tip:** if a question doesn’t need account-specific data, you can ask it without first running a tool. The LLM will answer from its training knowledge alone and no portfolio data leaves your machine.


------------------------------------------------------------------------

## 5 · Chat history

Conversations are stored locally and persist across app restarts. Each thread has an auto-generated title (from the first question). To delete a thread, use its **⋯ → Delete** action in the thread list.

------------------------------------------------------------------------

## 6 · Streaming and cost

Both Ollama and hosted providers stream tokens as they’re generated; answers appear incrementally. Tool calls run between streams (the model decides to call a tool, the tool runs locally, the model continues).

For paid providers, every chat turn (and every tool call result the model considers) counts toward your token usage. Tool results are usually small (the assistant queries get specific summaries, not full activity dumps), but a chat with many turns can add up. The provider’s dashboard is the source of truth for costs.

------------------------------------------------------------------------

## 7 · Troubleshooting

### ”No response” / hangs forever

- **Ollama:** make sure `ollama serve` is running and the model is pulled. Try `curl http://localhost:11434/api/tags` to confirm.
- **Hosted:** check your API key has tool-use enabled (some accounts need to enable function calling in the provider dashboard) and that you have credits.

### ”Conversation too long”

The chat no longer fits in the model’s context window. Start a new chat, or choose a model with a larger context window. The message links to the AI providers settings.

### ”Rate limit exceeded” or other provider errors

When a provider is busy or rate-limits a request before the answer starts, the assistant retries once. It waits as long as the provider asks, up to 10 seconds. If the provider asks for a longer wait, the error shows right away. Wait a moment, then send your question again.

### ”The model called a tool that doesn’t exist”

Some smaller open-source models hallucinate tool names. Switch to a larger tool-capable model (e.g. `qwen3.5:9b` or `gpt-oss:20b` from the bundled Ollama list).

### Answers are vague or wrong

The assistant is only as good as the model. If you’re on Ollama with a small model, upgrade to a larger one or switch to a hosted provider for harder questions. For follow-up precision, ask the assistant to “show me the tool call it ran.” It’ll surface the exact query.

### Numbers don’t match the dashboard

The assistant runs the same underlying queries the UI does, so numbers should match. If they don’t:

1.  Make sure the time period in your question matches what the dashboard is showing.
2.  The dashboard may be filtered to a specific account; ask the assistant explicitly “across all accounts” or “for account X”.
3.  File an issue on <a href="https://github.com/wealthfolio/wealthfolio/issues" class="font-medium underline underline-offset-4">GitHub</a> with the discrepancy.

------------------------------------------------------------------------

**Next step:** Once you’re comfortable with the assistant, the <a href="/docs/guide/health-center/" class="font-medium underline underline-offset-4">Health Center</a> is a good place to catch data inconsistencies before you ask the assistant deep questions.


<a href="/docs/guide/connect-broker-sync/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Connect &amp; Broker Sync</a> <a href="/docs/guide/mcp-server/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">MCP Server (Agent Access)</a>


On this page

- <a href="#1--what-it-can-do" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">1 · What it can do</a>
- <a href="#2--what-it-cant-do-yet" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">2 · What it can't do (yet)</a>
- <a href="#3--choose-a-provider" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">3 · Choose a provider</a>
  - <a href="#provider-settings" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Provider settings</a>
  - <a href="#ollama-recommended-for-privacy" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Ollama (recommended for privacy)</a>
  - <a href="#anthropic-openai-google-ai-groq-openrouter" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Anthropic, OpenAI, Google AI, Groq, OpenRouter</a>
  - <a href="#openai-compatible-custom-endpoints" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">OpenAI-compatible custom endpoints</a>
- <a href="#4--what-gets-sent-to-the-llm" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">4 · What gets sent to the LLM</a>
- <a href="#5--chat-history" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">5 · Chat history</a>
- <a href="#6--streaming-and-cost" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">6 · Streaming and cost</a>
- <a href="#7--troubleshooting" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">7 · Troubleshooting</a>
  - <a href="#no-response--hangs-forever" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">"No response" / hangs forever</a>
  - <a href="#conversation-too-long" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">"Conversation too long"</a>
  - <a href="#rate-limit-exceeded-or-other-provider-errors" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">"Rate limit exceeded" or other provider errors</a>
  - <a href="#the-model-called-a-tool-that-doesnt-exist" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">"The model called a tool that doesn't exist"</a>
  - <a href="#answers-are-vague-or-wrong" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Answers are vague or wrong</a>
  - <a href="#numbers-dont-match-the-dashboard" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Numbers don't match the dashboard</a>


