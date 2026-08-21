# The llm-wiki CLI

Most commands in this package are protocol text. The agent reads the body and acts with its own
tools. Three commands are different: they shell out to an `llm-wiki` binary.

| Command | Hermes slash | Why it needs the CLI |
|---|---|---|
| adapter | `/wiki-adapter` | Deterministic intent routing, registration, `doctor`, and governed `run` |
| specialist | `/wiki-specialist` | Listing and invoking private specialist methods |
| research | `/wiki-research` | Enumerating specialists before a research sweep |

## This package ships no binary

Upstream writes those invocations as `${CLAUDE_PLUGIN_ROOT}/bin/llm-wiki`, which assumes a CLI
bundled inside the installed plugin root. **This package vendors command bodies only.** It has no
`bin/` directory, so that path never resolves and the three commands failed at the first shell call.

The generated bodies therefore resolve the command themselves:

```bash
if [ -x "./scripts/llm-wiki" ]; then
  LLM_WIKI="./scripts/llm-wiki"           # source checkout
elif command -v llm-wiki >/dev/null 2>&1; then
  LLM_WIKI="llm-wiki"                     # installed on PATH
else
  echo "llm-wiki CLI not found. Install nvk/llm-wiki and put llm-wiki on PATH," >&2
  echo "or run from a source checkout that provides scripts/llm-wiki." >&2
  exit 1
fi
```

Order matters. A source checkout wins, because a contributor working inside the upstream repository
means the checkout's CLI, not whatever is installed globally.

## Fail closed

The resolver exits non-zero when neither is present. The other 24 commands do not touch the CLI and
keep working, so a missing binary degrades three commands rather than the whole package.

## Installing the CLI

Install upstream [nvk/llm-wiki](https://github.com/nvk/llm-wiki) and put its `llm-wiki` on `PATH`.
Match the CLI to the pin this package tracks — read [pin](pin.md).

## Alternatives that were not taken

- **Vendor the binary.** It would make the upstream path literally true, at the cost of shipping and
  re-vendoring an executable on every version bump, plus a licence and provenance surface.
- **Drop the three commands.** Smallest surface, but it removes working functionality from anyone
  who does have the CLI.

Resolving from PATH keeps all 27 commands present and turns a silent runtime failure into one clear
message.
