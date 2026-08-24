#!/usr/bin/env python3
"""Rewrite high-level wiki articles from a git diff.

Never paste a source file body into an article. Code wins if the page and the
tree disagree. Consumer hook calls this script; do not keep a second copier.
"""
from __future__ import annotations

import argparse
import os
import re
import subprocess
import sys
from pathlib import Path

GENERATED_OPEN = "<!-- GENERATED -->"
GENERATED_CLOSE = "<!-- /GENERATED -->"
SKIP_PARTS = {"dist", "assets"}


def run(args, cwd=None, check=True):
    return subprocess.run(args, cwd=cwd, check=check, text=True, capture_output=True)


def git_ok(args, cwd):
    r = subprocess.run(args, cwd=cwd, text=True, capture_output=True)
    return r.returncode == 0, r.stdout, r.stderr


def skip_path(f: str) -> bool:
    if f.endswith(".lock"):
        return True
    parts = f.split("/")
    if any(p in SKIP_PARTS for p in parts):
        return True
    norm = f.replace("\\", "/")
    if "/output/projects/" in "/" + norm:
        return True
    return False


def load_map(path: Path):
    rows = []
    for line in path.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        src, art = line.split("\t", 1)
        rows.append((src.strip(), art.strip()))
    return rows


def article_for(changed: str, rows):
    """Exact map row, else longest prefix row whose source ends with '/'."""
    exact = {src: art for src, art in rows if not src.endswith("/")}
    if changed in exact:
        return exact[changed]
    prefixes = sorted(
        ((src, art) for src, art in rows if src.endswith("/")),
        key=lambda x: len(x[0]),
        reverse=True,
    )
    for src, art in prefixes:
        if changed.startswith(src):
            return art
    return None


def heading_lines(text: str):
    out = []
    for ln in text.splitlines():
        s = ln.strip()
        if s.startswith("#") and not s.startswith("#!"):
            out.append(s)
        elif s.startswith("+#") or s.startswith("-#"):
            out.append(s[1:].strip())
    return out


def symbol_lines(text: str):
    names = []
    pat = re.compile(
        r"^(?:[-+]\s*)?(?:def|class|function|fn|pub fn|export (?:async )?function)\s+(\S+)"
    )
    for ln in text.splitlines():
        m = pat.search(ln.strip())
        if m:
            names.append(m.group(1).rstrip("({:"))
    # unique, stable order
    seen = set()
    uniq = []
    for n in names:
        if n not in seen:
            seen.add(n)
            uniq.append(n)
    return uniq


def summarise_diff(diff_text: str, src_rel: str, rng: str) -> str:
    """High-level rewrite from the unified diff. Never the source file body."""
    added = sum(1 for ln in diff_text.splitlines() if ln.startswith("+") and not ln.startswith("+++"))
    removed = sum(1 for ln in diff_text.splitlines() if ln.startswith("-") and not ln.startswith("---"))
    heads = heading_lines(diff_text)
    syms = symbol_lines(diff_text)
    hunks = [ln[4:].strip() for ln in diff_text.splitlines() if ln.startswith("@@")]
    lines = [
        f"High-level map of `{src_rel}`. Code wins if this page and the tree disagree.",
        "This page is not a copy of the source. Read the tree for the current text.",
        "",
        f"## This range (`{rng}`)",
        "",
        f"- **{src_rel}**: +{added} / −{removed} lines",
    ]
    if heads:
        lines.append("- Headings touched:")
        for h in heads[:24]:
            lines.append(f"  - `{h}`")
    if syms:
        lines.append("- Symbols touched:")
        for s in syms[:24]:
            lines.append(f"  - `{s}`")
    if hunks:
        lines.append("- Hunks:")
        for h in hunks[:16]:
            lines.append(f"  - `{h}`")
    if not heads and not syms and not hunks:
        lines.append("- Diff had no headings or symbols. Stat only. Read the tree.")
    lines.append("")
    return "\n".join(lines).rstrip() + "\n"


def outline_from_headings(src_path: Path, src_rel: str, rng: str) -> str:
    """First page: headings only. Not the source body."""
    text = src_path.read_text() if src_path.is_file() else ""
    heads = [ln.strip() for ln in text.splitlines() if ln.strip().startswith("#") and not ln.strip().startswith("#!")]
    lines = [
        f"High-level map of `{src_rel}`. Code wins if this page and the tree disagree.",
        "This page is not a copy of the source. Read the tree for the current text.",
        "",
        f"## Outline at `{rng}` (headings only)",
        "",
    ]
    if heads:
        for h in heads[:40]:
            lines.append(f"- `{h}`")
    else:
        lines.append("- No markdown headings in the source. Read the tree.")
    lines.append("")
    return "\n".join(lines).rstrip() + "\n"


def title_of(art: str) -> str:
    return Path(art).stem.replace("-", " ")


