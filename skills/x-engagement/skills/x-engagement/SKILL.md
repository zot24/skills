---
name: x-engagement
description: Crafts high-engagement X (Twitter) content using the published X recommendation algorithm weights, visibility filtering rules, account standing signals, conversation tactics, and the Original Content Rewards monetization rules. Use when writing tweets, planning X content strategy, building audience, optimizing engagement, diagnosing lost reach, or checking creator payout eligibility. Triggers on mentions of X, Twitter, tweets, threads, engagement, audience growth, content strategy, shadowban, reach drop, creator monetization, Original Content Rewards, revenue sharing, creator payouts.
allowed-tools: Read, Write, Edit, Bash
---

# X Engagement Playbook

Expert at building authority and engagement on X (Twitter) through distribution engineering,
algorithm-aware content design, and conversation tactics — grounded in the `xai-org/x-algorithm`
codebase at snapshot `902a06fd` (2026-09-04), which adds multi-step reply-spam detection, raises
coordinated-spam root coverage to 5k followers, and switches Phoenix retrieval aggregation to
`DENSE_WITH_LONG_DWELL` on top of the 2026-08-28 120k / dwell-0.05 / DPP-only release.

## Overview

- **Two systems, not one** — ranking decides your *order*; visibility filtering decides whether
  you're *eligible* at all. Most reach problems are the second one.
- **Published weights** — the blend weights are public as of 2026-08-13; the skill cites them with
  `file:line` rather than inferring a hierarchy
- **Weights multiply P(action), not counts** — upstream (2026-08-14) explicitly rejects
  "1 report cancels N likes." Report is rare (>1000× less base rate than like), so its weight is
  large so the *prediction* can move the score. Mass-report brigades are personalized and mostly
  affect similar users; only Home-Timeline-served actions count
- **Account standing gates everything** — spam/slop labels drop *every* post from out-of-network
  for 30 days while followers see you normally. A new `panda_reports_embedding_v10_rough_spam`
  rule can non-permanently suspend for PlatformManipulation. A `very_high_follower_count` skip
  now sits above `high_follower_count` in the user-enforcement chain (threshold is still mocked)
- **Mutuals compound** — a mutually-followed author gets +15.0 on reply weight for root posts;
  follow-graph bool features are wired into Phoenix candidate/history tensors
- **Conversation leverage** — replies are Grok-scored 0–3; spam/reply-ranking eligibility still
  covers threads where target+root are ≤**120k** followers. **New:** stacked self-replies under
  someone else's post are classified as multi-step reply spam (`PlanMultiStepReplySpam`) and can
  be written down to ranking score 0.0 plus a spam label. Coordinated-spam coverage now starts
  at roots with ≥**5,000** followers (was 1,000)
- **Dwell is small, not zero** — `DwellWeight` is **0.05**; Phoenix scoring *and retrieval*
  aggregation are both `DENSE_WITH_LONG_DWELL`. Still far below reply/quote (5.0). `vqv` is **0.0**
- **VMRanker is DPP-only** — ranking_scorer no longer computes SID fields into the reranker
  request. SlateContext still carries SID + Phoenix `recon_*` reconstruction-similarity **and**
  new `exact_k` / `exact_gap` exact-duplicate recurrence from the proto
- **Following blocks quotes/RTs** — Following timeline hydrates blocked-by on quoted and
  retweeted authors and drops those candidates
- **Monetization alignment** — Original Content Rewards pays on verified impressions on *original*
  posts in the Home Timeline
- **Freshness hardens after 14d** — stale posts zero engagement-count features in Phoenix when the
  flag is on; old viral posts lose raw-count advantage
- **Cold start is Home-Timeline impressions** — `view_count_on_home` replaces raw `view_count`;
  Thompson-sampling TopK (still off by default) is 2, not 5. The treatment arm now only boosts
  Phoenix MoE candidates

## Core Principles

### 1. Don't Get Dropped Before You Get Ranked
Visibility filtering runs a set of rules that fire **only for out-of-network recommendations** —
spam-high-recall, do-not-amplify, abusive, NSFW, compromised. Many are **account-level**. If OON
reach dies while follower engagement holds, that's the cause, not your hooks. Jurisdiction filters
(e.g. `Brazil2026ElectionFilter`, list **2,554** accounts as of 2026-09-04) can also remove listed
authors from For You unless the viewer follows them.

