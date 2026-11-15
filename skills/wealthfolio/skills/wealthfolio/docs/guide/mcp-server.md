> Source: https://wealthfolio.app/docs/guide/mcp-server



Docs


MCP Server – Connect AI Agents


# MCP Server – Connect AI Agents

Connect Wealthfolio to external AI agents – Claude Code, Codex, ChatGPT desktop, Cursor, Windsurf, Cline, VS Code – over the Model Context Protocol, with scoped, revocable access tokens.


Last updated November 12, 2026

**Wealthfolio’s MCP server** lets external AI agents talk to your portfolio over the <a href="https://modelcontextprotocol.io" class="font-medium underline underline-offset-4">Model Context Protocol</a>. Point Claude Code (including Claude Desktop’s Code tab), Codex, the ChatGPT desktop app, Cursor, Windsurf, Cline, or any MCP-capable client at Wealthfolio and it can read your holdings, performance, activities, and spending – and, if you allow it, record or change activities, set up accounts, holdings and liabilities, fix and refresh prices, organize your spending, and manage budgets – through the same typed tool registry the built-in <a href="/docs/guide/ai-assistant/" class="font-medium underline underline-offset-4">AI Assistant</a> uses.

Every connection is authenticated with a **scoped access token** you create and can revoke. Nothing is exposed until you turn the server on and hand out a token.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/agent-access/overview.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Settings → AI agent access – the MCP endpoint, access tokens, and agent activity log" /> <img src="https://assets.wealthfolio.app/images/screenshots/agent-access/overview-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Settings → AI agent access – the MCP endpoint, access tokens, and agent activity log" />
<figcaption>Settings → AI agent access – turn on the server, mint scoped tokens, watch what agents do</figcaption>
</figure>


**Assistant vs. MCP server.** The <a href="/docs/guide/ai-assistant/" class="font-medium underline underline-offset-4">AI Assistant</a> is a chat window *inside* Wealthfolio. The MCP server is the reverse: it lets an agent running *outside* Wealthfolio (in your editor or desktop client) reach into your portfolio. Both run over the same local, typed tool registry – your raw database is never handed to a model.


------------------------------------------------------------------------

## 1 · Where it lives

Open **Settings → AI agent access**. What you see depends on how you run Wealthfolio:

- **Desktop app** – a master toggle turns the feature on, then a local MCP server runs at `http://127.0.0.1:<port>/mcp`. You control it with **Start/Stop**, choose whether it **starts with the app**, and toggle **audit logging**.
- **Self-hosted / web server** – the endpoint is enabled with an environment variable (see <a href="#6--self-hosted-servers" class="font-medium underline underline-offset-4">§6</a>) and served at `/mcp` on the same origin as your server. Token management and the audit log work the same way.


AI agent access is a **desktop and web** feature. It isn’t available on the mobile app.


------------------------------------------------------------------------

## 2 · Turn it on and create a token

1.  **Enable the server.** Flip the master toggle (desktop) or set the environment variable (self-hosted). On desktop, press **Start** – the endpoint URL appears with a green dot when it’s live.
2.  **Create an access token.** Under **Personal access tokens**, click **Create token**, name it (e.g. “Claude Code”), pick an expiry, and choose its scopes. Tokens default to the **Read-only** preset – one click away from the common case.
3.  **Copy the token once.** It’s shown a single time at creation. The dialog also gives you ready-to-paste setup for Claude Code, Codex, or JSON-config clients, with the token already embedded.

<figure class="not-prose my-6">
<img src="https://assets.wealthfolio.app/images/screenshots/agent-access/new-token.png" class="block h-auto w-full dark:hidden" loading="lazy" decoding="async" alt="Creating a scoped access token – read and write scopes with a live capability summary" /> <img src="https://assets.wealthfolio.app/images/screenshots/agent-access/new-token-dark.png" class="hidden h-auto w-full dark:block" loading="lazy" decoding="async" alt="Creating a scoped access token – read and write scopes with a live capability summary" />
<figcaption>Each scope you tick shows up in the live "this token will be able to" summary on the right</figcaption>
</figure>

Expiry options are **7 days**, **30 days**, **90 days** (default), **1 year**, or **no expiry**. Shorter is safer – you can always mint a new one.

### Change a token’s permissions

To change what an existing token can do, click **Edit permissions** next to it in the token list, tick the scopes or pick a preset, and click **Save**. The token itself doesn’t change, so your clients keep their config; its name and expiry stay the same too. The new permissions apply from the agent’s next request. Refresh the tools in your client, or reconnect it, so the agent sees tools you’ve just granted.

