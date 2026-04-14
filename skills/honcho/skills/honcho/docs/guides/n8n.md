<!-- Source: https://docs.honcho.dev/v3/guides/integrations/n8n -->

# n8n Integration

## Overview

Honcho integrates with n8n through HTTP Request nodes for persistent memory across automation workflows and agents. Uses bearer token authentication with the Honcho API.

## Key Difference from n8n Memory

n8n's "memory" nodes are vector databases for RAG-style retrieval. Honcho offers richer context and reasoning -- it builds understanding of users over time, not just similarity search.

## Prerequisites

- n8n instance (self-hosted or cloud)
- Honcho API key from https://app.honcho.dev
- Understanding of Honcho's core concepts: workspaces, sessions, peers, and messages

## HTTP Request Node Setup

1. Add HTTP Request node from Core nodes
2. Set Method (POST for creation, GET for retrieval)
3. Set URL to appropriate Honcho API endpoint
4. Select Generic Credential Type > Bearer Auth
5. Create new credential with Honcho API key
6. Check "Send Body" and select JSON content type

## Workflow Structure

### Part 1: Data Ingestion
Manual trigger -> Workspace -> Session -> Gmail extraction -> Peer creation -> Session membership -> Message creation

### Part 2: AI Chat Interface
Chat trigger -> Agent with LLM and Honcho tools

## Core API Endpoints Used

**Create Workspace:** POST `https://api.honcho.dev/v3/workspaces`
```json
{ "id": "email-test", "metadata": {} }
```

**Create Session:** POST `https://api.honcho.dev/v3/workspaces/{workspace_id}/sessions`
```json
{ "id": "new_session" }
```

**Create Peers:** POST `https://api.honcho.dev/v3/workspaces/{workspace_id}/peers`
```json
{ "id": "peer-name" }
```

**Add Peers to Session:** POST `https://api.honcho.dev/v3/workspaces/{workspace_id}/sessions/{session_id}/peers`

**Create Messages:** POST `https://api.honcho.dev/v3/workspaces/{workspace_id}/sessions/{session_id}/messages/`

**Get Context:** GET `https://api.honcho.dev/v3/workspaces/{workspace_id}/sessions/{session_id}/context`

## Quick Setup Tip

The fastest way to configure any Honcho endpoint is to copy the curl command directly from the app.honcho.dev API playground, then use n8n's import cURL feature.

## Enhancement Ideas

- Replace hardcoded IDs with n8n variables
- Load multiple messages via Gmail "Get All" operation
- Add Gmail Trigger for real-time email ingestion
- Implement error handling with notifications
- Extend to other data sources (Slack, CRM, support tickets)
