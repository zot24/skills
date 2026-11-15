> Source: https://docs.firecrawl.dev/contributing/self-host



Contributing


# Self-hosting Firecrawl


Self-host Firecrawl with Docker Compose, verify a local scrape, understand open-source limits, and prepare the stack for production.


## <a href="#choose-self-hosting-or-firecrawl-cloud" class="anchor-link" aria-label="Navigate to header: Choose self-hosting or Firecrawl Cloud"></a><span id="_R_79crmhkd74t9_" class="cursor-pointer">Choose self-hosting or Firecrawl Cloud</span>

### <a href="#self-host-firecrawl-when" class="anchor-link" aria-label="Navigate to header: Self-host Firecrawl when"></a><span id="_R_99crmhkd74t9_" class="cursor-pointer">Self-host Firecrawl when</span>

- **You want control over the source or infrastructure.** This guide gets the API and its supporting services running on your machine.
- **You are comfortable operating the stack.** You will own upgrades, security, storage, monitoring, and recovery.
- **You want to validate Firecrawl against your environment.** Get the baseline working here, then design the controls in <a href="#before-production" class="link">Before production</a>.


### <a href="#what-self-hosting-requires" class="anchor-link" aria-label="Navigate to header: What self-hosting requires"></a><span id="_R_h9crmhkd74t9_" class="cursor-pointer">What self-hosting requires</span>

- You own upgrades, secrets, storage, monitoring, recovery, and incident response.
- Scraping still sends outbound requests to target websites. Optional proxy, parsing, or AI providers add more data flows.
- This guide keeps the first run intentionally simple. Get one scrape working, then change one decision at a time.
- The commands are pinned to `v2.11.162`. A different release may use a different Compose contract.

## <a href="#self-host-firecrawl-with-docker-compose" class="anchor-link" aria-label="Navigate to header: Self-host Firecrawl with Docker Compose"></a><span id="_R_l9crmhkd74t9_" class="cursor-pointer">Self-host Firecrawl with Docker Compose</span>

### <a href="#start-with-these-defaults" class="anchor-link" aria-label="Navigate to header: Start with these defaults"></a><span id="_R_n9crmhkd74t9_" class="cursor-pointer">Start with these defaults</span>

- **Release: Firecrawl `v2.11.162`.** Pin the code and configuration first. Upgrade after reviewing the target release’s `docker-compose.yaml` and self-hosting notes.
- **API authentication: off for this local run.** Add it only with a complete supported identity and database design; one environment variable is not enough.
- **Queue: PostgreSQL.** Keep it unless you intentionally want to operate the optional FoundationDB backend.
- **Queue admin UI: off.** Enable it only with a strong `BULL_AUTH_KEY` and network controls.
- **AI and advanced scraping providers: not configured.** Add a provider when a capability you need requires it.


### <a href="#prerequisites" class="anchor-link" aria-label="Navigate to header: Prerequisites"></a><span id="_R_t9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Prerequisites</span>


- <a href="https://git-scm.com/downloads" class="link" target="_blank" rel="noreferrer">Git</a>
- <a href="https://docs.docker.com/engine/install/" class="link" target="_blank" rel="noreferrer">Docker Engine</a> or Docker Desktop
- Docker Compose v2, invoked as `docker compose`
- `curl` for the verification requests


### <a href="#clone-the-verified-release" class="anchor-link" aria-label="Navigate to header: Clone the verified release"></a><span id="_R_159crmhkd74t9_" class="cursor-pointer">Clone the verified release</span>


``` shiki
git clone https://github.com/firecrawl/firecrawl.git
cd firecrawl
git checkout v2.11.162
```


### <a href="#configure-the-evaluation-deployment" class="anchor-link" aria-label="Navigate to header: Configure the evaluation deployment"></a><span id="_R_1d9crmhkd74t9_" class="cursor-pointer">Configure the evaluation deployment</span>


``` shiki
cat > .env <<'EOF'
USE_DB_AUTHENTICATION=false
POSTGRES_USER=postgres
POSTGRES_PASSWORD=replace-with-at-least-32-random-characters
POSTGRES_DB=postgres
EOF
```


### <a href="#build-and-start-firecrawl" class="anchor-link" aria-label="Navigate to header: Build and start Firecrawl"></a><span id="_R_1p9crmhkd74t9_" class="cursor-pointer">Build and start Firecrawl</span>


``` shiki
docker compose up --build -d
docker compose ps --all
```


### <a href="#check-api-reachability" class="anchor-link" aria-label="Navigate to header: Check API reachability"></a><span id="_R_219crmhkd74t9_" class="cursor-pointer">Check API reachability</span>


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


### <a href="#run-a-functional-smoke-test" class="anchor-link" aria-label="Navigate to header: Run a functional smoke test"></a><span id="_R_2d9crmhkd74t9_" class="cursor-pointer">Run a functional smoke test</span>


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


## <a href="#self-hosted-feature-support" class="anchor-link" aria-label="Navigate to header: Self-hosted feature support"></a><span id="_R_2r9crmhkd74t9_" class="cursor-pointer">Self-hosted feature support</span>


| If you need | Decision |
|----|----|
| Core scrape, crawl, map, and search routes | Keep the default stack. Fetch and Playwright processing are included. |
| LLM-backed extraction or formats | Connect an OpenAI-compatible provider or Ollama, then test that path separately. |
| Fire-engine or its advanced anti-bot behavior | Run and configure that service separately; it is not included. |
| Screenshots or page actions | Not available in the default stack. Fetch and Playwright both report no support; both require Fire-engine. |
| Agent, Browser, interact, feedback, or specialized product, menu, audio, and video formats | Use Firecrawl Cloud, or verify the external service requirements for the specific capability. |


