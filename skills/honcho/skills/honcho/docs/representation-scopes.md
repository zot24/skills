<!-- Source: https://docs.honcho.dev/v3/documentation/features/advanced/representation-scopes -->

# Representation Scopes

## Overview

Honcho enables control over perspective-based representations when reasoning is enabled. The system supports three core concepts: default behavior where Honcho reasons across all messages, observer-observed models where peers form directional representations, and targeted querying.

## Default Behavior

By default with `observe_me=true`, Honcho forms one representation per peer, reasoning over every message written to that peer across all sessions. Users retrieve conclusions via the `representation()` method:

```python
alice_rep = session.representation("alice")
```

## Observer-Observed Model

When `observe_others=true` is enabled at the session level, peers develop directional representations of other participants. The system stores these as (observer, observed) pairs:

| Observer | Observed | Representation |
|----------|----------|---|
| alice | alice | Honcho's view of Alice (all sessions) |
| alice | bob | Alice's view of Bob (Alice's sessions only) |
| alice | charlie | Alice's view of Charlie (Alice's sessions only) |

This segmentation means different agents possess knowledge only from their actual interactions, enabling sophisticated information asymmetry scenarios.

## Querying with Target

The `target` parameter retrieves perspective-specific representations:

```python
honcho_view = session.representation("alice")
bob_view = session.representation("alice", target="bob")
```

The same parameter works with chat endpoints to query using conclusions from specific perspectives.

## Use Cases

**Directional representations suit:** multi-agent games where NPCs only know witnessed information, information asymmetry scenarios, perspective-dependent agents, and privacy-segmented systems.

**Default behavior suffices for:** single-user applications, centralized knowledge systems, and simple chatbots.

## Implementation Notes

Representations update automatically through the reasoning pipeline when messages are created and relevant peer configurations are active. Critically, Peer Join Order Matters -- reasoning tasks schedule based on which peers exist when messages arrive. Peers joining later won't receive retroactive reasoning for prior conversation history.

Semantic filtering supports `search_query`, `search_top_k`, `search_max_distance`, `include_most_frequent`, and `max_conclusions` parameters for refined conclusion retrieval.
