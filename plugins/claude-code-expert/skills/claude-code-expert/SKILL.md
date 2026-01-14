#

 Claude/Anthropic Awareness Skill

---
name: claude-awareness-skill
description: Comprehensive Claude Code and Anthropic ecosystem knowledge. Provides official patterns for creating agents, skills, hooks, and commands. Auto-invokes when creating or validating Claude Code artifacts, checking best practices, or querying latest features. Use PROACTIVELY for agent/skill/hook/command creation and validation.
model: sonnet
allowed-tools: Read, Grep, Glob
context_persistence: true
auto_invoke: true
triggers:
  - "create new agent"
  - "create new skill"
  - "create new hook"
  - "create new command"
  - "validate agent"
  - "validate skill"
  - "validate hook"
  - "validate command"
  - "agent best practices"
  - "skill patterns"
  - "hook guidelines"
  - "command creation"
  - "best practices"
  - "check for updates"
  - "Claude Code features"
  - "MCP integration"
  - "latest capabilities"
  - "tool usage patterns"
  - "model selection"
---

## Purpose

This skill maintains authoritative knowledge of Claude Code and the Anthropic ecosystem, ensuring all agents, skills, hooks, and commands follow official best practices and leverage the latest capabilities.

## Core Responsibilities

### 1. Artifact Creation Guidance
Provide official patterns when creating:
- **Agents**: Specialized AI assistants with focused expertise
- **Skills**: Modular capability packages with persistent state
- **Hooks**: Event-driven automations for workflow enhancement
- **Commands**: Custom slash commands for reusable prompts

### 2. Validation & Quality Assurance
Validate artifacts against:
- Official structure requirements
- Security best practices
- Performance considerations
- Team collaboration standards

### 3. Ecosystem Awareness
Track and communicate:
- Latest Claude Code features
- New MCP integrations
- Model capabilities and updates
- Engineering blog insights

### 4. Best Practice Enforcement
Ensure adherence to:
- **Official patterns as PRIMARY source**
- Tool usage best practices
- Security and permission patterns
- Documentation standards

## Priority Hierarchy

🏆 **PRIORITY 1: Official Patterns** (ALWAYS AUTHORITATIVE)
- Claude Code documentation
- Anthropic Engineering blog
- Located in: `official/` directory

📋 **Priority 2: Project Patterns** (FUTURE - Phase 2)
- Your proven agent/skill structures
- Located in: `project/` directory
- Applied after official validation

💡 **Priority 3: External Repos** (FUTURE - Phase 3)
- Community Claude Code patterns
- Located in: `external/` directory
- Inspiration only, never overrides official

## Knowledge Base Structure

### Patterns (Creation Guides)
Load these for artifact creation:
- `official/patterns/agent-creation.md` - Complete agent creation guide
- `official/patterns/skill-creation.md` - Complete skill creation guide
- `official/patterns/hook-creation.md` - Complete hook creation guide (basic)
- `official/patterns/hook-advanced.md` - Advanced hook patterns (v2.1.0+)
- `official/patterns/command-creation.md` - Complete command creation guide

### Features (Capability Guides)
Load these for feature usage:
- `official/features/tool-usage.md` - Read, Write, Edit, Grep, Glob, Bash
- `official/features/mcp-integration.md` - MCP servers and integration
- `official/features/code-execution.md` - Code execution with MCP

### Validation (Quality Checklists)
Load these for validation:
- `official/validation/agent-checklist.md` - Agent quality checks
- `official/validation/skill-checklist.md` - Skill quality checks
- `official/validation/hook-checklist.md` - Hook quality checks
- `official/validation/command-checklist.md` - Command quality checks

### Ecosystem (Version Info)
Load these for version awareness:
- `official/ecosystem/claude-versions.md` - Model versions and capabilities
- `official/ecosystem/model-capabilities.md` - Detailed capability comparison

### Sources (External Documentation)
Hierarchical tracking of all Claude/Anthropic sources:
- `sources/SOURCES.md` - Human-readable source registry
- `sources/registry.json` - Machine-readable source definitions
- `sources/versions.json` - Feature versions and release tracking

