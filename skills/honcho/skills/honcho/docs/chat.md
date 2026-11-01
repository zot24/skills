> Source: https://honcho.dev/docs/v3/documentation/features/chat.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Chat Endpoint

> Ask Honcho questions about one peer, or across a whole workspace

The Chat endpoint is the natural language interface to Honcho's reasoning. Instead of manually retrieving conclusions, your LLM can ask questions and get synthesized answers based on all the reasoning Honcho has done. Think of it as agent-to-agent communication.

There are two ways to ask:

| | `peer.chat()` | `honcho.chat()` |
| - | - | - |
| Answers from | One peer's representation, from an observer's perspective | Every peer in the workspace, with no anchor peer |
| Good for | Personalization, per-user decisions, "what does this peer know about that peer" | Cross-peer themes, team-wide questions, "what does this workspace know" |
| Endpoint | `POST /v3/workspaces/{workspace_id}/peers/{peer_id}/chat` | `POST /v3/workspaces/{workspace_id}/chat` |

Most applications start with peer chat. Jump to [Workspace Chat](#workspace-chat) when the question spans more than one peer.

## Basic Usage

The simplest way to use the chat endpoint is to ask a question and get a text response:

```python Python theme={null}
from honcho import Honcho

honcho = Honcho()
peer = honcho.peer("user-123")

# Ask Honcho about the peer
query = "What is the user's favorite way of completing the task?"
answer = peer.chat(query)

print(answer)
# "Based on conclusions, the user prefers using keyboard shortcuts..."
```

```typescript TypeScript theme={null}
import { Honcho } from '@honcho-ai/sdk';

const honcho = new Honcho({});
const peer = await honcho.peer("user-123");

// Ask Honcho about the peer
const query = "What is the user's favorite way of completing the task?";
const answer = await peer.chat(query);

console.log(answer);
// "Based on conclusions, the user prefers using keyboard shortcuts..."
```

Peer chat searches through the peer's representation--all the conclusions Honcho has reasoned about them--and synthesizes a natural language answer.

## Reasoning Level

Use `reasoning_level` to trade off speed against depth for a specific chat request. It is optional and defaults to `low`. Accepted values are `minimal`, `low`, `medium`, `high`, and `max`. The same levels apply to [workspace chat](#workspace-chat).

The reasoning level controls which model the request is routed to, the tools used by the agent, the thinking budget, the maximum tool-iteration count, and output token limits.

| Level | When to use | Notes |
| - | - | - |
| `minimal` | Fast factual lookups | Smallest prefetch window and minimal tools for lower cost. |
| `low` | Default balance | Standard tool set and budgets. |
| `medium` | Multi-step or ambiguous questions | Calls fewer tools than `low`, but thinks harder and longer. |
| `high` | Complex synthesis across sources | Thinks like `medium`, but uses more tools. |
| `max` | Deep research, most complex queries | Highest thinking budget, max iterations. |

```python Python theme={null}
query = "Summarize the user's long-term goals."
answer = peer.chat(query, reasoning_level="high")
```

```typescript TypeScript theme={null}
const query = "Summarize the user's long-term goals.";
const answer = await peer.chat(query, { reasoningLevel: "high" });
```

## Streaming Responses

You can also receive the answer as a stream of text chunks:

```python Python theme={null}
query = "What do we know about the user?"
response_stream = peer.chat(query, stream=True)

for chunk in response_stream.iter_text():
    print(chunk, end="", flush=True)
```

```typescript TypeScript theme={null}
const query = "What do we know about the user?";
const responseStream = await peer.chat(query, { stream: true });

for await (const chunk of responseStream.iter_text()) {
    process.stdout.write(chunk);
}
```

The agent gathers context before it answers, so the answer usually arrives as a single chunk once it finishes; only an answer synthesized at the tool-call limit streams as it is generated. See [Streaming Responses](https://honcho.dev/docs/v3/documentation/features/advanced/streaming-response.md).

## Scoping to Sessions

By default the chat endpoint reasons over everything Honcho knows about the
peer. Pass `session` (`session_id` on the REST body) to restrict it to one
session:

```python Python theme={null}
answer = peer.chat("What did the user ask about?", session=session.id)
```

```typescript TypeScript theme={null}
const answer = await peer.chat("What did the user ask about?", { session: session.id });
```

To restrict a request to a *set* of sessions, use the session allowlist — a
constrained `filters` body on the endpoint. See
[Scoping Recall to Sessions](https://honcho.dev/docs/v3/documentation/features/advanced/using-filters.md#scoping-recall-to-sessions)
for the accepted shapes and for what an allowlist changes about the answer.

Pass `scope="therapy"` to answer from that [scope](https://honcho.dev/docs/v3/documentation/features/advanced/scopes.md)'s
own representation of the peer. A list (`scope=["therapy", "intake"]`) is an
allowlist of those scopes' sessions, not named-scope depth.
`honcho.chat(scope=)` is always the allowlist arm, even with one name. Details
are on the [scopes page](https://honcho.dev/docs/v3/documentation/features/advanced/scopes.md#the-two-arms).

## Structured Outputs

When your application needs a machine-readable answer instead of prose, pass a schema as `response_format` and the answer is guaranteed to conform to it:

```python Python theme={null}
from pydantic import BaseModel

class OnboardingStatus(BaseModel):
    completed: bool
    remaining_steps: list[str]

status = peer.chat(
    "Has the user completed the onboarding flow?",
    response_format=OnboardingStatus,
)
# status is a parsed OnboardingStatus instance
```

```typescript TypeScript theme={null}
import { z } from 'zod';

const OnboardingStatus = z.object({
  completed: z.boolean(),
  remainingSteps: z.array(z.string()),
});

const status = await peer.chat(
  "Has the user completed the onboarding flow?",
  { responseFormat: OnboardingStatus },
);
// status is typed as z.infer<typeof OnboardingStatus>
```

The agent runs its full reasoning loop either way — only the final answer is formatted to your schema. See [Structured Outputs](https://honcho.dev/docs/v3/documentation/features/advanced/structured-outputs.md) for the supported schema subset, streaming behavior, and best practices.

## Evidence

Pass `include_evidence` to get back the conclusions and messages the agent read while answering, alongside the tools it called:

```python Python theme={null}
result = peer.chat("What coffee does this user prefer?", include_evidence=True)

print(result.content)
for conclusion in result.evidence.conclusions:
    print(conclusion.id, conclusion.content)
```

```typescript TypeScript theme={null}
const { content, evidence } = await peer.chat(
  "What coffee does this user prefer?",
  { includeEvidence: true }
);
```

Evidence is collated from what the agent read rather than reported by the model, so it lists everything that was available to the answer rather than only what the answer used. See [Evidence](https://honcho.dev/docs/v3/documentation/features/advanced/evidence.md) for the full shape, streaming behavior, and what the trade-off costs you.

## Workspace Chat

`honcho.chat()` asks a question of the whole workspace. There is no observer
peer and no `target`: the agent orients itself with workspace stats and the
most active peers, works out which peers are relevant to the question, and then
reads their memory pair by pair.

### When to Use It

Reach for workspace chat when the question is about more than one peer, or when
you don't know which peer holds the answer:

* "What themes come up across all users this week?"
* "Which peers have mentioned the billing migration?"
* "Where do Alice and Bob disagree?"
* "What does this workspace know about deployment incidents?"

Stay with `peer.chat()` when you need a perspective (what one peer knows about
another), when you're personalizing for a single user, or when the caller only
holds a peer-scoped key.

### Asking the Workspace

`chat()` lives on the client, not on a peer:

```python Python theme={null}
from honcho import Honcho

honcho = Honcho(workspace_id="my-app")

answer = honcho.chat("What themes appear across all peers this week?")
print(answer)
# "Three themes recur: onboarding friction (alice, dana), ..."
```

```typescript TypeScript theme={null}
import { Honcho } from '@honcho-ai/sdk';

const honcho = new Honcho({ workspaceId: "my-app" });

const answer = await honcho.chat("What themes appear across all peers this week?");
console.log(answer);
```

```bash cURL theme={null}
curl -X POST "$HONCHO_URL/v3/workspaces/my-app/chat" \
  -H "Authorization: Bearer $HONCHO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query": "What themes appear across all peers this week?", "reasoning_level": "low"}'
```

The response body is `{"content": "..."}`, or `{"content": null}` when nothing
relevant was found. The SDKs return the string directly (`None` / `null` for no
answer).

### Narrowing Recall

Two options narrow what the agent can read. They are mutually exclusive.

**`session`** (`session_id` on the REST body) narrows message tools to one
session. Conclusion recall is unaffected.

```python Python theme={null}
answer = honcho.chat("What was decided in this thread?", session=session.id)
```

```typescript TypeScript theme={null}
const answer = await honcho.chat("What was decided in this thread?", { session: session.id });
```

**`scope`** restricts recall to the union of the named
[scopes](https://honcho.dev/docs/v3/documentation/features/advanced/scopes.md)' member sessions. On
workspace chat this is *always* the allowlist arm, even for a single name,
because there is no observer to swap. A scope with no member sessions recalls
nothing rather than everything.

```python Python theme={null}
answer = honcho.chat("What came up in therapy-related sessions?", scope="therapy")
answer = honcho.chat("What came up at intake?", scope=["therapy", "intake"])
```

```typescript TypeScript theme={null}
const answer = await honcho.chat("What came up in therapy-related sessions?", { scope: "therapy" });
const both = await honcho.chat("What came up at intake?", { scope: ["therapy", "intake"] });
```

Workspace chat does not accept `filters` or `target`.

### Streaming

Use `chat_stream` / `chatStream` to receive the answer as a stream. The stream
yields text chunks (usually one, as for peer chat); the REST endpoint sends
`text/event-stream` when `stream` is `true`.

```python Python theme={null}
for chunk in honcho.chat_stream("Summarize the open disagreements between peers"):
    print(chunk, end="", flush=True)
```

```typescript TypeScript theme={null}
const stream = await honcho.chatStream("Summarize the open disagreements between peers");
for await (const chunk of stream) {
  process.stdout.write(chunk);
}
```

### Workspace Structured Outputs

`response_format` works the same way as on peer chat. In Python, passing a
Pydantic model returns a parsed instance; passing a raw JSON Schema returns a
JSON string. The TypeScript client accepts a JSON Schema object and returns the
JSON string for you to parse.

```python Python theme={null}
from pydantic import BaseModel

class Theme(BaseModel):
    name: str
    peers: list[str]

class Themes(BaseModel):
    themes: list[Theme]

result = honcho.chat("What themes recur across peers?", response_format=Themes)
# result is a Themes instance (or None)
```

```typescript TypeScript theme={null}
const raw = await honcho.chat("What themes recur across peers?", {
  responseFormat: {
    type: "object",
    properties: {
      themes: {
        type: "array",
        items: {
          type: "object",
          properties: { name: { type: "string" }, peers: { type: "array", items: { type: "string" } } },
          required: ["name", "peers"],
        },
      },
    },
    required: ["themes"],
  },
});
const result = raw ? JSON.parse(raw) : null;
```

### How Workspace Chat Answers

When you call `honcho.chat(query)`:

1. Honcho prefetches an orientation overview: workspace stats, the most active peers, and their peer cards. This is a routing aid, not the corpus.
2. The agent is required to make at least one tool call before answering, so the overview alone is never mistaken for the whole workspace.
3. Message search runs workspace-wide and reveals which peers discussed a topic. Conclusion search stays pair-scoped: the agent names an `observer` and `observed` per call, and results come back attributed as `[observer->observed]`.
4. The agent synthesizes a grounded answer, citing which peers the evidence came from.

Keeping conclusion search pair-scoped avoids diluting retrieval with a
workspace-flat top-k, and matches how memory is stored: one collection per
`(observer, observed)` pair.

### Authentication

Workspace chat requires a workspace- or admin-level key. Peer- and
session-scoped keys are rejected with `401` regardless of the other options.
See [Manage API Keys](https://honcho.dev/docs/v3/documentation/reference/platform.md#3-manage-api-keys) for scoping
rules.

### Peer Chat vs Workspace Chat

| | `peer.chat()` | `honcho.chat()` |
| - | - | - |
| Perspective | Observer peer, optional `target` | None, whole workspace |
| `session` / `session_id` | Yes | Yes (message tools only) |
| `scope` | Single name swaps the observer; a list is an allowlist | Always an allowlist, even a single name |
| `filters` (session allowlist) | Yes | No |
| `reasoning_level`, `response_format`, streaming | Yes | Yes |
| Key required | Peer, workspace, or admin | Workspace or admin |
| CLI / Explore UI | `honcho peer chat`, Explore Chat tab | API and SDK only |

## Integration Patterns

### Dynamic Prompt Enhancement

Let your LLM decide what it needs to know, then inject that context into the next generation:

```python Python theme={null}
# Your LLM generates a query based on the conversation
llm_query = "Does the user prefer formal or casual communication?"

# Get answer from Honcho
context = peer.chat(llm_query)

# Add to your next LLM prompt
enhanced_prompt = f"""
Context about the user: {context}

User message: {user_input}

Respond appropriately based on the context.
"""
```

```typescript TypeScript theme={null}
// Your LLM generates a query based on the conversation
const llmQuery = "Does the user prefer formal or casual communication?";

// Get answer from Honcho
const context = await peer.chat(llmQuery);

// Add to your next LLM prompt
const enhancedPrompt = `
Context about the user: ${context}

User message: ${userInput}

Respond appropriately based on the context.
`;
```

### Conditional Logic

Use chat endpoint responses to drive application logic:

```python Python theme={null}
# Check if user has completed onboarding
onboarding_status = peer.chat("Has the user completed the onboarding flow?")

if "yes" in onboarding_status.lower():
    # Show main interface
    pass
else:
    # Show onboarding
    pass
```

```typescript TypeScript theme={null}
// Check if user has completed onboarding
const onboardingStatus = await peer.chat("Has the user completed the onboarding flow?");

if (onboardingStatus.toLowerCase().includes("yes")) {
    // Show main interface
} else {
    // Show onboarding
}
```

### Preference Extraction

Extract specific preferences for personalization:

```python Python theme={null}
# Get multiple insights
tone = peer.chat("What tone does the user prefer in responses?")
expertise = peer.chat("What is the user's level of technical expertise?")
goals = peer.chat("What are the user's main goals or objectives?")

# Use these to configure your agent's behavior
```

```typescript TypeScript theme={null}
// Get multiple insights
const tone = await peer.chat("What tone does the user prefer in responses?");
const expertise = await peer.chat("What is the user's level of technical expertise?");
const goals = await peer.chat("What are the user's main goals or objectives?");

// Use these to configure your agent's behavior
```

### Team Digests

Use workspace chat where the unit of interest is the group rather than one user:

```python Python theme={null}
digest = honcho.chat(
    "Summarize what each peer worked on this week and any blockers they raised.",
    reasoning_level="medium",
)
```

```typescript TypeScript theme={null}
const digest = await honcho.chat(
  "Summarize what each peer worked on this week and any blockers they raised.",
  { reasoningLevel: "medium" },
);
```

## How Honcho Answers

When you call `peer.chat(query)`:

1. Honcho searches through the peer's peer card and representation--conclusions drawn from reasoning over their messages
2. Retrieves conclusions semantically relevant to your query
3. Combines them with segments of source messages, if needed, to gather more context
4. Synthesizes them into a coherent natural language response to your query

Honcho [reasoning](https://honcho.dev/docs/v3/documentation/core-concepts/reasoning.md) runs continuously in the background, processing new messages and updating representations. The chat endpoint always has access to Honcho's latest conclusions about the peer. Workspace chat follows the same loop with a different starting point; see [How Workspace Chat Answers](#how-workspace-chat-answers).

## Best Practices

### Ask specific questions

Instead of "Tell me about the user", ask "What communication style does the user prefer?" You'll get more actionable answers.

### Let your LLM formulate queries

The chat endpoint shines when your LLM decides what it needs to know. This creates dynamic, context-aware personalization. An excellent way to achieve this, if building an agent, is to give access to the Honcho chat endpoint as just another tool.

### Use for runtime decisions

Don't just use chat for LLM prompts - use it to drive application logic, routing, and feature flags based on user behavior.

### Pick the right entry point

Peer chat for one peer's perspective, workspace chat for questions that span peers. Asking `honcho.chat()` about a single known peer works, but costs a routing step that `peer.chat()` skips.

### Combine with context()

Use `context()` for conversation context and `peer.chat()` for specific insights. They complement each other.

For more ideas on using the chat endpoint, see our [guides](https://honcho.dev/docs/v3/guides/overview.md).


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
