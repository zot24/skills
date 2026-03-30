> Source: https://hermes-agent.nousresearch.com/docs/guides/use-mcp-with-hermes/



On this page


# Use MCP with Hermes


This guide shows how to actually use MCP with Hermes Agent in day-to-day workflows.

If the feature page explains what MCP is, this guide is about how to get value from it quickly and safely.

## When should you use MCP?<a href="#when-should-you-use-mcp" class="hash-link" aria-label="Direct link to When should you use MCP?" translate="no" title="Direct link to When should you use MCP?">​</a>

Use MCP when:

- a tool already exists in MCP form and you do not want to build a native Hermes tool
- you want Hermes to operate against a local or remote system through a clean RPC layer
- you want fine-grained per-server exposure control
- you want to connect Hermes to internal APIs, databases, or company systems without modifying Hermes core

Do not use MCP when:

- a built-in Hermes tool already solves the job well
- the server exposes a huge dangerous tool surface and you are not prepared to filter it
- you only need one very narrow integration and a native tool would be simpler and safer

## Mental model<a href="#mental-model" class="hash-link" aria-label="Direct link to Mental model" translate="no" title="Direct link to Mental model">​</a>

Think of MCP as an adapter layer:

- Hermes remains the agent
- MCP servers contribute tools
- Hermes discovers those tools at startup or reload time
- the model can use them like normal tools
- you control how much of each server is visible

That last part matters. Good MCP usage is not just “connect everything.” It is “connect the right thing, with the smallest useful surface.”

## Step 1: install MCP support<a href="#step-1-install-mcp-support" class="hash-link" aria-label="Direct link to Step 1: install MCP support" translate="no" title="Direct link to Step 1: install MCP support">​</a>

If you installed Hermes with the standard install script, MCP support is already included (the installer runs `uv pip install -e ".[all]"`).

If you installed without extras and need to add MCP separately:


``` bash
cd ~/.hermes/hermes-agent
uv pip install -e ".[mcp]"
```


For npm-based servers, make sure Node.js and `npx` are available.

For many Python MCP servers, `uvx` is a nice default.

## Step 2: add one server first<a href="#step-2-add-one-server-first" class="hash-link" aria-label="Direct link to Step 2: add one server first" translate="no" title="Direct link to Step 2: add one server first">​</a>

Start with a single, safe server.

Example: filesystem access to one project directory only.


``` yaml
mcp_servers:
  project_fs:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-filesystem", "/home/user/my-project"]
```


Then start Hermes:


``` bash
hermes chat
```


Now ask something concrete:


``` text
Inspect this project and summarize the repo layout.
```


## Step 3: verify MCP loaded<a href="#step-3-verify-mcp-loaded" class="hash-link" aria-label="Direct link to Step 3: verify MCP loaded" translate="no" title="Direct link to Step 3: verify MCP loaded">​</a>

You can verify MCP in a few ways:

- Hermes banner/status should show MCP integration when configured
- ask Hermes what tools it has available
- use `/reload-mcp` after config changes
- check logs if the server failed to connect

A practical test prompt:


``` text
Tell me which MCP-backed tools are available right now.
```


## Step 4: start filtering immediately<a href="#step-4-start-filtering-immediately" class="hash-link" aria-label="Direct link to Step 4: start filtering immediately" translate="no" title="Direct link to Step 4: start filtering immediately">​</a>

Do not wait until later if the server exposes a lot of tools.

### Example: whitelist only what you want<a href="#example-whitelist-only-what-you-want" class="hash-link" aria-label="Direct link to Example: whitelist only what you want" translate="no" title="Direct link to Example: whitelist only what you want">​</a>


``` yaml
mcp_servers:
  github:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-github"]
    env:
      GITHUB_PERSONAL_ACCESS_TOKEN: "***"
    tools:
      include: [list_issues, create_issue, search_code]
```


This is usually the best default for sensitive systems.

