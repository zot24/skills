#!/usr/bin/env python3
"""Build Hermes /wiki-* SKILL.md files from vendored nvk v0.23.0 commands.

Does not invent compile/ingest protocols. Embeds official command bodies so
Hermes slash-load is self-contained.
"""

from __future__ import annotations

import json
import re
import shutil
from pathlib import Path

PKG = Path(__file__).resolve().parents[1]
PIN_CMD = Path.home() / ".claude/plugins/marketplaces/llm-wiki/claude-plugin/commands"
PIN_WM = Path.home() / (
    ".claude/plugins/marketplaces/llm-wiki/plugins/llm-wiki-opencode/skills/wiki-manager"
)
PIN_QUERY = Path.home() / (
    ".claude/plugins/marketplaces/llm-wiki/plugins/llm-wiki-opencode/skills/wiki-query"
)
TAG = "v0.23.0"
SHA = "d02cbcb"
PIN_ABS_WM = (
    "~/.claude/plugins/marketplaces/llm-wiki/plugins/llm-wiki-opencode"
    "/skills/wiki-manager"
)
RAW_CMD = f"https://raw.githubusercontent.com/nvk/llm-wiki/{TAG}/claude-plugin/commands"
RAW_WM = (
    f"https://raw.githubusercontent.com/nvk/llm-wiki/{TAG}"
    "/plugins/llm-wiki-opencode/skills/wiki-manager"
)

COMMANDS = [
    "wiki",
    "adapter",
    "archive",
    "assess",
    "audit",
    "collect",
    "compile",
    "dataset",
    "feedback",
    "idea",
    "ingest",
    "ingest-collection",
    "inventory",
    "librarian",
    "lint",
    "ll",
    "output",
    "plan",
    "portfolio",
    "project",
    "query",
    "refresh",
    "research",
    "retract",
    "session",
    "specialist",
    "thesis",
]

# Extra pin files always vendored next to wiki-manager SKILL.md.
WM_ALWAYS = ["SKILL.md"]


def skill_name(cmd: str) -> str:
    return "wiki" if cmd == "wiki" else f"wiki-{cmd}"


def slash(cmd: str) -> str:
    return "/wiki" if cmd == "wiki" else f"/wiki-{cmd}"


def parse_frontmatter(text: str) -> tuple[dict[str, str], str]:
    if not text.startswith("---\n"):
        return {}, text
    end = text.find("\n---\n", 4)
    if end < 0:
        return {}, text
    raw = text[4:end]
    body = text[end + 5 :]
    meta: dict[str, str] = {}
    for line in raw.splitlines():
        if ":" not in line:
            continue
        key, val = line.split(":", 1)
        meta[key.strip()] = val.strip().strip('"')
    return meta, body


def rewrite_refs(body: str) -> str:
    """Point protocol reads at the pin + this skill's vendored copies.

    Does not change the protocol text itself.
    """

    def repl_ref(match: re.Match[str]) -> str:
        name = match.group(1)
        return (
            f"`references/{name}` (vendored {TAG}; pin "
            f"`{PIN_ABS_WM}/references/{name}`)"
        )

    body = re.sub(
        r"`?skills/wiki-manager/references/([A-Za-z0-9._-]+)`?",
        repl_ref,
        body,
    )
    body = body.replace(
        "`skills/wiki-manager/SKILL.md`",
        f"`{PIN_ABS_WM}/SKILL.md` (also vendored at `references/wiki-manager-SKILL.md`)",
    )
    body = body.replace(
        "skills/wiki-manager/SKILL.md",
        f"{PIN_ABS_WM}/SKILL.md",
    )
    return body


BUNDLED_CLI = "${CLAUDE_PLUGIN_ROOT}/bin/llm-wiki"

CLI_RESOLVER = """## Resolve the llm-wiki CLI

This package vendors command bodies only. It does **not** bundle a CLI, so
`${CLAUDE_PLUGIN_ROOT}/bin/llm-wiki` does not exist here. Resolve the command
first and fail closed when it is absent:

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

Every `$LLM_WIKI` below refers to that resolved command. Do not guess a path,
and do not continue without the CLI.

"""


def needs_cli(text: str) -> bool:
    return BUNDLED_CLI in text


