> Source: https://pi.dev/docs/latest/prompt-templates



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Prompt Templates


> pi can create prompt templates. Ask it to build one for your workflow.

Prompt templates are Markdown snippets that expand into full prompts. Type `/name` in the editor to invoke a template, where `name` is the filename without `.md`.


## Locations

<a href="#locations" class="heading-anchor" aria-label="Permalink: Locations" data-copy="" data-copy-text="https://pi.dev/docs/latest/prompt-templates#locations"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi loads prompt templates from:

- Global: `~/.pi/agent/prompts/*.md`
- Project: `.pi/prompts/*.md` (only after the project is trusted)
- Packages: `prompts/` directories or `pi.prompts` entries in `package.json`
- Settings: `prompts` array with files or directories
- CLI: `--prompt-template <path>` (repeatable)

Disable discovery with `--no-prompt-templates`.


## Format

<a href="#format" class="heading-anchor" aria-label="Permalink: Format" data-copy="" data-copy-text="https://pi.dev/docs/latest/prompt-templates#format"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` markdown
---
description: Review staged git changes
---
Review the staged changes (`git diff --cached`). Focus on:
- Bugs and logic errors
- Security issues
- Error handling gaps
```

- The filename becomes the command name. `review.md` becomes `/review`.
- `description` is optional. If missing, the first non-empty line is used.
- `argument-hint` is optional. When set, the hint is displayed before the description in the autocomplete dropdown.


### Argument Hints

<a href="#argument-hints" class="heading-anchor" aria-label="Permalink: Argument Hints" data-copy="" data-copy-text="https://pi.dev/docs/latest/prompt-templates#argument-hints"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Use `argument-hint` in frontmatter to show expected arguments in autocomplete. Use `<angle brackets>` for required arguments and `[square brackets]` for optional ones:

``` markdown
---
description: Review PRs from URLs with structured issue and code analysis
argument-hint: "<PR-URL>"
---
```

This renders in the autocomplete dropdown as:

    → pr   <PR-URL>       — Review PRs from URLs with structured issue and code analysis
      is   <issue>        — Analyze GitHub issues (bugs or feature requests)
      wr   [instructions] — Finish the current task end-to-end
      cl   — Audit changelog entries before release


## Usage

<a href="#usage" class="heading-anchor" aria-label="Permalink: Usage" data-copy="" data-copy-text="https://pi.dev/docs/latest/prompt-templates#usage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Type `/` followed by the template name in the editor. Autocomplete shows available templates with descriptions.

    /review                           # Expands review.md
    /component Button                 # Expands with argument
    /component Button "click handler" # Multiple arguments


## Arguments

<a href="#arguments" class="heading-anchor" aria-label="Permalink: Arguments" data-copy="" data-copy-text="https://pi.dev/docs/latest/prompt-templates#arguments"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Templates support positional arguments, defaults, and simple slicing:

- `$1`, `$2`, ... positional args
- `$@` or `$ARGUMENTS` for all args joined
- `${1:-default}` uses arg 1 when present/non-empty, otherwise `default`
- `${@:-default}` or `${ARGUMENTS:-default}` uses all arguments when present/non-empty, otherwise `default`
- `${@:N}` for args from the Nth position (1-indexed)
- `${@:N:L}` for `L` args starting at N

Example:

``` markdown
---
description: Create a component
---
Create a React component named $1 with features: $@
```

Default values are useful for optional arguments:

``` markdown
Summarize the current state in ${1:-7} bullet points.
```

Usage: `/component Button "onClick handler" "disabled support"`


## Loading Rules

<a href="#loading-rules" class="heading-anchor" aria-label="Permalink: Loading Rules" data-copy="" data-copy-text="https://pi.dev/docs/latest/prompt-templates#loading-rules"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- Template discovery in `prompts/` is non-recursive.
- If you want templates in subdirectories, add them explicitly via `prompts` settings or a package manifest.


