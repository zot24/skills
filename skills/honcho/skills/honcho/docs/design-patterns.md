<!-- Source: https://docs.honcho.dev/v3/documentation/core-concepts/design-patterns -->

# Design Patterns

Design your workspace, peers, and sessions for common application patterns. For users with coding agents (Claude Code, Cursor, etc.), the `/honcho-integration` skill provides interactive guidance through these design decisions.

## Quick Reference Table

| Decision | Recommendation |
|----------|----------------|
| Workspace quantity | One per application; separate per-agent if hard data isolation needed |
| Peer selection | Any entity requiring Honcho reasoning -- users, agents, NPCs, students, customers |
| Session scope | Flexible approach -- per-conversation, per-channel, per-scene, etc. |
| `observe_me: false` setting | Yes, for deterministic peers like assistants or bots without learning needs |
| `observe_others` requirement | Only when different peers need distinct views of same participant; most apps use default (false) |

## Workspace Design

Workspaces serve as top-level containers with complete isolation of peers, sessions, messages, and reasoning from other workspaces.

**Deployment patterns:**

| Pattern | Application |
|---------|-------------|
| Single workspace | Standard for most products in one environment |
| Per-tenant | Multi-tenant SaaS requiring complete customer data separation |

The SDK creates a workspace named `default` if no `workspace_id` is specified.

## Peer Design

A peer represents any entity participating in sessions, with observation settings controlling reasoning scope.

**Peer characteristics:**

- Participates in sessions (users, agents, characters, NPCs)
- Persists across multiple sessions
- Changes over time (preferences, knowledge) or produces storable messages

**Naming conventions using code examples:**

Platform-prefixed identifiers for multi-channel applications:
```python
peer = honcho.peer("discord_491827364")
peer = honcho.peer("slack_U04ABCDEF")
```

Application-specific user IDs:
```python
peer = honcho.peer("user_abc123")
```

Descriptive names for assistants:
```python
peer = honcho.peer("assistant")
peer = honcho.peer("dungeon-master")
```

**Peer Cards for multiple identities:**

```python
peer = honcho.peer("user_abc123")
peer.set_card([
    "Name: Alice. Also known as 'Ali' and 'A'.",
    "College student, prefers casual tone.",
])
```

**Disabling reasoning for deterministic peers:**

```python
from honcho.api_types import PeerConfig

assistant = honcho.peer("assistant", configuration=PeerConfig(observe_me=False))
user = honcho.peer("user-123", configuration=PeerConfig(observe_me=True))
```

## Session Design

Sessions define temporal interaction boundaries, affecting summary generation and context retrieval.

**Session scoping patterns:**

| Pattern | Scope | Example |
|---------|-------|---------|
| Per-conversation | Each new chat thread | ChatGPT-style with separate threads |
| Per-channel | Persistent channel or room | Discord channel, Slack thread |
| Per-interaction | Bounded task or encounter | Support ticket, game encounter |
| Per-import | Batch external data | Email or document import for single peer |

**Session lifecycle decisions:**

- Create new sessions when context resets (new conversation, topic change, new day)
- Reuse sessions when context should accumulate (ongoing channels, persistent threads)

## Application Patterns

### AI Companions

Assistants remembering users across sessions and platforms. The Honcho OpenClaw plugin demonstrates this pattern across WhatsApp, Telegram, Discord, and Slack.

**Implementation example:**

```python
from honcho import Honcho
from honcho.api_types import PeerConfig, SessionPeerConfig

honcho = Honcho(workspace_id="my-companion-app")
owner = honcho.peer("owner")
agent = honcho.peer("agent-main", configuration=PeerConfig(observe_me=False))

session = honcho.session("general-discord")
session.add_peers([
    (owner, SessionPeerConfig(observe_me=True, observe_others=False)),
    (agent, SessionPeerConfig(observe_me=True, observe_others=True)),
])

session.add_messages([
    owner.message("I've been stressed about the move to Portland next month"),
    agent.message("Moving is a big deal. What's weighing on you the most?"),
    owner.message("Honestly just leaving my friend group behind"),
])

response = owner.chat("What's going on in this user's life right now?")
```

**Key architectural decisions:**

