> Source: https://hermes-agent.nousresearch.com/docs/user-guide/features/tools/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Tools & Toolsets


Tools are functions that extend the agent's capabilities. They're organized into logical **toolsets** that can be enabled or disabled per platform.

## Available Tools<a href="#available-tools" class="hash-link" aria-label="Direct link to Available Tools" translate="no" title="Direct link to Available Tools">​</a>

Hermes ships with a broad built-in tool registry covering web search, browser automation, terminal execution, file editing, memory, delegation, RL training, messaging delivery, Home Assistant, and more.


**Honcho cross-session memory** is available as a memory provider plugin (`plugins/memory/honcho/`), not as a built-in toolset. See [Plugins](/docs/user-guide/features/plugins) for installation.


High-level categories:

| Category                  | Examples                                                 | Description                                                                                                |
|---------------------------|----------------------------------------------------------|------------------------------------------------------------------------------------------------------------|
| **Web**                   | `web_search`, `web_extract`                              | Search the web and extract page content.                                                                   |
| **Terminal & Files**      | `terminal`, `process`, `read_file`, `patch`              | Execute commands and manipulate files.                                                                     |
| **Browser**               | `browser_navigate`, `browser_snapshot`, `browser_vision` | Interactive browser automation with text and vision support.                                               |
| **Media**                 | `vision_analyze`, `image_generate`, `text_to_speech`     | Multimodal analysis and generation.                                                                        |
| **Agent orchestration**   | `todo`, `clarify`, `execute_code`, `delegate_task`       | Planning, clarification, code execution, and subagent delegation.                                          |
| **Memory & recall**       | `memory`, `session_search`                               | Persistent memory and session search.                                                                      |
| **Automation & delivery** | `cronjob`, `send_message`                                | Scheduled tasks with create/list/update/pause/resume/run/remove actions, plus outbound messaging delivery. |
| **Integrations**          | `ha_*`, MCP server tools, `rl_*`                         | Home Assistant, MCP, RL training, and other integrations.                                                  |

For the authoritative code-derived registry, see [Built-in Tools Reference](/docs/reference/tools-reference) and [Toolsets Reference](/docs/reference/toolsets-reference).


Paid <a href="https://portal.nousresearch.com" target="_blank" rel="noopener noreferrer">Nous Portal</a> subscribers can use web search, image generation, TTS, and browser automation through the **[Tool Gateway](/docs/user-guide/features/tool-gateway)** — no separate API keys needed. Run `hermes model` to enable it, or configure individual tools with `hermes tools`.


## Using Toolsets<a href="#using-toolsets" class="hash-link" aria-label="Direct link to Using Toolsets" translate="no" title="Direct link to Using Toolsets">​</a>


``` prism-code
# Use specific toolsets
hermes chat --toolsets "web,terminal"

# See all available tools
hermes tools

# Configure tools per platform (interactive)
hermes tools
```


Common toolsets include `web`, `terminal`, `file`, `browser`, `vision`, `image_gen`, `moa`, `skills`, `tts`, `todo`, `memory`, `session_search`, `cronjob`, `code_execution`, `delegation`, `clarify`, `homeassistant`, and `rl`.

See [Toolsets Reference](/docs/reference/toolsets-reference) for the full set, including platform presets such as `hermes-cli`, `hermes-telegram`, and dynamic MCP toolsets like `mcp-<server>`.

## Terminal Backends<a href="#terminal-backends" class="hash-link" aria-label="Direct link to Terminal Backends" translate="no" title="Direct link to Terminal Backends">​</a>

The terminal tool can execute commands in different environments:

| Backend       | Description                   | Use Case                                      |
|---------------|-------------------------------|-----------------------------------------------|
| `local`       | Run on your machine (default) | Development, trusted tasks                    |
| `docker`      | Isolated containers           | Security, reproducibility                     |
| `ssh`         | Remote server                 | Sandboxing, keep agent away from its own code |
| `singularity` | HPC containers                | Cluster computing, rootless                   |
| `modal`       | Cloud execution               | Serverless, scale                             |
| `daytona`     | Cloud sandbox workspace       | Persistent remote dev environments            |

### Configuration<a href="#configuration" class="hash-link" aria-label="Direct link to Configuration" translate="no" title="Direct link to Configuration">​</a>


``` prism-code
# In ~/.hermes/config.yaml
terminal:
  backend: local    # or: docker, ssh, singularity, modal, daytona
  cwd: "."          # Working directory
  timeout: 180      # Command timeout in seconds
```


### Docker Backend<a href="#docker-backend" class="hash-link" aria-label="Direct link to Docker Backend" translate="no" title="Direct link to Docker Backend">​</a>


``` prism-code
terminal:
  backend: docker
  docker_image: python:3.11-slim
```