### Cache (Fetched Documentation)
Auto-cached external documentation:
- `cache/blog/` - Engineering blog posts
- `cache/docs/` - Official documentation
- `cache/github/` - GitHub repository content
- `cache/community/` - Community resources

### Scripts (Automation)
Source synchronization and checking:
- `scripts/sync-sources.sh` - Fetch and cache all sources
- `scripts/fetch-source.sh` - Fetch a single source
- `scripts/check-updates.sh` - Check source freshness

## Progressive Disclosure Strategy

**Level 1: Auto-Invocation** (This file)
- Skill activates based on triggers
- Determines which guides to load
- Provides initial context

**Level 2: Pattern Loading** (On-demand)
- Load specific pattern file based on task
- E.g., creating agent → load `agent-creation.md`
- Full creation guide with examples

**Level 3: Validation** (Post-creation)
- Load relevant checklist
- Validate against all criteria
- Report issues and suggestions

**Level 4: Feature Deep-Dive** (As needed)
- Load feature guides for specific capabilities
- E.g., MCP integration → load `mcp-integration.md`
- Comprehensive feature documentation

## Workflow Examples

### Creating a New Agent

```
1. User: "Create an agent for code security reviews"
2. Skill auto-invokes (trigger: "create new agent")
3. Check state.json for documentation freshness
4. Load official/patterns/agent-creation.md
5. Provide structure guidance following official patterns
6. After creation, load official/validation/agent-checklist.md
7. Validate agent against checklist
8. Report validation results
```

### Creating a New Skill

```
1. User: "Create a skill for tracking performance metrics"
2. Skill auto-invokes (trigger: "create new skill")
3. Check state.json for documentation freshness
4. Load official/patterns/skill-creation.md
5. Provide directory structure and state management guidance
6. After creation, load official/validation/skill-checklist.md
7. Validate skill against checklist
8. Report validation results
```

### Validating Existing Artifact

```
1. User: "Validate my authentication hook"
2. Skill auto-invokes (trigger: "validate hook")
3. Load official/validation/hook-checklist.md
4. Review hook against all checklist items
5. Identify any issues or improvements
6. Provide specific recommendations
```

### Checking Latest Features

```
1. User: "What are the latest MCP capabilities?"
2. Skill auto-invokes (trigger: "latest capabilities")
3. Check state.json for last documentation check
4. Load official/features/mcp-integration.md
5. Load official/ecosystem/claude-versions.md
6. Provide current capabilities and recent updates
7. Suggest checking for updates if stale (>14 days)
```

## Documentation Freshness Management

### State Tracking
The skill maintains `state.json` with:
- Last documentation check date
- Documentation version checksums
- Feature adoption status
- Update recommendations

### Freshness Checks - IMPLEMENTATION

