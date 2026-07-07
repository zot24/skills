> Source: https://flueframework.com/docs/guide/subagents

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Subagents


Last updated May 29, 2026 <a href="/docs/guide/subagents/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


Subagents let an agent delegate a piece of work to a named specialist while it continues to own the interaction. Use them when an agent should ask another configured role to research, classify, or review something and then work with the returned answer.

A subagent is an [agent profile](/docs/guide/building-agents/#agent-profiles) declared on another agent. Delegated work runs in a separate child session, rather than continuing the parent agent’s conversation history. The subagent is not a separately addressable agent endpoint.

## Define a subagent

Create a named profile with `defineAgentProfile(...)`, then provide it through an agent’s `subagents` configuration:

``` astro-code
import { defineAgent, defineAgentProfile } from '@flue/runtime';

const issueClassifier = defineAgentProfile({
  name: 'issue_classifier',
  description: 'Classifies support issues for routing.',
  instructions: 'Return the likely product area and urgency for the reported issue.',
});

export default defineAgent(() => ({
  model: 'anthropic/claude-sonnet-4-6',
  instructions: 'Help resolve support requests. Delegate classification when it helps your answer.',
  subagents: [issueClassifier],
}));
```

In this example, `support-assistant` can delegate work to `issue_classifier`. The profile configures the specialist used for delegated tasks; it does not define another agent at `/agents/issue_classifier/:id`.

The profile’s `description` is shown to the parent model alongside the subagent’s name, so write it as delegation guidance: a short statement of what the subagent is good for.

## Delegate work

An agent with configured subagents can decide to delegate while answering a prompt. Flue gives the agent a built-in `task` capability that starts a child session for the selected subagent and returns that child’s answer to the parent agent.

The child session receives the delegated request and its own configured context, not the parent’s existing conversation transcript. When persistence is configured, its retained history remains owned by the parent session rather than becoming an ordinary named session. See [Database](/docs/guide/database/) for persistence setup. When a subagent works in a configured sandbox, it uses that same sandbox boundary as its parent. See [Sandboxes](/docs/guide/sandboxes/) for controlling workspace and command access.

## Configuration inheritance

A subagent profile is self-contained. The capability fields that define what the subagent is and can do apply only when the profile declares them — omitting one means the subagent has none, never the parent’s. Environment fields fall back to the parent’s values as runtime defaults.

| Field                                          | Behavior                                                                                                                                          |
|------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| `instructions`, `tools`, `skills`, `subagents` | Profile-owned. Only the profile’s own declarations apply; an omitted field means none. The parent’s values never flow into the delegated session. |
| `model`, `thinkingLevel`, `compaction`         | Inherits as a default. The profile’s own value wins when declared; an omitted field uses the parent’s value.                                      |
| `durability`                                   | Rejected. Delegated task sessions run inside the parent operation, so declaring `durability` on a subagent profile is a definition-time error.    |

A `task()` call without an `agent` name is not a subagent delegation: the child session reuses the parent’s full configuration in a fresh context.

## Use subagents in workflows

A workflow can choose delegation directly when application logic requires work from a particular subagent. Call `session.task(...)` with the name of a declared subagent, and provide `result` when the workflow needs validated data:

``` astro-code
import { defineAgent, defineWorkflow, defineAgentProfile } from '@flue/runtime';
import * as v from 'valibot';

const reviewer = defineAgentProfile({
  name: 'reviewer',
  instructions: 'Review the proposed change and identify concrete correctness risks.',
});

const coordinator = defineAgent(() => ({
  model: 'anthropic/claude-sonnet-4-6',
  subagents: [reviewer],
}));

const Review = v.object({
  summary: v.string(),
  risks: v.array(v.string()),
});

export default defineWorkflow({
  agent: coordinator,
  input: v.object({ change: v.string() }),
  output: Review,

  async run({ harness, input }) {
    const response = await (
      await harness.session()
    ).task(input.change, {
      agent: 'reviewer',
      result: Review,
    });
    return response.data;
  },
});
```

Here, the workflow chooses `reviewer` rather than leaving delegation to the parent agent. See [Workflows](/docs/guide/workflows/) for workflow orchestration and the [Agent API](/docs/api/agent-api/) for task options and result types.

## Next steps

- [Agents](/docs/guide/building-agents/) — create agents and reusable agent profiles.
- [Workflows](/docs/guide/workflows/) — orchestrate finite agent work in application code.
- [Tools](/docs/guide/tools/) and [Skills](/docs/guide/skills/) — give an agent profile capabilities and reusable instructions.
- [Sandboxes](/docs/guide/sandboxes/) — control the workspace available during delegated work.
- [Agent API](/docs/api/agent-api/) — look up `session.task(...)` options and results.
- [Observability](/docs/guide/observability/) — inspect delegated activity alongside other agent work.


## Docs Navigation

Current page: [Subagents](/docs/guide/subagents/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


