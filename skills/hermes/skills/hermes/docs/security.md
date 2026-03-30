> Source: https://hermes-agent.nousresearch.com/docs/user-guide/security/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Security


Hermes Agent is designed with a defense-in-depth security model. This page covers every security boundary — from command approval to container isolation to user authorization on messaging platforms.

## Overview<a href="#overview" class="hash-link" aria-label="Direct link to Overview" translate="no" title="Direct link to Overview">​</a>

The security model has five layers:

1.  **User authorization** — who can talk to the agent (allowlists, DM pairing)
2.  **Dangerous command approval** — human-in-the-loop for destructive operations
3.  **Container isolation** — Docker/Singularity/Modal sandboxing with hardened settings
4.  **MCP credential filtering** — environment variable isolation for MCP subprocesses
5.  **Context file scanning** — prompt injection detection in project files

## Dangerous Command Approval<a href="#dangerous-command-approval" class="hash-link" aria-label="Direct link to Dangerous Command Approval" translate="no" title="Direct link to Dangerous Command Approval">​</a>

Before executing any command, Hermes checks it against a curated list of dangerous patterns. If a match is found, the user must explicitly approve it.

### What Triggers Approval<a href="#what-triggers-approval" class="hash-link" aria-label="Direct link to What Triggers Approval" translate="no" title="Direct link to What Triggers Approval">​</a>

The following patterns trigger approval prompts (defined in `tools/approval.py`):

| Pattern                                 | Description                                       |
|-----------------------------------------|---------------------------------------------------|
| `rm -r` / `rm --recursive`              | Recursive delete                                  |
| `rm ... /`                              | Delete in root path                               |
| `chmod 777`                             | World-writable permissions                        |
| `mkfs`                                  | Format filesystem                                 |
| `dd if=`                                | Disk copy                                         |
| `DROP TABLE/DATABASE`                   | SQL DROP                                          |
| `DELETE FROM` (without WHERE)           | SQL DELETE without WHERE                          |
| `TRUNCATE TABLE`                        | SQL TRUNCATE                                      |
| `> /etc/`                               | Overwrite system config                           |
| `systemctl stop/disable/mask`           | Stop/disable system services                      |
| `kill -9 -1`                            | Kill all processes                                |
| `curl ... | sh`                         | Pipe remote content to shell                      |
| `bash -c`, `python -e`                  | Shell/script execution via flags                  |
| `find -exec rm`, `find -delete`         | Find with destructive actions                     |
| Fork bomb patterns                      | Fork bombs                                        |
| `pkill`/`killall` hermes/gateway        | Self-termination prevention                       |
| `gateway run` with `&`/`disown`/`nohup` | Prevents starting gateway outside service manager |


**Container bypass**: When running in `docker`, `singularity`, `modal`, or `daytona` backends, dangerous command checks are **skipped** because the container itself is the security boundary. Destructive commands inside a container can't harm the host.


### Approval Flow (CLI)<a href="#approval-flow-cli" class="hash-link" aria-label="Direct link to Approval Flow (CLI)" translate="no" title="Direct link to Approval Flow (CLI)">​</a>

In the interactive CLI, dangerous commands show an inline approval prompt:


``` prism-code
  ⚠️  DANGEROUS COMMAND: recursive delete
      rm -rf /tmp/old-project

      [o]nce  |  [s]ession  |  [a]lways  |  [d]eny

      Choice [o/s/a/D]:
```


The four options:

- **once** — allow this single execution
- **session** — allow this pattern for the rest of the session
- **always** — add to permanent allowlist (saved to `config.yaml`)
- **deny** (default) — block the command

### Approval Flow (Gateway/Messaging)<a href="#approval-flow-gatewaymessaging" class="hash-link" aria-label="Direct link to Approval Flow (Gateway/Messaging)" translate="no" title="Direct link to Approval Flow (Gateway/Messaging)">​</a>

On messaging platforms, the agent sends the dangerous command details to the chat and waits for the user to reply:

- Reply **yes**, **y**, **approve**, **ok**, or **go** to approve
- Reply **no**, **n**, **deny**, or **cancel** to deny

The `HERMES_EXEC_ASK=1` environment variable is automatically set when running the gateway.

