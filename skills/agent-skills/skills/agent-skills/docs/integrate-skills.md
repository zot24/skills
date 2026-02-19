> Source: https://agentskills.io/integrate-skills

# Integrate Skills into Your Agent

How to add Agent Skills support to your agent or tool.

## Integration Approaches

The two main approaches to integrating skills are:

**Filesystem-based agents** operate within a computer environment (bash/unix) and represent the most capable option. Skills are activated when models issue shell commands like `cat /path/to/my-skill/SKILL.md`. Bundled resources are accessed through shell commands.

**Tool-based agents** function without a dedicated computer environment. Instead, they implement tools allowing models to trigger skills and access bundled assets. The specific tool implementation is up to the developer.

## Overview

A skills-compatible agent needs to:

1. **Discover** skills in configured directories
2. **Load metadata** (name and description) at startup
3. **Match** user tasks to relevant skills
4. **Activate** skills by loading full instructions
5. **Execute** scripts and access resources as needed

## Skill Discovery

Skills are folders containing a `SKILL.md` file. Your agent should scan configured directories for valid skills.

## Loading Metadata

At startup, parse only the frontmatter of each `SKILL.md` file. This keeps initial context usage low.

### Parsing Frontmatter

```
function parseMetadata(skillPath):
    content = readFile(skillPath + "/SKILL.md")
    frontmatter = extractYAMLFrontmatter(content)

    return {
        name: frontmatter.name,
        description: frontmatter.description,
        path: skillPath
    }
```

### Injecting into Context

Include skill metadata in the system prompt so the model knows what skills are available.

Follow your platform's guidance for system prompt updates. For example, for Claude models, the recommended format uses XML:

```xml
<available_skills>
  <skill>
    <name>pdf-processing</name>
    <description>Extracts text and tables from PDF files, fills forms, merges documents.</description>
    <location>/path/to/skills/pdf-processing/SKILL.md</location>
  </skill>
  <skill>
    <name>data-analysis</name>
    <description>Analyzes datasets, generates charts, and creates summary reports.</description>
    <location>/path/to/skills/data-analysis/SKILL.md</location>
  </skill>
</available_skills>
```

For filesystem-based agents, include the `location` field with the absolute path to the SKILL.md file. For tool-based agents, the location can be omitted.

Keep metadata concise. Each skill should add roughly 50-100 tokens to the context.

## Security Considerations

Script execution introduces security risks. Consider:

- **Sandboxing**: Run scripts in isolated environments
- **Allowlisting**: Only execute scripts from trusted skills
- **Confirmation**: Ask users before running potentially dangerous operations
- **Logging**: Record all script executions for auditing

## Reference Implementation

The [skills-ref](https://github.com/agentskills/agentskills/tree/main/skills-ref) library provides Python utilities and a CLI for working with skills.

For example:

**Validate a skill directory:**

```bash
skills-ref validate <path>
```

**Generate `<available_skills>` XML for agent prompts:**

```bash
skills-ref to-prompt <path>...
```

Use the library source code as a reference implementation.

## Progressive Disclosure Flow

1. **Startup**: Load only `name` and `description` from all skills (~100 tokens each)
2. **Task Matching**: When user request matches a skill's description, load full SKILL.md
3. **Execution**: Load scripts/references/assets only when specifically needed
4. **Cleanup**: Release loaded content when task completes

## Implementation Checklist

- [ ] Scan configured directories for SKILL.md files
- [ ] Parse YAML frontmatter to extract metadata
- [ ] Inject available skills into system prompt
- [ ] Implement mechanism to load full SKILL.md on activation
- [ ] Provide file access for bundled resources
- [ ] (Optional) Implement script execution with sandboxing
- [ ] (Optional) Add logging for skill usage analytics