### Example: blacklist dangerous actions<a href="#example-blacklist-dangerous-actions" class="hash-link" aria-label="Direct link to Example: blacklist dangerous actions" translate="no" title="Direct link to Example: blacklist dangerous actions">​</a>


``` yaml
mcp_servers:
  stripe:
    url: "https://mcp.stripe.com"
    headers:
      Authorization: "Bearer ***"
    tools:
      exclude: [delete_customer, refund_payment]
```


### Example: disable utility wrappers too<a href="#example-disable-utility-wrappers-too" class="hash-link" aria-label="Direct link to Example: disable utility wrappers too" translate="no" title="Direct link to Example: disable utility wrappers too">​</a>


``` yaml
mcp_servers:
  docs:
    url: "https://mcp.docs.example.com"
    tools:
      prompts: false
      resources: false
```


## What does filtering actually affect?<a href="#what-does-filtering-actually-affect" class="hash-link" aria-label="Direct link to What does filtering actually affect?" translate="no" title="Direct link to What does filtering actually affect?">​</a>

There are two categories of MCP-exposed functionality in Hermes:

1.  Server-native MCP tools

- filtered with:
  - `tools.include`
  - `tools.exclude`

2.  Hermes-added utility wrappers

- filtered with:
  - `tools.resources`
  - `tools.prompts`

### Utility wrappers you may see<a href="#utility-wrappers-you-may-see" class="hash-link" aria-label="Direct link to Utility wrappers you may see" translate="no" title="Direct link to Utility wrappers you may see">​</a>

Resources:

- `list_resources`
- `read_resource`

Prompts:

- `list_prompts`
- `get_prompt`

These wrappers only appear if:

- your config allows them, and
- the MCP server session actually supports those capabilities

So Hermes will not pretend a server has resources/prompts if it does not.

## Common patterns<a href="#common-patterns" class="hash-link" aria-label="Direct link to Common patterns" translate="no" title="Direct link to Common patterns">​</a>

### Pattern 1: local project assistant<a href="#pattern-1-local-project-assistant" class="hash-link" aria-label="Direct link to Pattern 1: local project assistant" translate="no" title="Direct link to Pattern 1: local project assistant">​</a>

Use MCP for a repo-local filesystem or git server when you want Hermes to reason over a bounded workspace.


``` yaml
mcp_servers:
  fs:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-filesystem", "/home/user/project"]

  git:
    command: "uvx"
    args: ["mcp-server-git", "--repository", "/home/user/project"]
```


Good prompts:


``` text
Review the project structure and identify where configuration lives.
```


``` text
Check the local git state and summarize what changed recently.
```


### Pattern 2: GitHub triage assistant<a href="#pattern-2-github-triage-assistant" class="hash-link" aria-label="Direct link to Pattern 2: GitHub triage assistant" translate="no" title="Direct link to Pattern 2: GitHub triage assistant">​</a>


``` yaml
mcp_servers:
  github:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-github"]
    env:
      GITHUB_PERSONAL_ACCESS_TOKEN: "***"
    tools:
      include: [list_issues, create_issue, update_issue, search_code]
      prompts: false
      resources: false
```


Good prompts:


``` text
List open issues about MCP, cluster them by theme, and draft a high-quality issue for the most common bug.
```


``` text
Search the repo for uses of _discover_and_register_server and explain how MCP tools are registered.
```


### Pattern 3: internal API assistant<a href="#pattern-3-internal-api-assistant" class="hash-link" aria-label="Direct link to Pattern 3: internal API assistant" translate="no" title="Direct link to Pattern 3: internal API assistant">​</a>


``` yaml
mcp_servers:
  internal_api:
    url: "https://mcp.internal.example.com"
    headers:
      Authorization: "Bearer ***"
    tools:
      include: [list_customers, get_customer, list_invoices]
      resources: false
      prompts: false
```


Good prompts:


``` text
Look up customer ACME Corp and summarize recent invoice activity.
```


