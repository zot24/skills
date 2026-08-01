> Source: https://flueframework.com/docs/ecosystem/sandboxes/vercel

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Vercel Sandbox


Last updated Jul 21, 2026<a href="/docs/ecosystem/sandboxes/vercel/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


The Vercel Sandbox adapter adapts an initialized `@vercel/sandbox` `Sandbox` into Flue’s sandbox interface. Use it when application code should execute agent work inside a Vercel-managed sandbox rather than on its host filesystem.

## Quickstart

Add managed Linux sandbox capability to an existing Flue project with the [Vercel Sandbox](https://vercel.com/sandbox) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add sandbox vercel
```

## Overview

The blueprint installs `@vercel/sandbox` when needed and creates `sandboxes/vercel.ts` in your source-root. The generated adapter accepts an initialized Vercel `Sandbox`; authentication, runtime selection, retention, and cleanup remain application-owned.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>// flue-blueprint: sandbox/vercel@1
import { createSandboxSessionEnv, useModel } from &#39;@flue/runtime&#39;;
import type { SandboxApi, SandboxFactory, SessionEnv, FileStat } from &#39;@flue/runtime&#39;;
import type { Sandbox as VercelSandbox } from &#39;@vercel/sandbox&#39;;

class VercelSandboxApi implements SandboxApi {
  constructor(private sandbox: VercelSandbox) {}

  /* ... generated filesystem operations using sandbox.fs ... */

  async stat(path: string): Promise&lt;FileStat&gt; {
    const stat = await this.sandbox.fs.stat(path);
    return {
      isFile: stat.isFile(),
      isDirectory: stat.isDirectory(),
      isSymbolicLink: stat.isSymbolicLink(),
      size: stat.size,
      mtime: stat.mtime,
    };
  }

  async exec(
    command: string,
    options?: {
      cwd?: string;
      env?: Record&lt;string, string&gt;;
      timeoutMs?: number;
      signal?: AbortSignal;
    },
  ): Promise&lt;{ stdout: string; stderr: string; exitCode: number }&gt; {
    const timeoutSignal =
      typeof options?.timeoutMs === &#39;number&#39; ? AbortSignal.timeout(options.timeoutMs) : undefined;
    const callerSignal = options?.signal;
    const signal =
      callerSignal &amp;&amp; timeoutSignal
        ? AbortSignal.any([callerSignal, timeoutSignal])
        : (callerSignal ?? timeoutSignal);

    try {
      const response = await this.sandbox.runCommand({
        cmd: &#39;bash&#39;,
        args: [&#39;-c&#39;, command],
        cwd: options?.cwd,
        env: options?.env,
        signal,
      });
      const [stdout, stderr] = await Promise.all([
        response.stdout({ signal }),
        response.stderr({ signal }),
      ]);
      return { stdout, stderr, exitCode: response.exitCode };
    } catch (err) {
      if (callerSignal?.aborted) throw err;
      const aborted =
        timeoutSignal?.aborted &amp;&amp;
        (err === timeoutSignal.reason ||
          (err instanceof Error &amp;&amp; (err.name === &#39;AbortError&#39; || err.name === &#39;TimeoutError&#39;)));
      if (aborted) {
        return {
          stdout: &#39;&#39;,
          stderr: `[flue:vercel] Command timed out after ${options?.timeoutMs} milliseconds.`,
          exitCode: 124,
        };
      }
      throw err;
    }
  }
}

export function vercel(sandbox: VercelSandbox): SandboxFactory {
  return {
    async createSessionEnv(): Promise&lt;SessionEnv&gt; {
      const sandboxCwd = &#39;/vercel/sandbox&#39;;
      const api = new VercelSandboxApi(sandbox);
      return createSandboxSessionEnv(api, sandboxCwd);
    },
  };
}</code></pre>
<figcaption><span>&lt;source-root&gt;/sandboxes/vercel.ts (abridged)</span></figcaption>
</figure>

Pass an initialized Vercel `Sandbox` to `vercel(...)` and pass the returned factory to the agent’s `useSandbox(...)` call. The adapter maps the provider’s complete file stat, resolves relative paths from `/vercel/sandbox`, forwards a composed signal to command execution and output reads, propagates caller cancellation, and maps only `timeoutMs` cancellation to exit code 124.

## Configure

| Variable            | Purpose                                                                                                             |
|---------------------|---------------------------------------------------------------------------------------------------------------------|
| `VERCEL_OIDC_TOKEN` | **Required for OIDC authentication** — Injected automatically on Vercel; set it explicitly when using OIDC locally. |

| Requirement                     | Purpose                                                                                                      |
|---------------------------------|--------------------------------------------------------------------------------------------------------------|
| Vercel-supported authentication | **Required** — Uses OIDC on Vercel or an access token or other supported authentication flow outside Vercel. |
| `@vercel/sandbox` package       | **Required** — Creates the Vercel Sandbox adapted by Flue.                                                   |
| Application-owned lifecycle     | **Required** — Creates the sandbox and decides its retention and cleanup.                                    |

## Typical use

``` astro-code
import { Sandbox } from '@vercel/sandbox';
import { useModel, useSandbox } from '@flue/runtime';
import { vercel } from '../sandboxes/vercel';

export function Assistant() {
  useModel('anthropic/claude-sonnet-4-6');
  useSandbox({
    // Lazy, per the SandboxFactory contract: constructing this object is
    // cheap; the expensive Vercel sandbox creation happens once, inside
    // createSessionEnv(), at initialization — never on a re-render.
    async createSessionEnv(options) {
      const sandbox = await Sandbox.create({ runtime: 'node24' });
      return vercel(sandbox).createSessionEnv(options);
    },
  });
}
```

Keep Vercel authentication values in trusted application configuration and determine whether sandboxes should be fresh per job or reusable for stable agent identities.

See [Sandboxes](/docs/guide/sandboxes/) and [Sandbox Adapter API](/docs/reference/sandbox-api/).


## Docs Navigation

Current page: [Vercel Sandbox](/docs/ecosystem/sandboxes/vercel/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


