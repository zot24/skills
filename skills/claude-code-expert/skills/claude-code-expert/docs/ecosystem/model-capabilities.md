# Model Capabilities Reference

> **Source**: Official Claude Code Documentation & Anthropic
> **Source URL**: https://code.claude.com/docs/en/overview
> **Last Updated**: 2026-02-19

## Overview

Claude Code supports multiple Claude models, each with distinct capabilities and performance characteristics. This guide helps you understand which model to use for different scenarios.

## Core Model Comparison

| Capability | Opus 4.6 | Sonnet 4.5 | Haiku 4.5 |
|-----------|----------|-----------|-----------|
| **Speed** | Slower | Fast | Fastest |
| **Cost** | Highest | Medium | Lowest |
| **Reasoning** | Superior | Excellent | Good |
| **Coding** | Excellent | Excellent | Good |
| **Context Window** | 200K | 200K | 200K |
| **Multimodal** | Yes (Images) | Yes (Images) | Yes (Images) |
| **Extended Thinking** | Yes | Yes | Yes |

## Model-Specific Capabilities

### Claude Opus 4.6

**Model ID**: `claude-opus-4-6`
**Alias**: `opus`

**Strengths**:
- **Maximum capability**: Best for complex, nuanced tasks
- **Deep reasoning**: Superior analysis and planning
- **Complex code**: Handles intricate architectural decisions
- **Accuracy**: Highest correctness on difficult problems
- **Comprehensive**: Thorough and detailed responses
- **Novel problem-solving**: Best at tackling unfamiliar challenges

**Optimal Use Cases**:
- Critical security audits
- Complex system architecture design
- Research and advanced analysis
- High-stakes decisions
- Novel problem-solving
- Advanced algorithm design
- Compliance and regulatory review
- Mission-critical systems
- Agent orchestration for complex workflows

**Performance Characteristics**:
- Response time: ~5-10 seconds for typical requests
- Context utilization: Most thorough analysis
- Tool calling: Highly accurate, more deliberate

**Trade-offs**:
- Higher latency than Sonnet
- Higher cost per request
- May provide more detail than needed for simple tasks

### Claude Sonnet 4.5

**Model ID**: `claude-sonnet-4-5-20250514`
**Alias**: `sonnet`

**Strengths**:
- **Balanced performance**: Optimal speed-to-capability ratio
- **Code generation**: Excellent at writing and understanding code
- **Tool use**: Highly effective with Read, Write, Edit, Grep, Glob, Bash
- **Reasoning**: Strong analytical and problem-solving abilities
- **Context retention**: Excellent memory across long conversations
- **Default recommendation**: Best choice for most development tasks

**Optimal Use Cases**:
- General software development
- Code reviews and refactoring
- API integration and testing
- Database query optimization
- Documentation generation
- Multi-file edits
- Agent orchestration
- Production deployments

**Performance Characteristics**:
- Response time: ~2-5 seconds for typical requests
- Context utilization: Efficient with large codebases
- Tool calling: Fast and accurate

### Claude Haiku 4.5

**Model ID**: `claude-haiku-4-5-20250514`
**Alias**: `haiku`

**Strengths**:
- **Speed**: Fastest response times
- **Efficiency**: Lowest cost per request
- **Straightforward tasks**: Excellent for well-defined operations
- **High throughput**: Ideal for batch operations
- **Quick iterations**: Rapid feedback cycles

**Optimal Use Cases**:
- Simple code edits
- Format conversions
- Repetitive refactors
- Straightforward bug fixes
- Quick questions
- Batch file processing
- Cost-sensitive applications
- Development iteration
- Codebase exploration (built-in Explore agent uses Haiku)

**Performance Characteristics**:
- Response time: ~1-2 seconds for typical requests
- Context utilization: Efficient for focused tasks
- Tool calling: Fast and effective for simple operations

**Trade-offs**:
- Less capable on complex reasoning
- May need more explicit instructions
- Better for well-defined tasks

