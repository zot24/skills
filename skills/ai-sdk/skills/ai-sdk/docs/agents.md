<!-- Source: https://ai-sdk.dev/docs/agents/overview + https://ai-sdk.dev/docs/agents/building-agents -->

# AI Agents

Agents are **large language models (LLMs)** that use **tools** in a **loop** to accomplish tasks. These components work together:

- **LLMs** process input and decide the next action
- **Tools** extend capabilities beyond text generation (reading files, calling APIs, writing to databases)
- **Loop** orchestrates execution through context management and stopping conditions

## ToolLoopAgent Class

The `ToolLoopAgent` class handles agent orchestration automatically:

```typescript
import { ToolLoopAgent, stepCountIs, tool } from 'ai';
import { z } from 'zod';

const weatherAgent = new ToolLoopAgent({
  model: 'anthropic/claude-sonnet-4.5',
  tools: {
    weather: tool({
      description: 'Get the weather in a location (in Fahrenheit)',
      inputSchema: z.object({
        location: z.string().describe('The location to get the weather for'),
      }),
      execute: async ({ location }) => ({
        location,
        temperature: 72 + Math.floor(Math.random() * 21) - 10,
      }),
    }),
    convertFahrenheitToCelsius: tool({
      description: 'Convert temperature from Fahrenheit to Celsius',
      inputSchema: z.object({
        temperature: z.number().describe('Temperature in Fahrenheit'),
      }),
      execute: async ({ temperature }) => {
        const celsius = Math.round((temperature - 32) * (5 / 9));
        return { celsius };
      },
    }),
  },
  // Agent's default behavior is to stop after a maximum of 20 steps
  // stopWhen: stepCountIs(20),
});

const result = await weatherAgent.generate({
  prompt: 'What is the weather in San Francisco in celsius?',
});

console.log(result.text);  // agent's final answer
console.log(result.steps); // steps taken by the agent
```

The agent automatically:
1. Calls the `weather` tool to get the temperature in Fahrenheit
2. Calls `convertFahrenheitToCelsius` to convert it
3. Generates a final text response with the result

## Why Use the ToolLoopAgent Class?

- **Reduces boilerplate** - Manages loops and message arrays
- **Improves reusability** - Define once, use throughout your application
- **Simplifies maintenance** - Single place to update agent configuration
- **Type safety** - Full TypeScript support for tools and outputs

For most use cases, start with ToolLoopAgent. Use core functions (`generateText`, `streamText`) when you need explicit control over each step.

## Creating an Agent

```typescript
import { ToolLoopAgent } from 'ai';

const myAgent = new ToolLoopAgent({
  model: 'anthropic/claude-sonnet-4.5',
  instructions: 'You are a helpful assistant.',
  tools: {
    // Your tools here
  },
});
```

## Configuration Options

### Loop Control

By default, agents run for 20 steps (`stopWhen: stepCountIs(20)`). Configure with `stopWhen`:

```typescript
import { ToolLoopAgent, stepCountIs } from 'ai';

const agent = new ToolLoopAgent({
  model: 'anthropic/claude-sonnet-4.5',
  stopWhen: stepCountIs(20), // Allow up to 20 steps
});
```

The loop continues until:
- A finish reason other than tool-calls is returned, or
- A tool that is invoked does not have an execute function, or
- A tool call needs approval, or
- A stop condition is met

You can combine multiple conditions:

```typescript
const agent = new ToolLoopAgent({
  model: 'anthropic/claude-sonnet-4.5',
  stopWhen: [
    stepCountIs(20),
    yourCustomCondition(),
  ],
});
```

### Tool Choice

Control how the agent uses tools:

```typescript
const agent = new ToolLoopAgent({
  model: 'anthropic/claude-sonnet-4.5',
  tools: { /* ... */ },
  toolChoice: 'required', // Force tool use
  // or toolChoice: 'none' to disable tools
  // or toolChoice: 'auto' (default) to let the model decide
  // or toolChoice: { type: 'tool', toolName: 'weather' } for a specific tool
});
```

### Structured Output

Define structured output schemas:

```typescript
import { ToolLoopAgent, Output, stepCountIs } from 'ai';
import { z } from 'zod';

const analysisAgent = new ToolLoopAgent({
  model: 'anthropic/claude-sonnet-4.5',
  output: Output.object({
    schema: z.object({
      sentiment: z.enum(['positive', 'neutral', 'negative']),
      summary: z.string(),
      keyPoints: z.array(z.string()),
    }),
  }),
  stopWhen: stepCountIs(10),
});

const { output } = await analysisAgent.generate({
  prompt: 'Analyze customer feedback from the last quarter',
});
```

## System Instructions

Define behavior, personality, and constraints:

```typescript
const codeReviewAgent = new ToolLoopAgent({
  model: 'anthropic/claude-sonnet-4.5',
  instructions: `You are a senior software engineer conducting code reviews.

  Your approach:
  - Focus on security vulnerabilities first
  - Identify performance bottlenecks
  - Suggest improvements for readability and maintainability
  - Be constructive and educational in your feedback
  - Always explain why something is an issue and how to fix it`,
});
```

## Using an Agent

### Generate Text

```typescript
const result = await myAgent.generate({
  prompt: 'What is the weather like?',
});
console.log(result.text);
```

### Stream Text

```typescript
const result = await myAgent.stream({
  prompt: 'Tell me a story',
});

for await (const chunk of result.textStream) {
  console.log(chunk);
}
```

### Respond to UI Messages

```typescript
// In your API route (e.g., app/api/chat/route.ts)
import { createAgentUIStreamResponse } from 'ai';

export async function POST(request: Request) {
  const { messages } = await request.json();

  return createAgentUIStreamResponse({
    agent: myAgent,
    uiMessages: messages,
  });
}
```

### Track Step Progress

```typescript
const result = await myAgent.generate({
  prompt: 'Research and summarize the latest AI trends',
  onStepFinish: async ({ usage, finishReason, toolCalls }) => {
    console.log('Step completed:', {
      inputTokens: usage.inputTokens,
      outputTokens: usage.outputTokens,
      finishReason,
      toolsUsed: toolCalls?.map(tc => tc.toolName),
    });
  },
});
```

## End-to-end Type Safety

Infer types for your agent's UIMessages:

```typescript
import { ToolLoopAgent, InferAgentUIMessage } from 'ai';

const myAgent = new ToolLoopAgent({ /* ... */ });

export type MyAgentUIMessage = InferAgentUIMessage<typeof myAgent>;
```

Use this type in client components with `useChat`:

```typescript
'use client';
import { useChat } from '@ai-sdk/react';
import type { MyAgentUIMessage } from '@/agent/my-agent';

export function Chat() {
  const { messages } = useChat<MyAgentUIMessage>();
  // Full type safety for messages and tools
}
```

## Structured Workflows

When you need reliable, repeatable outcomes with explicit control flow, use core functions with structured workflow patterns:

```typescript
import { generateText } from 'ai';

async function structuredWorkflow(input: string) {
  // Step 1: Analyze
  const analysis = await generateText({
    model: 'anthropic/claude-sonnet-4.5',
    prompt: `Analyze: ${input}`,
  });

  // Step 2: Process based on analysis
  if (analysis.text.includes('needs research')) {
    const research = await generateText({
      model: 'anthropic/claude-sonnet-4.5',
      tools: { search },
      stopWhen: stepCountIs(5),
      prompt: `Research: ${input}`,
    });
    return research;
  }

  return analysis;
}
```

## Next Steps

- **[Workflow Patterns](https://ai-sdk.dev/docs/agents/workflows)** - Structured patterns using core functions
- **[Loop Control](https://ai-sdk.dev/docs/agents/loop-control)** - Advanced execution control with stopWhen and prepareStep
- **[Configuring Call Options](https://ai-sdk.dev/docs/agents/configuring-call-options)** - Type-safe runtime configuration
- **[Memory](https://ai-sdk.dev/docs/agents/memory)** - Agent memory management
- **[Subagents](https://ai-sdk.dev/docs/agents/subagents)** - Delegate tasks to specialized subagents
