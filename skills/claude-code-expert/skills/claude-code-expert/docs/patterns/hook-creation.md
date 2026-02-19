# Hook Creation Pattern

> **Source**: Official Claude Code Documentation
> **Source URL**: https://code.claude.com/docs/en/hooks
> **Last Updated**: 2026-02-19

## What Are Hooks?

Hooks are event-driven automations that execute shell commands at specific Claude Code lifecycle points. They enable deterministic behavior, validation, and workflow automation.

> "Encode rules as hooks rather than relying on LLM prompts to turn suggestions into app-level code that executes every time it is expected to run."

## Hook Types

Claude Code supports three types of hooks:

| Type | Description | Use Cases |
|------|-------------|-----------|
| `command` | Execute a shell command | Formatting, logging, validation, file operations |
| `prompt` | Send output to Claude for LLM-driven decisions | Context-aware validation, smart routing |
| `agent` | Invoke a subagent for multi-step analysis | Complex reviews, deep analysis, multi-file operations |

## Hook Event Types

Claude Code provides fourteen distinct hook events:

| Event | Timing | Can Block? | Decision Control | Use Cases |
|-------|--------|------------|------------------|-----------|
| `SessionStart` | Starting/resuming sessions | No | No | Initialization, setup, environment checks |
| `UserPromptSubmit` | When users submit prompts | No | **Yes** (modify/suppress) | Prompt modification, context injection |
| `PreToolUse` | Before tool calls | **Yes** | **Yes** (approve/block) | Validation, access control, blocking |
| `PermissionRequest` | When permission dialog would show | No | **Yes** (approve/deny) | Programmatic permission control |
| `PostToolUse` | After successful tool calls | No | No | Post-processing, logging, formatting |
| `PostToolUseFailure` | After failed tool calls | No | No | Error handling, retry logic, alerting |
| `Notification` | During notification delivery | No | No | Custom alerts, integrations |
| `SubagentStart` | When a subagent begins | No | No | Subagent tracking, setup |
| `SubagentStop` | Upon subagent completion | No | No | Result processing, coordination |
| `Stop` | When Claude finishes responding | No | No | Cleanup, state updates |
| `TeammateIdle` | When a teammate agent becomes idle | No | No | Team coordination, load balancing |
| `TaskCompleted` | When a task finishes | No | No | Progress tracking, notifications |
| `PreCompact` | Before compact operations | No | No | Data preservation, context saving |
| `SessionEnd` | Session termination | No | No | Cleanup, reporting |

## File Structure and Configuration

### Storage Locations

**User-level** (applies to all projects):
```
~/.claude/settings.json
```

**Project-level** (team-shared via git):
```
.claude/settings.json
```

### Configuration Format

```json
{
  "hooks": {
    "[EventName]": [
      {
        "matcher": "[Tool|Pattern]",
        "hooks": [
          {
            "type": "command",
            "command": "[shell_command]"
          }
        ]
      }
    ]
  }
}
```

**Note on Models**: Command hooks execute deterministic shell commands independently of Claude's language model. There is no model selection for command hooks. Prompt and agent hooks do use the LLM.

### Environment Variables

Hooks have access to these environment variables:

| Variable | Description |
|----------|-------------|
| `$CLAUDE_PROJECT_DIR` | The project root directory |
| `$CLAUDE_ENV_FILE` | Path to environment file for the session |

## Matcher Patterns

### Tool-Specific Matchers
```json
"matcher": "Edit"     // Matches Edit tool only
"matcher": "Write"    // Matches Write tool only
"matcher": "Bash"     // Matches Bash tool only
```

### Multiple Tools
```json
"matcher": "Edit|Write"  // Matches Edit OR Write
```

### Wildcard Matcher
```json
"matcher": "*"  // Matches ALL tools
```

### MCP Tool Matchers
```json
"matcher": "mcp__server-name__tool-name"  // Specific MCP tool
"matcher": "mcp__server-name__*"          // All tools from an MCP server
```

### Session Event Matchers
```json
"matcher": "startup"   // New session start only
"matcher": "resume"    // Resumed session only
"matcher": "clear"     // Context cleared
"matcher": "compact"   // Context compacted
```

## Hook Input Format

Hooks receive JSON input via stdin containing tool metadata:

```json
{
  "tool_name": "Bash",
  "tool_input": {
    "command": "npm test"
  },
  "file_path": "/path/to/file",
  "old_string": "...",
  "new_string": "..."
}
```

### Accessing Data with jq

```bash
# Extract command from Bash tool
jq -r '.tool_input.command'

# Extract file path from Edit tool
jq -r '.file_path'

# Extract new content from Write tool
jq -r '.tool_input.content'
```

## Hook Output Format

### Command Hooks

Command hooks can produce structured JSON output to control behavior:

**For PreToolUse** (decision control):
```json
{
  "decision": "block",
  "reason": "File is in a protected directory"
}
```

Decision values: `"approve"`, `"block"`, or omit for default behavior.

**For UserPromptSubmit** (prompt modification):
```json
{
  "hookSpecificOutput": {
    "suppressPrompt": false,
    "newPromptForModel": "Modified prompt text here"
  }
}
```

**For PermissionRequest** (permission control):
```json
{
  "hookSpecificOutput": {
    "decision": "approve"
  }
}
```

Decision values: `"approve"` or `"deny"`.

### Exit Codes (PreToolUse Command Hooks)

For simple command hooks without JSON output:
- `exit 0` = Allow operation
- `exit 2` = Block operation
- Other codes = Treated as success

### Async Hooks

Hooks can be run asynchronously by setting `async: true`:

```json
{
  "type": "command",
  "command": "long-running-script.sh",
  "async": true
}
```

Async hooks run in the background and do not block the agent loop. They cannot produce decision output.

## Common Use Cases and Examples

### 1. Command Logging (Compliance & Debugging)

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.command' | tee -a ~/.claude/command_log.txt"
          }
        ]
      }
    ]
  }
}
```

### 2. Code Formatting (Auto-Format After Edits)

**TypeScript/JavaScript**:
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); if [[ $FILE == *.ts ]] || [[ $FILE == *.tsx ]]; then prettier --write \"$FILE\"; fi"
          }
        ]
      }
    ]
  }
}
```

**Go**:
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); if [[ $FILE == *.go ]]; then gofmt -w \"$FILE\"; fi"
          }
        ]
      }
    ]
  }
}
```

### 3. Markdown Validation (Language Detection)

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); if [[ $FILE == *.md ]]; then python scripts/validate-markdown.py \"$FILE\"; fi"
          }
        ]
      }
    ]
  }
}
```

### 4. Access Control (Block Sensitive Files)

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); if [[ $FILE == *.env ]] || [[ $FILE == *package-lock.json ]] || [[ $FILE == .git/* ]]; then echo '{\"decision\":\"block\",\"reason\":\"Cannot modify sensitive files\"}'; exit 0; fi"
          }
        ]
      }
    ]
  }
}
```

**Note**: The preferred approach is to output JSON with `decision` field. The legacy `exit 2` approach still works for backward compatibility.

### 5. Notifications (System Alerts)

```json
{
  "hooks": {
    "Notification": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "MESSAGE=$(jq -r '.message'); notify-send 'Claude Code' \"$MESSAGE\""
          }
        ]
      }
    ]
  }
}
```

### 6. Git Integration (Auto-Stage Changes)

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); git add \"$FILE\" 2>/dev/null || true"
          }
        ]
      }
    ]
  }
}
```

### 7. Test Running (Auto-Test After Changes)

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); if [[ $FILE == src/**/*.ts ]]; then npm test -- \"${FILE/src/tests}\" || true; fi"
          }
        ]
      }
    ]
  }
}
```

### 8. Context Injection (UserPromptSubmit)

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "echo '{\"hookSpecificOutput\":{\"suppressPrompt\":false,\"newPromptForModel\":\"'\"$(cat <<EOF\n[Context: Current time is $(date '+%Y-%m-%d %H:%M'), Project: $CLAUDE_PROJECT_DIR]\nEOF\n)\"'}}'"
          }
        ]
      }
    ]
  }
}
```

### 9. Permission Auto-Approval

```json
{
  "hooks": {
    "PermissionRequest": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "CMD=$(jq -r '.tool_input.command'); if [[ $CMD == npm\\ test* ]] || [[ $CMD == npm\\ run\\ lint* ]]; then echo '{\"hookSpecificOutput\":{\"decision\":\"approve\"}}'; fi"
          }
        ]
      }
    ]
  }
}
```

### 10. Error Recovery (PostToolUseFailure)

```json
{
  "hooks": {
    "PostToolUseFailure": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.error // .tool_output' >> ~/.claude/error_log.txt"
          }
        ]
      }
    ]
  }
}
```

## Security Considerations

**CRITICAL SECURITY WARNING**

> "You must consider the security implication of hooks as you add them, because hooks run automatically during the agent loop with your current environment's credentials."

### Security Best Practices

1. **Review all hook implementations** before registration
2. **Recognize that malicious code can "exfiltrate your data"**
3. **Avoid hardcoding sensitive credentials** in hooks
4. **Limit hook permissions** to necessary operations
5. **Store sensitive hooks** in user settings rather than version control
6. **Validate input** before processing
7. **Use explicit path matching** to prevent unintended execution

### Safe Hook Pattern

