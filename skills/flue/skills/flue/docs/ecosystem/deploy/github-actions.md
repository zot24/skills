> Source: https://flueframework.com/docs/ecosystem/deploy/github-actions

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Build Agents for GitHub Actions


Last updated Jul 21, 2026<a href="/docs/ecosystem/deploy/github-actions/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


Build and run Flue agents in GitHub Actions. This guide walks you through creating your first agent, running it locally with the CLI, and wiring it into a CI workflow.

By the end, you will have a Flue agent running inside GitHub Actions, and you will know how to use local sandbox context, external CLIs, subagents, skills, and typed results to build CI automations.

CI is `flue run`’s home turf: one agent module, one message, no server, no port. The command executes the agent transport-free and prints the reply to stdout, so a workflow step can pipe it anywhere.

## Hello World

A minimal agent that runs in CI whenever an issue is opened.

### 1. Set up your project

``` astro-code
mkdir my-flue-project && cd my-flue-project
npm init -y
npm install @flue/runtime valibot
npm install -D @flue/cli
```

### 2. Create your first agent

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>import { useModel, useSandbox } from &#39;@flue/runtime&#39;;
import { local } from &#39;@flue/runtime/node&#39;;

export function Hello() {
  useModel(&#39;anthropic/claude-sonnet-4-6&#39;);
  useSandbox(local());
  return &#39;Greet the person the user names and share an interesting fact.&#39;;
}</code></pre>
<figcaption><span>src/agents/hello.ts</span></figcaption>
</figure>

A few things to note:

- This agent is never mounted over HTTP — it exists to be run from the CLI, which is perfect for CI. (The `'use agent'` directive matters only for building a deployable app with Vite; `flue run` takes the module path directly.)
- **`local()`** — The `local()` sandbox runs the agent directly against the host filesystem and shell. In CI, that’s the checked-out repo plus whatever binaries are on `$PATH` (`gh`, `git`, `npm`, etc.). Skills and `AGENTS.md` are discovered automatically from the project root. By default only shell-essential env vars (`PATH`, `HOME`, locale, etc.) are inherited from `process.env` — pass `local({ env: { GH_TOKEN: process.env.GH_TOKEN } })` to expose more. Use `local()` only when the runner itself provides the isolation boundary.

### 3. Test it locally

``` astro-code
npx flue run src/agents/hello.ts --message "Say hello to World"
```

`flue run` executes the agent module in-process — no HTTP listener, no build — streams progress to stderr, and prints the final reply to stdout. Pass `--json` for a machine-readable envelope instead.

### 4. Wire it into GitHub Actions

`.github/workflows/hello.yml`:

``` astro-code
name: Hello Flue

on:
  issues:
    types: [opened]

jobs:
  hello:
    runs-on: ubuntu-latest
    permissions:
      issues: read
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
      - run: npm ci
      - name: Run agent
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          npx flue run src/agents/hello.ts \
            --message 'Say hello to ${{ github.event.issue.user.login }}'
```

Add `ANTHROPIC_API_KEY` as a repository secret (**Settings \> Secrets and variables \> Actions**). Open an issue and you’ll see the agent’s greeting in the job logs.

## Building a real agent

Now let’s build something useful — an issue triage agent that analyzes an issue and reports back. This is where Flue’s agent features start to shine.

### Structured work with skills and actions

An agent’s deterministic orchestration lives in [harness tools](/docs/guide/tools/#harness-tools) — finite, schema-validated jobs the model calls — and [skills](/docs/guide/skills/), reusable instruction files. Inside either, the harness gives you two core methods:

- **`harness.sandbox.exec(cmd)`** — Run a shell command in the sandbox. Returns `{ stdout, stderr, exitCode }`.
- **`harness.prompt(text, opts)`** — Send a prompt to the agent and get back a result. `harness.prompt(...)` runs in the same conversation context as the agent’s own turns, so naming a mounted skill in the instruction is enough to direct the model to apply it.

`prompt()` accepts a `result` option — a [Valibot](https://valibot.dev) schema that defines the expected output shape. Flue parses the agent’s response and returns it on `response.data`, fully typed:

``` astro-code
import * as v from 'valibot';

// summary: string
const { data: summary } = await harness.prompt(`Summarize this diff:\n${diff}`, {
  result: v.string(),
});

// diagnosis: { reproducible: boolean, skipped: boolean }
const { data: diagnosis } = await harness.prompt(
  `Apply the triage skill to issue #${issueNumber}:\n\n${issue}`,
  {
    result: v.object({
      reproducible: v.boolean(),
      skipped: v.boolean(),
    }),
  },
);
```

### Connecting external CLIs

Your agent often needs to interact with tools like `gh`, `npm`, or `git`. With `local()`, the agent’s bash tool runs against the host shell directly — anything on `$PATH` is reachable. Host env vars are opt-in: only shell essentials (`PATH`, `HOME`, locale, etc.) are inherited by default, so you pass the specific vars your CLIs need via `local({ env: { ... } })`.

In GitHub Actions, this means you set the secrets you want the agent’s CLIs to see in the workflow `env:` block, then forward them explicitly into the sandbox. The runner is your isolation boundary; flue makes the inner boundary (host → spawned shell) explicit.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>import { useModel, useSandbox } from &#39;@flue/runtime&#39;;
import { local } from &#39;@flue/runtime/node&#39;;

export function Triage() {
  useModel(&#39;anthropic/claude-opus-4-7&#39;);
  useSandbox(
    local({
      env: {
        GH_TOKEN: process.env.GH_TOKEN,
        NPM_TOKEN: process.env.NPM_TOKEN,
      },
    }),
  );
  return &#39;When given an issue number, run the `triage` skill on it and report severity, reproducibility, and a summary.&#39;;
}</code></pre>
<figcaption><span>src/agents/triage.ts</span></figcaption>
</figure>

If you want a tighter boundary — the agent can call a specific operation but never see the underlying token — call `useTool(...)` inside the agent function. The tool implementation reads the secret from `process.env`; the agent only sees the tool’s parameters and result.

### Subagents

Named subagents can run focused detached tasks. `useSubagent(...)` declares one, backed by its own agent function:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>&#39;use agent&#39;;
import { useModel, useSubagent } from &#39;@flue/runtime&#39;;

function Reviewer() {
  return &#39;Focus on correctness, security, and project standards.&#39;;
}

export function Triage() {
  useSubagent({
    name: &#39;reviewer&#39;,
    description: &#39;Reviews a pull request for correctness, security, and project standards.&#39;,
    agent: Reviewer,
  });
  return &#39;Delegate PR reviews to the `reviewer` subagent via a task.&#39;;
}</code></pre>
<figcaption><span>src/agents/triage.ts</span></figcaption>
</figure>

### Sandbox context

The agent reads `AGENTS.md` and skills from its sandbox at runtime. CI agents typically use `local()`, which gives direct access to the runner’s checkout — so any files in your repo are visible automatically.

**Skills** are reusable agent tasks defined as markdown files in `.agents/skills/`. They give the agent a focused instruction set for a specific job:

`.agents/skills/triage/SKILL.md`:

``` astro-code
---
name: triage
description: Triage a GitHub issue — reproduce, assess severity, and optionally fix.
---

Given the issue number in the arguments:

1. Use `gh issue view` to fetch the issue details
2. Read the codebase to understand the relevant area
3. Attempt to reproduce the issue
4. Assess severity and write a summary
5. If the fix is straightforward, apply it and open a PR
```

**`AGENTS.md`** at your project root is the agent’s system prompt — it provides global context about the project:

``` astro-code
You are a helpful assistant working on the my-project codebase.

## Project structure

- `src/` — Application source code
- `tests/` — Test suite

## Guidelines

- Always run tests before suggesting a fix is complete
- Use the project's existing patterns and conventions
```

### Wiring it into GitHub Actions

`.github/workflows/issue-triage.yml`:

``` astro-code
name: Issue Triage

on:
  issues:
    types: [opened]

jobs:
  triage:
    runs-on: ubuntu-latest
    timeout-minutes: 30
    permissions:
      contents: read
      issues: write
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
      - run: npm ci
      - name: Run triage agent
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          npx flue run src/agents/triage.ts \
            --message 'Triage issue #${{ github.event.issue.number }}'
```

`GITHUB_TOKEN` is provided automatically by GitHub Actions.

## Typed results and orchestration

Result schemas aren’t just for type safety — they’re how you orchestrate multi-step work. Wrap the orchestration in a harness-connected tool (`useTool({ harness: true })`): you get typed data back from `prompt()` and can branch on it in plain code, all inside one durable conversation:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>&#39;use agent&#39;;
import { useModel, useSandbox, useTool } from &#39;@flue/runtime&#39;;
import { local } from &#39;@flue/runtime/node&#39;;
import * as v from &#39;valibot&#39;;

export function AutoTriage() {
  useModel(&#39;anthropic/claude-sonnet-4-6&#39;);
  useSandbox(local());
  useTool({
    name: &#39;triage-issue&#39;,
    description: &#39;Triage one GitHub issue and auto-fix critical reproducible ones.&#39;,
    input: v.object({ issueNumber: v.number() }),
    harness: true,
    async run({ harness, data }) {
      const { data: triage } = await harness.prompt(
        `Apply the triage skill to issue #${data.issueNumber}.`,
        {
          result: v.object({
            severity: v.picklist([&#39;low&#39;, &#39;medium&#39;, &#39;high&#39;, &#39;critical&#39;]),
            reproducible: v.boolean(),
            summary: v.string(),
          }),
        },
      );

      if (triage.severity === &#39;critical&#39; &amp;&amp; triage.reproducible) {
        await harness.prompt(`Apply the auto-fix skill to issue #${data.issueNumber}.`, {
          result: v.object({ fix_applied: v.boolean(), pr_url: v.optional(v.string()) }),
        });
      }
      return { output: triage };
    },
  });
  return &#39;When given an issue number, call the `triage-issue` tool and report its result.&#39;;
}</code></pre>
<figcaption><span>src/agents/auto-triage.ts</span></figcaption>
</figure>

This pattern — prompt, check the result, decide what to do next — is how you build sophisticated agents that go beyond single-shot prompts.

## Running agents locally

During development, `flue run` executes the same module the CI step will run:

``` astro-code
# One-shot run
npx flue run src/agents/auto-triage.ts --message "Triage issue #42"

# Machine-readable output for scripting
npx flue run src/agents/auto-triage.ts --message "Triage issue #42" --json | jq -r '.message'

# Continue the same conversation across invocations
npx flue run src/agents/auto-triage.ts --message "What did you conclude?" --id issue-42
```

Progress streams to stderr; only the final reply (or the `--json` envelope) lands on stdout. See [`flue run`](/docs/cli/run/) for the full contract.


## Docs Navigation

Current page: [Build Agents for GitHub Actions](/docs/ecosystem/deploy/github-actions/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


