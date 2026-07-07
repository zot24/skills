> Source: https://flueframework.com/docs/ecosystem/sandboxes/boxd

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# boxd


Last updated May 30, 2026 <a href="/docs/ecosystem/sandboxes/boxd/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


The boxd adapter adapts an already-initialized boxd `Box` from `@boxd-sh/sdk` into Flue’s sandbox interface. Use it when an agent needs a provider-backed Linux virtual machine with filesystem and shell behavior rather than the lightweight default workspace.

## Quickstart

Add provider-backed Linux VM sandbox capability to an existing Flue project with the [boxd](https://boxd.sh) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add sandbox boxd
```

## Overview

The boxd blueprint installs `@boxd-sh/sdk` when needed and creates `sandboxes/boxd.ts` in your source-root. The generated adapter accepts an application-created boxd `Box`; it does not create, retain, or delete the VM.

``` astro-code
// flue-blueprint: sandbox/boxd@1
import { createSandboxSessionEnv } from '@flue/runtime';
import type { SandboxApi, SandboxFactory, SessionEnv, FileStat } from '@flue/runtime';
import type { Box as BoxdBox } from '@boxd-sh/sdk';

export interface BoxdAdapterOptions {
  cwd?: string;
  readyTimeoutMs?: number;
}

async function waitForReady(box: BoxdBox, timeoutMs: number): Promise<void> {
  /* Polls box.exec(['true']) until the VM is ready or the deadline passes. */
}

function shellQuote(value: string): string {
  return `'${value.replace(/'/g, `'\\''`)}'`;
}

class BoxdSandboxApi implements SandboxApi {
  constructor(private box: BoxdBox) {}

  /* Adapts direct boxd file reads and writes. */

  /* Implements stat, readdir, exists, mkdir, and rm with quoted shell utilities. */

  /* Runs commands through bash -lc and forwards env and timeoutMs unchanged. */
}

export function boxd(box: BoxdBox, options?: BoxdAdapterOptions): SandboxFactory {
  let readyPromise: Promise<void> | undefined;
  return {
    async createSessionEnv(): Promise<SessionEnv> {
      const sandboxCwd = options?.cwd ?? '/home/boxd';
      readyPromise ??= waitForReady(box, options?.readyTimeoutMs ?? 30_000);
      await readyPromise;
      const api = new BoxdSandboxApi(box);
      return createSandboxSessionEnv(api, sandboxCwd);
    },
  };
}
```

Passing `boxd(box)` as an agent’s `sandbox` waits for that VM’s exec endpoint once, then exposes its files and Linux shell through Flue. Relative paths resolve from `/home/boxd` unless you set `cwd`; command timeouts remain in milliseconds, `stat` validates GNU metadata output, and `rm` receives the requested recursive and force flags, while VM identity, credentials, networking, persistence, and cleanup remain application-owned.

## Configure

| Variable       | Purpose                                                                                                            |
|----------------|--------------------------------------------------------------------------------------------------------------------|
| `BOXD_API_KEY` | **Alternative authentication** — Authenticates with boxd when a short-lived token is not used.                     |
| `BOXD_TOKEN`   | **Alternative authentication** — Provides provider-supported short-lived authentication instead of `BOXD_API_KEY`. |

| Requirement                 | Purpose                                                          |
|-----------------------------|------------------------------------------------------------------|
| One boxd credential         | **Required** — Uses either `BOXD_API_KEY` or `BOXD_TOKEN`.       |
| `@boxd-sh/sdk` package      | **Required** — Creates the Linux VM adapted to `SandboxFactory`. |
| Application-owned lifecycle | **Required** — Creates, reuses, and deletes the VM.              |

The generated adapter expects your application to create and own the boxd VM. It does not decide VM identity, retention, or cleanup for you.

## Use it when

Choose boxd when a task requires real Linux command behavior in an isolated provider VM, particularly where a separate VM per workspace or agent instance is part of your application design.

Before reusing a VM across sessions or tenants, define identity, authorization, egress, secrets, and cleanup policies. Conversation persistence remains controlled separately by Flue session storage.

See [Sandboxes](/docs/guide/sandboxes/) for execution-boundary design and [Sandbox Adapter API](/docs/api/sandbox-api/) for the adapter contract.


## Docs Navigation

Current page: [boxd](/docs/ecosystem/sandboxes/boxd/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