### Permanent Allowlist<a href="#permanent-allowlist" class="hash-link" aria-label="Direct link to Permanent Allowlist" translate="no" title="Direct link to Permanent Allowlist">​</a>

Commands approved with "always" are saved to `~/.hermes/config.yaml`:


``` prism-code
# Permanently allowed dangerous command patterns
command_allowlist:
  - rm
  - systemctl
```


These patterns are loaded at startup and silently approved in all future sessions.


Use `hermes config edit` to review or remove patterns from your permanent allowlist.


## User Authorization (Gateway)<a href="#user-authorization-gateway" class="hash-link" aria-label="Direct link to User Authorization (Gateway)" translate="no" title="Direct link to User Authorization (Gateway)">​</a>

When running the messaging gateway, Hermes controls who can interact with the bot through a layered authorization system.

### Authorization Check Order<a href="#authorization-check-order" class="hash-link" aria-label="Direct link to Authorization Check Order" translate="no" title="Direct link to Authorization Check Order">​</a>

The `_is_user_authorized()` method checks in this order:

1.  **Per-platform allow-all flag** (e.g., `DISCORD_ALLOW_ALL_USERS=true`)
2.  **DM pairing approved list** (users approved via pairing codes)
3.  **Platform-specific allowlists** (e.g., `TELEGRAM_ALLOWED_USERS=12345,67890`)
4.  **Global allowlist** (`GATEWAY_ALLOWED_USERS=12345,67890`)
5.  **Global allow-all** (`GATEWAY_ALLOW_ALL_USERS=true`)
6.  **Default: deny**

### Platform Allowlists<a href="#platform-allowlists" class="hash-link" aria-label="Direct link to Platform Allowlists" translate="no" title="Direct link to Platform Allowlists">​</a>

Set allowed user IDs as comma-separated values in `~/.hermes/.env`:


``` prism-code
# Platform-specific allowlists
TELEGRAM_ALLOWED_USERS=123456789,987654321
DISCORD_ALLOWED_USERS=111222333444555666
WHATSAPP_ALLOWED_USERS=15551234567
SLACK_ALLOWED_USERS=U01ABC123

# Cross-platform allowlist (checked for all platforms)
GATEWAY_ALLOWED_USERS=123456789

# Per-platform allow-all (use with caution)
DISCORD_ALLOW_ALL_USERS=true

# Global allow-all (use with extreme caution)
GATEWAY_ALLOW_ALL_USERS=true
```


If **no allowlists are configured** and `GATEWAY_ALLOW_ALL_USERS` is not set, **all users are denied**. The gateway logs a warning at startup:


``` prism-code
No user allowlists configured. All unauthorized users will be denied.
Set GATEWAY_ALLOW_ALL_USERS=true in ~/.hermes/.env to allow open access,
or configure platform allowlists (e.g., TELEGRAM_ALLOWED_USERS=your_id).
```


### DM Pairing System<a href="#dm-pairing-system" class="hash-link" aria-label="Direct link to DM Pairing System" translate="no" title="Direct link to DM Pairing System">​</a>

For more flexible authorization, Hermes includes a code-based pairing system. Instead of requiring user IDs upfront, unknown users receive a one-time pairing code that the bot owner approves via the CLI.

**How it works:**

1.  An unknown user sends a DM to the bot
2.  The bot replies with an 8-character pairing code
3.  The bot owner runs `hermes pairing approve <platform> <code>` on the CLI
4.  The user is permanently approved for that platform

Control how unauthorized direct messages are handled in `~/.hermes/config.yaml`:


``` prism-code
unauthorized_dm_behavior: pair

whatsapp:
  unauthorized_dm_behavior: ignore
```


- `pair` is the default. Unauthorized DMs get a pairing code reply.
- `ignore` silently drops unauthorized DMs.
- Platform sections override the global default, so you can keep pairing on Telegram while keeping WhatsApp silent.

**Security features** (based on OWASP + NIST SP 800-63-4 guidance):

