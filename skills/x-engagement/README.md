# X Engagement Skill

Expert at crafting high-engagement [X (Twitter)](https://x.com) content — grounded in the actual X recommendation algorithm ([xai-org/x-algorithm](https://github.com/xai-org/x-algorithm)).

## What This Skill Covers

- **Published scoring weights** — the real blend weights xAI released on 2026-08-13, cited with `file:line`
- **Visibility filtering** — the ALLOW/INTERSTITIAL/DROP rules, including the ones that fire *only* for out-of-network recommendations
- **Account standing** — agatha, user-cred-v2 PageRank, the bdsm behaviour model, and the enforcement labels with 30-day TTLs
- **Quality screening** — Banger Initial Screen outputs, taxonomy classification, slop scoring
- **Hooks + attention** — First line stops the scroll; substance converts it into an action that actually scores
- **Follow triggers** — Why follows compound across scoring, retrieval and enforcement, even at a weight of 4.0
- **Reply strategy** — Grok scores replies 0–3; elevated spam scrutiny under 1,000 followers, and why volume is the riskiest lever
- **Threads + clusters** — Interconnected posts that drive cross-traffic
- **Authority building** — Mutual-follow boost, share signals, network alignment, positioning
- **Monetization** — Original Content Rewards: eligibility, qualified impressions (Premium viewers × Home Timeline × original posts), what counts as original, payout rules

## Usage

```bash
/x-engagement:x-engagement hook "AI agents"
/x-engagement:x-engagement thread "Why most AI projects fail"
/x-engagement:x-engagement review "my draft tweet text here"
/x-engagement:x-engagement reply "context from parent thread"
/x-engagement:x-engagement signals
/x-engagement:x-engagement monetization
```

Or use natural language:

```
"Write a viral X/Twitter post about AI"
"Help me craft a thread about building in public"
"Review this tweet draft"
"What signals does the X algorithm actually weight?"
```

## Key Algorithm Facts (from xai-org/x-algorithm @ `28e414f`, 2026-08-21)

- **Weights multiply P(action), not raw counts** (clarified 2026-08-14) — do not say "1 report cancels N likes"
- **Brazil2026ElectionFilter** — listed electoral-court accounts dropped from For You unless the viewer follows them
- **Reply spam/ranking mid-tier threshold** 15k → 30k → **80k** followers on target+root
- **Semantic-ID slate context** — 3-level SID recurrence/gaps feed VMRanker (author decay still uses author `k`)
- **Following muted keywords** match quote + ancestor text, not only the post body
- **Author NSFW bit** (`nsfw_author_phoenix`) enters Phoenix features on non-retweets
- **Stale ~14d** posts can have engagement-count features zeroed in Phoenix

Published blend weights, from `home-mixer/params/param.rs`:

| Signal | Weight | Implication |
|--------|-------:|-------------|
| `report` | **−234.0** | Large weight on rare P(report) — not "1 report = N likes". Still avoid inviting reports. |
| `mute_author` / `not_interested` / `block_author` | −58.8 / −43.2 / −31.2 | Irritating people is far costlier than boring them |
| `share_via_copy_link` | 20.0 | Highest positive — but high *because* the action is rare |
| `reply` from a mutual follow | 5.0 **+15.0** | Largest live positive term; root posts only |
| `reply` / `quote` / `share_via_dm` | 5.0 | Quote is worth 5× a bare repost |
| `follow_author` | 4.0 | Not the top weight — but the only action that compounds |
| `retweet` / `favorite` | 1.0 / 0.5 | Likes are near-table-stakes |
| `cont_dwell_time` | 0.004 | Attention is a precondition, not the payoff |
| `dwell` / `profile_click` | **0.0** | Predicted, but contribute nothing |
| `not_dwelled` | −0.02 | Smallest term in the model — a weak hook costs little directly |
| Author diversity | ×0.625 / ×0.438 | Your 2nd and 3rd post in one feed load |
| OON weight | ×0.75 | Reaching non-followers costs 25% of your score |

Weights blend action value with base rate (`param.rs:279-281`) — a large weight often just means
a rare action. Score contribution is `weight × P(action)`. Don't read the table as a to-do list.

Beyond ranking, **visibility filtering** decides eligibility: a set of rules drops posts *only*
for out-of-network recommendations, many keyed on account-level labels with 30-day TTLs. That is
usually what a reach collapse actually is.

## Monetization (Original Content Rewards)

Creator Revenue Sharing has been replaced by **Original Content Rewards**. Earnings come from
*qualified impressions*: **Premium viewers × Home Timeline × original posts**. Replies don't
monetize, aggregator payouts have been cut, and habitual bait packaging risks permanent
deductions.

See [`docs/monetization.md`](skills/x-engagement/docs/monetization.md) for eligibility
thresholds, originality rules, payout cadence, and the Revenue Sharing migration timeline.
Numbers are set by X and change — verify at
<https://help.x.com/en/using-x/original-content-rewards>.
