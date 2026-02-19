<!-- Source: https://ai-sdk.dev/docs/ai-sdk-core/tools-and-tool-calling -->

# Tool Calling

Tools are objects that can be called by the model to perform a specific task. AI SDK Core tools contain several core elements:

- **`description`** - An optional description of the tool that can influence when the tool is picked
- **`inputSchema`** - A Zod schema or JSON schema that defines the input parameters. The schema is consumed by the LLM, and also used to validate the LLM tool calls
- **`execute`** - An optional async function that is called with the inputs from the tool call. It is optional because you might want to forward tool calls to the client or to a queue instead of executing them in the same process
- **`strict`** - (optional, boolean) Enables strict tool calling when supported by the provider

You can use the `tool` helper function to infer the types of the `execute` parameters.

## Defining Tools

```typescript
import { z } from 'zod';
import { generateText, tool, stepCountIs } from 'ai';

const result = await generateText({
  model: 'anthropic/claude-sonnet-4.5',
  tools: {
    weather: tool({
      description: 'Get the weather in a location',
      inputSchema: z.object({
        location: z.string().describe('The location to get the weather for'),
      }),
      execute: async ({ location }) => ({
        location,
        temperature: 72 + Math.floor(Math.random() * 21) - 10,
      }),
    }),
  },
  stopWhen: stepCountIs(5),
  prompt: 'What is the weather in San Francisco?',
});
```

When a model uses a tool, it is called a "tool call" and the output of the tool is called a "tool result".

## Strict Mode

When enabled, language model providers that support strict tool calling will only generate tool calls that are valid according to your defined `inputSchema`. Enable it per-tool:

```typescript
tool({
  description: 'Get the weather in a location',
  inputSchema: z.object({ location: z.string() }),
  strict: true,
  execute: async ({ location }) => ({ /* ... */ }),
});
```

## Input Examples

You can specify example inputs to help guide the model on how input data should be structured:

```typescript
tool({
  description: 'Get the weather in a location',
  inputSchema: z.object({
    location: z.string().describe('The location to get the weather for'),
  }),
  inputExamples: [
    { input: { location: 'San Francisco' } },
    { input: { location: 'London' } },
  ],
  execute: async ({ location }) => { /* ... */ },
});
```

Only the Anthropic provider supports tool input examples natively. Other providers ignore the setting.

## Tool Execution Approval

Require approval before execution by setting `needsApproval`:

```typescript
const runCommand = tool({
  description: 'Run a shell command',
  inputSchema: z.object({
    command: z.string().describe('The shell command to execute'),
  }),
  needsApproval: true,
  execute: async ({ command }) => { /* ... */ },
});
```

### How It Works

When a tool requires approval, `generateText` and `streamText` complete and return `tool-approval-request` parts in the result content. The approval flow requires two calls:

1. Call `generateText` with a tool that has `needsApproval: true`
2. Model generates a tool call
3. `generateText` returns with `tool-approval-request` parts in `result.content`
4. Your app requests approval and collects the user's decision
5. Add a `tool-approval-response` to the messages array
6. Call `generateText` again with the updated messages
7. If approved, the tool runs. If denied, the model sees the denial and responds accordingly.

### Dynamic Approval

Make approval decisions based on tool input:

```typescript
const paymentTool = tool({
  description: 'Process a payment',
  inputSchema: z.object({
    amount: z.number(),
    recipient: z.string(),
  }),
  needsApproval: async ({ amount }) => amount > 1000,
  execute: async ({ amount, recipient }) => {
    return await processPayment(amount, recipient);
  },
});
```

## Multi-Step Calls (using stopWhen)

With the `stopWhen` setting, you can enable multi-step calls. When `stopWhen` is set and the model generates a tool call, the AI SDK will trigger a new generation passing in the tool result until there are no further tool calls or the stopping condition is met.

```typescript
import { z } from 'zod';
import { generateText, tool, stepCountIs } from 'ai';

const { text, steps } = await generateText({
  model: 'anthropic/claude-sonnet-4.5',
  tools: {
    weather: tool({
      description: 'Get the weather in a location',
      inputSchema: z.object({
        location: z.string().describe('The location to get the weather for'),
      }),
      execute: async ({ location }) => ({
        location,
        temperature: 72 + Math.floor(Math.random() * 21) - 10,
      }),
    }),
  },
  stopWhen: stepCountIs(5),
  prompt: 'What is the weather in San Francisco?',
});
```

### Steps

Access intermediate tool calls and results via the `steps` property:

```typescript
const { steps } = await generateText({
  model: 'anthropic/claude-sonnet-4.5',
  stopWhen: stepCountIs(10),
  // ...
});

// extract all tool calls from the steps:
const allToolCalls = steps.flatMap(step => step.toolCalls);
```

### onStepFinish Callback

Triggered when a step is finished with all text deltas, tool calls, and tool results available:

```typescript
const result = await generateText({
  // ...
  onStepFinish({ text, toolCalls, toolResults, finishReason, usage }) {
    // your own logic, e.g. for saving the chat history or recording usage
  },
});
```

### prepareStep Callback

Called before a step is started. Use it to provide different settings for each step:

```typescript
const result = await generateText({
  // ...
  prepareStep: async ({ model, stepNumber, steps, messages }) => {
    if (stepNumber === 0) {
      return {
        model: modelForThisParticularStep,
        toolChoice: { type: 'tool', toolName: 'tool1' },
        activeTools: ['tool1'],
      };
    }
    // when nothing is returned, the default settings are used
  },
});
```

## Tool Choice

Control when a tool is selected:

- `auto` (default): the model can choose whether and which tools to call
- `required`: the model must call a tool. It can choose which tool to call
- `none`: the model must not call tools
- `{ type: 'tool', toolName: string }`: the model must call the specified tool

```typescript
const result = await generateText({
  model: 'anthropic/claude-sonnet-4.5',
  tools: { weather: weatherTool },
  toolChoice: 'required',
  prompt: 'What is the weather in San Francisco?',
});
```

## Tool Execution Options

When tools are called, they receive additional options as a second parameter:

- **Tool Call ID** - The ID of the tool call, useful for streaming data
- **Messages** - The messages that were sent to the model
- **Abort Signals** - Forwarded from `generateText`/`streamText` for cancellation
- **Context (experimental)** - Arbitrary context passed via `experimental_context`

```typescript
tool({
  // ...
  execute: async ({ location }, { toolCallId, messages, abortSignal }) => {
    return fetch(`https://api.weather.com?q=${location}`, {
      signal: abortSignal,
    });
  },
});
```

## Tool Input Lifecycle Hooks

Available hooks for streaming contexts (`streamText`):

- **`onInputStart`** - Called when the model starts generating tool input
- **`onInputDelta`** - Called for each chunk of text as the input is streamed
- **`onInputAvailable`** - Called when the complete input is available and validated

## Dynamic Tools

For scenarios where tool schemas are not known at compile time (MCP tools, user-defined functions):

```typescript
import { dynamicTool } from 'ai';

const customTool = dynamicTool({
  description: 'Execute a custom function',
  inputSchema: z.object({}),
  execute: async input => {
    const { action, parameters } = input as any;
    return { result: `Executed ${action}` };
  },
});
```

## Response Messages

Add generated assistant and tool messages to your conversation history:

```typescript
import { generateText, ModelMessage } from 'ai';

const messages: ModelMessage[] = [/* ... */];

const { response } = await generateText({
  // ...
  messages,
});

// add the response messages to your conversation history:
messages.push(...response.messages);
```

## Active Tools

Limit available tools to the model while maintaining static typing:

```typescript
const { text } = await generateText({
  model: 'anthropic/claude-sonnet-4.5',
  tools: myToolSet,
  activeTools: ['firstTool'],
});
```

## Multi-modal Tool Results

Return images and other media back to models through `toModelOutput` conversion:

```typescript
tool({
  // ...
  execute: async ({ action }) => {
    return { type: 'image', data: screenshotBase64 };
  },
  toModelOutput({ output }) {
    return {
      type: 'content',
      value:
        typeof output === 'string'
          ? [{ type: 'text', text: output }]
          : [{ type: 'media', data: output.data, mediaType: 'image/png' }],
    };
  },
});
```

Multi-modal tool results are experimental and only supported by Anthropic and OpenAI.

## Types

Use `TypedToolCall` and `TypedToolResult` helpers for type-safe code:

```typescript
import { TypedToolCall, TypedToolResult, tool } from 'ai';

const myToolSet = {
  firstTool: tool({ /* ... */ }),
  secondTool: tool({ /* ... */ }),
};

type MyToolCall = TypedToolCall<typeof myToolSet>;
type MyToolResult = TypedToolResult<typeof myToolSet>;
```

## Tool Call Repair (experimental)

Use `experimental_repairToolCall` to fix invalid tool calls without extra conversation steps:

```typescript
const result = await generateText({
  model,
  tools,
  prompt,
  experimental_repairToolCall: async ({ toolCall, tools, inputSchema, error }) => {
    if (NoSuchToolError.isInstance(error)) {
      return null; // do not fix invalid tool names
    }
    const { object: repairedArgs } = await generateObject({
      model: 'anthropic/claude-sonnet-4.5',
      schema: tools[toolCall.toolName].inputSchema,
      prompt: `Fix the inputs for tool "${toolCall.toolName}": ${JSON.stringify(toolCall.input)}`,
    });
    return { ...toolCall, input: JSON.stringify(repairedArgs) };
  },
});
```

## MCP Tools

The AI SDK supports connecting to Model Context Protocol (MCP) servers. MCP tools are best suited for rapid development iteration. For production applications, prefer defining native AI SDK tools for full control, type safety, and optimal performance.

## Extracting Tools

Extract tools into separate files using the `tool` helper for correct type inference:

```typescript
// tools/weather-tool.ts
import { tool } from 'ai';
import { z } from 'zod';

export const weatherTool = tool({
  description: 'Get the weather in a location',
  inputSchema: z.object({
    location: z.string().describe('The location to get the weather for'),
  }),
  execute: async ({ location }) => ({
    location,
    temperature: 72 + Math.floor(Math.random() * 21) - 10,
  }),
});
```