This is the sort of place where a strict whitelist is far better than an exclude list.

### Pattern 4: documentation / knowledge servers<a href="#pattern-4-documentation--knowledge-servers" class="hash-link" aria-label="Direct link to Pattern 4: documentation / knowledge servers" translate="no" title="Direct link to Pattern 4: documentation / knowledge servers">​</a>

Some MCP servers expose prompts or resources that are more like shared knowledge assets than direct actions.


``` yaml
mcp_servers:
  docs:
    url: "https://mcp.docs.example.com"
    tools:
      prompts: true
      resources: true
```


Good prompts:


``` text
List available MCP resources from the docs server, then read the onboarding guide and summarize it.
```


``` text
List prompts exposed by the docs server and tell me which ones would help with incident response.
```


## Tutorial: end-to-end setup with filtering<a href="#tutorial-end-to-end-setup-with-filtering" class="hash-link" aria-label="Direct link to Tutorial: end-to-end setup with filtering" translate="no" title="Direct link to Tutorial: end-to-end setup with filtering">​</a>

Here is a practical progression.

### Phase 1: add GitHub MCP with a tight whitelist<a href="#phase-1-add-github-mcp-with-a-tight-whitelist" class="hash-link" aria-label="Direct link to Phase 1: add GitHub MCP with a tight whitelist" translate="no" title="Direct link to Phase 1: add GitHub MCP with a tight whitelist">​</a>


``` yaml
mcp_servers:
  github:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-github"]
    env:
      GITHUB_PERSONAL_ACCESS_TOKEN: "***"
    tools:
      include: [list_issues, create_issue, search_code]
      prompts: false
      resources: false
```


Start Hermes and ask:


``` text
Search the codebase for references to MCP and summarize the main integration points.
```


### Phase 2: expand only when needed<a href="#phase-2-expand-only-when-needed" class="hash-link" aria-label="Direct link to Phase 2: expand only when needed" translate="no" title="Direct link to Phase 2: expand only when needed">​</a>

If you later need issue updates too:


``` yaml
tools:
  include: [list_issues, create_issue, update_issue, search_code]
```


Then reload:


``` text
/reload-mcp
```


### Phase 3: add a second server with different policy<a href="#phase-3-add-a-second-server-with-different-policy" class="hash-link" aria-label="Direct link to Phase 3: add a second server with different policy" translate="no" title="Direct link to Phase 3: add a second server with different policy">​</a>


``` yaml
mcp_servers:
  github:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-github"]
    env:
      GITHUB_PERSONAL_ACCESS_TOKEN: "***"
    tools:
      include: [list_issues, create_issue, update_issue, search_code]
      prompts: false
      resources: false

  filesystem:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-filesystem", "/home/user/project"]
```


Now Hermes can combine them:


``` text
Inspect the local project files, then create a GitHub issue summarizing the bug you find.
```


That is where MCP gets powerful: multi-system workflows without changing Hermes core.

## Safe usage recommendations<a href="#safe-usage-recommendations" class="hash-link" aria-label="Direct link to Safe usage recommendations" translate="no" title="Direct link to Safe usage recommendations">​</a>

### Prefer allowlists for dangerous systems<a href="#prefer-allowlists-for-dangerous-systems" class="hash-link" aria-label="Direct link to Prefer allowlists for dangerous systems" translate="no" title="Direct link to Prefer allowlists for dangerous systems">​</a>

For anything financial, customer-facing, or destructive:

- use `tools.include`
- start with the smallest set possible

### Disable unused utilities<a href="#disable-unused-utilities" class="hash-link" aria-label="Direct link to Disable unused utilities" translate="no" title="Direct link to Disable unused utilities">​</a>

If you do not want the model browsing server-provided resources/prompts, turn them off:


``` yaml
tools:
  resources: false
  prompts: false
```


### Keep servers scoped narrowly<a href="#keep-servers-scoped-narrowly" class="hash-link" aria-label="Direct link to Keep servers scoped narrowly" translate="no" title="Direct link to Keep servers scoped narrowly">​</a>

