> Source: https://pi.dev/docs/latest/message-types



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Message Types


Pi uses `AgentMessage` values in SDK state, lifecycle events, RPC responses, and persisted session message entries. This page defines those shared messages and their content blocks.

Message timestamps are Unix timestamps in milliseconds. They are different from the ISO 8601 timestamps on [session entries](/docs/latest/session-format#entry-base).

Source definitions:

- [`packages/ai/src/types.ts`](https://github.com/earendil-works/pi/blob/main/packages/ai/src/types.ts) defines provider-facing messages and content blocks.
- [`packages/agent/src/types.ts`](https://github.com/earendil-works/pi/blob/main/packages/agent/src/types.ts) defines the extensible `AgentMessage` union.
- [`packages/coding-agent/src/core/messages.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/core/messages.ts) adds coding-agent message roles.


## Content blocks

<a href="#content-blocks" class="heading-anchor" aria-label="Permalink: Content blocks" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#content-blocks"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### TextContent

<a href="#textcontent" class="heading-anchor" aria-label="Permalink: TextContent" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#textcontent"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` typescript
interface TextContent {
  type: "text";
  text: string;
  textSignature?: string;
}
```

`textSignature` contains provider-specific message metadata. Treat it as opaque.


### ImageContent

<a href="#imagecontent" class="heading-anchor" aria-label="Permalink: ImageContent" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#imagecontent"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` typescript
interface ImageContent {
  type: "image";
  data: string;
  mimeType: string;
}
```

`data` is base64-encoded image data. `mimeType` identifies its media type, such as `image/png` or `image/jpeg`.


### ThinkingContent

<a href="#thinkingcontent" class="heading-anchor" aria-label="Permalink: ThinkingContent" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#thinkingcontent"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` typescript
interface ThinkingContent {
  type: "thinking";
  thinking: string;
  thinkingSignature?: string;
  redacted?: boolean;
}
```

Thinking signatures contain provider-specific replay data. Treat them as opaque. A redacted block can have no visible thinking text while retaining an encrypted payload in `thinkingSignature`.


### ToolCall

<a href="#toolcall" class="heading-anchor" aria-label="Permalink: ToolCall" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#toolcall"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` typescript
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

<a href="#usage" class="heading-anchor" aria-label="Permalink: Usage" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#usage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Assistant messages always contain usage. Tool results can contain usage when the tool performed nested model work.

``` typescript
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

<a href="#base-messages" class="heading-anchor" aria-label="Permalink: Base messages" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#base-messages"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### SystemMessage

<a href="#systemmessage" class="heading-anchor" aria-label="Permalink: SystemMessage" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#systemmessage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` typescript
interface SystemMessage {
  role: "system";
  content: string | TextContent[];
  sections?: Record<string, string | null>;
  toolsAdded?: Tool[];
  toolsRemoved?: ToolReference[];
  replace?: boolean;
  timestamp: number;
}
```

The leading system message declares the initial prompt and tools. Later system messages can append instructions, replace or remove named prompt sections, and add or remove tools. Replaying them in order yields the current state. A message with `replace: true` discards the earlier state and establishes a complete new baseline.


### UserMessage

<a href="#usermessage" class="heading-anchor" aria-label="Permalink: UserMessage" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#usermessage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` typescript
interface UserMessage {
  role: "user";
  content: string | (TextContent | ImageContent)[];
  timestamp: number;
}
```


### AssistantMessage

<a href="#assistantmessage" class="heading-anchor" aria-label="Permalink: AssistantMessage" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#assistantmessage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` typescript
interface AssistantMessage {
  role: "assistant";
  content: (TextContent | ThinkingContent | ToolCall)[];
  api: string;
  provider: string;
  model: string;
  responseModel?: string;
  responseId?: string;
  providerThinkingLevel?: string;
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

`responseModel` records a concrete provider response model when it differs from the requested model. `responseId`, `providerThinkingLevel`, `diagnostics`, and `rawStopReason` preserve provider or runtime details.

`"pending"` is used for a partial assistant message while it streams. The completed message in `message_end` has a terminal stop reason, and Pi does not persist `"pending"` assistant messages in session JSONL.

A `"deferred"` response has a `DeferredHandle` with the provider data needed to retrieve it:

``` typescript
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

<a href="#toolresultmessage" class="heading-anchor" aria-label="Permalink: ToolResultMessage" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#toolresultmessage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` typescript
interface ToolResultMessage<TDetails = any> {
  role: "toolResult";
  toolCallId: string;
  toolName: string;
  content: (TextContent | ImageContent)[];
  details?: TDetails;
  usage?: Usage;
  isError: boolean;
  timestamp: number;
}
```

`details` is tool-specific. Optional `usage` reports nested model work performed by the tool and contributes to full-session statistics, but it is not part of the main model-call usage.


## Coding-agent messages

<a href="#coding-agent-messages" class="heading-anchor" aria-label="Permalink: Coding-agent messages" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#coding-agent-messages"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


The coding-agent package extends `AgentMessage` with four roles.


### BashExecutionMessage

<a href="#bashexecutionmessage" class="heading-anchor" aria-label="Permalink: BashExecutionMessage" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#bashexecutionmessage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Created by direct shell commands, including the RPC [`bash`](/docs/latest/rpc-commands#bash) command. It is not an LLM tool result.

``` typescript
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

<a href="#custommessage" class="heading-anchor" aria-label="Permalink: CustomMessage" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#custommessage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Created when an extension sends a context message.

``` typescript
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

<a href="#branchsummarymessage" class="heading-anchor" aria-label="Permalink: BranchSummaryMessage" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#branchsummarymessage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` typescript
interface BranchSummaryMessage {
  role: "branchSummary";
  summary: string;
  fromId: string | null;
  timestamp: number;
}
```

Pi creates this context message from a persisted `branch_summary` entry.


### CompactionSummaryMessage

<a href="#compactionsummarymessage" class="heading-anchor" aria-label="Permalink: CompactionSummaryMessage" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#compactionsummarymessage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` typescript
interface CompactionSummaryMessage {
  role: "compactionSummary";
  summary: string;
  tokensBefore: number;
  timestamp: number;
}
```

Pi creates this context message from a persisted `compaction` entry.


## AgentMessage union

<a href="#agentmessage-union" class="heading-anchor" aria-label="Permalink: AgentMessage union" data-copy="" data-copy-text="https://pi.dev/docs/latest/message-types#agentmessage-union"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


In the coding agent, the union is equivalent to:

``` typescript
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


