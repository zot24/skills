<!-- Source: https://flueframework.com/docs/ecosystem/sandboxes/cloudflare-shell -->

The Cloudflare Shell adapter adapts an application-owned `@cloudflare/shell``Workspace` into a Flue sandbox on the Cloudflare target. Unlike a Linux shell sandbox, it provides a durable workspace and a model-facing `code` tool that executes JavaScript against workspace state through a Worker Loader binding.

## Quickstart [\#](https://flueframework.com/docs/ecosystem/sandboxes/cloudflare-shell/\#quickstart)

Add durable workspace sandbox capability to an existing Flue project with the [Cloudflare Shell](https://developers.cloudflare.com/workers/runtime-apis/bindings/worker-loader/) blueprint. Run the following command in your terminal or coding agent of choice:

```
flue add sandbox cloudflare-shell
```

## Overview [\#](https://flueframework.com/docs/ecosystem/sandboxes/cloudflare-shell/\#overview)

The blueprint installs `@cloudflare/shell` and `@cloudflare/codemode`, creates `<source-root>/sandboxes/cloudflare-shell.ts`, and adds a Worker Loader binding to Wrangler configuration. The generated adapter exports sandbox construction and default workspace helpers; its file API retries nested writes after recursively creating a missing parent directory.

```
// flue-blueprint: sandbox/cloudflare-shell@1
import { Workspace, WorkspaceFileSystem /* ... */ } from '@cloudflare/shell';
import { stateTools } from '@cloudflare/shell/workers';
import { DynamicWorkerExecutor, resolveProvider /* ... */ } from '@cloudflare/codemode';
import type { SandboxFactory, SessionToolFactory /* ... */ } from '@flue/runtime';
import { getCloudflareContext } from '@flue/runtime/cloudflare';

export interface GetShellSandboxOptions {
  workspace: Workspace;
  loader: WorkerLoader;
  executor?: Pick<DynamicWorkerExecutorOptions, 'timeout' | 'globalOutbound' | 'modules'>;
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
  const toolFactory: SessionToolFactory = () => [createCodeTool(executor, stateProvider)];

  return {
    async createSessionEnv() {
      return createWorkspaceSessionEnv(workspace, fs, '/');
    },
    tools: toolFactory,
  };
}

/* ... generated workspace session environment and code tool implementation ... */

export function getDefaultWorkspace(): Workspace {
  const { storage } = getCloudflareContext();
  return new Workspace({ sql: storage.sql });
}
```

Create a workspace, then pass it with the `worker_loaders` binding to `getShellSandbox(...)`. Agents receive durable file operations and the isolated JavaScript `code` tool; they do not receive Linux command execution. Application-specific data loading into the workspace remains application-owned.

## Configure [\#](https://flueframework.com/docs/ecosystem/sandboxes/cloudflare-shell/\#configure)

| Requirement | Purpose |
| --- | --- |
| Cloudflare target | **Required** — Runs the Workspace and Worker Loader integration. |
| `@cloudflare/shell` package | **Required** — Provides the durable Workspace. |
| `@cloudflare/codemode` package | **Required** — Provides code-oriented model operations. |
| `worker_loaders` binding such as `LOADER` | **Required on Cloudflare** — Executes JavaScript against Workspace state; this is a Cloudflare binding, not an environment variable. |
| Environment-variable credentials | **Not required** — The integration uses the `worker_loaders` binding instead. |
| Ordinary Linux shell | **Not provided** — This adapter provides a model-facing `code` tool, not shell command execution. |

Import the generated helpers from your project adapter file, not from `@flue/runtime/cloudflare`:

```
import { getDefaultWorkspace, getShellSandbox } from '../sandboxes/cloudflare-shell';
```

## Choose this adapter when [\#](https://flueframework.com/docs/ecosystem/sandboxes/cloudflare-shell/\#choose-this-adapter-when)

Use Cloudflare Shell when files must be stored in a durable Workspace and agent work can be expressed through Workspace operations. It is not interchangeable with a container: `harness.shell(...)` and `session.shell(...)` do not provide Linux command execution through this adapter.

If the workspace should survive later user interactions, associate it with a stable addressable agent instance. A workspace created inside one workflow invocation belongs to that invocation’s owner rather than forming a shared cross-run workspace.

See [Sandboxes](https://flueframework.com/docs/guide/sandboxes/) and [Deploy on Cloudflare](https://flueframework.com/docs/ecosystem/deploy/cloudflare/).

## Docs Navigation

Current page: [Cloudflare Shell](https://flueframework.com/docs/ecosystem/sandboxes/cloudflare-shell/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
