# auto-wiki — rewrite high-level wiki pages from a git diff

The published script lives in this package: `scripts/auto-wiki.py`. Do not keep a second
copier in a consumer repo. A hook **calls** this script. It does not paste a source file
into a wiki article.

nvk `wiki-manager` stays a **separate install**. This script rewrites high-level Project
pages from a git diff. It does not compile the hub. It is not wiki-manager.

Pattern (Danny / nvk / Karpathy): [patterns/auto-wiki.md](patterns/auto-wiki.md). Catalog: [patterns/README.md](patterns/README.md).

## Pattern

```
main HEAD moves → diff the code → rewrite only the pages that cover those files → commit
```

Agents pull that map instead of walking the tree.

## Hard rules

1. Trigger only when `main` moves. Other branches skip.
2. Operator switch: `.git/hooks/auto-wiki.enabled` must exist (contents `on`). Absent = no run.
3. Update only pages the diff touches, via `AUTO-WIKI-MAP.tsv` in the wiki Project.
4. Each changed page names `generated: <sha>..<sha>`.
5. Skip lockfiles, `dist/`, `assets/`, and the Project folder itself.
6. **Rewrite from the diff.** Headings, what changed, symbols. Never assign the source file
   body as the article body. `<!-- SYNC -->` paste is the old copier; this script does not
   do that.
7. Pages are a map. **Code wins** if they disagree. Do not copy a generated page into a
   skill as law.
8. `WHY.md` stays human. Do not map it.

## Map file

Tab-separated, in the wiki Project directory:

```
# source-relative-to-repo<TAB>article.md
docs/patterns/auto-wiki.md	patterns.md
docs/staffing.md	staffing.md
```

A source that ends with `/` is a prefix: any changed path under it maps to that article.

## Hook install (by hand)

This skill does **not** write git hooks when installed. First consumer: point `post-commit`
and `post-merge` at `scripts/auto-wiki.py` (or a one-line wrapper that `exec`s it). Keep the
`auto-wiki.enabled` switch in front of the `exec`.

```bash
# post-commit (after the enabled test and range = HEAD^..HEAD)
exec python3 "$TOWER_SKILL_ROOT/scripts/auto-wiki.py" --range "$range" --repo "$root"
```

Open question: whether `zskills install tower` should also write hooks. Do not invent a
global installer in this package.

## CLI

```bash
python3 scripts/auto-wiki.py --range <a>..<b> --repo <git-root> \
  [--wiki <hub>] [--project <rel>] [--map AUTO-WIKI-MAP.tsv] \
  [--allow-branch] [--no-commit]
```

`--wiki` defaults to `$WIKI_HUB` or `~/wiki`. `--project` is `$WIKI_PROJECT`
(relative to the hub). The consumer sets it. This skill does not name a house path.