def rewrite_cli(body: str) -> str:
    """Point CLI invocations at a resolved command instead of a bundle we lack.

    Upstream assumes a `bin/llm-wiki` shipped inside the plugin root. This
    package vendors command bodies only, so that path never exists and the
    commands fail at runtime. Rewrite the invocation to `$LLM_WIKI`, which the
    resolver block above defines from a source checkout or from PATH.
    """
    if not needs_cli(body):
        return body
    body = body.replace(f'"{BUNDLED_CLI}"', '"$LLM_WIKI"')
    body = body.replace(BUNDLED_CLI, '"$LLM_WIKI"')
    body = body.replace(
        "Other runtimes should use the\nbundled `bin/llm-wiki` relative to the installed plugin root described in the\nadapter reference. Do not assume the command is globally installed.",
        "Other runtimes resolve\n`$LLM_WIKI` as shown above. This package ships no bundled `bin/llm-wiki`.",
    )
    return body


def rewrite_cli_tools(value: str) -> str:
    """Replace the bundled-CLI permission with the resolved-command permission."""
    if f"Bash({BUNDLED_CLI}:*)" not in value:
        return value
    return value.replace(
        f"Bash({BUNDLED_CLI}:*)",
        "Bash(llm-wiki:*), Bash(command:*)",
    )


def extract_ref_names(original: str) -> list[str]:
    names = re.findall(
        r"skills/wiki-manager/references/([A-Za-z0-9._-]+)", original
    )
    out: list[str] = []
    for n in names:
        if n not in out:
            out.append(n)
    return out


def hermes_frontmatter(cmd: str, meta: dict[str, str]) -> str:
    desc = meta.get("description", "").strip()
    if not desc:
        desc = f"nvk llm-wiki {cmd} command."
    desc = desc.rstrip(".")
    name = skill_name(cmd)
    claude = "/wiki" if cmd == "wiki" else f"/wiki:{cmd}"
    hermes = slash(cmd)
    full = (
        f"{desc}. Use when the user runs {hermes} or {claude}. "
        f"Official nvk/llm-wiki {TAG} command body. "
        "Never use bundled Karpathy llm-wiki against this hub."
    )
    tools = rewrite_cli_tools(meta.get("allowed-tools", "").strip())
    lines = [
        "---",
        f"name: {name}",
        "description: >-",
        f"  {full}",
    ]
    if tools:
        lines.append(f"allowed-tools: {tools}")
    lines.append("---")
    return "\n".join(lines) + "\n"


def header(cmd: str, refs: list[str]) -> str:
    name = skill_name(cmd)
    hermes = slash(cmd)
    claude = "/wiki" if cmd == "wiki" else f"/wiki:{cmd}"
    ref_lines = []
    for r in refs:
        ref_lines.append(
            f"- `{PIN_ABS_WM}/references/{r}` "
            f"(in-skill copy: `references/{r}`; "
            f"tag: {RAW_WM}/references/{r})"
        )
    if cmd == "wiki":
        ref_lines.append(
            f"- `{PIN_ABS_WM}/SKILL.md` "
            f"(in-skill copy: `references/wiki-manager-SKILL.md`; "
            f"tag: {RAW_WM}/SKILL.md)"
        )
    ref_block = "\n".join(ref_lines) if ref_lines else (
        f"- Pin wiki-manager: `{PIN_ABS_WM}/` "
        f"(tag {TAG} / `{SHA}`). Load those references only when this command body asks."
    )
    return f"""# {name} — nvk {TAG} `{claude}`

Vendored **verbatim** from nvk/llm-wiki **{TAG}** (`{SHA}`)
`claude-plugin/commands/{cmd}.md`.
Do **not** invent compile, ingest, lint, or query protocols.

- Hermes slash: `{hermes}` (hyphen). Claude: `{claude}` (colon). Hermes cannot use colons in slashes.
- Hub: `~/wiki` via `~/.config/llm-wiki/config.json`. Never bundled Karpathy `llm-wiki`.
- This file is self-contained for slash-load. Extra protocol files are optional pointers, not a load dependency.

## Official references (pin, not HEAD)

{ref_block}

Official command body follows. `$ARGUMENTS` is the text after `{hermes}`.

---
"""


def vendor_sources() -> None:
    vendor_cmd = PKG / "vendor" / "commands"
    vendor_wm = PKG / "vendor" / "wiki-manager"
    vendor_cmd.mkdir(parents=True, exist_ok=True)
    (vendor_wm / "references").mkdir(parents=True, exist_ok=True)

    if not PIN_CMD.is_dir():
        raise SystemExit(f"pin commands missing: {PIN_CMD}")
    if not PIN_WM.is_dir():
        raise SystemExit(f"pin wiki-manager missing: {PIN_WM}")

    for cmd in COMMANDS:
        src = PIN_CMD / f"{cmd}.md"
        if not src.is_file():
            raise SystemExit(f"missing pin command: {src}")
        shutil.copyfile(src, vendor_cmd / f"{cmd}.md")

    shutil.copyfile(PIN_WM / "SKILL.md", vendor_wm / "SKILL.md")
    for ref in sorted((PIN_WM / "references").glob("*.md")):
        shutil.copyfile(ref, vendor_wm / "references" / ref.name)

    if PIN_QUERY.is_dir() and (PIN_QUERY / "SKILL.md").is_file():
        qdir = PKG / "vendor" / "wiki-query"
        qdir.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(PIN_QUERY / "SKILL.md", qdir / "SKILL.md")


