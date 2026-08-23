> Source: https://pi.dev/docs/latest/compaction



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Compaction & Branch Summarization


LLMs have limited context windows. When conversations grow too long, Pi uses compaction to summarize older content while preserving recent work. This page covers both auto-compaction and branch summarization.

**Source files** ([pi-mono](https://github.com/earendil-works/pi-mono)):

- [`packages/coding-agent/src/core/compaction/compaction.ts`](https://github.com/earendil-works/pi-mono/blob/main/packages/coding-agent/src/core/compaction/compaction.ts) - Auto-compaction logic
- [`packages/coding-agent/src/core/compaction/branch-summarization.ts`](https://github.com/earendil-works/pi-mono/blob/main/packages/coding-agent/src/core/compaction/branch-summarization.ts) - Branch summarization
- [`packages/coding-agent/src/core/compaction/utils.ts`](https://github.com/earendil-works/pi-mono/blob/main/packages/coding-agent/src/core/compaction/utils.ts) - Shared utilities (file tracking, serialization)
- [`packages/coding-agent/src/core/session-manager.ts`](https://github.com/earendil-works/pi-mono/blob/main/packages/coding-agent/src/core/session-manager.ts) - Entry types (`CompactionEntry`, `BranchSummaryEntry`)
- [`packages/coding-agent/src/core/extensions/types.ts`](https://github.com/earendil-works/pi-mono/blob/main/packages/coding-agent/src/core/extensions/types.ts) - Extension event types

For TypeScript definitions in your project, inspect `node_modules/@earendil-works/pi-coding-agent/dist/`.


## Overview

<a href="#overview" class="heading-anchor" aria-label="Permalink: Overview" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#overview"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi has two summarization mechanisms:

| Mechanism | Trigger | Purpose |
|----|----|----|
| Compaction | Context exceeds threshold, or `/compact` | Summarize old messages to free up context |
| Branch summarization | `/tree` navigation | Preserve context when switching branches |

Both use the same structured summary format and track file operations cumulatively. Compaction and branch-summary requests use fresh routing session IDs and, where supported by the provider, disable prompt-cache writes because these one-off prompts are unlikely to be reused.


## Compaction

<a href="#compaction" class="heading-anchor" aria-label="Permalink: Compaction" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#compaction"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### When It Triggers

<a href="#when-it-triggers" class="heading-anchor" aria-label="Permalink: When It Triggers" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#when-it-triggers"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Auto-compaction triggers when:

    contextTokens > contextWindow - reserveTokens

By default, `reserveTokens` is 16384 tokens (configurable in `~/.pi/agent/settings.json` or `<project-dir>/.pi/settings.json`). This leaves room for the LLM's response.

You can also trigger manually with `/compact [instructions]`, where optional instructions focus the summary.


### How It Works

<a href="#how-it-works" class="heading-anchor" aria-label="Permalink: How It Works" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#how-it-works"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


1.  **Find cut point**: Walk backwards from newest message, accumulating token estimates until `keepRecentTokens` (default 20k, configurable in `~/.pi/agent/settings.json` or `<project-dir>/.pi/settings.json`) is reached
2.  **Extract messages**: Collect messages from the previous kept boundary (or session start) up to the cut point
3.  **Generate summary**: Call LLM to summarize with structured format, passing the previous summary as iterative context when present
4.  **Append entry**: Save `CompactionEntry` with summary and `firstKeptEntryId`
5.  **Rebuilds context**: Session rebuilds the context for the next request, using summary + messages from `firstKeptEntryId` onwards

<!-- -->

    Before compaction:

      entry:  0     1     2     3      4     5     6      7      8     9
            ┌─────┬─────┬─────┬──────┬─────┬─────┬──────┬──────┬─────┬─────┐
            │ hdr │ usr │ ass │ tool │ usr │ ass │ tool │ tool │ ass │ tool│
            └─────┴─────┴─────┴──────┴─────┴─────┴──────┴──────┴─────┴─────┘
                    └────────┬───────┘ └──────────────┬──────────────┘
                   messagesToSummarize            kept messages
                                       ↑
                              firstKeptEntryId (entry 4)

    After compaction (new entry appended):

      entry:  0     1     2     3      4     5     6      7      8     9     10
            ┌─────┬─────┬─────┬──────┬─────┬─────┬──────┬──────┬─────┬─────┬─────┐
            │ hdr │ usr │ ass │ tool │ usr │ ass │ tool │ tool │ ass │ tool│ cmp │
            └─────┴─────┴─────┴──────┴─────┴─────┴──────┴──────┴─────┴─────┴─────┘
                   └──────────┬──────┘ └──────────────────────┬───────────────────┘
                     not sent to LLM                    sent to LLM
                                                             ↑
                                                  starts from firstKeptEntryId

    What the LLM sees:

      ┌────────┬─────────┬─────┬─────┬──────┬──────┬─────┬──────┐
      │ system │ summary │ usr │ ass │ tool │ tool │ ass │ tool │
      └────────┴─────────┴─────┴─────┴──────┴──────┴─────┴──────┘
           ↑         ↑      └─────────────────┬────────────────┘
        prompt   from cmp          messages from firstKeptEntryId

On repeated compactions, the summarized span starts at the previous compaction's kept boundary (`firstKeptEntryId`), not at the compaction entry itself, falling back to the entry after the previous compaction if that kept entry cannot be found in the path. This preserves messages that survived the earlier compaction by including them in the next summarization pass as well. Pi also recalculates `tokensBefore` from the rebuilt session context before writing the new `CompactionEntry`, so the token count reflects the actual pre-compaction context being replaced.


### Split Turns

<a href="#split-turns" class="heading-anchor" aria-label="Permalink: Split Turns" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#split-turns"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


A "turn" starts with a user message and includes all assistant responses and tool calls until the next user message. Normally, compaction cuts at turn boundaries.

When a single turn exceeds `keepRecentTokens`, the cut point lands mid-turn at an assistant message. This is a "split turn":

    Split turn (one huge turn exceeds budget):

      entry:  0     1     2      3     4      5      6     7      8
            ┌─────┬─────┬─────┬──────┬─────┬──────┬──────┬─────┬──────┐
            │ hdr │ usr │ ass │ tool │ ass │ tool │ tool │ ass │ tool │
            └─────┴─────┴─────┴──────┴─────┴──────┴──────┴─────┴──────┘
                    ↑                                     ↑
             turnStartIndex = 1                  firstKeptEntryId = 7
                    │                                     │
                    └──── turnPrefixMessages (1-6) ───────┘
                                                          └── kept (7-8)

      isSplitTurn = true
      messagesToSummarize = []  (no complete turns before)
      turnPrefixMessages = [usr, ass, tool, ass, tool, tool]

For split turns, Pi generates two summaries and merges them:

1.  **History summary**: Previous context (if any)
2.  **Turn prefix summary**: The early part of the split turn


### Cut Point Rules

<a href="#cut-point-rules" class="heading-anchor" aria-label="Permalink: Cut Point Rules" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#cut-point-rules"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Valid cut points are:

- User messages
- Assistant messages
- BashExecution messages
- Custom messages (custom_message, branch_summary)

Never cut at tool results (they must stay with their tool call).


### CompactionEntry Structure

<a href="#compactionentry-structure" class="heading-anchor" aria-label="Permalink: CompactionEntry Structure" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#compactionentry-structure"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Defined in [`session-manager.ts`](https://github.com/earendil-works/pi-mono/blob/main/packages/coding-agent/src/core/session-manager.ts):

``` typescript
interface CompactionEntry<T = unknown> {
  type: "compaction";
  id: string;
  parentId: string;
  timestamp: number;
  summary: string;
  firstKeptEntryId: string;
  tokensBefore: number;
  usage?: Usage;       // LLM usage that generated the summary
  fromHook?: boolean;  // true if provided by extension (legacy field name)
  details?: T;         // implementation-specific data
}

// Default compaction uses this for details (from compaction.ts):
interface CompactionDetails {
  readFiles: string[];
  modifiedFiles: string[];
}
```

Extensions can store any JSON-serializable data in `details`. The default compaction tracks file operations, but custom extension implementations can use their own structure. Generated and extension-provided summaries store their LLM `usage` when available so session totals include summarization work.

See [`prepareCompaction()`](https://github.com/earendil-works/pi-mono/blob/main/packages/coding-agent/src/core/compaction/compaction.ts) and [`compact()`](https://github.com/earendil-works/pi-mono/blob/main/packages/coding-agent/src/core/compaction/compaction.ts) for the implementation. For direct programmatic summarization, `generateSummary()` returns the summary text and `generateSummaryWithUsage()` returns `{ text, usage }`.


## Branch Summarization

<a href="#branch-summarization" class="heading-anchor" aria-label="Permalink: Branch Summarization" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#branch-summarization"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### When It Triggers

<a href="#when-it-triggers-1" class="heading-anchor" aria-label="Permalink: When It Triggers" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#when-it-triggers-1"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


When you use `/tree` to navigate to a different branch, Pi offers to summarize the work you're leaving. This injects context from the left branch into the new branch.


### How It Works

<a href="#how-it-works-1" class="heading-anchor" aria-label="Permalink: How It Works" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#how-it-works-1"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


1.  **Find common ancestor**: Deepest node shared by old and new positions
2.  **Collect entries**: Walk from old leaf back to common ancestor
3.  **Prepare with budget**: Include messages up to token budget (newest first)
4.  **Generate summary**: Call LLM with structured format
5.  **Append entry**: Save `BranchSummaryEntry` at navigation point

<!-- -->

    Tree before navigation:

             ┌─ B ─ C ─ D (old leaf, being abandoned)
        A ───┤
             └─ E ─ F (target)

    Common ancestor: A
    Entries to summarize: B, C, D

    After navigation with summary:

             ┌─ B ─ C ─ D
        A ───┤
             └─ E ─ F ─ [summary of B,C,D] (new leaf)


### Cumulative File Tracking

<a href="#cumulative-file-tracking" class="heading-anchor" aria-label="Permalink: Cumulative File Tracking" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#cumulative-file-tracking"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Both compaction and branch summarization track files cumulatively. When generating a summary, pi extracts file operations from:

- Tool calls in the messages being summarized
- Previous compaction or branch summary `details` (if any)

This means file tracking accumulates across multiple compactions or nested branch summaries, preserving the full history of read and modified files.


### BranchSummaryEntry Structure

<a href="#branchsummaryentry-structure" class="heading-anchor" aria-label="Permalink: BranchSummaryEntry Structure" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#branchsummaryentry-structure"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Defined in [`session-manager.ts`](https://github.com/earendil-works/pi-mono/blob/main/packages/coding-agent/src/core/session-manager.ts):

``` typescript
interface BranchSummaryEntry<T = unknown> {
  type: "branch_summary";
  id: string;
  parentId: string;
  timestamp: number;
  summary: string;
  fromId: string;      // Entry we navigated from
  usage?: Usage;       // LLM usage that generated the summary
  fromHook?: boolean;  // true if provided by extension (legacy field name)
  details?: T;         // implementation-specific data
}

// Default branch summarization uses this for details (from branch-summarization.ts):
interface BranchSummaryDetails {
  readFiles: string[];
  modifiedFiles: string[];
}
```

Same as compaction, extensions can store custom data in `details`.

See [`collectEntriesForBranchSummary()`](https://github.com/earendil-works/pi-mono/blob/main/packages/coding-agent/src/core/compaction/branch-summarization.ts), [`prepareBranchEntries()`](https://github.com/earendil-works/pi-mono/blob/main/packages/coding-agent/src/core/compaction/branch-summarization.ts), and [`generateBranchSummary()`](https://github.com/earendil-works/pi-mono/blob/main/packages/coding-agent/src/core/compaction/branch-summarization.ts) for the implementation.


## Summary Format

<a href="#summary-format" class="heading-anchor" aria-label="Permalink: Summary Format" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#summary-format"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Both compaction and branch summarization use the same structured format:

``` markdown
## Goal
[What the user is trying to accomplish]

## Constraints & Preferences
- [Requirements mentioned by user]

## Progress
### Done
- [x] [Completed tasks]

### In Progress
- [ ] [Current work]

### Blocked
- [Issues, if any]

## Key Decisions
- **[Decision]**: [Rationale]

## Next Steps
1. [What should happen next]

## Critical Context
- [Data needed to continue]

<read-files>
path/to/file1.ts
path/to/file2.ts
</read-files>

<modified-files>
path/to/changed.ts
</modified-files>
```


### Message Serialization

<a href="#message-serialization" class="heading-anchor" aria-label="Permalink: Message Serialization" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#message-serialization"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Before summarization, messages are serialized to text via [`serializeConversation()`](https://github.com/earendil-works/pi-mono/blob/main/packages/coding-agent/src/core/compaction/utils.ts):

    [User]: What they said
    [Assistant thinking]: Internal reasoning
    [Assistant]: Response text
    [Assistant tool calls]: read(path="foo.ts"); edit(path="bar.ts", ...)
    [Tool result]: Output from tool

This prevents the model from treating it as a conversation to continue.

Tool results are truncated to 2000 characters during serialization. Content beyond that limit is replaced with a marker indicating how many characters were truncated. This keeps summarization requests within reasonable token budgets, since tool results (especially from `read` and `bash`) are typically the largest contributors to context size.


## Custom Summarization via Extensions

<a href="#custom-summarization-via-extensions" class="heading-anchor" aria-label="Permalink: Custom Summarization via Extensions" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#custom-summarization-via-extensions"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Extensions can intercept and customize both compaction and branch summarization. See [`extensions/types.ts`](https://github.com/earendil-works/pi-mono/blob/main/packages/coding-agent/src/core/extensions/types.ts) for event type definitions.


### session_before_compact

<a href="#session-before-compact" class="heading-anchor" aria-label="Permalink: session_before_compact" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#session-before-compact"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Fired before auto-compaction or `/compact`. Can cancel or provide custom summary. See `SessionBeforeCompactEvent` and `CompactionPreparation` in the types file.

``` typescript
pi.on("session_before_compact", async (event, ctx) => {
  const { preparation, branchEntries, customInstructions, reason, willRetry, signal } = event;

  // preparation.messagesToSummarize - messages to summarize
  // preparation.turnPrefixMessages - split turn prefix (if isSplitTurn)
  // preparation.previousSummary - previous compaction summary
  // preparation.fileOps - extracted file operations
  // preparation.tokensBefore - context tokens before compaction
  // preparation.firstKeptEntryId - where kept messages start
  // preparation.settings - compaction settings

  // branchEntries - all entries on current branch (for custom state)
  // reason - "manual" (/compact), "threshold", or "overflow"
  // willRetry - whether the aborted turn is retried after compaction (overflow recovery)
  // signal - AbortSignal (pass to LLM calls)

  // Cancel:
  return { cancel: true };

  // Custom summary:
  return {
    compaction: {
      summary: "Your summary...",
      firstKeptEntryId: preparation.firstKeptEntryId,
      tokensBefore: preparation.tokensBefore,
      // usage: summaryResponse.usage, // Optional; included in session totals
      details: { /* custom data */ },
    }
  };
});
```


#### Converting Messages to Text

<a href="#converting-messages-to-text" class="heading-anchor" aria-label="Permalink: Converting Messages to Text" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#converting-messages-to-text"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


To generate a summary with your own model, convert messages to text using `serializeConversation`:

``` typescript
import { convertToLlm, serializeConversation } from "@earendil-works/pi-coding-agent";

pi.on("session_before_compact", async (event, ctx) => {
  const { preparation } = event;

  // Convert AgentMessage[] to Message[], then serialize to text
  const conversationText = serializeConversation(
    convertToLlm(preparation.messagesToSummarize)
  );
  // Returns:
  // [User]: message text
  // [Assistant thinking]: thinking content
  // [Assistant]: response text
  // [Assistant tool calls]: read(path="..."); bash(command="...")
  // [Tool result]: output text

  // Now send to your model for summarization
  const { summary, usage } = await myModel.summarize(conversationText);

  return {
    compaction: {
      summary,
      firstKeptEntryId: preparation.firstKeptEntryId,
      tokensBefore: preparation.tokensBefore,
      usage,
    }
  };
});
```

See [custom-compaction.ts](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/custom-compaction.ts) for a complete example using a different model.


### session_compact_failed

<a href="#session-compact-failed" class="heading-anchor" aria-label="Permalink: session_compact_failed" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#session-compact-failed"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Fired when manual or automatic compaction fails or is aborted. This is useful for telemetry extensions that need to pair `session_before_compact` attempts with terminal outcomes.

``` typescript
pi.on("session_compact_failed", async (event, ctx) => {
  const { reason, errorMessage, aborted, willRetry, fromExtension } = event;
  // reason - "manual" (/compact), "threshold", or "overflow"
  // errorMessage - present for non-abort failures
  // aborted - true for cancelled/aborted compactions
  // willRetry - whether the aborted turn would have retried after compaction
  // fromExtension - whether extension-provided compaction content was being used
});
```


### session_before_tree

<a href="#session-before-tree" class="heading-anchor" aria-label="Permalink: session_before_tree" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#session-before-tree"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Fired before `/tree` navigation. Always fires regardless of whether user chose to summarize. Can cancel navigation or provide custom summary.

``` typescript
pi.on("session_before_tree", async (event, ctx) => {
  const { preparation, signal } = event;

  // preparation.targetId - where we're navigating to
  // preparation.oldLeafId - current position (being abandoned)
  // preparation.commonAncestorId - shared ancestor
  // preparation.entriesToSummarize - entries that would be summarized
  // preparation.userWantsSummary - whether user chose to summarize

  // Cancel navigation entirely:
  return { cancel: true };

  // Provide custom summary (only used if userWantsSummary is true):
  if (preparation.userWantsSummary) {
    return {
      summary: {
        summary: "Your summary...",
        // usage: summaryResponse.usage, // Optional; included in session totals
        details: { /* custom data */ },
      }
    };
  }
});
```

See `SessionBeforeTreeEvent` and `TreePreparation` in the types file.


## Settings

<a href="#settings" class="heading-anchor" aria-label="Permalink: Settings" data-copy="" data-copy-text="https://pi.dev/docs/latest/compaction#settings"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Configure compaction in `~/.pi/agent/settings.json` or `<project-dir>/.pi/settings.json`:

``` json
{
  "compaction": {
    "enabled": true,
    "reserveTokens": 16384,
    "keepRecentTokens": 20000
  }
}
```

| Setting            | Default | Description                            |
|--------------------|---------|----------------------------------------|
| `enabled`          | `true`  | Enable auto-compaction                 |
| `reserveTokens`    | `16384` | Tokens to reserve for LLM response     |
| `keepRecentTokens` | `20000` | Recent tokens to keep (not summarized) |

Disable auto-compaction with `"enabled": false`. You can still compact manually with `/compact`.