def compose(rng: str, src_rel: str, body: str, existing: str) -> str:
    """Keep human text outside GENERATED. Replace generated range + body."""
    fm_src = f"source: {src_rel}"
    gen = f"generated: {rng}"
    inner = f"{GENERATED_OPEN}\n{body.rstrip()}\n{GENERATED_CLOSE}\n"
    if existing.startswith("---"):
        m = re.match(r"^---\n(.*?)\n---\n", existing, re.S)
        if not m:
            raise SystemExit(f"auto-wiki: bad frontmatter")
        fm = m.group(1)
        rest = existing[m.end() :]
        if re.search(r"^generated:", fm, re.M):
            fm = re.sub(r"^generated:.*$", gen, fm, count=1, flags=re.M)
        else:
            fm = gen + "\n" + fm
        if re.search(r"^source:", fm, re.M):
            fm = re.sub(r"^source:.*$", fm_src, fm, count=1, flags=re.M)
        else:
            fm = fm + "\n" + fm_src
        if GENERATED_OPEN in rest:
            pre, _, tail = rest.partition(GENERATED_OPEN)
            _, _, after = tail.partition(GENERATED_CLOSE)
            after_clean = after.lstrip("\n")
            new = f"---\n{fm}\n---\n{pre}{inner}{after_clean}"
        elif "<!-- SYNC -->" in rest:
            # Old copier body. Drop it. Code wins. Keep nothing of the paste.
            new = f"---\n{fm}\n---\n\n# {title_of(src_rel)}\n\n{inner}"
        else:
            new = f"---\n{fm}\n---\n{rest.rstrip()}\n\n{inner}"
        if not new.endswith("\n"):
            new += "\n"
        return new
    return f"---\n{gen}\n{fm_src}\n---\n\n# {title_of(src_rel)}\n\n{inner}"


def current_branch(repo: Path) -> str:
    ok, out, _ = git_ok(["git", "rev-parse", "--abbrev-ref", "HEAD"], repo)
    return out.strip() if ok else ""


def parse_args(argv):
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--range", required=True, help="git range a..b")
    p.add_argument("--repo", required=True, help="git repo whose diff we rewrite from")
    p.add_argument("--wiki", default=os.environ.get("WIKI_HUB") or str(Path.home() / "wiki"))
    p.add_argument("--project", default=os.environ.get("WIKI_PROJECT") or "",
                   help="hub-relative wiki Project directory")
    p.add_argument("--map", default="AUTO-WIKI-MAP.tsv")
    p.add_argument("--allow-branch", action="store_true", help="run even when HEAD is not main")
    p.add_argument("--no-commit", action="store_true", help="write files, do not commit the hub")
    return p.parse_args(argv)


def main(argv=None) -> int:
    args = parse_args(argv if argv is not None else sys.argv[1:])
    rng = args.range.strip()
    repo = Path(args.repo).resolve()
    wiki = Path(args.wiki).expanduser().resolve()
    if not args.project.strip():
        print("auto-wiki: set --project or WIKI_PROJECT", file=sys.stderr)
        return 2
    projrel = args.project.strip().lstrip("/")
    proj = wiki / projrel
    mapp = proj / args.map
    if not proj.is_dir() or not mapp.is_file():
        print(f"auto-wiki: missing Project or map at {proj}", file=sys.stderr)
        return 1

    if not args.allow_branch:
        br = current_branch(repo)
        if br != "main":
            print(f"auto-wiki: skip (HEAD is {br or 'unknown'}, want main)")
            return 0

    if ".." not in rng:
        print(f"auto-wiki: skip (need a..b range, got {rng})")
        return 0
    left, right = rng.split("..", 1)
    ok_l, _, _ = git_ok(["git", "rev-parse", "--verify", left], repo)
    ok_r, _, _ = git_ok(["git", "rev-parse", "--verify", right], repo)
    if not ok_l or not ok_r:
        print(f"auto-wiki: skip (unresolvable range {rng})")
        return 0
    if left == right:
        print(f"auto-wiki: skip (no-op range {rng})")
        return 0
    quiet = run(["git", "diff", "--quiet", rng, "--"], cwd=repo, check=False)
    if quiet.returncode == 0:
        print(f"auto-wiki: skip (empty diff {rng})")
        return 0

    names = run(["git", "diff", "--name-only", rng], cwd=repo).stdout.splitlines()
    changed = [f for f in names if f and not skip_path(f)]
    if not changed:
        print(f"auto-wiki: skip (only lock/dist/assets/project files in {rng})")
        return 0

    rows = load_map(mapp)
    jobs = []
    seen_art = set()
    for f in changed:
        art = article_for(f, rows)
        if not art or art in seen_art:
            continue
        if art.lower() == "why.md":
            continue
        seen_art.add(art)
        jobs.append((art, f))
    if not jobs:
        print(f"auto-wiki: skip (no mapped files in {rng})")
        return 0

    updated = []
    for art, src_rel in jobs:
        dest = proj / art
        dest.parent.mkdir(parents=True, exist_ok=True)
        diff = run(["git", "diff", rng, "--", src_rel], cwd=repo).stdout
        if dest.exists() and dest.stat().st_size > 0 and "<!-- SYNC -->" not in dest.read_text():
            body = summarise_diff(diff, src_rel, rng)
        else:
            # First page, or old byte-copy: headings + this range's diff. Not the source body.
            outline = outline_from_headings(repo / src_rel, src_rel, rng)
            summary = summarise_diff(diff, src_rel, rng)
            body = outline + "\n" + summary
        existing = dest.read_text() if dest.exists() else ""
        dest.write_text(compose(rng, src_rel, body, existing))
        updated.append(art)

    summary = ", ".join(updated)
    print(f"auto-wiki: updated {summary} from {rng}")

    if args.no_commit:
        return 0
    if not (wiki / ".git").exists():
        print("auto-wiki: hub is not a git repo; wrote files only (no commit)")
        return 0

    rels = [f"{projrel}/{art}" for art in updated]
    run(["git", "add", "--"] + rels, cwd=wiki)
    cached = run(["git", "diff", "--cached", "--quiet"], cwd=wiki, check=False)
    if cached.returncode == 0:
        print("auto-wiki: no wiki content change after rewrite")
        return 0
    msg = f"docs(tower): {rng} Why: rewrite wiki map from diff ({summary})"
    run(["git", "commit", "-m", msg], cwd=wiki)
    print("auto-wiki: committed in wiki hub")
    return 0


if __name__ == "__main__":
    sys.exit(main())