Examples:

- filesystem server rooted to one project dir, not your whole home directory
- git server pointed at one repo
- internal API server with read-heavy tool exposure by default

### Reload after config changes<a href="#reload-after-config-changes" class="hash-link" aria-label="Direct link to Reload after config changes" translate="no" title="Direct link to Reload after config changes">​</a>


``` text
/reload-mcp
```


Do this after changing:

- include/exclude lists
- enabled flags
- resources/prompts toggles
- auth headers / env

## Troubleshooting by symptom<a href="#troubleshooting-by-symptom" class="hash-link" aria-label="Direct link to Troubleshooting by symptom" translate="no" title="Direct link to Troubleshooting by symptom">​</a>

### "The server connects but the tools I expected are missing"<a href="#the-server-connects-but-the-tools-i-expected-are-missing" class="hash-link" aria-label="Direct link to &quot;The server connects but the tools I expected are missing&quot;" translate="no" title="Direct link to &quot;The server connects but the tools I expected are missing&quot;">​</a>

Possible causes:

- filtered by `tools.include`
- excluded by `tools.exclude`
- utility wrappers disabled via `resources: false` or `prompts: false`
- server does not actually support resources/prompts

### "The server is configured but nothing loads"<a href="#the-server-is-configured-but-nothing-loads" class="hash-link" aria-label="Direct link to &quot;The server is configured but nothing loads&quot;" translate="no" title="Direct link to &quot;The server is configured but nothing loads&quot;">​</a>

Check:

- `enabled: false` was not left in config
- command/runtime exists (`npx`, `uvx`, etc.)
- HTTP endpoint is reachable
- auth env or headers are correct

### "Why do I see fewer tools than the MCP server advertises?"<a href="#why-do-i-see-fewer-tools-than-the-mcp-server-advertises" class="hash-link" aria-label="Direct link to &quot;Why do I see fewer tools than the MCP server advertises?&quot;" translate="no" title="Direct link to &quot;Why do I see fewer tools than the MCP server advertises?&quot;">​</a>

Because Hermes now respects your per-server policy and capability-aware registration. That is expected, and usually desirable.

### "How do I remove an MCP server without deleting the config?"<a href="#how-do-i-remove-an-mcp-server-without-deleting-the-config" class="hash-link" aria-label="Direct link to &quot;How do I remove an MCP server without deleting the config?&quot;" translate="no" title="Direct link to &quot;How do I remove an MCP server without deleting the config?&quot;">​</a>

Use:


``` yaml
enabled: false
```


That keeps the config around but prevents connection and registration.

## Recommended first MCP setups<a href="#recommended-first-mcp-setups" class="hash-link" aria-label="Direct link to Recommended first MCP setups" translate="no" title="Direct link to Recommended first MCP setups">​</a>

Good first servers for most users:

- filesystem
- git
- GitHub
- fetch / documentation MCP servers
- one narrow internal API

Not-great first servers:

- giant business systems with lots of destructive actions and no filtering
- anything you do not understand well enough to constrain

## Related docs<a href="#related-docs" class="hash-link" aria-label="Direct link to Related docs" translate="no" title="Direct link to Related docs">​</a>

- [MCP (Model Context Protocol)](/docs/user-guide/features/mcp)
- [FAQ](/docs/reference/faq)
- [Slash Commands](/docs/reference/slash-commands)


