<!-- Source: https://flueframework.com/docs/ecosystem/sandboxes/exedev -->

The exe.dev adapter adapts an existing exe.dev VM into Flue’s sandbox interface using SSH for commands and SFTP for files. Because it depends on Node.js APIs and `ssh2`, use it with the Node target rather than a Cloudflare Worker target.

## Quickstart [\#](https://flueframework.com/docs/ecosystem/sandboxes/exedev/\#quickstart)

Add SSH-backed sandbox capability to an existing Flue project with the [exe.dev](https://exe.dev/) blueprint. Run the following command in your terminal or coding agent of choice:

```
flue add sandbox exedev
```

## Overview [\#](https://flueframework.com/docs/ecosystem/sandboxes/exedev/\#overview)

The blueprint installs `ssh2` and its TypeScript declarations, then creates `sandboxes/exedev.ts` in your source-root. The generated Node adapter uses SSH and SFTP for an existing VM and also exports optional helpers for explicit VM creation, cloning, readiness checks, and deletion.

```
// flue-blueprint: sandbox/exedev@1
import { createSandboxSessionEnv } from '@flue/runtime';
import type { FileStat, SandboxApi, SandboxFactory, SessionEnv } from '@flue/runtime';
import * as fs from 'node:fs';
import * as os from 'node:os';
import * as path from 'node:path';
import { Client as SSHClient } from 'ssh2';
import type { ConnectConfig, SFTPWrapper } from 'ssh2';

/* ... generated VM and option interfaces, error type, and HTTPS lifecycle helpers ... */
/* ... generated SSH authentication, retry, connection, and stream interfaces ... */

export class ExeDevSandboxApi implements SandboxApi {
  /* ... generated SFTP connection and file operations ... */

  async exec(
    command: string,
    options?: {
      cwd?: string;
      env?: Record<string, string>;
      timeoutMs?: number;
      signal?: AbortSignal;
    },
  ): Promise<{ stdout: string; stderr: string; exitCode: number }> {
    /* ... generate the SSH command from env, cwd, and command ... */
    /* ... collect both output streams and close the stream after timeoutMs ... */
    /* ... return exit code 124 when the timeout closes the stream ... */
  }
}

export function exedev(vm: ExeDevVm | string, options?: ExeDevAdapterOptions): SandboxFactory {
  const resolvedVm = typeof vm === 'string' ? { host: vm } : vm;
  return {
    async createSessionEnv(): Promise<SessionEnv> {
      const { ssh } = await sshConnect(resolvedVm, options ?? {});
      const api = new ExeDevSandboxApi(ssh);

      let sandboxCwd = '/home/user';
      try {
        const { stdout } = await api.exec('echo $HOME');
        const detected = stdout.trim();
        if (detected) sandboxCwd = detected;
      } catch {
        /* ... retain /home/user when home-directory detection fails ... */
      }

      return createSandboxSessionEnv(api, sandboxCwd);
    },
  };
}
```

Pass an SSH-reachable VM hostname or `ExeDevVm` to `exedev(...)` and assign the returned factory to an agent’s `sandbox` property. Flue uses the detected remote home directory when available; `timeoutMs` remains in milliseconds and closes the SSH command stream at the deadline, returning exit code 124. File removal uses SFTP directly, so recursive and force options are rejected before mutation rather than emulated with a one-off shell command.

## Configure [\#](https://flueframework.com/docs/ecosystem/sandboxes/exedev/\#configure)

| Variable | Purpose |
| --- | --- |
| `EXE_VM_HOST` | **Required** — Identifies the exe.dev VM used to wire the sandbox adapter. |
| `EXE_SSH_KEY` | **Optional** — Points to a private SSH key file. |
| `SSH_AUTH_SOCK` | **Optional** — Authenticates through an SSH agent instead of `EXE_SSH_KEY`. |
| `EXE_API_TOKEN` | **Required for lifecycle examples** — Authenticates helpers that manage exe.dev VM lifecycle. |

| Requirement | Purpose |
| --- | --- |
| Node.js target | **Required** — Provides the Node APIs used by the adapter and SSH client. |
| `ssh2` package | **Required** — Provides SSH command execution and SFTP file access. |
| Existing SSH-reachable exe.dev VM | **Required** — Supplies the remote sandbox resource. |
| SSH configuration | **Required** — Authenticates access to the VM. |

## Choose this adapter when [\#](https://flueframework.com/docs/ecosystem/sandboxes/exedev/\#choose-this-adapter-when)

Use exe.dev when a Node-hosted Flue application should operate inside a VM you reach through SSH/SFTP. The adapter blueprint includes optional lifecycle helpers, but the sandbox adapter itself is designed around a VM your application owns.

Treat SSH keys and provider tokens as server-side secrets. Decide whether agent instances share or allocate VMs, and clean up application-owned VMs according to your retention policy.

See [Deploy on Node.js](https://flueframework.com/docs/ecosystem/deploy/node/), [Sandboxes](https://flueframework.com/docs/guide/sandboxes/), and [Sandbox Adapter API](https://flueframework.com/docs/api/sandbox-api/).

## Docs Navigation

Current page: [exe.dev](https://flueframework.com/docs/ecosystem/sandboxes/exedev/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
