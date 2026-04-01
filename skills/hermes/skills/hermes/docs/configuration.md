> Source: https://hermes-agent.nousresearch.com/docs/user-guide/configuration/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Configuration


All settings are stored in the `~/.hermes/` directory for easy access.

## Directory Structure<a href="#directory-structure" class="hash-link" aria-label="Direct link to Directory Structure" translate="no" title="Direct link to Directory Structure">​</a>


``` prism-code
~/.hermes/
├── config.yaml     # Settings (model, terminal, TTS, compression, etc.)
├── .env            # API keys and secrets
├── auth.json       # OAuth provider credentials (Nous Portal, etc.)
├── SOUL.md         # Primary agent identity (slot #1 in system prompt)
├── memories/       # Persistent memory (MEMORY.md, USER.md)
├── skills/         # Agent-created skills (managed via skill_manage tool)
├── cron/           # Scheduled jobs
├── sessions/       # Gateway sessions
└── logs/           # Logs (errors.log, gateway.log — secrets auto-redacted)
```


## Managing Configuration<a href="#managing-configuration" class="hash-link" aria-label="Direct link to Managing Configuration" translate="no" title="Direct link to Managing Configuration">​</a>


``` prism-code
hermes config              # View current configuration
hermes config edit         # Open config.yaml in your editor
hermes config set KEY VAL  # Set a specific value
hermes config check        # Check for missing options (after updates)
hermes config migrate      # Interactively add missing options

# Examples:
hermes config set model anthropic/claude-opus-4
hermes config set terminal.backend docker
hermes config set OPENROUTER_API_KEY sk-or-...  # Saves to .env
```


The `hermes config set` command automatically routes values to the right file — API keys are saved to `.env`, everything else to `config.yaml`.


## Configuration Precedence<a href="#configuration-precedence" class="hash-link" aria-label="Direct link to Configuration Precedence" translate="no" title="Direct link to Configuration Precedence">​</a>

Settings are resolved in this order (highest priority first):

1.  **CLI arguments** — e.g., `hermes chat --model anthropic/claude-sonnet-4` (per-invocation override)
2.  **`~/.hermes/config.yaml`** — the primary config file for all non-secret settings
3.  **`~/.hermes/.env`** — fallback for env vars; **required** for secrets (API keys, tokens, passwords)
4.  **Built-in defaults** — hardcoded safe defaults when nothing else is set


Secrets (API keys, bot tokens, passwords) go in `.env`. Everything else (model, terminal backend, compression settings, memory limits, toolsets) goes in `config.yaml`. When both are set, `config.yaml` wins for non-secret settings.


## Environment Variable Substitution<a href="#environment-variable-substitution" class="hash-link" aria-label="Direct link to Environment Variable Substitution" translate="no" title="Direct link to Environment Variable Substitution">​</a>

You can reference environment variables in `config.yaml` using `${VAR_NAME}` syntax:


``` prism-code
auxiliary:
  vision:
    api_key: ${GOOGLE_API_KEY}
    base_url: ${CUSTOM_VISION_URL}

delegation:
  api_key: ${DELEGATION_KEY}
```


Multiple references in a single value work: `url: "${HOST}:${PORT}"`. If a referenced variable is not set, the placeholder is kept verbatim (`${UNDEFINED_VAR}` stays as-is). Only the `${VAR}` syntax is supported — bare `$VAR` is not expanded.

For AI provider setup (OpenRouter, Anthropic, Copilot, custom endpoints, self-hosted LLMs, fallback models, etc.), see [AI Providers](/docs/integrations/providers).

## Terminal Backend Configuration<a href="#terminal-backend-configuration" class="hash-link" aria-label="Direct link to Terminal Backend Configuration" translate="no" title="Direct link to Terminal Backend Configuration">​</a>

Hermes supports six terminal backends. Each determines where the agent's shell commands actually execute — your local machine, a Docker container, a remote server via SSH, a Modal cloud sandbox, a Daytona workspace, or a Singularity/Apptainer container.


``` prism-code
terminal:
  backend: local    # local | docker | ssh | modal | daytona | singularity
  cwd: "."          # Working directory ("." = current dir for local, "/root" for containers)
  timeout: 180      # Per-command timeout in seconds
  env_passthrough: []  # Env var names to forward to sandboxed execution (terminal + execute_code)
  singularity_image: "docker://nikolaik/python-nodejs:python3.11-nodejs20"  # Container image for Singularity backend
  modal_image: "nikolaik/python-nodejs:python3.11-nodejs20"                 # Container image for Modal backend
  daytona_image: "nikolaik/python-nodejs:python3.11-nodejs20"               # Container image for Daytona backend
```


### Backend Overview<a href="#backend-overview" class="hash-link" aria-label="Direct link to Backend Overview" translate="no" title="Direct link to Backend Overview">​</a>

| Backend         | Where commands run              | Isolation                   | Best for                       |
|-----------------|---------------------------------|-----------------------------|--------------------------------|
| **local**       | Your machine directly           | None                        | Development, personal use      |
| **docker**      | Docker container                | Full (namespaces, cap-drop) | Safe sandboxing, CI/CD         |
| **ssh**         | Remote server via SSH           | Network boundary            | Remote dev, powerful hardware  |
| **modal**       | Modal cloud sandbox             | Full (cloud VM)             | Ephemeral cloud compute, evals |
| **daytona**     | Daytona workspace               | Full (cloud container)      | Managed cloud dev environments |
| **singularity** | Singularity/Apptainer container | Namespaces (--containall)   | HPC clusters, shared machines  |

### Local Backend<a href="#local-backend" class="hash-link" aria-label="Direct link to Local Backend" translate="no" title="Direct link to Local Backend">​</a>

The default. Commands run directly on your machine with no isolation. No special setup required.


``` prism-code
terminal:
  backend: local
```


The agent has the same filesystem access as your user account. Use `hermes tools` to disable tools you don't want, or switch to Docker for sandboxing.


### Docker Backend<a href="#docker-backend" class="hash-link" aria-label="Direct link to Docker Backend" translate="no" title="Direct link to Docker Backend">​</a>

Runs commands inside a Docker container with security hardening (all capabilities dropped, no privilege escalation, PID limits).


``` prism-code
terminal:
  backend: docker
  docker_image: "nikolaik/python-nodejs:python3.11-nodejs20"
  docker_mount_cwd_to_workspace: false  # Mount launch dir into /workspace
  docker_forward_env:              # Env vars to forward into container
    - "GITHUB_TOKEN"
  docker_volumes:                  # Host directory mounts
    - "/home/user/projects:/workspace/projects"
    - "/home/user/data:/data:ro"   # :ro for read-only

  # Resource limits
  container_cpu: 1                 # CPU cores (0 = unlimited)
  container_memory: 5120           # MB (0 = unlimited)
  container_disk: 51200            # MB (requires overlay2 on XFS+pquota)
  container_persistent: true       # Persist /workspace and /root across sessions
```


**Requirements:** Docker Desktop or Docker Engine installed and running. Hermes probes `$PATH` plus common macOS install locations (`/usr/local/bin/docker`, `/opt/homebrew/bin/docker`, Docker Desktop app bundle).

**Container lifecycle:** Each session starts a long-lived container (`docker run -d ... sleep 2h`). Commands run via `docker exec` with a login shell. On cleanup, the container is stopped and removed.

**Security hardening:**

- `--cap-drop ALL` with only `DAC_OVERRIDE`, `CHOWN`, `FOWNER` added back
- `--security-opt no-new-privileges`
- `--pids-limit 256`
- Size-limited tmpfs for `/tmp` (512MB), `/var/tmp` (256MB), `/run` (64MB)

**Credential forwarding:** Env vars listed in `docker_forward_env` are resolved from your shell environment first, then `~/.hermes/.env`. Skills can also declare `required_environment_variables` which are merged automatically.

### SSH Backend<a href="#ssh-backend" class="hash-link" aria-label="Direct link to SSH Backend" translate="no" title="Direct link to SSH Backend">​</a>

Runs commands on a remote server over SSH. Uses ControlMaster for connection reuse (5-minute idle keepalive). Persistent shell is enabled by default — state (cwd, env vars) survives across commands.


``` prism-code
terminal:
  backend: ssh
  persistent_shell: true           # Keep a long-lived bash session (default: true)
```


**Required environment variables:**


``` prism-code
TERMINAL_SSH_HOST=my-server.example.com
TERMINAL_SSH_USER=ubuntu
```


**Optional:**

