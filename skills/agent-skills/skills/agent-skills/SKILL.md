---
name: agent-skills
description: Expert at Agent Skills - both the open agentskills.io format and Claude's official extensions (Claude Code, Agent SDK, Claude API). Use when creating SKILL.md files, understanding the specification, validating skills, choosing frontmatter fields, or integrating skills into agents. Triggers on mentions of agent skills, SKILL.md, skill format, slash commands, skill frontmatter, agent extensibility.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Agent Skills Format Expert

You are an expert at Agent Skills - a lightweight standard for extending AI agent capabilities with specialized knowledge and workflows. The spec has two layers: a portable open spec (agentskills.io) that works across many tools, and platform-specific extensions (Claude Code, Agent SDK, Claude API) layered on top.

## Overview

- **What it is**: Open format for giving AI agents new capabilities via SKILL.md files
- **Core file**: `SKILL.md` with YAML frontmatter + Markdown instructions
- **Pattern**: Progressive disclosure (metadata → instructions → resources)
- **Adoption**: Claude Code, Gemini CLI, Cursor, VS Code, GitHub, OpenAI Codex, and 10+ others
- **Repository**: github.com/agentskills/agentskills

## Quick Start

Minimal valid skill:
```yaml
---
name: my-skill
description: Does X when user needs Y. Use for tasks involving Z.
---

# My Skill

Instructions for the agent...
```

## SKILL.md Structure (open spec)

| Field | Required | Constraints |
|-------|----------|-------------|
| `name` | Yes | 1-64 chars, lowercase + hyphens, must match directory name |
| `description` | Yes | 1-1024 chars, what it does + when to use it |
| `license` | No | License name or file reference |
| `compatibility` | No | Environment requirements |
| `metadata` | No | Arbitrary key-value pairs |
| `allowed-tools` | No | Space-delimited pre-approved tools |

## Directory Structure

```
skill-name/
├── SKILL.md          # Required: metadata + instructions
├── scripts/          # Optional: executable code (Python, Bash, JS)
├── references/       # Optional: detailed documentation
└── assets/           # Optional: templates, images, data files
```

## Claude Code extensions (beyond the open spec)

| Field / feature | Semantics | Scope |
|---|---|---|
| `allowed-tools` | Pre-approved tools the skill may use (e.g. `Read, Bash(git *)`) | Claude Code CLI only — NOT supported in Agent SDK |
| `context: fork` | Run the skill in an isolated subagent context | Claude Code + Agent SDK |
| `agent` | Run the skill via a named subagent type | Claude Code |
| `model` | Model override for the skill's execution | Claude Code |
| `disable-model-invocation` | Only the user can invoke (`/name`); Claude never auto-triggers | Claude Code |
| `argument-hint` | Hint shown for slash-command arguments | Claude Code |
| `$ARGUMENTS`, `$0`/`$1`… | Argument substitution in the skill body | Claude Code |
| `` !`command` `` | Dynamic context injection — command runs and its output replaces the line before Claude reads the skill | Claude Code |
| `@path` | File-content references in the body | Claude Code |

## Documentation

Open format (agentskills.io):
- **[Specification](docs/specification.md)** - Complete SKILL.md format spec
- **[What Are Skills](docs/what-are-skills.md)** - Conceptual overview
- **[Integration Guide](docs/integrate-skills.md)** - Add skills to your agent
- **[Skill Creation Quickstart](docs/skill-creation-quickstart.md)** - First skill walkthrough
- **[Skill Creation Best Practices](docs/skill-creation-best-practices.md)** - Authoring guidelines
- **[Using Scripts](docs/using-scripts.md)** - Bundling executable code
- **[Evaluating Skills](docs/evaluating-skills.md)** - Testing skill quality
- **[Optimizing Descriptions](docs/optimizing-descriptions.md)** - Trigger-accuracy tuning
- **[Upstream README](docs/readme-upstream.md)** - Raw repository README

Official Anthropic:
- **[Claude Code Skills](docs/claude-code-skills.md)** - Frontmatter reference, invocation control, subagent execution, dynamic context
- **[Agent SDK Skills](docs/agent-sdk-skills.md)** - Using skills with the Agent SDK
- **[Agent SDK Slash Commands](docs/agent-sdk-slash-commands.md)** - Custom commands in the SDK
- **[Anthropic Overview](docs/anthropic-overview.md)** - Agent Skills on the Claude API/platform
- **[Anthropic API Quickstart](docs/anthropic-api-quickstart.md)** - First skill via the API
- **[Best Practices](docs/best-practices.md)** - Anthropic's authoring guidance
- **[Anthropic Enterprise](docs/anthropic-enterprise.md)** - Enterprise skill management
- **[Anthropic API Skills Guide](docs/anthropic-api-skills-guide.md)** - Build-with-Claude skills guide

Internal:
- **[Examples](docs/examples.md)** - Sample skills
- **[Audit Checklist](docs/audit-checklist.md)** - Compliance matrix spec

## Common Workflows

### Create a New Skill
1. Create directory with skill name (lowercase, hyphens)
2. Create `SKILL.md` with required frontmatter
3. Write clear instructions in the body
4. Add optional scripts/, references/, assets/ as needed
5. Validate with `skills-ref validate ./my-skill`

### Audit All Skills
Run `audit` to scan all skill directories and generate a compliance matrix showing file presence, line counts, registration status, and version consistency. See [Audit Checklist](docs/audit-checklist.md) for the full specification.

### Validate a Skill
```bash
# Install reference library
pip install skills-ref

# Validate
skills-ref validate ./path/to/skill
```

### Generate Prompt XML
```bash
skills-ref to-prompt ./skill1 ./skill2
```

## Key Principles

1. **Progressive Disclosure**: Load metadata first (~100 tokens), full instructions on activation (~5000 tokens max recommended), resources only when needed
2. **Self-Documenting**: Skills should be readable by humans and agents
3. **Portable**: Just files - easy to version, share, edit
4. **Keep SKILL.md < 500 lines**: Move detailed content to references/

## Upstream Sources

- **Repository**: https://github.com/agentskills/agentskills
- **Documentation**: https://agentskills.io
- **Reference Library**: https://github.com/agentskills/agentskills/tree/main/skills-ref
- **Example Skills**: https://github.com/anthropics/skills
- **Anthropic Overview**: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview
- **Claude Code Skills**: https://code.claude.com/docs/en/skills

## Sync & Update

When user runs `sync`: Fetch latest from agentskills.io, code.claude.com, platform.claude.com, and GitHub, update docs/ files.
When user runs `diff`: Compare current docs/ against upstream sources.