### 2. Negative Signals Matter — But Read the Math
`report` −234.0, `mute_author` −58.8, `not_interested` −43.2 versus a top positive of 20.0. Those
numbers weight **predicted probabilities for this viewer**, not raw engagement tallies. Do **not**
say "one report cancels ~47 replies." Still: content that invites mute/block/report is expensive,
and `agatha/` scores blocks/reports *relative to favorites* as a durable account label.

### 3. Hook → Hold → Earn a Real Action
`dwell` is weighted **0.05** (same tier as photo expand) and `cont_dwell_time` **0.004**;
`not_dwelled` is **−0.02**. Attention is still the precondition, not the payoff. Hold the reader
to earn a reply, quote, DM share or follow — those are what score. Retrieval now aggregating
`DENSE_WITH_LONG_DWELL` does not make dwell the goal; it just means the candidate index prefers
the same long-dwell signal scoring already used.

### 4. Follows Compound, Even Though They Aren't Top-Weighted
`follow_author` is 4.0 — below reply, quote and DM share. But it's the only action that changes
every *future* impression, moves you in-network past the 0.75 OON discount, and feeds the PageRank
credibility that buys enforcement leniency. Design for it for those reasons.

### 5. Post First, Drive Traffic Second
Always post your own content to your profile first, then reply into relevant threads to pull
traffic back. Never let your best content die inside someone else's thread — reply impressions
don't monetize either.

### 6. Reply Quality Over Volume — This Is The Riskiest Lever
Replies are Grok-scored 0–3, and the scorer now sees follower counts. Below ~1,000 followers spam
scrutiny is elevated, and `fast_reply_spam_post` carries a 30-day `SpamHighRecall` label.
`bdsm/` reads posting *cadence* directly. Reply-spam / reply-ranking tasks still cover threads up
to ≤120k followers on target and root. **Do not chain your own replies under someone else's
post** — `PlanMultiStepReplySpam` flags consecutive self-replies (depth ≥ 2, parent is you, root
is not you, root ≥ 1,000 followers) and can zero the ranking score. Coordinated-spam detection
now runs on deep threads whose root has ≥ 5,000 followers. Five excellent replies beat fifty
mediocre ones, and one excellent reply beats a self-reply stack.

### 7. Volume and Repetition Both Decay
Author diversity: your 2nd post in a feed load keeps 62.5%, your 3rd 43.75%. VMRanker separately
demotes posts similar to their neighbours via a determinantal point process (DPP). Phoenix
reconstruction-similarity (`recon_*`) and exact-duplicate recurrence (`exact_k`, `exact_gap`)
are now explicit slate-context features. Post less, and don't rephrase yourself, ship the same
take twice, or flood one topic cluster.

### 8. Originality Is Attributed, Paid, and Enforced
Original Content Rewards pays on qualified impressions: **Premium viewers**, **Home Timeline**,
**original posts**. Separately, `llm_slop_user` and `llm_slop_post` are real enforcement labels
with 30-day TTLs. Generic AI-shaped output is a named, penalized category.

### 9. Ship While Fresh
Phoenix can mark posts older than ~14 days as stale and zero their engagement-count features
(`IS_STALE_POST14D`). Design for timely distribution; do not rely on ancient high-count posts to
keep ranking on raw fav/view features alone. Cold-start explore uses **Home Timeline** impression
counts (`view_count_on_home`), not global views.

### 10. Account-level NSFW bleeds into ranking features
Phoenix receives an author-NSFW safety bit (`SAFETY_BIT_AUTHOR_NSFW` via `nsfw_author_phoenix`).
Adult-marked accounts are not only a visibility problem — they are a model-input problem on every
non-retweet candidate.

## Documentation

- **[Scoring Weights](docs/scoring-weights.md)** - The published blend weights with `file:line`
  citations, correct P(action) semantics, bidirectional-follow boost, OON factors, author
  diversity, dwell 0.05 / vqv 0.0, retrieval now `DENSE_WITH_LONG_DWELL`, params off by default
- **[Algorithm Signals](docs/algorithm-signals.md)** - Which signals exist, candidate sources,
  network alignment, facepile, stale-post / cold-start notes, how to prioritize
- **[Visibility Filtering](docs/visibility-filtering.md)** - ALLOW/INTERSTITIAL/DROP, the
  out-of-network-only drop rules, Brazil 2026 election filter, muted-keyword Following expansion,
  Following blocked-by quote/RT drop
- **[Account Standing](docs/account-standing.md)** - agatha, user-cred-v2 PageRank, bdsm behaviour
  model, the enforcement label chain and its 30-day TTLs
