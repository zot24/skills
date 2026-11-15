> Source: https://honcho.dev/docs/v3/guides/integrations/cursor-agent-sdk.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Cursor Agent SDK

> Give agents built with the Cursor Agent SDK a memory of the people they work with

The [Cursor Agent SDK](https://cursor.com/docs/agent-sdk) (`@grok/agent-sdk`) builds agents from a folder of Markdown and TypeScript and runs them locally or on Cursor hosting. Its built-in memory is one journal file that every user of the agent shares. Honcho replaces it with a separate, growing model of each person the agent talks to.

There are two ways to connect them:

| | Mount the Honcho plugin | Record with a hook |
| - | - | - |
| Best for | An agent you use yourself | An agent that serves a team, a Slack workspace or GitHub |
| Who records turns | The model, following the plugin's skills | Your code, after every turn |
| People | One user peer: you | One peer per person |
| Code to write | Three short files | Four short files |

Both need a Honcho API key from [app.honcho.dev](https://app.honcho.dev).

## Option 1: Mount the Honcho plugin

The Honcho plugin for [Cursor](https://honcho.dev/docs/v3/guides/integrations/cursor.md) and [Grok Bot](https://honcho.dev/docs/v3/guides/integrations/grok-bot.md) runs from its MCP server and its skills alone. The Agent SDK mounts a Cursor plugin's skills and MCP servers, so the plugin works unchanged.

**1. Copy the plugin into your project**

```bash theme={null}
git clone --depth 1 https://github.com/plastic-labs/honcho /tmp/honcho
mkdir -p plugins && cp -r /tmp/honcho/integrations/cursor plugins/honcho
```

**2. Mount it**

Mount the plugin as a directory, so you can replace its MCP server in the next step:

```ts bot/extensions/honcho/extension.ts theme={null}
import { cursorPlugin } from "@grok/agent-sdk/extensions";

export default cursorPlugin({ path: "plugins/honcho" });
```

**3. Connect with an API key**

The plugin signs in to Honcho with OAuth. The Agent SDK keeps OAuth tokens on the machine that signed in, so a hosted agent can't use them. Replace the server with one that sends your API key:

```ts bot/extensions/honcho/mcp-connections/honcho.ts theme={null}
import { defineConnection } from "@grok/agent-sdk/connections";

export default defineConnection({
  url: "https://mcp.honcho.dev",
  headers: {
    Authorization: "Bearer ${HONCHO_API_KEY}",
    "X-Honcho-Plugin": "cursor-agent-sdk",
  },
  advertiseTools: true,
});
```

**4. Tell the agent to use it**

Skills load only when the model decides it needs them, and the memory loop must run every turn. Add this to `bot/instructions.md`:

```md theme={null}
## Memory

Honcho is your memory of the user. At the start of every conversation, load the
`honcho__honcho-memory` and `honcho__honcho-grok-bot` skills and follow them:
recall before you answer, and record every turn.
```

If `bot/hooks/memory.ts` and a `## Memory` section from `agent-sdk init` are still there, delete them.

**5. Deploy**

Allow the Honcho MCP host and declare the secret:

```ts bot/agent.ts theme={null}
import { defineAgent } from "@grok/agent-sdk";

export default defineAgent({
  hosting: {
    egressDomains: ["mcp.honcho.dev"],
    secretNames: ["HONCHO_API_KEY"],
  },
});
```

```bash theme={null}
agent-sdk deploy
agent-sdk secret set <agent> HONCHO_API_KEY
```

Locally, export `HONCHO_API_KEY` before `agent-sdk dev`.

Start the agent with `agent-sdk dev` and say hello. On the first conversation the agent runs `honcho-setup` and asks what Honcho should call you. It uses the `cursor` workspace, the same one the plugin uses in the Cursor IDE and Grok Bot, so all three share what they learn about you.

> [!NOTE]
>
> The plugin's rules and lifecycle hooks are not mounted. The plugin does not need them. The trade-off is that the model records each turn itself, so an interrupted turn can go unrecorded. Scheduled and webhook runs have no user to record.

## Option 2: Record with a hook

Here the agent's own code writes every turn to Honcho, and gives the model one tool to ask about the person it is talking to. Each Slack user or GitHub account becomes its own peer.

```bash theme={null}
npm install @honcho-ai/sdk
```

**1. Shared helpers**

Files under `bot/lib/` are shared code, not loaded as agent parts.

```ts bot/lib/honcho.ts theme={null}
import type { SessionInfo } from "@grok/agent-sdk";
import { Honcho } from "@honcho-ai/sdk";

// Both read HONCHO_API_KEY and HONCHO_WORKSPACE_ID. Call them inside a handler:
// hosted secrets are not set yet when modules load.
const defaultHeaders = { "X-Honcho-Plugin": "cursor-agent-sdk" };

// For hooks: a slow hook holds up the next event in its session.
export const honcho = () => new Honcho({ timeout: 5_000, defaultHeaders });

// For recall: a dialectic answer can take a while, and a retry would start another one.
export const honchoRecall = () =>
  new Honcho({ timeout: 60_000, maxRetries: 0, defaultHeaders });

// Honcho ids allow only letters, digits, _ and -.
export const toId = (s: string) => s.replace(/[^A-Za-z0-9_-]/g, "-");

// One peer per person: the Slack user, else the session principal
// (github:<id> on GitHub, the caller on HTTP).
export function userPeerId(session: SessionInfo) {
  const a = session.auth;
  if (a?.attributes?.user_id) return toId(`slack-${a.attributes.team_id ?? "x"}-${a.attributes.user_id}`);
  return toId(a?.principalId ?? "anonymous");
}
```

**2. Record every turn**

Hooks run after each event is recorded, so they never slow the model down.

```ts bot/hooks/honcho.ts theme={null}
import type { HookContext } from "@grok/agent-sdk";
import { defineHook } from "@grok/agent-sdk/hooks";
import { honcho, toId, userPeerId } from "../lib/honcho.js";

async function record(ctx: HookContext, fromAgent: boolean, text: string) {
  if (ctx.session.purpose === "eval") return;
  const client = honcho();
  const [session, peer] = await Promise.all([
    client.session(ctx.session.id),
    fromAgent
      ? client.peer(toId(ctx.agent.name), { configuration: { observeMe: false } })
      : client.peer(userPeerId(ctx.session)),
  ]);
  await session.addMessages([peer.message(text)]);
}

export default defineHook({
  events: {
    "message.received": (e, ctx) => record(ctx, false, e.data.text),
    "turn.completed": async (e, ctx) => {
      if (e.data.result) await record(ctx, true, e.data.result);
    },
  },
});
```

**3. Let the model ask Honcho**

A hook cannot add context before the model runs, so the model asks when it needs to. The tool works out who the user is, so the model never handles peer ids.

```ts bot/tools/recall.ts theme={null}
import { defineTool } from "@grok/agent-sdk/tools";
import { z } from "zod";
import { honchoRecall, userPeerId } from "../lib/honcho.js";

export default defineTool({
  description:
    "Ask Honcho what it knows about the person you are talking to: preferences, past work, decisions. Call it before answering anything that depends on them.",
  inputSchema: z.object({ question: z.string() }),
  async execute({ question }, ctx) {
    const peer = await honchoRecall().peer(userPeerId(ctx.session));
    return (await peer.chat(question)) ?? "Honcho knows nothing about this person yet.";
  },
});
```

Add a line to `bot/instructions.md`, and delete `bot/hooks/memory.ts` and its `## Memory` section if `agent-sdk init` created them:

```md theme={null}
At the start of each conversation, call `recall` to learn about the person you are helping.
```

**4. Deploy**

Allow the Honcho host and declare the secrets:

```ts bot/agent.ts theme={null}
import { defineAgent } from "@grok/agent-sdk";

export default defineAgent({
  hosting: {
    egressDomains: ["api.honcho.dev"],
    secretNames: ["HONCHO_API_KEY", "HONCHO_WORKSPACE_ID"],
  },
});
```

```bash theme={null}
agent-sdk deploy
agent-sdk secret set <agent> HONCHO_API_KEY
agent-sdk secret set <agent> HONCHO_WORKSPACE_ID
```

Locally, export both variables before `agent-sdk dev`.

### How memory is organized

| Honcho | Value |
| - | - |
| Workspace | `HONCHO_WORKSPACE_ID` |
| User peer | `slack-<team>-<user>` on Slack; the session principal elsewhere, such as `github-<id>` |
| Agent peer | the agent's name, not modeled (`observeMe: false`) |
| Session | the Agent SDK session id: one Slack thread, PR conversation or chat |

A Slack thread can include several people, but the Agent SDK tells hooks only who started it. Every message in a thread is recorded under the person who started it.

## Troubleshooting

**Nothing shows up in Honcho.** Run `agent-sdk run --dir . --message "hi"` and look for `hook "honcho" handler for ... threw` in the log. A 401 means `HONCHO_API_KEY` is missing in that environment. On hosting, check `api.honcho.dev` is in `egressDomains`.

**`recall` says Honcho knows nothing.** Honcho reasons in the background, so a new peer has little to show for the first few turns.

## Source

Option 1 uses the plugin in the Honcho monorepo under [`integrations/cursor/`](https://github.com/plastic-labs/honcho/tree/main/integrations/cursor). Issues and pull requests go to [plastic-labs/honcho](https://github.com/plastic-labs/honcho).


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