| Variable                  | Default          | Description             |
|---------------------------|------------------|-------------------------|
| `TERMINAL_SSH_PORT`       | `22`             | SSH port                |
| `TERMINAL_SSH_KEY`        | (system default) | Path to SSH private key |
| `TERMINAL_SSH_PERSISTENT` | `true`           | Enable persistent shell |

**How it works:** Connects at init time with `BatchMode=yes` and `StrictHostKeyChecking=accept-new`. Persistent shell keeps a single `bash -l` process alive on the remote host, communicating via temporary files. Commands that need `stdin_data` or `sudo` automatically fall back to one-shot mode.

### Modal Backend<a href="#modal-backend" class="hash-link" aria-label="Direct link to Modal Backend" translate="no" title="Direct link to Modal Backend">​</a>

Runs commands in a <a href="https://modal.com" target="_blank" rel="noopener noreferrer">Modal</a> cloud sandbox. Each task gets an isolated VM with configurable CPU, memory, and disk. Filesystem can be snapshot/restored across sessions.


``` prism-code
terminal:
  backend: modal
  container_cpu: 1                 # CPU cores
  container_memory: 5120           # MB (5GB)
  container_disk: 51200            # MB (50GB)
  container_persistent: true       # Snapshot/restore filesystem
```


**Required:** Either `MODAL_TOKEN_ID` + `MODAL_TOKEN_SECRET` environment variables, or a `~/.modal.toml` config file.

**Persistence:** When enabled, the sandbox filesystem is snapshotted on cleanup and restored on next session. Snapshots are tracked in `~/.hermes/modal_snapshots.json`.

**Credential files:** Automatically mounted from `~/.hermes/` (OAuth tokens, etc.) and synced before each command.

### Daytona Backend<a href="#daytona-backend" class="hash-link" aria-label="Direct link to Daytona Backend" translate="no" title="Direct link to Daytona Backend">​</a>

Runs commands in a <a href="https://daytona.io" target="_blank" rel="noopener noreferrer">Daytona</a> managed workspace. Supports stop/resume for persistence.


``` prism-code
terminal:
  backend: daytona
  container_cpu: 1                 # CPU cores
  container_memory: 5120           # MB → converted to GiB
  container_disk: 10240            # MB → converted to GiB (max 10 GiB)
  container_persistent: true       # Stop/resume instead of delete
```


**Required:** `DAYTONA_API_KEY` environment variable.

**Persistence:** When enabled, sandboxes are stopped (not deleted) on cleanup and resumed on next session. Sandbox names follow the pattern `hermes-{task_id}`.

**Disk limit:** Daytona enforces a 10 GiB maximum. Requests above this are capped with a warning.

### Singularity/Apptainer Backend<a href="#singularityapptainer-backend" class="hash-link" aria-label="Direct link to Singularity/Apptainer Backend" translate="no" title="Direct link to Singularity/Apptainer Backend">​</a>

Runs commands in a <a href="https://apptainer.org" target="_blank" rel="noopener noreferrer">Singularity/Apptainer</a> container. Designed for HPC clusters and shared machines where Docker isn't available.


``` prism-code
terminal:
  backend: singularity
  singularity_image: "docker://nikolaik/python-nodejs:python3.11-nodejs20"
  container_cpu: 1                 # CPU cores
  container_memory: 5120           # MB
  container_persistent: true       # Writable overlay persists across sessions
```


**Requirements:** `apptainer` or `singularity` binary in `$PATH`.

**Image handling:** Docker URLs (`docker://...`) are automatically converted to SIF files and cached. Existing `.sif` files are used directly.

**Scratch directory:** Resolved in order: `TERMINAL_SCRATCH_DIR` → `TERMINAL_SANDBOX_DIR/singularity` → `/scratch/$USER/hermes-agent` (HPC convention) → `~/.hermes/sandboxes/singularity`.

**Isolation:** Uses `--containall --no-home` for full namespace isolation without mounting the host home directory.

### Common Terminal Backend Issues<a href="#common-terminal-backend-issues" class="hash-link" aria-label="Direct link to Common Terminal Backend Issues" translate="no" title="Direct link to Common Terminal Backend Issues">​</a>

If terminal commands fail immediately or the terminal tool is reported as disabled:

- **Local** — No special requirements. The safest default when getting started.
- **Docker** — Run `docker version` to verify Docker is working. If it fails, fix Docker or `hermes config set terminal.backend local`.
- **SSH** — Both `TERMINAL_SSH_HOST` and `TERMINAL_SSH_USER` must be set. Hermes logs a clear error if either is missing.
- **Modal** — Needs `MODAL_TOKEN_ID` env var or `~/.modal.toml`. Run `hermes doctor` to check.
- **Daytona** — Needs `DAYTONA_API_KEY`. The Daytona SDK handles server URL configuration.
- **Singularity** — Needs `apptainer` or `singularity` in `$PATH`. Common on HPC clusters.

When in doubt, set `terminal.backend` back to `local` and verify commands run there first.

### Docker Volume Mounts<a href="#docker-volume-mounts" class="hash-link" aria-label="Direct link to Docker Volume Mounts" translate="no" title="Direct link to Docker Volume Mounts">​</a>

When using the Docker backend, `docker_volumes` lets you share host directories with the container. Each entry uses standard Docker `-v` syntax: `host_path:container_path[:options]`.


``` prism-code
terminal:
  backend: docker
  docker_volumes:
    - "/home/user/projects:/workspace/projects"   # Read-write (default)
    - "/home/user/datasets:/data:ro"              # Read-only
    - "/home/user/outputs:/outputs"               # Agent writes, you read
```


This is useful for:

- **Providing files** to the agent (datasets, configs, reference code)
- **Receiving files** from the agent (generated code, reports, exports)
- **Shared workspaces** where both you and the agent access the same files

Can also be set via environment variable: `TERMINAL_DOCKER_VOLUMES='["/host:/container"]'` (JSON array).

### Docker Credential Forwarding<a href="#docker-credential-forwarding" class="hash-link" aria-label="Direct link to Docker Credential Forwarding" translate="no" title="Direct link to Docker Credential Forwarding">​</a>

By default, Docker terminal sessions do not inherit arbitrary host credentials. If you need a specific token inside the container, add it to `terminal.docker_forward_env`.


``` prism-code
terminal:
  backend: docker
  docker_forward_env:
    - "GITHUB_TOKEN"
    - "NPM_TOKEN"
```


Hermes resolves each listed variable from your current shell first, then falls back to `~/.hermes/.env` if it was saved with `hermes config set`.


Anything listed in `docker_forward_env` becomes visible to commands run inside the container. Only forward credentials you are comfortable exposing to the terminal session.


### Optional: Mount the Launch Directory into `/workspace`<a href="#optional-mount-the-launch-directory-into-workspace" class="hash-link" aria-label="Direct link to optional-mount-the-launch-directory-into-workspace" translate="no" title="Direct link to optional-mount-the-launch-directory-into-workspace">​</a>

Docker sandboxes stay isolated by default. Hermes does **not** pass your current host working directory into the container unless you explicitly opt in.

Enable it in `config.yaml`:


``` prism-code
terminal:
  backend: docker
  docker_mount_cwd_to_workspace: true
```


When enabled:

- if you launch Hermes from `~/projects/my-app`, that host directory is bind-mounted to `/workspace`
- the Docker backend starts in `/workspace`
- file tools and terminal commands both see the same mounted project

When disabled, `/workspace` stays sandbox-owned unless you explicitly mount something via `docker_volumes`.

Security tradeoff:

- `false` preserves the sandbox boundary
- `true` gives the sandbox direct access to the directory you launched Hermes from

Use the opt-in only when you intentionally want the container to work on live host files.

### Persistent Shell<a href="#persistent-shell" class="hash-link" aria-label="Direct link to Persistent Shell" translate="no" title="Direct link to Persistent Shell">​</a>

By default, each terminal command runs in its own subprocess — working directory, environment variables, and shell variables reset between commands. When **persistent shell** is enabled, a single long-lived bash process is kept alive across `execute()` calls so that state survives between commands.

This is most useful for the **SSH backend**, where it also eliminates per-command connection overhead. Persistent shell is **enabled by default for SSH** and disabled for the local backend.


``` prism-code
terminal:
  persistent_shell: true   # default — enables persistent shell for SSH
```


To disable:


``` prism-code
hermes config set terminal.persistent_shell false
```


**What persists across commands:**

- Working directory (`cd /tmp` sticks for the next command)
- Exported environment variables (`export FOO=bar`)
- Shell variables (`MY_VAR=hello`)