**On Every Invocation**:
1. Read `.claude/skills/claude-awareness-skill/state.json`
2. Extract `documentation.official.claudeCode.lastChecked` date
3. Calculate days since last check (compare to today's date: 2025-11-10)
4. If > 14 days: Add notice to response

**Freshness Notice Template**:
```markdown
---
📅 **Documentation Freshness Notice**

Last checked: [lastChecked date]
Days since check: [X days]

The Claude Code documentation may have updates. To check:
- Visit: https://code.claude.com/docs/
- Or ask me to "check for Claude Code updates"

---
```

### Update Process

**Automated Update Workflow** (Using scripts):
```bash
# Check source freshness status
./scripts/check-updates.sh --verbose

# Sync all stale sources
./scripts/sync-sources.sh

# Sync only priority 1 sources
./scripts/sync-sources.sh --priority=1

# Sync specific category
./scripts/sync-sources.sh --category=blog

# Force refresh all sources
./scripts/sync-sources.sh --force
```

**Manual Update Workflow** (User initiated):
1. User asks: "Check for Claude Code updates"
2. Run `./scripts/check-updates.sh --verbose`
3. Review stale/missing sources
4. Run `./scripts/sync-sources.sh` to fetch updates
5. State.json is automatically updated with new `lastChecked` date

**Source Registry** (`sources/registry.json`):
Tracks all official sources hierarchically:
- github.com/anthropics/* - All Anthropic repositories
- code.claude.com/docs/* - Claude Code documentation
- docs.anthropic.com/* - API documentation
- anthropic.com/engineering/* - Engineering blog
- anthropic.com/news/* - Product announcements

### State.json Update Protocol

After checking for updates (whether found or not):
1. Update `documentation.official.claudeCode.lastChecked` to current date
2. Update `documentation.official.claudeCode.docsMapChecksum` if fetched
3. Set `documentation.official.claudeCode.needsUpdate` to true/false
4. Add history entry with timestamp and findings

**Example state.json update**:
```json
{
  "documentation": {
    "official": {
      "claudeCode": {
        "version": "2025-01-15",
        "lastChecked": "2025-11-10T00:00:00Z",
        "docsMapChecksum": "sha256:abc123...",
        "needsUpdate": false
      }
    }
  },
  "history": [
    {
      "timestamp": "2025-11-10T00:00:00Z",
      "event": "freshness_check",
      "description": "Checked Claude Code documentation map",
      "result": "No updates found"
    }
  ]
}
```

### Conservative Strategy
- **No auto-updates**: User controls when to fetch latest
- **Alert only**: Notify when documentation is stale (>14 days)
- **Token efficient**: Minimal checks, update on demand
- **Manual verification**: User reviews changes before applying

## Security & Safety

### Official Patterns Enforcement
- **Always validate** against official patterns first
- **Never override** official security guidelines
- **Warn** if practices deviate from official standards

### Sensitive Operations
- Review hook permissions carefully
- Validate bash command safety
- Check file access restrictions
- Ensure no secrets in artifacts

### Team Collaboration
- Distinguish project vs personal artifacts
- Validate shareability and documentation
- Check naming conflicts
- Ensure appropriate tool restrictions

## Integration with Other Agents/Skills

### Coordination Points
- Works with **agent-quality-controller** for validation
- Complements **agent-orchestrator** for workflow design
- Enhances **performance-optimizer** with latest features
- Supports **security** agents with official patterns

### When to Invoke
- **Creating** any Claude Code artifact
- **Validating** existing implementations
- **Querying** best practices or capabilities
- **Checking** for updates or new features

## Usage Instructions

### For Users
Simply mention the triggers naturally:
- "Create a new agent for API testing"
- "Validate this skill structure"
- "What are the best practices for hooks?"
- "Show me the latest MCP features"

The skill will auto-invoke and provide official guidance.

### For Claude
When this skill activates:
1. Check state.json for freshness
2. Load relevant official documentation
3. Provide guidance following official patterns
4. Validate if requested
5. Report clearly and concisely

## Future Phases

### Phase 2: Project Patterns (Not Implemented)
- Analyze `.claude/` directory
- Extract proven patterns
- Document in `project/` directory
- Secondary validation layer

See `README.md` for implementation instructions.

### Phase 3: External Repos (Not Implemented)
- User provides repo URLs
- Analyze external `.claude/` structures
- Cache patterns in `external/` directory
- Inspiration only, never authoritative

See `README.md` for implementation instructions.

## Quick Reference

**Creating Artifacts**:
- Agents: `official/patterns/agent-creation.md`
- Skills: `official/patterns/skill-creation.md`
- Hooks: `official/patterns/hook-creation.md`
- Commands: `official/patterns/command-creation.md`

**Validating**:
- All checklists in `official/validation/`

**Features**:
- Tools: `official/features/tool-usage.md`
- MCP: `official/features/mcp-integration.md`
- Code Execution: `official/features/code-execution.md`

**Versions**:
- Models: `official/ecosystem/claude-versions.md`
- Capabilities: `official/ecosystem/model-capabilities.md`

## Update History

- **2025-01-15**: Initial skill creation with Phase 1 (Official docs)
- **Future**: Phase 2 (Project patterns) when user requests
- **Future**: Phase 3 (External repos) when user provides URLs

---

**Remember**: Official patterns are ALWAYS authoritative. Project and external patterns provide style and inspiration but never override official guidelines.