## Capability Categories

### Code Understanding

- **Opus 4.6**: Superior deep code analysis; best for understanding intricate systems; exceptional at finding subtle issues
- **Sonnet 4.5**: Excellent comprehension of complex codebases; strong pattern recognition; good architectural understanding
- **Haiku 4.5**: Good for standard code patterns; effective for straightforward analysis; best with clear, well-structured code

### Code Generation

- **Opus 4.6**: Highest quality output; best architectural decisions; most robust error handling
- **Sonnet 4.5**: Excellent code quality; good design patterns; efficient implementations
- **Haiku 4.5**: Good code for simple tasks; fast generation; may need more guidance for complex tasks

### Debugging

- **Opus 4.6**: Superior at complex bugs; best for subtle issues; most thorough analysis
- **Sonnet 4.5**: Excellent root cause analysis; effective error diagnosis; good fix suggestions
- **Haiku 4.5**: Good for straightforward bugs; quick identification; effective for common patterns

### Refactoring

- **Opus 4.6**: Best for major refactors; superior architectural improvements; most comprehensive approaches
- **Sonnet 4.5**: Excellent refactoring suggestions; good balance of quality and speed; effective for most scenarios
- **Haiku 4.5**: Good for simple refactors; fast execution; effective for targeted changes

### Testing

- **Opus 4.6**: Most comprehensive test suites; best edge case identification; superior test architecture
- **Sonnet 4.5**: Excellent test generation; good edge case coverage; effective test strategies
- **Haiku 4.5**: Good for standard tests; fast test generation; effective for happy paths

## Tool Usage Capabilities

### Read Tool Proficiency

**All Models**: Excellent
- All models effectively read and comprehend files
- Opus 4.6 and Sonnet 4.5 better at synthesizing across many files
- Haiku 4.5 efficient for focused file reads

### Edit Tool Proficiency

**All Models**: Excellent
- All models make precise edits
- Sonnet 4.5 best balance for most edits
- Opus 4.6 best for critical changes
- Haiku 4.5 fastest for simple replacements

### Grep/Glob Tool Proficiency

**All Models**: Excellent
- All models construct effective search patterns
- Opus 4.6 and Sonnet 4.5 better at complex regex
- Haiku 4.5 effective for straightforward searches

### Bash Tool Proficiency

- **Opus 4.6**: Most robust command construction; best error prevention; superior safety considerations
- **Sonnet 4.5**: Strong command construction; good error handling; effective chaining
- **Haiku 4.5**: Effective for standard commands; may need more explicit guidance; good for well-known patterns

## MCP Integration Capabilities

**All Models**: Full MCP support
- All models can use MCP servers effectively
- Opus 4.6 may provide more thorough integrations
- Haiku 4.5 fastest for simple MCP operations
- Sonnet 4.5 best balance for most MCP workflows

## Extended Thinking

**All Models Support Extended Thinking**:
- Activated with Tab key or "thinking keywords"
- Enables deeper analysis before responding
- Particularly valuable for:
  - Complex architectural decisions
  - Intricate debugging
  - Novel problem-solving
  - Planning multi-step implementations

**Model Behavior with Extended Thinking**:
- **Opus 4.6**: Most comprehensive thinking, deepest analysis
- **Sonnet 4.5**: Thorough thinking, excellent balance
- **Haiku 4.5**: Focused thinking, efficient analysis

## Multimodal Capabilities

**All Models**: Image understanding
- Screenshots for UI/UX feedback
- Diagrams for architectural discussions
- Error screenshots for debugging
- Mockups for design implementation
- Charts and graphs for data analysis

**Best Practices**:
- Use Opus 4.6 or Sonnet 4.5 for complex visual analysis
- Haiku 4.5 effective for straightforward image tasks

## Context Management

**All Models**: 200K token context window

