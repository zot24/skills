<!-- Source: X Engagement Playbook + xai-org/x-algorithm codebase -->

# Content Strategy

## Hook First, Context Later — But Hold Attention After

People scroll fast. Your first line decides everything — but the algorithm also explicitly tracks **dwell time** as a positive signal and **not_dwelled** (fast scroll-past) as a negative signal.

A hook gets the stop. Substance gets the dwell. **Both matter.**

### Hook Structure

```
hook
↓
context
↓
story
↓
lesson
```

### Bad vs Good Openings

**Bad:**
> I updated my Spanish DNI recently because...

**Good:**
> People obsess over the "183-day rule".
> But that's rarely the real issue.

The hook should create curiosity or challenge a common belief.

## Build Content Clusters

Instead of isolated tweets, create **topic clusters** - interconnected posts on the same theme.

### Example Cluster

| Post | Topic |
|------|-------|
| 1 | 183-day rule myth |
| 2 | Spanish DNI address change |
| 3 | Accountants giving bad advice |
| 4 | Modelo 030 explanation |
| 5 | How to break tax ties properly |

When one tweet gets traction, the others get traffic too. Each post reinforces the others.

## Never Drop Naked Links

Links alone look spammy and get suppressed by the algorithm.

### Structure for Link Sharing

```
statement
insight
context
👇
link
```

### Example

> Days alone won't protect you.
>
> You also need to align your documents, address, and legal ties with the country you claim to live in.
>
> Part of what I personally did 👇
> (link)

The link becomes **supporting evidence**, not promotion.

## Controversial Truths Drive Engagement

Topics that challenge common beliefs naturally trigger engagement.

Example: The "183-day rule" myth activates multiple communities:
- Digital nomads
- Tax twitter
- Crypto twitter

Conflict and disagreement drive replies, which drive reach.

## Content Formula

```
controversial truth
+
practical knowledge
+
real-life examples
+
conversation hijacking
= reach
```

All four elements must be present for maximum impact.

## Dwell Optimization

The algorithm tracks two dwell signals:
- `dwell` / `cont_dwell_time`: Viewer reads the post (positive weight)
- `not_dwelled`: Viewer scrolls past quickly (negative weight — actively hurts you)

A post that generates zero likes but holds attention for 5 seconds scores better than a post that gets a quick like-and-scroll. **Design every post to reward reading, not just stopping.**

### Dwell tactics
- Break long thoughts across multiple lines to slow the read
- Use numbered progressions that pull readers forward ("3 of 5 surprises people...")
- End posts with a question or open loop that invites a reply
- Give enough substance that even sophisticated readers learn something

## Author Diversity Penalty

If you have multiple posts competing for a viewer's feed, the algorithm applies a **decay multiplier** to each successive post from the same author. Your best post gets full score — every additional post in that feed load gets progressively attenuated.

**Quality beats quantity.** One excellent post outperforms three average ones that split your author score budget.

## The Quality Gate

Every post is screened by a Grok VLM (**Banger Initial Screen**) before entering out-of-network distribution. Content with `quality_score < 0.4` only reaches existing followers.

The VLM penalizes: generic / templated content, thin text, decontextualized media, and engagement bait without substance.

→ See **[Content Quality Gate](content-quality.md)** for detailed thresholds and tactics.
