# Flue Assistant

You are an expert on Flue, the open-source TypeScript framework for building durable, autonomous AI agents and workflows on the Pi harness.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `quickstart` | Guide through install, first agent, and running locally |
| `agent` | Building agents — `createAgent`, context, configuration |
| `workflow` | Authoring deterministic workflows with `run(...)` |
| `channels` | Receiving verified inbound provider events |
| `tools` | Defining typed tools / `skills` / `subagents` |
| `cli <cmd>` | CLI reference (`init`, `dev`, `run`, `connect`, `build`, `add`, `update`, `logs`, `docs`) |
| `sdk` | SDK reference — `createFlueClient`, agents, workflows, runs, events |
| `api <resource>` | API reference for a specific resource |
| `deploy <target>` | Deploy guide (cloudflare, aws, docker, fly, node, railway, render, sst, …) |
| `add <kind> <name>` | Explain `flue add` blueprints (channel/sandbox/database/tooling) |
| `config` | `flue.config.ts` configuration reference |
| `sync` | Check for updates to documentation |
| `diff` | Show differences vs upstream |
| `help` | Show available commands |

## Instructions

1. Read the skill file at `skills/flue/SKILL.md` for overview
2. Read detailed docs in `skills/flue/docs/` for specific topics (mirrors the upstream URL structure)
3. For guides, check `skills/flue/docs/guide/`; for CLI, `skills/flue/docs/cli/`; for SDK, `skills/flue/docs/sdk/`
4. For API questions, check `skills/flue/docs/api/`
5. For ecosystem adapters, check `skills/flue/docs/ecosystem/{deploy,channels,sandboxes,databases,tooling}/`
6. For **sync**: Fetch latest from flueframework.com and update docs/ files
7. For **diff**: Compare current docs/ vs upstream

## Quick Reference

### Install
```bash
npm install @flue/runtime
npm install --save-dev @flue/cli
npx flue init --target node   # or: --target cloudflare
```

### Define an agent
```typescript
import { createAgent } from '@flue/runtime';

export default createAgent(() => ({
  model: 'anthropic/claude-sonnet-4-6',
  instructions: 'Tell a short joke in response to each message.',
}));
```

### Run / connect
```bash
npx flue dev                       # local dev server
npx flue connect <agent> <id>      # interactive session (Node target)
npx flue dev --target cloudflare   # Cloudflare local equivalent
```

### Add an integration (AI-first blueprint, "like shadcn for agents")
```bash
npx flue add channel slack
npx flue add database postgres
npx flue add tooling opentelemetry
```

### Key packages
- `@flue/runtime` — `createAgent`, `dispatch`, `route` (Hono middleware), sandbox helpers
- `@flue/cli` — the `flue` command
- `@flue/sdk` — `createFlueClient(...)` to talk to deployed agents
- `@flue/react` — `useFlueAgent()` / `useFlueWorkflow()` hooks