------------------------------------------------------------------------

## 3 · Scopes – what a token can do

A token carries a set of scopes. The agent can only call tools its scopes allow; the backend rejects anything outside them. Scopes split into **read** and **write**.

### Read access


| Scope | Grants |
|----|----|
| **Accounts (read)** | List accounts and their metadata. |
| **Holdings & value (read)** | Read holdings, positions, and portfolio value. |
| **Performance (read)** | Read performance history and summaries. |
| **Activities (read)** | Read transactions and other account activities. |
| **Financial planning (read)** | Read goals, contribution limits, and planning data. |
| **Health (read)** | Read portfolio health and diagnostic checks. |
| **Asset classification (read)** | Read instrument classifications and taxonomies. |
| **View spending** | Read transactions in Spending accounts, categories, splits, rules, events, reports, and budgets. |


### Write access


| Scope | Grants |
|----|----|
| **Activities — draft** | Prepare draft activities for review (not committed). |
| **Activities — commit/write** | Commit activities, update existing ones, and link or unlink transfers. **Requires the draft scope.** |
| **Asset classification — suggest** | Suggest instrument classifications for review. |
| **Asset classification — apply/write** | Apply reviewed asset classifications. **Requires the suggest scope.** |
| **Market data — write** | Save reviewed prices (quotes) for existing assets, refresh prices from your providers, and fix an asset’s listing, currency, or provider. **Requires the holdings read scope.** |
| **Accounts — write** | Create accounts and change their name, type, group, number, tracking mode, and hidden or archived state. **Requires the accounts read scope.** |
| **Holdings — write** | Save holdings snapshots for accounts that track holdings, and add alternative assets and liabilities. **Requires the holdings read scope.** |
| **Organize spending** | Manage spending categories, assignments, splits, rules, and events. **Requires View spending.** |
| **Manage budgets** | Change default and monthly budgets, groups, buffers, and rollovers. **Requires View spending.** |


**Activities — commit/write** also lets an agent delete activities, or mark one void so it stays stored but no longer counts. **Health (read)** lets it run the Health Center’s checks, not only read their last result.

Some scopes need another one. Ticking one of these also ticks the scope it needs and locks it until you untick the first; the backend refuses a token that has one without the other:


| Scope                                  | Needs                              |
|----------------------------------------|------------------------------------|
| **Activities — commit/write**          | **Activities — draft**             |
| **Asset classification — apply/write** | **Asset classification — suggest** |
| **Market data — write**                | **Holdings & value (read)**        |
| **Accounts — write**                   | **Accounts (read)**                |
| **Holdings — write**                   | **Holdings & value (read)**        |
| **Organize spending**                  | **View spending**                  |
| **Manage budgets**                     | **View spending**                  |


### Spending

With **View spending**, an agent can read your spending transactions, reports, insights, events, and budgets. It can also list your categorization rules, with where each came from (yours, a preset, or an add-on), and preview them. **Organize spending** lets it organize categories, rules, presets, splits, events, and tags, and re-run your rules on your spending accounts. **Manage budgets** lets it manage budgets. Changes are shown for review before they’re saved, and manual categories are never changed.

### Prices and assets

With **Holdings & value (read)**, an agent can look up one asset’s market data setup: its listing, quote currency, pricing mode, preferred provider, latest price, last sync, and the accounts that hold it. It can also read the stored price history and exchange rates, and list your market data providers. Custom providers show without their URLs or headers, since those can hold API keys. **Health (read)** gives it each Health Center issue with the assets, accounts, and dates involved.

**Market data — write** lets it act on what it finds:

- **Refresh prices**: the latest prices (the app’s **Update prices**), the last few days, or the full history (the app’s **Refresh full history**, or **Refetch price history** for one asset). It can also replace an asset’s stored history with a fresh copy from its provider. Prices you entered by hand and prices from a connected broker are kept.
- **Fix an asset**: change its quote currency, pricing mode, symbol, exchange, or preferred provider. The preview asks the provider for a price first, and blocks the change if the listing isn’t found or quotes in another currency. It also shows every account that holds the asset. When the listing, currency, or provider changes, saving also replaces the old provider history, so prices in the old currency don’t stay. Transactions, quantities, and costs never change.

Agents can choose any provider you’ve enabled, including a custom one you set up, but can’t add or configure providers.

### Accounts, holdings, and liabilities