| Feature       | Details                                               |
|---------------|-------------------------------------------------------|
| Code format   | 8-char from 32-char unambiguous alphabet (no 0/O/1/I) |
| Randomness    | Cryptographic (`secrets.choice()`)                    |
| Code TTL      | 1 hour expiry                                         |
| Rate limiting | 1 request per user per 10 minutes                     |
| Pending limit | Max 3 pending codes per platform                      |
| Lockout       | 5 failed approval attempts → 1-hour lockout           |
| File security | `chmod 0600` on all pairing data files                |
| Logging       | Codes are never logged to stdout                      |

**Pairing CLI commands:**


``` prism-code
# List pending and approved users
hermes pairing list

# Approve a pairing code
hermes pairing approve telegram ABC12DEF

# Revoke a user's access
hermes pairing revoke telegram 123456789

# Clear all pending codes
hermes pairing clear-pending
```


**Storage:** Pairing data is stored in `~/.hermes/pairing/` with per-platform JSON files:

- `{platform}-pending.json` — pending pairing requests
- `{platform}-approved.json` — approved users
- `_rate_limits.json` — rate limit and lockout tracking

## Container Isolation<a href="#container-isolation" class="hash-link" aria-label="Direct link to Container Isolation" translate="no" title="Direct link to Container Isolation">​</a>

When using the `docker` terminal backend, Hermes applies strict security hardening to every container.

### Docker Security Flags<a href="#docker-security-flags" class="hash-link" aria-label="Direct link to Docker Security Flags" translate="no" title="Direct link to Docker Security Flags">​</a>

Every container runs with these flags (defined in `tools/environments/docker.py`):


``` prism-code
_SECURITY_ARGS = [
    "--cap-drop", "ALL",                          # Drop ALL Linux capabilities
    "--security-opt", "no-new-privileges",         # Block privilege escalation
    "--pids-limit", "256",                         # Limit process count
    "--tmpfs", "/tmp:rw,nosuid,size=512m",         # Size-limited /tmp
    "--tmpfs", "/var/tmp:rw,noexec,nosuid,size=256m",  # No-exec /var/tmp
    "--tmpfs", "/run:rw,noexec,nosuid,size=64m",   # No-exec /run
]
```


### Resource Limits<a href="#resource-limits" class="hash-link" aria-label="Direct link to Resource Limits" translate="no" title="Direct link to Resource Limits">​</a>

Container resources are configurable in `~/.hermes/config.yaml`:


``` prism-code
terminal:
  backend: docker
  docker_image: "nikolaik/python-nodejs:python3.11-nodejs20"
  docker_forward_env: []  # Explicit allowlist only; empty keeps secrets out of the container
  container_cpu: 1        # CPU cores
  container_memory: 5120  # MB (default 5GB)
  container_disk: 51200   # MB (default 50GB, requires overlay2 on XFS)
  container_persistent: true  # Persist filesystem across sessions
```


### Filesystem Persistence<a href="#filesystem-persistence" class="hash-link" aria-label="Direct link to Filesystem Persistence" translate="no" title="Direct link to Filesystem Persistence">​</a>

- **Persistent mode** (`container_persistent: true`): Bind-mounts `/workspace` and `/root` from `~/.hermes/sandboxes/docker/<task_id>/`
- **Ephemeral mode** (`container_persistent: false`): Uses tmpfs for workspace — everything is lost on cleanup


For production gateway deployments, use `docker`, `modal`, or `daytona` backend to isolate agent commands from your host system. This eliminates the need for dangerous command approval entirely.


If you add names to `terminal.docker_forward_env`, those variables are intentionally injected into the container for terminal commands. This is useful for task-specific credentials like `GITHUB_TOKEN`, but it also means code running in the container can read and exfiltrate them.


## Terminal Backend Security Comparison<a href="#terminal-backend-security-comparison" class="hash-link" aria-label="Direct link to Terminal Backend Security Comparison" translate="no" title="Direct link to Terminal Backend Security Comparison">​</a>

