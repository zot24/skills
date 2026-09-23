> Source: https://pi.dev/docs/latest/sessions



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Sessions and Context


Pi saves a conversation as a session. The active branch of that session supplies conversation history for the next model request. Use session commands to continue work, explore another branch, or reduce the amount of history sent to the model.


## Continue or switch sessions

<a href="#continue-or-switch-sessions" class="heading-anchor" aria-label="Permalink: Continue or switch sessions" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#continue-or-switch-sessions"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi saves sessions automatically unless you start it with `--no-session`.

``` bash
pi --continue
pi --resume
```

`--continue` opens the most recent session for the current working directory. `--resume` opens the session picker. In interactive mode, `/resume` opens the same picker and `/new` starts a new session.

Use `/name` or `--name` to assign a recognizable session name. Run `/session` to verify the current session file, ID, message count, token usage, and cost.

The session picker lets you search, rename, and delete sessions. It can also show paths, change sorting, and limit results to named sessions. See [Keybindings](/docs/latest/keybindings#sessions) for its shortcuts.


## Choose how to branch

<a href="#choose-how-to-branch" class="heading-anchor" aria-label="Permalink: Choose how to branch" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#choose-how-to-branch"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi stores entries as a tree, so returning to an earlier point does not erase the branch you leave.

| Action   | Result                                             | Use it when                                   |
|----------|----------------------------------------------------|-----------------------------------------------|
| `/tree`  | Moves within the current session file              | Related alternatives should stay together     |
| `/fork`  | Creates a new session from an earlier user message | The alternative should become separate work   |
| `/clone` | Copies the active branch into a new session        | You want a separate copy of the current state |

In `/tree`, select a user message to put its text back in the editor. Edit and submit it to create another branch. Selecting an assistant response or another entry continues after that entry with an empty editor.

When you leave a branch, Pi can summarize it and attach that summary to the branch you enter. This preserves relevant work from the abandoned path without including every message from it.

For the persisted tree and entry types, see [Session Format](/docs/latest/session-format).


## Manage conversation context

<a href="#manage-conversation-context" class="heading-anchor" aria-label="Permalink: Manage conversation context" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#manage-conversation-context"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


The model receives the active branch, not every branch in the session file. Pi combines that history with the system prompt, discovered context files, available tools, and loaded skill descriptions. [How Pi Works](/docs/latest/how-pi-works#context) describes how those inputs are assembled.

The footer shows current context usage. When the active context approaches the model's limit, Pi normally compacts older history automatically. Compaction adds a summary and keeps recent messages. It does not delete the original session entries.

Run `/compact` to compact manually. You can add instructions when the summary should preserve a particular topic or decision. Configure automatic compaction and retained history through [Settings](/docs/latest/settings#compaction).

Compaction can fail if the provider is unavailable or cannot accept the summarization request. Correct the provider problem and run `/compact` again. Disabling automatic compaction does not disable the manual command.

See [Compaction Reference](/docs/latest/compaction) for thresholds, retained boundaries, branch-summary behavior, and extension hooks.


## Control session storage

<a href="#control-session-storage" class="heading-anchor" aria-label="Permalink: Control session storage" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#control-session-storage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


By default, Pi stores sessions under `~/.pi/agent/sessions/`, grouped by working directory. Use `--session-dir`, `PI_CODING_AGENT_SESSION_DIR`, or the `sessionDir` setting to choose another location. The CLI option has highest precedence.

Use `--no-session` for an ephemeral run. An ephemeral session cannot be resumed after Pi exits.

Use `--session` when you already know the session path or ID. Use `--fork` to create a new session from an existing session before interactive mode starts.


## Export or share a session

<a href="#export-or-share-a-session" class="heading-anchor" aria-label="Permalink: Export or share a session" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#export-or-share-a-session"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Use `/export` to write the current session as HTML or JSONL. Use `/share` to upload it and get a viewer link. Pi uses a Radius artifact when Radius authentication is configured; otherwise, it uses a private GitHub gist.

Review exported or shared sessions first. They can contain prompts, model responses, tool arguments, command output, file contents, and extension messages.


## Report a bug

<a href="#report-a-bug" class="heading-anchor" aria-label="Permalink: Report a bug" data-copy="" data-copy-text="https://pi.dev/docs/latest/sessions#report-a-bug"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Run `/bug [description]` to prepare a private report for the Pi developers. You can include the session transcript, omit it, or ask the current model to summarize the problem. Review any transcript or generated summary because it can contain sensitive conversation data.

The report includes environment and provider configuration without credential values, plus recorded error diagnostics. Upload it through `radius.pi.dev` or export the same report as a zip to inspect and share yourself. Uploads do not require a login; Radius authentication attributes the report to your account so the developers can follow up. If an upload fails, Pi offers to export the zip.


