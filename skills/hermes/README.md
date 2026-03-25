# hermes

Expert knowledge about Hermes Agent — its memory system, skills architecture, cron job scheduler, tools, and behavioral conventions.

## What This Skill Covers

- **Memory system**: Dual-store memory, Honcho peer profiles, instruction capture system
- **Skills system**: How skills are created, triggered, and structured
- **Cron jobs**: Schedule formats, delivery targets, scheduler architecture (and its common failure mode)
- **Tools**: Categories and capabilities of Hermes's built-in tools
- **Conventions**: Communication style, user preferences, context management

## Usage

Activate when user asks questions like:
- "how does hermes work?"
- "what can hermes do?"
- "hermes memory system"
- "how do I configure/create skills for hermes?"

## Files

- `SKILL.md` — main skill file with all knowledge
- `commands/hermes.md` — slash command entry point
- `sync.json` — CI sync configuration

## Source

This skill consolidates knowledge from:
- Hermes Agent documentation: https://hermes-agent.nousresearch.com/docs
- Agent Skills specification: https://agentskills.io
- Operational experience with Hermes deployment