| Backend         | Isolation           | Dangerous Cmd Check                | Best For                     |
|-----------------|---------------------|------------------------------------|------------------------------|
| **local**       | None — runs on host | ✅ Yes                             | Development, trusted users   |
| **ssh**         | Remote machine      | ✅ Yes                             | Running on a separate server |
| **docker**      | Container           | ❌ Skipped (container is boundary) | Production gateway           |
| **singularity** | Container           | ❌ Skipped                         | HPC environments             |
| **modal**       | Cloud sandbox       | ❌ Skipped                         | Scalable cloud isolation     |
| **daytona**     | Cloud sandbox       | ❌ Skipped                         | Persistent cloud workspaces  |

## Environment Variable Passthrough<a href="#environment-variable-passthrough" class="hash-link" aria-label="Direct link to Environment Variable Passthrough" translate="no" title="Direct link to Environment Variable Passthrough">​</a>

Both `execute_code` and `terminal` strip sensitive environment variables from child processes to prevent credential exfiltration by LLM-generated code. However, skills that declare `required_environment_variables` legitimately need access to those vars.

### How It Works<a href="#how-it-works" class="hash-link" aria-label="Direct link to How It Works" translate="no" title="Direct link to How It Works">​</a>

Two mechanisms allow specific variables through the sandbox filters:

**1. Skill-scoped passthrough (automatic)**

When a skill is loaded (via `skill_view` or the `/skill` command) and declares `required_environment_variables`, any of those vars that are actually set in the environment are automatically registered as passthrough. Missing vars (still in setup-needed state) are **not** registered.


``` prism-code
# In a skill's SKILL.md frontmatter
required_environment_variables:
  - name: TENOR_API_KEY
    prompt: Tenor API key
    help: Get a key from https://developers.google.com/tenor
```


After loading this skill, `TENOR_API_KEY` passes through to `execute_code`, `terminal` (local), **and remote backends (Docker, Modal)** — no manual configuration needed.


Prior to v0.5.1, Docker's `forward_env` was a separate system from the skill passthrough. They are now merged — skill-declared env vars are automatically forwarded into Docker containers and Modal sandboxes without needing to add them to `docker_forward_env` manually.


**2. Config-based passthrough (manual)**

For env vars not declared by any skill, add them to `terminal.env_passthrough` in `config.yaml`:


``` prism-code
terminal:
  env_passthrough:
    - MY_CUSTOM_KEY
    - ANOTHER_TOKEN
```


### Credential File Passthrough (OAuth tokens, etc.)<a href="#credential-file-passthrough" class="hash-link" aria-label="Direct link to Credential File Passthrough (OAuth tokens, etc.)" translate="no" title="Direct link to Credential File Passthrough (OAuth tokens, etc.)">​</a>

Some skills need **files** (not just env vars) in the sandbox — for example, Google Workspace stores OAuth tokens as `google_token.json` in `~/.hermes/`. Skills declare these in frontmatter:


``` prism-code
required_credential_files:
  - path: google_token.json
    description: Google OAuth2 token (created by setup script)
  - path: google_client_secret.json
    description: Google OAuth2 client credentials
```


When loaded, Hermes checks if these files exist in `~/.hermes/` and registers them for mounting:

- **Docker**: Read-only bind mounts (`-v host:container:ro`)
- **Modal**: Mounted at sandbox creation + synced before each command (handles mid-session OAuth setup)
- **Local**: No action needed (files already accessible)

You can also list credential files manually in `config.yaml`:


``` prism-code
terminal:
  credential_files:
    - google_token.json
    - my_custom_oauth_token.json
```


Paths are relative to `~/.hermes/`. Files are mounted to `/root/.hermes/` inside the container.

### What Each Sandbox Filters<a href="#what-each-sandbox-filters" class="hash-link" aria-label="Direct link to What Each Sandbox Filters" translate="no" title="Direct link to What Each Sandbox Filters">​</a>

| Sandbox               | Default Filter                                                                                                                            | Passthrough Override                                          |
|-----------------------|-------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|
| **execute_code**      | Blocks vars containing `KEY`, `TOKEN`, `SECRET`, `PASSWORD`, `CREDENTIAL`, `PASSWD`, `AUTH` in name; only allows safe-prefix vars through | ✅ Passthrough vars bypass both checks                        |
| **terminal** (local)  | Blocks explicit Hermes infrastructure vars (provider keys, gateway tokens, tool API keys)                                                 | ✅ Passthrough vars bypass the blocklist                      |
| **terminal** (Docker) | No host env vars by default                                                                                                               | ✅ Passthrough vars + `docker_forward_env` forwarded via `-e` |
| **terminal** (Modal)  | No host env/files by default                                                                                                              | ✅ Credential files mounted; env passthrough via sync         |
| **MCP**               | Blocks everything except safe system vars + explicitly configured `env`                                                                   | ❌ Not affected by passthrough (use MCP `env` config instead) |

