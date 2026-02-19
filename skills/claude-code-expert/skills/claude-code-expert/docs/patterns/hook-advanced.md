# Advanced Hook Patterns

> **Source**: Official Claude Code Documentation + Community Best Practices
> **Source URLs**:
> - https://code.claude.com/docs/en/hooks
> - https://gist.github.com/alexfazio/653c5164d726987569ee8229a19f451f
> **Last Updated**: 2026-02-19

This document covers advanced hook patterns including prompt-based hooks, agent hooks, async hooks, and sophisticated automation workflows. For basic hook concepts, see [hook-creation.md](hook-creation.md).

## Hook Types Overview

Claude Code supports three hook types:

| Type | Decision Maker | Best For | Performance |
|------|---------------|----------|-------------|
| **Command** | Shell script | Deterministic checks, formatting | Fast (~10ms) |
| **Prompt** | LLM reasoning | Context-aware decisions, complex validation | Slower (~1-5s) |
| **Agent** | Subagent | Multi-step workflows, sophisticated analysis | Slowest (~5-30s) |

### When to Use Each Type

**Command Hooks** (Covered in [hook-creation.md](hook-creation.md)):
- File formatting (prettier, gofmt)
- Simple pattern blocking (*.env files)
- Logging and auditing
- Git operations

**Prompt Hooks** (This document):
- Security analysis requiring context
- Code quality decisions
- Complex validation logic
- Natural language processing

**Agent Hooks** (This document):
- Multi-file analysis
- Architectural validation
- Complex refactoring checks
- Integration testing triggers

## Prompt-Based Hooks

Prompt hooks use LLM reasoning for decisions that require understanding context rather than simple pattern matching.

### Configuration Format

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Evaluate if this edit is safe and follows project conventions. Respond with JSON: {\"decision\": \"approve\"} or {\"decision\": \"block\", \"reason\": \"explanation\"}.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

### Prompt Hook Fields

| Field | Required | Default | Description |
|-------|----------|---------|-------------|
| `type` | Yes | - | Must be `"prompt"` |
| `prompt` | Yes | - | Instructions for the LLM to evaluate. Use `$ARGUMENTS` to access the hook input data. |
| `timeout` | No | 60 | Max seconds before timeout |

### Variable Access in Prompt Hooks

Prompt hooks receive the full hook input context automatically. The `$ARGUMENTS` variable contains the serialized hook input. The LLM can reason about the tool name, input parameters, file paths, and other context provided in the hook input JSON.

### Prompt Hook Response Format

For `PreToolUse` hooks that need to make decisions, the prompt should instruct the LLM to respond with JSON:

```json
{"decision": "approve"}
```

or:

```json
{"decision": "block", "reason": "Explanation of why this was blocked"}
```

The `reason` is shown to Claude for context when an operation is blocked.

### Example: Security-Aware Edit Validation

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "prompt",
            "prompt": "You are a security reviewer. Analyze this file edit for:\n1. Hardcoded secrets (API keys, passwords, tokens)\n2. SQL injection vulnerabilities\n3. Command injection risks\n4. Unsafe file path handling\n\nRespond with JSON: {\"decision\": \"approve\"} or {\"decision\": \"block\", \"reason\": \"description\"}",
            "timeout": 15
          }
        ]
      }
    ]
  }
}
```

### Example: Code Quality Gate

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Review this code change for quality:\n- Does it follow DRY principles?\n- Are there obvious bugs?\n- Is error handling appropriate?\n\nRespond with JSON: {\"decision\": \"approve\"} or {\"decision\": \"block\", \"reason\": \"specific issue\"}",
            "timeout": 20
          }
        ]
      }
    ]
  }
}
```

## Agent Hooks

Agent hooks invoke subagents for complex multi-step analysis.

### Configuration Format

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "agent",
            "prompt": "Review the changes made to this file for code quality and security issues.",
            "timeout": 60
          }
        ]
      }
    ]
  }
}
```

### Agent Hook Fields

| Field | Required | Default | Description |
|-------|----------|---------|-------------|
| `type` | Yes | - | Must be `"agent"` |
| `prompt` | Yes | - | Instructions for the agent describing what to analyze |
| `timeout` | No | 120 | Max seconds for agent execution |

The agent receives the hook input context along with the prompt instructions. For PreToolUse, the agent can return a decision in the same JSON format as prompt hooks.

### Example: Architectural Validation

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write",
        "hooks": [
          {
            "type": "agent",
            "prompt": "Validate that this new file follows our architectural patterns. Check import boundaries, folder structure, and naming conventions. Respond with JSON: {\"decision\": \"approve\"} or {\"decision\": \"block\", \"reason\": \"explanation\"}.",
            "timeout": 45
          }
        ]
      }
    ]
  }
}
```

