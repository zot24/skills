# pr-standard Skill

The house standard for GitHub pull request descriptions. One card that an agent or a human reads
before writing a PR body.

The prose rule is **ASD-STE100 (Simplified Technical English)**. The body rule is: fill the template.
The label rule is: four labels, every time.

## What This Skill Covers

- **Six writing rules** — one idea per sentence, the same word for the same thing, active voice,
  imperative in steps, no filler, exact technical names
- **The body shape** — Labels checklist, Summary, How It Works with a mermaid diagram, Linked issues,
  Testing evidence, Notes for reviewers
- **The four-label pack** — type (`bug` / `enhancement` / `documentation`), `priority:*`,
  `t-shirt:*`, and the repo's own `area:*`
- **Diagrams** — which type a change needs, when to commit a `.mmd` source, and the three mermaid
  patterns that GitHub refuses to render
- **The forked-chat workflow** — why the conversation that wrote the code must not write the body,
  and the handoff prompt that replaces it

## Usage

```
/pr-standard:pr-standard help              # Show available commands
/pr-standard:pr-standard write             # Write and post a body for the current branch
/pr-standard:pr-standard fix 812           # Rewrite an existing PR body
/pr-standard:pr-standard review 812        # Check an open PR against the standard
/pr-standard:pr-standard rules             # The six ASD-STE100 rules
/pr-standard:pr-standard template          # The body shape and skeleton
/pr-standard:pr-standard labels            # The four-label pack
/pr-standard:pr-standard diagram           # Diagram choice and mermaid traps
/pr-standard:pr-standard fork              # The forked-chat workflow
```

## The hard rule for agents

Do not run `gh pr create -b "<one paragraph>"`. Write the body to a file and pass `--body-file`.

```bash
gh pr create --title "feat(api): return phone on the lead endpoint" \
  --body-file /tmp/pr-body.md \
  --label enhancement --label priority:high --label t-shirt:small --label area:api
```

## Notes

- **`area:*` names are per repo.** Run `gh label list --limit 100` and pick from the result. Do not
  invent an area taxonomy inside a feature PR.
- **No CI job reads a PR body.** A diagram linter parses committed `.mmd` files and never opens the
  description. A green run is not proof that your diagram renders. Open the PR page and look.
- **Length is whatever the reviewer needs.** STE100 makes the text clear. It does not cap the length.
- **Repo-local rules win.** A repo can require an ERD, a diagram index, or an agreed noun list. Read
  its `CLAUDE.md` first. This card is the floor.

## Documentation

- [Writing rules](./skills/pr-standard/docs/writing-rules.md)
- [Body template](./skills/pr-standard/docs/body-template.md)
- [Labels](./skills/pr-standard/docs/labels.md)
- [Diagrams](./skills/pr-standard/docs/diagrams.md)
- [Forked chat](./skills/pr-standard/docs/forked-chat.md)

## Sources

This skill has no upstream source. The standard is house policy, first written as
`docs/guides/PR_DESCRIPTION_STANDARD.md` in a private repo and promoted here so that every repo
shares one card. `sync.json` carries an empty `sources` array for that reason.
