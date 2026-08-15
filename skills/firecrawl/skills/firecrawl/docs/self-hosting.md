> Source: https://docs.firecrawl.dev/contributing/self-host



> ## Documentation Index
>
> Fetch the complete documentation index at: <a href="/llms.txt" tabindex="-1">/llms.txt</a>
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="https://firecrawl.dev" class="select-none" style="-webkit-touch-callout:none"><span class="sr-only">Firecrawl Docs home page</span><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=c45b3c967c19a39190e76fe8e9c2ed5a" class="nav-logo w-auto relative object-contain shrink-0 block dark:hidden h-6" alt="light logo" /><img src="https://mintcdn.com/firecrawl/iilnMwCX-8eR1yOO/logo/logo-dark.png?fit=max&amp;auto=format&amp;n=iilnMwCX-8eR1yOO&amp;q=85&amp;s=3fee4abe033bd3c26e8ad92043a91c17" class="nav-logo w-auto relative object-contain shrink-0 hidden dark:block h-6" alt="dark logo" /></a>


Search...


Contributing


Self-hosting Firecrawl


<a href="/introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor] hover:text-primary dark:hover:text-primary-light text-gray-800 dark:text-gray-200" data-active="true" aria-current="location">Documentation</a>


<a href="/sdks/overview" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">SDKs</a>


<a href="/api-reference/v2-introduction" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">API Reference</a>


<a href="/ai-onboarding" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200">Build with AI</a>


Contributing


# Self-hosting Firecrawl


Self-host Firecrawl with Docker Compose, verify a local scrape, understand open-source limits, and prepare the stack for production.


## 


<a href="#choose-self-hosting-or-firecrawl-cloud" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#self-host-firecrawl-when" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **You want control over the source or infrastructure.** This guide gets the API and its supporting services running on your machine.
- **You are comfortable operating the stack.** You will own upgrades, security, storage, monitoring, and recovery.
- **You want to validate Firecrawl against your environment.** Get the baseline working here, then design the controls in <a href="#before-production" class="link">Before production</a>.


### 


<a href="#what-self-hosting-requires" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- You own upgrades, secrets, storage, monitoring, recovery, and incident response.
- Scraping still sends outbound requests to target websites. Optional proxy, parsing, or AI providers add more data flows.
- This guide keeps the first run intentionally simple. Get one scrape working, then change one decision at a time.
- The commands are pinned to `v2.11.162`. A different release may use a different Compose contract.

## 


<a href="#self-host-firecrawl-with-docker-compose" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#start-with-these-defaults" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **Release: Firecrawl `v2.11.162`.** Pin the code and configuration first. Upgrade after reviewing the target release’s `docker-compose.yaml` and self-hosting notes.
- **API authentication: off for this local run.** Add it only with a complete supported identity and database design; one environment variable is not enough.
- **Queue: PostgreSQL.** Keep it unless you intentionally want to operate the optional FoundationDB backend.
- **Queue admin UI: off.** Enable it only with a strong `BULL_AUTH_KEY` and network controls.
- **AI and advanced scraping providers: not configured.** Add a provider when a capability you need requires it.


### 


<a href="#prerequisites" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="https://git-scm.com/downloads" class="link" target="_blank" rel="noreferrer">Git</a>
- <a href="https://docs.docker.com/engine/install/" class="link" target="_blank" rel="noreferrer">Docker Engine</a> or Docker Desktop
- Docker Compose v2, invoked as `docker compose`
- `curl` for the verification requests


### 


<a href="#clone-the-verified-release" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
git clone https://github.com/firecrawl/firecrawl.git
cd firecrawl
git checkout v2.11.162
```


### 


<a href="#configure-the-evaluation-deployment" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
cat > .env <<'EOF'
USE_DB_AUTHENTICATION=false
POSTGRES_USER=postgres
POSTGRES_PASSWORD=replace-with-at-least-32-random-characters
POSTGRES_DB=postgres
EOF
```


### 


<a href="#build-and-start-firecrawl" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
docker compose up --build -d
docker compose ps --all
```


### 


<a href="#check-api-reachability" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
curl \
  --fail \
  --silent \
  --show-error \
  --max-time 5 \
  http://localhost:3002/v0/health/readiness
```


``` shiki
{"status":"ok"}
```


