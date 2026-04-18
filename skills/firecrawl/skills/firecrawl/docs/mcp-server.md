[Skip to main content](https://docs.firecrawl.dev/mcp-server#content-area)

[Firecrawl Docs home page![light logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=c45b3c967c19a39190e76fe8e9c2ed5a)![dark logo](https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&auto=format&n=iilnMwCX-8eR1yOO&q=85&s=3fee4abe033bd3c26e8ad92043a91c17)](https://firecrawl.dev/)

v2
![US](https://d3gk2c5xim1je2.cloudfront.net/flags/US.svg)

English

Search...

Ctrl K

Search...

Navigation

Get Started

Firecrawl MCP Server

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

- [Features](https://docs.firecrawl.dev/mcp-server#features)
- [Installation](https://docs.firecrawl.dev/mcp-server#installation)
- [Remote hosted URL](https://docs.firecrawl.dev/mcp-server#remote-hosted-url)
- [Running with npx](https://docs.firecrawl.dev/mcp-server#running-with-npx)
- [Manual Installation](https://docs.firecrawl.dev/mcp-server#manual-installation)
- [Running on Cursor](https://docs.firecrawl.dev/mcp-server#running-on-cursor)
- [Manual Installation](https://docs.firecrawl.dev/mcp-server#manual-installation-2)
- [Running on Windsurf](https://docs.firecrawl.dev/mcp-server#running-on-windsurf)
- [Running with Streamable HTTP Mode](https://docs.firecrawl.dev/mcp-server#running-with-streamable-http-mode)
- [Installing via Smithery (Legacy)](https://docs.firecrawl.dev/mcp-server#installing-via-smithery-legacy)
- [Running on VS Code](https://docs.firecrawl.dev/mcp-server#running-on-vs-code)
- [Running on Claude Desktop](https://docs.firecrawl.dev/mcp-server#running-on-claude-desktop)
- [Running on Claude Code](https://docs.firecrawl.dev/mcp-server#running-on-claude-code)
- [Running on Google Antigravity](https://docs.firecrawl.dev/mcp-server#running-on-google-antigravity)
- [Running on n8n](https://docs.firecrawl.dev/mcp-server#running-on-n8n)
- [Configuration](https://docs.firecrawl.dev/mcp-server#configuration)
- [Environment Variables](https://docs.firecrawl.dev/mcp-server#environment-variables)
- [Required for Cloud API](https://docs.firecrawl.dev/mcp-server#required-for-cloud-api)
- [Optional Configuration](https://docs.firecrawl.dev/mcp-server#optional-configuration)
- [Configuration Examples](https://docs.firecrawl.dev/mcp-server#configuration-examples)
- [Custom configuration with Claude Desktop](https://docs.firecrawl.dev/mcp-server#custom-configuration-with-claude-desktop)
- [System Configuration](https://docs.firecrawl.dev/mcp-server#system-configuration)
- [Rate Limiting and Batch Processing](https://docs.firecrawl.dev/mcp-server#rate-limiting-and-batch-processing)
- [Available Tools](https://docs.firecrawl.dev/mcp-server#available-tools)
- [1\. Scrape Tool (firecrawl\_scrape)](https://docs.firecrawl.dev/mcp-server#1-scrape-tool-firecrawl_scrape)
- [2\. Map Tool (firecrawl\_map)](https://docs.firecrawl.dev/mcp-server#2-map-tool-firecrawl_map)
- [Map Tool Options:](https://docs.firecrawl.dev/mcp-server#map-tool-options)
- [3\. Search Tool (firecrawl\_search)](https://docs.firecrawl.dev/mcp-server#3-search-tool-firecrawl_search)
- [Search Tool Options:](https://docs.firecrawl.dev/mcp-server#search-tool-options)
- [4\. Crawl Tool (firecrawl\_crawl)](https://docs.firecrawl.dev/mcp-server#4-crawl-tool-firecrawl_crawl)
- [5\. Check Crawl Status (firecrawl\_check\_crawl\_status)](https://docs.firecrawl.dev/mcp-server#5-check-crawl-status-firecrawl_check_crawl_status)
- [6\. Extract Tool (firecrawl\_extract)](https://docs.firecrawl.dev/mcp-server#6-extract-tool-firecrawl_extract)
- [Extract Tool Options:](https://docs.firecrawl.dev/mcp-server#extract-tool-options)
- [7\. Agent Tool (firecrawl\_agent)](https://docs.firecrawl.dev/mcp-server#7-agent-tool-firecrawl_agent)
- [Agent Tool Options:](https://docs.firecrawl.dev/mcp-server#agent-tool-options)
- [8\. Check Agent Status (firecrawl\_agent\_status)](https://docs.firecrawl.dev/mcp-server#8-check-agent-status-firecrawl_agent_status)
- [Agent Status Options:](https://docs.firecrawl.dev/mcp-server#agent-status-options)
- [9\. Create Browser Session (firecrawl\_browser\_create)](https://docs.firecrawl.dev/mcp-server#9-create-browser-session-firecrawl_browser_create)
- [Browser Create Options:](https://docs.firecrawl.dev/mcp-server#browser-create-options)
- [10\. Execute Code in Browser (firecrawl\_browser\_execute)](https://docs.firecrawl.dev/mcp-server#10-execute-code-in-browser-firecrawl_browser_execute)
- [Browser Execute Options:](https://docs.firecrawl.dev/mcp-server#browser-execute-options)
- [11\. Delete Browser Session (firecrawl\_browser\_delete)](https://docs.firecrawl.dev/mcp-server#11-delete-browser-session-firecrawl_browser_delete)
- [Browser Delete Options:](https://docs.firecrawl.dev/mcp-server#browser-delete-options)
- [12\. List Browser Sessions (firecrawl\_browser\_list)](https://docs.firecrawl.dev/mcp-server#12-list-browser-sessions-firecrawl_browser_list)
- [Browser List Options:](https://docs.firecrawl.dev/mcp-server#browser-list-options)
- [13\. Interact with Scraped Page (firecrawl\_interact)](https://docs.firecrawl.dev/mcp-server#13-interact-with-scraped-page-firecrawl_interact)
- [Interact Tool Options:](https://docs.firecrawl.dev/mcp-server#interact-tool-options)
- [14\. Stop Interact Session (firecrawl\_interact\_stop)](https://docs.firecrawl.dev/mcp-server#14-stop-interact-session-firecrawl_interact_stop)
- [Interact Stop Options:](https://docs.firecrawl.dev/mcp-server#interact-stop-options)
- [Logging System](https://docs.firecrawl.dev/mcp-server#logging-system)
- [Error Handling](https://docs.firecrawl.dev/mcp-server#error-handling)
- [Development](https://docs.firecrawl.dev/mcp-server#development)
- [Contributing](https://docs.firecrawl.dev/mcp-server#contributing)
- [Thanks to contributors](https://docs.firecrawl.dev/mcp-server#thanks-to-contributors)
- [License](https://docs.firecrawl.dev/mcp-server#license)

![Firecrawl](https://docs.firecrawl.dev/logo/light.svg)![Firecrawl](https://docs.firecrawl.dev/logo/dark.svg)

### Ready to build?

Start getting web data for free and scale seamlessly as your project expands. **No credit card needed.**

[Start for free](https://www.firecrawl.dev/signin?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=start_for_free) [See our plans](https://www.firecrawl.dev/pricing?utm_source=firecrawl_docs&utm_medium=docs_card&utm_content=see_our_plans)

A Model Context Protocol (MCP) server implementation that integrates [Firecrawl](https://github.com/firecrawl/firecrawl) for searching, scraping, and interacting with the web. Our MCP server is open-source and available on [GitHub](https://github.com/firecrawl/firecrawl-mcp-server).

## [​](https://docs.firecrawl.dev/mcp-server\#features)  Features

- Search the web and get full page content
- Scrape any URL into clean, structured data
- Interact with pages — click, navigate, and operate
- Deep research with autonomous agent
- Browser session management
- Cloud and self-hosted support
- Streamable HTTP support

## [​](https://docs.firecrawl.dev/mcp-server\#installation)  Installation

You can either use our remote hosted URL or run the server locally. Get your API key from [https://firecrawl.dev/app/api-keys](https://www.firecrawl.dev/app/api-keys)

### [​](https://docs.firecrawl.dev/mcp-server\#remote-hosted-url)  Remote hosted URL

```
https://mcp.firecrawl.dev/{FIRECRAWL_API_KEY}/v2/mcp
```

### [​](https://docs.firecrawl.dev/mcp-server\#running-with-npx)  Running with npx

```
env FIRECRAWL_API_KEY=fc-YOUR_API_KEY npx -y firecrawl-mcp
```

### [​](https://docs.firecrawl.dev/mcp-server\#manual-installation)  Manual Installation

```
npm install -g firecrawl-mcp
```

### [​](https://docs.firecrawl.dev/mcp-server\#running-on-cursor)  Running on Cursor

[![Add Firecrawl MCP server to Cursor](https://cursor.com/deeplink/mcp-install-dark.png)](cursor://anysphere.cursor-deeplink/mcp/install?name=firecrawl&config=eyJjb21tYW5kIjoibnB4IiwiYXJncyI6WyIteSIsImZpcmVjcmF3bC1tY3AiXSwiZW52Ijp7IkZJUkVDUkFXTF9BUElfS0VZIjoiWU9VUi1BUEktS0VZIn19)

#### [​](https://docs.firecrawl.dev/mcp-server\#manual-installation-2)  Manual Installation

Configuring Cursor 🖥️
Note: Requires Cursor version 0.45.6+
For the most up-to-date configuration instructions, please refer to the official Cursor documentation on configuring MCP servers:
[Cursor MCP Server Configuration Guide](https://docs.cursor.com/context/model-context-protocol#configuring-mcp-servers)To configure Firecrawl MCP in Cursor **v0.48.6**

1. Open Cursor Settings
2. Go to Features > MCP Servers
3. Click ”+ Add new global MCP server”
4. Enter the following code:















```
{
     "mcpServers": {
       "firecrawl-mcp": {
         "command": "npx",
         "args": ["-y", "firecrawl-mcp"],
         "env": {
           "FIRECRAWL_API_KEY": "YOUR-API-KEY"
         }
       }
     }
}
```


To configure Firecrawl MCP in Cursor **v0.45.6**

1. Open Cursor Settings
2. Go to Features > MCP Servers
3. Click ”+ Add New MCP Server”
4. Enter the following:
   - Name: “firecrawl-mcp” (or your preferred name)
   - Type: “command”
   - Command: `env FIRECRAWL_API_KEY=your-api-key npx -y firecrawl-mcp`

> If you are using Windows and are running into issues, try `cmd /c "set FIRECRAWL_API_KEY=your-api-key && npx -y firecrawl-mcp"`

Replace `your-api-key` with your Firecrawl API key. If you don’t have one yet, you can create an account and get it from [https://www.firecrawl.dev/app/api-keys](https://www.firecrawl.dev/app/api-keys)After adding, refresh the MCP server list to see the new tools. The Composer Agent will automatically use Firecrawl MCP when appropriate, but you can explicitly request it by describing your web data needs. Access the Composer via Command+L (Mac), select “Agent” next to the submit button, and enter your query.

### [​](https://docs.firecrawl.dev/mcp-server\#running-on-windsurf)  Running on Windsurf

Add this to your `./codeium/windsurf/model_config.json`:

```
{
  "mcpServers": {
    "mcp-server-firecrawl": {
      "command": "npx",
      "args": ["-y", "firecrawl-mcp"],
      "env": {
        "FIRECRAWL_API_KEY": "YOUR_API_KEY"
      }
    }
  }
}
```

### [​](https://docs.firecrawl.dev/mcp-server\#running-with-streamable-http-mode)  Running with Streamable HTTP Mode

To run the server using streamable HTTP transport locally instead of the default stdio transport:

```
env HTTP_STREAMABLE_SERVER=true FIRECRAWL_API_KEY=fc-YOUR_API_KEY npx -y firecrawl-mcp
```

Use the url: [http://localhost:3000/v2/mcp](http://localhost:3000/v2/mcp) or [https://mcp.firecrawl.dev/{FIRECRAWL\_API\_KEY}/v2/mcp](https://mcp.firecrawl.dev/%7BFIRECRAWL_API_KEY%7D/v2/mcp)

### [​](https://docs.firecrawl.dev/mcp-server\#installing-via-smithery-legacy)  Installing via Smithery (Legacy)

To install Firecrawl for Claude Desktop automatically via [Smithery](https://smithery.ai/server/@mendableai/mcp-server-firecrawl):

```
npx -y @smithery/cli install @mendableai/mcp-server-firecrawl --client claude
```

### [​](https://docs.firecrawl.dev/mcp-server\#running-on-vs-code)  Running on VS Code

For one-click installation, click one of the install buttons below…[![Install with NPX in VS Code](https://img.shields.io/badge/VS_Code-NPM-0098FF?style=flat-square&logo=visualstudiocode&logoColor=white)](https://insiders.vscode.dev/redirect/mcp/install?name=firecrawl&inputs=%5B%7B%22type%22%3A%22promptString%22%2C%22id%22%3A%22apiKey%22%2C%22description%22%3A%22Firecrawl%20API%20Key%22%2C%22password%22%3Atrue%7D%5D&config=%7B%22command%22%3A%22npx%22%2C%22args%22%3A%5B%22-y%22%2C%22firecrawl-mcp%22%5D%2C%22env%22%3A%7B%22FIRECRAWL_API_KEY%22%3A%22%24%7Binput%3AapiKey%7D%22%7D%7D)[![Install with NPX in VS Code Insiders](https://img.shields.io/badge/VS_Code_Insiders-NPM-24bfa5?style=flat-square&logo=visualstudiocode&logoColor=white)](https://insiders.vscode.dev/redirect/mcp/install?name=firecrawl&inputs=%5B%7B%22type%22%3A%22promptString%22%2C%22id%22%3A%22apiKey%22%2C%22description%22%3A%22Firecrawl%20API%20Key%22%2C%22password%22%3Atrue%7D%5D&config=%7B%22command%22%3A%22npx%22%2C%22args%22%3A%5B%22-y%22%2C%22firecrawl-mcp%22%5D%2C%22env%22%3A%7B%22FIRECRAWL_API_KEY%22%3A%22%24%7Binput%3AapiKey%7D%22%7D%7D&quality=insiders)For manual installation, add the following JSON block to your User Settings (JSON) file in VS Code. You can do this by pressing `Ctrl + Shift + P` and typing `Preferences: Open User Settings (JSON)`.

```
{
  "mcp": {
    "inputs": [\
      {\
        "type": "promptString",\
        "id": "apiKey",\
        "description": "Firecrawl API Key",\
        "password": true\
      }\
    ],
    "servers": {
      "firecrawl": {
        "command": "npx",
        "args": ["-y", "firecrawl-mcp"],
        "env": {
          "FIRECRAWL_API_KEY": "${input:apiKey}"
        }
      }
    }
  }
}
```

Optionally, you can add it to a file called `.vscode/mcp.json` in your workspace. This will allow you to share the configuration with others:

```
{
  "inputs": [\
    {\
      "type": "promptString",\
      "id": "apiKey",\
      "description": "Firecrawl API Key",\
      "password": true\
    }\
  ],
  "servers": {
    "firecrawl": {
      "command": "npx",
      "args": ["-y", "firecrawl-mcp"],
      "env": {
        "FIRECRAWL_API_KEY": "${input:apiKey}"
      }
    }
  }
}
```

**Note:** Some users have reported issues when adding the MCP server to VS Code due to how it validates JSON with an outdated schema format ( [microsoft/vscode#155379](https://github.com/microsoft/vscode/issues/155379)).
This affects several MCP tools, including Firecrawl.**Workaround:** Disable JSON validation in VS Code to allow the MCP server to load properly.

See reference: [directus/directus#25906 (comment)](https://github.com/directus/directus/issues/25906#issuecomment-3369169513).The MCP server still works fine when invoked via other extensions, but the issue occurs specifically when registering it directly in the MCP server list. We plan to add guidance once VS Code updates their schema validation.

### [​](https://docs.firecrawl.dev/mcp-server\#running-on-claude-desktop)  Running on Claude Desktop

Add this to the Claude config file:

```
{
  "mcpServers": {
    "firecrawl": {
      "url": "https://mcp.firecrawl.dev/v2/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_API_KEY"
      }
    }
  }
}
```

If you get a “Couldn’t reach the MCP server” error, your Claude Desktop version may not support streamable HTTP transport. Use the local npx approach instead (requires [Node.js](https://nodejs.org/)):

```
{
  "mcpServers": {
    "firecrawl": {
      "command": "npx",
      "args": ["-y", "firecrawl-mcp"],
      "env": {
        "FIRECRAWL_API_KEY": "YOUR_API_KEY"
      }
    }
  }
}
```

If you see a `spawn npx ENOENT` error, Node.js is not installed or not in your system PATH. Install Node.js from [nodejs.org](https://nodejs.org/) (LTS version), then fully restart Claude Desktop. On Windows, you can also run `where npx` in Command Prompt and use the full path (e.g. `C:\\Program Files\\nodejs\\npx.cmd`) as the `command` value.

### [​](https://docs.firecrawl.dev/mcp-server\#running-on-claude-code)  Running on Claude Code

Add the Firecrawl MCP server using the Claude Code CLI. You can use the remote hosted URL or run locally:

```
# Remote hosted URL (recommended)
claude mcp add firecrawl --url https://mcp.firecrawl.dev/your-api-key/v2/mcp

# Or run locally via npx
claude mcp add firecrawl -e FIRECRAWL_API_KEY=your-api-key -- npx -y firecrawl-mcp
```

### [​](https://docs.firecrawl.dev/mcp-server\#running-on-google-antigravity)  Running on Google Antigravity

Google Antigravity allows you to configure MCP servers directly through its Agent interface.![Antigravity MCP Installation](https://mintcdn.com/firecrawl/rxzXygFiVc0TDh5X/images/guides/mcp/antigravity-mcp-installation.gif?s=19297c26dad5ed191862571618ce8c0a)

1. Open the Agent sidebar in the Editor or the Agent Manager view
2. Click the ”…” (More Actions) menu and select **MCP Servers**
3. Select **View raw config** to open your local `mcp_config.json` file
4. Add the following configuration:

```
{
  "mcpServers": {
    "firecrawl": {
      "command": "npx",
      "args": ["-y", "firecrawl-mcp"],
      "env": {
        "FIRECRAWL_API_KEY": "YOUR_FIRECRAWL_API_KEY"
      }
    }
  }
}
```

5. Save the file and click **Refresh** in the Antigravity MCP interface to see the new tools

Replace `YOUR_FIRECRAWL_API_KEY` with your API key from [https://firecrawl.dev/app/api-keys](https://www.firecrawl.dev/app/api-keys).

### [​](https://docs.firecrawl.dev/mcp-server\#running-on-n8n)  Running on n8n

To connect the Firecrawl MCP server in n8n:

1. Get your Firecrawl API key from [https://firecrawl.dev/app/api-keys](https://www.firecrawl.dev/app/api-keys)
2. In your n8n workflow, add an **AI Agent** node
3. In the AI Agent configuration, add a new **Tool**
4. Select **MCP Client Tool** as the tool type
5. Enter the MCP server Endpoint (replace `{YOUR_FIRECRAWL_API_KEY}` with your actual API key):

```
https://mcp.firecrawl.dev/{YOUR_FIRECRAWL_API_KEY}/v2/mcp
```

6. Set **Server Transport** to **HTTP Streamable**
7. Set **Authentication** to **None**
8. For **Tools to include**, you can select **All**, **Selected**, or **All Except** \- this will expose the Firecrawl tools (scrape, crawl, map, search, extract, etc.)

For self-hosted deployments, run the MCP server with npx and enable HTTP transport mode:

```
env HTTP_STREAMABLE_SERVER=true \
    FIRECRAWL_API_KEY=fc-YOUR_API_KEY \
    FIRECRAWL_API_URL=YOUR_FIRECRAWL_INSTANCE \
    npx -y firecrawl-mcp
```

This will start the server on `http://localhost:3000/v2/mcp` which you can use in your n8n workflow as Endpoint. The `HTTP_STREAMABLE_SERVER=true` environment variable is required since n8n needs HTTP transport.

## [​](https://docs.firecrawl.dev/mcp-server\#configuration)  Configuration

### [​](https://docs.firecrawl.dev/mcp-server\#environment-variables)  Environment Variables

#### [​](https://docs.firecrawl.dev/mcp-server\#required-for-cloud-api)  Required for Cloud API

- `FIRECRAWL_API_KEY`: Your Firecrawl API key

  - Required when using cloud API (default)
  - Optional when using self-hosted instance with `FIRECRAWL_API_URL`
- `FIRECRAWL_API_URL`(Optional): Custom API endpoint for self-hosted instances

  - Example: `https://firecrawl.your-domain.com`
  - If not provided, the cloud API will be used (requires API key)

#### [​](https://docs.firecrawl.dev/mcp-server\#optional-configuration)  Optional Configuration

##### Retry Configuration

- `FIRECRAWL_RETRY_MAX_ATTEMPTS`: Maximum number of retry attempts (default: 3)
- `FIRECRAWL_RETRY_INITIAL_DELAY`: Initial delay in milliseconds before first retry (default: 1000)
- `FIRECRAWL_RETRY_MAX_DELAY`: Maximum delay in milliseconds between retries (default: 10000)
- `FIRECRAWL_RETRY_BACKOFF_FACTOR`: Exponential backoff multiplier (default: 2)

##### Credit Usage Monitoring

- `FIRECRAWL_CREDIT_WARNING_THRESHOLD`: Credit usage warning threshold (default: 1000)
- `FIRECRAWL_CREDIT_CRITICAL_THRESHOLD`: Credit usage critical threshold (default: 100)

### [​](https://docs.firecrawl.dev/mcp-server\#configuration-examples)  Configuration Examples

For cloud API usage with custom retry and credit monitoring:

```
# Required for cloud API
export FIRECRAWL_API_KEY=your-api-key

# Optional retry configuration
export FIRECRAWL_RETRY_MAX_ATTEMPTS=5        # Increase max retry attempts
export FIRECRAWL_RETRY_INITIAL_DELAY=2000    # Start with 2s delay
export FIRECRAWL_RETRY_MAX_DELAY=30000       # Maximum 30s delay
export FIRECRAWL_RETRY_BACKOFF_FACTOR=3      # More aggressive backoff

# Optional credit monitoring
export FIRECRAWL_CREDIT_WARNING_THRESHOLD=2000    # Warning at 2000 credits
export FIRECRAWL_CREDIT_CRITICAL_THRESHOLD=500    # Critical at 500 credits
```

For self-hosted instance:

```
# Required for self-hosted
export FIRECRAWL_API_URL=https://firecrawl.your-domain.com

# Optional authentication for self-hosted
export FIRECRAWL_API_KEY=your-api-key  # If your instance requires auth

# Custom retry configuration
export FIRECRAWL_RETRY_MAX_ATTEMPTS=10
export FIRECRAWL_RETRY_INITIAL_DELAY=500     # Start with faster retries
```

### [​](https://docs.firecrawl.dev/mcp-server\#custom-configuration-with-claude-desktop)  Custom configuration with Claude Desktop

Add this to your `claude_desktop_config.json`:

```
{
  "mcpServers": {
    "mcp-server-firecrawl": {
      "command": "npx",
      "args": ["-y", "firecrawl-mcp"],
      "env": {
        "FIRECRAWL_API_KEY": "YOUR_API_KEY_HERE",

        "FIRECRAWL_RETRY_MAX_ATTEMPTS": "5",
        "FIRECRAWL_RETRY_INITIAL_DELAY": "2000",
        "FIRECRAWL_RETRY_MAX_DELAY": "30000",
        "FIRECRAWL_RETRY_BACKOFF_FACTOR": "3",

        "FIRECRAWL_CREDIT_WARNING_THRESHOLD": "2000",
        "FIRECRAWL_CREDIT_CRITICAL_THRESHOLD": "500"
      }
    }
  }
}
```

### [​](https://docs.firecrawl.dev/mcp-server\#system-configuration)  System Configuration

The server includes several configurable parameters that can be set via environment variables. Here are the default values if not configured:

```
const CONFIG = {
  retry: {
    maxAttempts: 3, // Number of retry attempts for rate-limited requests
    initialDelay: 1000, // Initial delay before first retry (in milliseconds)
    maxDelay: 10000, // Maximum delay between retries (in milliseconds)
    backoffFactor: 2, // Multiplier for exponential backoff
  },
  credit: {
    warningThreshold: 1000, // Warn when credit usage reaches this level
    criticalThreshold: 100, // Critical alert when credit usage reaches this level
  },
};
```

These configurations control:

1. **Retry Behavior**   - Automatically retries failed requests due to rate limits
   - Uses exponential backoff to avoid overwhelming the API
   - Example: With default settings, retries will be attempted at:
     - 1st retry: 1 second delay
     - 2nd retry: 2 seconds delay
     - 3rd retry: 4 seconds delay (capped at maxDelay)
2. **Credit Usage Monitoring**   - Tracks API credit consumption for cloud API usage
   - Provides warnings at specified thresholds
   - Helps prevent unexpected service interruption
   - Example: With default settings:
     - Warning at 1000 credits remaining
     - Critical alert at 100 credits remaining

### [​](https://docs.firecrawl.dev/mcp-server\#rate-limiting-and-batch-processing)  Rate Limiting and Batch Processing

The server utilizes Firecrawl’s built-in rate limiting and batch processing capabilities:

- Automatic rate limit handling with exponential backoff
- Efficient parallel processing for batch operations
- Smart request queuing and throttling
- Automatic retries for transient errors

## [​](https://docs.firecrawl.dev/mcp-server\#available-tools)  Available Tools

### [​](https://docs.firecrawl.dev/mcp-server\#1-scrape-tool-firecrawl_scrape)  1\. Scrape Tool (`firecrawl_scrape`)

Scrape content from a single URL with advanced options.

```
{
  "name": "firecrawl_scrape",
  "arguments": {
    "url": "https://example.com",
    "formats": ["markdown"],
    "onlyMainContent": true,
    "waitFor": 1000,
    "mobile": false,
    "includeTags": ["article", "main"],
    "excludeTags": ["nav", "footer"],
    "skipTlsVerification": false
  }
}
```

### [​](https://docs.firecrawl.dev/mcp-server\#2-map-tool-firecrawl_map)  2\. Map Tool (`firecrawl_map`)

Map a website to discover all indexed URLs on the site.

```
{
  "name": "firecrawl_map",
  "arguments": {
    "url": "https://example.com",
    "search": "blog",
    "sitemap": "include",
    "includeSubdomains": false,
    "limit": 100,
    "ignoreQueryParameters": true
  }
}
```

#### [​](https://docs.firecrawl.dev/mcp-server\#map-tool-options)  Map Tool Options:

- `url`: The base URL of the website to map
- `search`: Optional search term to filter URLs
- `sitemap`: Control sitemap usage - “include”, “skip”, or “only”
- `includeSubdomains`: Whether to include subdomains in the mapping
- `limit`: Maximum number of URLs to return
- `ignoreQueryParameters`: Whether to ignore query parameters when mapping

**Best for:** Discovering URLs on a website before deciding what to scrape; finding specific sections of a website.
**Returns:** Array of URLs found on the site.

### [​](https://docs.firecrawl.dev/mcp-server\#3-search-tool-firecrawl_search)  3\. Search Tool (`firecrawl_search`)

Search the web and optionally extract content from search results.

```
{
  "name": "firecrawl_search",
  "arguments": {
    "query": "your search query",
    "limit": 5,
    "location": "United States",
    "tbs": "qdr:m",
    "scrapeOptions": {
      "formats": ["markdown"],
      "onlyMainContent": true
    }
  }
}
```

#### [​](https://docs.firecrawl.dev/mcp-server\#search-tool-options)  Search Tool Options:

- `query`: The search query string (required)
- `limit`: Maximum number of results to return
- `location`: Geographic location for search results
- `tbs`: Time-based search filter (e.g., `qdr:d` for past day, `qdr:w` for past week, `qdr:m` for past month)
- `filter`: Additional search filter
- `sources`: Array of source types to search (`web`, `images`, `news`)
- `scrapeOptions`: Options for scraping search result pages
- `enterprise`: Array of enterprise options (`default`, `anon`, `zdr`)

### [​](https://docs.firecrawl.dev/mcp-server\#4-crawl-tool-firecrawl_crawl)  4\. Crawl Tool (`firecrawl_crawl`)

Start an asynchronous crawl with advanced options.

```
{
  "name": "firecrawl_crawl",
  "arguments": {
    "url": "https://example.com",
    "maxDiscoveryDepth": 2,
    "limit": 100,
    "allowExternalLinks": false,
    "deduplicateSimilarURLs": true
  }
}
```

### [​](https://docs.firecrawl.dev/mcp-server\#5-check-crawl-status-firecrawl_check_crawl_status)  5\. Check Crawl Status (`firecrawl_check_crawl_status`)

Check the status of a crawl job.

```
{
  "name": "firecrawl_check_crawl_status",
  "arguments": {
    "id": "550e8400-e29b-41d4-a716-446655440000"
  }
}
```

**Returns:** Status and progress of the crawl job, including results if available.

### [​](https://docs.firecrawl.dev/mcp-server\#6-extract-tool-firecrawl_extract)  6\. Extract Tool (`firecrawl_extract`)

Extract structured information from web pages using LLM capabilities. Supports both cloud AI and self-hosted LLM extraction.

```
{
  "name": "firecrawl_extract",
  "arguments": {
    "urls": ["https://example.com/page1", "https://example.com/page2"],
    "prompt": "Extract product information including name, price, and description",
    "schema": {
      "type": "object",
      "properties": {
        "name": { "type": "string" },
        "price": { "type": "number" },
        "description": { "type": "string" }
      },
      "required": ["name", "price"]
    },
    "allowExternalLinks": false,
    "enableWebSearch": false,
    "includeSubdomains": false
  }
}
```

Example response:

```
{
  "content": [\
    {\
      "type": "text",\
      "text": {\
        "name": "Example Product",\
        "price": 99.99,\
        "description": "This is an example product description"\
      }\
    }\
  ],
  "isError": false
}
```

#### [​](https://docs.firecrawl.dev/mcp-server\#extract-tool-options)  Extract Tool Options:

- `urls`: Array of URLs to extract information from
- `prompt`: Custom prompt for the LLM extraction
- `schema`: JSON schema for structured data extraction
- `allowExternalLinks`: Allow extraction from external links
- `enableWebSearch`: Enable web search for additional context
- `includeSubdomains`: Include subdomains in extraction

When using a self-hosted instance, the extraction will use your configured LLM. For cloud API, it uses Firecrawl’s managed LLM service.

### [​](https://docs.firecrawl.dev/mcp-server\#7-agent-tool-firecrawl_agent)  7\. Agent Tool (`firecrawl_agent`)

Autonomous web research agent that independently browses the internet, searches for information, navigates through pages, and extracts structured data based on your query. This runs asynchronously — it returns a job ID immediately, and you poll `firecrawl_agent_status` to check when complete and retrieve results.

```
{
  "name": "firecrawl_agent",
  "arguments": {
    "prompt": "Find the top 5 AI startups founded in 2024 and their funding amounts",
    "schema": {
      "type": "object",
      "properties": {
        "startups": {
          "type": "array",
          "items": {
            "type": "object",
            "properties": {
              "name": { "type": "string" },
              "funding": { "type": "string" },
              "founded": { "type": "string" }
            }
          }
        }
      }
    }
  }
}
```

You can also provide specific URLs for the agent to focus on:

```
{
  "name": "firecrawl_agent",
  "arguments": {
    "urls": ["https://docs.firecrawl.dev", "https://firecrawl.dev/pricing"],
    "prompt": "Compare the features and pricing information from these pages"
  }
}
```

#### [​](https://docs.firecrawl.dev/mcp-server\#agent-tool-options)  Agent Tool Options:

- `prompt`: Natural language description of the data you want (required, max 10,000 characters)
- `urls`: Optional array of URLs to focus the agent on specific pages
- `schema`: Optional JSON schema for structured output

**Best for:** Complex research tasks where you don’t know the exact URLs; multi-source data gathering; finding information scattered across the web; extracting data from JavaScript-heavy SPAs that fail with regular scrape.**Returns:** Job ID for status checking. Use `firecrawl_agent_status` to poll for results.

### [​](https://docs.firecrawl.dev/mcp-server\#8-check-agent-status-firecrawl_agent_status)  8\. Check Agent Status (`firecrawl_agent_status`)

Check the status of an agent job and retrieve results when complete. Poll every 15-30 seconds and keep polling for at least 2-3 minutes before considering the request failed.

```
{
  "name": "firecrawl_agent_status",
  "arguments": {
    "id": "550e8400-e29b-41d4-a716-446655440000"
  }
}
```

#### [​](https://docs.firecrawl.dev/mcp-server\#agent-status-options)  Agent Status Options:

- `id`: The agent job ID returned by `firecrawl_agent` (required)

**Possible statuses:**

- `processing`: Agent is still researching — keep polling
- `completed`: Research finished — response includes the extracted data
- `failed`: An error occurred

**Returns:** Status, progress, and results (if completed) of the agent job.

### [​](https://docs.firecrawl.dev/mcp-server\#9-create-browser-session-firecrawl_browser_create)  9\. Create Browser Session (`firecrawl_browser_create`)

Create a persistent browser session for code execution via CDP (Chrome DevTools Protocol).

```
{
  "name": "firecrawl_browser_create",
  "arguments": {
    "ttl": 120,
    "activityTtl": 60
  }
}
```

#### [​](https://docs.firecrawl.dev/mcp-server\#browser-create-options)  Browser Create Options:

- `ttl`: Total session lifetime in seconds (30-3600, optional)
- `activityTtl`: Idle timeout in seconds (10-3600, optional)

**Best for:** Running code (Python/JS) that interacts with a live browser page, multi-step browser automation, sessions with profiles that survive across multiple tool calls.**Returns:** Session ID, CDP URL, and live view URL.

### [​](https://docs.firecrawl.dev/mcp-server\#10-execute-code-in-browser-firecrawl_browser_execute)  10\. Execute Code in Browser (`firecrawl_browser_execute`)

Execute code in an active browser session. Supports agent-browser commands (bash), Python, or JavaScript.

```
{
  "name": "firecrawl_browser_execute",
  "arguments": {
    "sessionId": "session-id-here",
    "code": "agent-browser open https://example.com",
    "language": "bash"
  }
}
```

Python example with Playwright:

```
{
  "name": "firecrawl_browser_execute",
  "arguments": {
    "sessionId": "session-id-here",
    "code": "await page.goto('https://example.com')\ntitle = await page.title()\nprint(title)",
    "language": "python"
  }
}
```

#### [​](https://docs.firecrawl.dev/mcp-server\#browser-execute-options)  Browser Execute Options:

- `sessionId`: The browser session ID (required)
- `code`: The code to execute (required)
- `language`: `bash`, `python`, or `node` (optional, defaults to `bash`)

**Common agent-browser commands (bash):**

- `agent-browser open <url>` — Navigate to URL
- `agent-browser snapshot` — Get accessibility tree with clickable refs
- `agent-browser click @e5` — Click element by ref from snapshot
- `agent-browser type @e3 "text"` — Type into element
- `agent-browser screenshot [path]` — Take screenshot
- `agent-browser scroll down` — Scroll page
- `agent-browser wait 2000` — Wait 2 seconds

**Returns:** Execution result including stdout, stderr, and exit code.

### [​](https://docs.firecrawl.dev/mcp-server\#11-delete-browser-session-firecrawl_browser_delete)  11\. Delete Browser Session (`firecrawl_browser_delete`)

Destroy a browser session.

```
{
  "name": "firecrawl_browser_delete",
  "arguments": {
    "sessionId": "session-id-here"
  }
}
```

#### [​](https://docs.firecrawl.dev/mcp-server\#browser-delete-options)  Browser Delete Options:

- `sessionId`: The browser session ID to destroy (required)

**Returns:** Success confirmation.

### [​](https://docs.firecrawl.dev/mcp-server\#12-list-browser-sessions-firecrawl_browser_list)  12\. List Browser Sessions (`firecrawl_browser_list`)

List browser sessions, optionally filtered by status.

```
{
  "name": "firecrawl_browser_list",
  "arguments": {
    "status": "active"
  }
}
```

#### [​](https://docs.firecrawl.dev/mcp-server\#browser-list-options)  Browser List Options:

- `status`: Filter by session status — `active` or `destroyed` (optional)

**Returns:** Array of browser sessions.

### [​](https://docs.firecrawl.dev/mcp-server\#13-interact-with-scraped-page-firecrawl_interact)  13\. Interact with Scraped Page (`firecrawl_interact`)

Interact with a previously scraped page in a live browser session. Scrape a page first with `firecrawl_scrape`, then use the returned `scrapeId` (from the scrape response metadata) to click buttons, fill forms, extract dynamic content, or navigate deeper. The response includes a `liveViewUrl` and `interactiveLiveViewUrl` you can open in your browser to watch or control the session in real time.

```
{
  "name": "firecrawl_interact",
  "arguments": {
    "scrapeId": "scrape-id-from-previous-scrape",
    "prompt": "Click the Sign In button"
  }
}
```

#### [​](https://docs.firecrawl.dev/mcp-server\#interact-tool-options)  Interact Tool Options:

- `scrapeId`: The scrape job ID from a previous `firecrawl_scrape` call (required)
- `prompt`: Natural language instruction describing the action to take (provide `prompt` or `code`)
- `code`: Code to execute in the browser session (provide `code` or `prompt`)
- `language`: `bash`, `python`, or `node` (optional, defaults to `node`, only used with `code`)
- `timeout`: Execution timeout in seconds, 1–300 (optional, defaults to 30)

**Best for:** Multi-step workflows on a single page — searching a site, clicking through results, filling forms, extracting data that requires interaction.**Returns:** Interaction result including `liveViewUrl` and `interactiveLiveViewUrl`.

### [​](https://docs.firecrawl.dev/mcp-server\#14-stop-interact-session-firecrawl_interact_stop)  14\. Stop Interact Session (`firecrawl_interact_stop`)

Stop an interact session for a scraped page. Call this when you are done interacting to free resources.

```
{
  "name": "firecrawl_interact_stop",
  "arguments": {
    "scrapeId": "scrape-id-from-previous-scrape"
  }
}
```

#### [​](https://docs.firecrawl.dev/mcp-server\#interact-stop-options)  Interact Stop Options:

- `scrapeId`: The scrape ID for the session to stop (required)

**Returns:** Confirmation that the session has been stopped.

## [​](https://docs.firecrawl.dev/mcp-server\#logging-system)  Logging System

The server includes comprehensive logging:

- Operation status and progress
- Performance metrics
- Credit usage monitoring
- Rate limit tracking
- Error conditions

Example log messages:

```
[INFO] Firecrawl MCP Server initialized successfully
[INFO] Starting scrape for URL: https://example.com
[INFO] Starting crawl for URL: https://example.com
[WARNING] Credit usage has reached warning threshold
[ERROR] Rate limit exceeded, retrying in 2s...
```

## [​](https://docs.firecrawl.dev/mcp-server\#error-handling)  Error Handling

The server provides robust error handling:

- Automatic retries for transient errors
- Rate limit handling with backoff
- Detailed error messages
- Credit usage warnings
- Network resilience

Example error response:

```
{
  "content": [\
    {\
      "type": "text",\
      "text": "Error: Rate limit exceeded. Retrying in 2 seconds..."\
    }\
  ],
  "isError": true
}
```

## [​](https://docs.firecrawl.dev/mcp-server\#development)  Development

```
# Install dependencies
npm install

# Build
npm run build

# Run tests
npm test
```

### [​](https://docs.firecrawl.dev/mcp-server\#contributing)  Contributing

1. Fork the repository
2. Create your feature branch
3. Run tests: `npm test`
4. Submit a pull request

### [​](https://docs.firecrawl.dev/mcp-server\#thanks-to-contributors)  Thanks to contributors

Thanks to [@vrknetha](https://github.com/vrknetha), [@cawstudios](https://caw.tech/) for the initial implementation!Thanks to MCP.so and Klavis AI for hosting and [@gstarwd](https://github.com/gstarwd), [@xiangkaiz](https://github.com/xiangkaiz) and [@zihaolin96](https://github.com/zihaolin96) for integrating our server.

## [​](https://docs.firecrawl.dev/mcp-server\#license)  License

MIT License - see LICENSE file for details

[Suggest edits](https://github.com/firecrawl/firecrawl-docs/edit/main/mcp-server.mdx) [Raise issue](https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&body=Path:%20/mcp-server)

[Skill + CLI\\
\\
Previous](https://docs.firecrawl.dev/sdks/cli) [Advanced Scraping Guide\\
\\
Next](https://docs.firecrawl.dev/advanced-scraping-guide)

Ctrl+I

![Add Firecrawl MCP server to Cursor](https://cursor.com/deeplink/mcp-install-dark.png)

![Antigravity MCP Installation](https://mintcdn.com/firecrawl/rxzXygFiVc0TDh5X/images/guides/mcp/antigravity-mcp-installation.gif?s=19297c26dad5ed191862571618ce8c0a)

Chat Widget

Loading...