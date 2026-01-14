# Claude Awareness Skill

Comprehensive knowledge base for Claude Code and the Anthropic ecosystem. Ensures all agents, skills, hooks, and commands follow official best practices.

## Current Status

✅ **Phase 1: Official Documentation** (IMPLEMENTED)
- Claude Code documentation pre-baked
- Anthropic Engineering blog insights cached
- Auto-invocation triggers configured
- Progressive disclosure enabled

✅ **Phase 1.5: Source Tracking & Auto-Caching** (IMPLEMENTED)
- Hierarchical source registry for all Claude/Anthropic content
- Automated fetch-and-cache scripts
- Feature version tracking (announced → released → deprecated)
- Release timeline tracking

⏳ **Phase 2: Project Patterns** (NOT IMPLEMENTED)
⏳ **Phase 3: External Repositories** (NOT IMPLEMENTED)

## Slash Commands

This skill provides slash commands for documentation management:

| Command | Description |
|---------|-------------|
| `/claude-docs-sync` | Sync all documentation sources to local cache |
| `/claude-docs-check` | Check cache freshness and status |
| `/claude-docs-fetch <url>` | Fetch a single URL to cache |

**Examples:**
```bash
/claude-docs-sync                     # Sync all stale sources
/claude-docs-sync --priority=1        # Only priority 1 sources
/claude-docs-sync --category=blog     # Only blog posts
/claude-docs-sync --force             # Force refresh all
/claude-docs-check --verbose          # Detailed status
/claude-docs-fetch https://agentskills.io/specification
```

## Quick Start

The skill automatically activates when you:
- Create a new agent, skill, hook, or command
- Validate existing artifacts
- Query best practices or latest features

Example:
```
> Create a new agent for API testing
```

The skill will auto-invoke and provide official guidance.

## Directory Structure

```
claude-awareness-skill/
├── SKILL.md                       # Main skill definition
├── state.json                     # Version tracking & state
├── README.md                      # This file
│
├── official/                      # Phase 1: Official patterns (IMPLEMENTED)
│   ├── patterns/                  # Creation guides
│   │   ├── agent-creation.md      # Complete agent guide
│   │   ├── skill-creation.md      # Complete skill guide
│   │   ├── hook-creation.md       # Complete hook guide (basic)
│   │   ├── hook-advanced.md       # Advanced hook patterns (v2.1.0+)
│   │   └── command-creation.md    # Complete command guide
│   ├── features/                  # Capability guides
│   │   ├── tool-usage.md          # Read, Write, Edit, Grep, Glob, Bash
│   │   ├── mcp-integration.md     # MCP servers & integration
│   │   └── code-execution.md      # Code execution with MCP
│   ├── validation/                # Quality checklists
│   │   ├── agent-checklist.md     # Agent validation
│   │   ├── skill-checklist.md     # Skill validation
│   │   ├── hook-checklist.md      # Hook validation (incl. v2.1.0+)
│   │   └── command-checklist.md   # Command validation
│   └── ecosystem/                 # Version & capability info
│       ├── claude-versions.md     # Model versions
│       └── model-capabilities.md  # Capability comparison
│
├── sources/                       # Phase 1.5: Source tracking (IMPLEMENTED)
│   ├── SOURCES.md                 # Human-readable source registry
│   ├── registry.json              # Machine-readable source definitions
│   └── versions.json              # Feature versions & release tracking
│
├── cache/                         # Auto-cached external documentation
│   ├── blog/                      # Engineering blog posts
│   ├── news/                      # Product announcements
│   ├── docs/                      # Official documentation
│   │   ├── code-claude-com/       # code.claude.com docs
│   │   └── anthropic/             # docs.anthropic.com
│   ├── github/                    # Repository content
│   │   ├── claude-code/           # anthropics/claude-code
│   │   ├── skills/                # anthropics/skills
│   │   └── claude-cookbooks/      # anthropics/claude-cookbooks
│   └── community/                 # Community resources
│
├── scripts/                       # Automation scripts
│   ├── sync-sources.sh            # Fetch and cache all sources
│   ├── fetch-source.sh            # Fetch a single source
│   └── check-updates.sh           # Check source freshness
│
├── project/                       # Phase 2: Project patterns (EMPTY)
│   └── .gitkeep
│
└── external/                      # Phase 3: External repos (EMPTY)
    └── .gitkeep
```