**Accounts — write** lets an agent create the accounts it imports into, and update an account’s name, type, group, number, tracking mode, and hidden or archived state. An account’s currency can’t change after it’s created, and there’s no delete. The preview flags an account with the same name, so a retried request doesn’t create a second one.

**Holdings — write** lets it:

- **Save a holdings snapshot**: the positions and cash on a date, for accounts that track holdings (not transactions) and aren’t connected to a broker. A snapshot replaces that date’s positions, and the preview lists what’s added, changed, and removed. Cash left out is carried forward, never zeroed.
- **Add an alternative asset or liability**: a property, vehicle, collectible, precious metal, private equity holding, other asset, or a liability such as a mortgage. Later values and balances go through **Market data — write**, many dates in one go. Loans with an interest rate and payment schedule are set up in the app.

### Presets

The dialog’s **Access presets** set the scopes in one click:


| Preset | Scopes |
|----|----|
| **Read-only** | Every read scope, including **View spending**. New tokens start here. |
| **Read + draft** | Read-only plus **Activities — draft**. |
| **Read + write** | Read + draft plus **Activities — commit/write**. |
| **Read + activity write + asset classification** | Read + write plus **Asset classification — suggest** and **Asset classification — apply/write**. |
| **Spending — view** | **View spending** only. |
| **Spending — organize** | **View spending** and **Organize spending**. |
| **Spending — budgets** | **View spending** and **Manage budgets**. |


No preset includes **Market data — write**, **Accounts — write**, or **Holdings — write**; tick them yourself. In the token list, a token whose scopes match a preset shows that preset’s name; any other token shows as **Custom** with its number of scopes.


**Grant the narrowest scopes you’re comfortable with.** A read-only token can never modify your data. Only add write scopes for agents you trust to change activities, spending, or budgets, and prefer a short expiry for those.


**Upgrading from 3.11.** Existing tokens keep exactly the permissions they had. Spending tools now need the spending scopes, so an agent that used the categorization tools needs **View spending** added, plus **Organize spending** to make changes. Use **Edit permissions** – you don’t need a new token – then reconnect the agent so it picks up the new tools. A token made with the Read-only preset now shows as **Custom**, because Read-only now includes View spending; add View spending to make it Read-only again. A token with **Activities — commit/write** can now also delete activities or mark them void; remove that scope from tokens that shouldn’t.


**Upgrading from 3.12.** A token with **Market data — write** can now also refresh prices and change an asset’s listing, currency, or provider; remove that scope from tokens that should only save prices. Account and holdings changes need the new **Accounts — write** and **Holdings — write** scopes, which existing tokens don’t have. Add them with **Edit permissions**, then reconnect the agent.


------------------------------------------------------------------------

## 4 · Connect a client

Wealthfolio speaks **Streamable HTTP** MCP. The server card’s **Copy config** button copies the Claude Code command below with `YOUR_TOKEN` as a placeholder. Its help (?) button and the token dialog have a **Claude Code**, **Codex / ChatGPT** and **Other** tab with the snippet for each app; the token dialog fills in your new token. Replace `PORT` with the port shown on the server card (self-hosted users use their server’s URL) and `YOUR_TOKEN` with the token you copied.

Wealthfolio labels each tool as read-only or as a write, and marks the writes that change or remove existing data. Clients use these labels to decide when to ask you first: Codex, for example, runs read tools without asking and asks before tools that change existing data. Draft and suggest tools count as read-only: they return a preview and save nothing.

### Claude Code and Claude Desktop (Code tab)

Run this in a terminal:

``` mb-4
claude mcp add --scope user --transport http wealthfolio http://127.0.0.1:PORT/mcp --header "Authorization: Bearer YOUR_TOKEN"
```

`--scope user` adds Wealthfolio for all your projects (Claude Code keeps it in `~/.claude.json`). The **Code** tab in Claude Desktop runs Claude Code, so it picks up the same server. Run `claude mcp list`, or `/mcp` in a session, to check the connection.


**The Claude Desktop chat tab can’t use this server.** Its `claude_desktop_config.json` only loads servers it starts as a local command, so an HTTP entry there is skipped. Use the Code tab instead. See <a href="#use-your-claude-or-chatgpt-subscription" class="font-medium underline underline-offset-4">Use your Claude or ChatGPT subscription</a> for what else can and can’t connect.


To share the server with one project instead, add a `.mcp.json` at the project root. It reads the token from the `WEALTHFOLIO_TOKEN` environment variable, so the file holds no secret and is safe to commit:

