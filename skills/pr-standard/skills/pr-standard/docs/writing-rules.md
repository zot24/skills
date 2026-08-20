# The six writing rules (ASD-STE100)

The house standard for pull request prose is **ASD-STE100 (Simplified Technical English)**. These
six rules are the whole standard. Do not add more.

The rules cover two places: the description text, and the prose inside the mermaid diagram in that
description. Node labels, participant aliases, and note text are prose.

---

## 1. One idea per sentence

Split a sentence that carries two facts. Short sentences survive translation, skimming, and a
reviewer who opens the PR on a phone.

- Good: "The endpoint reads `lead_id`. It returns 404 when the row is absent."
- Bad: "The endpoint reads `lead_id` and returns 404 when the row is absent, which also covers the deleted case."

## 2. The same word for the same thing

Pick one noun per concept. Hold it for the whole PR, the diagram, and the commit messages. A synonym
reads as a second concept.

- Good: `client` in every sentence.
- Bad: `client`, then `customer`, then `account`.

Read the repo's `CLAUDE.md` for an agreed noun list before you choose. Projects fix their own nouns.

## 3. Active voice

Name the actor. Passive voice hides which component does the work.

- Good: "The migration adds `core.leads.phone`."
- Bad: "`core.leads.phone` is added by the migration."

## 4. Imperative in steps

Write instructions as commands.

- Good: "Run `pnpm test`."
- Bad: "You will want to run `pnpm test`."

## 5. No filler

Delete the word when the sentence keeps its meaning without it.

Banned: **basically, simply, just, actually, in order to, obviously, of course**.

- Good: "The view needs a base-table grant."
- Bad: "Basically the view just needs a base-table grant in order to work."

Filler also hides risk. "This simply moves the check" tells a reviewer that the change is safe. The
diff decides that, not the adverb.

## 6. Exact technical names

Write the identifier, not a description of it.

- Good: `public.processes`, `service_instance_id`, `apps/api/src/routes/leads.ts`
- Bad: "the processes view", "the instance id", "the leads route file"

---

## Length

**The description does not have to be short.** Give the reviewer the context, the mechanism, and the
risk. STE100 makes the text clear. It does not cap the length. Cut filler, not information.

A three-line body on a 600-line diff is a failure of the standard, not a success.

---

## Worked rewrites

**Before**

> This PR basically refactors the leads endpoint a bit so that it can handle the new phone field
> that was added by the migration, and it also fixes a small bug where the response was sometimes
> missing data for deleted records.

**After**

> The migration adds `core.leads.phone`. The endpoint `GET /leads/:id` now selects that column.
>
> The endpoint returned a partial row for a soft-deleted `lead`. It now returns 404. The check reads
> `deleted_at`.

**Before**

> We should probably run the tests in order to make sure nothing is broken.

**After**

> Run `pnpm test`. Run `pnpm type-check`.

---

## Checklist before you post

- [ ] No sentence carries two facts.
- [ ] One noun per concept, across the body and the diagram.
- [ ] Every sentence names its actor.
- [ ] Every step is a command.
- [ ] No banned word is present.
- [ ] Every identifier is exact.
