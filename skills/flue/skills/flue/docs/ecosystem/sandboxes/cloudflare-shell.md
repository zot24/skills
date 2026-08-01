> Source: https://flueframework.com/docs/ecosystem/sandboxes/cloudflare-shell

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Cloudflare Shell


Last updated Jul 21, 2026<a href="/docs/ecosystem/sandboxes/cloudflare-shell/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


The Cloudflare Shell adapter adapts an application-owned `@cloudflare/shell` `Workspace` into a Flue sandbox on the Cloudflare target. Unlike a Linux shell sandbox, it provides a durable workspace. The model keeps the standard file tools (`read`/`write`/`edit`, routed through the workspace) and gains a `code` tool that executes JavaScript against workspace state through a Worker Loader binding, in place of the shell-backed `bash`/`grep`/`glob`.

## Quickstart

Add durable workspace sandbox capability to an existing Flue project with the [Cloudflare Shell](https://developers.cloudflare.com/workers/runtime-apis/bindings/worker-loader/) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add sandbox cloudflare-shell
```

## Overview

The blueprint installs `@cloudflare/shell` and `@cloudflare/codemode`, creates `<source-root>/sandboxes/cloudflare-shell.ts`, and adds a Worker Loader binding to Wrangler configuration. The generated adapter exports sandbox construction and default workspace helpers; its file API retries nested writes after recursively creating a missing parent directory.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>// flue-blueprint: sandbox/cloudflare-shell@2
import { Workspace, WorkspaceFileSystem /* ... */ } from &#39;@cloudflare/shell&#39;;
import { stateTools } from &#39;@cloudflare/shell/workers&#39;;
import { DynamicWorkerExecutor, resolveProvider /* ... */ } from &#39;@cloudflare/codemode&#39;;
import {
  createEditTool,
  createReadTool,
  createWriteTool,
  type SandboxFactory,
  type SessionToolFactory /* ... */,
} from &#39;@flue/runtime&#39;;
import { getCloudflareContext } from &#39;@flue/runtime/cloudflare&#39;;

export interface GetShellSandboxOptions {
  workspace: Workspace;
  loader: WorkerLoader;
  executor?: Pick&lt;DynamicWorkerExecutorOptions, &#39;timeout&#39; | &#39;globalOutbound&#39; | &#39;modules&#39;&gt;;
}

export function getShellSandbox(options: GetShellSandboxOptions): SandboxFactory {
  /* ... generated workspace and Worker Loader validation ... */

  const { workspace, loader, executor: executorOptions } = options;
  const fs = new WorkspaceFileSystem(workspace);
  const executor = new DynamicWorkerExecutor({
    loader,
    ...executorOptions,
  });
  const stateProvider = resolveProvider(stateTools(workspace));
  // Compose the standard file tools with this sandbox&#39;s native codemode
  // tool; the exec-backed bash/grep/glob stay out — this env has no shell.
  const toolFactory: SessionToolFactory = (env) =&gt; [
    createReadTool(env),
    createWriteTool(env),
    createEditTool(env),
    createCodeTool(executor, stateProvider),
  ];

  return {
    async createSessionEnv(): Promise&lt;ShellSandboxEnv&gt; {
      return { ...createWorkspaceSessionEnv(workspace, fs, &#39;/&#39;), workspace };
    },
    tools: toolFactory,
  };
}

/* ... generated workspace session environment and code tool implementation ... */

export function getDefaultWorkspace(): Workspace {
  const { storage } = getCloudflareContext();
  return new Workspace({ sql: storage.sql });
}</code></pre>
<figcaption><span>&lt;source-root&gt;/sandboxes/cloudflare-shell.ts (abridged)</span></figcaption>
</figure>

Create a workspace, then pass it with the `worker_loaders` binding to `getShellSandbox(...)`. Agents receive durable file operations — the standard `read`/`write`/`edit` tools composed from Flue’s exported per-tool factories — and the isolated JavaScript `code` tool; they do not receive Linux command execution. Application-specific data loading into the workspace remains application-owned.

The generated `code` tool bounds its own concurrency: Cloudflare allows at most 4 concurrent dynamic-worker invocations per request, and Flue executes a turn’s tool calls in parallel, so the adapter queues `code` executions above a cap of 3 rather than letting the platform reject the surplus calls.

## Configure

| Requirement                               | Purpose                                                                                                                              |
|-------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| Cloudflare target                         | **Required** — Runs the Workspace and Worker Loader integration.                                                                     |
| `@cloudflare/shell` package               | **Required** — Provides the durable Workspace.                                                                                       |
| `@cloudflare/codemode` package            | **Required** — Provides code-oriented model operations.                                                                              |
| `worker_loaders` binding such as `LOADER` | **Required on Cloudflare** — Executes JavaScript against Workspace state; this is a Cloudflare binding, not an environment variable. |
| Environment-variable credentials          | **Not required** — The integration uses the `worker_loaders` binding instead.                                                        |
| Ordinary Linux shell                      | **Not provided** — This adapter provides the standard file tools plus a model-facing `code` tool, not shell command execution.       |

Import the generated helpers from your project adapter file, not from `@flue/runtime/cloudflare`:

``` astro-code
import { getDefaultWorkspace, getShellSandbox } from '../sandboxes/cloudflare-shell';
```

## Choose this adapter when

Use Cloudflare Shell when files must be stored in a durable Workspace and agent work can be expressed through Workspace operations. It is not interchangeable with a container: `harness.sandbox.exec(...)` does not provide Linux command execution through this adapter — it throws. Use the file verbs on `harness.sandbox` for durable file access, or narrow to the native `Workspace` with `shellWorkspace(harness.sandbox)` for operations the generic surface doesn’t cover.

If the workspace should survive later user interactions, associate it with a stable agent instance id. A workspace keyed to a throwaway id belongs to that id’s owner rather than forming a shared workspace.

See [Sandboxes](/docs/guide/sandboxes/) and [Deploy on Cloudflare](/docs/ecosystem/deploy/cloudflare/).


## Docs Navigation

Current page: [Cloudflare Shell](/docs/ecosystem/sandboxes/cloudflare-shell/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