### 


<a href="#run-a-functional-smoke-test" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
curl \
  --fail-with-body \
  --silent \
  --show-error \
  --max-time 75 \
  -X POST \
  http://localhost:3002/v2/scrape \
  -H 'Content-Type: application/json' \
  -d '{
    "url": "https://example.com",
    "formats": ["markdown"],
    "timeout": 60000
  }'
```


``` shiki
{
  "success": true,
  "data": {
    "markdown": "...",
    "metadata": {
      "statusCode": 200
    }
  }
}
```


## 


<a href="#self-hosted-feature-support" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| If you need                                                                                | Decision                                                                                                   |
|--------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|
| Core scrape, crawl, map, and search routes                                                 | Keep the default stack. Fetch and Playwright processing are included.                                      |
| LLM-backed extraction or formats                                                           | Connect an OpenAI-compatible provider or Ollama, then test that path separately.                           |
| Fire-engine or its advanced anti-bot behavior                                              | Run and configure that service separately; it is not included.                                             |
| Screenshots or page actions                                                                | Not available in the default stack. Fetch and Playwright both report no support; both require Fire-engine. |
| Agent, Browser, interact, feedback, or specialized product, menu, audio, and video formats | Use Firecrawl Cloud, or verify the external service requirements for the specific capability.              |


## 


<a href="#before-production" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **If data must survive service replacement,** add durable storage for PostgreSQL, Redis, and RabbitMQ, then define and test backup and restore procedures. The provided Compose file does not add those volumes.
- **If users or untrusted networks can reach the API,** add a supported authentication design, network access controls, and TLS at a reverse proxy or ingress. Do not expose this unauthenticated baseline publicly.
- **If you have availability or capacity requirements,** set uptime targets, monitoring, resource sizing, scaling triggers, and upgrade and rollback procedures. The Compose limits are not verified minimum requirements.
- **If data location or compliance matters,** map requests to target websites and every optional AI, proxy, or parsing provider before enabling them.
- **If secrets must be managed centrally,** move the database password out of `.env` and into your platform’s secret-management system.


## 


<a href="#where-to-go-next" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **Still evaluating?** Keep the API on a trusted network and run `docker compose down` when you are finished.
- **Adding an open-source capability?** Use <a href="#self-hosted-feature-support" class="link">Self-hosted feature support</a> to find the required provider or service, then test that path on its own.
- **Changing Firecrawl code?** Switch to <a href="/contributing/guide" class="link">Running Locally</a> for the contributor development environment.
- **Connecting a client?** Point the <a href="/sdks/cli#connect-the-cli-to-self-hosted-firecrawl" class="link">Firecrawl CLI</a> or <a href="/mcp-server/local#connect-mcp-to-self-hosted-firecrawl" class="link">local MCP server</a> at your verified API URL.
- **Moving to Kubernetes?** Start with the versioned Kubernetes or Helm references linked from <a href="https://github.com/firecrawl/firecrawl/blob/main/SELF_HOST.md" class="link" target="_blank" rel="noreferrer"><code>SELF_HOST.md</code></a>, then make the production decisions above explicit for your platform.
- **Want managed infrastructure or Cloud-only capabilities?** Compare <a href="/contributing/open-source-or-cloud" class="link">Open Source vs Cloud</a>.
- **Going to production?** Complete every decision in <a href="#before-production" class="link">Before production</a> before exposing the API.

## 


<a href="#troubleshooting" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#you’re-bypassing-authentication" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#docker-containers-fail-to-start" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
docker compose ps --all
docker compose logs --tail=200
```


- If the source revision differs, either check out `v2.11.162` or use that release’s configuration.
- If a build or container is resource-constrained, increase Docker CPU, memory, or disk capacity.
- If PostgreSQL fails, check `.env` syntax, keep `POSTGRES_DB=postgres`, and make sure the user and password values are consistent.

### 


<a href="#connection-issues-with-redis" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
docker compose ps redis
docker compose logs --tail=100 redis
```


### 


<a href="#api-endpoint-does-not-respond" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
docker compose ps api
docker compose logs --tail=200 api
```


``` shiki
docker compose logs --tail=200 api playwright-service
```


### 


<a href="#scrape-request-times-out" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/contributing/self-host.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/contributing/self-host" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


