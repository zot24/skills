> Source: https://hermes-agent.nousresearch.com/docs/user-guide/features/skills/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Skills System


Skills are on-demand knowledge documents the agent can load when needed. They follow a **progressive disclosure** pattern to minimize token usage and are compatible with the <a href="https://agentskills.io/specification" target="_blank" rel="noopener noreferrer">agentskills.io</a> open standard.

All skills live in **`~/.hermes/skills/`** — the primary directory and source of truth. On fresh install, bundled skills are copied from the repo. Hub-installed and agent-created skills also go here. The agent can modify or delete any skill.

You can also point Hermes at **external skill directories** — additional folders scanned alongside the local one. See [External Skill Directories](#external-skill-directories) below.

See also:

- [Bundled Skills Catalog](/docs/reference/skills-catalog)
- [Official Optional Skills Catalog](/docs/reference/optional-skills-catalog)

## Using Skills<a href="#using-skills" class="hash-link" aria-label="Direct link to Using Skills" translate="no" title="Direct link to Using Skills">​</a>

Every installed skill is automatically available as a slash command:


``` prism-code
# In the CLI or any messaging platform:
/gif-search funny cats
/axolotl help me fine-tune Llama 3 on my dataset
/github-pr-workflow create a PR for the auth refactor
/plan design a rollout for migrating our auth provider

# Just the skill name loads it and lets the agent ask what you need:
/excalidraw
```


The bundled `plan` skill is a good example of a skill-backed slash command with custom behavior. Running `/plan [request]` tells Hermes to inspect context if needed, write a markdown implementation plan instead of executing the task, and save the result under `.hermes/plans/` relative to the active workspace/backend working directory.

You can also interact with skills through natural conversation:


``` prism-code
hermes chat --toolsets skills -q "What skills do you have?"
hermes chat --toolsets skills -q "Show me the axolotl skill"
```


## Progressive Disclosure<a href="#progressive-disclosure" class="hash-link" aria-label="Direct link to Progressive Disclosure" translate="no" title="Direct link to Progressive Disclosure">​</a>

Skills use a token-efficient loading pattern:


``` prism-code
Level 0: skills_list()           → [{name, description, category}, ...]   (~3k tokens)
Level 1: skill_view(name)        → Full content + metadata       (varies)
Level 2: skill_view(name, path)  → Specific reference file       (varies)
```


The agent only loads the full skill content when it actually needs it.

## SKILL.md Format<a href="#skillmd-format" class="hash-link" aria-label="Direct link to SKILL.md Format" translate="no" title="Direct link to SKILL.md Format">​</a>


``` prism-code
---
name: my-skill
description: Brief description of what this skill does
version: 1.0.0
platforms: [macos, linux]     # Optional — restrict to specific OS platforms
metadata:
  hermes:
    tags: [python, automation]
    category: devops
    fallback_for_toolsets: [web]    # Optional — conditional activation (see below)
    requires_toolsets: [terminal]   # Optional — conditional activation (see below)
---

# Skill Title

## When to Use
Trigger conditions for this skill.

## Procedure
1. Step one
2. Step two

## Pitfalls
- Known failure modes and fixes

## Verification
How to confirm it worked.
```


### Platform-Specific Skills<a href="#platform-specific-skills" class="hash-link" aria-label="Direct link to Platform-Specific Skills" translate="no" title="Direct link to Platform-Specific Skills">​</a>

Skills can restrict themselves to specific operating systems using the `platforms` field:

| Value     | Matches        |
|-----------|----------------|
| `macos`   | macOS (Darwin) |
| `linux`   | Linux          |
| `windows` | Windows        |


``` prism-code
platforms: [macos]            # macOS only (e.g., iMessage, Apple Reminders, FindMy)
platforms: [macos, linux]     # macOS and Linux
```


When set, the skill is automatically hidden from the system prompt, `skills_list()`, and slash commands on incompatible platforms. If omitted, the skill loads on all platforms.

### Conditional Activation (Fallback Skills)<a href="#conditional-activation-fallback-skills" class="hash-link" aria-label="Direct link to Conditional Activation (Fallback Skills)" translate="no" title="Direct link to Conditional Activation (Fallback Skills)">​</a>

Skills can automatically show or hide themselves based on which tools are available in the current session. This is most useful for **fallback skills** — free or local alternatives that should only appear when a premium tool is unavailable.


``` prism-code
metadata:
  hermes:
    fallback_for_toolsets: [web]      # Show ONLY when these toolsets are unavailable
    requires_toolsets: [terminal]     # Show ONLY when these toolsets are available
    fallback_for_tools: [web_search]  # Show ONLY when these specific tools are unavailable
    requires_tools: [terminal]        # Show ONLY when these specific tools are available
```


| Field                   | Behavior                                                                                  |
|-------------------------|-------------------------------------------------------------------------------------------|
| `fallback_for_toolsets` | Skill is **hidden** when the listed toolsets are available. Shown when they're missing.   |
| `fallback_for_tools`    | Same, but checks individual tools instead of toolsets.                                    |
| `requires_toolsets`     | Skill is **hidden** when the listed toolsets are unavailable. Shown when they're present. |
| `requires_tools`        | Same, but checks individual tools.                                                        |

**Example:** The built-in `duckduckgo-search` skill uses `fallback_for_toolsets: [web]`. When you have `FIRECRAWL_API_KEY` set, the web toolset is available and the agent uses `web_search` — the DuckDuckGo skill stays hidden. If the API key is missing, the web toolset is unavailable and the DuckDuckGo skill automatically appears as a fallback.

Skills without any conditional fields behave exactly as before — they're always shown.

## Secure Setup on Load<a href="#secure-setup-on-load" class="hash-link" aria-label="Direct link to Secure Setup on Load" translate="no" title="Direct link to Secure Setup on Load">​</a>

Skills can declare required environment variables without disappearing from discovery:


``` prism-code
required_environment_variables:
  - name: TENOR_API_KEY
    prompt: Tenor API key
    help: Get a key from https://developers.google.com/tenor
    required_for: full functionality
```


When a missing value is encountered, Hermes asks for it securely only when the skill is actually loaded in the local CLI. You can skip setup and keep using the skill. Messaging surfaces never ask for secrets in chat — they tell you to use `hermes setup` or `~/.hermes/.env` locally instead.

Once set, declared env vars are **automatically passed through** to `execute_code` and `terminal` sandboxes — the skill's scripts can use `$TENOR_API_KEY` directly. For non-skill env vars, use the `terminal.env_passthrough` config option. See [Environment Variable Passthrough](/docs/user-guide/security#environment-variable-passthrough) for details.

## Skill Directory Structure<a href="#skill-directory-structure" class="hash-link" aria-label="Direct link to Skill Directory Structure" translate="no" title="Direct link to Skill Directory Structure">​</a>


``` prism-code
~/.hermes/skills/                  # Single source of truth
├── mlops/                         # Category directory
│   ├── axolotl/
│   │   ├── SKILL.md               # Main instructions (required)
│   │   ├── references/            # Additional docs
│   │   ├── templates/             # Output formats
│   │   ├── scripts/               # Helper scripts callable from the skill
│   │   └── assets/                # Supplementary files
│   └── vllm/
│       └── SKILL.md
├── devops/
│   └── deploy-k8s/                # Agent-created skill
│       ├── SKILL.md
│       └── references/
├── .hub/                          # Skills Hub state
│   ├── lock.json
│   ├── quarantine/
│   └── audit.log
└── .bundled_manifest              # Tracks seeded bundled skills
```


## External Skill Directories<a href="#external-skill-directories" class="hash-link" aria-label="Direct link to External Skill Directories" translate="no" title="Direct link to External Skill Directories">​</a>

If you maintain skills outside of Hermes — for example, a shared `~/.agents/skills/` directory used by multiple AI tools — you can tell Hermes to scan those directories too.

Add `external_dirs` under the `skills` section in `~/.hermes/config.yaml`:


``` prism-code
skills:
  external_dirs:
    - ~/.agents/skills
    - /home/shared/team-skills
    - ${SKILLS_REPO}/skills
```


Paths support `~` expansion and `${VAR}` environment variable substitution.

### How it works<a href="#how-it-works" class="hash-link" aria-label="Direct link to How it works" translate="no" title="Direct link to How it works">​</a>

- **Read-only**: External dirs are only scanned for skill discovery. When the agent creates or edits a skill, it always writes to `~/.hermes/skills/`.
- **Local precedence**: If the same skill name exists in both the local dir and an external dir, the local version wins.
- **Full integration**: External skills appear in the system prompt index, `skills_list`, `skill_view`, and as `/skill-name` slash commands — no different from local skills.
- **Non-existent paths are silently skipped**: If a configured directory doesn't exist, Hermes ignores it without errors. Useful for optional shared directories that may not be present on every machine.

### Example<a href="#example" class="hash-link" aria-label="Direct link to Example" translate="no" title="Direct link to Example">​</a>


``` prism-code
~/.hermes/skills/               # Local (primary, read-write)
├── devops/deploy-k8s/
│   └── SKILL.md
└── mlops/axolotl/
    └── SKILL.md

~/.agents/skills/               # External (read-only, shared)
├── my-custom-workflow/
│   └── SKILL.md
└── team-conventions/
    └── SKILL.md
```


All four skills appear in your skill index. If you create a new skill called `my-custom-workflow` locally, it shadows the external version.

## Agent-Managed Skills (skill_manage tool)<a href="#agent-managed-skills-skill_manage-tool" class="hash-link" aria-label="Direct link to Agent-Managed Skills (skill_manage tool)" translate="no" title="Direct link to Agent-Managed Skills (skill_manage tool)">​</a>

The agent can create, update, and delete its own skills via the `skill_manage` tool. This is the agent's **procedural memory** — when it figures out a non-trivial workflow, it saves the approach as a skill for future reuse.

### When the Agent Creates Skills<a href="#when-the-agent-creates-skills" class="hash-link" aria-label="Direct link to When the Agent Creates Skills" translate="no" title="Direct link to When the Agent Creates Skills">​</a>

- After completing a complex task (5+ tool calls) successfully
- When it hit errors or dead ends and found the working path
- When the user corrected its approach
- When it discovered a non-trivial workflow

### Actions<a href="#actions" class="hash-link" aria-label="Direct link to Actions" translate="no" title="Direct link to Actions">​</a>

| Action        | Use for                     | Key params                                             |
|---------------|-----------------------------|--------------------------------------------------------|
| `create`      | New skill from scratch      | `name`, `content` (full SKILL.md), optional `category` |
| `patch`       | Targeted fixes (preferred)  | `name`, `old_string`, `new_string`                     |
| `edit`        | Major structural rewrites   | `name`, `content` (full SKILL.md replacement)          |
| `delete`      | Remove a skill entirely     | `name`                                                 |
| `write_file`  | Add/update supporting files | `name`, `file_path`, `file_content`                    |
| `remove_file` | Remove a supporting file    | `name`, `file_path`                                    |


The `patch` action is preferred for updates — it's more token-efficient than `edit` because only the changed text appears in the tool call.


## Skills Hub<a href="#skills-hub" class="hash-link" aria-label="Direct link to Skills Hub" translate="no" title="Direct link to Skills Hub">​</a>

Browse, search, install, and manage skills from online registries, `skills.sh`, direct well-known skill endpoints, and official optional skills.

### Common commands<a href="#common-commands" class="hash-link" aria-label="Direct link to Common commands" translate="no" title="Direct link to Common commands">​</a>


``` prism-code
hermes skills browse                              # Browse all hub skills (official first)
hermes skills browse --source official            # Browse only official optional skills
hermes skills search kubernetes                   # Search all sources
hermes skills search react --source skills-sh     # Search the skills.sh directory
hermes skills search https://mintlify.com/docs --source well-known
hermes skills inspect openai/skills/k8s           # Preview before installing
hermes skills install openai/skills/k8s           # Install with security scan
hermes skills install official/security/1password
hermes skills install skills-sh/vercel-labs/json-render/json-render-react --force
hermes skills install well-known:https://mintlify.com/docs/.well-known/skills/mintlify
hermes skills list --source hub                   # List hub-installed skills
hermes skills check                               # Check installed hub skills for upstream updates
hermes skills update                              # Reinstall hub skills with upstream changes when needed
hermes skills audit                               # Re-scan all hub skills for security
hermes skills uninstall k8s                       # Remove a hub skill
hermes skills publish skills/my-skill --to github --repo owner/repo
hermes skills snapshot export setup.json          # Export skill config
hermes skills tap add myorg/skills-repo           # Add a custom GitHub source
```


### Supported hub sources<a href="#supported-hub-sources" class="hash-link" aria-label="Direct link to Supported hub sources" translate="no" title="Direct link to Supported hub sources">​</a>

| Source                                     | Example                                                            | Notes                                                                                                                                                      |
|--------------------------------------------|--------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `official`                                 | `official/security/1password`                                      | Optional skills shipped with Hermes.                                                                                                                       |
| `skills-sh`                                | `skills-sh/vercel-labs/agent-skills/vercel-react-best-practices`   | Searchable via `hermes skills search <query> --source skills-sh`. Hermes resolves alias-style skills when the skills.sh slug differs from the repo folder. |
| `well-known`                               | `well-known:https://mintlify.com/docs/.well-known/skills/mintlify` | Skills served directly from `/.well-known/skills/index.json` on a website. Search using the site or docs URL.                                              |
| `github`                                   | `openai/skills/k8s`                                                | Direct GitHub repo/path installs and custom taps.                                                                                                          |
| `clawhub`, `lobehub`, `claude-marketplace` | Source-specific identifiers                                        | Community or marketplace integrations.                                                                                                                     |

### Integrated hubs and registries<a href="#integrated-hubs-and-registries" class="hash-link" aria-label="Direct link to Integrated hubs and registries" translate="no" title="Direct link to Integrated hubs and registries">​</a>

Hermes currently integrates with these skills ecosystems and discovery sources:

#### 1. Official optional skills (`official`)<a href="#1-official-optional-skills-official" class="hash-link" aria-label="Direct link to 1-official-optional-skills-official" translate="no" title="Direct link to 1-official-optional-skills-official">​</a>

These are maintained in the Hermes repository itself and install with builtin trust.

- Catalog: [Official Optional Skills Catalog](/docs/reference/optional-skills-catalog)
- Source in repo: `optional-skills/`
- Example:


``` prism-code
hermes skills browse --source official
hermes skills install official/security/1password
```


#### 2. skills.sh (`skills-sh`)<a href="#2-skillssh-skills-sh" class="hash-link" aria-label="Direct link to 2-skillssh-skills-sh" translate="no" title="Direct link to 2-skillssh-skills-sh">​</a>

This is Vercel's public skills directory. Hermes can search it directly, inspect skill detail pages, resolve alias-style slugs, and install from the underlying source repo.

- Directory: <a href="https://skills.sh/" target="_blank" rel="noopener noreferrer">skills.sh</a>
- CLI/tooling repo: <a href="https://github.com/vercel-labs/skills" target="_blank" rel="noopener noreferrer">vercel-labs/skills</a>
- Official Vercel skills repo: <a href="https://github.com/vercel-labs/agent-skills" target="_blank" rel="noopener noreferrer">vercel-labs/agent-skills</a>
- Example:


``` prism-code
hermes skills search react --source skills-sh
hermes skills inspect skills-sh/vercel-labs/json-render/json-render-react
hermes skills install skills-sh/vercel-labs/json-render/json-render-react --force
```


#### 3. Well-known skill endpoints (`well-known`)<a href="#3-well-known-skill-endpoints-well-known" class="hash-link" aria-label="Direct link to 3-well-known-skill-endpoints-well-known" translate="no" title="Direct link to 3-well-known-skill-endpoints-well-known">​</a>

This is URL-based discovery from sites that publish `/.well-known/skills/index.json`. It is not a single centralized hub — it is a web discovery convention.

- Example live endpoint: <a href="https://mintlify.com/docs/.well-known/skills/index.json" target="_blank" rel="noopener noreferrer">Mintlify docs skills index</a>
- Reference server implementation: <a href="https://github.com/vercel-labs/skills-handler" target="_blank" rel="noopener noreferrer">vercel-labs/skills-handler</a>
- Example:


``` prism-code
hermes skills search https://mintlify.com/docs --source well-known
hermes skills inspect well-known:https://mintlify.com/docs/.well-known/skills/mintlify
hermes skills install well-known:https://mintlify.com/docs/.well-known/skills/mintlify
```


#### 4. Direct GitHub skills (`github`)<a href="#4-direct-github-skills-github" class="hash-link" aria-label="Direct link to 4-direct-github-skills-github" translate="no" title="Direct link to 4-direct-github-skills-github">​</a>

Hermes can install directly from GitHub repositories and GitHub-based taps. This is useful when you already know the repo/path or want to add your own custom source repo.

Default taps (browsable without any setup):

- <a href="https://github.com/openai/skills" target="_blank" rel="noopener noreferrer">openai/skills</a>

- <a href="https://github.com/anthropics/skills" target="_blank" rel="noopener noreferrer">anthropics/skills</a>

- <a href="https://github.com/VoltAgent/awesome-agent-skills" target="_blank" rel="noopener noreferrer">VoltAgent/awesome-agent-skills</a>

- <a href="https://github.com/garrytan/gstack" target="_blank" rel="noopener noreferrer">garrytan/gstack</a>

- Example:


``` prism-code
hermes skills install openai/skills/k8s
hermes skills tap add myorg/skills-repo
```


#### 5. ClawHub (`clawhub`)<a href="#5-clawhub-clawhub" class="hash-link" aria-label="Direct link to 5-clawhub-clawhub" translate="no" title="Direct link to 5-clawhub-clawhub">​</a>

A third-party skills marketplace integrated as a community source.

- Site: <a href="https://clawhub.ai/" target="_blank" rel="noopener noreferrer">clawhub.ai</a>
- Hermes source id: `clawhub`

#### 6. Claude marketplace-style repos (`claude-marketplace`)<a href="#6-claude-marketplace-style-repos-claude-marketplace" class="hash-link" aria-label="Direct link to 6-claude-marketplace-style-repos-claude-marketplace" translate="no" title="Direct link to 6-claude-marketplace-style-repos-claude-marketplace">​</a>

Hermes supports marketplace repos that publish Claude-compatible plugin/marketplace manifests.

Known integrated sources include:

- <a href="https://github.com/anthropics/skills" target="_blank" rel="noopener noreferrer">anthropics/skills</a>
- <a href="https://github.com/aiskillstore/marketplace" target="_blank" rel="noopener noreferrer">aiskillstore/marketplace</a>

Hermes source id: `claude-marketplace`

#### 7. LobeHub (`lobehub`)<a href="#7-lobehub-lobehub" class="hash-link" aria-label="Direct link to 7-lobehub-lobehub" translate="no" title="Direct link to 7-lobehub-lobehub">​</a>

Hermes can search and convert agent entries from LobeHub's public catalog into installable Hermes skills.

- Site: <a href="https://lobehub.com/" target="_blank" rel="noopener noreferrer">LobeHub</a>
- Public agents index: <a href="https://chat-agents.lobehub.com/" target="_blank" rel="noopener noreferrer">chat-agents.lobehub.com</a>
- Backing repo: <a href="https://github.com/lobehub/lobe-chat-agents" target="_blank" rel="noopener noreferrer">lobehub/lobe-chat-agents</a>
- Hermes source id: `lobehub`

### Security scanning and `--force`<a href="#security-scanning-and---force" class="hash-link" aria-label="Direct link to security-scanning-and---force" translate="no" title="Direct link to security-scanning-and---force">​</a>

All hub-installed skills go through a **security scanner** that checks for data exfiltration, prompt injection, destructive commands, supply-chain signals, and other threats.

`hermes skills inspect ...` now also surfaces upstream metadata when available:

- repo URL
- skills.sh detail page URL
- install command
- weekly installs
- upstream security audit statuses
- well-known index/endpoint URLs

Use `--force` when you have reviewed a third-party skill and want to override a non-dangerous policy block:


``` prism-code
hermes skills install skills-sh/anthropics/skills/pdf --force
```


Important behavior:

- `--force` can override policy blocks for caution/warn-style findings.
- `--force` does **not** override a `dangerous` scan verdict.
- Official optional skills (`official/...`) are treated as builtin trust and do not show the third-party warning panel.

### Trust levels<a href="#trust-levels" class="hash-link" aria-label="Direct link to Trust levels" translate="no" title="Direct link to Trust levels">​</a>

| Level       | Source                                                                                      | Policy                                                                                     |
|-------------|---------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------|
| `builtin`   | Ships with Hermes                                                                           | Always trusted                                                                             |
| `official`  | `optional-skills/` in the repo                                                              | Builtin trust, no third-party warning                                                      |
| `trusted`   | Trusted registries/repos such as `openai/skills`, `anthropics/skills`                       | More permissive policy than community sources                                              |
| `community` | Everything else (`skills.sh`, well-known endpoints, custom GitHub repos, most marketplaces) | Non-dangerous findings can be overridden with `--force`; `dangerous` verdicts stay blocked |

### Update lifecycle<a href="#update-lifecycle" class="hash-link" aria-label="Direct link to Update lifecycle" translate="no" title="Direct link to Update lifecycle">​</a>

The hub now tracks enough provenance to re-check upstream copies of installed skills:


``` prism-code
hermes skills check          # Report which installed hub skills changed upstream
hermes skills update         # Reinstall only the skills with updates available
hermes skills update react   # Update one specific installed hub skill
```


This uses the stored source identifier plus the current upstream bundle content hash to detect drift.

### Slash commands (inside chat)<a href="#slash-commands-inside-chat" class="hash-link" aria-label="Direct link to Slash commands (inside chat)" translate="no" title="Direct link to Slash commands (inside chat)">​</a>

All the same commands work with `/skills`:


``` prism-code
/skills browse
/skills search react --source skills-sh
/skills search https://mintlify.com/docs --source well-known
/skills inspect skills-sh/vercel-labs/json-render/json-render-react
/skills install openai/skills/skill-creator --force
/skills check
/skills update
/skills list
```


Official optional skills still use identifiers like `official/security/1password` and `official/migration/openclaw-migration`.


- <a href="#using-skills" class="table-of-contents__link toc-highlight">Using Skills</a>
- <a href="#progressive-disclosure" class="table-of-contents__link toc-highlight">Progressive Disclosure</a>
- <a href="#skillmd-format" class="table-of-contents__link toc-highlight">SKILL.md Format</a>
  - <a href="#platform-specific-skills" class="table-of-contents__link toc-highlight">Platform-Specific Skills</a>
  - <a href="#conditional-activation-fallback-skills" class="table-of-contents__link toc-highlight">Conditional Activation (Fallback Skills)</a>
- <a href="#secure-setup-on-load" class="table-of-contents__link toc-highlight">Secure Setup on Load</a>
- <a href="#skill-directory-structure" class="table-of-contents__link toc-highlight">Skill Directory Structure</a>
- <a href="#external-skill-directories" class="table-of-contents__link toc-highlight">External Skill Directories</a>
  - <a href="#how-it-works" class="table-of-contents__link toc-highlight">How it works</a>
  - <a href="#example" class="table-of-contents__link toc-highlight">Example</a>
- <a href="#agent-managed-skills-skill_manage-tool" class="table-of-contents__link toc-highlight">Agent-Managed Skills (skill_manage tool)</a>
  - <a href="#when-the-agent-creates-skills" class="table-of-contents__link toc-highlight">When the Agent Creates Skills</a>
  - <a href="#actions" class="table-of-contents__link toc-highlight">Actions</a>
- <a href="#skills-hub" class="table-of-contents__link toc-highlight">Skills Hub</a>
  - <a href="#common-commands" class="table-of-contents__link toc-highlight">Common commands</a>
  - <a href="#supported-hub-sources" class="table-of-contents__link toc-highlight">Supported hub sources</a>
  - <a href="#integrated-hubs-and-registries" class="table-of-contents__link toc-highlight">Integrated hubs and registries</a>
  - <a href="#security-scanning-and---force" class="table-of-contents__link toc-highlight">Security scanning and <code>--force</code></a>
  - <a href="#trust-levels" class="table-of-contents__link toc-highlight">Trust levels</a>
  - <a href="#update-lifecycle" class="table-of-contents__link toc-highlight">Update lifecycle</a>
  - <a href="#slash-commands-inside-chat" class="table-of-contents__link toc-highlight">Slash commands (inside chat)</a>


