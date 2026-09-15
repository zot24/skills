> Source: https://pi.dev/docs/latest/session-format



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Session File Format


Sessions are stored as JSONL (JSON Lines) files. Each line is a JSON object with a `type` field. Session entries form a tree structure via `id`/`parentId` fields, enabling in-place branching without creating new files.


## File Location

<a href="#file-location" class="heading-anchor" aria-label="Permalink: File Location" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#file-location"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


    ~/.pi/agent/sessions/--<path>--/<timestamp>_<session-id>.jsonl

By default, `<session-id>` is a UUID. Callers can supply a custom ID through the SDK or `--session-id`. For `<path>`, Pi removes the leading path separator and replaces `/`, `\\`, and `:` with `-`.


## Deleting Sessions

<a href="#deleting-sessions" class="heading-anchor" aria-label="Permalink: Deleting Sessions" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#deleting-sessions"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Sessions can be removed by deleting their `.jsonl` files under `~/.pi/agent/sessions/`.

Pi also supports deleting sessions interactively from `/resume` (select a session and press `Ctrl+D`, then confirm). When available, pi uses the `trash` CLI to avoid permanent deletion.


## Session Version

<a href="#session-version" class="heading-anchor" aria-label="Permalink: Session Version" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#session-version"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Sessions have a version field in the header:

- **Version 1**: Linear entry sequence (legacy, auto-migrated on load)
- **Version 2**: Tree structure with `id`/`parentId` linking
- **Version 3**: Renamed `hookMessage` role to `custom` (extensions unification)

Existing sessions are automatically migrated to the current version (v3) when loaded.


## Source Files

<a href="#source-files" class="heading-anchor" aria-label="Permalink: Source Files" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#source-files"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Source on GitHub ([pi](https://github.com/earendil-works/pi)):

