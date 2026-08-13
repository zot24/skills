<!-- Source: X Engagement Playbook + xai-org/x-algorithm codebase -->

# Authority Building

## Position Yourself With Practical Signals

The strongest authority tweets are based on **things you actually did**.

### Examples of Practical Signals

- Updating official documents
- Changing legal address
- Embassy registration
- Notifying tax authorities
- Shifting legal ties
- Filing specific forms (Modelo 030, etc.)

Concrete actions create credibility. People trust real actions, real examples, and real administrative steps more than opinions or theory.

## Convert Theory Into Practice

Most threads discuss concepts, but very few show real examples.

### Typical Discussion (Weak)
```
theory → theory → theory
```

### Winning Format (Strong)
```
theory → real example → practical action
```

## Find Your Unfair Advantage

Most accounts in any niche talk about the same high-level topics. The winning strategy is to go deeper into areas others ignore.

### Example: Tax/Nomad Niche

**What everyone talks about:**
- Flags and countries
- Tax rates
- General advice

**What almost nobody talks about:**
- Administrative signals
- Legal ties documentation
- Embassy registration
- Specific forms and procedures
- Breaking tax residency ties step-by-step

This specificity is a **rare and valuable niche** that builds authority fast.

## Core Principle

Authority on X is built through **demonstrated experience**.

The accounts that combine:
- **Expertise** (deep knowledge)
- **Storytelling** (engaging delivery)
- **Conversation leverage** (strategic participation)

...grow the fastest.

## Follows: Valuable, But Not For The Reason You'd Think

`follow_author` carries a weight of **4.0** (`home-mixer/params/param.rs:345-350`) — below `reply`
(5.0), `quote` (5.0) and `share_via_dm` (5.0), and well below `share_via_copy_link` (20.0). It is
**not** the highest-weighted action in the model.

The case for designing around follows is different, and stronger than the weight:

- The weighted score is a **per-impression** quantity. A follow is the only action that changes
  every *future* impression — it moves you into that viewer's in-network pool permanently, where
  you skip the 0.75 out-of-network discount entirely.
- A **mutual** follow is worth more still: root posts from a mutually-followed author get a
  **+15.0** boost on reply weight, taking it from 5.0 to 20.0 — the largest positive term in the
  model (`param.rs:284-289`).
- Follows feed the graph that `user-cred-v2/` runs PageRank over, and credibility ≥ 50 buys a skip
  on post enforcement rules. → **[Account Standing](account-standing.md)**

So: design for follows because they compound across the scoring, retrieval and enforcement layers
at once — not because the per-action weight is highest. It isn't.

**Design some posts explicitly to earn follows, not just likes.**

→ **[Scoring Weights](scoring-weights.md)** for the full table and the propensity caveat.

### What triggers follows

- Content that makes someone think "I want to see more from this person"
- Posts that uniquely answer a question the reader didn't know they had
- Threads that are so useful people screenshot them — they follow so they don't miss more
- A clear content identity: viewers should be able to predict what you'll post

### Follow trigger template

> [Counterintuitive thing you learned through direct experience]
>
> Most people [common approach]. I spent [time/money/effort] learning [specific insight].
>
> Here's the exact [framework/step/decision] I'd do differently:

This pattern works because it signals ongoing value ("there's more where this came from").

## Private Shares as an Authority Signal

The model tracks three share types separately, and they are **not** weighted alike
(`param.rs:318-330`):

| Signal | Weight |
|---|---:|
| `share_via_copy_link` | 20.0 |
| `share_via_dm` | 5.0 |
| `share` (generic) | 2.0 |

Someone sending your post to a specific person, or copying the link to paste elsewhere, is
high-trust — it means your content is reference-quality.

One caveat that matters: copy-link's 20.0 is high **because the action is rare**, not because it
is 4× a DM share in value. Upstream is explicit that weights blend value with base rate
(`param.rs:279-281`). Don't build tactics around farming copy-links.

**Content that becomes "send this to someone who needs it" material is the goal** — the specific
share mechanism isn't something you control.

### How to write DM-shareable content

- Frame insights as "this applies to someone in [specific situation]"
- Write things that are immediately useful to someone dealing with a specific problem
- The "I wish someone had told me this when I was starting" angle

## Network Alignment

The repo contains a **MinHash Jaccard similarity** hydrator measuring overlap between the viewer's
mutual-follow set and the author's
(`home-mixer/candidate_hydrators/mutual_follow_jaccard_hydrator.rs:16`).

**It is gated by `EnableMutualFollowJaccardHydration`, which defaults to `false`**
(`param.rs:759-764`). The code is published; the published default is off. Treat tactics built on
Jaccard overlap as plausible, not established.

Two mechanisms in the same area *are* live and do support the same conclusion:

- **The bidirectional follow boost** (+15.0 on reply weight for root posts from mutually-followed
  authors) makes mutuals concretely more valuable than one-way followers.
- **`simclusters/`** clusters accounts and posts by who engages with what, and is a distinct
  out-of-network retrieval path. Being legibly part of a community cluster is its own route to
  new readers.

Practical implication, which survives either way: **Build an audience in communities where your
target viewers are also active, and follow back.** Follow, engage, and get followed back within
the specific ecosystem you're trying to reach. Scattered, cross-niche followers give you neither
mutual-follow density nor a clean cluster identity.