### SSH Backend<a href="#ssh-backend" class="hash-link" aria-label="Direct link to SSH Backend" translate="no" title="Direct link to SSH Backend">​</a>

Recommended for security — agent can't modify its own code:


``` prism-code
terminal:
  backend: ssh
```


``` prism-code
# Set credentials in ~/.hermes/.env
TERMINAL_SSH_HOST=my-server.example.com
TERMINAL_SSH_USER=myuser
TERMINAL_SSH_KEY=~/.ssh/id_rsa
```


### Singularity/Apptainer<a href="#singularityapptainer" class="hash-link" aria-label="Direct link to Singularity/Apptainer" translate="no" title="Direct link to Singularity/Apptainer">​</a>


``` prism-code
# Pre-build SIF for parallel workers
apptainer build ~/python.sif docker://python:3.11-slim

# Configure
hermes config set terminal.backend singularity
hermes config set terminal.singularity_image ~/python.sif
```


### Modal (Serverless Cloud)<a href="#modal-serverless-cloud" class="hash-link" aria-label="Direct link to Modal (Serverless Cloud)" translate="no" title="Direct link to Modal (Serverless Cloud)">​</a>


``` prism-code
uv pip install modal
modal setup
hermes config set terminal.backend modal
```


### Container Resources<a href="#container-resources" class="hash-link" aria-label="Direct link to Container Resources" translate="no" title="Direct link to Container Resources">​</a>

Configure CPU, memory, disk, and persistence for all container backends:


``` prism-code
terminal:
  backend: docker  # or singularity, modal, daytona
  container_cpu: 1              # CPU cores (default: 1)
  container_memory: 5120        # Memory in MB (default: 5GB)
  container_disk: 51200         # Disk in MB (default: 50GB)
  container_persistent: true    # Persist filesystem across sessions (default: true)
```


When `container_persistent: true`, installed packages, files, and config survive across sessions.

### Container Security<a href="#container-security" class="hash-link" aria-label="Direct link to Container Security" translate="no" title="Direct link to Container Security">​</a>

All container backends run with security hardening:

- Read-only root filesystem (Docker)
- All Linux capabilities dropped
- No privilege escalation
- PID limits (256 processes)
- Full namespace isolation
- Persistent workspace via volumes, not writable root layer

Docker can optionally receive an explicit env allowlist via `terminal.docker_forward_env`, but forwarded variables are visible to commands inside the container and should be treated as exposed to that session.

## Background Process Management<a href="#background-process-management" class="hash-link" aria-label="Direct link to Background Process Management" translate="no" title="Direct link to Background Process Management">​</a>

Start background processes and manage them:


``` prism-code
terminal(command="pytest -v tests/", background=true)
# Returns: {"session_id": "proc_abc123", "pid": 12345}

# Then manage with the process tool:
process(action="list")       # Show all running processes
process(action="poll", session_id="proc_abc123")   # Check status
process(action="wait", session_id="proc_abc123")   # Block until done
process(action="log", session_id="proc_abc123")    # Full output
process(action="kill", session_id="proc_abc123")   # Terminate
process(action="write", session_id="proc_abc123", data="y")  # Send input
```


PTY mode (`pty=true`) enables interactive CLI tools like Codex and Claude Code.

## Sudo Support<a href="#sudo-support" class="hash-link" aria-label="Direct link to Sudo Support" translate="no" title="Direct link to Sudo Support">​</a>

If a command needs sudo, you'll be prompted for your password (cached for the session). Or set `SUDO_PASSWORD` in `~/.hermes/.env`.


On messaging platforms, if sudo fails, the output includes a tip to add `SUDO_PASSWORD` to `~/.hermes/.env`.


- <a href="#available-tools" class="table-of-contents__link toc-highlight">Available Tools</a>
- <a href="#using-toolsets" class="table-of-contents__link toc-highlight">Using Toolsets</a>
- <a href="#terminal-backends" class="table-of-contents__link toc-highlight">Terminal Backends</a>
  - <a href="#configuration" class="table-of-contents__link toc-highlight">Configuration</a>
  - <a href="#docker-backend" class="table-of-contents__link toc-highlight">Docker Backend</a>
  - <a href="#ssh-backend" class="table-of-contents__link toc-highlight">SSH Backend</a>
  - <a href="#singularityapptainer" class="table-of-contents__link toc-highlight">Singularity/Apptainer</a>
  - <a href="#modal-serverless-cloud" class="table-of-contents__link toc-highlight">Modal (Serverless Cloud)</a>
  - <a href="#container-resources" class="table-of-contents__link toc-highlight">Container Resources</a>
  - <a href="#container-security" class="table-of-contents__link toc-highlight">Container Security</a>
- <a href="#background-process-management" class="table-of-contents__link toc-highlight">Background Process Management</a>
- <a href="#sudo-support" class="table-of-contents__link toc-highlight">Sudo Support</a>