``` mb-4
{
  "mcpServers": {
    "wealthfolio": {
      "type": "http",
      "url": "http://127.0.0.1:PORT/mcp",
      "headers": { "Authorization": "Bearer ${WEALTHFOLIO_TOKEN}" }
    }
  }
}
```

Set `WEALTHFOLIO_TOKEN` in the shell that starts Claude Code. Claude Code asks you to approve a project’s servers the first time it uses them.

### Codex and the ChatGPT desktop app

The Codex CLI, the Codex IDE extension, and the ChatGPT desktop app share one config file, `~/.codex/config.toml`. Add:

``` mb-4
[mcp_servers.wealthfolio]
url = "http://127.0.0.1:PORT/mcp"
http_headers = { Authorization = "Bearer YOUR_TOKEN" }
tool_timeout_sec = 120
```

To keep the token out of the file, remove `Authorization` from `http_headers` and add `bearer_token_env_var = "WEALTHFOLIO_TOKEN"` instead. Codex then reads the token from that environment variable. Run `codex mcp list` to check the server is configured.

### Other apps

The app’s **Other** tab has a snippet for each of these. Cursor, Windsurf, Cline and Unsloth Studio share one config shape:

``` mb-4
{
  "mcpServers": {
    "wealthfolio": {
      "type": "http",
      "url": "http://127.0.0.1:PORT/mcp",
      "headers": { "Authorization": "Bearer YOUR_TOKEN" }
    }
  }
}
```

**LM Studio** uses the same shape without the `"type"` line.

**VS Code** differs – it uses a top-level `servers` key:

``` mb-4
{
  "servers": {
    "wealthfolio": {
      "type": "http",
      "url": "http://127.0.0.1:PORT/mcp",
      "headers": { "Authorization": "Bearer YOUR_TOKEN" }
    }
  }
}
```

**OpenCode** uses its own `mcp` key. `"oauth": false` stops it from starting an OAuth flow for this server:

``` mb-4
{
  "mcp": {
    "wealthfolio": {
      "type": "remote",
      "url": "http://127.0.0.1:PORT/mcp",
      "oauth": false,
      "headers": { "Authorization": "Bearer YOUR_TOKEN" }
    }
  }
}
```

**Jan** has its own format too; pick Jan in the app’s **Other** tab to copy it. Any other client that speaks Streamable HTTP just needs the URL plus an `Authorization: Bearer YOUR_TOKEN` header.

### Where the config goes


| Client | Config location |
|----|----|
| **Claude Code / Claude Desktop (Code)** | `claude mcp add --scope user …` (`~/.claude.json`), or `.mcp.json` in a project |
| **Codex / ChatGPT desktop** | `~/.codex/config.toml` |
| **Cursor** | `~/.cursor/mcp.json` (or `.cursor/mcp.json` in a project) |
| **VS Code** | `.vscode/mcp.json` |
| **Windsurf** | `~/.codeium/windsurf/mcp_config.json` |
| **Cline** | Cline → MCP Servers → Configure (`cline_mcp_settings.json`) |
| **OpenCode** | `opencode.json` in a project, or `~/.config/opencode/opencode.json` |
| **Jan** | Settings → MCP Servers → Add |
| **LM Studio** | Program → Install → Edit `mcp.json` |
| **Unsloth Studio** | In a chat: **+** → MCP servers |


On a self-hosted server with several profiles, the snippets the app gives you also carry an `X-WF-Profile-Id` header for the profile you’re signed in to. Keep it; without it the server uses the default profile.

Once connected, the agent discovers Wealthfolio’s tools automatically. Ask it “what are my top holdings?” or “how did my portfolio do this year?” and it’ll call the read tools and answer with your real numbers.

### Use your Claude or ChatGPT subscription

Claude Code (in a terminal, an IDE, or Claude Desktop’s Code tab) signs in with your Claude plan, and Codex (CLI, IDE extension, or the ChatGPT desktop app) signs in with your ChatGPT plan. Connected to Wealthfolio, they use that plan: you don’t need an API key.

Some Claude apps can’t reach a local Wealthfolio:

- **claude.ai and the Claude mobile apps** connect to MCP servers from Anthropic’s cloud, which can’t see `127.0.0.1` on your computer.
- **The Claude Desktop chat tab** only starts local command servers, not HTTP ones (see above).

The community <a href="https://www.npmjs.com/package/mcp-remote" class="font-medium underline underline-offset-4"><code>mcp-remote</code></a> package can wrap an HTTP server as a local command for the Claude Desktop chat tab. It needs Node.js, and Wealthfolio doesn’t test or support it.

