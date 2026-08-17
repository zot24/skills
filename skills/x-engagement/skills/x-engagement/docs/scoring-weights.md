<!-- Source: https://github.com/xai-org/x-algorithm/blob/main/home-mixer/params/param.rs (cached at upstream/home-mixer-params.md) -->
<!-- Snapshot: c65aa17, 2026-08-14 -->

# Published Scoring Weights

xAI published the actual blend weights on **2026-08-13**. On **2026-08-14** they added long-form
comments in `param.rs` and `ranking_scorer.rs` correcting how those weights must be read. Before
2026-08-13 the weights were private and any ranking of "which action matters most" was inference.
These are the real defaults, from `home-mixer/params/param.rs`.

Cached verbatim at [`upstream/home-mixer-params.md`](upstream/home-mixer-params.md) — grep it to
confirm any number below.

## Read this before you read the table

Upstream states (`param.rs` comments expanded 2026-08-14; also `ranking_scorer.rs` on `apply`):

> These weights reflect a combination of how much an action is valued in ranking **and typical
> propensities of these actions across the X network** (e.g. negative feedback is overall rare).

And, explicitly:

> Each weight multiplies the *predicted* probability of that action (P(favorite), P(repost), …)
> or a continuous value e.g. watch time — the weights do **not** multiply raw engagement counts.
> One common misinterpretation is that you can read these weight ratios as count equivalences,
> e.g. the incorrect statement that "one report cancels 468 likes."

A weight is not a strategic priority. The score contribution of an action is:

```
contribution = weight_i × P(action_i | viewer, post)
```

That probability is personalized and substantially driven by the viewer's own behaviour. The
baseline P(report) is **more than 1000× lower** than P(like); the large negative weight exists so
the report *prediction* can move the final score at all — not so that one raw report erases dozens
of raw likes.

`share_via_copy_link` carries the largest weight (20.0) precisely *because* almost nobody copies a
link. A high weight compensates for a low base rate — it does not mean "chase this action."
Do not read the table as a to-do list ranked top to bottom.

What the numbers *do* settle: which actions the model counts for nothing, and how far apart the
tiers actually are.

## Positive weights

| Action | Weight | `param.rs` |
|---|---:|---|
| `share_via_copy_link` | 20.0 | `:326-330` |
| `reply` (bidirectional-follow boost) | +15.0 | `:284-289` |
| `reply` | 5.0 | `:283` |
| `quote` | 5.0 | `:332` |
| `share_via_dm` | 5.0 | `:319-324` |
| `follow_author` | **4.0** | `:345-350` |
| `share` | 2.0 | `:318` |
| `retweet` | 1.0 | `:296` |
| `favorite` (like) | 0.5 | `:282` |
| `click` | 0.4 | `:309` |
| `open_link` | 0.2 | `:310` |
| `photo_expand` | 0.05 | `:297-302` |
| `video_open` | 0.05 | `:303-308` |
| `vqv` (video quality view) | 0.05 | `:317` |
| `quoted_click` | 0.05 | `:333-338` |
| `post_unexplored` | 0.02 | `:351-356` |
| `cont_dwell_time` | 0.004 | `:375-380` |
| `dwell` | **0.0** | `:331` |
| `profile_click` | **0.0** | `:311-316` |
| `quoted_vqv` | 0.0 | `:339-344` |
| `cont_click_dwell_time` | 0.0 | `:381-386` |

## Negative weights

| Action | Weight | `param.rs` |
|---|---:|---|
| `report` | −234.0 | `:442` |
| `mute_author` | −58.8 | `:436-441` |
| `not_interested` | −43.2 | `:424-429` |
| `block_author` | −31.2 | `:430-435` |
| `not_dwelled` | **−0.02** | `:443-448` |

All of the above are read into the weighted scorer at
`home-mixer/scorers/ranking_scorer.rs:74-103`.

## What the numbers actually change

**Binary dwell is worth zero.** `DwellWeight` defaults to `0.0`. Only `cont_dwell_time` scores,
at `0.004` — the smallest non-zero positive in the model. Holding attention is still worth
designing for (it feeds reposts, replies and follows), but "the algorithm rewards dwell" is not a
claim the defaults support.

**`not_dwelled` is the weakest penalty in the model, not a headline risk.** At `−0.02` it is four
orders of magnitude below `report`. A hook that doesn't deliver costs you roughly nothing
directly. The real cost of thin content is `not_interested` (−43.2) and `mute_author` (−58.8) —
i.e. actively annoying someone, not merely failing to hold them.

**Negative feedback still dominates risk — without the count-equivalence myth.** The weight
magnitudes look extreme (−234.0 report vs 5.0 reply) because rare actions are scaled up so their
*predictions* matter. Upstream rejects reading that as "1 report cancels ~47 replies." Two further
guards against mass-report gaming (same 2026-08-14 comments):

1. **Personalization** — recommendations use *your* predicted P(report/block), so brigading from
   dissimilar bad actors mainly hurts ranking for viewers like those actors, not the whole network.
2. **Home Timeline only** — actions only count for ranking if they happen on a post *served in*
   Home Timeline. Navigating straight to a post (e.g. coordinated via group chat) has no ranking
   impact, and you cannot force a post into someone's Timeline in a reliably reproducible way.

Strategically: still avoid content that invites mute, block, or report. Agatha and account labels
are the durable cost. Just stop teaching the false "one report = N likes" ratio.

