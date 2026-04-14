<!-- Source: https://docs.honcho.dev/v3/documentation/introduction/overview -->

# Overview

## What is Honcho?

Honcho is an open source memory library with a managed service for building stateful agents. It's designed to enable agents to build and maintain state about any entity -- users, agents, groups, ideas, and more.

## Core Problem It Solves

The documentation outlines a common development cycle where agents initially work well but struggle with context retention across sessions. Developers typically respond by building RAG solutions, only to discover the real issue isn't engineering -- it's incomplete information extraction from existing data.

## Key Architecture Components

Honcho uses four interconnected storage primitives:

1. **Workspaces** - Top-level isolation containers for different applications or environments
2. **Peers** - Entities that persist and change over time (users, agents, objects)
3. **Sessions** - Interaction threads between peers with temporal boundaries
4. **Messages** - Data units that trigger reasoning (conversations, events, documents)

## The Reasoning Advantage

Unlike traditional RAG systems that retrieve explicitly stated information, Honcho employs formal logical reasoning to generate conclusions about each peer. This approach surfaces implicit connections, handles contradictory information, and enables predictions under uncertainty -- capabilities static retrieval cannot match.

## Getting Started

New users can obtain an API key at https://app.honcho.dev or access the quickstart guide to build their first stateful agent.
