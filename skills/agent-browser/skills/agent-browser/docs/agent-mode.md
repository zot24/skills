> Source: https://agent-browser.dev/docs/agent-mode

# Agent Mode

agent-browser works with any AI coding agent. Use `--json` for machine-readable output.

## Compatible Agents

- Claude Code
- Cursor
- GitHub Copilot
- OpenAI Codex
- Google Gemini CLI
- Goose
- OpenCode
- Windsurf
- Any agent that can run shell commands

## JSON Output Format

```bash
agent-browser snapshot --json
# Returns: {"success":true,"data":{"snapshot":"...","refs":{"e1":{"role":"heading","name":"Title"},...}}}

agent-browser get text @e1 --json
agent-browser is visible @e2 --json
```

Note: The default text output is more compact and preferred for AI agents. Use `--json` only when programmatic parsing is required.

## Optimal AI Workflow

```bash
# 1. Navigate and get snapshot
agent-browser open example.com
agent-browser snapshot -i --json   # AI parses tree and refs

# 2. AI identifies target refs from snapshot
# 3. Execute actions using refs
agent-browser click @e2
agent-browser fill @e3 "input text"

# 4. Get new snapshot if page changed
agent-browser snapshot -i --json
```

## Command Chaining

Commands can be chained with `&&` in a single shell invocation. The browser persists via a background daemon, so chaining is safe and more efficient:

```bash
# Open, wait for load, and snapshot in one call
agent-browser open example.com && agent-browser wait --load networkidle && agent-browser snapshot -i

# Chain multiple interactions
agent-browser fill @e1 "user@example.com" && agent-browser fill @e2 "pass" && agent-browser click @e3

# Navigate and screenshot
agent-browser open example.com && agent-browser wait --load networkidle && agent-browser screenshot page.png
```

Use `&&` when you don't need intermediate output. Run commands separately when you need to parse output first (e.g., snapshot to discover refs before interacting).

## Integration Methods

### Skill Installation

Add the skill to your AI coding assistant for richer context:

```bash
npx skills add vercel-labs/agent-browser
```

This works with Claude Code, Codex, Cursor, Gemini CLI, GitHub Copilot, Goose, OpenCode, and Windsurf. The skill is fetched from the repository, so it stays up to date automatically.

### Claude Code

Install as a Claude Code skill:

```bash
npx skills add vercel-labs/agent-browser
```

This adds the skill to `.claude/skills/agent-browser/SKILL.md` in your project. The skill teaches Claude Code the full agent-browser workflow, including the snapshot-ref interaction pattern, session management, and timeout handling.

### AGENTS.md / CLAUDE.md

For more consistent results, add to your project or global instructions file:

```markdown
## Browser Automation

Use `agent-browser` for web automation. Run `agent-browser --help` for commands.

Core workflow:
1. `agent-browser open <url>` - Navigate to page
2. `agent-browser snapshot -i` - Get interactive elements (@e1, @e2)
3. `agent-browser click @e1` / `fill @e2 "text"` - Interact using refs
4. Re-snapshot after page changes
```
