<!-- Source: https://agentskills.io/what-are-skills -->

# What are Agent Skills?

> A standardized way to give AI agents new capabilities and expertise.

Agent Skills are a lightweight, open format for extending AI agent capabilities with specialized knowledge and workflows.

At its core, a skill is a folder containing a `SKILL.md` file. This file includes metadata (`name` and `description`, at minimum) and instructions that tell an agent how to perform a specific task. Skills can also bundle scripts, reference materials, templates, and other resources.

```
my-skill/
├── SKILL.md          # Required: metadata + instructions
├── scripts/          # Optional: executable code
├── references/       # Optional: documentation
├── assets/           # Optional: templates, resources
└── ...               # Any additional files or directories
```

## Why Agent Skills?

Agents are increasingly capable, but often don't have the context they need to do real work reliably. Skills solve this by packaging procedural knowledge and company-, team-, and user-specific context into portable, version-controlled folders that agents load on demand. This gives agents:

- **Domain expertise**: Capture specialized knowledge — from legal review processes to data analysis pipelines to presentation formatting — as reusable instructions and resources.
- **Repeatable workflows**: Turn multi-step tasks into consistent, auditable procedures.
- **Cross-product reuse**: Build a skill once and use it across any skills-compatible agent.

## How do Agent Skills work?

Agents load skills through **progressive disclosure**, in three stages:

1. **Discovery**: At startup, agents load only the name and description of each available skill, just enough to know when it might be relevant.

2. **Activation**: When a task matches a skill's description, the agent reads the full `SKILL.md` instructions into context.

3. **Execution**: The agent follows the instructions, optionally executing bundled code or loading referenced files as needed.

Full instructions load only when a task calls for them, so agents can keep many skills on hand with only a small context footprint.

## The SKILL.md file

Every skill starts with a `SKILL.md` file containing YAML frontmatter and Markdown instructions:

```yaml
---
name: pdf-processing
description: Extract PDF text, fill forms, merge files. Use when handling PDFs.
---

# PDF Processing

## When to use this skill
Use this skill when the user needs to work with PDF files...

## How to extract text
1. Use pdfplumber for text extraction...

## How to fill forms
...
```

The following frontmatter is required at the top of `SKILL.md`:

- `name`: A short identifier
- `description`: When to use this skill

The Markdown body contains the actual instructions and has no specific restrictions on structure or content.

This simple format has some key advantages:

- **Self-documenting**: A skill author or user can read a `SKILL.md` and understand what it does, making skills easy to audit and improve.
- **Extensible**: Skills can range in complexity from just text instructions to executable code, assets, and templates.
- **Portable**: Skills are just files, so they're easy to edit, version, and share.

## Where can I use Agent Skills?

Agent Skills are supported by a large and growing number of AI tools and agentic clients:

| Client | Description |
|--------|-------------|
| [Claude Code](https://claude.ai/code) | Agentic coding tool by Anthropic — terminal, IDE, desktop, and browser |
| [Claude](https://claude.ai/) | Anthropic's AI assistant |
| [Cursor](https://cursor.com/) | AI editor and coding agent |
| [VS Code](https://code.visualstudio.com/) | Visual Studio Code with GitHub Copilot |
| [GitHub Copilot](https://github.com/) | AI pair programmer by GitHub |
| [Gemini CLI](https://geminicli.com) | Google's open-source AI agent for the terminal |
| [OpenAI Codex](https://developers.openai.com/codex) | OpenAI's coding agent |
| [Roo Code](https://roocode.com) | AI dev team in your editor |
| [OpenHands](https://openhands.dev/) | Open platform for cloud coding agents |
| [Junie](https://junie.jetbrains.com/) | LLM-agnostic coding agent on IntelliJ Platform |
| [Amp](https://ampcode.com/) | Frontier coding agent |
| [Goose](https://block.github.io/goose/) | Open source extensible AI agent by Block |
| [Kiro](https://kiro.dev/) | Spec-driven AI coding by AWS |
| [Letta](https://www.letta.com/) | Stateful agents with advanced memory |
| [Firebender](https://firebender.com/) | Android-native coding agent |
| [OpenCode](https://opencode.ai/) | Open source agent for terminal, IDE, and desktop |
| [Mux](https://mux.coder.com/) | Parallel coding agents by Coder |
| [Factory](https://factory.ai/) | AI-native software development platform |
| [TRAE](https://trae.ai/) | Adaptive AI IDE by ByteDance |
| [Autohand Code CLI](https://autohand.ai/) | Autonomous LLM-powered terminal coding agent |
| [Mistral AI Vibe](https://github.com/mistralai/mistral-vibe) | Command-line coding assistant by Mistral |
| [Spring AI](https://docs.spring.io/spring-ai/reference) | AI development framework for Java |
| [Piebald](https://piebald.ai) | Desktop & web app for agentic development |
| [pi](https://shittycodingagent.ai/) | Minimal terminal coding harness |
| [Databricks Genie Code](https://databricks.com/) | Autonomous AI for data work |
| [Snowflake Cortex Code](https://docs.snowflake.com/en/user-guide/cortex-code/cortex-code) | AI agent for the Snowflake platform |
| [Agentman](https://agentman.ai/) | Agentic healthcare platform |
| [Command Code](https://commandcode.ai/) | Coding agent that learns your coding taste |
| [Ona](https://ona.com) | Platform for background agents |
| [Qodo](https://www.qodo.ai/) | Agentic code integrity platform |
| [Laravel Boost](https://github.com/laravel/boost) | AI-assisted Laravel development |
| [Emdash](https://emdash.sh) | Provider-agnostic multi-agent desktop app |
| [Workshop](https://workshop.ai/) | Cross-platform AI coding agent |
| [VT Code](https://github.com/vinhnx/vtcode) | Open-source coding agent with LLM-native understanding |
| [nanobot](https://nanobot.wiki/) | Ultra-lightweight multi-platform AI agent |
| [fast-agent](https://fast-agent.ai/) | Simple, extendable LLM interaction |
| [Google AI Edge Gallery](https://github.com/google-ai-edge/gallery) | On-device LLM runner |

## Open development

The Agent Skills format was originally developed by [Anthropic](https://www.anthropic.com/), released as an open standard, and has been adopted by a growing number of agent products. The standard is open to contributions from the broader ecosystem.

Join the discussion on [GitHub](https://github.com/agentskills/agentskills) or [Discord](https://discord.gg/MKPE9g8aUy).

## Next steps

- [View the specification](https://agentskills.io/specification) to understand the full format.
- [Add skills support to your agent](https://agentskills.io/client-implementation/adding-skills-support) to build a compatible client.
- [See example skills](https://github.com/anthropics/skills) on GitHub.
- [Read authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) for writing effective skills.
- [Use the reference library](https://github.com/agentskills/agentskills/tree/main/skills-ref) to validate skills and generate prompt XML.
