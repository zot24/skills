# Agent Creation Pattern

> **Source**: Official Claude Code Documentation
> **Source URL**: https://code.claude.com/docs/en/sub-agents.md
> **Last Updated**: 2026-02-19

## What Are Subagents?

Subagents are specialized AI assistants stored as Markdown files with YAML frontmatter. They enable focused expertise, tool restriction, and reusable workflows across projects. Each subagent runs in its own context window, preventing pollution of the main conversation.

## File Structure

### Storage Locations (Priority Order)
1. **Project-level**: `.claude/agents/` (highest priority, current project only)
2. **User-level**: `~/.claude/agents/` (available across all projects)
3. **Plugin-provided**: Within plugin `agents/` directories

### Basic Structure
```markdown
---
name: agent-identifier
description: When and why to use this agent
tools: tool1, tool2, tool3
model: sonnet
---

System prompt content describing the agent's role,
capabilities, and approach to problem-solving.
```

## Required Fields

| Field | Required | Format | Description |
|-------|----------|--------|-------------|
| `name` | **Yes** | Lowercase with hyphens | Unique identifier (e.g., `code-reviewer`) |
| `description` | **Yes** | Natural language | When/why to use this agent, triggers |

## Optional Fields

| Field | Default | Purpose |
|-------|---------|---------|
| `tools` | All tools | Comma-separated list to restrict access |
| `model` | Inherits | `sonnet`, `opus`, `haiku`, or `'inherit'` |
| `permissionMode` | Inherits | `default`, `acceptEdits`, `bypassPermissions`, or `plan` |
| `maxTurns` | Unlimited | Maximum number of agent turns before stopping |
| `skills` | None | Comma-separated list of skills to preload into context |
| `mcpServers` | Inherits | Comma-separated list of MCP servers to make available |
| `hooks` | None | Hook definitions scoped to this agent (same format as settings.json hooks) |

**Important**: When `tools` field is omitted, agent inherits ALL available tools, including MCP server integrations.

### Permission Modes

| Mode | Behavior |
|------|----------|
| `default` | Normal permission prompts for tool use |
| `acceptEdits` | Auto-approve file edits, prompt for other operations |
| `bypassPermissions` | Skip all permission prompts (use with caution) |
| `plan` | Read-only mode, cannot make changes |

### Full-Featured Frontmatter Example

```yaml
---
name: security-auditor
description: Use PROACTIVELY for security code reviews. MUST BE USED when analyzing authentication, authorization, or handling sensitive data.
tools: Read, Grep, Glob, Bash
model: opus
permissionMode: plan
maxTurns: 50
skills: owasp-checker, dependency-scanner
mcpServers: snyk-server
---
```

## Built-in Subagents

Claude Code includes several built-in subagents that are automatically available:

| Agent | Model | Tools | Purpose |
|-------|-------|-------|---------|
| **Explore** | Haiku | Read, Grep, Glob (read-only) | Fast codebase exploration and file discovery |
| **Plan** | Inherits | Read, Grep, Glob (read-only) | Create implementation plans without modifying files |
| **general-purpose** | Inherits | All tools | Default subagent for delegated tasks |
| **Bash** | Inherits | Bash only | Execute shell commands in isolation |
| **statusline-setup** | Haiku | Bash, Read | Configure terminal status line display |
| **Claude Code Guide** | Inherits | Read | Answer questions about Claude Code itself |

### Using Built-in Agents

Built-in agents are invoked automatically by Claude when appropriate, or can be requested explicitly:

```
> Use the Explore agent to find all authentication-related files
> Have the Plan agent create an implementation strategy for this feature
```

## Model Selection for Agents

Choose the appropriate model based on the agent's complexity, frequency of use, and accuracy requirements:

### When to Use Haiku

**Best for**:
- Simple, repetitive tasks
- High-frequency operations (executed many times per session)
- Straightforward transformations
- Well-defined, narrow scope
- Cost-sensitive applications