### Example: Test Coverage Check

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "agent",
            "prompt": "Analyze if this file has adequate test coverage after this change. Suggest any missing test cases.",
            "timeout": 60
          }
        ]
      }
    ]
  }
}
```

## Async Hooks

Hooks can run asynchronously to avoid blocking the agent loop:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); eslint \"$FILE\" >> /tmp/claude_lint_results.txt 2>&1",
            "async": true
          }
        ]
      }
    ]
  }
}
```

### Async Hook Behavior

- Runs in the background without blocking Claude's agent loop
- Cannot produce decision output (approve/block)
- Useful for logging, analytics, background linting, notifications
- Results can be written to files for later consumption

### When to Use Async

| Use Case | Sync | Async |
|----------|------|-------|
| File formatting | Yes | No (needs to complete before next tool) |
| Access control blocking | Yes | No (needs decision) |
| Command logging | No | Yes (non-blocking) |
| Analytics/metrics | No | Yes (non-blocking) |
| Background linting | No | Yes (results consumed later) |
| Notifications | No | Yes (fire and forget) |

## PermissionRequest Event

The `PermissionRequest` event fires when Claude requests permission for a tool, allowing programmatic control over permission dialogs.

### Configuration

```json
{
  "hooks": {
    "PermissionRequest": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "CMD=$(jq -r '.tool_input.command'); if [[ $CMD == npm\\ test* ]]; then echo '{\"hookSpecificOutput\":{\"decision\":\"approve\"}}'; else echo '{}'; fi"
          }
        ]
      }
    ]
  }
}
```

### Response Format

The PermissionRequest hook uses `hookSpecificOutput` for decisions:

```json
{
  "hookSpecificOutput": {
    "decision": "approve"
  }
}
```

| Decision | Effect |
|----------|--------|
| `"approve"` | Automatically grant permission |
| `"deny"` | Automatically deny permission |
| (omitted) | Show normal permission dialog |

### Example: Auto-Allow Safe Commands

```json
{
  "hooks": {
    "PermissionRequest": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "CMD=$(jq -r '.tool_input.command'); if [[ $CMD == npm\\ test* ]] || [[ $CMD == npm\\ run\\ lint* ]] || [[ $CMD == git\\ status* ]] || [[ $CMD == git\\ log* ]]; then echo '{\"hookSpecificOutput\":{\"decision\":\"approve\"}}'; fi"
          }
        ]
      }
    ]
  }
}
```

### Example: Deny Dangerous Operations

```json
{
  "hooks": {
    "PermissionRequest": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "CMD=$(jq -r '.tool_input.command'); if [[ $CMD == *rm\\ -rf* ]] || [[ $CMD == *--force* ]] || [[ $CMD == *sudo* ]]; then echo '{\"hookSpecificOutput\":{\"decision\":\"deny\"}}'; fi"
          }
        ]
      }
    ]
  }
}
```

## The `once: true` Option

Run a hook only once per session, useful for initialization or one-time checks.

### Configuration

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Session initialized at $(date)'",
            "once": true
          }
        ]
      }
    ]
  }
}
```

### Use Cases

- **Session initialization**: Set up environment once
- **Dependency checks**: Verify tools are installed once
- **Welcome messages**: Show context once per session
- **License validation**: Check once at start

### Example: One-Time Environment Check

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "which jq prettier eslint || echo 'WARNING: Missing required tools'",
            "once": true
          }
        ]
      }
    ]
  }
}
```

## Expanded Matchers

Beyond tool names, Claude Code supports session lifecycle matchers and MCP tool matchers:

### Session Lifecycle Matchers

| Matcher | Event | Description |
|---------|-------|-------------|
| `startup` | SessionStart | Fresh session start |
| `resume` | SessionStart | Resuming existing session |
| `clear` | SessionEnd | Session cleared by user |
| `compact` | PreCompact | Before context compaction |

### MCP Tool Matchers

```json
"matcher": "mcp__server-name__tool-name"    // Specific MCP tool
"matcher": "mcp__server-name__*"            // All tools from an MCP server
```

