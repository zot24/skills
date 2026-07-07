> Source: https://flueframework.com/docs/guide/building-agents

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Agents


Last updated Jun 22, 2026 <a href="/docs/guide/building-agents/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


Agents are useful when your application needs a model to keep working within a continuing context. This guide covers creating an agent, configuring its capabilities and environment, and exposing it safely to users.

For the underlying mental model, start with [What is an agent?](/docs/concepts/agents/). If you need single-use or background work instead of a continuing agent, see [Workflows](/docs/guide/workflows/).

## Creating a new agent

In a Flue project, an agent is a file in `src/agents/` whose default export is created with `defineAgent(...)`:

``` astro-code
import { defineAgent, type AgentRouteHandler } from '@flue/runtime';

export const description = 'Tells a short joke in response to each message.';

export const route: AgentRouteHandler = async (_c, next) => next();

export default defineAgent(() => ({
  model: 'anthropic/claude-haiku-4-5',
  instructions: 'Tell a short joke in response to each message.',
}));
```

In this example:

- **The filename:** This gives the agent its name: `joke-teller`.
- `description`: This optional static description is collected into the deployment manifest at build time and returned by [`listAgents()`](/docs/api/data-persistence-api/#inspection-primitives). When present, it must be a non-empty string.
- `route`: This exposes the agent over HTTP at `POST /agents/joke-teller/:id`. Event streaming is available at `GET /agents/joke-teller/:id`.
- `defineAgent(...)`: This defines the agent’s behavior and environment.

See [Project Layout](/docs/guide/project-layout/) and [Models & Providers](/docs/guide/models/) for more information.

## Agent configuration

The object returned by `defineAgent(...)` defines the agent’s behavior, capabilities, and environment. For example, a repository reviewer can be given review instructions, reusable Actions, tools and skills, and a local workspace to work within:

``` astro-code
import { defineAgent } from '@flue/runtime';
import { local } from '@flue/runtime/node';
import reviewChecklist from '../skills/review-checklist/SKILL.md' with { type: 'skill' };
import { reviewChange } from '../actions/review-change.ts';
import { repositoryTools } from '../shared/repository-tools.ts';

export default defineAgent(() => ({
  model: 'anthropic/claude-sonnet-4-6',
  instructions: 'Review the requested change and report only findings supported by evidence.',
  cwd: '/srv/repositories/catalog-service',
  actions: [reviewChange],
  tools: repositoryTools,
  skills: [reviewChecklist],
  sandbox: local(),
}));
```

Actions let the model call finite agent-backed operations, tools execute bounded application functions, and skills provide reusable guidance. For more details, see [Actions](/docs/guide/actions/), [Tools](/docs/guide/tools/), [Skills](/docs/guide/skills/), [Sandboxes](/docs/guide/sandboxes/), and [Database](/docs/guide/database/).

### Markdown instructions

Long instructions can live in their own markdown file. Import a `.md` file with the `with { type: 'markdown' }` import attribute and Flue inlines its contents as a string at build time:

``` astro-code
import { defineAgent } from '@flue/runtime';
import instructions from './repository-reviewer.md' with { type: 'markdown' };

export default defineAgent(() => ({
  model: 'anthropic/claude-sonnet-4-6',
  instructions,
}));
```

The attribute is required — a `.md` import without it fails the build. `SKILL.md` files are not plain markdown and must use `with { type: 'skill' }` instead; see [Skills](/docs/guide/skills/).

## Agent ID

Each agent is initialized with an `id`, which identifies the continuing instance of that agent.

``` astro-code
POST /agents/support-assistant/ticket-8472
                               └─────────┘ id
```

It’s up to the developer to decide what `id` means and whether it maps to important application data, such as a user ID, customer support ticket, or GitHub issue. A randomly generated ID can also work.

Flue passes that ID to `defineAgent(...)`, where the application can configure the resources that belong to that instance. For example, a support agent can receive tools scoped to one ticket:

``` astro-code
import { defineAgent, type AgentRouteHandler } from '@flue/runtime';
import { createTicketTools } from '../shared/support-tickets.ts';

export const route: AgentRouteHandler = async (_c, next) => next();

export default defineAgent(({ id }) => ({
  model: 'anthropic/claude-haiku-4-5',
  instructions: 'Help the customer understand and resolve their support ticket.',
  tools: createTicketTools(id),
}));
```

In this example, the agent can access the ticket selected by its `id`, but its tools do not give it access to other tickets. Conversation history belongs in the agent instance’s canonical conversation stream, while durable application data should remain in your own data layer.

## Agent profiles

An agent profile defines reusable behavior and capabilities without creating a public agent or configuring its runtime resources. Use profiles to share an agent’s model, instructions, tools, or skills across your project.

``` astro-code
import { defineAgent, defineAgentProfile } from '@flue/runtime';
import { supportTools } from '../shared/support-tools.ts';

const support = defineAgentProfile({
  model: 'anthropic/claude-haiku-4-5',
  instructions: 'Answer customer support questions clearly and accurately.',
  tools: supportTools,
});

export default defineAgent(() => ({
  profile: support,
}));
```

`defineAgent(...)` can replace profile fields such as the model or instructions, and add tools, skills, or subagents needed for a specific agent.

## Subagents

Subagents are another use for agent profiles: they let an agent delegate focused work to another agent.

``` astro-code
import { defineAgent, defineAgentProfile } from '@flue/runtime';
import { local } from '@flue/runtime/node';

const policyResearcherSubagent = defineAgentProfile({
  name: 'policy_researcher',
  description: 'Finds relevant policy text and quotes the supporting passages.',
  instructions: 'Read the policy workspace and return supporting quotations with file paths.',
});

export default defineAgent(() => ({
  model: 'anthropic/claude-sonnet-4-6',
  instructions: 'Answer policy questions only after delegating source lookup to policy_researcher.',
  sandbox: local(),
  cwd: '/srv/company-policies',
  subagents: [policyResearcherSubagent],
}));
```

Here, `policy-assistant` can use its built-in task capability to delegate source lookup to `policy_researcher` before answering a policy question. The subagent is available to its parent for delegated work. It does not receive its own public endpoint because it is not exported as the agent for that file.

For more information, see [Subagents](/docs/guide/subagents/).

## Interacting with your agent

Users can interact directly with an agent over HTTP. Your application must verify that the caller can access the selected agent `id`.

### HTTP

An agent with a `route` export accepts HTTP messages at `POST /agents/<name>/<id>`. The body contains a message:

``` astro-code
POST /agents/support-assistant/ticket-8472 HTTP/1.1
Authorization: Bearer <token>
Content-Type: application/json

{
  "message": "Can you summarize the open issues in my case?"
}
```

The body may also carry an optional `images` array of `{ "type": "image", "data": "<base64>", "mimeType": "image/png" }` attachments for vision-capable models. See the [Routing API](/docs/api/routing-api/) for the full request contract.

Use the `route` handler to protect direct HTTP access to an agent instance:

``` astro-code
import { defineAgent, type AgentRouteHandler } from '@flue/runtime';
import { authenticate } from '../auth.ts';

export const route: AgentRouteHandler = async (c, next) => {
  const principal = await authenticate(c.req.header('authorization'));
  const ticketId = c.req.param('id');

  if (!principal) return c.json({ error: 'Unauthorized' }, 401);
  if (!principal.supportTicketIds.includes(ticketId)) return c.notFound();

  await next();
};

export default defineAgent(({ id }) => ({
  model: 'anthropic/claude-haiku-4-5',
  instructions: `Help with authorized support ticket ${id}.`,
}));
```

For more information, see [Routing](/docs/guide/routing/) and [SDK](/docs/sdk/overview/).

## `dispatch()`

Use `dispatch(...)` when your application receives an event for an agent asynchronously, such as a webhook, queue message, chat event, or notification. For example, an application route can verify an incoming support-system webhook and dispatch the comment to the agent for that ticket:

``` astro-code
import { dispatch } from '@flue/runtime';
import { flue } from '@flue/runtime/routing';
import { Hono } from 'hono';
import supportAssistant from './agents/support-assistant.ts';
import { verifySupportWebhook } from './shared/support-webhooks.ts';

const app = new Hono();

app.post('/webhooks/support-comments', async (c) => {
  const event = await verifySupportWebhook(c.req.raw);
  const receipt = await dispatch(supportAssistant, {
    id: event.ticketId,
    input: {
      type: 'support.comment.created',
      commentId: event.commentId,
      text: event.text,
    },
  });

  return c.json(receipt, 202);
});

app.route('/', flue());

export default app;
```

Your application chooses the agent instance before dispatching the event. `dispatch(...)` accepts it for asynchronous processing rather than waiting for an agent response. See [Channels](/docs/guide/channels/) for verified provider ingress and application-owned outbound behavior.

## Next steps

- [Agent API](/docs/api/agent-api/) — look up session operations and their results.
- [Actions](/docs/guide/actions/), [Tools](/docs/guide/tools/), [Skills](/docs/guide/skills/), and [Sandboxes](/docs/guide/sandboxes/) — configure what an agent can do and where it works.
- [Subagents](/docs/guide/subagents/) — delegate focused work to specialist profiles.
- [Routing](/docs/guide/routing/) — expose agent HTTP surfaces inside an authenticated application.
- [Workflows](/docs/guide/workflows/) — run single-use or background agent work.
- [Schedules](/docs/guide/schedules/) — invoke finite workflows or dispatch continuing agent input on a schedule.
- [Channels](/docs/guide/channels/) — deliver verified provider events into agent sessions.
- [Observability](/docs/guide/observability/) — inspect agent activity.


## Docs Navigation

Current page: [Agents](/docs/guide/building-agents/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


