# X Engagement Skill

Expert at crafting high-engagement [X (Twitter)](https://x.com) content — grounded in the actual X recommendation algorithm ([xai-org/x-algorithm](https://github.com/xai-org/x-algorithm)).

## What This Skill Covers

- **Algorithm signals** — Exact scoring model: follow_author, dwell, share_via_dm, not_dwelled (negative), and more
- **Quality gate** — Banger Initial Screen: Grok VLM scores all posts; quality_score ≥ 0.4 required for OON distribution
- **Hooks + dwell** — First line stops the scroll; substance after the hook earns the dwell (and avoids the not_dwelled penalty)
- **Follow triggers** — Designing content that earns follows (the highest-weight action in the model)
- **Reply strategy** — Grok scores all replies 0–3; spam detection targets accounts under 1,000 followers
- **Threads + clusters** — Interconnected posts that drive cross-traffic
- **Authority building** — Network alignment (Jaccard), DM-share signals, facepile social proof

## Usage

```bash
/x-engagement:x-engagement hook "AI agents"
/x-engagement:x-engagement thread "Why most AI projects fail"
/x-engagement:x-engagement review "my draft tweet text here"
/x-engagement:x-engagement reply "context from parent thread"
/x-engagement:x-engagement signals
```

Or use natural language:

```
"Write a viral X/Twitter post about AI"
"Help me craft a thread about building in public"
"Review this tweet draft"
"What signals does the X algorithm actually weight?"
```

## Key Algorithm Facts (from xai-org/x-algorithm)

| Signal | Type | Implication |
|--------|------|-------------|
| `follow_author` | Positive | Highest-value per-action; design for follows |
| `share_via_dm` | Positive | Private DM shares tracked separately; reference-quality content earns them |
| `dwell` / `cont_dwell_time` | Positive | Time-on-post is rewarded |
| `not_dwelled` | **Negative** | Fast scroll-past actively hurts future distribution |
| `report` / `block` | **Negative** | Strong account-level suppression |
| Banger Screen | Gate | quality_score ≥ 0.4 required for For You feed |
| Author diversity | Decay | Successive posts from same author get attenuated scores |
| OON weight | Penalty | Non-follower distribution requires higher raw score |
