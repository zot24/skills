> Source: https://flueframework.com/docs/ecosystem/sandboxes/cloudflare-shell

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Cloudflare Computer


Last updated Aug 4, 2026<a href="/docs/ecosystem/sandboxes/cloudflare-computer/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


The Cloudflare Computer adapter wraps a [`@cloudflare/computer`](https://github.com/cloudflare/computer) `Workspace` — a durable, SQLite-backed virtual filesystem that lives in the agent’s own Durable Object — into a Flue sandbox on the Cloudflare target. Commands run through the package’s worker-shell backend, a just-bash shell in a Dynamic Worker operating directly on the durable files, so agents get Flue’s full standard tool set (`bash`/`grep`/`glob`/`read`/`write`/`edit`) with no substitutions and no container.

`@cloudflare/computer` is an early preview from Cloudflare — suitable for experiments and prototypes, not production.

## Quickstart

Add durable workspace sandbox capability to an existing Flue project with the Cloudflare Computer blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add sandbox cloudflare-computer
```

## Overview

The blueprint creates the adapter at `<source-root>/sandboxes/cloudflare-computer.ts`. Shell commands don’t run in your Worker: the adapter mints a Dynamic Worker through a [Worker Loader](https://developers.cloudflare.com/workers/runtime-apis/bindings/worker-loader/) binding and runs just-bash there, against the durable filesystem. That binding — currently beta-gated, so your Cloudflare account needs access — and the `experimental` compatibility flag its Dynamic Worker requires are the two Wrangler additions; there are no API keys or environment variables:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="jsonc"><code>{
 &quot;compatibility_flags&quot;: [&quot;nodejs_compat&quot;, &quot;experimental&quot;],
 &quot;worker_loaders&quot;: [{ &quot;binding&quot;: &quot;LOADER&quot; }]
}</code></pre>
<figcaption><span>wrangler.jsonc</span></figcaption>
</figure>

Two one-line re-exports complete the wiring: the project’s `cloudflare.ts` re-exports `WorkspaceServiceProxy` (the loopback the shell dials back through), and each sandbox-using agent module re-exports the generated `workspaceHost` extension so its Durable Object hosts the workspace.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>// flue-blueprint: sandbox/cloudflare-computer@1
import { Workspace, type WorkspaceOptions /* ... */ } from &#39;@cloudflare/computer&#39;;
import { WorkerShellBackend } from &#39;@cloudflare/computer/backends/worker-shell&#39;;
import { createGitClient } from &#39;@cloudflare/computer/git&#39;;
import type { Sandbox, SandboxFactory /* ... */ } from &#39;@flue/runtime&#39;;
import { extend, getDurableObjectIdentity } from &#39;@flue/runtime/cloudflare&#39;;

/** Re-export from each agent module: `export { workspaceHost as cloudflare } ...` */
export const workspaceHost = extend({
 base: (Base) =&gt;
     class extends Base {
         /* ... captures the Durable Object state; exposes the workspace stub ... */
     },
});

/** One durable Workspace per agent instance, shared with the sandbox. */
export function getComputerWorkspace(options: GetComputerWorkspaceOptions): Workspace {
 /* ... memoized construction: DO storage + git client + WorkerShellBackend ... */
}

export function getComputerSandbox(options: GetComputerWorkspaceOptions): SandboxFactory {
 return {
     async createSandbox(): Promise&lt;ComputerSandboxEnv&gt; {
         const workspace = getComputerWorkspace(options);
         await workspace.fs.mkdir(&#39;/workspace&#39;, { recursive: true });
         return { ...createWorkspaceSandbox(workspace, &#39;/workspace&#39;), workspace };
     },
     // No `tools` override: exec() works here, so the framework&#39;s standard
     // set (bash/grep/glob/read/write/edit) applies as-is.
 };
}</code></pre>
<figcaption><span>&lt;source-root&gt;/sandboxes/cloudflare-computer.ts (abridged)</span></figcaption>
</figure>

Pass the `worker_loaders` binding to `getComputerSandbox(...)` inside the agent:

``` astro-code
'use agent';
import { env } from 'cloudflare:workers';
import { useModel, useSandbox } from '@flue/runtime';
import { getComputerSandbox } from '../sandboxes/cloudflare-computer';

export { workspaceHost as cloudflare } from '../sandboxes/cloudflare-computer';

export function Assistant() {
 useModel('cloudflare/@cf/moonshotai/kimi-k2.6');
 useSandbox(getComputerSandbox({ loader: env.LOADER }));
 return 'You explore and edit your durable workspace with the standard file and shell tools.';
}
```

Application-owned hydration and inspection go through the workspace’s native surface: `getComputerWorkspace(...)` (or `computerWorkspace(harness.sandbox)`) exposes `workspace.git` for clones and commits and `workspace.fs` for out-of-band reads and writes, and the adapter’s `workspace` option reshapes the generated `WorkspaceOptions` — read-only R2 mounts, a `defaultGitIdentity`, an observer, additional backends. Import all of these helpers from your project adapter file, not from `@flue/runtime/cloudflare`.

## Choose this adapter when

Use Cloudflare Computer when files must be stored durably in the agent’s own Durable Object and shell-expressible work covers the agent’s needs — no container to provision, no cold start beyond the Dynamic Worker. Filesystem state survives Durable Object restarts and is capped around 10 GB (it shares the DO’s SQLite storage).

It is not a Linux box: commands run in a JavaScript shell without native binaries or package managers. That is the adapter’s default wiring, not the package’s ceiling — `@cloudflare/computer` can register additional execution backends against the same durable files, including its full-Linux `CloudflareContainerBackend`, appended through the adapter’s `workspace` option as an application-owned configuration. If the agent’s baseline need is language toolchains, native tools, or writable bucket mounts, use [Cloudflare Sandbox](/docs/ecosystem/sandboxes/cloudflare/) (Containers) instead.

See [Sandboxes](/docs/guide/sandboxes/) and [Deploy on Cloudflare](/docs/ecosystem/deploy/cloudflare/).


## Docs Navigation

Current page: [Cloudflare Computer](/docs/ecosystem/sandboxes/cloudflare-computer/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


