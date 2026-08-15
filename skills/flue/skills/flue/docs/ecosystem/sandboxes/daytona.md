> Source: https://flueframework.com/docs/ecosystem/sandboxes/daytona

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Daytona


Last updated Jul 21, 2026<a href="/docs/ecosystem/sandboxes/daytona/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


The Daytona adapter adapts an already-initialized Daytona sandbox from `@daytona/sdk` into Flue’s sandbox interface. Use it when a Node-hosted application needs a provider-managed Linux environment with filesystem and shell operations.

## Quickstart

Add provider-managed Linux sandbox capability to an existing Flue project with the [Daytona](https://daytona.io) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add sandbox daytona
```

## Overview

The blueprint installs `@daytona/sdk` when needed and creates `sandboxes/daytona.ts` in your source-root. That file adapts a Daytona sandbox that your application has already created; it does not choose its image, identity, retention, or cleanup policy.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>// flue-blueprint: sandbox/daytona@1
import { sandboxFromDriver, useModel } from &#39;@flue/runtime&#39;;
import type { SandboxDriver, SandboxFactory, Sandbox, FileStat } from &#39;@flue/runtime&#39;;
import type { Sandbox as DaytonaSandbox } from &#39;@daytona/sdk&#39;;

class DaytonaSandboxDriver implements SandboxDriver {
  constructor(private sandbox: DaytonaSandbox) {}

  /* Implements file reads, writes, stat, listing, existence, and mkdir with sandbox.fs. */

  /* Forwards recursive removal and rejects unsupported force before deletion. */

  /* Implements exec() with executeCommand(), rounding timeoutMs up to whole seconds. */
}

export function daytona(sandbox: DaytonaSandbox): SandboxFactory {
  return {
    async createSandbox(): Promise&lt;Sandbox&gt; {
      const sandboxCwd = (await sandbox.getWorkDir()) ?? &#39;/home/daytona&#39;;
      const driver = new DaytonaSandboxDriver(sandbox);
      return sandboxFromDriver(driver, sandboxCwd);
    },
  };
}</code></pre>
<figcaption><span>&lt;source-root&gt;/sandboxes/daytona.ts (abridged)</span></figcaption>
</figure>

Pass an initialized Daytona `Sandbox` to `daytona(...)`, then pass the returned factory to the agent’s `useSandbox(...)` call. Flue uses the provider’s working directory as the workspace root, exposes Daytona filesystem and process operations through the session, preserves Daytona’s available file metadata, and rounds millisecond command deadlines up to the SDK’s whole-second timeout. Daytona supports recursive deletion but not force semantics, so the adapter rejects `force` before deletion. Your application remains responsible for sandbox creation and lifecycle.

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
import { useModel, useSandbox } from '@flue/runtime';
import { daytona } from '../sandboxes/daytona';

export function Assistant() {
  useModel('anthropic/claude-sonnet-4-6');
  useSandbox({
    // Lazy, per the SandboxFactory contract: constructing this object is
    // cheap; the expensive Daytona sandbox creation happens once, inside
    // createSandbox(), at initialization — never on a re-render.
    async createSandbox(options) {
      const client = new Daytona({ apiKey: env.DAYTONA_API_KEY });
      const sandbox = await client.create();
      return daytona(sandbox).createSandbox(options);
    },
  });
}
```

Configure images, snapshots, regions, environment variables, and volumes through the Daytona SDK before passing the sandbox to `daytona(...)`. For a narrower working directory, configure `cwd` on the agent’s `useSandbox(...)` call; Flue resolves it once against the adapter’s provider-owned base directory during `init()`.

See [Sandboxes](/docs/guide/sandboxes/#remote-sandboxes), [Sandbox Adapter API](/docs/reference/sandbox-api/), and [Daytona’s TypeScript SDK reference](https://www.daytona.io/docs/en/typescript-sdk/daytona/).


## Docs Navigation

Current page: [Daytona](/docs/ecosystem/sandboxes/daytona/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


