<!-- Source: https://docs.honcho.dev/v3/documentation/features/advanced/peer-card -->

# Peer Card

## Overview

A peer card is a quick-reference biographical profile containing stable facts about a peer -- name, occupation, preferences, and standing instructions. It complements the full representation by capturing essential grounding information that persists across sessions.

## Content Categories

Peer cards store durable biographical information across six categories:

- **Identity**: Name, age, location
- **Occupation**: Job titles and employers
- **Relationships**: Family, connections, associations
- **Instructions**: Behavioral directives prefixed with "INSTRUCTION:"
- **Preferences**: Communication style preferences marked "PREFERENCE:"
- **Traits**: Personality characteristics marked "TRAIT:"

Information should be stable and cross-contextual. Transient data like current mood or recent topics belong in conclusions and summaries instead.

## Creation Methods

**Automatic Creation**: The dreaming process extracts biographical facts from existing conclusions, automatically populating peer cards without manual intervention.

**Manual Creation**: You can directly set peer card facts via SDK or API, useful for bootstrapping known information or correcting discovered facts.

## Directional Peer Cards

When `observe_others` is enabled, peers can maintain separate cards for each observed peer. Alice's card for Bob remains distinct from Honcho's peer card for Bob, using the `target` parameter to differentiate.

## Implementation and Usage

Peer cards are injected into system prompts during chat operations and included in context retrieval when a `peer_target` is specified. The dreaming process reads existing cards before consolidation and updates them with newly discovered facts.

## Constraints

- Maximum 40 facts per card
- Data type: list of strings (one fact per string)
- Manual updates replace the entire card, not merge with existing data

## Configuration

Control through the configuration hierarchy:

```json
{
  "peer_card": {
    "use": true,
    "create": true
  }
}
```

Settings apply at workspace, session, or message level.

## Best Practices

1. Bootstrap with known facts immediately at signup
2. Use structured prefixes (INSTRUCTION:, PREFERENCE:, TRAIT:)
3. Keep facts atomic -- one fact per string
4. Allow dreaming to handle ongoing updates automatically
5. Use manual `set_card()` only for corrections
