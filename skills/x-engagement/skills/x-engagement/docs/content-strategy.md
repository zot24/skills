<!-- Source: X Engagement Playbook + xai-org/x-algorithm codebase -->

# Content Strategy

## Hook First, Context Later — But Hold Attention After

People scroll fast. Your first line decides whether anyone reads the rest.

A hook gets the stop. Substance is what converts the stop into a reply, quote, share or follow —
the actions the model actually pays for. **Both matter**, but see
[Dwell — What It's Actually Worth](#dwell--what-its-actually-worth) below: attention is the
precondition, not the payoff.

### Hook Structure

```
hook
↓
context
↓
story
↓
lesson
```

### Bad vs Good Openings

**Bad:**
> I updated my Spanish DNI recently because...

**Good:**
> People obsess over the "183-day rule".
> But that's rarely the real issue.

The hook should create curiosity or challenge a common belief.

## Build Content Clusters

Instead of isolated tweets, create **topic clusters** - interconnected posts on the same theme.

### Example Cluster

| Post | Topic |
|------|-------|
| 1 | 183-day rule myth |
| 2 | Spanish DNI address change |
| 3 | Accountants giving bad advice |
| 4 | Modelo 030 explanation |
| 5 | How to break tax ties properly |

When one tweet gets traction, the others get traffic too. Each post reinforces the others.

## Never Drop Naked Links

Links alone look spammy and get suppressed by the algorithm.

### Structure for Link Sharing

```
statement
insight
context
👇
link
```

### Example

> Days alone won't protect you.
>
> You also need to align your documents, address, and legal ties with the country you claim to live in.
>
> Part of what I personally did 👇
> (link)

The link becomes **supporting evidence**, not promotion.

## Controversial Truths Drive Engagement

Topics that challenge common beliefs naturally trigger engagement.

Example: The "183-day rule" myth activates multiple communities:
- Digital nomads
- Tax twitter
- Crypto twitter

Conflict and disagreement drive replies, which drive reach.

## Content Formula

```
controversial truth
+
practical knowledge
+
real-life examples
+
conversation hijacking
= reach
```

All four elements must be present for maximum impact.

## Dwell — What It's Actually Worth

The published weights deflate this considerably (`home-mixer/params/param.rs`):

- `dwell` (binary): **0.0** — predicted, but contributes nothing
- `cont_dwell_time`: **0.004** — the smallest non-zero positive in the model
- `not_dwelled`: **−0.02** — the smallest term in the model, period

So a post that holds attention but earns nothing else scores near zero, and a hook that fails to
hold costs you almost nothing directly. **"Optimize for dwell" is not supported by the weights.**

Attention is still worth designing for, but as a *means*: nobody replies, quotes, DM-shares or
follows from a post they didn't read. Hold attention to earn the 4.0–5.0 actions, not for the
0.004.

The real penalty for thin content isn't the scroll-past — it's `not_interested` (−43.2) and
`mute_author` (−58.8). Boring is cheap; irritating is expensive. And irritating is *not* the same
as "one report deletes forty-seven replies" — see [Scoring Weights](scoring-weights.md) for the
2026-08-14 probability semantics.

→ **[Scoring Weights](scoring-weights.md)**

### Attention tactics
- Break long thoughts across multiple lines to slow the read
- Use numbered progressions that pull readers forward ("3 of 5 surprises people...")
- End posts with a question or open loop that invites a reply
- Give enough substance that even sophisticated readers learn something

## Freshness window

Two separate mechanisms punish "let it age and ride the counts":

1. Visibility filtering's `DropStaleTweetsRule` ages posts out of eligibility.
2. Phoenix (2026-08-14) can flag posts older than ~14 days (`IS_STALE_POST14D`) and **zero their
   engagement-count features** when `enable_stale_post` is on — so old viral tallies stop helping
   the model the way fresh counts do.

**Ship, distribute, and earn actions while the post is young.** Clusters still work; resurrection
of month-old bangers via raw counts is a weaker bet than it looks.

## Author Diversity Penalty

If you have multiple posts competing for a viewer's feed, the algorithm applies a **decay
multiplier** to each successive post from the same author. With published defaults (decay 0.5,
floor 0.25) your 2nd post keeps **62.5%** of its score and your 3rd **43.75%**, tailing to a 25%
floor.

A second penalty stacks on top: `vm-ranker/` reorders by embedding dissimilarity, so posts that
resemble each other are demoted even across different authors. As of 2026-08-21, slate context
also tracks 3-level semantic-ID recurrence (`sid_k_l*`, `sid_gap_l*`) and forwards it into
VMRanker — so flooding one topic cluster is a diversity problem even when the author-decay math
only keys on author `k`.

**Quality beats quantity, and variety beats repetition.** One excellent post outperforms three
average ones that split your author score budget — and three rephrasings of the same take, or
three posts in the same semantic cluster, are worse still.

## Screening and Eligibility

Every non-reply post is screened by a Grok VLM (**Banger Initial Screen**) at publish time, which
classifies it into the topic taxonomy and scores it for slop. There is **no published numeric
quality threshold** — the widely repeated `quality_score ≥ 0.4` gate came from a file deleted on
2026-08-13.

What actually decides whether you reach non-followers is the label-and-drop chain in visibility
filtering, which keys largely on **account-level** standing — plus jurisdiction-specific candidate
filters such as `Brazil2026ElectionFilter` (listed authors hidden from For You unless followed).

- → **[Content Quality Screening](content-quality.md)** — what the screen produces
- → **[Visibility Filtering](visibility-filtering.md)** — what drops you from recommendations
- → **[Account Standing](account-standing.md)** — how accounts pick up the labels that do it