## Priority Hierarchy

The skill enforces a strict priority system:

1. **🏆 Official Patterns** (ALWAYS AUTHORITATIVE)
   - Source: Claude Code docs + Anthropic Engineering blog
   - Location: `official/` directory
   - Status: ✅ Implemented

2. **📋 Project Patterns** (Style & Conventions)
   - Source: Your `.claude/` directory
   - Location: `project/` directory
   - Status: ⏳ Phase 2 (not implemented)

3. **💡 External Repos** (Inspiration Only)
   - Source: Community Claude Code repos (YOU provide URLs)
   - Location: `external/` directory
   - Status: ⏳ Phase 3 (not implemented)

**Rule**: Official patterns NEVER overridden by project or external patterns.

## Phase 1: Official Documentation (IMPLEMENTED)

### What's Included

**Patterns** (How to create):
- Agents: Structure, frontmatter, system prompts, coordination
- Skills: Directory layout, state management, auto-invocation
- Hooks: Event types, matchers, security, common patterns
- Commands: Arguments, bash execution, file references

**Features** (How to use):
- Tool Usage: Read, Write, Edit, Grep, Glob, Bash best practices
- MCP Integration: Servers, transports, authentication, resources
- Code Execution: Jupyter integration, state persistence, efficiency

**Validation** (Quality checks):
- Comprehensive checklists for all artifact types
- Security considerations
- Performance optimization
- Team collaboration standards

**Ecosystem** (Stay current):
- Model versions (Sonnet 4.5, Opus, Haiku)
- Capability comparison
- Feature availability
- Update tracking

### How It Works

1. **Auto-Invocation**: Triggers on keywords like "create new agent"
2. **Freshness Check**: Verifies documentation is current (<14 days)
3. **Progressive Loading**: Loads only needed documentation
4. **Official Guidance**: Provides authoritative patterns
5. **Validation**: Checks against official checklists

### Update Management

**Conservative Strategy** (Token Efficient):
- Check documentation freshness on invocation
- Alert if >14 days since last check
- User manually triggers updates
- Only fetch if documentation changed

**Checking for Updates**:
```
> Check for Claude Code updates
```

**Applying Updates** (when available):
```
> Update Claude documentation
```

## Phase 1.5: Source Tracking & Auto-Caching (IMPLEMENTED)

### Source Hierarchy

The skill tracks ALL official Claude/Anthropic sources hierarchically:

| Domain | Priority | Content |
|--------|----------|---------|
| `github.com/anthropics/*` | 1 | claude-code, skills, claude-cookbooks repos |
| `code.claude.com/docs/*` | 1 | Claude Code documentation |
| `docs.anthropic.com/*` | 1 | API and SDK documentation |
| `anthropic.com/engineering/*` | 1 | Engineering blog (best practices) |
| `anthropic.com/news/*` | 2 | Product announcements |
| `claude.com/blog/*` | 2 | Claude product blog |
| Community resources | 3 | Curated community content |

### Feature Version Tracking

The skill tracks feature lifecycle status:
- **announced** → Feature mentioned but not available
- **beta** → Available for testing, may change
- **released** → Generally available, stable
- **deprecated** → Being phased out
- **removed** → No longer available

### Using the Scripts

```bash
# Navigate to skill directory
cd .claude/skills/claude-awareness-skill

# Check source freshness status
./scripts/check-updates.sh --verbose

# Sync all stale sources (respects freshness rules)
./scripts/sync-sources.sh

# Sync only priority 1 sources
./scripts/sync-sources.sh --priority=1

# Sync specific category
./scripts/sync-sources.sh --category=blog
./scripts/sync-sources.sh --category=docs
./scripts/sync-sources.sh --category=github

# Force refresh all sources (ignores cache freshness)
./scripts/sync-sources.sh --force

# Fetch a single source manually
./scripts/fetch-source.sh https://www.anthropic.com/engineering/claude-code-best-practices
```

