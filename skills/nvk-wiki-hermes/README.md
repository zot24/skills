# nvk-wiki-hermes

Hermes `/wiki-*` hyphen slashes for the **entire** [nvk/llm-wiki](https://github.com/nvk/llm-wiki) Claude command surface, pinned to **v0.23.0** (`d02cbcb`).

This is **not** the [llm-wiki expert skill](../llm-wiki). That skill teaches the product. This package **is** the official command bodies, slash-loadable on Hermes. Extending `skills/llm-wiki/` would smash the expert skill, so the command pack lives here.

This is **not** Karpathy's gist wiki. Keep bundled Hermes `llm-wiki` **disabled**.

## Why a new package

| Package | Job |
|---|---|
| `llm-wiki` | Expert digest (structure, upgrade, pinning) |
| `nvk-wiki-hermes` | Operational slashes: `/wiki`, `/wiki-compile`, `/wiki-ingest`, … |

## Slash map

Hermes cannot use colons in slashes. Claude ` /wiki:compile ` is Hermes `/wiki-compile`.

| Claude | Hermes | Skill |
|---|---|---|
| `/wiki` | `/wiki` | `wiki` |
| `/wiki:adapter` | `/wiki-adapter` | `wiki-adapter` |
| `/wiki:archive` | `/wiki-archive` | `wiki-archive` |
| `/wiki:assess` | `/wiki-assess` | `wiki-assess` |
| `/wiki:audit` | `/wiki-audit` | `wiki-audit` |
| `/wiki:collect` | `/wiki-collect` | `wiki-collect` |
| `/wiki:compile` | `/wiki-compile` | `wiki-compile` |
| `/wiki:dataset` | `/wiki-dataset` | `wiki-dataset` |
| `/wiki:feedback` | `/wiki-feedback` | `wiki-feedback` |
| `/wiki:idea` | `/wiki-idea` | `wiki-idea` |
| `/wiki:ingest` | `/wiki-ingest` | `wiki-ingest` |
| `/wiki:ingest-collection` | `/wiki-ingest-collection` | `wiki-ingest-collection` |
| `/wiki:inventory` | `/wiki-inventory` | `wiki-inventory` |
| `/wiki:librarian` | `/wiki-librarian` | `wiki-librarian` |
| `/wiki:lint` | `/wiki-lint` | `wiki-lint` |
| `/wiki:ll` | `/wiki-ll` | `wiki-ll` |
| `/wiki:output` | `/wiki-output` | `wiki-output` |
| `/wiki:plan` | `/wiki-plan` | `wiki-plan` |
| `/wiki:portfolio` | `/wiki-portfolio` | `wiki-portfolio` |
| `/wiki:project` | `/wiki-project` | `wiki-project` |
| `/wiki:query` | `/wiki-query` | `wiki-query` |
| `/wiki:refresh` | `/wiki-refresh` | `wiki-refresh` |
| `/wiki:research` | `/wiki-research` | `wiki-research` |
| `/wiki:retract` | `/wiki-retract` | `wiki-retract` |
| `/wiki:session` | `/wiki-session` | `wiki-session` |
| `/wiki:specialist` | `/wiki-specialist` | `wiki-specialist` |
| `/wiki:thesis` | `/wiki-thesis` | `wiki-thesis` |

Each `skills/wiki-<cmd>/SKILL.md` embeds the official command body so Hermes slash-load does not depend on a second file.

## Pin

- Tag: **v0.23.0**
- Commit: `d02cbcbace84ab14d6ba3b937092c6a8403c2423`
- Commands: `claude-plugin/commands/*.md`
- Protocols: `plugins/llm-wiki-opencode/skills/wiki-manager/references/`
- Query Lite: `plugins/llm-wiki-opencode/skills/wiki-query/SKILL.md`

`sync.json` pulls from `raw.githubusercontent.com/nvk/llm-wiki/v0.23.0/…`, **not** `master`. After a sync, rebuild embeds:

```bash
python3 skills/nvk-wiki-hermes/scripts/generate-skills.py
```

## Hermes install (this machine)

Symlink each skill directory (not the house `nvk-wiki-hermes` contract skill):

```bash
PKG="$PWD/skills/nvk-wiki-hermes/skills"
for dest in \
  "$HOME/.hermes/skills/research" \
  "$HOME/.hermes/profiles/tower/skills/research" \
  "$HOME/.hermes/profiles/herdr-worker/skills/research"
do
  mkdir -p "$dest"
  for skill in "$PKG"/wiki "$PKG"/wiki-*; do
    ln -sfn "$skill" "$dest/$(basename "$skill")"
  done
done
```

`wiki-compile` replaces the leftover house cluster recipe. Do not copy that leftover into this repo.

Keep `skills.disabled` containing `llm-wiki` (Karpathy).

## Usage

```
/wiki                        # router, init, status, config
/wiki-query <question>       # read-only
/wiki-ingest <url-or-path>
/wiki-compile
/wiki-lint
/wiki-audit
```

Do not invent compile/ingest protocols. The vendored body is the protocol.

## License

Vendored nvk command and reference text is MIT, Copyright (c) 2026 nvk. See `LICENSE-nvk`.
