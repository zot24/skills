<!-- Source: https://github.com/xai-org/x-algorithm (direct codebase analysis) -->

# X Algorithm Signals Reference

Sourced directly from the `xai-org/x-algorithm` repository. Describes the exact signals the Phoenix ranking model uses to score content.

## How Scoring Works

The Phoenix transformer (Grok-based) predicts probabilities for multiple user actions. These probabilities are multiplied by configurable weights and summed:

```
Final Score = Σ (weight_i × P(action_i))
```

Positive action weights are added. Negative action weights are subtracted. The final score determines whether content surfaces in For You.

## Positive Signals (Boost Score)

| Signal | What Triggers It | Strategic Implication |
|--------|-----------------|----------------------|
| `follow_author` | Viewer follows you after seeing the post | **Highest-value action** — content that makes people follow you is rewarded disproportionately |
| `reply` | Viewer replies to your post | Second-tier signal; replies also generate further engagement |
| `repost` | Viewer reposts | Strong distributional signal |
| `quote` | Viewer quotes your post | Strong — brings your content to a new audience |
| `share_via_dm` | Viewer sends post to someone via DM | Private shares are tracked and weighted — high-trust sharing signal |
| `share_via_copy_link` | Viewer copies the link | Also tracked separately |
| `share` | General share action | Broad share signal |
| `dwell` / `cont_dwell_time` | Viewer stops and reads the post (time-weighted) | Reading time is an explicit positive signal — content must hold attention |
| `favorite` | Like | Standard engagement |
| `click` / `profile_click` | Viewer clicks tweet or taps your profile | Intent signal |
| `photo_expand` | Viewer expands an image | Media engagement |
| `vqv` / `quoted_vqv` | Video quality view (watched substantial portion) | Rewards high-quality video content |

## Negative Signals (Suppress Score)

| Signal | What Triggers It | Strategic Implication |
|--------|-----------------|----------------------|
| `not_dwelled` | Viewer scrolled past quickly without reading | **Explicit negative signal** — fast scroll-bys actively hurt ranking |
| `not_interested` | "Show me less of this" click | Strong suppression signal |
| `mute_author` | Viewer mutes you | Persistent account-level penalty |
| `block_author` | Viewer blocks you | Strongest account-level negative |
| `report` | Viewer reports the post | Very strong — triggers safety review pipeline |

## Author Diversity Penalty

After weighted scoring, the algorithm applies a **decay multiplier** to posts from the same author appearing multiple times in a single feed response:

```rust
multiplier = (1.0 - floor) * decay_factor^position + floor
```

Position 0 = full score, position 1 = attenuated, position 2 = further attenuated. The `floor` prevents complete suppression, but the decay is real. **Posting volume doesn't compound — each additional post from the same author competes against your own best post.**

## Out-of-Network Weight

Out-of-network (OON) content — posts served to non-followers via the For You feed — has a `OonWeightFactor` multiplier applied after scoring. Topic-based OON content uses `TopicOonWeightFactor`. New users with sufficient following get `NewUserOonWeightFactor`.

Implication: OON distribution requires a higher raw engagement score to overcome the OON weight penalty.

## Network Alignment (Mutual Follow Jaccard)

The algorithm computes a **MinHash Jaccard similarity** between your follower network and the viewer's following network:

```
jaccard = (matching minhash positions) / (total positions)
```

Higher overlap = your audience and the viewer's interest graph are aligned. This is used as a feature in the Phoenix transformer — **posting in communities where your followers and the target audience overlap amplifies OON reach.**

## Facepile Social Proof

If people the viewer **follows** have replied to your post, a "facepile" of their profile pictures is shown on the post. This is only enabled for viewers with ≥1,000 followers. Replies from people within the viewer's network function as **social proof that boosts click-through**, not just an engagement metric.

Implication: Seed replies from engaged followers who themselves have meaningful follower counts.

## Action Hierarchy for Content Strategy

Based on weight structure, optimize content in this order:

1. **Trigger a follow** — highest per-action value, rare and permanent
2. **Trigger a DM share** — high-trust, tracked separately
3. **Trigger a repost/quote** — strong distributional signal
4. **Trigger a reply** — strong engagement, enables further reach
5. **Maximize dwell time** — don't just hook, hold
6. **Get a like** — table stakes
7. **Avoid not_dwelled** — hooks without substance actively hurt you
