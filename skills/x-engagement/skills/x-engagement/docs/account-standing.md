<!-- Source: https://github.com/xai-org/x-algorithm — abuse-enforcement-service/, agatha/, user-cred-v2/, bdsm/ -->
<!-- Cached: upstream/enforcement-user-rules.md, upstream/enforcement-post-rules.md -->
<!-- Snapshot: 28e414f, 2026-08-21 -->

# Account Standing

Published **2026-08-13** (with BDSM public-note refinements through **2026-08-14**). Several systems
score your **account**, not your posts, and the labels they assign feed straight into the
out-of-network drop rules in **[Visibility Filtering](visibility-filtering.md)**.

This is the layer that decides whether your content is eligible for reach at all. It operates on
timescales of weeks and is invisible from engagement metrics.

## The scorers

| System | What it reads | Output |
|---|---|---|
| `agatha/` | Blocks, reports and spam reports **relative to favorites**, batch jobs | Account labels incl. spam-suspension and adult-content |
| `user-cred-v2/` | PageRank over the follow graph **and engagement edges** | Credibility score, 0–100 |
| `bdsm/` | Your **sequence of actions over time** | Inauthentic / coordinated-behaviour signal |
| `grox/` | Post text and media at publish time | Content labels (spam, slop, gibberish, adult, violent) |

### Agatha — the ratio that matters

`agatha/` labels an account from **how others respond to its posts: blocks, reports and spam
reports relative to favorites** (`README.md`, Content Understanding table).

It is a **ratio**, not a count. A post that earns 500 likes and 5 blocks is in different standing
from one that earns 50 likes and 5 blocks. This is the mechanism by which deliberately
antagonistic content is expensive even when it "performs" — the engagement it wins is the
denominator, and the blocks are the numerator.

This also pairs with the `report` weight of −234.0 in
**[Scoring Weights](scoring-weights.md)**: a report can cost you in ranking *via personalized
P(report)* and again as a durable account label through Agatha. Do **not** treat the weight as a
raw "one report cancels N likes" conversion — upstream rejected that reading on 2026-08-14.
Mass-report campaigns that never appear on Home Timeline also do not feed ranking.

### User-cred-v2 — PageRank, and the immunity it buys

`user-cred-v2/UserCredV2.scala:10-18` computes a score from PageRank mass over follow and
engagement edges:

```scala
private val ScoreSlope = 7.07
private val ScoreIntercept = 165.2
rawScore = ScoreIntercept + ScoreSlope * log(mass)
score    = (rawScore max 0.0) min 100.0
```

Logarithmic, clamped to 0–100. Because it runs over the *graph*, who follows and engages with you
matters more than how many do — edges from well-connected accounts carry more mass.

**This score buys enforcement immunity.** The very first rule in the post enforcement chain
(`enforcement_post.yaml:31-37`):

```yaml
- id: pagerank_skipped
  when: >
    (cred.is_high || cred.score >= 50.0)
    && !score.skip_author_credibility_prechecks
  then: { kind: skip, reason: pagerank_skipped }
```

If your credibility score is **≥ 50** the post enforcement rules below it are skipped entirely.
Established accounts in a real network genuinely are treated differently — the same post can be
labelled on a new account and pass on a credible one.

A `high_follower_count` rule (`enforcement_post.yaml:24-29`) grants the same skip. Its published
threshold is **deliberately fake** — the file comments *"Prod uses a different follower count
floor; this is a mock value to reduce gaming."* So the exemption is real; the number is not
knowable from the repo.

Practical reading: **building graph credibility is a prerequisite, not a nice-to-have.** New
accounts running aggressive content or reply strategies have no such buffer.

### BDSM — behaviour over time

`bdsm/` is a bidirectional transformer over your recent action sequence, with **time-aware RoPE**:
rotary position embeddings driven by action timestamps rather than token index, "so the model
natively represents inter-action timing (**burstiness, mechanical cadence**)"
(`bdsm/README.md`).