### Example: Different Behavior for New vs Resumed Sessions

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup",
        "hooks": [
          {
            "type": "command",
            "command": "cat .claude/welcome.md"
          }
        ]
      },
      {
        "matcher": "resume",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Welcome back! Last session: '$(cat ~/.claude/last_session.txt)"
          }
        ]
      }
    ]
  }
}
```

### Example: Hook for Specific MCP Server Tools

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "mcp__database-server__*",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Database operation detected' >> ~/.claude/db_audit.log"
          }
        ]
      }
    ]
  }
}
```

## Frontmatter Scoping

Scope hooks to specific paths using YAML frontmatter in hook files.

### File-Based Hook with Frontmatter

Create `.claude/hooks/pre-edit-validate.md`:

```markdown
---
event: PreToolUse
matcher: Edit|Write
paths:
  - src/api/**/*.ts
  - src/lib/**/*.ts
exclude:
  - "**/*.test.ts"
  - "**/*.spec.ts"
---

# API Code Validation Hook

Validate all edits to API code follow security best practices:

1. Check for proper input validation
2. Ensure error handling is present
3. Verify authentication checks exist
4. Confirm no hardcoded secrets
```

### Frontmatter Fields

| Field | Type | Description |
|-------|------|-------------|
| `event` | string | Hook event (PreToolUse, PostToolUse, etc.) |
| `matcher` | string | Tool matcher pattern |
| `paths` | string[] | Glob patterns to include |
| `exclude` | string[] | Glob patterns to exclude |
| `priority` | number | Execution order (higher = earlier) |
| `enabled` | boolean | Enable/disable hook |

## Advanced Patterns

### Multi-Stage Validation

Chain multiple validation steps with escalating cost:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); [[ $FILE != *.env* ]] || echo '{\"decision\":\"block\",\"reason\":\"Cannot edit .env files\"}'"
          },
          {
            "type": "prompt",
            "prompt": "Quick security check: any obvious vulnerabilities in this edit? Respond with JSON: {\"decision\": \"approve\"} or {\"decision\": \"block\", \"reason\": \"issue\"}.",
            "timeout": 10
          },
          {
            "type": "agent",
            "prompt": "Comprehensive security analysis of these changes. Check for OWASP Top 10 vulnerabilities.",
            "timeout": 60
          }
        ]
      }
    ]
  }
}
```

### Hook Chaining via State

Share state between hooks using a state file:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); echo \"$FILE\" >> /tmp/claude_edited_files.txt"
          }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "if [ -f /tmp/claude_edited_files.txt ]; then echo 'Files edited this turn:'; cat /tmp/claude_edited_files.txt; rm /tmp/claude_edited_files.txt; fi"
          }
        ]
      }
    ]
  }
}
```

### Dynamic Configuration

Load hook behavior from external config:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "CMD=$(jq -r '.tool_input.command'); BLOCKED=$(cat .claude/blocked-commands.txt 2>/dev/null || echo ''); if echo \"$BLOCKED\" | grep -q \"$CMD\"; then echo '{\"decision\":\"block\",\"reason\":\"Command is in blocklist\"}'; fi"
          }
        ]
      }
    ]
  }
}
```

### Cross-Event Workflows

Coordinate behavior across events:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "echo $(date +%s) > /tmp/claude_session_start",
            "once": true
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "COUNT=$(cat /tmp/claude_edit_count 2>/dev/null || echo 0); echo $((COUNT + 1)) > /tmp/claude_edit_count"
          }
        ]
      }
    ],
    "SessionEnd": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "START=$(cat /tmp/claude_session_start); EDITS=$(cat /tmp/claude_edit_count 2>/dev/null || echo 0); DURATION=$(($(date +%s) - START)); echo \"Session summary: $EDITS edits in ${DURATION}s\" >> ~/.claude/session_log.txt"
          }
        ]
      }
    ]
  }
}
```

### Caching Strategies

Cache expensive operations:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); HASH=$(md5 -q \"$FILE\" 2>/dev/null || echo 'new'); CACHE=\"/tmp/claude_lint_cache_$HASH\"; if [ -f \"$CACHE\" ]; then cat \"$CACHE\"; else eslint \"$FILE\" --format json 2>/dev/null | tee \"$CACHE\"; fi"
          }
        ]
      }
    ]
  }
}
```

## Security Best Practices

### Input Validation

Always validate hook inputs:

```bash
#!/bin/bash
set -euo pipefail