**Precedence:**

| Level          | Variable                    | Default        |
|----------------|-----------------------------|----------------|
| Config         | `terminal.persistent_shell` | `true`         |
| SSH override   | `TERMINAL_SSH_PERSISTENT`   | follows config |
| Local override | `TERMINAL_LOCAL_PERSISTENT` | `false`        |

Per-backend environment variables take highest precedence. If you want persistent shell on the local backend too:


``` prism-code
export TERMINAL_LOCAL_PERSISTENT=true
```


Commands that require `stdin_data` or sudo automatically fall back to one-shot mode, since the persistent shell's stdin is already occupied by the IPC protocol.


See [Code Execution](/docs/user-guide/features/code-execution) and the [Terminal section of the README](/docs/user-guide/features/tools) for details on each backend.

## Memory Configuration<a href="#memory-configuration" class="hash-link" aria-label="Direct link to Memory Configuration" translate="no" title="Direct link to Memory Configuration">​</a>


``` prism-code
memory:
  memory_enabled: true
  user_profile_enabled: true
  memory_char_limit: 2200   # ~800 tokens
  user_char_limit: 1375     # ~500 tokens
```


## File Read Safety<a href="#file-read-safety" class="hash-link" aria-label="Direct link to File Read Safety" translate="no" title="Direct link to File Read Safety">​</a>

Controls how much content a single `read_file` call can return. Reads that exceed the limit are rejected with an error telling the agent to use `offset` and `limit` for a smaller range. This prevents a single read of a minified JS bundle or large data file from flooding the context window.


``` prism-code
file_read_max_chars: 100000  # default — ~25-35K tokens
```


Raise it if you're on a model with a large context window and frequently read big files. Lower it for small-context models to keep reads efficient:


``` prism-code
# Large context model (200K+)
file_read_max_chars: 200000

# Small local model (16K context)
file_read_max_chars: 30000
```


The agent also deduplicates file reads automatically — if the same file region is read twice and the file hasn't changed, a lightweight stub is returned instead of re-sending the content. This resets on context compression so the agent can re-read files after their content is summarized away.

## Git Worktree Isolation<a href="#git-worktree-isolation" class="hash-link" aria-label="Direct link to Git Worktree Isolation" translate="no" title="Direct link to Git Worktree Isolation">​</a>

Enable isolated git worktrees for running multiple agents in parallel on the same repo:


``` prism-code
worktree: true    # Always create a worktree (same as hermes -w)
# worktree: false # Default — only when -w flag is passed
```


When enabled, each CLI session creates a fresh worktree under `.worktrees/` with its own branch. Agents can edit files, commit, push, and create PRs without interfering with each other. Clean worktrees are removed on exit; dirty ones are kept for manual recovery.

You can also list gitignored files to copy into worktrees via `.worktreeinclude` in your repo root:


``` prism-code
# .worktreeinclude
.env
.venv/
node_modules/
```


## Context Compression<a href="#context-compression" class="hash-link" aria-label="Direct link to Context Compression" translate="no" title="Direct link to Context Compression">​</a>

Hermes automatically compresses long conversations to stay within your model's context window. The compression summarizer is a separate LLM call — you can point it at any provider or endpoint.

All compression settings live in `config.yaml` (no environment variables).

### Full reference<a href="#full-reference" class="hash-link" aria-label="Direct link to Full reference" translate="no" title="Direct link to Full reference">​</a>


``` prism-code
compression:
  enabled: true                                     # Toggle compression on/off
  threshold: 0.50                                   # Compress at this % of context limit
  target_ratio: 0.20                                # Fraction of threshold to preserve as recent tail
  protect_last_n: 20                                # Min recent messages to keep uncompressed
  summary_model: "google/gemini-3-flash-preview"    # Model for summarization
  summary_provider: "auto"                          # Provider: "auto", "openrouter", "nous", "codex", "main", etc.
  summary_base_url: null                            # Custom OpenAI-compatible endpoint (overrides provider)
```


### Common setups<a href="#common-setups" class="hash-link" aria-label="Direct link to Common setups" translate="no" title="Direct link to Common setups">​</a>

**Default (auto-detect) — no configuration needed:**


``` prism-code
compression:
  enabled: true
  threshold: 0.50
```


Uses the first available provider (OpenRouter → Nous → Codex) with Gemini Flash.

**Force a specific provider** (OAuth or API-key based):


``` prism-code
compression:
  summary_provider: nous
  summary_model: gemini-3-flash
```


Works with any provider: `nous`, `openrouter`, `codex`, `anthropic`, `main`, etc.

**Custom endpoint** (self-hosted, Ollama, zai, DeepSeek, etc.):


``` prism-code
compression:
  summary_model: glm-4.7
  summary_base_url: https://api.z.ai/api/coding/paas/v4
```


Points at a custom OpenAI-compatible endpoint. Uses `OPENAI_API_KEY` for auth.

### How the three knobs interact<a href="#how-the-three-knobs-interact" class="hash-link" aria-label="Direct link to How the three knobs interact" translate="no" title="Direct link to How the three knobs interact">​</a>

| `summary_provider`           | `summary_base_url` | Result                                              |
|------------------------------|--------------------|-----------------------------------------------------|
| `auto` (default)             | not set            | Auto-detect best available provider                 |
| `nous` / `openrouter` / etc. | not set            | Force that provider, use its auth                   |
| any                          | set                | Use the custom endpoint directly (provider ignored) |

The `summary_model` must support a context length at least as large as your main model's, since it receives the full middle section of the conversation for compression.

## Iteration Budget Pressure<a href="#iteration-budget-pressure" class="hash-link" aria-label="Direct link to Iteration Budget Pressure" translate="no" title="Direct link to Iteration Budget Pressure">​</a>

When the agent is working on a complex task with many tool calls, it can burn through its iteration budget (default: 90 turns) without realizing it's running low. Budget pressure automatically warns the model as it approaches the limit:

| Threshold | Level   | What the model sees                                         |
|-----------|---------|-------------------------------------------------------------|
| **70%**   | Caution | `[BUDGET: 63/90. 27 iterations left. Start consolidating.]` |
| **90%**   | Warning | `[BUDGET WARNING: 81/90. Only 9 left. Respond NOW.]`        |

Warnings are injected into the last tool result's JSON (as a `_budget_warning` field) rather than as separate messages — this preserves prompt caching and doesn't disrupt the conversation structure.


``` prism-code
agent:
  max_turns: 90                # Max iterations per conversation turn (default: 90)
```


Budget pressure is enabled by default. The agent sees warnings naturally as part of tool results, encouraging it to consolidate its work and deliver a response before running out of iterations.

## Context Pressure Warnings<a href="#context-pressure-warnings" class="hash-link" aria-label="Direct link to Context Pressure Warnings" translate="no" title="Direct link to Context Pressure Warnings">​</a>

Separate from iteration budget pressure, context pressure tracks how close the conversation is to the **compaction threshold** — the point where context compression fires to summarize older messages. This helps both you and the agent understand when the conversation is getting long.

| Progress               | Level   | What happens                                                         |
|------------------------|---------|----------------------------------------------------------------------|
| **≥ 60%** to threshold | Info    | CLI shows a cyan progress bar; gateway sends an informational notice |
| **≥ 85%** to threshold | Warning | CLI shows a bold yellow bar; gateway warns compaction is imminent    |

In the CLI, context pressure appears as a progress bar in the tool output feed:


``` prism-code
  ◐ context ████████████░░░░░░░░ 62% to compaction  48k threshold (50%) · approaching compaction
```


On messaging platforms, a plain-text notification is sent:


``` prism-code
◐ Context: ████████████░░░░░░░░ 62% to compaction (threshold: 50% of window).
```


If auto-compression is disabled, the warning tells you context may be truncated instead.

Context pressure is automatic — no configuration needed. It fires purely as a user-facing notification and does not modify the message stream or inject anything into the model's context.

## Credential Pool Strategies<a href="#credential-pool-strategies" class="hash-link" aria-label="Direct link to Credential Pool Strategies" translate="no" title="Direct link to Credential Pool Strategies">​</a>

When you have multiple API keys or OAuth tokens for the same provider, configure the rotation strategy:


``` prism-code
credential_pool_strategies:
  openrouter: round_robin    # cycle through keys evenly
  anthropic: least_used      # always pick the least-used key
```


Options: `fill_first` (default), `round_robin`, `least_used`, `random`. See [Credential Pools](/docs/user-guide/features/credential-pools) for full documentation.