def write_skill(cmd: str) -> None:
    src = (PKG / "vendor" / "commands" / f"{cmd}.md").read_text()
    meta, body = parse_frontmatter(src)
    refs = extract_ref_names(src)
    name = skill_name(cmd)
    dest = PKG / "skills" / name
    dest.mkdir(parents=True, exist_ok=True)
    refdir = dest / "references"
    if refdir.exists():
        shutil.rmtree(refdir)
    refdir.mkdir()

    for r in refs:
        pin = PIN_WM / "references" / r
        vend = PKG / "vendor" / "wiki-manager" / "references" / r
        chosen = pin if pin.is_file() else vend
        if not chosen.is_file():
            raise SystemExit(f"missing reference {r} for {cmd}")
        shutil.copyfile(chosen, refdir / r)
        # source banner if not already present
        text = (refdir / r).read_text()
        banner = (
            f"<!-- Source: {RAW_WM}/references/{r} "
            f"(nvk/llm-wiki {TAG} / {SHA}) -->\n"
        )
        if not text.startswith("<!-- Source:"):
            (refdir / r).write_text(banner + text)

    if cmd == "wiki":
        wm = PKG / "vendor" / "wiki-manager" / "SKILL.md"
        text = wm.read_text()
        banner = (
            f"<!-- Source: {RAW_WM}/SKILL.md "
            f"(nvk/llm-wiki {TAG} / {SHA}) -->\n"
        )
        out = banner + text if not text.startswith("<!-- Source:") else text
        (refdir / "wiki-manager-SKILL.md").write_text(out)

    if cmd == "query":
        ql = PKG / "vendor" / "wiki-manager" / "references" / "query-lite.md"
        if ql.is_file() and "query-lite.md" not in refs:
            shutil.copyfile(ql, refdir / "query-lite.md")
        oq = PKG / "vendor" / "wiki-query" / "SKILL.md"
        if oq.is_file():
            text = oq.read_text()
            banner = (
                f"<!-- Source: https://raw.githubusercontent.com/nvk/llm-wiki/"
                f"{TAG}/plugins/llm-wiki-opencode/skills/wiki-query/SKILL.md "
                f"({SHA}) -->\n"
            )
            if not text.startswith("<!-- Source:"):
                text = banner + text
            (refdir / "wiki-query-opencode.md").write_text(text)

    rewritten = rewrite_cli(rewrite_refs(body.lstrip("\n")))
    if needs_cli(body):
        rewritten = CLI_RESOLVER + rewritten
    skill = hermes_frontmatter(cmd, meta) + "\n" + header(cmd, refs) + rewritten
    if not skill.endswith("\n"):
        skill += "\n"
    (dest / "SKILL.md").write_text(skill)

    # Claude marketplace command: official body + hyphen name note.
    cmd_dir = PKG / "commands"
    cmd_dir.mkdir(exist_ok=True)
    note = (
        f"<!-- Hermes slash is {slash(cmd)}; Claude plugin slash is "
        f"/nvk-wiki-hermes:{skill_name(cmd)}. Official nvk {TAG} body. -->\n"
    )
    cmd_meta, cmd_body = parse_frontmatter(src)
    if needs_cli(src):
        cmd_src = src
        for key in ("allowed-tools",):
            if key in cmd_meta:
                cmd_src = cmd_src.replace(
                    f"{key}: {cmd_meta[key]}", f"{key}: {rewrite_cli_tools(cmd_meta[key])}"
                )
        head, sep, rest = cmd_src.partition("\n---\n")
        rest = CLI_RESOLVER + rewrite_cli(rest.lstrip("\n"))
        cmd_src = head + sep + "\n" + rest
    else:
        cmd_src = src
    (cmd_dir / f"{skill_name(cmd)}.md").write_text(note + cmd_src)


