<!-- Source: https://docs.honcho.dev/v3/documentation/core-concepts/representation -->

# Peer Representations

## Overview

Honcho creates dynamic representations of peers by continuously reasoning about their messages over time. A representation is the collection of reasoning Honcho has done about a peer over time.

## Core Components

Representations consist of three primary artifact types:

**Conclusions** emerge through formal logical reasoning, including deductive, inductive, and abductive approaches. For instance, Honcho might infer that a user frequently mentions work deadlines and rarely mentions hobbies, suggesting they are time-constrained.

**Summaries** compress conversation history into queryable formats, generated automatically at set intervals (short summaries every 20 messages, long summaries every 60 messages by default).

**Peer Cards** store essential biographical details, ensuring baseline information about individuals remains accessible.

## Observation Modes

The system offers two configuration-controlled observation approaches:

- **`observe_me`** (enabled by default): Honcho builds understanding of a peer based on all messages they've sent across all sessions.

- **`observe_others`** (session-level): Peers develop representations of other session participants based only on messages they've observed, creating perspective-specific understandings.

## Strategic Value

This architecture enables stateful agent simulation where different peers maintain distinct, experience-based perspectives. Perspective-based segmentation prevents all agents from being omniscient, preserving authenticity in multi-agent interactions.
