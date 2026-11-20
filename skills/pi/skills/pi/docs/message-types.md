> Source: https://pi.dev/docs/latest/message-types



# Message Types


Pi uses `AgentMessage` values in SDK state, lifecycle events, RPC responses, and persisted session message entries. This page defines those shared messages and their content blocks.

Message timestamps are Unix timestamps in milliseconds. They are different from the ISO 8601 timestamps on <a href="/latest/session-format#entry-base" class="link-module_root__svb26">session entries</a>.

Source definitions:

- <a href="https://github.com/earendil-works/pi/blob/main/packages/ai/src/types.ts" class="link-module_root__svb26"><code class="inline-code-module_root__fGvLx" data-variant="soft">packages/ai/src/types.ts</code></a> defines provider-facing messages and content blocks.
- <a href="https://github.com/earendil-works/pi/blob/main/packages/agent/src/types.ts" class="link-module_root__svb26"><code class="inline-code-module_root__fGvLx" data-variant="soft">packages/agent/src/types.ts</code></a> defines the extensible `AgentMessage` union.
- <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/core/messages.ts" class="link-module_root__svb26"><code class="inline-code-module_root__fGvLx" data-variant="soft">packages/coding-agent/src/core/messages.ts</code></a> adds coding-agent message roles.


## Content blocks


### TextContent


``` code-snippet-module_root__tK5do
interface TextContent {
  type: "text";
  text: string;
  textSignature?: string;
}
```

`textSignature` contains provider-specific message metadata. Treat it as opaque.


### ImageContent


``` code-snippet-module_root__tK5do
interface ImageContent {
  type: "image";
  data: string;
  mimeType: string;
}
```

`data` is base64-encoded image data. `mimeType` identifies its media type, such as `image/png` or `image/jpeg`.


### ThinkingContent


``` code-snippet-module_root__tK5do
interface ThinkingContent {
  type: "thinking";
  thinking: string;
  thinkingSignature?: string;
  redacted?: boolean;
}
```

Thinking signatures contain provider-specific replay data. Treat them as opaque. A redacted block can have no visible thinking text while retaining an encrypted payload in `thinkingSignature`.


### ToolCall


``` code-snippet-module_root__tK5do
interface ToolCall {
  type: "toolCall";
  id: string;
  name: string;
  arguments: Record<string, any>;
  thoughtSignature?: string;
  namespace?: string;
}
```

`thoughtSignature` is provider-specific. `namespace` identifies an OpenAI Responses namespace for dynamically loaded or namespaced tools.


## Usage


Assistant messages always contain usage. Tool results can contain usage when the tool performed nested model work.

``` code-snippet-module_root__tK5do
interface Usage {
  input: number;
  output: number;
  cacheRead: number;
  cacheWrite: number;
  cacheWrite1h?: number;
  reasoning?: number;
  totalTokens: number;
  cost: {
    input: number;
    output: number;
    cacheRead: number;
    cacheWrite: number;
    total: number;
  };
}
```

When present, `reasoning` is already included in `output`; do not add it again. `cacheWrite1h` is the subset of `cacheWrite` written with one-hour retention.


## Base messages


### SystemMessage


``` code-snippet-module_root__tK5do
interface SystemMessage {
  role: "system";
  content: string | TextContent[];
  sections?: Record<string, string | null>;
  toolsAdded?: Tool[];
  toolsRemoved?: ToolReference[];
  timestamp: number;
}
```

The leading system message declares the initial prompt and tools. Later system messages can append instructions, replace or remove named prompt sections, and add or remove tools. Replaying them in order yields the current state.


### UserMessage


``` code-snippet-module_root__tK5do
interface UserMessage {
  role: "user";
  content: string | (TextContent | ImageContent)[];
  timestamp: number;
}
```


### AssistantMessage


``` code-snippet-module_root__tK5do
interface AssistantMessage {
  role: "assistant";
  content: (TextContent | ThinkingContent | ToolCall)[];
  api: string;
  provider: string;
  model: string;
  responseModel?: string;
  responseId?: string;
  providerThinkingLevel?: string;
  thinkingLevel?: ModelThinkingLevel;
  diagnostics?: AssistantMessageDiagnostic[];
  usage: Usage;
  stopReason: "pending" | "stop" | "length" | "toolUse" | "error" | "aborted" | "deferred";
  deferred?: DeferredHandle;
  errorMessage?: string;
  rawStopReason?: string;
  endTurn?: boolean;
  timestamp: number;
}
```

