# Stage 7 — one decisions page

By this point owner questions are scattered: the copy spec's section 6, each directions file's
owner questions, the IA's open items, the yellow strings in the mock-ups. An owner will not open six
files. Gather every one into **one page** the owner answers in a single sitting, with the
recommended answer already selected, and read the answers back from that page before the next
stage starts.

## Collect

Read every source in full where its questions live. For each question write one object. Merge
duplicates across files into one decision and list every source.

```json
{
  "id": "<site>-copy-q3",
  "group": "<site>",
  "title": "The question in plain words, at most 12 words",
  "context": "One or two sentences a busy owner needs. No file names, no row ids.",
  "kind": "choice",
  "options": [
    { "value": "a", "label": "At most 10 words" },
    { "value": "b", "label": "At most 10 words" }
  ],
  "recommended": "a",
  "blocks": "What waits on it, at most 10 words",
  "source": "<path>, question 3; <other path>, item 7"
}
```

| Key | Rule |
|---|---|
| `id` | Short and stable: `<site>-design-pick`, `<site>-copy-q3`, `<site>-ia-n2`. Answers are stored under it, so never rename one |
| `group` | One per site, plus shared groups (content and knowledge base, agents and infrastructure) |
| `kind` | `choice` (pick one), `yesno`, or `fact` — a value only the owner knows: a name, a price, a count |
| `options` | For `choice` and `yesno`. Empty for `fact` |
| `recommended` | The option `value` the spec recommends. For a `fact`, the spec's **fallback** in plain words: what ships if the owner leaves it blank. A question with no recommendation says so on the card |
| `blocks` | What cannot move until it is answered |
| `source` | For you and the parent, never shown as the label |

**Order:** design picks first, then each site's copy questions most-blocking first, then shared
groups. Keep labels and context in the owner's plain words and pass them through `unslop` (read
`~/.claude/skills/unslop/SKILL.md`; it is user-invoked) before the page is built. Save the list as
`<specs>/owner-decisions.json` and a readable `owner-decisions.md` table beside it. With several
sites, keep one list for all of them in the folder of whoever runs them.

## Build the page

An Artifact with the `db` capability. When the Artifact tool is available, load its built-in
`artifact-design` and `artifact-capabilities` skills first; without it, use the fallback in this
doc. If your environment already has a decisions template with a slot for the decisions JSON,
inject the JSON into it and reuse it; otherwise build the page as this doc describes.

Without Artifacts, give the owner `owner-decisions.md` with an `Answer` column pre-filled with each
recommendation, ask them to edit it, and read the file back instead of the collection.

The page must:

- show each decision as a card in its group, the recommended option **pre-selected** and labelled;
- save on every change, with a "confirm recommended" button per card and per group;
- show progress (answered of total) and each card's state: not confirmed, recommended confirmed,
  changed by the owner, fact typed;
- give each card a free-text note for anything the options miss;
- let only the owner write; everyone else reads.

Answers go in the db collection `answers`, one document per decision, the document id equal to the
decision `id`:

```json
{ "value": "b", "note": "free text or empty", "recommended": "a", "at": "2026-01-01T12:00:00Z" }
```

Storing `recommended` beside `value` lets a reader tell "confirmed the recommendation" from "changed
it" without the source list.

## Read back

Before each later brief or stage, read the answers: `ArtifactData` action `list`, collection
`answers`, on the page's URL. Then:

1. Record each answer in the spec it came from (the copy spec's owner questions, the directions
   file, the IA), with the date.
2. Carry it into the next stage's task under a heading such as "Owner answers already in",
   quoting fact answers verbatim. An owner who types an old footer line instead of a name has answered: use the
   line, and drop the work that needed a name.
3. Unanswered decisions keep their fallback. Nothing ships on a guess.

When new questions arrive (a new IA, a new family), add them to the JSON and republish the same
page; ids already answered stay put.

**Done when:** every owner question in every spec is on the page exactly once, and every answer
read back from `answers` is recorded in the spec it came from.