def write_package_index() -> None:
    dest = PKG / "skills" / "nvk-wiki-hermes"
    dest.mkdir(parents=True, exist_ok=True)
    rows = []
    for cmd in COMMANDS:
        hermes = slash(cmd)
        claude = "/wiki" if cmd == "wiki" else f"/wiki:{cmd}"
        rows.append(f"| `{claude}` | `{hermes}` | `wiki` |" if cmd == "wiki"
                    else f"| `{claude}` | `{hermes}` | `{skill_name(cmd)}` |")
    table = "\n".join(rows)
    (dest / "SKILL.md").write_text(
        f"""---
name: nvk-wiki-hermes
description: >-
  Hermes hyphen-slash pack of every nvk/llm-wiki {TAG} Claude command
  (/wiki, /wiki-compile, /wiki-ingest, …). Use when the user wants the
  official nvk command surface on Hermes. Never Karpathy llm-wiki.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

# nvk-wiki-hermes — official nvk {TAG} command pack

Peer of the **llm-wiki expert** skill. This package is the **command
surface**, not the expert digest. Extending `skills/llm-wiki/` would smash
that expert skill, so these slashes live here.

Pin: nvk/llm-wiki **{TAG}** (`{SHA}`). Sync from that tag, not `master`.

Hermes cannot use colons in slashes. Map:

| Claude | Hermes | Skill |
|---|---|---|
{table}

Load the matching `wiki` / `wiki-<cmd>` skill. Each of those SKILL.md files
embeds the official command body.

Do not invent protocols. Do not compile or `lint --fix` a hub unless the
user invoked that command and the official body allows it.

## Documentation

- **[Layout](docs/layout.md)** — what is vendored, what is generated, and which files never to hand-edit
- **[The llm-wiki CLI](docs/cli.md)** — three commands need an external CLI, how it is resolved, and what to install
- **[Pin policy](docs/pin.md)** — why the sources are tag-pinned to {TAG} and what a version bump involves
"""
    )


def write_router_command() -> None:
    lines = [
        "# nvk wiki commands on Hermes",
        "",
        f"Official nvk/llm-wiki {TAG} (`{SHA}`) command pack.",
        "Hermes slashes use hyphens. Claude uses colons.",
        "",
        "## Command: $ARGUMENTS",
        "",
        "| Hermes | Claude | Skill |",
        "|---|---|---|",
    ]
    for cmd in COMMANDS:
        hermes = slash(cmd)
        claude = "/wiki" if cmd == "wiki" else f"/wiki:{cmd}"
        lines.append(f"| `{hermes}` | `{claude}` | `{skill_name(cmd)}` |")
    lines += [
        "",
        "If `$ARGUMENTS` is empty or `help`, print this table.",
        "Otherwise route to the matching skill under `skills/`.",
        "Do not invent protocols. Vendor text is the protocol.",
        "",
    ]
    (PKG / "commands" / "nvk-wiki-hermes.md").write_text("\n".join(lines))


def write_sync_json() -> None:
    sources = []
    for cmd in COMMANDS:
        sources.append(
            {
                "url": f"{RAW_CMD}/{cmd}.md",
                "target": f"vendor/commands/{cmd}.md",
                "type": "raw",
                "freshness_days": 30,
            }
        )
    sources.append(
        {
            "url": f"{RAW_WM}/SKILL.md",
            "target": "vendor/wiki-manager/SKILL.md",
            "type": "raw",
            "freshness_days": 30,
        }
    )
    wm_refs = sorted((PIN_WM / "references").glob("*.md"))
    for ref in wm_refs:
        sources.append(
            {
                "url": f"{RAW_WM}/references/{ref.name}",
                "target": f"vendor/wiki-manager/references/{ref.name}",
                "type": "raw",
                "freshness_days": 30,
            }
        )
    sources.append(
        {
            "url": (
                f"https://raw.githubusercontent.com/nvk/llm-wiki/{TAG}"
                "/plugins/llm-wiki-opencode/skills/wiki-query/SKILL.md"
            ),
            "target": "vendor/wiki-query/SKILL.md",
            "type": "raw",
            "freshness_days": 30,
        }
    )
    payload = {
        "name": "nvk-wiki-hermes",
        "version": "1.0.0",
        "description": (
            f"Hermes /wiki-* hyphen slashes vendored from nvk/llm-wiki {TAG}"
        ),
        "sources": sources,
        "cache_dir": ".cache",
        "notes": (
            f"ALL sources are pinned to nvk/llm-wiki {TAG} ({SHA}), never "
            "master. After sync, run scripts/generate-skills.py to rebuild "
            "embedded SKILL.md files from vendor/commands."
        ),
    }
    (PKG / "sync.json").write_text(json.dumps(payload, indent=2) + "\n")


def main() -> None:
    vendor_sources()
    write_sync_json()
    for cmd in COMMANDS:
        write_skill(cmd)
    write_package_index()
    write_router_command()
    print(f"generated {len(COMMANDS)} command skills + router in {PKG}")


if __name__ == "__main__":
    main()