**Context Utilization**:
- **Opus 4.6**: Most thorough use of available context
- **Sonnet 4.5**: Efficient context utilization
- **Haiku 4.5**: Focused context use

**Best Practices**:
- All models benefit from progressive information disclosure
- Use @ references for quick file inclusion
- Leverage Read tool for selective file access
- Employ subagents for context isolation

## Agent and Skill Support

**All Models**: Full agent and skill support

**Agent Performance**:
- **Opus 4.6**: Best for complex agent workflows and orchestration
- **Sonnet 4.5**: Optimal for most agent scenarios
- **Haiku 4.5**: Effective for simple agent tasks and exploration

**Built-in Agent Assignments**:
- **Explore agent**: Uses Haiku (fast, read-only exploration)
- **Plan agent**: Inherits parent model
- **general-purpose agent**: Inherits parent model

**Skill Execution**:
- All models auto-invoke skills based on descriptions
- Opus 4.6 and Sonnet 4.5 better at nuanced skill selection
- Haiku 4.5 effective for clearly defined skill triggers

## Model Selection Decision Tree

```
Task Complexity?
+-- Simple, well-defined
|   +-- Speed critical? -> Haiku 4.5
|      Cost critical? -> Haiku 4.5
|      Otherwise -> Sonnet 4.5
|
+-- Medium complexity
|   +-- Always -> Sonnet 4.5
|
+-- High complexity
    +-- Critical accuracy? -> Opus 4.6
    +-- Novel problem? -> Opus 4.6
    +-- High stakes? -> Opus 4.6
    +-- Otherwise -> Sonnet 4.5 with Extended Thinking
```

## Cost Optimization Strategies

### Use Haiku 4.5 For:
- Formatting and linting
- Simple refactors
- Straightforward questions
- Batch operations
- Development iterations
- Codebase exploration

### Use Sonnet 4.5 For:
- Most development tasks
- Code reviews
- Feature implementation
- Bug fixing
- General agent workflows

### Use Opus 4.6 For:
- Security audits
- Critical decisions
- Complex architecture
- High-stakes situations
- When accuracy is paramount

## Performance Optimization

### Maximize Speed
1. Use Haiku 4.5 for simple tasks
2. Use clear, specific prompts
3. Limit file inclusions
4. Use parallel tool calls

### Maximize Quality
1. Use Opus 4.6 for critical tasks
2. Enable Extended Thinking
3. Provide comprehensive context
4. Use iterative refinement

### Balance Both
1. Use Sonnet 4.5 as default
2. Reserve Opus 4.6 for complex decisions
3. Use Haiku 4.5 for quick iterations
4. Match model to task complexity

## Model Configuration

### In Agents
```yaml
---
model: sonnet  # or opus, haiku
---
```

### In Skills
```yaml
---
model: haiku  # for frequent, simple operations
---
```

### In Commands (Legacy)
```yaml
---
model: opus  # for critical operations
---
```

### Inheritance
Omit model field to use parent conversation's model.

## Best Practices Summary

1. **Default to Sonnet 4.5**: Best balance for most scenarios
2. **Use Haiku 4.5 for speed**: Simple, repetitive, or high-volume tasks
3. **Use Opus 4.6 for quality**: Critical, complex, or high-stakes work
4. **Match model to task**: Consider complexity, stakes, and budget
5. **Enable Extended Thinking**: For complex reasoning regardless of model
6. **Test different models**: Performance varies by specific use case
7. **Monitor costs**: Track usage and optimize model selection

## Limitations and Considerations

### All Models
- Cannot browse internet (use MCP for external data)
- Cannot modify files outside Claude Code permissions
- Subject to rate limits based on usage tier

### Model-Specific
- **Opus 4.6**: Higher latency and cost
- **Haiku 4.5**: Less capable on highly complex tasks
- **Sonnet 4.5**: May occasionally need Opus for maximum accuracy

---

**For latest capabilities**: https://code.claude.com/docs
**For model updates**: https://www.anthropic.com/engineering