- <a href="#when-should-you-use-mcp" class="table-of-contents__link toc-highlight">When should you use MCP?</a>
- <a href="#mental-model" class="table-of-contents__link toc-highlight">Mental model</a>
- <a href="#step-1-install-mcp-support" class="table-of-contents__link toc-highlight">Step 1: install MCP support</a>
- <a href="#step-2-add-one-server-first" class="table-of-contents__link toc-highlight">Step 2: add one server first</a>
- <a href="#step-3-verify-mcp-loaded" class="table-of-contents__link toc-highlight">Step 3: verify MCP loaded</a>
- <a href="#step-4-start-filtering-immediately" class="table-of-contents__link toc-highlight">Step 4: start filtering immediately</a>
  - <a href="#example-whitelist-only-what-you-want" class="table-of-contents__link toc-highlight">Example: whitelist only what you want</a>
  - <a href="#example-blacklist-dangerous-actions" class="table-of-contents__link toc-highlight">Example: blacklist dangerous actions</a>
  - <a href="#example-disable-utility-wrappers-too" class="table-of-contents__link toc-highlight">Example: disable utility wrappers too</a>
- <a href="#what-does-filtering-actually-affect" class="table-of-contents__link toc-highlight">What does filtering actually affect?</a>
  - <a href="#utility-wrappers-you-may-see" class="table-of-contents__link toc-highlight">Utility wrappers you may see</a>
- <a href="#common-patterns" class="table-of-contents__link toc-highlight">Common patterns</a>
  - <a href="#pattern-1-local-project-assistant" class="table-of-contents__link toc-highlight">Pattern 1: local project assistant</a>
  - <a href="#pattern-2-github-triage-assistant" class="table-of-contents__link toc-highlight">Pattern 2: GitHub triage assistant</a>
  - <a href="#pattern-3-internal-api-assistant" class="table-of-contents__link toc-highlight">Pattern 3: internal API assistant</a>
  - <a href="#pattern-4-documentation--knowledge-servers" class="table-of-contents__link toc-highlight">Pattern 4: documentation / knowledge servers</a>
- <a href="#tutorial-end-to-end-setup-with-filtering" class="table-of-contents__link toc-highlight">Tutorial: end-to-end setup with filtering</a>
  - <a href="#phase-1-add-github-mcp-with-a-tight-whitelist" class="table-of-contents__link toc-highlight">Phase 1: add GitHub MCP with a tight whitelist</a>
  - <a href="#phase-2-expand-only-when-needed" class="table-of-contents__link toc-highlight">Phase 2: expand only when needed</a>
  - <a href="#phase-3-add-a-second-server-with-different-policy" class="table-of-contents__link toc-highlight">Phase 3: add a second server with different policy</a>
- <a href="#safe-usage-recommendations" class="table-of-contents__link toc-highlight">Safe usage recommendations</a>
  - <a href="#prefer-allowlists-for-dangerous-systems" class="table-of-contents__link toc-highlight">Prefer allowlists for dangerous systems</a>
  - <a href="#disable-unused-utilities" class="table-of-contents__link toc-highlight">Disable unused utilities</a>
  - <a href="#keep-servers-scoped-narrowly" class="table-of-contents__link toc-highlight">Keep servers scoped narrowly</a>
  - <a href="#reload-after-config-changes" class="table-of-contents__link toc-highlight">Reload after config changes</a>
- <a href="#troubleshooting-by-symptom" class="table-of-contents__link toc-highlight">Troubleshooting by symptom</a>
  - <a href="#the-server-connects-but-the-tools-i-expected-are-missing" class="table-of-contents__link toc-highlight">"The server connects but the tools I expected are missing"</a>
  - <a href="#the-server-is-configured-but-nothing-loads" class="table-of-contents__link toc-highlight">"The server is configured but nothing loads"</a>
  - <a href="#why-do-i-see-fewer-tools-than-the-mcp-server-advertises" class="table-of-contents__link toc-highlight">"Why do I see fewer tools than the MCP server advertises?"</a>
  - <a href="#how-do-i-remove-an-mcp-server-without-deleting-the-config" class="table-of-contents__link toc-highlight">"How do I remove an MCP server without deleting the config?"</a>
- <a href="#recommended-first-mcp-setups" class="table-of-contents__link toc-highlight">Recommended first MCP setups</a>
- <a href="#related-docs" class="table-of-contents__link toc-highlight">Related docs</a>


