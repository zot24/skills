---
name: x-engagement
description: Crafts high-engagement X (Twitter) content using the published X recommendation algorithm weights, visibility filtering rules, account standing signals, conversation tactics, and the Original Content Rewards monetization rules. Use when writing tweets, planning X content strategy, building audience, optimizing engagement, diagnosing lost reach, or checking creator payout eligibility. Triggers on mentions of X, Twitter, tweets, threads, engagement, audience growth, content strategy, shadowban, reach drop, creator monetization, Original Content Rewards, revenue sharing, creator payouts.
allowed-tools: Read, Write, Edit, Bash
---

# X Engagement Playbook

Expert at building authority and engagement on X (Twitter) through distribution engineering,
algorithm-aware content design, and conversation tactics — grounded in the `xai-org/x-algorithm`
codebase at snapshot `a389166` (2026-08-13), the release that published the scoring weights and
the visibility-filtering rules.

## Overview

- **Two systems, not one** — ranking decides your *order*; visibility filtering decides whether
  you're *eligible* at all. Most reach problems are the second one.
- **Published weights** — the blend weights are public as of 2026-08-13; the skill cites them with
  `file:line` rather than inferring a hierarchy
- **Negative feedback dominates** — `report` is −234.0 against a top positive of 20.0; avoiding
  irritation beats optimizing engagement
- **Account standing gates everything** — spam/slop labels drop *every* post from out-of-network
  for 30 days while followers see you normally
- **Mutuals compound** — a mutually-followed author gets +15.0 on reply weight for root posts
- **Conversation leverage** — replies are Grok-scored 0–3; volume is the riskiest strategy here
- **Monetization alignment** — Original Content Rewards pays on verified impressions on *original*
  posts in the Home Timeline

## Core Principles

### 1. Don't Get Dropped Before You Get Ranked
Visibility filtering runs a set of rules that fire **only for out-of-network recommendations** —
spam-high-recall, do-not-amplify, abusive, NSFW, compromised. Many are **account-level**. If OON
reach dies while follower engagement holds, that's the cause, not your hooks.

### 2. Negative Signals Outweigh Everything Positive
`report` −234.0, `mute_author` −58.8, `not_interested` −43.2 versus a top positive of 20.0. One
report cancels ~47 replies. Provocation that wins arguments and loses this ratio is a bad trade —
and `agatha/` scores blocks/reports *relative to favorites* as a durable account label.

### 3. Hook → Hold → Earn a Real Action
`dwell` is weighted **0.0** and `cont_dwell_time` **0.004**; `not_dwelled` is **−0.02**, the
smallest term in the model. Attention is the precondition, not the payoff. Hold the reader to earn
a reply, quote, DM share or follow — those are what score.

### 4. Follows Compound, Even Though They Aren't Top-Weighted
`follow_author` is 4.0 — below reply, quote and DM share. But it's the only action that changes
every *future* impression, moves you in-network past the 0.75 OON discount, and feeds the PageRank
credibility that buys enforcement leniency. Design for it for those reasons.

### 5. Post First, Drive Traffic Second
Always post your own content to your profile first, then reply into relevant threads to pull
traffic back. Never let your best content die inside someone else's thread — reply impressions
don't monetize either.

### 6. Reply Quality Over Volume — This Is The Riskiest Lever
Replies are Grok-scored 0–3. Below ~1,000 followers spam scrutiny is elevated, and
`fast_reply_spam_post` carries a 30-day `SpamHighRecall` label. `bdsm/` reads posting *cadence*
directly. Five excellent replies beat fifty mediocre ones by a wide margin.

### 7. Volume and Repetition Both Decay
Author diversity: your 2nd post in a feed load keeps 62.5%, your 3rd 43.75%. VMRanker separately
demotes posts similar to their neighbours. Post less, and don't rephrase yourself.

### 8. Originality Is Attributed, Paid, and Enforced
Original Content Rewards pays on qualified impressions: **Premium viewers**, **Home Timeline**,
**original posts**. Separately, `llm_slop_user` and `llm_slop_post` are real enforcement labels
with 30-day TTLs. Generic AI-shaped output is a named, penalized category.

## Documentation

- **[Scoring Weights](docs/scoring-weights.md)** - The published blend weights with `file:line`
  citations, the bidirectional-follow boost, OON factors, author diversity, params off by default
- **[Algorithm Signals](docs/algorithm-signals.md)** - Which signals exist, candidate sources,
  network alignment, facepile, how to prioritize
- **[Visibility Filtering](docs/visibility-filtering.md)** - ALLOW/INTERSTITIAL/DROP, the
  out-of-network-only drop rules, the Under the Hood transparency tool
- **[Account Standing](docs/account-standing.md)** - agatha, user-cred-v2 PageRank, bdsm behaviour
  model, the enforcement label chain and its 30-day TTLs
- **[Content Quality Screening](docs/content-quality.md)** - Banger Screen outputs, reply spam
  buckets, 0–3 reply rubric, the ten safety categories
- **[Content Strategy](docs/content-strategy.md)** - Hooks, clusters, attention, diversity decay
- **[Conversation Tactics](docs/conversation-tactics.md)** - Reply scoring, spam risk, thread
  hijacking, social proof
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
3. **Ask: could this make someone mute, block or report?** The negatives dominate the model
4. **Ask: does this earn a reply, quote, DM share, or follow?** Those are what score
5. **Check it reads as human** — not templated, not your last post rephrased
6. **Post to your profile** first
7. **Wait 10–30 minutes**, then find active threads (20–200 likes, your topic)
8. **Reply with quality, at human pace** — extend the idea, don't self-promote

## Content Formula

```
clean account standing (no OON drop labels)
+ topically legible (VLM can categorize it)
+ nothing that invites mute / block / report
+ a reason to reply, quote, or DM it to one specific person
+ a reason to follow (unique insight + consistent content identity)
+ original and human-sounding (not slop-labelled)
= algorithmic reach → qualified impressions → payout
```

## Anti-Patterns

- High-volume or fast-cadence replies (`fast_reply_spam_post`, 30-day `SpamHighRecall`)
- Generic / templated / AI-shaped content (`llm_slop_user`, `llm_slop_post`)
- Rephrasing your own last post (VMRanker demotion, `SpamEmbeddingMajorityPoster`)
- Burst posting on a mechanical schedule (`bdsm/` reads inter-action timing)
- Deliberate antagonism (agatha scores blocks/reports relative to favorites)
- Posting too frequently (author diversity decay attenuates each successive post)
- Dropping naked links (`MALICIOUS_URL_DROP` keys on the link, and it can fire retroactively)
- Risky avatar / banner imagery (`NSFW_AVATAR_IMAGE_USER_DROP` costs you *all* OON reach)
- Posting before building your own content
- Leading with theory instead of concrete examples
- Building a reply-heavy strategy for income (reply impressions don't monetize)
- Aggregating others' content with thin additions (devalued under Original Content Rewards)
- Chasing `dwell` as an end in itself (weighted 0.0)
- Chasing `profile_click` (weighted 0.0)

## Currency

Analytical docs are hand-derived from the source files cached in `docs/upstream/`, at snapshot
`a389166` (2026-08-13). CI copies those files but **cannot** regenerate the prose. If a cached
file's diff shows a changed or removed constant, the analysis needs re-deriving by hand — see
`sync.json` → `snapshot_commit`.
