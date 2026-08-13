<!-- Source: X Engagement Playbook -->

# High-Performing Content Templates

## Template 1: Myth Busting

> The biggest mistake [group] make when [action]:
>
> They [common mistake] but never [overlooked step].

### Example
> The biggest mistake Spaniards make when moving abroad:
>
> They get residency elsewhere but never notify Hacienda properly.

## Template 2: Hidden Complexity

> [Common belief] is only the [Nth] test in most [frameworks].
>
> [Other factors] come first.

### Example
> The 183-day rule is only the third test in most tax treaties.
>
> Permanent home and center of vital interests come first.

## Template 3: Checklist Tease

> If you're [doing X], there are [N] things you should probably do.
>
> Most people only do one.

### Example
> If you're leaving Spain, there are 5 things you should probably do.
>
> Most people only do one.

## Template 4: Counterintuitive Truth

> You can [do X] but still [unexpected consequence].
>
> It happens more often than people think.

### Example
> You can leave Spain physically but still be tax resident.
>
> It happens more often than people think.

## General Framework

Each high-performing post combines:

1. **A controversial or counterintuitive truth** - challenges common belief
2. **Practical knowledge** - specific, actionable information
3. **Real-life examples** - things you actually did or witnessed
4. **A clear takeaway** - what the reader should do differently

## Topics That Trigger Engagement

Look for topics that:
- Challenge widely-held assumptions
- Activate multiple communities simultaneously
- Have a "most people get this wrong" angle
- Can be supported with concrete examples

## Template 5: Follow Trigger

> I [specific action] and it [result that surprises].
>
> [Most people do X] because they think [assumption].
>
> The actual reason it works is [non-obvious insight].

This pattern shows demonstrated experience and hints at more insight to come — making viewers follow to see what else you know.

## Template 6: DM-Share Bait

> If you're [in specific situation], save this.
>
> [Problem most people in that situation have]
>
> The fix is [specific step], not [common mistake].
>
> [1-2 lines of practical detail]

Framing as a reference to save or share amplifies `share_via_dm` and `share_via_copy_link` signals.

## Template 7: Dwell Anchor

Build posts that reward reading all the way through:

> [Hook: challenge an assumption]
>
> Background: [1-2 lines of context the reader needs]
>
> The part everyone misses: [the real insight]
>
> Specifically: [concrete example with detail]
>
> What this means if you're [doing X]:
> [actionable implication]

The layered structure holds the reader — each line pulls to the next. That's what converts a stop
into a reply, quote or follow, which is where the score actually comes from.

## Algorithm-Backed Content Priorities

These are ordered by **what you can realistically influence**, not by raw weight — upstream states
weights blend action value with base rate (`param.rs:279-281`), so the weight column is context,
not a ranking. → **[Scoring Weights](scoring-weights.md)**

| Priority | Target | Weight | Content Type |
|---|---|---:|---|
| 1 | *Avoid* mute / block / report | −31 to −234 | Nothing gratuitously antagonistic; the negatives dominate the model |
| 2 | reply | 5.0 | Discussion-inviting questions or genuine challenges |
| 3 | quote | 5.0 | Counterintuitive takes people want to add their own angle to |
| 4 | share_via_dm | 5.0 | Reference-quality, problem-specific content |
| 5 | follow_author | 4.0 | Unique insight + clear content identity — the only action that compounds |
| 6 | repost | 1.0 | Broadly relatable, low-friction to forward |
| 7 | like | 0.5 | Table stakes — the baseline |

Not worth designing for: `dwell` (0.0), `profile_click` (0.0), and avoiding `not_dwelled` (−0.02).
Hold attention because it earns rows 2–5, not for its own weight.
