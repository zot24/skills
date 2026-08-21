# Layout: vendored, generated, and hand-written

This package has three kinds of file. Editing the wrong kind loses the edit.

| Path | Kind | Edit it? |
|---|---|---|
| `vendor/commands/*.md` | Vendored from upstream, and a sync target | **No.** The sync workflow overwrites it |
| `vendor/wiki-manager/**`, `vendor/wiki-query/**` | Vendored, sync targets | **No** |
| `skills/<name>/SKILL.md` | Generated from `vendor/` | **No.** Regeneration overwrites it |
| `commands/<name>.md` | Generated from `vendor/` | **No.** Regeneration overwrites it |
| `skills/nvk-wiki-hermes/SKILL.md` | Generated package index | **No** |
| `scripts/generate-skills.py` | The generator | **Yes.** This is where behaviour changes go |
| `skills/nvk-wiki-hermes/docs/*.md` | Hand-written | **Yes** |
| `README.md`, `sync.json` | Hand-written and generated respectively | See below |

## The pipeline

```
upstream tag  ──sync──▶  vendor/  ──generate-skills.py──▶  skills/<name>/SKILL.md
                                                        └─▶  commands/<name>.md
                                                        └─▶  skills/nvk-wiki-hermes/SKILL.md
```

`sync.json` records the same order: *"After sync, run `scripts/generate-skills.py` to rebuild
embedded SKILL.md files from vendor/commands."*

## Why a hand edit disappears

A generated file is rewritten from `vendor/` on the next regeneration. A vendored file is refetched
from the pinned tag on the next sync. So a fix applied directly to `commands/wiki-adapter.md`
survives exactly until someone runs either step.

Any change to what the commands say belongs in `scripts/generate-skills.py`, followed by a
regeneration. The diff then covers both the generator and its outputs, which is how a reviewer can
see that the two agree.

## Regenerating

The generator's `vendor_sources()` step copies from a local checkout of the pinned upstream tag and
exits if that checkout is absent. To rebuild only from the already-vendored copies, call the writer
functions directly and skip that step.

Regeneration is byte-reproducible: running it against an unmodified tree produces no diff. That
property is what makes the generated files safe to review — any diff is caused by the generator
change above it, never by drift.
