# Claude Versions and Capabilities

> **Source**: Official Claude Code Documentation & Anthropic Release Notes
> **Source URL**: https://code.claude.com/docs/en/overview
> **Last Updated**: 2026-02-19

## Current Claude Models

### Claude Opus 4.6 (Most Capable)

**Model ID**: `claude-opus-4-6`

**Key Capabilities**:
- Most capable Claude model available
- Best for complex tasks requiring deep reasoning
- Superior performance on difficult problems
- Excellent for critical decision-making
- Multimodal (text and images)

**Best For**:
- Complex architectural decisions
- Critical code reviews and security audits
- Research and deep analysis
- Tasks requiring maximum accuracy
- Agent orchestration for high-stakes workflows

**Context Window**: 200K tokens

**Model Alias**: `opus`

### Claude Sonnet 4.5 (Recommended Default)

**Model ID**: `claude-sonnet-4-5-20250514`

**Key Capabilities**:
- Best balance of performance and speed
- Excellent for coding tasks
- Strong reasoning capabilities
- Extended context window
- Multimodal (text and images)

**Best For**:
- General-purpose development tasks
- Code review and analysis
- Complex reasoning
- Agent workflows
- Production applications

**Context Window**: 200K tokens

**Model Alias**: `sonnet`

### Claude Haiku 4.5 (Fastest)

**Model ID**: `claude-haiku-4-5-20250514`

**Key Capabilities**:
- Fastest response time
- Lower cost
- Good for straightforward tasks
- Quick iterations

**Best For**:
- Simple, well-defined tasks
- Quick edits and refactors
- Repetitive operations
- Cost-sensitive applications
- High-volume requests
- Exploration agents (built-in Explore agent uses Haiku)

**Context Window**: 200K tokens

**Model Alias**: `haiku`

## Model Aliases

Claude Code supports model aliases for convenience:

| Alias | Maps To | Usage |
|-------|---------|-------|
| `opus` | `claude-opus-4-6` | In agents/skills `model` field |
| `sonnet` | `claude-sonnet-4-5-20250514` | Default recommendation |
| `haiku` | `claude-haiku-4-5-20250514` | Fast, cost-efficient |

Use aliases in agent and skill frontmatter:
```yaml
model: sonnet   # Uses latest Sonnet
model: opus     # Uses latest Opus
model: haiku    # Uses latest Haiku
```

Or use full model IDs for version pinning:
```yaml
model: claude-sonnet-4-5-20250514  # Pinned to specific version
```

## Claude Code Features

### Tool Ecosystem
- Read: File content access
- Write: File creation
- Edit: Precise file modifications
- Grep: Fast content search (ripgrep-based)
- Glob: File pattern matching
- Bash: System command execution

### MCP Integration
- Model Context Protocol support
- Hundreds of MCP servers available
- HTTP (recommended), SSE, and stdio transports
- OAuth 2.0 authentication
- Three scopes: local, project, user
- MCP Tool Search for discovery
- @-mention resources
- Plugin-provided MCP servers

### Code Execution
- Jupyter integration
- Python code execution
- Interactive programming
- Data analysis capabilities

### Agent Features
- Custom subagents with YAML frontmatter
- Built-in agents: Explore, Plan, general-purpose, Bash
- Agent permissions: default, acceptEdits, bypassPermissions, plan
- maxTurns control
- Skills preloading in agents
- MCP server scoping per agent
- Agent hooks
- Persistent memory (user/project/local scopes)
- Foreground and background execution
- Agent resumption with transcripts

### Skills System (Unified with Commands)
- Dynamic skill loading from `.claude/skills/`
- Legacy command support from `.claude/commands/`
- Auto-invocation based on description matching
- Progressive disclosure pattern
- `context: fork` for isolated execution
- `argument-hint` for parameter guidance
- `$ARGUMENTS`, `$1`, `$2` positional arguments
- `!` bash execution and `@` file references
- Hooks scoped to skill lifecycle
- Visibility control (user-invocable, disable-model-invocation)
- Plugin distribution