```bash
#!/bin/bash
set -euo pipefail

# Validate input exists
if ! jq -e '.file_path' >/dev/null 2>&1; then
  exit 0
fi

# Get file path safely
FILE=$(jq -r '.file_path')

# Validate file extension
if [[ ! $FILE =~ \\.ts$ ]]; then
  exit 0
fi

# Validate file exists and is readable
if [[ ! -r "$FILE" ]]; then
  exit 0
fi

# Perform safe operation
prettier --write "$FILE"
```

## Hook Development Best Practices

### 1. Deterministic Behavior
Encode rules as hooks rather than relying on LLM prompts:

**Bad**: Tell Claude "always run prettier after editing TypeScript"
**Good**: Create PostToolUse hook that runs prettier automatically

### 2. Error Handling
Always handle errors gracefully:

```bash
# Allow operations to fail without breaking Claude
command_that_might_fail || true

# Redirect errors to stderr
dangerous_operation 2>/dev/null || echo "Warning: operation failed" >&2
```

### 3. Exit Codes (PreToolUse Only)
- `exit 0` = Allow operation (success) -- or use JSON output with `decision` field
- `exit 2` = Block operation (validation failed) -- legacy approach
- Other codes = Treated as success

### 4. Storage Location Selection

**Use User Settings** (`~/.claude/settings.json`) when:
- Hook applies to all projects
- Hook contains sensitive logic
- Experimental or personal workflow

**Use Project Settings** (`.claude/settings.json`) when:
- Team-shared workflow
- Project-specific conventions
- Safe for version control

### 5. Testing
- Test hooks manually before relying on them
- Verify stdin parsing with sample JSON
- Test both success and failure paths
- Ensure proper exit codes
- Test JSON output format for decision hooks

### 6. Use Once for Initialization
Use `once: true` for hooks that should only run once per session:

```json
{
  "type": "command",
  "command": "echo 'Session initialized'",
  "once": true
}
```

## Advanced Patterns

### Conditional Execution Based on Content

```bash
#!/bin/bash
FILE=$(jq -r '.file_path')
NEW_CONTENT=$(jq -r '.new_string')

# Only run if content contains "TODO"
if echo "$NEW_CONTENT" | grep -q "TODO"; then
  echo "Warning: TODO found in $FILE" >&2
fi
```

### Multi-Step Hook Chain

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); prettier --write \"$FILE\""
          },
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); eslint --fix \"$FILE\""
          },
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); git add \"$FILE\""
          }
        ]
      }
    ]
  }
}
```

### Prompt-Based Hook (LLM Decision)

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Review this file change. If the edit introduces security vulnerabilities, respond with {\"decision\": \"block\", \"reason\": \"description\"}. Otherwise respond with {\"decision\": \"approve\"}."
          }
        ]
      }
    ]
  }
}
```

### Agent Hook (Subagent Analysis)

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "agent",
            "prompt": "Analyze this bash command for security risks. Check for dangerous operations, data exfiltration attempts, or unintended side effects.",
            "agent": "security-reviewer"
          }
        ]
      }
    ]
  }
}
```

## Troubleshooting

### Hook Not Executing?
- Verify JSON syntax in settings.json
- Check event name spelling (case-sensitive)
- Ensure matcher pattern matches tool name
- Validate shell command works independently
- Check file permissions on scripts

### Hook Blocking Operations?
- Verify exit code (0 = allow, 2 = block in PreToolUse)
- Check JSON output for `decision` field
- Check stderr output for error messages
- Test hook command manually with sample JSON

### JSON Parsing Errors?
- Ensure jq is installed: `which jq`
- Test JSON structure: `echo '{}' | jq`
- Verify stdin is being received

## Quick Reference

### Minimal Hook (Logging)
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.command' >> ~/claude_commands.log"
          }
        ]
      }
    ]
  }
}
```

### Access Control Hook (Blocking)
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); [[ $FILE != *.env ]] || echo '{\"decision\":\"block\",\"reason\":\"Cannot edit .env files\"}'"
          }
        ]
      }
    ]
  }
}
```

### Auto-Format Hook (Post-Processing)
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); prettier --write \"$FILE\" 2>/dev/null || true"
          }
        ]
      }
    ]
  }
}
```

## Advanced Hook Patterns

For advanced hook development, see [hook-advanced.md](hook-advanced.md):

- **Prompt-Based Hooks**: LLM-driven decision making with context awareness
- **Agent Hooks**: Invoke subagents for complex multi-step analysis
- **PermissionRequest Event**: Programmatic control over permission dialogs
- **`once: true` Option**: Single-execution hooks for initialization
- **Async Hooks**: Background execution for non-blocking operations
- **Expanded Matchers**: startup, resume, clear, compact, MCP tools
- **Frontmatter Scoping**: Path-specific hook targeting
- **Advanced Patterns**: Multi-stage validation, hook chaining, caching strategies
