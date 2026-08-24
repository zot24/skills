> Source: https://pi.dev/docs/latest/sessions



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Sessions


Pi saves conversations as sessions so you can continue work, branch from earlier turns, and revisit previous paths.


## Session Storage

<a href="#session-storage" class="heading-anchor" aria-label="Permalink: Session Storage" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#session-storage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Sessions auto-save to `~/.pi/agent/sessions/`, organized by working directory. Each session is a JSONL file with a tree structure.

``` bash
pi -c                  # Continue most recent session
pi -r                  # Browse and select from past sessions
pi --no-session        # Ephemeral mode; do not save
pi --name "my task"    # Set session display name at startup
pi --session <path|id> # Use a specific session file or partial session ID
pi --fork <path|id>    # Fork a session file or partial session ID into a new session
```

Use `/session` in interactive mode to see the current session file, session ID, message count, tokens, and cost.

For the JSONL file format and SessionManager API, see [Session Format](/docs/latest/session-format).


## Session Commands

<a href="#session-commands" class="heading-anchor" aria-label="Permalink: Session Commands" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#session-commands"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Command             | Description                                                        |
|---------------------|--------------------------------------------------------------------|
| `/resume`           | Browse and select previous sessions                                |
| `/new`              | Start a new session                                                |
| `/name <name>`      | Set the current session display name                               |
| `/session`          | Show session info                                                  |
| `/tree`             | Navigate the current session tree                                  |
| `/fork`             | Create a new session from a previous user message                  |
| `/clone`            | Duplicate the current active branch into a new session             |
| `/compact [prompt]` | Summarize older context; see [Compaction](/docs/latest/compaction) |
| `/export [file]`    | Export session to HTML                                             |
| `/share`            | Upload as private GitHub gist with shareable HTML link             |


## Resuming and Deleting Sessions

<a href="#resuming-and-deleting-sessions" class="heading-anchor" aria-label="Permalink: Resuming and Deleting Sessions" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#resuming-and-deleting-sessions"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


`/resume` opens an interactive session picker for the current project. `pi -r` opens the same picker at startup.

In the picker you can:

- search by typing
- toggle path display with Ctrl+P
- toggle sort mode with Ctrl+S
- filter to named sessions with Ctrl+N
- rename with Ctrl+R
- delete with Ctrl+D, then confirm

When available, pi uses the `trash` CLI for deletion instead of permanently removing files.


## Naming Sessions

<a href="#naming-sessions" class="heading-anchor" aria-label="Permalink: Naming Sessions" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#naming-sessions"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Use `/name <name>` to set a human-readable session name:

``` text
/name Refactor auth module
```

Set the name at startup with `--name` or `-n`:

``` bash
pi --name "Refactor auth module"
pi --name "CI audit" -p "Review this build failure"
```

Named sessions are easier to find in `/resume` and `pi -r`.


## Branching with `/tree`

<a href="#branching-with-tree" class="heading-anchor" aria-label="Permalink: Branching with /tree" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#branching-with-tree"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Sessions are stored as trees. Every entry has an `id` and `parentId`, and the current position is the active leaf. `/tree` lets you jump to any previous point and continue from there without creating a new file.

<img src="/docs/latest/images/tree-view.png" width="600" alt="Tree View" />

Example shape:

``` text
├─ user: "Hello, can you help..."
│  └─ assistant: "Of course! I can..."
│     ├─ user: "Let's try approach A..."
│     │  └─ assistant: "For approach A..."
│     │     └─ user: "That worked..."  ← active
│     └─ user: "Actually, approach B..."
│        └─ assistant: "For approach B..."
```


### Tree Controls

<a href="#tree-controls" class="heading-anchor" aria-label="Permalink: Tree Controls" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#tree-controls"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Key                          | Action                                      |
|------------------------------|---------------------------------------------|
| ↑/↓                          | Navigate visible entries                    |
| ←/→                          | Page up/down                                |
| Ctrl+←/Ctrl+→ or Alt+←/Alt+→ | Fold/unfold or jump between branch segments |
| Shift+L                      | Set or clear a label on the selected entry  |
| Shift+T                      | Toggle label timestamps                     |
| Enter                        | Select entry                                |
| Escape/Ctrl+C                | Cancel                                      |
| Ctrl+O                       | Cycle filter mode                           |

Filter modes are: default, no-tools, user-only, labeled-only, and all. Configure the default with `treeFilterMode` in [Settings](/docs/latest/settings).


### Selection Behavior

<a href="#selection-behavior" class="heading-anchor" aria-label="Permalink: Selection Behavior" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#selection-behavior"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Selecting a user or custom message:

1.  Moves the leaf to the selected message's parent.
2.  Places the selected message text in the editor.
3.  Lets you edit and resubmit, creating a new branch.

Selecting an assistant, tool, compaction, or other non-user entry:

1.  Moves the leaf to that entry.
2.  Leaves the editor empty.
3.  Lets you continue from that point.

Selecting the root user message resets the leaf to an empty conversation and places the original prompt in the editor.


## `/tree`, `/fork`, and `/clone`

<a href="#tree-fork-and-clone" class="heading-anchor" aria-label="Permalink: /tree, /fork, and /clone" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#tree-fork-and-clone"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Feature     | `/tree`                       | `/fork`                                    | `/clone`                                 |
|-------------|-------------------------------|--------------------------------------------|------------------------------------------|
| Output      | Same session file             | New session file                           | New session file                         |
| View        | Full tree                     | User-message selector                      | Current active branch                    |
| Typical use | Explore alternatives in place | Start a new session from an earlier prompt | Duplicate current work before continuing |
| Summary     | Optional branch summary       | None                                       | None                                     |

Use `/tree` when you want to keep alternatives together. Use `/fork` or `/clone` when you want a separate session file.


## Branch Summaries

<a href="#branch-summaries" class="heading-anchor" aria-label="Permalink: Branch Summaries" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#branch-summaries"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


When `/tree` switches away from one branch to another, pi can summarize the abandoned branch and attach that summary at the new position. This preserves important context from the path you left without replaying the whole branch.

When prompted, choose one of:

1.  no summary
2.  summarize with the default prompt
3.  summarize with custom focus instructions

See [Compaction](/docs/latest/compaction) for branch summarization internals and extension hooks.


## Session Format

<a href="#session-format" class="heading-anchor" aria-label="Permalink: Session Format" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#session-format"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Session files are JSONL and contain message entries, model changes, thinking-level changes, labels, compactions, branch summaries, and extension entries.

For parsers, extensions, SDK usage, and the full SessionManager API, see [Session Format](/docs/latest/session-format).