### Freshness Rules

| Content Type | Check Frequency | Max Age |
|--------------|-----------------|---------|
| Release notes | Daily | 1 day |
| Blog posts | Weekly | 7 days |
| Documentation | Bi-weekly | 14 days |
| GitHub repos | Weekly | 7 days |
| Community | Monthly | 30 days |

### What Gets Cached

When you run `./scripts/sync-sources.sh`, the skill fetches:

**Engineering Blog** (Priority 1):
- claude-code-best-practices
- building-agents-with-the-claude-agent-sdk
- equipping-agents-for-the-real-world-with-agent-skills
- claude-code-sandboxing
- claude-think-tool
- code-execution-with-mcp
- advanced-tool-use

**Documentation** (Priority 1):
- Claude Code: hooks, sub-agents, skills, slash-commands, mcp, permissions, memory
- Anthropic: SDK reference, release notes

**GitHub** (Priority 1):
- claude-code: examples/hooks, plugins, CHANGELOG.md
- skills: README.md, skills directory
- claude-cookbooks: skills examples

---

## Phase 2: Project Pattern Analysis (NOT IMPLEMENTED)

### Purpose
Extract and document YOUR proven patterns from existing agents/skills/hooks/commands.

### What It Would Do

1. **Analyze Current `.claude/` Directory**:
   - Count and categorize agents (core vs domain)
   - Extract common frontmatter patterns
   - Document naming conventions
   - Identify coordination patterns

2. **Extract Project-Specific Patterns**:
   - Tool usage preferences
   - Model selection strategies
   - Directory organization
   - Documentation standards

3. **Document in `project/` Directory**:
   - `project/agents/patterns.md` - Your agent conventions
   - `project/skills/patterns.md` - Your skill structure
   - `project/hooks/patterns.md` - Your hook patterns
   - `project/commands/patterns.md` - Your command style

### When to Implement

When you want to:
- Document your team's conventions
- Create a style guide for new agents
- Ensure consistency across artifacts
- Provide examples from your codebase

### How to Implement

**Step 1**: Request analysis
```
> Analyze my project patterns for agents and skills
```

**Step 2**: Skill will:
- Scan `.claude/agents/` and `.claude/skills/`
- Extract patterns and conventions
- Document findings in `project/` directory
- Update state.json

**Step 3**: Project patterns become secondary validation
- Official patterns validated first (always)
- Project patterns applied for style/conventions
- Creates consistent team artifacts

**Estimated Time**: 1-2 hours for comprehensive analysis

## Phase 3: External Repository Analysis (NOT IMPLEMENTED)

### Purpose
Learn from community Claude Code repositories for inspiration (NEVER overrides official).

### What It Would Do

1. **Analyze External Repositories**:
   - YOU provide specific repo URLs
   - Skill analyzes their `.claude/` structure
   - Extracts interesting patterns
   - Documents in `external/` directory

2. **Create Inspiration Library**:
   - Agent patterns from community
   - Skill structures others use
   - Hook implementations
   - Command ideas

3. **Build Awesome List**:
   - Curated collection by category
   - Testing agents
   - Deployment patterns
   - Security hooks
   - Analytics skills

### When to Implement

When you want to:
- Learn from other Claude Code users
- Discover new patterns and approaches
- Build a reference library
- Find inspiration for new artifacts

### How to Implement

**Step 1**: Provide repo URL
```
> Analyze Claude Code patterns from github.com/user/awesome-agents
```

**Step 2**: Skill will:
- Fetch repository structure
- Analyze `.claude/` directory
- Extract interesting patterns
- Document in `external/` directory
- Add to awesome-list.md

**Step 3**: External patterns available as inspiration
- Official patterns still authoritative
- Project patterns for style
- External patterns for ideas only

**Note**: You must provide specific repo URLs. Skill does NOT discover repos automatically.

**Estimated Time**: 30-60 minutes per repository