**Examples**:
```yaml
# Format converter - simple, repetitive
name: json-formatter
model: haiku

# File renamer - straightforward operations
name: file-renamer
model: haiku

# Simple linter - well-defined rules
name: code-linter
model: haiku
```

### When to Use Sonnet (Default Recommendation)

**Best for**:
- General-purpose agents
- Balanced complexity and performance needs
- Standard development workflows
- Code reviews and refactoring
- Most production use cases

**Examples**:
```yaml
# Code reviewer - balanced analysis
name: code-reviewer
model: sonnet

# API integration - moderate complexity
name: api-integrator
model: sonnet

# Debugger - requires reasoning
name: debugger
model: sonnet
```

### When to Use Opus

**Best for**:
- Critical decision-making
- Complex architectural analysis
- Security audits
- Novel problem-solving
- High-stakes situations where accuracy is paramount

**Examples**:
```yaml
# Security auditor - critical accuracy needed
name: security-auditor
model: opus

# System architect - complex decisions
name: system-architect
model: opus

# Compliance reviewer - high stakes
name: compliance-reviewer
model: opus
```

### Decision Framework

Ask yourself these questions:

1. **Task Complexity**: How intricate is the reasoning required?
   - Simple -> Haiku
   - Moderate -> Sonnet
   - Complex -> Opus

2. **Frequency of Use**: How often will this agent run?
   - Very frequent -> Haiku (cost-efficient)
   - Regular -> Sonnet (balanced)
   - Occasional -> Opus (when needed)

3. **Error Cost**: What's the impact of mistakes?
   - Low impact -> Haiku
   - Moderate impact -> Sonnet
   - High impact/critical -> Opus

4. **Speed vs Accuracy Trade-off**: What matters more?
   - Speed priority -> Haiku
   - Balanced -> Sonnet
   - Accuracy priority -> Opus

**Tip**: Start with Sonnet for most agents. Switch to Haiku if the task proves simple and repetitive. Upgrade to Opus if critical accuracy is needed.

## System Prompt Best Practices

Effective system prompts should include:

### 1. Role Definition
Clear statement of expertise and responsibilities:
```markdown
You are a security-focused code reviewer specializing in identifying
vulnerabilities in web applications. You have deep expertise in OWASP
Top 10 vulnerabilities and secure coding practices.
```

### 2. Specific Instructions
Step-by-step processes when invoked:
```markdown
When invoked:
1. Read all changed files
2. Analyze for security vulnerabilities
3. Check for OWASP Top 10 issues
4. Review authentication/authorization logic
5. Examine input validation
```

### 3. Checklists
Review criteria and validation steps:
```markdown
## Security Checklist
- [ ] No SQL injection vulnerabilities
- [ ] Proper input validation
- [ ] Secure password handling
- [ ] No hardcoded secrets
- [ ] CSRF protection in place
```

### 4. Output Format
How results should be presented:
```markdown
## Output Format

Provide findings as:
- **Critical**: Immediate security risks
- **High**: Important vulnerabilities
- **Medium**: Should be addressed
- **Low**: Minor improvements
```

### 5. Constraints
Limitations or focus areas:
```markdown
## Constraints
- Focus ONLY on security issues
- Do NOT refactor for style
- Prioritize authentication/authorization bugs
- Flag any secrets in code
```

### 6. Examples
Concrete scenarios demonstrating expected behavior:
```markdown
## Example Analysis

**Bad**:
```javascript
const query = `SELECT * FROM users WHERE id = ${userId}`;
```

**Issue**: SQL injection vulnerability
**Fix**: Use parameterized queries
```

## Tool Selection Strategy

**Limit to necessary tools** for the agent's specific purpose:

```yaml
# Security reviewer - read-only
tools: Read, Grep, Glob

# Code generator - full access
tools: Read, Write, Edit, Grep, Glob, Bash

# Database specialist - includes MCP
# (omit tools field to inherit all, including MCP servers)
```