- **[Content Quality Screening](docs/content-quality.md)** - Banger Screen outputs, reply spam
  buckets, 0–3 reply rubric, multi-step / coordinated reply spam, the ten safety categories
- **[Content Strategy](docs/content-strategy.md)** - Hooks, clusters, attention, diversity decay,
  freshness
- **[Conversation Tactics](docs/conversation-tactics.md)** - Reply scoring, spam risk (≤120k),
  multi-step self-reply spam, thread hijacking, social proof
- **[Authority Building](docs/authority-building.md)** - Follow triggers, share signals,
  network alignment, positioning
- **[Monetization](docs/monetization.md)** - Original Content Rewards: eligibility, qualified
  impressions, originality rules, payout mechanics *(sourced from X help pages, not the codebase)*
- **[Content Ideas](docs/content-ideas.md)** - High-performing templates
- **[x-algorithm README (upstream)](docs/x-algorithm-readme.md)** - Cached upstream README
- **[upstream/](docs/upstream/)** - Verbatim cached source files the analysis above is derived from

## Quick Workflow

1. **Check standing first** if reach has dropped — Under the Hood shows the labels actually on
   your account; don't theorize about hooks until that's clean
2. **Draft content** with a strong hook (controversial truth or myth-busting)
3. **Ask: could this make someone mute, block or report?** Negatives still dominate risk, even
   after correcting the weight-ratio myth
4. **Ask: does this earn a reply, quote, DM share, or follow?** Those are what score
5. **Check it reads as human** — not templated, not your last post rephrased, not the same
   cluster as the post you just shipped
6. **Post to your profile** first
7. **Wait 10–30 minutes**, then find active threads (20–200 likes, your topic)
8. **Reply with quality, at human pace, once** — extend the idea, don't self-promote, don't
   stack self-replies under someone else's tweet; quality still matters on mid-tier threads
   up through ~120k

## Content Formula

```
clean account standing (no OON drop labels)
+ topically legible (VLM can categorize it)
+ nothing that invites mute / block / report
+ a reason to reply, quote, or DM it to one specific person
+ a reason to follow (unique insight + consistent content identity)
+ original and human-sounding (not slop-labelled)
+ timely enough that engagement features still count
+ not a near-duplicate of your last post or the same cluster
= algorithmic reach → qualified impressions → payout
```

## Anti-Patterns

- High-volume or fast-cadence replies (`fast_reply_spam_post`, 30-day `SpamHighRecall`)
- Stacking self-replies under someone else's post (`PlanMultiStepReplySpam` → ranking 0.0 + spam)
- Coordinated or deep-thread reply chains on roots with ≥5k followers
- Generic / templated / AI-shaped content (`llm_slop_user`, `llm_slop_post`)
- Rephrasing your own last post (VMRanker DPP demotion, `SpamEmbeddingMajorityPoster`)
- Shipping the same take twice (`exact_k` / `exact_gap` on slate context)
- Flooding one topic cluster in a short window (Phoenix `recon_*` similarity on slate context)
- Burst posting on a mechanical schedule (`bdsm/` reads inter-action timing)
- Deliberate antagonism (agatha scores blocks/reports relative to favorites)
- Posting too frequently (author diversity decay attenuates each successive post)
- Dropping naked links (`MALICIOUS_URL_DROP` keys on the link, and it can fire retroactively)
- Risky avatar / banner imagery (`NSFW_AVATAR_IMAGE_USER_DROP` costs you *all* OON reach)
- Adult-labelled account state leaking into Phoenix via `nsfw_author_phoenix`
- Posting before building your own content
- Leading with theory instead of concrete examples
- Building a reply-heavy strategy for income (reply impressions don't monetize)
- Aggregating others' content with thin additions (devalued under Original Content Rewards)
- Treating `dwell` 0.05 as the payoff (reply/quote still 5.0)
- Chasing `vqv` or `profile_click` (both weighted 0.0)
- Treating weight ratios as raw count equivalences ("1 report = N likes") — wrong since 2026-08-14
- Relying on weeks-old posts to keep ranking on accumulated fav/view counts alone
- Treating mid-size creator threads (80k–120k) as "safe from reply ranking" — they are not
- Spray-and-pray replies now that every reply can be scored immediately and a worse score sticks

## Currency

Analytical docs are hand-derived from the source files cached in `docs/upstream/`, at snapshot
`902a06fd` (2026-09-04). CI copies those files but **cannot** regenerate the prose. If a cached
file's diff shows a changed or removed constant, the analysis needs re-deriving by hand — see
`sync.json` → `snapshot_commit`.
