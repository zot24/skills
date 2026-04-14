<!-- Source: https://docs.honcho.dev/v3/documentation/core-concepts/architecture -->

# Architecture & Intuition

## Overview

Honcho functions as memory infrastructure that continuously evaluates information to construct detailed peer representations -- whether those peers are users, agents, or other entities -- across extended timeframes.

## Core Data Model

The system organizes around four primary components:

**Workspaces** serve as top-level isolation containers, enabling separation between different applications, environments, or SaaS customers. Authentication and configuration operate at this scope.

**Peers** represent individual users, agents, or persistent entities. Everything revolves around building and maintaining their representations. Cross-session context allows insights from one interaction to inform another.

**Sessions** function as interaction threads with temporal boundaries. They can involve multiple peers and provide contextual scope for support tickets, meetings, or conversations.

**Messages** constitute the foundational interaction units, ordered chronologically within sessions. The platform accepts diverse content formats beyond typical chat -- emails, documents, files, or system notifications.

## Data Flow Architecture

The system operates asynchronously: messages are written to PostgreSQL while reasoning tasks queue for background processing. Workers generate logic, summaries, and insights stored in vector collections. When context is needed, queries retrieve relevant conclusions alongside recent messages for prompt injection.

## Design Approach

The architecture emphasizes peer-centric memory, continuous reasoning, background async operations, LLM-provider flexibility, and multi-tenant scalability. Notably, the unified paradigm treats humans and agents identically, enabling diverse multi-agent scenarios.

Configuration cascades hierarchically from workspace through peer to session levels, allowing workspace defaults with granular overrides.