Benefits of tool restriction:
- Improves security
- Maintains focus
- Prevents unintended actions

## When to Use Subagents

Use subagents when:
- Tasks require specialized expertise or dedicated focus
- Separate context windows prevent pollution of main conversation
- Consistent workflows benefit from reusable configurations
- Tool permissions need restriction for security
- Complex projects require multiple specialized assistants
- Team sharing and collaboration needed
- You need to control permission behavior per task (via `permissionMode`)
- Long-running tasks benefit from turn limits (via `maxTurns`)

## Invocation Patterns

### Automatic Delegation
Claude automatically invokes appropriate agents based on task description matching agent description.

**Encourage automatic selection** with these phrases in descriptions:
- "use PROACTIVELY"
- "MUST BE USED when..."
- "Auto-invokes when..."

Example:
```yaml
description: Use PROACTIVELY for security code reviews. MUST BE USED when analyzing authentication, authorization, or handling sensitive data.
```

### Explicit Invocation
Users can directly request specific agents:
```
> Use the code-reviewer agent to examine my changes
> Have the debugger agent investigate this error
> Ask the data-scientist agent to analyze these metrics
```

### Foreground vs Background Execution

Subagents can run in the **foreground** (default) or **background**:

- **Foreground**: The main conversation waits for the subagent to complete before continuing. Results are returned inline.
- **Background**: The subagent runs concurrently while the main conversation continues. Results are available when the subagent finishes.

Background execution is useful for long-running tasks like comprehensive code reviews or test suite execution that should not block the user.

## Persistent Memory

Subagents can store and retrieve persistent memory across sessions:

### Memory Scopes

| Scope | Location | Shared |
|-------|----------|--------|
| `user` | `~/.claude/agent-memory/` | Across all projects |
| `project` | `.claude/agent-memory/` | Within project team |
| `local` | `.claude.local/agent-memory/` | Current machine only |

### Memory Usage

Agents can read and write to memory files to maintain state:
- Store learned preferences and patterns
- Cache analysis results for reuse
- Track ongoing tasks across sessions
- Build knowledge bases over time

Memory files are simple text/markdown files that agents can read and write using standard file tools.

## Common Agent Patterns

### Code Reviewer Pattern
```yaml
---
name: code-reviewer
description: Reviews code for quality, security, and maintainability. Use for pull requests, security audits, and code quality checks.
tools: Read, Grep, Glob, Bash
model: sonnet
permissionMode: plan
---

You are an experienced code reviewer focusing on:
- Code quality and maintainability
- Security vulnerabilities (OWASP Top 10)
- Best practices and patterns
- Error handling and edge cases
- Test coverage

## Review Checklist
- [ ] Clear, descriptive naming
- [ ] No code duplication
- [ ] Proper error handling
- [ ] No secrets in code
- [ ] Input validation present
- [ ] Test coverage adequate
```

### Debugger Pattern
```yaml
---
name: debugger
description: Specializes in root cause analysis and bug fixing. Use when investigating errors, exceptions, or unexpected behavior.
tools: Read, Grep, Glob, Bash
model: sonnet
---

You are a debugging specialist who:
1. Captures error messages and stack traces
2. Identifies reproduction steps
3. Isolates failures through systematic testing
4. Implements minimal, targeted fixes
5. Reviews recent changes and logs
```

### Data Analyst Pattern
```yaml
---
name: data-analyst
description: Handles SQL queries and data analysis. Use for database operations, metrics analysis, and reporting.
tools: Read, Write, Bash
# Omit tools to inherit MCP servers like PostgreSQL
model: sonnet
---

You are a data analyst specializing in:
- Writing optimized SQL queries
- Data extraction and transformation
- Metrics calculation and analysis
- Clear data visualization
- Actionable recommendations
```