## Auxiliary Models<a href="#auxiliary-models" class="hash-link" aria-label="Direct link to Auxiliary Models" translate="no" title="Direct link to Auxiliary Models">​</a>

Hermes uses lightweight "auxiliary" models for side tasks like image analysis, web page summarization, and browser screenshot analysis. By default, these use **Gemini Flash** via auto-detection — you don't need to configure anything.

### The universal config pattern<a href="#the-universal-config-pattern" class="hash-link" aria-label="Direct link to The universal config pattern" translate="no" title="Direct link to The universal config pattern">​</a>

Every model slot in Hermes — auxiliary tasks, compression, fallback — uses the same three knobs:

| Key        | What it does                                           | Default            |
|------------|--------------------------------------------------------|--------------------|
| `provider` | Which provider to use for auth and routing             | `"auto"`           |
| `model`    | Which model to request                                 | provider's default |
| `base_url` | Custom OpenAI-compatible endpoint (overrides provider) | not set            |

When `base_url` is set, Hermes ignores the provider and calls that endpoint directly (using `api_key` or `OPENAI_API_KEY` for auth). When only `provider` is set, Hermes uses that provider's built-in auth and base URL.

Available providers: `auto`, `openrouter`, `nous`, `codex`, `copilot`, `anthropic`, `main`, `zai`, `kimi-coding`, `minimax`, and any provider registered in the [provider registry](/docs/reference/environment-variables).

### Full auxiliary config reference<a href="#full-auxiliary-config-reference" class="hash-link" aria-label="Direct link to Full auxiliary config reference" translate="no" title="Direct link to Full auxiliary config reference">​</a>


``` prism-code
auxiliary:
  # Image analysis (vision_analyze tool + browser screenshots)
  vision:
    provider: "auto"           # "auto", "openrouter", "nous", "codex", "main", etc.
    model: ""                  # e.g. "openai/gpt-4o", "google/gemini-2.5-flash"
    base_url: ""               # Custom OpenAI-compatible endpoint (overrides provider)
    api_key: ""                # API key for base_url (falls back to OPENAI_API_KEY)
    timeout: 30                # seconds — LLM API call; increase for slow local vision models
    download_timeout: 30       # seconds — image HTTP download; increase for slow connections

  # Web page summarization + browser page text extraction
  web_extract:
    provider: "auto"
    model: ""                  # e.g. "google/gemini-2.5-flash"
    base_url: ""
    api_key: ""
    timeout: 30                # seconds

  # Dangerous command approval classifier
  approval:
    provider: "auto"
    model: ""
    base_url: ""
    api_key: ""
    timeout: 30                # seconds

  # Context compression timeout (separate from compression.* config)
  compression:
    timeout: 120               # seconds — compression summarizes long conversations, needs more time

  # Session search — summarizes past session matches
  session_search:
    provider: "auto"
    model: ""
    base_url: ""
    api_key: ""
    timeout: 30

  # Skills hub — skill matching and search
  skills_hub:
    provider: "auto"
    model: ""
    base_url: ""
    api_key: ""
    timeout: 30

  # MCP tool dispatch
  mcp:
    provider: "auto"
    model: ""
    base_url: ""
    api_key: ""
    timeout: 30

  # Memory flush — summarizes conversation for persistent memory
  flush_memories:
    provider: "auto"
    model: ""
    base_url: ""
    api_key: ""
    timeout: 30
```


Each auxiliary task has a configurable `timeout` (in seconds). Defaults: vision 30s, web_extract 30s, approval 30s, compression 120s. Increase these if you use slow local models for auxiliary tasks. Vision also has a separate `download_timeout` (default 30s) for the HTTP image download — increase this for slow connections or self-hosted image servers.


