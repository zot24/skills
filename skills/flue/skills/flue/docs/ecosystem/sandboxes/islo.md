> Source: https://flueframework.com/docs/ecosystem/sandboxes/islo

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# islo


Last updated Jul 21, 2026<a href="/docs/ecosystem/sandboxes/islo/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


The islo adapter adapts a named islo sandbox into Flue’s sandbox interface by invoking the local `islo` CLI. It is designed for a Node.js server, container, or CI runner where the binary is installed and can launch remote commands.

## Quickstart

Add named remote sandbox capability to an existing Flue project with the [islo](https://islo.dev) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add sandbox islo
```

## Overview

The islo blueprint creates `sandboxes/islo.ts` in your source-root without adding an npm dependency. The generated adapter uses Node’s child-process API and expects an authenticated `islo` binary plus an application-managed sandbox name.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>// flue-blueprint: sandbox/islo@1
import { spawn } from &#39;node:child_process&#39;;
import { createSandboxSessionEnv } from &#39;@flue/runtime&#39;;
import type { SandboxApi, SandboxFactory, SessionEnv, FileStat } from &#39;@flue/runtime&#39;;

export interface IsloAdapterOptions {
  cwd?: string;
  cliPath?: string;
}

const q = (s: string) =&gt; `&#39;${s.replace(/&#39;/g, `&#39;\\&#39;&#39;`)}&#39;`;

class IsloSandboxApi implements SandboxApi {
  constructor(
    private name: string,
    private cliPath: string,
  ) {}

  async exec(
    command: string,
    options?: {
      cwd?: string;
      env?: Record&lt;string, string&gt;;
      timeoutMs?: number;
      signal?: AbortSignal;
    },
  ): Promise&lt;{ stdout: string; stderr: string; exitCode: number }&gt; {
    const cd = options?.cwd ? `cd ${q(options.cwd)} &amp;&amp; ` : &#39;&#39;;
    const envPrefix = options?.env
      ? Object.entries(options.env)
          .map(([k, v]) =&gt; `${k}=${q(v)}`)
          .join(&#39; &#39;) + &#39; &#39;
      : &#39;&#39;;
    const tmo =
      typeof options?.timeoutMs === &#39;number&#39; ? `timeout ${options.timeoutMs / 1000} ` : &#39;&#39;;
    const remote = `${envPrefix}${tmo}bash -lc ${q(cd + command)}`;
    const args = [&#39;--output&#39;, &#39;json&#39;, &#39;use&#39;, this.name, &#39;--&#39;, &#39;bash&#39;, &#39;-lc&#39;, remote];

    /* ... spawn the islo CLI and map its output and exit code ... */
  }

  /* ... generated file operations using quoted remote shell commands ... */
}

export function islo(name: string, options?: IsloAdapterOptions): SandboxFactory {
  const cliPath = options?.cliPath ?? &#39;islo&#39;;
  return {
    async createSessionEnv(): Promise&lt;SessionEnv&gt; {
      const sandboxCwd = options?.cwd ?? &#39;/workspace&#39;;
      const api = new IsloSandboxApi(name, cliPath);
      return createSandboxSessionEnv(api, sandboxCwd);
    },
  };
}</code></pre>
<figcaption><span>&lt;source-root&gt;/sandboxes/islo.ts (abridged)</span></figcaption>
</figure>

Pass a sandbox name to `islo(...)` and assign the returned factory to an agent’s `sandbox` property. Flue resolves relative paths from `/workspace`; the adapter converts `timeoutMs` from milliseconds to seconds for GNU `timeout` inside the sandbox, while the CLI handles remote execution and file operations.

## Configure

| Variable       | Purpose                                                                                                                |
|----------------|------------------------------------------------------------------------------------------------------------------------|
| `ISLO_API_KEY` | **Alternative authentication** — Authenticates server or CI operation when existing CLI authentication is unavailable. |

| Requirement                            | Purpose                                                                   |
|----------------------------------------|---------------------------------------------------------------------------|
| Existing CLI authentication or API key | **Required** — Authenticates through the CLI session or `ISLO_API_KEY`.   |
| Node.js child-process capability       | **Required** — Allows the adapter to invoke the CLI.                      |
| `islo` binary on `PATH`                | **Required** — Executes remote shell and file operations.                 |
| Named islo sandbox                     | **Required** — Identifies the application- or deployment-managed sandbox. |

## Choose this adapter when

Use islo when an application can rely on a host-installed CLI and wants to connect to named sandboxes from a Node execution environment. Do not use it in Cloudflare Workers or other runtimes that cannot execute native child processes.

The adapter runs remote shell/file work through the CLI; ensure its host process, credentials, and agent inputs match your intended trust boundary.

See [Deploy on Node.js](/docs/ecosystem/deploy/node/), [Sandboxes](/docs/guide/sandboxes/), and [Sandbox Adapter API](/docs/reference/sandbox-api/).


## Docs Navigation

Current page: [islo](/docs/ecosystem/sandboxes/islo/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