## <a href="#before-production" class="anchor-link" aria-label="Navigate to header: Before production"></a><span id="_R_339crmhkd74t9_" class="cursor-pointer">Before production</span>


- **If data must survive service replacement,** add durable storage for PostgreSQL, Redis, and RabbitMQ, then define and test backup and restore procedures. The provided Compose file does not add those volumes.
- **If users or untrusted networks can reach the API,** add a supported authentication design, network access controls, and TLS at a reverse proxy or ingress. Do not expose this unauthenticated baseline publicly.
- **If you have availability or capacity requirements,** set uptime targets, monitoring, resource sizing, scaling triggers, and upgrade and rollback procedures. The Compose limits are not verified minimum requirements.
- **If data location or compliance matters,** map requests to target websites and every optional AI, proxy, or parsing provider before enabling them.
- **If secrets must be managed centrally,** move the database password out of `.env` and into your platform’s secret-management system.
- **If you enable admin routes with `BULL_AUTH_KEY`,** call them under `/admin/ops/` with an `Authorization: Bearer` header, set `BULL_AUTH_KEY_PREVIOUS` while callers move to a new key, and set `BULL_AUTH_KEY_PATH_ROUTES=false` once nothing uses the `/admin/<key>/...` paths. To reach the queue UI, metrics, and diagnostic routes without a key, set `ADMIN_INTERNAL_PORT` and keep that port private. See <a href="https://github.com/firecrawl/firecrawl/blob/main/SELF_HOST.md#admin-routes" class="link" target="_blank" rel="noreferrer"><code>SELF_HOST.md</code></a> for the full list.


## <a href="#where-to-go-next" class="anchor-link" aria-label="Navigate to header: Where to go next"></a><span id="_R_3b9crmhkd74t9_" class="cursor-pointer">Where to go next</span>

- **Still evaluating?** Keep the API on a trusted network and run `docker compose down` when you are finished.
- **Adding an open-source capability?** Use <a href="#self-hosted-feature-support" class="link">Self-hosted feature support</a> to find the required provider or service, then test that path on its own.
- **Changing Firecrawl code?** Switch to <a href="/contributing/guide" class="link">Contributor Setup</a> for the development environment.
- **Connecting a client?** Point the <a href="/sdks/cli#connect-the-cli-to-self-hosted-firecrawl" class="link">Firecrawl CLI</a> or <a href="/mcp-server/local#connect-mcp-to-self-hosted-firecrawl" class="link">local MCP server</a> at your verified API URL.
- **Moving to Kubernetes?** Start with the versioned Kubernetes or Helm references linked from <a href="https://github.com/firecrawl/firecrawl/blob/main/SELF_HOST.md" class="link" target="_blank" rel="noreferrer"><code>SELF_HOST.md</code></a>, then make the production decisions above explicit for your platform.
- **Want managed infrastructure or Cloud-only capabilities?** Compare <a href="/contributing/open-source-or-cloud" class="link">Open Source vs Cloud</a>.
- **Going to production?** Complete every decision in <a href="#before-production" class="link">Before production</a> before exposing the API.

## <a href="#troubleshooting" class="anchor-link" aria-label="Navigate to header: Troubleshooting"></a><span id="_R_3f9crmhkd74t9_" class="min-w-0 break-words cursor-pointer">Troubleshooting</span>

### <a href="#you’re-bypassing-authentication" class="anchor-link" aria-label="Navigate to header: You’re bypassing authentication"></a><span id="_R_3h9crmhkd74t9_" class="cursor-pointer">You’re bypassing authentication</span>


### <a href="#docker-containers-fail-to-start" class="anchor-link" aria-label="Navigate to header: Docker containers fail to start"></a><span id="_R_3l9crmhkd74t9_" class="cursor-pointer">Docker containers fail to start</span>


``` shiki
docker compose ps --all
docker compose logs --tail=200
```


- If the source revision differs, either check out `v2.11.162` or use that release’s configuration.
- If a build or container is resource-constrained, increase Docker CPU, memory, or disk capacity.
- If PostgreSQL fails, check `.env` syntax, keep `POSTGRES_DB=postgres`, and make sure the user and password values are consistent.

### <a href="#connection-issues-with-redis" class="anchor-link" aria-label="Navigate to header: Connection issues with Redis"></a><span id="_R_3t9crmhkd74t9_" class="cursor-pointer">Connection issues with Redis</span>


``` shiki
docker compose ps redis
docker compose logs --tail=100 redis
```


### <a href="#api-endpoint-does-not-respond" class="anchor-link" aria-label="Navigate to header: API endpoint does not respond"></a><span id="_R_459crmhkd74t9_" class="cursor-pointer">API endpoint does not respond</span>


``` shiki
docker compose ps api
docker compose logs --tail=200 api
```


``` shiki
docker compose logs --tail=200 api playwright-service
```


### <a href="#scrape-request-times-out" class="anchor-link" aria-label="Navigate to header: Scrape request times out"></a><span id="_R_4h9crmhkd74t9_" class="cursor-pointer">Scrape request times out</span>


<a href="https://github.com/firecrawl/firecrawl-docs/edit/main/contributing/self-host.mdx" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Suggest edits</span></a><a href="https://github.com/firecrawl/firecrawl-docs/issues/new?title=Issue%20on%20docs&amp;body=Path:%20/contributing/self-host" class="h-fit whitespace-nowrap px-3.5 py-2 flex flex-row gap-3 items-center border-standard rounded-xl text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 bg-white/50 dark:bg-codeblock/50 hover:border-gray-500 hover:dark:border-gray-500" target="_blank" rel="noopener noreferrer"><span class="small">Raise issue</span></a>