The in-app <a href="/docs/guide/ai-assistant/" class="font-medium underline underline-offset-4">AI Assistant</a> is different: it calls a model provider directly, so it needs an API key or a local model.

------------------------------------------------------------------------

## 5 · Audit log

Every tool call an agent makes is recorded under **Agent activity** – the time, the tool name, the outcome (**Success**, **Denied**, or **Error**), and which token made the call. Filter by tool or outcome, search, and **Clear log** when you want a clean slate.

On desktop, the **Log agent activity** switch turns recording on or off. On a self-hosted server it’s controlled by an environment variable (below). With logging off, no new audit rows are written.

------------------------------------------------------------------------

## 6 · Self-hosted servers

On a <a href="/docs/guide/self-hosting/" class="font-medium underline underline-offset-4">self-hosted</a> Wealthfolio server the MCP endpoint is off by default and enabled with environment variables:


| Variable | Effect |
|----|----|
| `WF_MCP_ENABLED=true` | Serves the MCP endpoint at `/mcp`. Restart the server after setting it. |
| `WF_MCP_AUDIT_ENABLED` | Audit logging of agent tool calls. On by default; set to `false` to stop writing audit rows. |


After enabling, create tokens from **Settings → AI agent access** exactly as on desktop. The `url` in your client config is your server’s origin plus `/mcp` (for example `https://wealth.example.com/mcp`).


**Self-hosted MCP requires Wealthfolio auth.** On Docker, Unraid, and other network-accessible server installs, `WF_MCP_ENABLED=true` requires Wealthfolio’s own authentication to be configured with `WF_AUTH_PASSWORD_HASH` or OIDC. If you run the app with `WF_AUTH_REQUIRED=false` because a reverse proxy handles login, the server will refuse to start with MCP enabled.

You can still keep your reverse proxy in front, but leave Wealthfolio auth enabled too. MCP tokens are created through the app’s Agent Access API; reverse-proxy-only auth cannot currently replace that app-level protection.


A self-hosted MCP endpoint is reachable by anything that can hit your server. Put it behind your usual auth/<a href="/docs/guide/self-hosting/reverse-proxy/" class="font-medium underline underline-offset-4">reverse proxy</a>, keep tokens scoped and short-lived, and remove tokens you no longer use.


------------------------------------------------------------------------

## 7 · Security model

- **Nothing is exposed by default.** The server is off until you enable it, and it serves nothing without a valid token.
- **Local-only on desktop.** The desktop server binds to `127.0.0.1` – it isn’t reachable from other machines on your network.
- **Scoped and revocable.** Each token carries only the scopes you granted. **Remove** a token and any client using it loses access immediately.
- **Writes are gated.** Committing an activity requires *both* the draft and write scopes; a draft-only token can stage changes but never commit them.
- **Stopping ≠ revoking.** Stopping the server (or disabling the feature on desktop) keeps your tokens valid – they resume working when you start it again. To cut a client off for good, delete its token.
- **Typed tools, not raw SQL.** Agents call the same scoped, typed tools as the AI Assistant. They never receive your database or your other API keys.

------------------------------------------------------------------------

## 8 · Troubleshooting

### The client can’t connect

- Make sure the server is **running** (green dot on the server card, or `WF_MCP_ENABLED=true` and a restart on self-hosted).
- Check the `url` and `PORT` match what’s on the server card, and that the path ends in `/mcp`.
- Confirm the `Authorization` header is `Bearer <token>` with a valid, unexpired token.

### The container won’t start after setting `WF_MCP_ENABLED=true`

On self-hosted installs that bind to the network, MCP requires Wealthfolio auth. If you set `WF_AUTH_REQUIRED=false` and rely only on a reverse proxy for login, the server refuses to start because the Agent Access API can mint long-lived MCP tokens.

Fix it by configuring `WF_AUTH_PASSWORD_HASH` or OIDC, then restart with `WF_MCP_ENABLED=true`. If you don’t want Wealthfolio auth enabled, leave `WF_MCP_ENABLED=false`.

### The agent says a tool was “denied”

The token is missing the scope for that tool. Click **Edit permissions** on the token in **Settings → AI agent access**, add the scope you need (or pick the right preset), and save. Then refresh the tools in your client or reconnect it.

### The agent doesn’t see a tool

The client only lists tools the token’s scopes allow. Add the scope with **Edit permissions**, then refresh the tools in your client or reconnect it – a client that’s already connected doesn’t pick up newly granted tools on its own. Spending and budget tools need **View spending**, **Organize spending**, or **Manage budgets**.

