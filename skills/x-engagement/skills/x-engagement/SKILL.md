---
name: x-engagement
description: Crafts high-engagement X (Twitter) content using the actual X recommendation algorithm signals, conversation hijacking, authority building, and strategic hooks. Use when writing tweets, planning X content strategy, building audience, or optimizing engagement. Triggers on mentions of X, Twitter, tweets, threads, engagement, audience growth, content strategy.
allowed-tools: Read, Write, Edit, Bash
---

# X Engagement Playbook

Expert at building authority and engagement on X (Twitter) through distribution engineering, algorithm-aware content design, and conversation tactics — grounded in the actual `xai-org/x-algorithm` codebase.

## Overview

- **Algorithm-first thinking** — the Phoenix transformer predicts P(follow), P(dwell), P(share_dm), P(reply), P(not_dwelled) — optimize for these, not just likes
- **Quality gate awareness** — content must pass the Banger Initial Screen (quality_score ≥ 0.4) to reach non-followers at all
- **Hook-first writing** — first line decides the stop; substance decides the dwell
- **Follow triggers** — the highest-value per-action signal in the scoring model
- **DM shares** — separately tracked and weighted; reference-quality content earns them
- **Conversation leverage** — replies are quality-scored by Grok VLM; quality > volume
- **Network alignment** — MinHash Jaccard measures your follower overlap with viewer graphs

## Core Principles

### 1. Hook → Hold → Trigger Follow
The scoring model weights `follow_author` above all per-action signals. Every post should make a viewer think "I want to see more from this person." Bad: tips thread. Good: counterintuitive insight with specific proof from lived experience.

### 2. Dwell Is a Signal, Not_Dwelled Is a Penalty
`dwell` and `cont_dwell_time` are explicit positive signals. `not_dwelled` (fast scroll-past) is an explicit **negative** signal that suppresses future distribution. A hook without substance earns stops then scrolls — net negative.

### 3. Post First, Drive Traffic Second
Always post your own content to your profile first. Then reply in relevant threads to pull traffic back. Never let your best content die inside someone else's thread.

### 4. Reply Quality Over Volume
Replies are Grok-scored on a 0–3 scale. Low-follower accounts (< 1,000) face elevated spam scrutiny. Five excellent replies outperform fifty mediocre ones — and don't risk spam classification.

## Documentation

- **[Algorithm Signals](docs/algorithm-signals.md)** - Exact scoring signals from the x-algorithm codebase: weights, dwell, follow, OON penalties, author diversity
- **[Content Quality Gate](docs/content-quality.md)** - Banger Screen (quality_score ≥ 0.4), slop score, spam detection thresholds, reply scoring
- **[Content Strategy](docs/content-strategy.md)** - Hooks, clusters, dwell optimization, author diversity penalty, quality gate
- **[Conversation Tactics](docs/conversation-tactics.md)** - Reply quality scoring, spam risk, social proof facepile, thread hijacking
- **[Authority Building](docs/authority-building.md)** - Follow triggers, DM-share signals, network alignment (Jaccard), positioning
- **[Content Ideas](docs/content-ideas.md)** - High-performing templates ranked by algorithm signal priority
- **[x-algorithm README (upstream)](docs/x-algorithm-readme.md)** - Cached README from xai-org/x-algorithm, the codebase the playbook is grounded in

## Quick Workflow

1. **Draft content** with a strong hook (controversial truth or myth-busting)
2. **Check quality** — does it pass the Banger Screen? Original insight, specific, topically clear?
3. **Optimize for dwell** — does it reward reading all the way through?
4. **Ask: does this earn a follow?** — the highest-value action
5. **Post to your profile** first
6. **Wait 10–30 minutes**, then find active threads (20–200 likes, your topic)
7. **Reply with quality** — extend the idea, don't self-promote
8. **Seed replies** from engaged followers to trigger the social proof facepile

## Updated Content Formula

```
quality_score ≥ 0.4 (passes banger screen)
+ follow trigger (unique insight + content identity)
+ dwell design (substance that holds attention)
+ DM-shareable framing (reference-quality, specific)
+ conversation leverage (strategic replies with Grok-quality content)
= algorithmic reach
```

## Anti-Patterns

- Dropping naked links (looks spammy, no dwell)
- Posting before building your own content
- Generic / templated content (fails quality screen, high slop score)
- High-volume low-quality replies (spam-flagged under 1,000 followers)
- Posting too frequently in bursts (author diversity decay attenuates each successive post)
- Leading with theory instead of concrete examples
- Posts that generate likes but no dwell (not_dwelled is an explicit negative signal)
- Content that triggers safety categories (ViolentMedia, HateOrAbuse, etc.) — suppressed regardless of engagement
