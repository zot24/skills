> Source: https://pi.dev/docs/latest/skills



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Skills


> pi can create skills. Ask it to build one for your use case.

Skills are self-contained capability packages that the agent loads on-demand. A skill provides specialized workflows, setup instructions, helper scripts, and reference documentation for specific tasks.

Pi implements the [Agent Skills standard](https://agentskills.io/specification), warning about most violations but remaining lenient. Pi allows skill names to differ from their parent directory even though the standard disallows it; that rule is suboptimal for shared skill directories used across multiple agent harnesses.


## Table of Contents

<a href="#table-of-contents" class="heading-anchor" aria-label="Permalink: Table of Contents" data-copy="" data-copy-text="https://pi.dev/docs/latest/skills#table-of-contents"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- [Locations](#locations)
- [How Skills Work](#how-skills-work)
- [Skill Commands](#skill-commands)
- [Skill Structure](#skill-structure)
- [Frontmatter](#frontmatter)
- [Validation](#validation)
- [Example](#example)
- [Skill Repositories](#skill-repositories)


## Locations

<a href="#locations" class="heading-anchor" aria-label="Permalink: Locations" data-copy="" data-copy-text="https://pi.dev/docs/latest/skills#locations"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


> **Security:** Skills can instruct the model to perform any action and may include executable code the model invokes. Review skill content before use.

Pi loads skills from:

- Global:
  - `~/.pi/agent/skills/`
  - `~/.agents/skills/`
- Project (only after the project is trusted):
  - `.pi/skills/`
  - `.agents/skills/` in `cwd` and ancestor directories (up to git repo root, or filesystem root when not in a repo)
- Packages: `skills/` directories or `pi.skills` entries in `package.json`
- Settings: `skills` array with files or directories
- CLI: `--skill <path>` (repeatable, additive even with `--no-skills`)

Discovery rules:

- In `~/.pi/agent/skills/` and `.pi/skills/`, direct root `.md` files are discovered as individual skills when they have valid skill frontmatter with a non-empty `description`
- In all skill locations, directories containing `SKILL.md` are discovered recursively
- In `~/.agents/skills/` and project `.agents/skills/`, root `.md` files are ignored, but nested `.md` files in grouping folders are discovered when they declare skill frontmatter
- Root Markdown files other than `SKILL.md` that do not look like skills are ignored silently

Disable discovery with `--no-skills` (explicit `--skill` paths still load).


### Using Skills from Other Harnesses

<a href="#using-skills-from-other-harnesses" class="heading-anchor" aria-label="Permalink: Using Skills from Other Harnesses" data-copy="" data-copy-text="https://pi.dev/docs/latest/skills#using-skills-from-other-harnesses"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


To use skills from Claude Code or OpenAI Codex, add their directories to settings:

``` json
{
  "skills": [
    "~/.claude/skills",
    "~/.codex/skills"
  ]
}
```

For project-level Claude Code skills, add to `.pi/settings.json`:

``` json
{
  "skills": ["../.claude/skills"]
}
```


## How Skills Work

<a href="#how-skills-work" class="heading-anchor" aria-label="Permalink: How Skills Work" data-copy="" data-copy-text="https://pi.dev/docs/latest/skills#how-skills-work"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


1.  At startup, pi scans skill locations and extracts names and descriptions
2.  The system prompt includes available skills in XML format per the [specification](https://agentskills.io/integrate-skills)
3.  When a task matches, the agent uses `read`, or `bash` when `read` is unavailable, to load the full SKILL.md (models don't always do this; use prompting or `/skill:name` to force it)
4.  The agent follows the instructions, using relative paths to reference scripts and assets

This is progressive disclosure: only descriptions are always in context, full instructions load on-demand.


## Skill Commands

<a href="#skill-commands" class="heading-anchor" aria-label="Permalink: Skill Commands" data-copy="" data-copy-text="https://pi.dev/docs/latest/skills#skill-commands"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Skills register as `/skill:name` commands:

``` bash
/skill:brave-search           # Load and execute the skill
/skill:pdf-tools extract      # Load skill with arguments
```

Arguments after the command are appended to the skill content as `User: <args>`.

Toggle skill commands via `/settings` in interactive mode or in `settings.json`:

``` json
{
  "enableSkillCommands": true
}
```


## Skill Structure

<a href="#skill-structure" class="heading-anchor" aria-label="Permalink: Skill Structure" data-copy="" data-copy-text="https://pi.dev/docs/latest/skills#skill-structure"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


A skill is a directory with a `SKILL.md` file. Everything else is freeform.

    my-skill/
    ├── SKILL.md              # Required: frontmatter + instructions
    ├── scripts/              # Helper scripts
    │   └── process.sh
    ├── references/           # Detailed docs loaded on-demand
    │   └── api-reference.md
    └── assets/
        └── template.json


### SKILL.md Format

<a href="#skillmd-format" class="heading-anchor" aria-label="Permalink: SKILL.md Format" data-copy="" data-copy-text="https://pi.dev/docs/latest/skills#skillmd-format"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


```` markdown
---
name: my-skill
description: What this skill does and when to use it. Be specific.
---

# My Skill

## Setup

Run once before first use:
```bash
cd /path/to/skill && npm install
```

## Usage

```bash
./scripts/process.sh <input>
```
````

Use relative paths from the skill directory:

``` markdown
See [the reference guide](references/REFERENCE.md) for details.
```


## Frontmatter

<a href="#frontmatter" class="heading-anchor" aria-label="Permalink: Frontmatter" data-copy="" data-copy-text="https://pi.dev/docs/latest/skills#frontmatter"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Per the [Agent Skills specification](https://agentskills.io/specification#frontmatter-required):

| Field                      | Required | Description                                                                                                                                                                                          |
|----------------------------|----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `name`                     | Yes      | Max 64 chars. Lowercase a-z, 0-9, hyphens. Unlike the standard, Pi does not require this to match the parent directory because that standard requirement is suboptimal for shared skill directories. |
| `description`              | Yes      | Max 1024 chars. What the skill does and when to use it.                                                                                                                                              |
| `license`                  | No       | License name or reference to bundled file.                                                                                                                                                           |
| `compatibility`            | No       | Max 500 chars. Environment requirements.                                                                                                                                                             |
| `metadata`                 | No       | Arbitrary key-value mapping.                                                                                                                                                                         |
| `allowed-tools`            | No       | Space-delimited list of pre-approved tools (experimental).                                                                                                                                           |
| `disable-model-invocation` | No       | When `true`, skill is hidden from system prompt. Users must use `/skill:name`.                                                                                                                       |


### Name Rules

<a href="#name-rules" class="heading-anchor" aria-label="Permalink: Name Rules" data-copy="" data-copy-text="https://pi.dev/docs/latest/skills#name-rules"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- 1-64 characters
- Lowercase letters, numbers, hyphens only
- No leading/trailing hyphens
- No consecutive hyphens Pi does not require the name to match the parent directory. The Agent Skills standard does, but that requirement is suboptimal for shared skill directories used by multiple tools.

Valid: `pdf-processing`, `data-analysis`, `code-review` Invalid: `PDF-Processing`, `-pdf`, `pdf--processing`


### Description Best Practices

<a href="#description-best-practices" class="heading-anchor" aria-label="Permalink: Description Best Practices" data-copy="" data-copy-text="https://pi.dev/docs/latest/skills#description-best-practices"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


The description determines when the agent loads the skill. Be specific.

Good:

``` yaml
description: Extracts text and tables from PDF files, fills PDF forms, and merges multiple PDFs. Use when working with PDF documents.
```

Poor:

``` yaml
description: Helps with PDFs.
```


## Validation

<a href="#validation" class="heading-anchor" aria-label="Permalink: Validation" data-copy="" data-copy-text="https://pi.dev/docs/latest/skills#validation"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi validates skills against the Agent Skills standard. Most issues produce warnings but still load the skill:

- Name exceeds 64 characters or contains invalid characters
- Name starts/ends with hyphen or has consecutive hyphens
- Description exceeds 1024 characters

Unknown frontmatter fields are ignored.

Declared skills with missing descriptions are not loaded. Malformed `SKILL.md` files and `SKILL.md` files without a description produce warnings and are not loaded. Other Markdown files without valid skill frontmatter are ignored.

Name collisions (same name from different locations) warn and keep the first skill found.


## Example

<a href="#example" class="heading-anchor" aria-label="Permalink: Example" data-copy="" data-copy-text="https://pi.dev/docs/latest/skills#example"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


    brave-search/
    ├── SKILL.md
    ├── search.js
    └── content.js

**SKILL.md:**

```` markdown
---
name: brave-search
description: Web search and content extraction via Brave Search API. Use for searching documentation, facts, or any web content.
---

# Brave Search

## Setup

```bash
cd /path/to/brave-search && npm install
```

## Search

```bash
./search.js "query"              # Basic search
./search.js "query" --content    # Include page content
```

## Extract Page Content

```bash
./content.js https://example.com
```
````


## Skill Repositories

<a href="#skill-repositories" class="heading-anchor" aria-label="Permalink: Skill Repositories" data-copy="" data-copy-text="https://pi.dev/docs/latest/skills#skill-repositories"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- [Anthropic Skills](https://github.com/anthropics/skills) - Document processing (docx, pdf, pptx, xlsx), web development
- [Pi Skills](https://github.com/badlogic/pi-skills) - Web search, browser automation, Google APIs, transcription