`responseModel` records the concrete model reported by the provider, when the provider reports one. It may equal the requested model. `responseId`, `providerThinkingLevel`, `thinkingLevel`, `diagnostics`, and `rawStopReason` preserve provider or runtime details.

`"pending"` is used for a partial assistant message while it streams. The completed message in `message_end` has a terminal stop reason, and Pi does not persist `"pending"` assistant messages in session JSONL.

A `"deferred"` response has a `DeferredHandle` with the provider data needed to retrieve it:

``` code-snippet-module_root__tK5do
interface DeferredHandle {
  provider: string;
  modelId: string;
  api: string;
  id: string;
  expiresAt?: number;
  pollAfterMs?: number;
  data?: JsonValue;
}
```


### ToolResultMessage


``` code-snippet-module_root__tK5do
interface ToolResultMessage<TDetails = any> {
  role: "toolResult";
  toolCallId: string;
  toolName: string;
  content: (TextContent | ImageContent)[];
  details?: TDetails;
  usage?: Usage;
  nestedCalls?: NestedToolCalls;
  isError: boolean;
  timestamp: number;
}
```

`details` is tool-specific. Optional `usage` reports nested model work performed by the tool and contributes to full-session statistics, but it is not part of the main model-call usage. `nestedCalls` records bounded metadata about calls this tool made to other tools:

``` code-snippet-module_root__tK5do
interface NestedToolCalls {
  calls: NestedToolCallRecord[];
  complete: boolean;
}

interface NestedToolCallRecord {
  id: string;
  name: string;
  arguments?: JsonObject;
  argumentsBytes?: number;
  status: "ok" | "error" | "unfinished";
  durationMs?: number;
  error?: string;
}
```


## Coding-agent messages


The coding-agent package extends `AgentMessage` with four roles.


### BashExecutionMessage


Created by direct shell commands, including the RPC <a href="/latest/rpc-commands#bash" class="link-module_root__svb26"><code class="inline-code-module_root__fGvLx" data-variant="soft">bash</code></a> command. It is not an LLM tool result.

``` code-snippet-module_root__tK5do
interface BashExecutionMessage {
  role: "bashExecution";
  command: string;
  output: string;
  exitCode: number | undefined;
  cancelled: boolean;
  truncated: boolean;
  fullOutputPath?: string;
  excludeFromContext?: boolean;
  timestamp: number;
}
```

Unless `excludeFromContext` is true, Pi converts this message to user-role text before the next model request.


### CustomMessage


Created when an extension sends a context message.

``` code-snippet-module_root__tK5do
interface CustomMessage<T = unknown> {
  role: "custom";
  customType: string;
  content: string | (TextContent | ImageContent)[];
  display: boolean;
  details?: T;
  timestamp: number;
}
```

Pi converts its content to a user message for model requests. `display` controls terminal rendering; `details` is not sent to the model.


### BranchSummaryMessage


``` code-snippet-module_root__tK5do
interface BranchSummaryMessage {
  role: "branchSummary";
  summary: string;
  fromId: string | null;
  timestamp: number;
}
```

Pi creates this context message from a persisted `branch_summary` entry.


### CompactionSummaryMessage


``` code-snippet-module_root__tK5do
interface CompactionSummaryMessage {
  role: "compactionSummary";
  summary: string;
  tokensBefore: number;
  timestamp: number;
}
```

Pi creates this context message from a persisted `compaction` entry.


## AgentMessage union


In the coding agent, the union is equivalent to:

``` code-snippet-module_root__tK5do
type AgentMessage =
  | SystemMessage
  | UserMessage
  | AssistantMessage
  | ToolResultMessage
  | BashExecutionMessage
  | CustomMessage
  | BranchSummaryMessage
  | CompactionSummaryMessage;
```

At the lower-level agent package, `AgentMessage` is `Message | CustomAgentMessages[keyof CustomAgentMessages]`. Applications can add roles through TypeScript declaration merging, so consumers should tolerate unknown custom roles when they accept messages from an augmented host.


