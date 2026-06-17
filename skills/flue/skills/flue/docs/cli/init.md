<!-- Source: https://flueframework.com/docs/cli/init -->

## Synopsis [\#](https://flueframework.com/docs/cli/init/\#synopsis)

```
flue init --target <node|cloudflare> [--root <path>] [--force]
```

## Description [\#](https://flueframework.com/docs/cli/init/\#description)

`flue init` writes a starter `flue.config.ts`. It does not create agents, workflows, or an application entrypoint.

## Options [\#](https://flueframework.com/docs/cli/init/\#options)

| Option | Default | Description |
| --- | --- | --- |
| `--target <node|cloudflare>` | Required | Select the target written to `flue.config.ts`. |
| `--root <path>` | Current working directory | Select the existing directory in which to write `flue.config.ts`. |
| `--force` | `false` | Write `flue.config.ts` when a `flue.config.*` file already exists. |

Without `--force`, any existing `flue.config.*` file prevents generation. If `--force` writes `flue.config.ts` beside another supported variant, the new `.ts` file takes precedence and the existing file remains on disk.

## Output [\#](https://flueframework.com/docs/cli/init/\#output)

The generated `target` value matches `--target`. For `flue init --target node`, the file is:

```
import { defineConfig } from '@flue/cli/config';

export default defineConfig({
  target: 'node',
});
```

## Examples [\#](https://flueframework.com/docs/cli/init/\#examples)

```
flue init --target node
flue init --target cloudflare --root ./apps/assistant
```

See [Configuration](https://flueframework.com/docs/reference/configuration/) for the complete `flue.config.ts` surface.

## Docs Navigation

Current page: [flue init](https://flueframework.com/docs/cli/init/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