### Security Considerations<a href="#security-considerations" class="hash-link" aria-label="Direct link to Security Considerations" translate="no" title="Direct link to Security Considerations">​</a>

- The passthrough only affects vars you or your skills explicitly declare — the default security posture is unchanged for arbitrary LLM-generated code
- Credential files are mounted **read-only** into Docker containers
- Skills Guard scans skill content for suspicious env access patterns before installation
- Missing/unset vars are never registered (you can't leak what doesn't exist)
- Hermes infrastructure secrets (provider API keys, gateway tokens) should never be added to `env_passthrough` — they have dedicated mechanisms

## MCP Credential Handling<a href="#mcp-credential-handling" class="hash-link" aria-label="Direct link to MCP Credential Handling" translate="no" title="Direct link to MCP Credential Handling">​</a>

MCP (Model Context Protocol) server subprocesses receive a **filtered environment** to prevent accidental credential leakage.

### Safe Environment Variables<a href="#safe-environment-variables" class="hash-link" aria-label="Direct link to Safe Environment Variables" translate="no" title="Direct link to Safe Environment Variables">​</a>

Only these variables are passed through from the host to MCP stdio subprocesses:


``` prism-code
PATH, HOME, USER, LANG, LC_ALL, TERM, SHELL, TMPDIR
```


Plus any `XDG_*` variables. All other environment variables (API keys, tokens, secrets) are **stripped**.

Variables explicitly defined in the MCP server's `env` config are passed through:


``` prism-code
mcp_servers:
  github:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-github"]
    env:
      GITHUB_PERSONAL_ACCESS_TOKEN: "ghp_..."  # Only this is passed
```


### Credential Redaction<a href="#credential-redaction" class="hash-link" aria-label="Direct link to Credential Redaction" translate="no" title="Direct link to Credential Redaction">​</a>

Error messages from MCP tools are sanitized before being returned to the LLM. The following patterns are replaced with `[REDACTED]`:

- GitHub PATs (`ghp_...`)
- OpenAI-style keys (`sk-...`)
- Bearer tokens
- `token=`, `key=`, `API_KEY=`, `password=`, `secret=` parameters

### Website Access Policy<a href="#website-access-policy" class="hash-link" aria-label="Direct link to Website Access Policy" translate="no" title="Direct link to Website Access Policy">​</a>

You can restrict which websites the agent can access through its web and browser tools. This is useful for preventing the agent from accessing internal services, admin panels, or other sensitive URLs.


``` prism-code
# In ~/.hermes/config.yaml
security:
  website_blocklist:
    enabled: true
    domains:
      - "*.internal.company.com"
      - "admin.example.com"
    shared_files:
      - "/etc/hermes/blocked-sites.txt"
```


When a blocked URL is requested, the tool returns an error explaining the domain is blocked by policy. The blocklist is enforced across `web_search`, `web_extract`, `browser_navigate`, and all URL-capable tools.