### Hooks System
- 14 lifecycle events (SessionStart, UserPromptSubmit, PreToolUse, PermissionRequest, PostToolUse, PostToolUseFailure, Notification, SubagentStart, SubagentStop, Stop, TeammateIdle, TaskCompleted, PreCompact, SessionEnd)
- Three hook types: command, prompt, agent
- Async hook support
- JSON output for decision control
- MCP tool matchers
- Session lifecycle matchers (startup, resume, clear, compact)
- `once: true` for single execution
- Frontmatter scoping with path patterns

### Sandboxing
- Filesystem isolation
- Network isolation
- Security boundaries
- Custom proxy rules

## Feature Availability Matrix

| Feature | Opus 4.6 | Sonnet 4.5 | Haiku 4.5 |
|---------|----------|-----------|-----------|
| Extended Thinking | Yes | Yes | Yes |
| Multimodal (Images) | Yes | Yes | Yes |
| Code Execution | Yes | Yes | Yes |
| MCP Integration | Yes | Yes | Yes |
| Subagents | Yes | Yes | Yes |
| Skills | Yes | Yes | Yes |
| Hooks | Yes | Yes | Yes |
| Sandboxing | Yes | Yes | Yes |
| Tool Ecosystem | Yes | Yes | Yes |

## Model Selection Guidance

### When to Use Opus 4.6
**Maximum capability needed**:
- Complex architectural decisions
- Critical security reviews
- Research and deep analysis
- Tasks where accuracy is paramount
- Multi-step reasoning chains
- High-stakes agent workflows

### When to Use Sonnet 4.5
**Default choice for most tasks**:
- Balanced performance and cost
- Latest capabilities
- General development work
- Production applications
- Most agent workflows
- Code review and analysis

### When to Use Haiku 4.5
**Speed and cost optimization**:
- Simple, repetitive tasks
- Quick edits and formatting
- Straightforward refactors
- High-volume operations
- Cost-sensitive projects
- Fast iteration cycles
- Codebase exploration

## Platform Support

### Claude Code CLI
- macOS, Linux, Windows
- Terminal-native operation
- Git integration
- CI/CD compatible

### Claude.ai Web
- Browser-based access
- Team collaboration
- File uploads
- Project organization

### Claude Desktop
- Desktop application
- MCP extensions
- Local file access

### IDE Extensions
- VS Code integration
- JetBrains plugin
- In-editor assistance

### API Access
- Direct API integration
- Claude Agent SDK
- Custom integrations
- Programmatic access

## Community & Ecosystem

### MCP Ecosystem
- **Thousands of MCP servers** built by community
- **SDKs available** in all major languages
- **Industry adoption** as de-facto standard
- **Active community** at modelcontextprotocol.io

### Plugin Marketplace
- Community plugins
- Team-shareable skills
- Pre-built agents
- Workflow templates

### Open Source
- MCP protocol is open source
- Community contributions
- Extensible architecture

## Staying Current

### Official Channels
- Anthropic Engineering Blog: https://www.anthropic.com/engineering
- Claude Code Docs: https://code.claude.com/docs
- MCP Community: modelcontextprotocol.io/community

### Update Frequency
- **Documentation**: Regularly updated with new features
- **Models**: New versions released periodically
- **Features**: Continuous improvements and additions

## Version Tracking

**Current Documentation Version**: 2026-02-19

**Latest Models**: Claude Opus 4.6, Claude Sonnet 4.5, Claude Haiku 4.5

## Recommended Practices

### Model Selection in Agents
```yaml
---
model: sonnet  # Default recommendation
---
```

### Model Selection in Skills
```yaml
---
model: haiku  # For simple, frequent operations
---
```

### Model Override
Use `opus` for critical operations:
```yaml
---
model: opus  # When maximum accuracy needed
---
```

### Model Inheritance
Omit model field to inherit from main conversation:
```yaml
---
# model field omitted - uses parent model
---
```

---

**Note**: This document reflects capabilities as of February 2026. For the latest information, refer to:
- https://code.claude.com/docs
- https://www.anthropic.com/engineering
