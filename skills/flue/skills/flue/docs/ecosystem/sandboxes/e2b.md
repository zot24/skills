<!-- Source: https://flueframework.com/docs/ecosystem/sandboxes/e2b -->

The E2B adapter adapts an initialized E2B sandbox from the `e2b` package into Flue’s sandbox interface. Use it for provider-managed Linux execution when an agent needs shell commands and workspace files outside the application host.

## Quickstart [\#](https://flueframework.com/docs/ecosystem/sandboxes/e2b/\#quickstart)

Add provider-managed Linux sandbox capability to an existing Flue project with the [E2B](https://e2b.dev/) blueprint. Run the following command in your terminal or coding agent of choice:

```
flue add sandbox e2b
```

## Overview [\#](https://flueframework.com/docs/ecosystem/sandboxes/e2b/\#overview)

The blueprint installs `e2b` when needed and creates `sandboxes/e2b.ts` in your source-root. That file adapts an E2B sandbox that your application has already created; it does not create, retain, or close provider resources.

```
// flue-blueprint: sandbox/e2b@1
import { createSandboxSessionEnv } from '@flue/runtime';
import type { SandboxApi, SandboxFactory, SessionEnv, FileStat } from '@flue/runtime';
import type { Sandbox as E2BSandbox } from 'e2b';

class E2BSandboxApi implements SandboxApi {
  constructor(private sandbox: E2BSandbox) {}

  /* Implements file reads, writes, stat, listing, existence, and mkdir with sandbox.files. */

  /* Rejects recursive or force before calling sandbox.files.remove(). */

  /* Implements exec() with sandbox.commands.run(), forwarding timeoutMs unchanged. */
}

export function e2b(sandbox: E2BSandbox): SandboxFactory {
  return {
    async createSessionEnv(): Promise<SessionEnv> {
      const sandboxCwd = '/home/user';
      const api = new E2BSandboxApi(sandbox);
      return createSandboxSessionEnv(api, sandboxCwd);
    },
  };
}
```

Pass an initialized E2B `Sandbox` to `e2b(...)`, then assign the returned factory to an agent’s `sandbox` property. Flue resolves workspace paths from `/home/user`, exposes E2B’s files and commands through session operations, forwards command timeouts in milliseconds, and reports only the file metadata E2B exposes. E2B’s direct remove API has no recursive or force controls, so the adapter rejects either option before deletion. Your application remains responsible for sandbox configuration and lifecycle.

## Configure [\#](https://flueframework.com/docs/ecosystem/sandboxes/e2b/\#configure)

| Variable | Purpose |
| --- | --- |
| `E2B_API_KEY` | **Required** — Authenticates with the E2B API. |

| Requirement | Purpose |
| --- | --- |
| `e2b` package | **Required** — Provides the initialized E2B sandbox adapted by Flue. |
| Provider-managed Linux sandbox | **Required** — Supplies the command and filesystem environment. |
| Application-owned lifecycle | **Required** — Creates the sandbox and closes or retains it as appropriate. |

## Integration shape [\#](https://flueframework.com/docs/ecosystem/sandboxes/e2b/\#integration-shape)

```
import { Sandbox } from 'e2b';
import { createAgent } from '@flue/runtime';
import { e2b } from '../sandboxes/e2b';

const sandbox = await Sandbox.create();
const agent = createAgent(() => ({
  model: 'anthropic/claude-sonnet-4-6',
  sandbox: e2b(sandbox),
}));
```

Select templates, timeouts, network access, secret exposure, and resource reuse through your application and provider policy. Flue adapts the active environment; it does not choose provider retention for you.

See [Sandboxes](https://flueframework.com/docs/guide/sandboxes/) and [Sandbox Adapter API](https://flueframework.com/docs/api/sandbox-api/).

## Docs Navigation

Current page: [E2B](https://flueframework.com/docs/ecosystem/sandboxes/e2b/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