See [Website Blocklist](/docs/user-guide/configuration#website-blocklist) in the configuration guide for full details.

### SSRF Protection<a href="#ssrf-protection" class="hash-link" aria-label="Direct link to SSRF Protection" translate="no" title="Direct link to SSRF Protection">​</a>

All URL-capable tools (web search, web extract, vision, browser) validate URLs before fetching them to prevent Server-Side Request Forgery (SSRF) attacks. Blocked addresses include:

- **Private networks** (RFC 1918): `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`
- **Loopback**: `127.0.0.0/8`, `::1`
- **Link-local**: `169.254.0.0/16` (includes cloud metadata at `169.254.169.254`)
- **CGNAT / shared address space** (RFC 6598): `100.64.0.0/10` (Tailscale, WireGuard VPNs)
- **Cloud metadata hostnames**: `metadata.google.internal`, `metadata.goog`
- **Reserved, multicast, and unspecified addresses**

SSRF protection is always active and cannot be disabled. DNS failures are treated as blocked (fail-closed). Redirect chains are re-validated at each hop to prevent redirect-based bypasses.

### Tirith Pre-Exec Security Scanning<a href="#tirith-pre-exec-security-scanning" class="hash-link" aria-label="Direct link to Tirith Pre-Exec Security Scanning" translate="no" title="Direct link to Tirith Pre-Exec Security Scanning">​</a>

Hermes integrates <a href="https://github.com/sheeki03/tirith" target="_blank" rel="noopener noreferrer">tirith</a> for content-level command scanning before execution. Tirith detects threats that pattern matching alone misses:

- Homograph URL spoofing (internationalized domain attacks)
- Pipe-to-interpreter patterns (`curl | bash`, `wget | sh`)
- Terminal injection attacks

Tirith auto-installs from GitHub releases on first use with SHA-256 checksum verification (and cosign provenance verification if cosign is available).


``` prism-code
# In ~/.hermes/config.yaml
security:
  tirith_enabled: true       # Enable/disable tirith scanning (default: true)
  tirith_path: "tirith"      # Path to tirith binary (default: PATH lookup)
  tirith_timeout: 5          # Subprocess timeout in seconds
  tirith_fail_open: true     # Allow execution when tirith is unavailable (default: true)
```


When `tirith_fail_open` is `true` (default), commands proceed if tirith is not installed or times out. Set to `false` in high-security environments to block commands when tirith is unavailable.

Tirith's verdict integrates with the approval flow: safe commands pass through, while both suspicious and blocked commands trigger user approval with the full tirith findings (severity, title, description, safer alternatives). Users can approve or deny — the default choice is deny to keep unattended scenarios secure.

### Context File Injection Protection<a href="#context-file-injection-protection" class="hash-link" aria-label="Direct link to Context File Injection Protection" translate="no" title="Direct link to Context File Injection Protection">​</a>

Context files (AGENTS.md, .cursorrules, SOUL.md) are scanned for prompt injection before being included in the system prompt. The scanner checks for:

- Instructions to ignore/disregard prior instructions
- Hidden HTML comments with suspicious keywords
- Attempts to read secrets (`.env`, `credentials`, `.netrc`)
- Credential exfiltration via `curl`
- Invisible Unicode characters (zero-width spaces, bidirectional overrides)

Blocked files show a warning:


``` prism-code
[BLOCKED: AGENTS.md contained potential prompt injection (prompt_injection). Content not loaded.]
```


## Best Practices for Production Deployment<a href="#best-practices-for-production-deployment" class="hash-link" aria-label="Direct link to Best Practices for Production Deployment" translate="no" title="Direct link to Best Practices for Production Deployment">​</a>

### Gateway Deployment Checklist<a href="#gateway-deployment-checklist" class="hash-link" aria-label="Direct link to Gateway Deployment Checklist" translate="no" title="Direct link to Gateway Deployment Checklist">​</a>

1.  **Set explicit allowlists** — never use `GATEWAY_ALLOW_ALL_USERS=true` in production
2.  **Use container backend** — set `terminal.backend: docker` in config.yaml
3.  **Restrict resource limits** — set appropriate CPU, memory, and disk limits
4.  **Store secrets securely** — keep API keys in `~/.hermes/.env` with proper file permissions
5.  **Enable DM pairing** — use pairing codes instead of hardcoding user IDs when possible
6.  **Review command allowlist** — periodically audit `command_allowlist` in config.yaml
7.  **Set `MESSAGING_CWD`** — don't let the agent operate from sensitive directories
8.  **Run as non-root** — never run the gateway as root
9.  **Monitor logs** — check `~/.hermes/logs/` for unauthorized access attempts
10. **Keep updated** — run `hermes update` regularly for security patches

### Securing API Keys<a href="#securing-api-keys" class="hash-link" aria-label="Direct link to Securing API Keys" translate="no" title="Direct link to Securing API Keys">​</a>


``` prism-code
# Set proper permissions on the .env file
chmod 600 ~/.hermes/.env

# Keep separate keys for different services
# Never commit .env files to version control
```


### Network Isolation<a href="#network-isolation" class="hash-link" aria-label="Direct link to Network Isolation" translate="no" title="Direct link to Network Isolation">​</a>

For maximum security, run the gateway on a separate machine or VM:


``` prism-code
terminal:
  backend: ssh
  ssh_host: "agent-worker.local"
  ssh_user: "hermes"
  ssh_key: "~/.ssh/hermes_agent_key"
```


This keeps the gateway's messaging connections separate from the agent's command execution.


- <a href="#overview" class="table-of-contents__link toc-highlight">Overview</a>
- <a href="#dangerous-command-approval" class="table-of-contents__link toc-highlight">Dangerous Command Approval</a>
  - <a href="#what-triggers-approval" class="table-of-contents__link toc-highlight">What Triggers Approval</a>
  - <a href="#approval-flow-cli" class="table-of-contents__link toc-highlight">Approval Flow (CLI)</a>
  - <a href="#approval-flow-gatewaymessaging" class="table-of-contents__link toc-highlight">Approval Flow (Gateway/Messaging)</a>
  - <a href="#permanent-allowlist" class="table-of-contents__link toc-highlight">Permanent Allowlist</a>
- <a href="#user-authorization-gateway" class="table-of-contents__link toc-highlight">User Authorization (Gateway)</a>
  - <a href="#authorization-check-order" class="table-of-contents__link toc-highlight">Authorization Check Order</a>
  - <a href="#platform-allowlists" class="table-of-contents__link toc-highlight">Platform Allowlists</a>
  - <a href="#dm-pairing-system" class="table-of-contents__link toc-highlight">DM Pairing System</a>
- <a href="#container-isolation" class="table-of-contents__link toc-highlight">Container Isolation</a>
  - <a href="#docker-security-flags" class="table-of-contents__link toc-highlight">Docker Security Flags</a>
  - <a href="#resource-limits" class="table-of-contents__link toc-highlight">Resource Limits</a>
  - <a href="#filesystem-persistence" class="table-of-contents__link toc-highlight">Filesystem Persistence</a>
- <a href="#terminal-backend-security-comparison" class="table-of-contents__link toc-highlight">Terminal Backend Security Comparison</a>
- <a href="#environment-variable-passthrough" class="table-of-contents__link toc-highlight">Environment Variable Passthrough</a>
  - <a href="#how-it-works" class="table-of-contents__link toc-highlight">How It Works</a>
  - <a href="#credential-file-passthrough" class="table-of-contents__link toc-highlight">Credential File Passthrough (OAuth tokens, etc.)</a>
  - <a href="#what-each-sandbox-filters" class="table-of-contents__link toc-highlight">What Each Sandbox Filters</a>
  - <a href="#security-considerations" class="table-of-contents__link toc-highlight">Security Considerations</a>
- <a href="#mcp-credential-handling" class="table-of-contents__link toc-highlight">MCP Credential Handling</a>
  - <a href="#safe-environment-variables" class="table-of-contents__link toc-highlight">Safe Environment Variables</a>
  - <a href="#credential-redaction" class="table-of-contents__link toc-highlight">Credential Redaction</a>
  - <a href="#website-access-policy" class="table-of-contents__link toc-highlight">Website Access Policy</a>
  - <a href="#ssrf-protection" class="table-of-contents__link toc-highlight">SSRF Protection</a>
  - <a href="#tirith-pre-exec-security-scanning" class="table-of-contents__link toc-highlight">Tirith Pre-Exec Security Scanning</a>
  - <a href="#context-file-injection-protection" class="table-of-contents__link toc-highlight">Context File Injection Protection</a>
- <a href="#best-practices-for-production-deployment" class="table-of-contents__link toc-highlight">Best Practices for Production Deployment</a>
  - <a href="#gateway-deployment-checklist" class="table-of-contents__link toc-highlight">Gateway Deployment Checklist</a>
  - <a href="#securing-api-keys" class="table-of-contents__link toc-highlight">Securing API Keys</a>
  - <a href="#network-isolation" class="table-of-contents__link toc-highlight">Network Isolation</a>


