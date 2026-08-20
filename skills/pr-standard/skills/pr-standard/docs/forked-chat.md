# Write the body in a forked chat

Do not draft the description in the same conversation that wrote the code. That conversation already
understands the change. It writes for itself, and a reviewer cannot follow the result.

The fork starts from the same context but carries a different job: explain the change **so that a
common reviewer understands it**.

---

## The five steps

1. **Finish the code on the main chat.** Commit and push the branch first.
2. **Fork the conversation.** Give the fork three things:
   - the diff summary (`git diff --stat main...HEAD`, plus `gh pr diff` when the PR exists),
   - the diagram text,
   - the linked issues and ADRs.
   Tell it to apply this card.
3. **The fork writes the body and posts it.** It fills every section, checks the mermaid, sets the
   four labels, and runs `gh pr create --body-file` or `gh pr edit --body-file`.
4. **Drop the fork.**
5. **Continue the main chat.**

This binds humans and agents. Any in-repo agent or skill that opens a PR follows the same five steps.

---

## The handoff prompt

Give the fork this, with the three inputs filled in:

```text
Write the pull request body for this branch. Apply the pr-standard skill.

Diff summary:
<paste git diff --stat and the file list>

Diagram:
<paste the mermaid text, or say "none yet — produce one">

Linked issues:
<#123, ADR-0004>

Requirements:
- Fill every section of the template. Do not replace it with one paragraph.
- Apply the six ASD-STE100 rules to the body and to the prose inside the diagram.
- Write for a reviewer who has not read this branch.
- Length is whatever the reviewer needs. Cut filler, not information.
- Post with `gh pr create --body-file` and set the four labels.
```

---

## Why a fork, and not a fresh chat

A fresh chat has no context and invents it. The conversation that wrote the code has all the context
and assumes it. The fork holds the context and is told to spend it on the reviewer.

---

## When you cannot fork

Some harnesses have no fork. Then do this instead:

1. Write the diff summary, the diagram text, and the issue list to a file.
2. Start a subagent, or a new session, with that file as its only input.
3. Have it produce the body.

The goal is the same: the writer must not be the reader of its own memory.
