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


Prompt templates turn Markdown files into reusable `/` commands. Use one when you want to reuse the same prompt without adding executable behavior or a larger set of supporting instructions.

A template can accept arguments and appear in command completion. Pi can load templates from personal configuration, project configuration, an explicit path, or a Pi package. Project configuration loads only after project trust is granted.


## Create a template

<a href="#create-a-template" class="heading-anchor" aria-label="Permalink: Create a template" data-copy="" data-copy-text="https://pi.dev/docs/latest/prompt-templates#create-a-template"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Create `~/.pi/agent/prompts/review.md`:

``` markdown
---
description: Review staged git changes
argument-hint: "[focus]"
---
Review the staged changes. Focus on ${1:-correctness, security, and error handling}.
```

The filename becomes the command name, so this template is available as `/review`. The `description` appears in command completion. If it is omitted, Pi uses the first non-empty line.

`argument-hint` is optional. Use `<angle brackets>` for required arguments and `[square brackets]` for optional arguments.

Run `/reload` after adding or changing a template in an active session.


## Use a template

<a href="#use-a-template" class="heading-anchor" aria-label="Permalink: Use a template" data-copy="" data-copy-text="https://pi.dev/docs/latest/prompt-templates#use-a-template"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Type the template command in the editor:

``` text
/review
/review concurrency
```

Pi expands the template before the resulting text enters the agent. Extensions receive the raw input first through the `input` event unless an extension command with the same name handles it.

Templates support these substitutions:

| Syntax               | Result                                 |
|----------------------|----------------------------------------|
| `$1`, `$2`, …        | One positional argument                |
| `$@` or `$ARGUMENTS` | All arguments joined with spaces       |
| `${1:-default}`      | First argument, or a default value     |
| `${@:-default}`      | All arguments, or a default value      |
| `${@:N}`             | Arguments starting at position `N`     |
| `${@:N:L}`           | `L` arguments starting at position `N` |

Arguments follow shell-like quoting, so `/review "API compatibility"` supplies one argument containing a space.


## Add it to Pi

<a href="#add-it-to-pi" class="heading-anchor" aria-label="Permalink: Add it to Pi" data-copy="" data-copy-text="https://pi.dev/docs/latest/prompt-templates#add-it-to-pi"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Place the template in your user or project prompt directory. Conventional prompt directories load direct `.md` children only.

Settings and packages can select nested Markdown files; a package manifest can narrow discovery with explicit paths and globs. See [Settings](/docs/latest/settings#resources) and [Pi Packages](/docs/latest/packages) for these options.

Project templates become commands in the editor after trust is granted. Review their content before trusting an unfamiliar project. See [Security](/docs/latest/security#understand-project-trust).