# Validate JSON input
if ! jq -e '.' >/dev/null 2>&1; then
  echo "Invalid JSON input" >&2
  exit 0  # Allow operation on validation failure
fi

# Safely extract values
FILE_PATH=$(jq -r '.file_path // empty')
if [[ -z "$FILE_PATH" ]]; then
  exit 0  # No file path, allow
fi

# Validate path is within project
REAL_PATH=$(realpath "$FILE_PATH" 2>/dev/null || echo "")
PROJECT_ROOT="${CLAUDE_PROJECT_DIR:-$(pwd)}"
if [[ ! "$REAL_PATH" == "$PROJECT_ROOT"* ]]; then
  echo '{"decision":"block","reason":"File outside project"}'
  exit 0
fi
```

### Credential Safety

Never expose credentials in hooks:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "CMD=$(jq -r '.tool_input.command'); if echo \"$CMD\" | grep -qE '(API_KEY|SECRET|PASSWORD|TOKEN)='; then echo '{\"decision\":\"block\",\"reason\":\"Command may expose secrets\"}'; fi"
          }
        ]
      }
    ]
  }
}
```

### Timeout Management

Set appropriate timeouts:

| Hook Type | Recommended Timeout |
|-----------|-------------------|
| Command (simple) | 5-10s |
| Command (complex) | 15-30s |
| Prompt | 10-30s |
| Agent | 60-120s |

### Error Handling

Handle errors gracefully:

```bash
#!/bin/bash
# Fail open on errors (don't block user on hook failure)
trap 'exit 0' ERR

# Your validation logic here
# ...

# Only block for explicit violations
if [[ "$SHOULD_BLOCK" == "true" ]]; then
  echo "{\"decision\":\"block\",\"reason\":\"$REASON\"}"
fi
```

## Performance Optimization

### Fast Path for Common Cases

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); [[ $FILE == *.test.* ]] && exit 0; [[ $FILE == *.spec.* ]] && exit 0"
          },
          {
            "type": "prompt",
            "prompt": "Validate non-test file edit. Respond with JSON: {\"decision\": \"approve\"} or {\"decision\": \"block\", \"reason\": \"issue\"}.",
            "timeout": 15
          }
        ]
      }
    ]
  }
}
```

### Conditional Expensive Checks

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "FILE=$(jq -r '.file_path'); if [[ $FILE == src/security/* ]] || [[ $FILE == src/auth/* ]]; then echo 'SECURITY_FILE=true' > /tmp/claude_hook_flags; fi"
          },
          {
            "type": "prompt",
            "prompt": "Security-critical file detected. Perform thorough review of this change. Respond with JSON: {\"decision\": \"approve\"} or {\"decision\": \"block\", \"reason\": \"issue\"}.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

## Troubleshooting

### Hook Not Firing?

1. Check event name spelling (case-sensitive)
2. Verify matcher pattern matches tool name
3. Check hook file location and permissions
4. Run `claude --debug` to see hook loading

### Prompt Hook Timing Out?

1. Reduce prompt complexity
2. Increase timeout value
3. Add fast-path command hook first to skip unnecessary checks

### Agent Hook Failing?

1. Verify the prompt is clear and actionable
2. Increase timeout for complex analysis
3. Review agent output for errors

### State Not Persisting?

1. Use absolute paths for state files
2. Ensure directory exists and is writable
3. Clean up state files in SessionEnd
4. Check for race conditions with multiple hooks

## Quick Reference

### Minimal Prompt Hook
```json
{"type": "prompt", "prompt": "Check this change. Respond with JSON: {\"decision\": \"approve\"} or {\"decision\": \"block\", \"reason\": \"issue\"}."}
```

### Minimal Agent Hook
```json
{"type": "agent", "prompt": "Validate this file change for security and quality issues."}
```

### Minimal Once Hook
```json
{"type": "command", "command": "echo 'Init'", "once": true}
```

### Minimal Async Hook
```json
{"type": "command", "command": "log-operation.sh", "async": true}
```

### Permission Auto-Approval
```json
{
  "hooks": {
    "PermissionRequest": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "CMD=$(jq -r '.tool_input.command'); if [[ $CMD == npm\\ test* ]]; then echo '{\"hookSpecificOutput\":{\"decision\":\"approve\"}}'; fi"
          }
        ]
      }
    ]
  }
}
```
