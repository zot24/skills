# Pin policy

Every source in `sync.json` points at an immutable upstream tag, never `master`. The tag is recorded
in the generator and repeated in each generated header.

## Why pin

The package vendors **command bodies** — the protocol an agent executes. A body that changes under
the agent silently changes behaviour, and the failure mode is not a build error but a wrong action
taken on somebody's knowledge base. A tag makes the surface reviewable.

## What this costs

Because the sources are immutable, the twice-monthly sync refetches identical bytes forever. The
pinned version can never advance on its own, and no check reports that a newer upstream exists. When
upstream ships a new version, this package keeps shipping the old command surface with a green CI
until someone bumps it deliberately.

That is the intended trade, not an oversight. It is worth re-reading whenever the sync report for
this package shows no changes for a long stretch — that is the expected output, so it carries no
signal.

## Bumping the pin

1. Read the upstream diff between the current tag and the target tag. Command bodies are protocol:
   read them, do not skim.
2. Update the tag and commit sha in `scripts/generate-skills.py`.
3. Re-run the generator against a checkout of the new tag so `vendor/` and the generated files move
   together.
4. Regenerate `sync.json` so every source URL carries the new tag.
5. Check that the CLI-using commands still match what the CLI of that version accepts — read
   [cli](cli.md).
6. Review the generated diff. A body change is a behaviour change.

## Never master

A `master` URL would make the vendored copy drift between syncs with no diff to review, which is the
exact failure the pin exists to prevent.