It is explicitly looking at *rhythm*. Scheduled bursts, fixed-interval posting, and rapid-fire
templated replies are the pattern this model exists to find. This is the system that punishes
automation-shaped behaviour, independent of whether any individual post is fine.

## The enforcement rules

`abuse-enforcement-service/` acts on those scores. The rules are published and short — read
[`upstream/enforcement-user-rules.md`](upstream/enforcement-user-rules.md) and
[`upstream/enforcement-post-rules.md`](upstream/enforcement-post-rules.md) in full.

### LLM slop is an explicit, labelled offence

**Account level** (`enforcement_user.yaml:51-57`):

```yaml
- id: act_add_llm_slop_label
  when: '"llm_slop_user" in score.labels'
  then:
    kind: act_add_labels_v2
    labels: ["SpamHighRecall"]
    ttl_msec: 2592000000
```

`2592000000` ms = **30 days**. And `SpamHighRecall` on a user is exactly what
`SPAM_HIGH_RECALL_USER_DROP` keys on in the OON-only drop list.

Chain it together:

```
labelled llm_slop_user
  → SpamHighRecall on the account, 30-day TTL
  → SPAM_HIGH_RECALL_USER_DROP fires for TimelineHomeRecommendations
  → every post dropped from out-of-network for a month
  → followers still see everything, so your timeline looks normal
```

**Post level** (`enforcement_post.yaml:39-61`), all with 30-day TTLs:

| Score label | Applied post label |
|---|---|
| `llm_slop_post` | `RiskyHighVizReply` |
| `gibberish_post` | `SpamHighRecall` |
| `fast_reply_spam_post` | `SpamHighRecall` |
| `anchor_campaign_post` | `SpamHighRecall` |
| `SpamEmbeddingPtosDistilled` | `SpamHighRecall` |

Note `fast_reply_spam_post` and `RiskyHighVizReply` — replies are specifically modelled, and speed
is a signal. A high-volume reply strategy is the exact shape these rules describe.

`SpamEmbeddingMajorityPoster` (`enforcement_user.yaml:59+`) targets accounts whose posts cluster
tightly in embedding space — i.e. saying the same thing repeatedly in different words.

## What this changes about the playbook

1. **Standing is upstream of everything.** A 30-day `SpamHighRecall` label costs more than any
   post can earn. Nothing in the scoring model compensates.
2. **Generic AI-written content is a named, enforced category.** `llm_slop_user` /
   `llm_slop_post` are real label names with real consequences. "Sounds like everyone else" is
   now a durable penalty, not just weak ranking.
3. **Cadence is scored, not just content.** `bdsm/` reads burstiness and mechanical timing
   directly. Post like a person.
4. **Reply volume is the highest-risk strategy in the playbook.** `fast_reply_spam_post`,
   `RiskyHighVizReply`, and the low-follower reply spam classifier all converge on it.
   → See **[Conversation Tactics](conversation-tactics.md)**.
5. **Credibility ≥ 50 is a buffer worth building before anything aggressive.** Follow graph and
   engagement edges, built slowly, buy you the `pagerank_skipped` path.
6. **Antagonism is priced as a ratio.** Agatha divides blocks/reports by favorites. Content that
   wins arguments and loses that ratio is a bad trade.
7. **Penalties expire.** 30-day TTLs mean standing recovers. A suppressed month is a month, not
   permanent — provided the behaviour stops.

## Verify rather than guess

The **Under the Hood** transparency tool shows the labels actually on your account and posts. Use
it before assuming a suppression story. → **[Visibility Filtering](visibility-filtering.md)**.

## Caveat

The label *thresholds* live in the Grox classifiers and in botmaker rules, and upstream withholds
the Grox `.j2` prompts and some botmaker rules to limit gaming (`README.md`, "What's not in this
repo?"). The rules above are the published enforcement chain; what trips `llm_slop_user` in the
first place is not public.

The enforcement YAML is also a **mirror**, not the live config — its header reads *"mirrored from
GrowthBook dynamic config; last sync 2026-08-06T16:20:00Z"*. Rules and TTLs can change in
production without the file changing. Treat the mechanisms as solid and the exact numbers as
indicative.
