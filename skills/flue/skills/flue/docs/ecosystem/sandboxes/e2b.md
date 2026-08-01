> Source: https://flueframework.com/docs/ecosystem/sandboxes/e2b

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# E2B


Last updated Jul 21, 2026<a href="/docs/ecosystem/sandboxes/e2b/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


The E2B adapter adapts an initialized E2B sandbox from the `e2b` package into Flue’s sandbox interface. Use it for provider-managed Linux execution when an agent needs shell commands and workspace files outside the application host.

## Quickstart

Add provider-managed Linux sandbox capability to an existing Flue project with the [E2B](https://e2b.dev) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add sandbox e2b
```

## Overview

The blueprint installs `e2b` when needed and creates `sandboxes/e2b.ts` in your source-root. That file adapts an E2B sandbox that your application has already created; it does not create, retain, or close provider resources.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>// flue-blueprint: sandbox/e2b@1
import { createSandboxSessionEnv, useModel } from &#39;@flue/runtime&#39;;
import type { SandboxApi, SandboxFactory, SessionEnv, FileStat } from &#39;@flue/runtime&#39;;
import type { Sandbox as E2BSandbox } from &#39;e2b&#39;;

class E2BSandboxApi implements SandboxApi {
  constructor(private sandbox: E2BSandbox) {}

  /* Implements file reads, writes, stat, listing, existence, and mkdir with sandbox.files. */

  /* Rejects recursive or force before calling sandbox.files.remove(). */

  /* Implements exec() with sandbox.commands.run(), forwarding timeoutMs unchanged. */
}

export function e2b(sandbox: E2BSandbox): SandboxFactory {
  return {
    async createSessionEnv(): Promise&lt;SessionEnv&gt; {
      const sandboxCwd = &#39;/home/user&#39;;
      const api = new E2BSandboxApi(sandbox);
      return createSandboxSessionEnv(api, sandboxCwd);
    },
  };
}</code></pre>
<figcaption><span>&lt;source-root&gt;/sandboxes/e2b.ts (abridged)</span></figcaption>
</figure>

Pass an initialized E2B `Sandbox` to `e2b(...)`, then pass the returned factory to the agent’s `useSandbox(...)` call. Flue resolves workspace paths from `/home/user`, exposes E2B’s files and commands through session operations, forwards command timeouts in milliseconds, and reports only the file metadata E2B exposes. E2B’s direct remove API has no recursive or force controls, so the adapter rejects either option before deletion. Your application remains responsible for sandbox configuration and lifecycle.

## Configure

| Variable      | Purpose                                        |
|---------------|------------------------------------------------|
| `E2B_API_KEY` | **Required** — Authenticates with the E2B API. |

| Requirement                    | Purpose                                                                     |
|--------------------------------|-----------------------------------------------------------------------------|
| `e2b` package                  | **Required** — Provides the initialized E2B sandbox adapted by Flue.        |
| Provider-managed Linux sandbox | **Required** — Supplies the command and filesystem environment.             |
| Application-owned lifecycle    | **Required** — Creates the sandbox and closes or retains it as appropriate. |

## Integration shape

``` astro-code
import { Sandbox } from 'e2b';
import { useModel, useSandbox } from '@flue/runtime';
import { e2b } from '../sandboxes/e2b';

export function Assistant() {
  useModel('anthropic/claude-sonnet-4-6');
  useSandbox({
    // Lazy, per the SandboxFactory contract: constructing this object is
    // cheap; the expensive E2B sandbox creation happens once, inside
    // createSessionEnv(), at initialization — never on a re-render.
    async createSessionEnv(options) {
      const sandbox = await Sandbox.create();
      return e2b(sandbox).createSessionEnv(options);
    },
  });
}
```

Select templates, timeouts, network access, secret exposure, and resource reuse through your application and provider policy. Flue adapts the active environment; it does not choose provider retention for you.

See [Sandboxes](/docs/guide/sandboxes/) and [Sandbox Adapter API](/docs/reference/sandbox-api/).


## Docs Navigation

Current page: [E2B](/docs/ecosystem/sandboxes/e2b/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


