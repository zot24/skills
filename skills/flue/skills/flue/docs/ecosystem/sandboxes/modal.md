<!-- Source: https://flueframework.com/docs/ecosystem/sandboxes/modal -->

The Modal adapter adapts an already-initialized Modal Sandbox from the `modal` JavaScript SDK into Flue’s sandbox interface. Use it for provider-backed command execution and files when your application provisions Modal sandbox resources.

## Quickstart [\#](https://flueframework.com/docs/ecosystem/sandboxes/modal/\#quickstart)

Add provider-backed compute sandbox capability to an existing Flue project with the [Modal](https://modal.com/) blueprint. Run the following command in your terminal or coding agent of choice:

```
flue add sandbox modal
```

## Overview [\#](https://flueframework.com/docs/ecosystem/sandboxes/modal/\#overview)

The Modal blueprint installs the `modal` JavaScript SDK when needed and creates `sandboxes/modal.ts` in your source-root. The generated adapter accepts an application-created Modal `Sandbox`; provisioning, image selection, credentials, and shutdown remain outside the adapter.

```
// flue-blueprint: sandbox/modal@1
import { createSandboxSessionEnv } from '@flue/runtime';
import type { SandboxApi, SandboxFactory, SessionEnv, FileStat } from '@flue/runtime';
import type { Sandbox as ModalSandbox } from 'modal';

export interface ModalAdapterOptions {
  cwd?: string;
}

function shellQuote(value: string): string {
  return `'${value.replace(/'/g, `'\\''`)}'`;
}

class ModalSandboxApi implements SandboxApi {
  constructor(private sandbox: ModalSandbox) {}

  /* Adapts Modal open/read/write handles and closes every opened file. */

  /* Implements stat, readdir, exists, mkdir, and rm with quoted shell utilities. */

  /* Runs commands through bash -lc, forwards timeoutMs, and drains both output streams. */
}

export function modal(sandbox: ModalSandbox, options?: ModalAdapterOptions): SandboxFactory {
  return {
    async createSessionEnv(): Promise<SessionEnv> {
      const sandboxCwd = options?.cwd ?? '/';
      const api = new ModalSandboxApi(sandbox);
      return createSandboxSessionEnv(api, sandboxCwd);
    },
  };
}
```

Passing `modal(sandbox)` as an agent’s `sandbox` exposes the created Modal Sandbox’s files and command execution through Flue, with relative paths rooted at `/` unless you set `cwd`. The selected image must provide `bash` and compatible filesystem utilities for operations that Modal’s SDK does not expose directly; the generated `stat` parser supports the output used by GNU and BusyBox `stat`, and `rm` receives the requested recursive and force flags.

## Configure [\#](https://flueframework.com/docs/ecosystem/sandboxes/modal/\#configure)

| Variable | Purpose |
| --- | --- |
| `MODAL_TOKEN_ID` | **Required without `~/.modal.toml`** — Identifies the Modal token when file-based credentials are unavailable. |
| `MODAL_TOKEN_SECRET` | **Required without `~/.modal.toml`** — Authenticates the Modal token when file-based credentials are unavailable. |

| Requirement | Purpose |
| --- | --- |
| `modal` package | **Required** — Provides the Modal JavaScript SDK. |
| Node.js 22 or later | **Required** — Runs the SDK used by the generated adapter. |
| Suitable Modal image | **Required** — Provides the shell and system utilities required by the agent work. |

## Choose this adapter when [\#](https://flueframework.com/docs/ecosystem/sandboxes/modal/\#choose-this-adapter-when)

Use Modal when your application already manages Modal applications, images, or sandbox lifetimes and needs to expose that compute boundary to Flue operations. The adapter adapts the created sandbox; creation, shutdown, secret handling, networking, and image content remain your responsibility.

See [Sandboxes](https://flueframework.com/docs/guide/sandboxes/) and [Sandbox Adapter API](https://flueframework.com/docs/api/sandbox-api/).

## Docs Navigation

Current page: [Modal](https://flueframework.com/docs/ecosystem/sandboxes/modal/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