Context compression has its own top-level `compression:` block with `summary_provider`, `summary_model`, and `summary_base_url` — see [Context Compression](#context-compression) above. The fallback model uses a `fallback_model:` block — see [Fallback Model](/docs/integrations/providers#fallback-model). All three follow the same provider/model/base_url pattern.


### Changing the Vision Model<a href="#changing-the-vision-model" class="hash-link" aria-label="Direct link to Changing the Vision Model" translate="no" title="Direct link to Changing the Vision Model">​</a>

To use GPT-4o instead of Gemini Flash for image analysis:


``` prism-code
auxiliary:
  vision:
    model: "openai/gpt-4o"
```


Or via environment variable (in `~/.hermes/.env`):


``` prism-code
AUXILIARY_VISION_MODEL=openai/gpt-4o
```


### Provider Options<a href="#provider-options" class="hash-link" aria-label="Direct link to Provider Options" translate="no" title="Direct link to Provider Options">​</a>

| Provider       | Description                                                                                                                                                                                                                      | Requirements                           |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------|
| `"auto"`       | Best available (default). Vision tries OpenRouter → Nous → Codex.                                                                                                                                                                | —                                      |
| `"openrouter"` | Force OpenRouter — routes to any model (Gemini, GPT-4o, Claude, etc.)                                                                                                                                                            | `OPENROUTER_API_KEY`                   |
| `"nous"`       | Force Nous Portal                                                                                                                                                                                                                | `hermes login`                         |
| `"codex"`      | Force Codex OAuth (ChatGPT account). Supports vision (gpt-5.3-codex).                                                                                                                                                            | `hermes model` → Codex                 |
| `"main"`       | Use your active custom/main endpoint. This can come from `OPENAI_BASE_URL` + `OPENAI_API_KEY` or from a custom endpoint saved via `hermes model` / `config.yaml`. Works with OpenAI, local models, or any OpenAI-compatible API. | Custom endpoint credentials + base URL |

### Common Setups<a href="#common-setups-1" class="hash-link" aria-label="Direct link to Common Setups" translate="no" title="Direct link to Common Setups">​</a>

**Using a direct custom endpoint** (clearer than `provider: "main"` for local/self-hosted APIs):


``` prism-code
auxiliary:
  vision:
    base_url: "http://localhost:1234/v1"
    api_key: "local-key"
    model: "qwen2.5-vl"
```


`base_url` takes precedence over `provider`, so this is the most explicit way to route an auxiliary task to a specific endpoint. For direct endpoint overrides, Hermes uses the configured `api_key` or falls back to `OPENAI_API_KEY`; it does not reuse `OPENROUTER_API_KEY` for that custom endpoint.

**Using OpenAI API key for vision:**


``` prism-code
# In ~/.hermes/.env:
# OPENAI_BASE_URL=https://api.openai.com/v1
# OPENAI_API_KEY=sk-...

auxiliary:
  vision:
    provider: "main"
    model: "gpt-4o"       # or "gpt-4o-mini" for cheaper
```


**Using OpenRouter for vision** (route to any model):


``` prism-code
auxiliary:
  vision:
    provider: "openrouter"
    model: "openai/gpt-4o"      # or "google/gemini-2.5-flash", etc.
```


**Using Codex OAuth** (ChatGPT Pro/Plus account — no API key needed):


``` prism-code
auxiliary:
  vision:
    provider: "codex"     # uses your ChatGPT OAuth token
    # model defaults to gpt-5.3-codex (supports vision)
```


**Using a local/self-hosted model:**


``` prism-code
auxiliary:
  vision:
    provider: "main"      # uses your active custom endpoint
    model: "my-local-model"
```


`provider: "main"` follows the same custom endpoint Hermes uses for normal chat. That endpoint can be set directly with `OPENAI_BASE_URL`, or saved once through `hermes model` and persisted in `config.yaml`.


If you use Codex OAuth as your main model provider, vision works automatically — no extra configuration needed. Codex is included in the auto-detection chain for vision.


**Vision requires a multimodal model.** If you set `provider: "main"`, make sure your endpoint supports multimodal/vision — otherwise image analysis will fail.


### Environment Variables (legacy)<a href="#environment-variables-legacy" class="hash-link" aria-label="Direct link to Environment Variables (legacy)" translate="no" title="Direct link to Environment Variables (legacy)">​</a>

Auxiliary models can also be configured via environment variables. However, `config.yaml` is the preferred method — it's easier to manage and supports all options including `base_url` and `api_key`.

| Setting              | Environment Variable             |
|----------------------|----------------------------------|
| Vision provider      | `AUXILIARY_VISION_PROVIDER`      |
| Vision model         | `AUXILIARY_VISION_MODEL`         |
| Vision endpoint      | `AUXILIARY_VISION_BASE_URL`      |
| Vision API key       | `AUXILIARY_VISION_API_KEY`       |
| Web extract provider | `AUXILIARY_WEB_EXTRACT_PROVIDER` |
| Web extract model    | `AUXILIARY_WEB_EXTRACT_MODEL`    |
| Web extract endpoint | `AUXILIARY_WEB_EXTRACT_BASE_URL` |
| Web extract API key  | `AUXILIARY_WEB_EXTRACT_API_KEY`  |

Compression and fallback model settings are config.yaml-only.


Run `hermes config` to see your current auxiliary model settings. Overrides only show up when they differ from the defaults.


## Reasoning Effort<a href="#reasoning-effort" class="hash-link" aria-label="Direct link to Reasoning Effort" translate="no" title="Direct link to Reasoning Effort">​</a>

Control how much "thinking" the model does before responding:


``` prism-code
agent:
  reasoning_effort: ""   # empty = medium (default). Options: xhigh (max), high, medium, low, minimal, none
```


When unset (default), reasoning effort defaults to "medium" — a balanced level that works well for most tasks. Setting a value overrides it — higher reasoning effort gives better results on complex tasks at the cost of more tokens and latency.

You can also change the reasoning effort at runtime with the `/reasoning` command:


``` prism-code
/reasoning           # Show current effort level and display state
/reasoning high      # Set reasoning effort to high
/reasoning none      # Disable reasoning
/reasoning show      # Show model thinking above each response
/reasoning hide      # Hide model thinking
```


## Tool-Use Enforcement<a href="#tool-use-enforcement" class="hash-link" aria-label="Direct link to Tool-Use Enforcement" translate="no" title="Direct link to Tool-Use Enforcement">​</a>

Some models (especially GPT-family) occasionally describe intended actions as text instead of making tool calls. Tool-use enforcement injects guidance that steers the model back to actually calling tools.


``` prism-code
agent:
  tool_use_enforcement: "auto"   # "auto" | true | false | ["model-substring", ...]
```


| Value                             | Behavior                                                                    |
|-----------------------------------|-----------------------------------------------------------------------------|
| `"auto"` (default)                | Enabled for GPT models (`gpt-`, `openai/gpt-`) and disabled for all others. |
| `true`                            | Always enabled for all models.                                              |
| `false`                           | Always disabled.                                                            |
| `["gpt-", "o1-", "custom-model"]` | Enabled only for models whose name contains one of the listed substrings.   |

When enabled, the system prompt includes guidance reminding the model to make actual tool calls rather than describing what it would do. This is transparent to the user and has no effect on models that already use tools reliably.

## TTS Configuration<a href="#tts-configuration" class="hash-link" aria-label="Direct link to TTS Configuration" translate="no" title="Direct link to TTS Configuration">​</a>


``` prism-code
tts:
  provider: "edge"              # "edge" | "elevenlabs" | "openai" | "neutts"
  edge:
    voice: "en-US-AriaNeural"   # 322 voices, 74 languages
  elevenlabs:
    voice_id: "pNInz6obpgDQGcFmaJgB"
    model_id: "eleven_multilingual_v2"
  openai:
    model: "gpt-4o-mini-tts"
    voice: "alloy"              # alloy, echo, fable, onyx, nova, shimmer
    base_url: "https://api.openai.com/v1"  # Override for OpenAI-compatible TTS endpoints
  neutts:
    ref_audio: ''
    ref_text: ''
    model: neuphonic/neutts-air-q4-gguf
    device: cpu
```


This controls both the `text_to_speech` tool and spoken replies in voice mode (`/voice tts` in the CLI or messaging gateway).

## Display Settings<a href="#display-settings" class="hash-link" aria-label="Direct link to Display Settings" translate="no" title="Direct link to Display Settings">​</a>


``` prism-code
display:
  tool_progress: all      # off | new | all | verbose
  tool_progress_command: false  # Enable /verbose slash command in messaging gateway
  skin: default           # Built-in or custom CLI skin (see user-guide/features/skins)
  theme_mode: auto        # auto | light | dark — color scheme for skin-aware rendering
  personality: "kawaii"  # Legacy cosmetic field still surfaced in some summaries
  compact: false          # Compact output mode (less whitespace)
  resume_display: full    # full (show previous messages on resume) | minimal (one-liner only)
  bell_on_complete: false # Play terminal bell when agent finishes (great for long tasks)
  show_reasoning: false   # Show model reasoning/thinking above each response (toggle with /reasoning show|hide)
  streaming: false        # Stream tokens to terminal as they arrive (real-time output)
  background_process_notifications: all  # all | result | error | off (gateway only)
  show_cost: false        # Show estimated $ cost in the CLI status bar
  tool_preview_length: 0  # Max chars for tool call previews (0 = no limit, show full paths/commands)
```


### Theme mode<a href="#theme-mode" class="hash-link" aria-label="Direct link to Theme mode" translate="no" title="Direct link to Theme mode">​</a>

The `theme_mode` setting controls whether skins render in light or dark mode:

| Mode             | Behavior                                                                                                                              |
|------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| `auto` (default) | Detects your terminal's background color automatically. Falls back to `dark` if detection fails.                                      |
| `light`          | Forces light-mode skin colors. Skins that define a `colors_light` override use those colors instead of the default dark-mode palette. |
| `dark`           | Forces dark-mode skin colors.                                                                                                         |

This works with any skin — built-in or custom. Skin authors can provide `colors_light` in their skin definition for optimal light-terminal appearance.

| Mode      | What you see                                   |
|-----------|------------------------------------------------|
| `off`     | Silent — just the final response               |
| `new`     | Tool indicator only when the tool changes      |
| `all`     | Every tool call with a short preview (default) |
| `verbose` | Full args, results, and debug logs             |

In the CLI, cycle through these modes with `/verbose`. To use `/verbose` in messaging platforms (Telegram, Discord, Slack, etc.), set `tool_progress_command: true` in the `display` section above. The command will then cycle the mode and save to config.

## Privacy<a href="#privacy" class="hash-link" aria-label="Direct link to Privacy" translate="no" title="Direct link to Privacy">​</a>


``` prism-code
privacy:
  redact_pii: false  # Strip PII from LLM context (gateway only)
```


When `redact_pii` is `true`, the gateway redacts personally identifiable information from the system prompt before sending it to the LLM on supported platforms:

| Field                                      | Treatment                                                             |
|--------------------------------------------|-----------------------------------------------------------------------|
| Phone numbers (user ID on WhatsApp/Signal) | Hashed to `user_<12-char-sha256>`                                     |
| User IDs                                   | Hashed to `user_<12-char-sha256>`                                     |
| Chat IDs                                   | Numeric portion hashed, platform prefix preserved (`telegram:<hash>`) |
| Home channel IDs                           | Numeric portion hashed                                                |
| User names / usernames                     | **Not affected** (user-chosen, publicly visible)                      |

**Platform support:** Redaction applies to WhatsApp, Signal, and Telegram. Discord and Slack are excluded because their mention systems (`<@user_id>`) require the real ID in the LLM context.

Hashes are deterministic — the same user always maps to the same hash, so the model can still distinguish between users in group chats. Routing and delivery use the original values internally.

## Speech-to-Text (STT)<a href="#speech-to-text-stt" class="hash-link" aria-label="Direct link to Speech-to-Text (STT)" translate="no" title="Direct link to Speech-to-Text (STT)">​</a>


``` prism-code
stt:
  provider: "local"            # "local" | "groq" | "openai"
  local:
    model: "base"              # tiny, base, small, medium, large-v3
  openai:
    model: "whisper-1"         # whisper-1 | gpt-4o-mini-transcribe | gpt-4o-transcribe
  # model: "whisper-1"         # Legacy fallback key still respected
```


Provider behavior:

- `local` uses `faster-whisper` running on your machine. Install it separately with `pip install faster-whisper`.
- `groq` uses Groq's Whisper-compatible endpoint and reads `GROQ_API_KEY`.
- `openai` uses the OpenAI speech API and reads `VOICE_TOOLS_OPENAI_KEY`.

If the requested provider is unavailable, Hermes falls back automatically in this order: `local` → `groq` → `openai`.

Groq and OpenAI model overrides are environment-driven:


``` prism-code
STT_GROQ_MODEL=whisper-large-v3-turbo
STT_OPENAI_MODEL=whisper-1
GROQ_BASE_URL=https://api.groq.com/openai/v1
STT_OPENAI_BASE_URL=https://api.openai.com/v1
```


## Voice Mode (CLI)<a href="#voice-mode-cli" class="hash-link" aria-label="Direct link to Voice Mode (CLI)" translate="no" title="Direct link to Voice Mode (CLI)">​</a>


``` prism-code
voice:
  record_key: "ctrl+b"         # Push-to-talk key inside the CLI
  max_recording_seconds: 120    # Hard stop for long recordings
  auto_tts: false               # Enable spoken replies automatically when /voice on
  silence_threshold: 200        # RMS threshold for speech detection
  silence_duration: 3.0         # Seconds of silence before auto-stop
```


Use `/voice on` in the CLI to enable microphone mode, `record_key` to start/stop recording, and `/voice tts` to toggle spoken replies. See [Voice Mode](/docs/user-guide/features/voice-mode) for end-to-end setup and platform-specific behavior.

## Streaming<a href="#streaming" class="hash-link" aria-label="Direct link to Streaming" translate="no" title="Direct link to Streaming">​</a>

Stream tokens to the terminal or messaging platforms as they arrive, instead of waiting for the full response.

### CLI Streaming<a href="#cli-streaming" class="hash-link" aria-label="Direct link to CLI Streaming" translate="no" title="Direct link to CLI Streaming">​</a>


``` prism-code
display:
  streaming: true         # Stream tokens to terminal in real-time
  show_reasoning: true    # Also stream reasoning/thinking tokens (optional)
```


When enabled, responses appear token-by-token inside a streaming box. Tool calls are still captured silently. If the provider doesn't support streaming, it falls back to the normal display automatically.

### Gateway Streaming (Telegram, Discord, Slack)<a href="#gateway-streaming-telegram-discord-slack" class="hash-link" aria-label="Direct link to Gateway Streaming (Telegram, Discord, Slack)" translate="no" title="Direct link to Gateway Streaming (Telegram, Discord, Slack)">​</a>


``` prism-code
streaming:
  enabled: true           # Enable progressive message editing
  transport: edit         # "edit" (progressive message editing) or "off"
  edit_interval: 0.3      # Seconds between message edits
  buffer_threshold: 40    # Characters before forcing an edit flush
  cursor: " ▉"            # Cursor shown during streaming
```


When enabled, the bot sends a message on the first token, then progressively edits it as more tokens arrive. Platforms that don't support message editing (Signal, Email, Home Assistant) are auto-detected on the first attempt — streaming is gracefully disabled for that session with no flood of messages.

**Overflow handling:** If the streamed text exceeds the platform's message length limit (~4096 chars), the current message is finalized and a new one starts automatically.


Streaming is disabled by default. Enable it in `~/.hermes/config.yaml` to try the streaming UX.


## Group Chat Session Isolation<a href="#group-chat-session-isolation" class="hash-link" aria-label="Direct link to Group Chat Session Isolation" translate="no" title="Direct link to Group Chat Session Isolation">​</a>

Control whether shared chats keep one conversation per room or one conversation per participant:


``` prism-code
group_sessions_per_user: true  # true = per-user isolation in groups/channels, false = one shared session per chat
```


- `true` is the default and recommended setting. In Discord channels, Telegram groups, Slack channels, and similar shared contexts, each sender gets their own session when the platform provides a user ID.
- `false` reverts to the old shared-room behavior. That can be useful if you explicitly want Hermes to treat a channel like one collaborative conversation, but it also means users share context, token costs, and interrupt state.
- Direct messages are unaffected. Hermes still keys DMs by chat/DM ID as usual.
- Threads stay isolated from their parent channel either way; with `true`, each participant also gets their own session inside the thread.

For the behavior details and examples, see [Sessions](/docs/user-guide/sessions) and the [Discord guide](/docs/user-guide/messaging/discord).

## Unauthorized DM Behavior<a href="#unauthorized-dm-behavior" class="hash-link" aria-label="Direct link to Unauthorized DM Behavior" translate="no" title="Direct link to Unauthorized DM Behavior">​</a>

Control what Hermes does when an unknown user sends a direct message:


``` prism-code
unauthorized_dm_behavior: pair

whatsapp:
  unauthorized_dm_behavior: ignore
```


- `pair` is the default. Hermes denies access, but replies with a one-time pairing code in DMs.
- `ignore` silently drops unauthorized DMs.
- Platform sections override the global default, so you can keep pairing enabled broadly while making one platform quieter.

## Quick Commands<a href="#quick-commands" class="hash-link" aria-label="Direct link to Quick Commands" translate="no" title="Direct link to Quick Commands">​</a>

Define custom commands that run shell commands without invoking the LLM — zero token usage, instant execution. Especially useful from messaging platforms (Telegram, Discord, etc.) for quick server checks or utility scripts.


``` prism-code
quick_commands:
  status:
    type: exec
    command: systemctl status hermes-agent
  disk:
    type: exec
    command: df -h /
  update:
    type: exec
    command: cd ~/.hermes/hermes-agent && git pull && pip install -e .
  gpu:
    type: exec
    command: nvidia-smi --query-gpu=name,utilization.gpu,memory.used,memory.total --format=csv,noheader
```


Usage: type `/status`, `/disk`, `/update`, or `/gpu` in the CLI or any messaging platform. The command runs locally on the host and returns the output directly — no LLM call, no tokens consumed.

- **30-second timeout** — long-running commands are killed with an error message
- **Priority** — quick commands are checked before skill commands, so you can override skill names
- **Autocomplete** — quick commands are resolved at dispatch time and are not shown in the built-in slash-command autocomplete tables
- **Type** — only `exec` is supported (runs a shell command); other types show an error
- **Works everywhere** — CLI, Telegram, Discord, Slack, WhatsApp, Signal, Email, Home Assistant

## Human Delay<a href="#human-delay" class="hash-link" aria-label="Direct link to Human Delay" translate="no" title="Direct link to Human Delay">​</a>

Simulate human-like response pacing in messaging platforms:


``` prism-code
human_delay:
  mode: "off"                  # off | natural | custom
  min_ms: 800                  # Minimum delay (custom mode)
  max_ms: 2500                 # Maximum delay (custom mode)
```


## Code Execution<a href="#code-execution" class="hash-link" aria-label="Direct link to Code Execution" translate="no" title="Direct link to Code Execution">​</a>

Configure the sandboxed Python code execution tool:


``` prism-code
code_execution:
  timeout: 300                 # Max execution time in seconds
  max_tool_calls: 50           # Max tool calls within code execution
```


## Web Search Backends<a href="#web-search-backends" class="hash-link" aria-label="Direct link to Web Search Backends" translate="no" title="Direct link to Web Search Backends">​</a>

The `web_search`, `web_extract`, and `web_crawl` tools support four backend providers. Configure the backend in `config.yaml` or via `hermes tools`:


``` prism-code
web:
  backend: firecrawl    # firecrawl | parallel | tavily | exa
```


| Backend                 | Env Var             | Search | Extract | Crawl |
|-------------------------|---------------------|--------|---------|-------|
| **Firecrawl** (default) | `FIRECRAWL_API_KEY` | ✔      | ✔       | ✔     |
| **Parallel**            | `PARALLEL_API_KEY`  | ✔      | ✔       | —     |
| **Tavily**              | `TAVILY_API_KEY`    | ✔      | ✔       | ✔     |
| **Exa**                 | `EXA_API_KEY`       | ✔      | ✔       | —     |

**Backend selection:** If `web.backend` is not set, the backend is auto-detected from available API keys. If only `EXA_API_KEY` is set, Exa is used. If only `TAVILY_API_KEY` is set, Tavily is used. If only `PARALLEL_API_KEY` is set, Parallel is used. Otherwise Firecrawl is the default.

**Self-hosted Firecrawl:** Set `FIRECRAWL_API_URL` to point at your own instance. When a custom URL is set, the API key becomes optional (set `USE_DB_AUTHENTICATION=false` on the server to disable auth).

**Parallel search modes:** Set `PARALLEL_SEARCH_MODE` to control search behavior — `fast`, `one-shot`, or `agentic` (default: `agentic`).

## Browser<a href="#browser" class="hash-link" aria-label="Direct link to Browser" translate="no" title="Direct link to Browser">​</a>

Configure browser automation behavior:


``` prism-code
browser:
  inactivity_timeout: 120        # Seconds before auto-closing idle sessions
  command_timeout: 30             # Timeout in seconds for browser commands (screenshot, navigate, etc.)
  record_sessions: false         # Auto-record browser sessions as WebM videos to ~/.hermes/browser_recordings/
```


The browser toolset supports multiple providers. See the [Browser feature page](/docs/user-guide/features/browser) for details on Browserbase, Browser Use, and local Chrome CDP setup.

## Timezone<a href="#timezone" class="hash-link" aria-label="Direct link to Timezone" translate="no" title="Direct link to Timezone">​</a>

Override the server-local timezone with an IANA timezone string. Affects timestamps in logs, cron scheduling, and system prompt time injection.


``` prism-code
timezone: "America/New_York"   # IANA timezone (default: "" = server-local time)
```


Supported values: any IANA timezone identifier (e.g. `America/New_York`, `Europe/London`, `Asia/Kolkata`, `UTC`). Leave empty or omit for server-local time.

## Discord<a href="#discord" class="hash-link" aria-label="Direct link to Discord" translate="no" title="Direct link to Discord">​</a>

Configure Discord-specific behavior for the messaging gateway:


``` prism-code
discord:
  require_mention: true          # Require @mention to respond in server channels
  free_response_channels: ""     # Comma-separated channel IDs where bot responds without @mention
  auto_thread: true              # Auto-create threads on @mention in channels
```


- `require_mention` — when `true` (default), the bot only responds in server channels when mentioned with `@BotName`. DMs always work without mention.
- `free_response_channels` — comma-separated list of channel IDs where the bot responds to every message without requiring a mention.
- `auto_thread` — when `true` (default), mentions in channels automatically create a thread for the conversation, keeping channels clean (similar to Slack threading).

## Security<a href="#security" class="hash-link" aria-label="Direct link to Security" translate="no" title="Direct link to Security">​</a>

Pre-execution security scanning and secret redaction:


``` prism-code
security:
  redact_secrets: true           # Redact API key patterns in tool output and logs
  tirith_enabled: true           # Enable Tirith security scanning for terminal commands
  tirith_path: "tirith"          # Path to tirith binary (default: "tirith" in $PATH)
  tirith_timeout: 5              # Seconds to wait for tirith scan before timing out
  tirith_fail_open: true         # Allow command execution if tirith is unavailable
  website_blocklist:             # See Website Blocklist section below
    enabled: false
    domains: []
    shared_files: []
```


- `redact_secrets` — automatically detects and redacts patterns that look like API keys, tokens, and passwords in tool output before it enters the conversation context and logs.
- `tirith_enabled` — when `true`, terminal commands are scanned by <a href="https://github.com/StackGuardian/tirith" target="_blank" rel="noopener noreferrer">Tirith</a> before execution to detect potentially dangerous operations.
- `tirith_path` — path to the tirith binary. Set this if tirith is installed in a non-standard location.
- `tirith_timeout` — maximum seconds to wait for a tirith scan. Commands proceed if the scan times out.
- `tirith_fail_open` — when `true` (default), commands are allowed to execute if tirith is unavailable or fails. Set to `false` to block commands when tirith cannot verify them.

## Website Blocklist<a href="#website-blocklist" class="hash-link" aria-label="Direct link to Website Blocklist" translate="no" title="Direct link to Website Blocklist">​</a>

Block specific domains from being accessed by the agent's web and browser tools:


``` prism-code
security:
  website_blocklist:
    enabled: false               # Enable URL blocking (default: false)
    domains:                     # List of blocked domain patterns
      - "*.internal.company.com"
      - "admin.example.com"
      - "*.local"
    shared_files:                # Load additional rules from external files
      - "/etc/hermes/blocked-sites.txt"
```


When enabled, any URL matching a blocked domain pattern is rejected before the web or browser tool executes. This applies to `web_search`, `web_extract`, `browser_navigate`, and any tool that accesses URLs.

Domain rules support:

- Exact domains: `admin.example.com`
- Wildcard subdomains: `*.internal.company.com` (blocks all subdomains)
- TLD wildcards: `*.local`

Shared files contain one domain rule per line (blank lines and `#` comments are ignored). Missing or unreadable files log a warning but don't disable other web tools.

The policy is cached for 30 seconds, so config changes take effect quickly without restart.

## Smart Approvals<a href="#smart-approvals" class="hash-link" aria-label="Direct link to Smart Approvals" translate="no" title="Direct link to Smart Approvals">​</a>

Control how Hermes handles potentially dangerous commands:


``` prism-code
approvals:
  mode: manual   # manual | smart | off
```


| Mode               | Behavior                                                                                                                                                                                                |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `manual` (default) | Prompt the user before executing any flagged command. In the CLI, shows an interactive approval dialog. In messaging, queues a pending approval request.                                                |
| `smart`            | Use an auxiliary LLM to assess whether a flagged command is actually dangerous. Low-risk commands are auto-approved with session-level persistence. Genuinely risky commands are escalated to the user. |
| `off`              | Skip all approval checks. Equivalent to `HERMES_YOLO_MODE=true`. **Use with caution.**                                                                                                                  |

Smart mode is particularly useful for reducing approval fatigue — it lets the agent work more autonomously on safe operations while still catching genuinely destructive commands.


Setting `approvals.mode: off` disables all safety checks for terminal commands. Only use this in trusted, sandboxed environments.


## Checkpoints<a href="#checkpoints" class="hash-link" aria-label="Direct link to Checkpoints" translate="no" title="Direct link to Checkpoints">​</a>

Automatic filesystem snapshots before destructive file operations. See the [Checkpoints & Rollback](/docs/user-guide/checkpoints-and-rollback) for details.


``` prism-code
checkpoints:
  enabled: true                  # Enable automatic checkpoints (also: hermes --checkpoints)
  max_snapshots: 50              # Max checkpoints to keep per directory
```


## Delegation<a href="#delegation" class="hash-link" aria-label="Direct link to Delegation" translate="no" title="Direct link to Delegation">​</a>

Configure subagent behavior for the delegate tool:


``` prism-code
delegation:
  # model: "google/gemini-3-flash-preview"  # Override model (empty = inherit parent)
  # provider: "openrouter"                  # Override provider (empty = inherit parent)
  # base_url: "http://localhost:1234/v1"    # Direct OpenAI-compatible endpoint (takes precedence over provider)
  # api_key: "local-key"                    # API key for base_url (falls back to OPENAI_API_KEY)
```


**Subagent provider:model override:** By default, subagents inherit the parent agent's provider and model. Set `delegation.provider` and `delegation.model` to route subagents to a different provider:model pair — e.g., use a cheap/fast model for narrowly-scoped subtasks while your primary agent runs an expensive reasoning model.

**Direct endpoint override:** If you want the obvious custom-endpoint path, set `delegation.base_url`, `delegation.api_key`, and `delegation.model`. That sends subagents directly to that OpenAI-compatible endpoint and takes precedence over `delegation.provider`. If `delegation.api_key` is omitted, Hermes falls back to `OPENAI_API_KEY` only.

The delegation provider uses the same credential resolution as CLI/gateway startup. All configured providers are supported: `openrouter`, `nous`, `copilot`, `zai`, `kimi-coding`, `minimax`, `minimax-cn`. When a provider is set, the system automatically resolves the correct base URL, API key, and API mode — no manual credential wiring needed.

**Precedence:** `delegation.base_url` in config → `delegation.provider` in config → parent provider (inherited). `delegation.model` in config → parent model (inherited). Setting just `model` without `provider` changes only the model name while keeping the parent's credentials (useful for switching models within the same provider like OpenRouter).

## Clarify<a href="#clarify" class="hash-link" aria-label="Direct link to Clarify" translate="no" title="Direct link to Clarify">​</a>

Configure the clarification prompt behavior:


``` prism-code
clarify:
  timeout: 120                 # Seconds to wait for user clarification response
```


## Context Files (SOUL.md, AGENTS.md)<a href="#context-files-soulmd-agentsmd" class="hash-link" aria-label="Direct link to Context Files (SOUL.md, AGENTS.md)" translate="no" title="Direct link to Context Files (SOUL.md, AGENTS.md)">​</a>

Hermes uses two different context scopes:

| File                       | Purpose                                                                               | Scope                                         |
|----------------------------|---------------------------------------------------------------------------------------|-----------------------------------------------|
| `SOUL.md`                  | **Primary agent identity** — defines who the agent is (slot \#1 in the system prompt) | `~/.hermes/SOUL.md` or `$HERMES_HOME/SOUL.md` |
| `.hermes.md` / `HERMES.md` | Project-specific instructions (highest priority)                                      | Walks to git root                             |
| `AGENTS.md`                | Project-specific instructions, coding conventions                                     | Recursive directory walk                      |
| `CLAUDE.md`                | Claude Code context files (also detected)                                             | Working directory only                        |
| `.cursorrules`             | Cursor IDE rules (also detected)                                                      | Working directory only                        |
| `.cursor/rules/*.mdc`      | Cursor rule files (also detected)                                                     | Working directory only                        |

- **SOUL.md** is the agent's primary identity. It occupies slot \#1 in the system prompt, completely replacing the built-in default identity. Edit it to fully customize who the agent is.
- If SOUL.md is missing, empty, or cannot be loaded, Hermes falls back to a built-in default identity.
- **Project context files use a priority system** — only ONE type is loaded (first match wins): `.hermes.md` → `AGENTS.md` → `CLAUDE.md` → `.cursorrules`. SOUL.md is always loaded independently.
- **AGENTS.md** is hierarchical: if subdirectories also have AGENTS.md, all are combined.
- Hermes automatically seeds a default `SOUL.md` if one does not already exist.
- All loaded context files are capped at 20,000 characters with smart truncation.

See also:

- [Personality & SOUL.md](/docs/user-guide/features/personality)
- [Context Files](/docs/user-guide/features/context-files)

## Working Directory<a href="#working-directory" class="hash-link" aria-label="Direct link to Working Directory" translate="no" title="Direct link to Working Directory">​</a>

| Context                                | Default                                                      |
|----------------------------------------|--------------------------------------------------------------|
| **CLI (`hermes`)**                     | Current directory where you run the command                  |
| **Messaging gateway**                  | Home directory `~` (override with `MESSAGING_CWD`)           |
| **Docker / Singularity / Modal / SSH** | User's home directory inside the container or remote machine |

Override the working directory:


``` prism-code
# In ~/.hermes/.env or ~/.hermes/config.yaml:
MESSAGING_CWD=/home/myuser/projects    # Gateway sessions
TERMINAL_CWD=/workspace                # All terminal sessions
```


- <a href="#directory-structure" class="table-of-contents__link toc-highlight">Directory Structure</a>
- <a href="#managing-configuration" class="table-of-contents__link toc-highlight">Managing Configuration</a>
- <a href="#configuration-precedence" class="table-of-contents__link toc-highlight">Configuration Precedence</a>
- <a href="#environment-variable-substitution" class="table-of-contents__link toc-highlight">Environment Variable Substitution</a>
- <a href="#terminal-backend-configuration" class="table-of-contents__link toc-highlight">Terminal Backend Configuration</a>
  - <a href="#backend-overview" class="table-of-contents__link toc-highlight">Backend Overview</a>
  - <a href="#local-backend" class="table-of-contents__link toc-highlight">Local Backend</a>
  - <a href="#docker-backend" class="table-of-contents__link toc-highlight">Docker Backend</a>
  - <a href="#ssh-backend" class="table-of-contents__link toc-highlight">SSH Backend</a>
  - <a href="#modal-backend" class="table-of-contents__link toc-highlight">Modal Backend</a>
  - <a href="#daytona-backend" class="table-of-contents__link toc-highlight">Daytona Backend</a>
  - <a href="#singularityapptainer-backend" class="table-of-contents__link toc-highlight">Singularity/Apptainer Backend</a>
  - <a href="#common-terminal-backend-issues" class="table-of-contents__link toc-highlight">Common Terminal Backend Issues</a>
  - <a href="#docker-volume-mounts" class="table-of-contents__link toc-highlight">Docker Volume Mounts</a>
  - <a href="#docker-credential-forwarding" class="table-of-contents__link toc-highlight">Docker Credential Forwarding</a>
  - <a href="#optional-mount-the-launch-directory-into-workspace" class="table-of-contents__link toc-highlight">Optional: Mount the Launch Directory into <code>/workspace</code></a>
  - <a href="#persistent-shell" class="table-of-contents__link toc-highlight">Persistent Shell</a>
- <a href="#memory-configuration" class="table-of-contents__link toc-highlight">Memory Configuration</a>
- <a href="#file-read-safety" class="table-of-contents__link toc-highlight">File Read Safety</a>
- <a href="#git-worktree-isolation" class="table-of-contents__link toc-highlight">Git Worktree Isolation</a>
- <a href="#context-compression" class="table-of-contents__link toc-highlight">Context Compression</a>
  - <a href="#full-reference" class="table-of-contents__link toc-highlight">Full reference</a>
  - <a href="#common-setups" class="table-of-contents__link toc-highlight">Common setups</a>
  - <a href="#how-the-three-knobs-interact" class="table-of-contents__link toc-highlight">How the three knobs interact</a>
- <a href="#iteration-budget-pressure" class="table-of-contents__link toc-highlight">Iteration Budget Pressure</a>
- <a href="#context-pressure-warnings" class="table-of-contents__link toc-highlight">Context Pressure Warnings</a>
- <a href="#credential-pool-strategies" class="table-of-contents__link toc-highlight">Credential Pool Strategies</a>
- <a href="#auxiliary-models" class="table-of-contents__link toc-highlight">Auxiliary Models</a>
  - <a href="#the-universal-config-pattern" class="table-of-contents__link toc-highlight">The universal config pattern</a>
  - <a href="#full-auxiliary-config-reference" class="table-of-contents__link toc-highlight">Full auxiliary config reference</a>
  - <a href="#changing-the-vision-model" class="table-of-contents__link toc-highlight">Changing the Vision Model</a>
  - <a href="#provider-options" class="table-of-contents__link toc-highlight">Provider Options</a>
  - <a href="#common-setups-1" class="table-of-contents__link toc-highlight">Common Setups</a>
  - <a href="#environment-variables-legacy" class="table-of-contents__link toc-highlight">Environment Variables (legacy)</a>
- <a href="#reasoning-effort" class="table-of-contents__link toc-highlight">Reasoning Effort</a>
- <a href="#tool-use-enforcement" class="table-of-contents__link toc-highlight">Tool-Use Enforcement</a>
- <a href="#tts-configuration" class="table-of-contents__link toc-highlight">TTS Configuration</a>
- <a href="#display-settings" class="table-of-contents__link toc-highlight">Display Settings</a>
  - <a href="#theme-mode" class="table-of-contents__link toc-highlight">Theme mode</a>
- <a href="#privacy" class="table-of-contents__link toc-highlight">Privacy</a>
- <a href="#speech-to-text-stt" class="table-of-contents__link toc-highlight">Speech-to-Text (STT)</a>
- <a href="#voice-mode-cli" class="table-of-contents__link toc-highlight">Voice Mode (CLI)</a>
- <a href="#streaming" class="table-of-contents__link toc-highlight">Streaming</a>
  - <a href="#cli-streaming" class="table-of-contents__link toc-highlight">CLI Streaming</a>
  - <a href="#gateway-streaming-telegram-discord-slack" class="table-of-contents__link toc-highlight">Gateway Streaming (Telegram, Discord, Slack)</a>
- <a href="#group-chat-session-isolation" class="table-of-contents__link toc-highlight">Group Chat Session Isolation</a>
- <a href="#unauthorized-dm-behavior" class="table-of-contents__link toc-highlight">Unauthorized DM Behavior</a>
- <a href="#quick-commands" class="table-of-contents__link toc-highlight">Quick Commands</a>
- <a href="#human-delay" class="table-of-contents__link toc-highlight">Human Delay</a>
- <a href="#code-execution" class="table-of-contents__link toc-highlight">Code Execution</a>
- <a href="#web-search-backends" class="table-of-contents__link toc-highlight">Web Search Backends</a>
- <a href="#browser" class="table-of-contents__link toc-highlight">Browser</a>
- <a href="#timezone" class="table-of-contents__link toc-highlight">Timezone</a>
- <a href="#discord" class="table-of-contents__link toc-highlight">Discord</a>
- <a href="#security" class="table-of-contents__link toc-highlight">Security</a>
- <a href="#website-blocklist" class="table-of-contents__link toc-highlight">Website Blocklist</a>
- <a href="#smart-approvals" class="table-of-contents__link toc-highlight">Smart Approvals</a>
- <a href="#checkpoints" class="table-of-contents__link toc-highlight">Checkpoints</a>
- <a href="#delegation" class="table-of-contents__link toc-highlight">Delegation</a>
- <a href="#clarify" class="table-of-contents__link toc-highlight">Clarify</a>
- <a href="#context-files-soulmd-agentsmd" class="table-of-contents__link toc-highlight">Context Files (SOUL.md, AGENTS.md)</a>
- <a href="#working-directory" class="table-of-contents__link toc-highlight">Working Directory</a>


