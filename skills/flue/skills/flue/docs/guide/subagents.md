> Source: https://flueframework.com/docs/guide/subagents

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Subagents


Last updated Jul 21, 2026<a href="/docs/guide/subagents/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


A **subagent** is a named delegate an agent can hand a focused task to. The delegate works in its own fresh context, with its own instructions and capabilities, and only its final answer returns to the parent’s conversation. This guide covers declaring subagents with `useSubagent`, how delegation works, what a delegate inherits, and the built-in general-purpose delegate.

## Declaring a subagent

Declare a delegate with the `useSubagent()` hook. A subagent definition has three required fields — a `name`, a `description`, and an `agent` function:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { useModel, useSubagent } from &#39;@flue/runtime&#39;;

function Summarizer() {
  return &#39;You summarize support cases in three sentences.&#39;;
}

export function CaseAgent() {
  useModel(&#39;anthropic/claude-sonnet-4-6&#39;);
  useSubagent({
    name: &#39;summarizer&#39;,
    description: &#39;Summarizes one support case.&#39;,
    agent: Summarizer,
  });
  return &#39;Investigate the case. Delegate the summary to the `summarizer` subagent.&#39;;
}</code></pre>
<figcaption><span>src/agents/case-agent.ts</span></figcaption>
</figure>

The `agent` field is an ordinary [agent function](/docs/guide/building-agents/#agent-functions) — it returns the delegate’s instructions, and it can compose the delegate’s capabilities with hooks. `name` and `description` are the delegate’s catalog identity: the description is the line the parent’s model reads when deciding whether to delegate, so write it the way you’d write a good tool description — what the delegate does and when to use it.

`Summarizer` is deliberately *not* exported. A delegate’s agent function is not a registered agent: it has no `useModel()` call, no conversation id, and no HTTP surface — it exists only as a capability of the agent that mounts it. Keep delegate functions unexported inside `'use agent'` modules (the build registers every *exported* capitalized function as a top-level agent), or define them in ordinary modules.

Like tools and skills, subagents may be declared conditionally — mount one only after a phase flag flips, and the runtime announces the roster change to the model (see [Dynamic resources](/docs/reference/agent-api/#dynamic-resources)). Declaring two delegates with the same name in one render throws.

## How delegation works

Delegation is model-driven. Every agent’s tool set includes a framework-owned `task` tool, and the declared delegates are cataloged by name and description in an “Available Agents” section of the system prompt. When the model decides a piece of work fits a delegate, it calls `task` with the delegate’s name and a prompt:

1.  The runtime renders the delegate’s `agent` function — fresh, at delegation time, in its own frame — into the child’s instructions, tools, and skills.
2.  The child runs as a detached session in the parent’s environment: it reads the task prompt, works with its own context window, and runs to completion.
3.  Only the child’s final message returns to the parent, as the `task` tool’s result. Nothing else — not the child’s intermediate reasoning, tool calls, or file reads — enters the parent’s conversation.

The `task` tool is always present, but its required `agent` parameter only resolves against declared delegates — an agent with no `useSubagent()` calls has no valid value to pass and cannot delegate. The model may also pass an optional `cwd` to point the child at a different working directory, and can forward images from the conversation by attachment id.

Two properties follow from the fresh-context design:

- **The prompt is the entire briefing.** The child does not see the parent’s conversation, so a task prompt like “summarize the case” only works if the delegate’s instructions or the prompt itself carry everything the child needs. Your parent instructions should tell the model to delegate with complete, self-contained prompts.
- **Tasks parallelize.** Tool calls in one batch execute in parallel, so the model can launch several tasks at once — five independent checks become five concurrent child sessions, each with its own context window instead of the parent’s.

Delegates can declare delegates of their own with nested `useSubagent()` calls; the runtime caps delegation depth at four levels. Child sessions write their own durable records, so a task interrupted by a crash or redeploy resumes where it left off — see [Delegated tasks](/docs/guide/durability/#delegated-tasks) in the Durability guide.

The model isn’t the only party that can delegate. A [harness tool](/docs/guide/tools/#harness-tools)’s `harness.prompt(...)` conversation — scoped to the tool call — can delegate to the agent’s declared subagents, so application code can require a particular delegate by naming it in the instruction instead of leaving the choice to the model. See the [Harness reference](/docs/reference/agent-api/#harness).

## What a subagent inherits

A delegate is isolated from the parent by default. It inherits the parent’s *environment*:

- the sandbox and its harness tools (read, write, bash, …);
- workspace context discovered from the working directory (`AGENTS.md`, workspace skills);
- the parent’s model and reasoning effort (unless overridden — see below).

It inherits nothing about the parent’s *conversation*: not its history, not its instructions, tools, skills, or subagents, and not its persistent state or initial data.

Everything on the right comes only from the delegate’s own render: the instructions it returns, the tools and skills its agent function mounts. A delegate’s world is exactly what you compose for it:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { useModel, useSkill, useSubagent, useTool } from &#39;@flue/runtime&#39;;
import { searchIssues } from &#39;../tools/search-issues.ts&#39;;
import reproduceSkill from &#39;../skills/reproduce/SKILL.md&#39;;

function Reproducer() {
  useTool(searchIssues);
  useSkill(reproduceSkill);
  return &#39;You reproduce one reported issue. Write your findings to report.md.&#39;;
}

export function Triage() {
  useModel(&#39;anthropic/claude-sonnet-4-6&#39;);
  useSubagent({
    name: &#39;reproducer&#39;,
    description: &#39;Sets up the reproduction for one issue and writes report.md.&#39;,
    agent: Reproducer,
  });
  return &#39;Investigate the reported issue. Delegate the reproduction to the `reproducer` subagent.&#39;;
}</code></pre>
<figcaption><span>src/agents/triage.ts</span></figcaption>
</figure>

Because parent and child share a sandbox, files are a natural hand-off surface: `Reproducer` writes `report.md`, and the parent reads it after the task returns.

Inside a delegate’s render, `useTool()`, `useSkill()`, `useInstruction()`, custom hooks, and nested `useSubagent()` compose as usual. The instance-scoped hooks throw: `usePersistentState()` and `useSandbox()` (durable state belongs to the parent instance, and delegates share its environment), `useModel()` (a delegate’s model comes from its definition — see below), and the client-facing hooks (`useDataWriter()`, the event hooks, `useDispatchMessage()`). The [Agent Hooks API](/docs/reference/agent-hooks-api/#usesubagent) lists the full contract.

Two definition fields override what the delegate would otherwise inherit:

- `model` — a [model specifier](/docs/guide/models/#model-specifier) for the delegate. Inherits the parent’s model when omitted.
- `thinkingLevel` — the delegate’s [reasoning effort](/docs/guide/models/#model-reasoning-effort). Inherits when omitted.

Routing a delegate to a cheaper model is a common pattern: a classification step that runs on every ticket doesn’t need the parent’s model.

## The general-purpose delegate

To fan work out into fresh contexts without defining a specialist, Flue ships `GeneralSubagent`, a ready-made blank delegate:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { GeneralSubagent, useModel, useSubagent } from &#39;@flue/runtime&#39;;

export function Researcher() {
  useModel(&#39;anthropic/claude-sonnet-4-6&#39;);
  useSubagent(GeneralSubagent);
  return &#39;Answer questions about this codebase. Fan independent research out to the `flue-general` subagent, one question per task.&#39;;
}</code></pre>
<figcaption><span>src/agents/researcher.ts</span></figcaption>
</figure>

`GeneralSubagent` mounts under the framework-reserved name `flue-general`. Its agent function is deliberately empty: the child gets the shared environment — sandbox tools, workspace context, the parent’s model — and no instructions, tools, or skills of its own. Everything it knows comes from the task prompt, so prompts to it must be complete briefings. Because delegation only resolves against declared subagents, even this general delegate is opt-in: mount it explicitly when an agent should be able to fan out.

## Share a subagent across agents

A delegate that several agents mount belongs in its own module, defined once with `defineSubagent()` and exported:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { defineSubagent } from &#39;@flue/runtime&#39;;

function IssueClassifier() {
  return &#39;Return the likely product area and urgency for the reported issue.&#39;;
}

export const issueClassifier = defineSubagent({
  name: &#39;issue_classifier&#39;,
  description: &#39;Classifies support issues for routing.&#39;,
  agent: IssueClassifier,
});</code></pre>
<figcaption><span>src/subagents/issue-classifier.ts</span></figcaption>
</figure>

Like `defineTool(...)` and `defineSkill(...)`, `defineSubagent(...)` is a typing helper: it validates the definition at module load (instead of first render) and returns it frozen. Mount the exported definition from any agent — per-mount overrides spread cleanly, so here the classifier runs on a small model for one high-volume agent:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { useModel, useSubagent } from &#39;@flue/runtime&#39;;
import { issueClassifier } from &#39;../subagents/issue-classifier.ts&#39;;

export function Support() {
  useModel(&#39;anthropic/claude-sonnet-4-6&#39;);
  useSubagent({ ...issueClassifier, model: &#39;anthropic/claude-haiku-4-5&#39; });
  return &#39;Handle the support ticket. Classify it with the `issue_classifier` subagent first.&#39;;
}</code></pre>
<figcaption><span>src/agents/support.ts</span></figcaption>
</figure>

## When to use a subagent

Subagents are most useful when:

- exploratory work would flood the parent’s context but produces a short answer — research, codebase exploration, log analysis;
- one phase of a workflow needs different instructions, tools, or skills than the rest of the conversation;
- independent pieces of work can run in parallel, each in its own context window;
- a class of work should run on a different model or reasoning effort than the parent.

Against the neighboring primitives: a [tool](/docs/guide/tools/) is a bounded function your application code executes — reach for one when the work is deterministic, not model-driven. A [skill](/docs/guide/skills/) adds instructions and resources to the *current* agent — reach for one when the agent needs guidance, not isolation. And a subagent is not a second registered agent: it has no conversation id, no persistent state, and no address. When another party of your system should message an agent over time, register a real agent and [`dispatch()`](/docs/guide/building-agents/#dispatch) to it instead.

## Next steps

- [Agent Hooks API](/docs/reference/agent-hooks-api/#usesubagent) — the full contract for `useSubagent`, `defineSubagent`, and `GeneralSubagent`.
- [Agent Hooks](/docs/guide/agent-hooks/) — the hook model that delegates compose with.
- [Tools](/docs/guide/tools/) and [Skills](/docs/guide/skills/) — the primitives to reach for when isolation isn’t the goal.
- [Sandboxes](/docs/guide/sandboxes/) — the shared environment parent and child work in.
- [Durability](/docs/guide/durability/#delegated-tasks) — how interrupted tasks recover.


## Docs Navigation

Current page: [Subagents](/docs/guide/subagents/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