## Documentation Sources

All documentation includes source URLs for verification:

**Official Claude Code Docs**:
- Base: https://code.claude.com/docs/en/
- Specific pages documented in each file

**Anthropic Engineering Blog**:
- Base: https://www.anthropic.com/engineering
- Articles: code-execution-with-mcp, agent-sdk, sandboxing, agent-skills

## State Management

The skill tracks its state in `state.json`:

```json
{
  "version": "1.0.0",
  "documentation": {
    "official": { /* version tracking */ },
    "project": { /* analysis status */ },
    "external": { /* repo list */ }
  },
  "config": {
    "updateStrategy": "conservative",
    "checkIntervalDays": 14
  }
}
```

## Token Efficiency

**Design Principles**:
- Pre-baked content (no runtime fetching)
- Progressive disclosure (load what's needed)
- Conservative updates (manual triggers)
- Efficient checks (checksum comparison only)

**Token Costs**:
- **Per use**: ~5-10k tokens (local file reads)
- **Freshness check**: ~1k tokens (checksum only)
- **Full update**: ~20-30k tokens (only when docs changed)

## Usage Examples

### Creating an Agent
```
> Create a new agent for PostgreSQL query optimization

Skill auto-invokes, loads official/patterns/agent-creation.md, provides:
- File structure and location
- Required frontmatter fields
- System prompt best practices
- Tool selection guidance
- Validation checklist
```

### Validating a Skill
```
> Validate my performance monitoring skill

Skill loads official/validation/skill-checklist.md, checks:
- Directory structure
- SKILL.md frontmatter
- State management
- Auto-invocation triggers
- Security considerations
Reports any issues with recommendations
```

### Querying Features
```
> What are the latest MCP integration patterns?

Skill loads official/features/mcp-integration.md, provides:
- Current MCP capabilities
- Integration methods
- Authentication patterns
- Example implementations
- Best practices
```

## Troubleshooting

### Skill Not Activating
- Check triggers in SKILL.md
- Use explicit keywords: "create new agent"
- Verify skill is in `.claude/skills/` directory

### Documentation Seems Outdated
- Check state.json `lastChecked` date
- Manually trigger: "Check for Claude Code updates"
- Apply updates if available

### Validation Failing
- Review official checklist for specific artifact type
- Compare against examples in pattern files
- Ensure following official structure

## Maintenance

### Regular Updates (Recommended)
- Check for updates every 2-4 weeks
- Review Anthropic Engineering blog for new articles
- Update state.json after applying updates

### Phase 2 Implementation (When Ready)
- Run project pattern analysis
- Review extracted patterns
- Refine and document conventions
- Use for team consistency

### Phase 3 Implementation (Optional)
- Curate list of interesting repos
- Analyze one repo at a time
- Build inspiration library
- Share awesome-list with team

## Contributing

### Adding Official Updates
1. Check for new Claude Code docs or blog posts
2. Fetch updated content
3. Update relevant files in `official/` directory
4. Update state.json with new versions
5. Document in history

### Implementing Phase 2
1. Scan `.claude/` directory
2. Extract patterns and conventions
3. Document in `project/` directory
4. Update state.json
5. Test secondary validation

### Implementing Phase 3
1. Receive repo URL from user
2. Analyze repository `.claude/` structure
3. Extract interesting patterns
4. Document in `external/` directory
5. Add to awesome-list.md
6. Update state.json

## License & Attribution

This skill consolidates information from:
- **Claude Code Documentation**: https://code.claude.com/docs
- **Anthropic Engineering Blog**: https://www.anthropic.com/engineering
- **MCP Specification**: modelcontextprotocol.io

All source URLs are documented in individual files.

## Version History

- **v1.0.0** (2025-01-15): Initial release with Phase 1 (Official documentation)
- **Future**: Phase 2 (Project patterns) when user requests
- **Future**: Phase 3 (External repos) when user provides URLs

---

**Remember**: This skill ensures ALL Claude Code artifacts follow official best practices. Official patterns are ALWAYS authoritative.