### It worked yesterday, not today

Check whether the token **expired** (see its status in the token list) or was removed. On desktop, also confirm the server is started and, if you rely on it, that **auto-start** is on.

------------------------------------------------------------------------

## Frequently asked questions

### Does Wealthfolio have a built-in MCP server?

Yes. Wealthfolio ships a native Model Context Protocol server – there’s no third-party bridge to install. Turn it on under **Settings → AI agent access**, mint a scoped token, and point any MCP client at it. On the desktop app it runs locally at `http://127.0.0.1:<port>/mcp`; on a self-hosted server it’s served at `/mcp` on your own origin.

### Which MCP clients work with Wealthfolio?

Any MCP client that speaks Streamable HTTP, including Claude Code (and Claude Desktop’s Code tab), Codex, the ChatGPT desktop app, Cursor, Windsurf, Cline, and the VS Code MCP integration. The Claude Desktop chat tab, claude.ai, and the Claude mobile apps can’t reach a local Wealthfolio; see <a href="#use-your-claude-or-chatgpt-subscription" class="font-medium underline underline-offset-4">Use your Claude or ChatGPT subscription</a>.

### Is the Wealthfolio MCP server safe?

Access is off until you enable it, and every connection uses a **scoped, revocable access token** you create yourself. Agents reach your data only through the same typed tool registry the in-app <a href="/docs/guide/ai-assistant/" class="font-medium underline underline-offset-4">AI Assistant</a> uses – never your raw database – and every call is recorded in an audit log you can review.

------------------------------------------------------------------------

**Next step:** If you’d rather chat with your portfolio from inside the app instead of wiring up an external agent, see the <a href="/docs/guide/ai-assistant/" class="font-medium underline underline-offset-4">AI Assistant</a>.


<a href="/docs/guide/ai-assistant/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">AI Assistant</a> <a href="/docs/guide/mobile/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Mobile</a>


On this page

- <a href="#1--where-it-lives" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">1 · Where it lives</a>
- <a href="#2--turn-it-on-and-create-a-token" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">2 · Turn it on and create a token</a>
  - <a href="#change-a-tokens-permissions" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Change a token's permissions</a>
- <a href="#3--scopes--what-a-token-can-do" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">3 · Scopes – what a token can do</a>
  - <a href="#read-access" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Read access</a>
  - <a href="#write-access" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Write access</a>
  - <a href="#spending" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Spending</a>
  - <a href="#prices-and-assets" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Prices and assets</a>
  - <a href="#accounts-holdings-and-liabilities" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Accounts, holdings, and liabilities</a>
  - <a href="#presets" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Presets</a>
- <a href="#4--connect-a-client" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">4 · Connect a client</a>
  - <a href="#claude-code-and-claude-desktop-code-tab" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Claude Code and Claude Desktop (Code tab)</a>
  - <a href="#codex-and-the-chatgpt-desktop-app" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Codex and the ChatGPT desktop app</a>
  - <a href="#other-apps" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Other apps</a>
  - <a href="#where-the-config-goes" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Where the config goes</a>
  - <a href="#use-your-claude-or-chatgpt-subscription" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Use your Claude or ChatGPT subscription</a>
- <a href="#5--audit-log" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">5 · Audit log</a>
- <a href="#6--self-hosted-servers" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">6 · Self-hosted servers</a>
- <a href="#7--security-model" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">7 · Security model</a>
- <a href="#8--troubleshooting" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">8 · Troubleshooting</a>
  - <a href="#the-client-cant-connect" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">The client can't connect</a>
  - <a href="#the-container-wont-start-after-setting-wf_mcp_enabledtrue" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">The container won't start after setting WF_MCP_ENABLED=true</a>
  - <a href="#the-agent-says-a-tool-was-denied" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">The agent says a tool was "denied"</a>
  - <a href="#the-agent-doesnt-see-a-tool" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">The agent doesn't see a tool</a>
  - <a href="#it-worked-yesterday-not-today" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">It worked yesterday, not today</a>
- <a href="#frequently-asked-questions" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Frequently asked questions</a>
  - <a href="#does-wealthfolio-have-a-built-in-mcp-server" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Does Wealthfolio have a built-in MCP server?</a>
  - <a href="#which-mcp-clients-work-with-wealthfolio" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Which MCP clients work with Wealthfolio?</a>
  - <a href="#is-the-wealthfolio-mcp-server-safe" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Is the Wealthfolio MCP server safe?</a>


