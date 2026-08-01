> Source: https://flueframework.com/docs/ecosystem/channels/github

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# GitHub


Last updated Jul 21, 2026<a href="/docs/ecosystem/channels/github/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a><a href="https://www.npmjs.com/package/@flue/github" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/github</a>


## Quickstart

Add verified webhook ingress and application-owned API behavior to an existing Flue project with the [GitHub](https://github.com) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel github
```

## Overview

The blueprint installs `@flue/github` and the official `@octokit/rest` SDK. It creates `<source-root>/channels/github.ts` with a named `channel`, a project-owned Octokit `client`, and an issue-comment tool, then wires that tool into an agent. Adapt the subscribed events, dispatched message, and tool to the application.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { Octokit } from &#39;@octokit/rest&#39;;
import { createGitHubChannel } from &#39;@flue/github&#39;;
import { dispatch } from &#39;@flue/runtime&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;

export const client = new Octokit({ auth: process.env.GITHUB_TOKEN });

export const channel = createGitHubChannel({
  webhookSecret: process.env.GITHUB_WEBHOOK_SECRET!,
  async webhook({ delivery }) {
    if (delivery.name !== &#39;issue_comment&#39; || delivery.payload.action !== &#39;created&#39;) return;
    const { repository, issue, comment, sender, installation } = delivery.payload;
    const issueRef = {
      owner: repository.owner.login,
      repo: repository.name,
      issueNumber: issue.number,
    };

    await dispatch(Assistant, {
      id: channel.instanceId(issueRef),
      // Recorded once when this event creates the instance; ignored after.
      initialData: {
        owner: issueRef.owner,
        repo: issueRef.repo,
        issueNumber: issueRef.issueNumber,
        openedBy: issue.user.login,
        title: issue.title,
      },
      message: {
        kind: &#39;signal&#39;,
        type: &#39;github.issue_comment.created&#39;,
        body: comment.body,
        attributes: {
          deliveryId: delivery.deliveryId,
          ...(installation === undefined ? {} : { installationId: String(installation.id) }),
          owner: issueRef.owner,
          repo: issueRef.repo,
          issueNumber: String(issueRef.issueNumber),
          sender: sender.login,
          title: issue.title,
          commentId: String(comment.id),
        },
      },
    });
  },
});</code></pre>
<figcaption><span>src/channels/github.ts (abridged)</span></figcaption>
</figure>

A newly created issue comment is admitted to the agent bound to that repository and issue; other verified deliveries receive an empty successful response. The full generated module also handles pull-request review comments and lets the bound agent post an issue or pull-request comment through Octokit. Cloudflare targets retain the project’s credential convention and run Octokit’s Fetch path under Flue’s `nodejs_compat` configuration.

## Mount the channel

A channel serves HTTP routes only where `app.ts` mounts it. Mount the module’s named `channel` export:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { channel as github } from &#39;./channels/github.ts&#39;;

app.route(&#39;/channels/github&#39;, github.route());</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

`channel.route()` is a pure router factory serving the channel’s declared routes relative to the mount path. The webhook paths in this guide assume the conventional `/channels/github` mount; a different mount path shifts them accordingly. The dispatch-target agent module carries the `'use agent'` directive — the directive registers it, so a dispatch-only agent needs no HTTP mount of its own.

## Configure

| Variable                | Purpose                                              |
|-------------------------|------------------------------------------------------|
| `GITHUB_WEBHOOK_SECRET` | **Required** — Verifies inbound deliveries.          |
| `GITHUB_TOKEN`          | **Required** — Authenticates outbound Octokit calls. |

It installs `@flue/github` for verified ingress and the official `@octokit/rest` SDK for outbound API calls. It creates `src/channels/github.ts` with named `channel` and `client` exports.

Configure the GitHub webhook URL as:

``` astro-code
https://example.com/channels/github/webhook
```

If `flue()` is mounted beneath an outer prefix, include that prefix. Set the content type to `application/json` (ingress is JSON-only; form-encoded deliveries are not accepted), set a webhook secret, and subscribe to the minimum event set the application handles. The example uses **Issue comments** and **Pull request review comments**. Keep both credentials in the project’s existing secret system.

## Channel module

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { createGitHubChannel } from &#39;@flue/github&#39;;
import { defineTool, dispatch } from &#39;@flue/runtime&#39;;
import { Octokit } from &#39;@octokit/rest&#39;;
import * as v from &#39;valibot&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;

export const client = new Octokit({
  auth: process.env.GITHUB_TOKEN,
});

export const channel = createGitHubChannel({
  webhookSecret: process.env.GITHUB_WEBHOOK_SECRET!,

  // Path: /channels/github/webhook
  async webhook({ delivery }) {
    // `delivery.name` is the X-GitHub-Event value and narrows `delivery.payload`
    // to the native @octokit/webhooks-types event. Filtering is application
    // policy: subscribe to the events you want in GitHub and branch here.
    if (delivery.name === &#39;issue_comment&#39; &amp;&amp; delivery.payload.action === &#39;created&#39;) {
      const { repository, issue, comment, sender, installation } = delivery.payload;
      const issueRef = {
        owner: repository.owner.login,
        repo: repository.name,
        issueNumber: issue.number,
      };
      await dispatch(Assistant, {
        id: channel.instanceId(issueRef),
        // Recorded once when this event creates the instance; ignored after.
        initialData: {
          owner: issueRef.owner,
          repo: issueRef.repo,
          issueNumber: issueRef.issueNumber,
          openedBy: issue.user.login,
          title: issue.title,
        },
        message: {
          kind: &#39;signal&#39;,
          type: &#39;github.issue_comment.created&#39;,
          body: comment.body,
          attributes: {
            deliveryId: delivery.deliveryId,
            ...(installation === undefined ? {} : { installationId: String(installation.id) }),
            owner: issueRef.owner,
            repo: issueRef.repo,
            issueNumber: String(issueRef.issueNumber),
            sender: sender.login,
            title: issue.title,
            commentId: String(comment.id),
          },
        },
      });
      return;
    }

    if (delivery.name === &#39;pull_request_review_comment&#39; &amp;&amp; delivery.payload.action === &#39;created&#39;) {
      const { repository, pull_request, comment, sender, installation } = delivery.payload;
      const issueRef = {
        owner: repository.owner.login,
        repo: repository.name,
        issueNumber: pull_request.number,
      };
      await dispatch(Assistant, {
        id: channel.instanceId(issueRef),
        // Recorded once when this event creates the instance; ignored after.
        initialData: {
          owner: issueRef.owner,
          repo: issueRef.repo,
          issueNumber: issueRef.issueNumber,
          openedBy: pull_request.user.login,
          title: pull_request.title,
        },
        message: {
          kind: &#39;signal&#39;,
          type: &#39;github.pull_request_review_comment.created&#39;,
          body: comment.body,
          attributes: {
            deliveryId: delivery.deliveryId,
            ...(installation === undefined ? {} : { installationId: String(installation.id) }),
            owner: issueRef.owner,
            repo: issueRef.repo,
            issueNumber: String(issueRef.issueNumber),
            sender: sender.login,
            title: pull_request.title,
            commentId: String(comment.id),
            // Replies attach to the top-level review comment in a thread.
            threadId: String(comment.in_reply_to_id ?? comment.id),
            path: comment.path,
            ...(comment.line === null || comment.line === undefined
              ? {}
              : { line: String(comment.line) }),
          },
        },
      });
      return;
    }
  },
});

export function commentOnIssue(ref: { owner: string; repo: string; issueNumber: number }) {
  return defineTool({
    name: &#39;comment_on_github_issue&#39;,
    description: &#39;Comment on the GitHub issue or pull request bound to this agent.&#39;,
    input: v.object({ body: v.pipe(v.string(), v.minLength(1)) }),
    async run({ data: { body } }) {
      const result = await client.rest.issues.createComment({
        owner: ref.owner,
        repo: ref.repo,
        issue_number: ref.issueNumber,
        body,
      });
      return { output: { commentId: result.data.id } };
    },
  });
}</code></pre>
<figcaption><span>src/channels/github.ts</span></figcaption>
</figure>

Every verified non-ping delivery is forwarded with its native `@octokit/webhooks-types` payload. `delivery.name` is the `X-GitHub-Event` value and discriminates `delivery.payload`, narrowing it to the matching event type (for example `name: 'issues'` gives an `IssuesEvent` payload). There is no fixed list of supported events and no normalization layer: the payload keeps GitHub’s own field names and nesting (`payload.repository.owner.login`, `payload.issue.number`, `payload.comment.in_reply_to_id`). Choosing which events to act on is application policy — subscribe to them in GitHub and branch on `delivery.name` (and, where it matters, `delivery.payload.action`) in the handler. GitHub `ping` is acknowledged internally and never reaches the callback.

## Bind the tool

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { useInitialData, useModel, useTool } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;
import { commentOnIssue } from &#39;../channels/github.ts&#39;;

const initialData = v.object({
  owner: v.string(),
  repo: v.string(),
  issueNumber: v.number(),
  openedBy: v.string(),
  title: v.string(),
});

export function Assistant() {
  useModel(&#39;anthropic/claude-haiku-4-5&#39;);
  const data = useInitialData&lt;v.InferOutput&lt;typeof initialData&gt;&gt;();
  if (!data) throw new Error(&#39;This agent is created by the GitHub channel dispatch.&#39;);
  useTool(commentOnIssue(data));
  return `Review the issue and post a concise triage comment when appropriate. &quot;${data.title}&quot; was opened by ${data.openedBy}.`;
}

Assistant.initialData = initialData;</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

`initialData` is the instance’s creation data: recorded once when the event creates the instance and ignored afterward, so the channel passes it on every dispatch. The agent’s `initialData` static validates the dispatched `initialData` when the instance is created; `useInitialData()` returns the parsed value on every render. Pull requests use their issue number for issue comments. The model selects the comment body; trusted code binds the repository and issue. The channel-agent import cycle is supported because both imported bindings are read only inside deferred callbacks or the agent function body.

GitHub expects a `2xx` response within ten seconds and does not auto-retry. The package does not enforce a handler deadline; treat the ten-second window as guidance and admit durable work quickly rather than blocking the response on it. The channel is stateless and does not deduplicate delivery ids, so claim `delivery.deliveryId` in application storage before dispatch when duplicate admission matters. Failed deliveries can be inspected and manually redelivered from GitHub with the same delivery id.

Octokit’s REST methods use Fetch and the example’s typed `issues.createComment()` operation is tested in workerd with Flue’s required `nodejs_compat` configuration. Cloudflare projects may initialize credentials through `process.env` or typed Worker bindings and should verify their complete target build.

See the [`@flue/github` README](https://github.com/withastro/flue/tree/main/packages/github#readme).


## Docs Navigation

Current page: [GitHub](/docs/ecosystem/channels/github/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