**`profile_click` scores nothing.** Content designed purely to drive profile visits earns no
ranking credit for the visit itself.

**Quote ≠ repost.** A quote is worth 5× a bare repost (5.0 vs 1.0). Content that invites people to
add their own take outranks content people merely forward.

**Follow is valuable but not supreme.** At 4.0 `follow_author` sits below reply, quote and DM
share. It is still the only action that compounds — a follow changes every future impression, and
the weighted score is a per-impression quantity that cannot capture that. Design for follows for
that reason, not because the weight is highest. It isn't.

## The bidirectional-follow reply boost

`BidirectionalFollowReplyWeightBoost = 15.0` (`param.rs:284-289`), applied at
`ranking_scorer.rs:180-193`. Upstream ships a design note for it:
[`upstream/bidirectional-boost.md`](upstream/bidirectional-boost.md).

Eligibility is narrow (`ranking_scorer.rs:180-184`) — all three must hold:

- the candidate is a **root post** (not a reply)
- it is **not a retweet**
- `is_mutual_follow_author == true` — viewer and author **follow each other**

When eligible, reply weight goes `5.0 → 20.0`, making it the largest positive term in the model.

Strategic reading: **a mutual follow is worth ~4× a one-way follower** on your root posts, for that
viewer. Followers you also follow back are structurally more valuable than raw follower count.
Note this is a property of the *relationship*, not something a single post can manufacture.

## Out-of-network weighting

Scores for out-of-network content are multiplied down after the weighted sum
(`ranking_scorer.rs:679-700`):

| Factor | Value | Source |
|---|---:|---|
| `OonWeightFactor` | 0.75 | `param.rs:246-251` |
| `TopicOonWeightFactor` | 0.5 | `param.rs:266-271` |
| `NEW_USER_OON_WEIGHT_FACTOR` | 0.00001 | `config.rs:38` |

Reaching non-followers costs a flat 25% of your score; topic-based OON costs 50%. You need to
out-score in-network content by that margin to surface.

The new-user factor is **suppression, not a boost** — `0.00001` is near-total. It applies to
accounts younger than `NewUserAgeThresholdSecs`, which **defaults to `0`** (`param.rs:272-277`),
so with published defaults the branch is dead (`age < 0` is never true) and every OON candidate
takes the 0.75 factor.

## Author diversity decay

`ranking_scorer.rs:614-615`:

```rust
multiplier = (1.0 - floor) * decay_factor.powf(exponent) + floor
```

Defaults: `AuthorDiversityDecay = 0.5`, `AuthorDiversityFloor = 0.25` (`param.rs:229-239`).
`exponent` is your post's position among *your own* posts in that feed response, best-scoring
first.

| Your post, ranked | Multiplier |
|---|---:|
| 1st | 1.000 |
| 2nd | 0.625 |
| 3rd | 0.438 |
| 4th | 0.344 |
| → ∞ | 0.250 |

Your second post in a single feed load keeps 62.5% of its score, your third 43.75%. Volume does
not compound — each extra post competes against your own best one.

## Second diversity penalty: VMRanker

`vm-ranker/` reorders already-scored posts with a **determinantal point process** over their
embeddings, trading a little score for less similarity between neighbours
(`README.md`, Ranking table). `EnableVMRanker` defaults to **`true`** (`param.rs:578-583`) — this
one is on.

Consequence beyond author diversity: posting several near-identical takes hurts even across
different authors. Topic clusters work; near-duplicate phrasings of the same post do not.

## Params that are OFF by default

Published defaults, easy to mistake for live behaviour:

| Param | Default | `param.rs` |
|---|---|---|
| `EnableMutualFollowJaccardHydration` | `false` | runtime key |
| `EnableFollowingRepliedUsersFacepile` | `false` | runtime key |
| `EnableMpnScoring` | `false` | runtime key |
| `EnableClickDwellLowFavRatePenalty` | `false` | runtime key |
| `EnableMultiplicativePostUnexplored` | `false` | runtime key |
| `EnableColdStartThompsonSampling` | `false` | added 2026-08-14 |

These are runtime-overridable params (the string keys are override handles), so a `false` default
does not prove the feature is off in production — only that the published default is off. Treat
tactics built on them as speculative.

### Cold-start Thompson sampling (off by default)

`home-mixer/scorers/author_cold_start.rs` can optionally pick the cold-start boost slot with
Thompson sampling over a Beta prior on fav/view rate (`EnableColdStartThompsonSampling`, default
`false`). Published priors: `ColdStartBetaAlpha0=0.75`, `ColdStartBetaBeta0=49.25`,
`ColdStartTsTopK=5`, `ColdStartImpressionScale=1.0`. When off (default), cold-start still picks by
argmax score among low-impression eligible posts. Practical takeaway if/when enabled: low-data
posts get a structured explore path — freshness and early positive rate matter more than raw
count lead.

## Verifying any of this

```bash
grep -n "Weight\|WeightFactor" docs/upstream/home-mixer-params.md
```

All `param.rs:NNN` citations above are **upstream** line numbers. The cached copies carry a
two-line `> Source:` header, so cached line = upstream line + 2.

If a constant in this file no longer matches that cache, the cache moved and this document is
stale — re-derive it and bump `snapshot_commit` in `sync.json`.
