# Google Stitch and the DESIGN.md format

Two Google Labs tools fit this pipeline. **DESIGN.md** is a file format with a linter, and stage 6
writes the lock in it. **Stitch** is a screen generator with an agent-first CLI. Stitch is
optional: it drafts directions and variants faster, but the mock-up rules still apply to whatever
it produces.

Upstream references, cached here and synced by CI:

- [DESIGN.md README](upstream-design-md-readme.md): the CLI (`lint`, `diff`, `export`, `spec`) and the linting rules
- [DESIGN.md spec](upstream-design-md-spec.md): the token schema, section order and consumer rules
- [Stitch skills](upstream-stitch-skills-readme.md): Google's agent skills for Stitch (generate, extract DESIGN.md, React conversion, `stitch-loop`, `taste-design`)

The Stitch CLI is documented on npm (`@google/stitch`) and at `stitch.withgoogle.com`. It is in
alpha, so run `stitch <command> --schema` before you rely on any flag named here.

## DESIGN.md: the lock's file format

`design.md` keeps the role [lock and structure](lock-and-structure.md#designmd) gives it. It is
also written in Google's DESIGN.md format, so any agent or tool that reads the format gets the
site's tokens without a translation step.

- **Two layers.** The YAML front matter holds the normative values: `colors`, `typography`,
  `rounded`, `spacing` and `components`, with components pointing at tokens by reference
  (`"{colors.accent}"`). The Markdown body holds the reasons and the rules. When prose and tokens
  disagree, the tokens win, so update both in one edit.
- **Name the primary.** Define a `primary` colour and at least one typography token. When either
  is missing, a consuming agent fills the gap with its own default, which is the generic look this
  skill exists to avoid.
- **Canonical sections first, in order:** Overview, Colors, Typography, Layout, Elevation & Depth,
  Shapes, Components, Do's and Don'ts. The site's extra sections (motion, mobile, rendering
  contract, build gates) come after them. The format keeps unknown headings, so nothing is lost.
- **Every pair you rely on goes in a component.** The linter checks contrast only on component
  `backgroundColor` and `textColor` pairs. A pairing that lives only in prose goes unchecked, so
  give the claim-and-caveat block, the buttons and the mobile action bar their own component
  entries.

### Gates

Run these in the worktree and record their output in the lock report:

```bash
npx -y @google/design.md@<pinned> lint design.md > .design-specs/design-lint.json   # exit 1 on errors
npx -y @google/design.md@<pinned> export --format css-tailwind design.md > src/styles/theme.css
npx -y @google/design.md@<pinned> diff design.locked.md design.md                   # exit 1 on regression
```

- **Pin the version.** The format is alpha and its rules change between releases.
- **Read warnings, not only the exit code.** `lint` exits 0 on warnings, but `contrast-ratio`,
  `missing-primary`, `missing-typography`, `orphaned-tokens` and `section-order` are all real
  defects for a lock. The lock is done when the JSON summary shows zero errors and zero warnings,
  or when each remaining warning is listed under Do's and Don'ts as a deliberate choice.
- **Keep the frozen copy.** At the lock, copy `design.md` to `design.locked.md`. Every later
  change to the look runs `diff` against it, and the build report names each changed token.
- **The exported theme is the only token source.** The build imports the exported CSS and does not
  hand-copy hex values into components. Regenerate it whenever `design.md` changes.
- **Add a CI check.** In the site repo, a GitHub Actions job runs `lint` on every pull request that
  touches `design.md` and fails when the JSON summary reports any error or warning. A Node script or
  `jq` reads `.summary`. It belongs with the repo's other checks, not with the deploy.

The linter does not check focus states, semantics, motion or the fold. Those stay with the
blind reviewer in [build and review](build-and-review.md).

## Stitch: an optional generator for stages 3 to 5

Use Stitch when the owner wants more variants than are practical to hand-write, or wants to flip
through screens on a canvas. You are still the design director. Stitch drafts, and you curate.

### Before the first call

- **Get the owner's word.** Stitch uploads prompts, captured pages and DESIGN.md files to Google,
  so it counts as an outside contact. Ask once on the [decisions page](decisions-page.md), and log
  every call in the directions file's calls table. When the owner says no, the pipeline runs exactly
  as before.
- **Check the quota.** Generation draws on the account's Stitch quota. Check it in the account
  before a batch, and keep each round to the number of screens the owner will actually compare.
- **Authenticate without secrets in the repo.** Run `stitch login` for OAuth. Some canvas commands
  also need `STITCH_API_KEY`, which comes from the secret store and never from a committed file.
  Keep `.stitch.json` and `.stitch/` in `.git/info/exclude` alongside the specs folder.

### Where it fits

| Stage | Stitch move | What stays yours |
|---|---|---|
| 1 Learn | `stitch capture <url>` saves today's page as one HTML file; `stitch upload screen` puts it on the canvas | The census, the snapshot and the screenshots of today |
| 3 Directions | `stitch generate screen` per direction, with a prompt built from the direction's axes, palette hexes and faces, never the category name alone | The Inspo study, the tells, the axes table and the distinctness check |
| 5 Family loop | `stitch generate variants --creative-range REFINE --aspects <one>` from the frozen favourite | One variant, one change. Use one aspect per variant (`LAYOUT`, `COLOR_SCHEME`, `TEXT_FONT`) so each variant names its change |
| 5 "Actually different" | `--creative-range REIMAGINE`, seeded from a fresh study, not from the favourite | All four axes must still differ; REIMAGINE output often keeps the favourite's paper or face, so check |
| 6 Lock | `stitch upload design design.md` applies the lock to the canvas screens for an owner preview | `design.md` is written and linted here, never exported from Stitch unread |

`EXPLORE` sits between the two and suits a round where the owner said "close, but not quite".

### Stitch output is raw material

A Stitch screen is never shown to the owner as it comes. Before it enters the index:

1. **Replace the copy.** Stitch writes its own text. Swap every string for the copy spec's row,
   mark open strings in yellow, and delete invented proof such as counters, logos and testimonials.
2. **Strip the network.** Inline the CSS. Remove CDN scripts, remote images and fonts other than
   the Google Fonts stylesheet. Replace photos with the labelled grey blocks.
3. **Restore the contract.** Add the corner tag, `noindex`, a single `h1`, and the claim and caveat
   in one block.
4. **Run the tell scan.** Generators drift towards the defaults the [tells table](directions.md#tells-to-design-against)
   lists, such as three equal cards, a purple accent or Inter. Fix them, or drop the screen.
5. **Run the same browser check** as every other mock ([mock-ups](mock-ups.md#check-every-file-in-a-real-browser)).

Name the source in the index card ("drafted in Stitch, reworked") so the owner knows how it was
made. When the reworked file and the Stitch canvas disagree, the file wins.

### Traps

- **False success.** A command can report a change it did not make. Fetch the screen
  (`stitch get screen … --json`) or look at it before you claim it changed.
- **Clarification instead of a screen.** Generation can stop with a question
  (`CLARIFICATION_REQUIRED`). Answer it with a prompt that holds the direction's constraints. Do not
  rerun the same prompt.
- **One prompt cannot hold a whole design.** For multi-page drafts, put the constraints in a DESIGN.md
  and upload it first, and only then generate pages. Without it, every screen drifts to a new style.
- **The CLI's own agent skill** (`stitch agent-skills add`) teaches an agent the commands. It does
  not replace this pipeline's stops. Install it per project, not user-wide.
