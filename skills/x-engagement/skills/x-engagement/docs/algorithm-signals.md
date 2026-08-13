<!-- Source: https://github.com/xai-org/x-algorithm (direct codebase analysis) -->
<!-- Snapshot: a389166, 2026-08-13 -->

# X Algorithm Signals Reference

The signals the Phoenix ranking model predicts, and what the pipeline does with them.

**For the actual numbers, see [Scoring Weights](scoring-weights.md)** — xAI published the blend
weights on 2026-08-13. This file covers which signals exist and how they combine; that file covers
what each is worth.

## How Scoring Works

Phoenix (a Grok-based transformer) predicts probabilities for multiple viewer actions. Those are
multiplied by configurable weights and summed:

```
Final Score = Σ (weight_i × P(action_i))
```

Positive weights add, negative weights subtract. The result is then adjusted by author diversity
and out-of-network factors, and the top K are selected.

Ranking decides **order**. It does not decide whether you are eligible to appear at all — that is
**[Visibility Filtering](visibility-filtering.md)**, a separate system.

## Positive Signals

| Signal | What Triggers It |
|---|---|
| `share_via_copy_link` | Viewer copies the post link |
| `reply` | Viewer replies |
| `quote` | Viewer quotes the post |
| `share_via_dm` | Viewer sends the post to someone via DM |
| `follow_author` | Viewer follows you after seeing the post |
| `share` | General share action |
| `retweet` | Viewer reposts |
| `favorite` | Like |
| `click` / `open_link` | Viewer opens the post or a link in it |
| `photo_expand` | Viewer expands an image |
| `vqv` / `quoted_vqv` | Video quality view (watched a substantial portion) |
| `cont_dwell_time` | Time-weighted reading time |
| `dwell` | Binary "viewer dwelled" |
| `profile_click` | Viewer taps through to your profile |
| `post_unexplored` | Exploration term for posts with little engagement history |

Three of these carry a **default weight of 0.0** — `dwell`, `profile_click` and `quoted_vqv`.
They are predicted but contribute nothing to the score. See
[Scoring Weights](scoring-weights.md).

## Negative Signals

| Signal | What Triggers It | Relative force |
|---|---|---|
| `report` | Viewer reports the post | Overwhelming (−234.0) |
| `mute_author` | Viewer mutes you | Very strong (−58.8) |
| `not_interested` | "Show me less of this" | Strong (−43.2) |
| `block_author` | Viewer blocks you | Strong (−31.2) |
| `not_dwelled` | Viewer scrolled past quickly | Negligible (−0.02) |

The spread here is the most important fact in the model. Negative feedback outweighs every
positive action by one to two orders of magnitude — one report cancels roughly 47 replies.
`not_dwelled`, by contrast, is the weakest term in the entire weight table; a hook that fails to
hold costs you almost nothing *directly*.

Note that `report`, `mute_author` and `block_author` also feed **account-level** labels via
`agatha/`, which is where the durable cost lives. → **[Account Standing](account-standing.md)**.

## Author Diversity Penalty

A decay multiplier is applied to posts from the same author within one feed response
(`home-mixer/scorers/ranking_scorer.rs:614-615`):

```rust
multiplier = (1.0 - floor) * decay_factor.powf(exponent) + floor
```

Defaults `decay = 0.5`, `floor = 0.25`: your 2nd post keeps 62.5%, your 3rd 43.75%, tailing to a
25% floor. **Posting volume doesn't compound — each additional post competes against your own
best post.**

A second, separate diversity penalty runs after scoring: `vm-ranker/` reorders by embedding
dissimilarity, so near-duplicate posts are demoted even across authors.

## Out-of-Network Weight

Out-of-network candidates are multiplied down after scoring: `OonWeightFactor` 0.75, topic-based
OON 0.5. Reaching non-followers costs a flat 25% of your score, so OON content must out-score
in-network content by that margin.

The `NEW_USER_OON_WEIGHT_FACTOR` (0.00001) is **suppression, not a perk**, and is dormant under
published defaults. Details in [Scoring Weights](scoring-weights.md).

## Candidate Sources

Three, not two:

| Source | Type |
|---|---|
| `thunder/` | In-network — recent posts from accounts you follow, held in memory |
| `phoenix/` retrieval | Out-of-network — two-tower embedding similarity over the global corpus |
| `simclusters/` | Out-of-network — clusters accounts and posts by who engages with what |

`simclusters/` was published on 2026-08-13. It means community structure is a distinct discovery
path from Phoenix's embedding similarity: being legibly *part of a cluster* is its own route to
non-followers.

## Network Alignment (Mutual Follow Jaccard)

`home-mixer/candidate_hydrators/mutual_follow_jaccard_hydrator.rs:16` computes a MinHash Jaccard
similarity between the viewer's mutual-follow set and the author's:

```
jaccard = (matching minhash positions) / (total positions)
```

**Gated by `EnableMutualFollowJaccardHydration`, which defaults to `false`**
(`home-mixer/params/param.rs:759-764`). The code is published; the published default is off.
Treat network-overlap tactics as plausible rather than established.

What *is* live and load-bearing is the **bidirectional follow reply boost**: +15.0 on reply weight
for root posts from an author the viewer mutually follows. Mutuals are worth roughly 4× one-way
followers on your root posts. → [Scoring Weights](scoring-weights.md).

## Facepile Social Proof

If people the viewer follows have replied to your post, a facepile of their avatars is shown.
Restricted to viewers with **≥ 1,000 followers**
(`home-mixer/candidate_hydrators/following_replied_users_hydrator.rs:13`,
`VIEWER_FOLLOWERS_THRESHOLD: i64 = 1000`).

Also gated by `EnableFollowingRepliedUsersFacepile`, default `false` (`param.rs:559-564`).

## How to Prioritize

The published weights do **not** give you a clean action ranking, because upstream states
explicitly (`param.rs:279-281`) that each weight blends "how much an action is valued in ranking
**and typical propensities of these actions across the X network**." A large weight often
compensates for a rare action. Score contribution is `weight × P(action)`, and you control
`P(action)`, not the weight.

What the code does support:

1. **Avoid negative feedback before optimizing anything else.** The negatives are 1–2 orders of
   magnitude larger than the positives, and they compound into account labels.
2. **Protect account standing.** An OON drop label makes the whole scoring model moot.
   → [Account Standing](account-standing.md)
3. **Earn replies and quotes.** Both 5.0, both well above like (0.5) and repost (1.0), and both
   plausibly reachable by design.
4. **Earn follows.** 4.0 per impression, but the only action that changes every *future*
   impression — a compounding return the per-impression score can't express.
5. **Write things worth sending to one specific person.** DM share 5.0, copy-link share 20.0.
6. **Hold attention** — but as a means to the above, not for `cont_dwell_time` (0.004) itself.
7. **Post less, better.** Author diversity decay plus VMRanker both penalize volume and
   repetition.

## Old patterns

<details>
<summary>Pre-2026-08-13: the inferred action hierarchy</summary>

Before the weights were published, this file ranked `follow_author` as "the highest-value action,
rewarded disproportionately," put DM share second, and listed dwell maximization fifth with
`not_dwelled` as a significant penalty.

The published weights do not support that ordering. `follow_author` is 4.0 — below reply, quote
and DM share, and far below copy-link share. `dwell` is weighted 0.0. `not_dwelled` is −0.02, the
smallest term in the model.

Kept here so anyone who acted on the old guidance can see precisely what changed.

</details>