### Exploration Agent Pattern
```yaml
---
name: codebase-explorer
description: Use PROACTIVELY to understand unfamiliar codebases. Maps architecture, identifies patterns, and documents structure.
tools: Read, Grep, Glob
model: haiku
permissionMode: plan
maxTurns: 30
---

You are a codebase exploration specialist. When invoked:
1. Map the top-level directory structure
2. Identify key entry points and configuration files
3. Trace dependency relationships
4. Document architectural patterns
5. Summarize findings in a structured format

Focus on understanding, not modification.
```

## Coordination Between Agents

### Agent Chaining
Combine multiple agents for complex workflows:
```
> First use code-analyzer for performance issues,
  then use optimizer to fix them
```

### Agent Resumption
Continue previous agent work with unique agent IDs:
```
> Resume work from agent-abc123
```

Agent transcripts are stored in `agent-{agentId}.jsonl` for continuity across sessions.

### Preloading Skills

Agents can preload specific skills into their context:
```yaml
---
name: api-builder
description: Builds REST APIs with best practices
skills: openapi-spec, database-patterns
---
```

This loads the specified skills' SKILL.md content into the agent's context window at startup.

## Creation Approaches

### Recommended: AI-Assisted Creation
1. Describe the agent's purpose to Claude
2. Let Claude generate initial configuration
3. Review and customize the output
4. Save to appropriate directory
5. Test and iterate

### Manual Creation
1. Create Markdown file in `.claude/agents/` or `~/.claude/agents/`
2. Add required YAML frontmatter
3. Write comprehensive system prompt
4. Test with sample tasks
5. Refine based on results

### CLI Configuration

Use `--agents` flag with JSON for session-specific agents:
```bash
# Single agent
claude --agents '{"name":"temp-agent","description":"...","tools":"Read,Grep"}'

# Multiple agents from JSON file
claude --agents agents-config.json
```

The `--agents` flag accepts either inline JSON or a path to a JSON file containing agent definitions.

## Organizational Principles

### Core Agents (Generic Patterns)
Location: `.claude/agents/core/`

Categories:
- `backend-api/` - API patterns, database, security
- `infrastructure-deployment/` - Vercel, CI/CD, monitoring
- `frontend-development/` - Next.js, React, TypeScript
- `content-marketing/` - SEO, analytics, documentation
- `quality-assurance/` - Testing patterns
- `meta-orchestration/` - Agent coordination
- `business-strategy/` - Planning, metrics, research

### Domain Agents (Business Knowledge)
Location: `.claude/agents/domain/`

Contains business-specific knowledge without credentials.

### Three-Tier Architecture
```
Core (Generic Patterns)
  -> extends
Domain (Business Knowledge)
  -> extends
Project (Credentials & Configs)
```

## Best Practices Summary

1. **Focused responsibility**: Each agent handles single, clear objectives
2. **Detailed guidance**: Comprehensive instructions improve performance
3. **Version control**: Store project agents in repositories for collaboration
4. **Scope clarity**: Explicit descriptions help automatic agent selection
5. **Tool minimalism**: Limit tools to necessary operations
6. **Permission control**: Use `permissionMode` to restrict agent capabilities appropriately
7. **Turn limits**: Set `maxTurns` to prevent runaway agents on complex tasks
8. **Skill preloading**: Use `skills` field to inject relevant context
9. **Test thoroughly**: Validate agent behavior before team deployment
10. **Iterate based on usage**: Monitor performance and refine prompts

## Quick Reference

**Minimum viable agent**:
```yaml
---
name: my-agent
description: What this agent does and when to use it
---

Role definition and instructions here.
```

**Full-featured agent**:
```yaml
---
name: comprehensive-agent
description: Detailed description with PROACTIVE trigger keywords
tools: Read, Write, Edit, Grep, Glob
model: sonnet
permissionMode: acceptEdits
maxTurns: 100
skills: relevant-skill-1, relevant-skill-2
mcpServers: my-mcp-server
---

# Role
Detailed role definition

# Capabilities
What you can do

# Instructions
Step-by-step process

# Checklist
Validation criteria

# Output Format
How to present results

# Examples
Concrete demonstrations
```