- Session keys combine thread and platform (e.g., `general-discord`, `general-telegram`) for separate histories with shared user memory
- Dynamic agent peers with workspace-level mapping enable agent renaming via metadata lookup
- Subagent hierarchy allows parent agents to join child sessions as silent observers
- Asymmetric observation: owners have default scope while agents see both perspectives
- Subagents receive lighter context (peer card only, no session summaries)

See the OpenClaw integration guide for complete plugin setup.

### Coding Agents

Coding agents maintain state across terminal restarts, editor switches, and project transitions. The Claude Code plugin exemplifies this pattern.

**Implementation example:**

```python
from honcho import Honcho
from honcho.api_types import PeerConfig

honcho = Honcho(workspace_id="claude_code")
developer = honcho.peer("user")
agent = honcho.peer("claude", configuration=PeerConfig(observe_me=False))

session = honcho.session("user-honcho-repo")
session.add_peers([developer, agent])

session.add_messages([
    developer.message("refactor the auth module to use dependency injection"),
    agent.message("I'll extract the auth dependencies into a provider pattern..."),
    developer.message("actually let's keep it simpler, just pass the config directly"),
])

context = developer.chat("What are this developer's preferences for code architecture?")
```

**Key architectural decisions:**

- One workspace per tool (Claude Code and Cursor separate, with optional cross-linking)
- Asymmetric peers: developer observed for memory formation, agent not observed but messages stored
- Session-per-directory by default with peer-prefixed naming to prevent developer collisions
- Filter agent messages to exclude trivial tool output, retaining substantive explanations
- Import external data via single-peer sessions for READMEs, architecture docs, or commit history

See the Claude Code integration guide for complete plugin setup.

### Games

Games require multi-peer scenarios where information asymmetry matters. NPCs should only know witnessed information, not full game state.

**Implementation example:**

```python
from honcho import Honcho
from honcho.api_types import SessionPeerConfig

honcho = Honcho(workspace_id="my-rpg")

player = honcho.peer("player-one")
merchant = honcho.peer("merchant-grim")
thief = honcho.peer("thief-shadow")

tavern = honcho.session("tavern-scene")
tavern.add_peers([player, merchant])
tavern.set_peer_configuration(merchant, SessionPeerConfig(observe_others=True))

tavern.add_messages([
    player.message("I'm looking for a rare gemstone. Money is no object."),
    merchant.message("I may know of one... but it won't come cheap."),
])

alley = honcho.session("dark-alley")
alley.add_peers([player, thief])
alley.set_peer_configuration(thief, SessionPeerConfig(observe_others=True))

alley.add_messages([
    player.message("I need that gemstone stolen from the merchant. Quietly."),
    thief.message("Consider it done. Half up front."),
])

merchant_view = merchant.chat("What do I know about this player?", target="player-one")
thief_view = thief.chat("What do I know about this player?", target="player-one")
full_view = player.chat("What is this player up to?")
```

**Key architectural decisions:**

- Every character (player, NPC) becomes a separate peer
- `observe_others: true` enables NPCs to build representations based exclusively on witnessed interactions
- Session-per-scene or session-per-encounter for interaction-specific context scoping
- Use `target` parameter when querying for specific NPC perspectives rather than omniscient views
- Reference Representation Scopes documentation for complete details

## Common Mistakes

1. **`observe_me` left enabled for assistants** -- Wastes reasoning compute on controllable, deterministic behavior
2. **Failing to store messages** -- Honcho reasons about messages asynchronously. If you don't call `add_messages()`, there's nothing to reason about
3. **Separate workspace per user** -- Use peers within single workspace instead; workspaces isolate applications, not users
4. **Excessive tiny sessions** -- Summaries and `session.context()` scope to single sessions; fragmenting continuous conversations breaks context flow
5. **Blocking on processing** -- Messages process asynchronously; avoid polling or waiting before continuing application flow

## Next Steps

- **Get Context**: Retrieve formatted context from sessions for your LLM
- **Chat Endpoint**: Query Honcho about peers using natural language
- **Reasoning Configuration**: Fine-tune what gets reasoned about and how
- **Representation Scopes**: Directional representations for multi-peer scenarios
