> Source: https://flueframework.com/docs/ecosystem/sandboxes/daytona

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Daytona


Last updated Jun 1, 2026 <a href="/docs/ecosystem/sandboxes/daytona/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


The Daytona adapter adapts an already-initialized Daytona sandbox from `@daytona/sdk` into Flue’s sandbox interface. Use it when a Node-hosted application needs a provider-managed Linux environment with filesystem and shell operations.

## Quickstart

Add provider-managed Linux sandbox capability to an existing Flue project with the [Daytona](https://daytona.io) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add sandbox daytona
```

## Overview

The blueprint installs `@daytona/sdk` when needed and creates `sandboxes/daytona.ts` in your source-root. That file adapts a Daytona sandbox that your application has already created; it does not choose its image, identity, retention, or cleanup policy.

``` astro-code
// flue-blueprint: sandbox/daytona@1
import { createSandboxSessionEnv } from '@flue/runtime';
import type { SandboxApi, SandboxFactory, SessionEnv, FileStat } from '@flue/runtime';
import type { Sandbox as DaytonaSandbox } from '@daytona/sdk';

class DaytonaSandboxApi implements SandboxApi {
  constructor(private sandbox: DaytonaSandbox) {}

  /* Implements file reads, writes, stat, listing, existence, and mkdir with sandbox.fs. */

  /* Forwards recursive removal and rejects unsupported force before deletion. */

  /* Implements exec() with executeCommand(), rounding timeoutMs up to whole seconds. */
}

export function daytona(sandbox: DaytonaSandbox): SandboxFactory {
  return {
    async createSessionEnv(): Promise<SessionEnv> {
      const sandboxCwd = (await sandbox.getWorkDir()) ?? '/home/daytona';
      const api = new DaytonaSandboxApi(sandbox);
      return createSandboxSessionEnv(api, sandboxCwd);
    },
  };
}
```

Pass an initialized Daytona `Sandbox` to `daytona(...)`, then assign the returned factory to an agent’s `sandbox` property. Flue uses the provider’s working directory as the workspace root, exposes Daytona filesystem and process operations through the session, preserves Daytona’s available file metadata, and rounds millisecond command deadlines up to the SDK’s whole-second timeout. Daytona supports recursive deletion but not force semantics, so the adapter rejects `force` before deletion. Your application remains responsible for sandbox creation and lifecycle.

## Configure

| Variable          | Purpose                                            |
|-------------------|----------------------------------------------------|
| `DAYTONA_API_KEY` | **Required** — Authenticates with the Daytona API. |

| Requirement                 | Purpose                                                                                         |
|-----------------------------|-------------------------------------------------------------------------------------------------|
| `@daytona/sdk` package      | **Required** — Creates the Daytona sandbox adapted by Flue.                                     |
| Application-owned lifecycle | **Required** — Creates, retains, and deletes the sandbox, then passes it to `daytona(sandbox)`. |

The generated adapter expects your application to create and own the Daytona sandbox. It does not decide sandbox identity, retention, or cleanup for you.

## Typical use

``` astro-code
import { Daytona } from '@daytona/sdk';
import { defineAgent } from '@flue/runtime';
import { daytona } from '../sandboxes/daytona';

const client = new Daytona({ apiKey: env.DAYTONA_API_KEY });
const sandbox = await client.create();
const agent = defineAgent(() => ({
  model: 'anthropic/claude-sonnet-4-6',
  sandbox: daytona(sandbox),
}));
```

Configure images, snapshots, regions, environment variables, and volumes through the Daytona SDK before passing the sandbox to `daytona(...)`. For a narrower working directory, configure `cwd` on the agent definition; Flue resolves it once against the adapter’s provider-owned base directory during `init()`.

See [Sandboxes](/docs/guide/sandboxes/#remote-sandboxes), [Sandbox Adapter API](/docs/api/sandbox-api/), and [Daytona’s TypeScript SDK reference](https://www.daytona.io/docs/en/typescript-sdk/daytona/).


## Docs Navigation

Current page: [Daytona](/docs/ecosystem/sandboxes/daytona/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