- [`packages/coding-agent/src/core/session-manager.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/core/session-manager.ts) - Session entry types and SessionManager
- [`packages/coding-agent/src/core/messages.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/core/messages.ts) - Extended message types (BashExecutionMessage, CustomMessage, etc.)
- [`packages/ai/src/types.ts`](https://github.com/earendil-works/pi/blob/main/packages/ai/src/types.ts) - Base message types (UserMessage, AssistantMessage, ToolResultMessage)
- [`packages/agent/src/types.ts`](https://github.com/earendil-works/pi/blob/main/packages/agent/src/types.ts) - AgentMessage union type

For TypeScript definitions in your project, inspect `node_modules/@earendil-works/pi-coding-agent/dist/` and `node_modules/@earendil-works/pi-ai/dist/`.


## Message Types

<a href="#message-types" class="heading-anchor" aria-label="Permalink: Message Types" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#message-types"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Session entries contain `AgentMessage` objects. Understanding these types is essential for parsing sessions and writing extensions.


### Content Blocks

<a href="#content-blocks" class="heading-anchor" aria-label="Permalink: Content Blocks" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#content-blocks"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Messages contain arrays of typed content blocks:

``` typescript
interface TextContent {
  type: "text";
  text: string;
  textSignature?: string;
}

interface ImageContent {
  type: "image";
  data: string;      // base64 encoded
  mimeType: string;  // e.g., "image/jpeg", "image/png"
}

interface ThinkingContent {
  type: "thinking";
  thinking: string;
  thinkingSignature?: string;
  redacted?: boolean;
}

interface ToolCall {
  type: "toolCall";
  id: string;
  name: string;
  arguments: Record<string, any>;
  thoughtSignature?: string;
  namespace?: string;
}
```


### Base Message Types (from pi-ai)

<a href="#base-message-types-from-pi-ai" class="heading-anchor" aria-label="Permalink: Base Message Types (from pi-ai)" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#base-message-types-from-pi-ai"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` typescript
interface UserMessage {
  role: "user";
  content: string | (TextContent | ImageContent)[];
  timestamp: number;  // Unix ms
}

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

interface ToolResultMessage {
  role: "toolResult";
  toolCallId: string;
  toolName: string;
  content: (TextContent | ImageContent)[];
  details?: any;      // Tool-specific metadata
  usage?: Usage;      // Nested LLM work performed by the tool
  addedToolNames?: string[];
  isError: boolean;
  timestamp: number;
}

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

`"pending"` is reserved for partial messages in streaming events. Terminal events replace it with a completion reason before Pi persists the assistant message, so `"pending"` should never appear in session JSONL. `"deferred"` is a terminal reason for a provider response that will complete later; its `deferred` handle contains the provider data needed to retrieve that response.


### Extended Message Types (from pi-coding-agent)

<a href="#extended-message-types-from-pi-coding-agent" class="heading-anchor" aria-label="Permalink: Extended Message Types (from pi-coding-agent)" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#extended-message-types-from-pi-coding-agent"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` typescript
interface BashExecutionMessage {
  role: "bashExecution";
  command: string;
  output: string;
  exitCode: number | undefined;
  cancelled: boolean;
  truncated: boolean;
  fullOutputPath?: string;
  excludeFromContext?: boolean;  // true for !! prefix commands
  timestamp: number;
}

interface CustomMessage {
  role: "custom";
  customType: string;            // Extension identifier
  content: string | (TextContent | ImageContent)[];
  display: boolean;              // Show in TUI
  details?: any;                 // Extension-specific metadata
  timestamp: number;
}

interface BranchSummaryMessage {
  role: "branchSummary";
  summary: string;
  fromId: string | null;         // Previous leaf whose abandoned path was summarized
  timestamp: number;
}

interface CompactionSummaryMessage {
  role: "compactionSummary";
  summary: string;
  tokensBefore: number;
  timestamp: number;
}
```


### AgentMessage Union

<a href="#agentmessage-union" class="heading-anchor" aria-label="Permalink: AgentMessage Union" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#agentmessage-union"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` typescript
type AgentMessage =
  | UserMessage
  | AssistantMessage
  | ToolResultMessage
  | BashExecutionMessage
  | CustomMessage
  | BranchSummaryMessage
  | CompactionSummaryMessage;
```


## Entry Base

<a href="#entry-base" class="heading-anchor" aria-label="Permalink: Entry Base" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#entry-base"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


All entries (except `SessionHeader`) extend `SessionEntryBase`:

``` typescript
interface SessionEntryBase {
  type: string;
  id: string;           // Usually an 8-char hex ID; may fall back to a full UUID
  parentId: string | null;  // Parent entry ID (null for a root entry)
  timestamp: string;    // ISO timestamp
}
```


## Entry Types

<a href="#entry-types" class="heading-anchor" aria-label="Permalink: Entry Types" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#entry-types"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### SessionHeader

<a href="#sessionheader" class="heading-anchor" aria-label="Permalink: SessionHeader" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#sessionheader"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


First line of the file. Metadata only, not part of the tree (no `id`/`parentId`).

``` json
{"type":"session","version":3,"id":"uuid","timestamp":"2024-12-03T14:00:00.000Z","cwd":"/path/to/project"}
```

For sessions with a parent (created via `/fork`, `/clone`, or `newSession({ parentSession })`):

``` json
{"type":"session","version":3,"id":"uuid","timestamp":"2024-12-03T14:00:00.000Z","cwd":"/path/to/project","parentSession":"/path/to/original/session.jsonl"}
```


### SessionMessageEntry

<a href="#sessionmessageentry" class="heading-anchor" aria-label="Permalink: SessionMessageEntry" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#sessionmessageentry"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


A message in the conversation. The `message` field contains an `AgentMessage`.

``` json
{"type":"message","id":"a1b2c3d4","parentId":"prev1234","timestamp":"2024-12-03T14:00:01.000Z","message":{"role":"user","content":"Hello","timestamp":1733234401000}}
{"type":"message","id":"b2c3d4e5","parentId":"a1b2c3d4","timestamp":"2024-12-03T14:00:02.000Z","message":{"role":"assistant","content":[{"type":"text","text":"Hi!"}],"api":"anthropic-messages","provider":"anthropic","model":"claude-sonnet-4-5","usage":{...},"stopReason":"stop","timestamp":1733234402000}}
{"type":"message","id":"c3d4e5f6","parentId":"b2c3d4e5","timestamp":"2024-12-03T14:00:03.000Z","message":{"role":"toolResult","toolCallId":"call_123","toolName":"bash","content":[{"type":"text","text":"output"}],"isError":false,"timestamp":1733234403000}}
```


### ModelChangeEntry

<a href="#modelchangeentry" class="heading-anchor" aria-label="Permalink: ModelChangeEntry" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#modelchangeentry"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Emitted when the user switches models mid-session.

``` json
{"type":"model_change","id":"d4e5f6g7","parentId":"c3d4e5f6","timestamp":"2024-12-03T14:05:00.000Z","provider":"openai","modelId":"gpt-4o"}
```


### ThinkingLevelChangeEntry

<a href="#thinkinglevelchangeentry" class="heading-anchor" aria-label="Permalink: ThinkingLevelChangeEntry" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#thinkinglevelchangeentry"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Emitted when the user changes the thinking/reasoning level.

``` json
{"type":"thinking_level_change","id":"e5f6g7h8","parentId":"d4e5f6g7","timestamp":"2024-12-03T14:06:00.000Z","thinkingLevel":"high"}
```


### CompactionEntry

<a href="#compactionentry" class="heading-anchor" aria-label="Permalink: CompactionEntry" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#compactionentry"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Created when context is compacted. Stores a summary of earlier messages.

``` json
{"type":"compaction","id":"f6g7h8i9","parentId":"e5f6g7h8","timestamp":"2024-12-03T14:10:00.000Z","summary":"User discussed X, Y, Z...","firstKeptEntryId":"c3d4e5f6","tokensBefore":50000}
```

`firstKeptEntryId` is required. It identifies the first entry retained from before the compaction entry. When rebuilding context, Pi replaces older summarized entries with the compaction summary and keeps the range beginning at this entry.

Optional fields:

- `usage`: LLM usage from generating the summary; included in session token and cost totals
- `details`: Implementation-specific data (e.g., `{ readFiles: string[], modifiedFiles: string[] }` for default, or custom data for extensions)
- `fromHook`: `true` if generated by an extension, `false`/`undefined` if pi-generated (legacy field name)


### BranchSummaryEntry

<a href="#branchsummaryentry" class="heading-anchor" aria-label="Permalink: BranchSummaryEntry" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#branchsummaryentry"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Created when switching branches via `/tree` with an LLM generated summary of the left branch up to the common ancestor. Captures context from the abandoned path.

``` json
{"type":"branch_summary","id":"g7h8i9j0","parentId":"a1b2c3d4","timestamp":"2024-12-03T14:15:00.000Z","fromId":"f6g7h8i9","summary":"Branch explored approach A..."}
```

`parentId` is the entry from which the new branch continues. `fromId` is the previous leaf whose abandoned path was summarized.

Optional fields:

- `usage`: LLM usage from generating the summary; included in session token and cost totals
- `details`: File tracking data (`{ readFiles: string[], modifiedFiles: string[] }`) for default, or custom data for extensions
- `fromHook`: `true` if generated by an extension, `false`/`undefined` if pi-generated (legacy field name)


### CustomEntry

<a href="#customentry" class="heading-anchor" aria-label="Permalink: CustomEntry" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#customentry"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Extension state persistence. Does NOT participate in LLM context.

``` json
{"type":"custom","id":"h8i9j0k1","parentId":"g7h8i9j0","timestamp":"2024-12-03T14:20:00.000Z","customType":"my-extension","data":{"count":42}}
```

Use `customType` to identify your extension's entries on reload. Interactive mode can render custom entries via `pi.registerEntryRenderer(customType, renderer)`, but they still do not participate in LLM context.


### CustomMessageEntry

<a href="#custommessageentry" class="heading-anchor" aria-label="Permalink: CustomMessageEntry" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#custommessageentry"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Extension-injected messages that DO participate in LLM context.

``` json
{"type":"custom_message","id":"i9j0k1l2","parentId":"h8i9j0k1","timestamp":"2024-12-03T14:25:00.000Z","customType":"my-extension","content":"Injected context...","display":true}
```

Fields:

- `content`: String or `(TextContent | ImageContent)[]` (same as UserMessage)
- `display`: `true` = show in TUI with distinct styling, `false` = hidden
- `details`: Optional extension-specific metadata (not sent to LLM)


### LabelEntry

<a href="#labelentry" class="heading-anchor" aria-label="Permalink: LabelEntry" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#labelentry"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


User-defined bookmark/marker on an entry.

``` json
{"type":"label","id":"j0k1l2m3","parentId":"i9j0k1l2","timestamp":"2024-12-03T14:30:00.000Z","targetId":"a1b2c3d4","label":"checkpoint-1"}
```

Set `label` to `undefined` to clear a label.


### SessionInfoEntry

<a href="#sessioninfoentry" class="heading-anchor" aria-label="Permalink: SessionInfoEntry" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#sessioninfoentry"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Session metadata (e.g., user-defined display name). Set via `/name`, `--name` / `-n`, or `pi.setSessionName()` in extensions.

``` json
{"type":"session_info","id":"k1l2m3n4","parentId":"j0k1l2m3","timestamp":"2024-12-03T14:35:00.000Z","name":"Refactor auth module"}
```

The session name is displayed in the session selector (`/resume`) instead of the first message when set.


## Tree Structure

<a href="#tree-structure" class="heading-anchor" aria-label="Permalink: Tree Structure" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#tree-structure"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Entries normally form one tree, but navigation APIs can create multiple roots:

- A root entry has `parentId: null`; the first entry is initially the root
- Each non-root entry points to its parent via `parentId`
- Branching creates new children from an earlier entry
- The "leaf" is the current position in the tree
- Calling `resetLeaf()` or `branchWithSummary(null, ...)` allows a later entry to become another root

<!-- -->

    [user msg] ─── [assistant] ─── [user msg] ─── [assistant] ─┬─ [user msg] ← current leaf
                                                                │
                                                                └─ [branch_summary] ─── [user msg] ← alternate branch


## Context Building

<a href="#context-building" class="heading-anchor" aria-label="Permalink: Context Building" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#context-building"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


`buildContextEntries()` walks from the current leaf to the root, producing the active entry list while honoring compaction:

1.  Collects all entries on the path
2.  If one or more `CompactionEntry` values are on the path, uses the latest one:
    - Includes the compaction entry first
    - Includes entries from `firstKeptEntryId` up to, but not including, the compaction entry
    - Includes entries after the compaction entry
3.  Preserves non-message entries in the selected range so interactive mode can render them

`buildSessionContext()` builds on that entry list to produce the message list for the LLM:

1.  Extracts current model and thinking level settings from the full path
2.  Converts selected entries to messages:
    - `message` -\> stored `AgentMessage`
    - `compaction` -\> `compactionSummary`
    - `branch_summary` -\> `branchSummary`
    - `custom_message` -\> `CustomMessage`
    - `custom` -\> no context message

The compaction summary replaces entries before `firstKeptEntryId`. The retained entries and all entries after the compaction remain available to the LLM.


## Parsing Example

<a href="#parsing-example" class="heading-anchor" aria-label="Permalink: Parsing Example" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#parsing-example"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` typescript
import { readFileSync } from "fs";

const lines = readFileSync("session.jsonl", "utf8").trim().split("\n");

for (const line of lines) {
  const entry = JSON.parse(line);

  switch (entry.type) {
    case "session":
      console.log(`Session v${entry.version ?? 1}: ${entry.id}`);
      break;
    case "message":
      console.log(`[${entry.id}] ${entry.message.role}: ${JSON.stringify(entry.message.content)}`);
      break;
    case "compaction":
      console.log(`[${entry.id}] Compaction: ${entry.tokensBefore} tokens summarized`);
      break;
    case "branch_summary":
      console.log(`[${entry.id}] Branch from ${entry.fromId}`);
      break;
    case "custom":
      console.log(`[${entry.id}] Custom (${entry.customType}): ${JSON.stringify(entry.data)}`);
      break;
    case "custom_message":
      console.log(`[${entry.id}] Extension message (${entry.customType}): ${entry.content}`);
      break;
    case "label":
      console.log(`[${entry.id}] Label "${entry.label}" on ${entry.targetId}`);
      break;
    case "model_change":
      console.log(`[${entry.id}] Model: ${entry.provider}/${entry.modelId}`);
      break;
    case "thinking_level_change":
      console.log(`[${entry.id}] Thinking: ${entry.thinkingLevel}`);
      break;
  }
}
```


## SessionManager API

<a href="#sessionmanager-api" class="heading-anchor" aria-label="Permalink: SessionManager API" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#sessionmanager-api"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Key methods for working with sessions programmatically.


### Static Creation Methods

<a href="#static-creation-methods" class="heading-anchor" aria-label="Permalink: Static Creation Methods" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#static-creation-methods"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- `SessionManager.create(cwd, sessionDir?, options?)` - New session; `options` can set `id` and `parentSession`
- `SessionManager.open(path, sessionDir?, cwdOverride?)` - Open existing session file
- `SessionManager.continueRecent(cwd, sessionDir?)` - Continue most recent or create new
- `SessionManager.inMemory(cwd?, options?, entries?)` - No file persistence, optionally initialized from entries
- `SessionManager.forkFrom(sourcePath, targetCwd, sessionDir?, options?)` - Fork session from another project


### Static Listing Methods

<a href="#static-listing-methods" class="heading-anchor" aria-label="Permalink: Static Listing Methods" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#static-listing-methods"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- `SessionManager.list(cwd, sessionDir?, onProgress?)` - List sessions for a directory
- `SessionManager.listAll(onProgress?)` - List all sessions across all projects
- `SessionManager.listAll(sessionDir?, onProgress?)` - List sessions from a custom session root


### Instance Methods - Session Management

<a href="#instance-methods---session-management" class="heading-anchor" aria-label="Permalink: Instance Methods - Session Management" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#instance-methods---session-management"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- `newSession(options?)` - Start a new session (options: `{ id?: string, parentSession?: string }`)
- `setSessionFile(path)` - Switch to a different session file
- `createBranchedSession(leafId)` - Extract branch to new session file


### Instance Methods - Appending (all return entry ID)

<a href="#instance-methods---appending-all-return-entry-id" class="heading-anchor" aria-label="Permalink: Instance Methods - Appending (all return entry ID)" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#instance-methods---appending-all-return-entry-id"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- `appendMessage(message)` - Add message
- `appendThinkingLevelChange(level)` - Record thinking change
- `appendModelChange(provider, modelId)` - Record model change
- `appendCompaction(summary, firstKeptEntryId, tokensBefore, details?, fromHook?, usage?)` - Add compaction
- `appendCustomEntry(customType, data?)` - Extension state (not in context)
- `appendSessionInfo(name)` - Set session display name
- `appendCustomMessageEntry(customType, content, display, details?)` - Extension message (in context)
- `appendLabelChange(targetId, label)` - Set/clear label


### Instance Methods - Tree Navigation

<a href="#instance-methods---tree-navigation" class="heading-anchor" aria-label="Permalink: Instance Methods - Tree Navigation" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#instance-methods---tree-navigation"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- `getLeafId()` - Current position
- `getLeafEntry()` - Get current leaf entry
- `getEntry(id)` - Get entry by ID
- `getBranch(fromId?)` - Walk from entry to root
- `getTree()` - Get full tree structure
- `getChildren(parentId)` - Get direct children
- `getLabel(id)` - Get label for entry
- `branch(entryId)` - Move leaf to earlier entry
- `resetLeaf()` - Reset leaf to null (before any entries)
- `branchWithSummary(entryId, summary, details?, fromHook?, usage?)` - Branch with context summary; `entryId` may be `null` to branch from the root


### Instance Methods - Context & Info

<a href="#instance-methods---context--info" class="heading-anchor" aria-label="Permalink: Instance Methods - Context &amp; Info" data-copy="" data-copy-text="https://pi.dev/docs/latest/session-format#instance-methods---context--info"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- `buildContextEntries()` - Get active branch entries with compaction applied
- `buildSessionContext()` - Get messages, thinkingLevel, and model for LLM
- `getEntries()` - All entries (excluding header)
- `getHeader()` - Session header metadata
- `getSessionName()` - Get display name from latest session_info entry
- `getCwd()` - Working directory
- `getSessionDir()` - Session storage directory
- `getSessionId()` - Session UUID
- `getSessionFile()` - Session file path (undefined for in-memory)
- `isPersisted()` - Whether session is saved to disk


