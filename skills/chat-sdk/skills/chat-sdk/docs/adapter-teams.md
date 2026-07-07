> Source: https://chat-sdk.dev/adapters/official/teams.md

---
title: Microsoft Teams
description: Microsoft Teams adapter with Adaptive Cards and modal support.
tagline: Deploy bots to Microsoft Teams with Adaptive Cards, mentions, and conversation threading.
package: @chat-adapter/teams
---

# Microsoft Teams


## Install


## Quick start


  The adapter auto-detects `TEAMS_APP_ID`, `TEAMS_APP_PASSWORD`, and `TEAMS_APP_TENANT_ID` from the environment.


```typescript title="lib/bot.ts" lineNumbers
import { Chat } from "chat";
import { createTeamsAdapter } from "@chat-adapter/teams";

const bot = new Chat({
  userName: "mybot",
  adapters: {
    teams: createTeamsAdapter({
      appType: "SingleTenant",
    }),
  },
});

bot.onNewMention(async (thread, message) => {
  await thread.post("Hello from Teams!");
});
```

## Configuration


`appId` is required. Exactly one authentication method (`appPassword` or `federated`) must be provided.

## Authentication

The [Teams CLI](https://microsoft.github.io/teams-sdk/cli) handles AAD app registration, client secret generation, bot registration, and Teams channel setup in one command.

### Install the CLI

```bash
npm install -g @microsoft/teams.cli
```

### 1. Create the app

```bash
teams login
teams status
teams app create --name "My Bot" --endpoint "https://your-domain.com/api/webhooks/teams" --env .env
```


  For local development, use a tunnel (e.g. [devtunnel](https://learn.microsoft.com/en-us/azure/developer/dev-tunnels/), ngrok) to expose your local server.


Credentials (`CLIENT_ID`, `CLIENT_SECRET`, `TENANT_ID`) are written to `.env`. Rename them to match the adapter:

```bash
TEAMS_APP_ID=<CLIENT_ID>
TEAMS_APP_PASSWORD=<CLIENT_SECRET>
TEAMS_APP_TENANT_ID=<TENANT_ID>
```

### 2. Install in Teams

Get a direct install link:

```bash
teams app get <appId> --install-link
```

Or download the app package for sideloading and upload via **Apps** then **Manage your apps** then **Upload an app** then **Upload a custom app**.

### 3. Verify

```bash
teams app doctor <appId>
```

### Authentication methods

**Client secret (default)** — provide `appPassword` or set `TEAMS_APP_PASSWORD`:

```typescript
createTeamsAdapter({
  appPassword: "your_app_password_here",
});
```

**Federated (workload identity)** — for environments with managed identities (e.g. AKS, GitHub Actions). Maps to `managedIdentityClientId` in the Teams SDK:

```typescript
createTeamsAdapter({
  federated: {
    clientId: "your_managed_identity_client_id_here",
  },
});
```

## Advanced

### User lookup

The adapter supports looking up user profiles via the Microsoft Graph API. To enable it:

1. Grant the `User.Read.All` **application permission** in your Azure AD app registration.
2. Grant admin consent for the permission.

```typescript
const user = await bot.getUser(message.author);
console.log(user?.email);    // "alice@contoso.com"
console.log(user?.fullName); // "Alice Smith"
```

The adapter caches each user's Azure AD object ID from incoming activities, so `getUser` only works for users who have previously interacted with the bot.

### Message history

Fetching message history requires `TEAMS_APP_TENANT_ID` and the right permissions depending on the conversation type:

| Context    | Permission                  | Type     | Admin consent? |
| ---------- | --------------------------- | -------- | -------------- |
| Channel    | `ChannelMessage.Read.Group` | RSC      | No             |
| Group chat | `ChatMessage.Read.Chat`     | RSC      | No             |
| DM         | `Chat.Read.All`             | Azure AD | Yes            |

RSC permissions are set via the Teams CLI (no admin consent needed):

```bash
teams app rsc add <appId> ChannelMessage.Read.Group --type Application
teams app rsc add <appId> ChatMessage.Read.Chat --type Application
```

For DM message history, RSC is not sufficient. Add `Chat.Read.All` via the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/):

```bash
az ad app permission add \
  --id <appId> \
  --api 00000003-0000-0000-c000-000000000000 \
  --api-permissions 6b7d71aa-70aa-4810-a8d9-5d9fb2830017=Role

az ad app permission admin-consent --id <appId>
```

If your app already owns routing, state, sessions, or workflow execution, use the [low-level Teams APIs](/docs/teams-primitives) instead of the full adapter runtime.

### Receiving all messages

By default, Teams bots only receive messages when directly @-mentioned. The RSC permissions above also enable receiving all messages in channels and group chats as a side effect.

### Troubleshooting

Run `teams app doctor <appId>` to diagnose common issues — bot registration, AAD app health, manifest consistency, and endpoint reachability.

## Feature support


