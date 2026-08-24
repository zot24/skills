<!-- Source: X Engagement Playbook + xai-org/x-algorithm codebase -->

# Conversation Tactics

## Parasitize Existing Conversations

One of the highest leverage tactics on X. Instead of waiting for organic reach, borrow attention from active threads.

### Find Target Tweets

Look for tweets with:
- 20-200 likes (active but not saturated)
- Active discussion in replies
- Your topic area

### Flow

```
existing conversation
↓
you add practical insight
↓
their audience discovers you
```

You borrow attention instead of waiting for it.

## Reply to Comments, Not Only the Main Tweet

This is an underrated tactic with higher ROI.

### Why Comments > Main Tweet

| Target | Visibility | Competition |
|--------|-----------|-------------|
| Main tweet | Medium | Huge |
| Good comments | Higher | Lower |

### Find Good Comments To Reply To

Look for comments that:
- Summarize the discussion
- Introduce a key idea
- Appear early in the thread

Then **extend their idea** with your own insight.

## Use Timing Strategically

Timing matters when interacting with threads.

### Recommended Flow

```
tweet your content
↓
wait 10-30 minutes
↓
reply in relevant thread
↓
traffic flows into your tweet
```

This avoids looking like spam and lets the algorithm test your tweet first before you start driving traffic to it.

## Never Start With a Reply

Your best content should live on your profile first, not buried inside someone else's thread.

### Bad Flow
```
reply → content dies inside someone else's thread
```

### Good Flow
```
post → wait → reply to relevant threads → pull traffic to your tweet
```

Always post your content first. Then use other conversations to bring readers back to it.

## Reply Quality Is Scored by Grok

Replies are quality-scored by Grok on a **0–3 rubric**, enforced in code
(`grox/flows/reply_spam/classifier_reply_ranking.py:163-169` raises on any score outside it).
Higher-scored replies get more thread visibility. The scoring uses contextual signals including
the parent post and engagement data.

**This means reply quality is not just social — it's algorithmic.** Weak replies get buried. Strong replies get surfaced.

### What makes a high-scoring reply

- Directly extends the idea in the parent post with new information
- Demonstrates genuine expertise or lived experience
- Adds nuance, counterpoint, or a concrete example
- Is longer than one sentence — shows real engagement

### What gets a low reply score (and risks spam flags)

- Generic validation ("Great take!")
- Self-promotion without topical contribution
- Repeating what the parent post said
- Links without context

## Spam Risk for Small Accounts

`grox/flows/reply_spam/task_spam_detection.py:18-27` buckets replies by follower count for spam
scrutiny:

| Bucket | Condition |
|---|---|
| Highest | reply-target **and** root author both ≤ 100 followers |
| High | both ≤ 500 |
| Elevated | both ≤ 1,000 |
| Standard | above that |

Read the condition carefully: it keys on the **replied-to user's and the root author's** follower
counts, not only yours. Small accounts talking in small threads draw the most scrutiny.

**Under 1,000 followers: quality > volume on replies.** Five excellent replies outperform fifty
mediocre ones and avoid spam detection.

### Mid-tier threshold raised to 80k (2026-08-21)

`grox/flows/reply_spam/task_filter.py`:

| Filter | When eligible | Threshold history |
|---|---|---|
| `TaskSpamFilter` | spam detection task runs unless *both* reply-target and root are **above** the threshold | 15k → 30k (2026-08-14) → **80,000** |
| `TaskReplyRankingFilter` | reply quality ranking runs when *both* reply-target and root are **≤** threshold | 15k → 30k (2026-08-14) → **80,000** |

Constants: `FOLLOWER_COUNT_THRESHOLD_FOR_SPAM_DETECTION = 80000` (`task_filter.py:17`) and
`FOLLOWER_COUNT_THRESHOLD_FOR_REPLY_RANKING = 80000` (`task_filter.py:185`).

Effect: the 30k–80k creator band is no longer a free pass. Most active mid-tier threads now go
through reply-spam detection and/or Grok reply ranking. Reply quality is a mid-tier problem, not
only a small-account problem.

Also renamed/retargeted in this snapshot: the stream generator is now
`ReplyRankingTaskGenerator` on topic `content-understanding-realtime-unified-posts-v3`
(`grox/flows/reply_spam/constants.py`, `generators.py`) — infrastructure rename, same playbook.

### The reply-volume trap

This is the highest-risk strategy in the playbook, because three systems converge on it:

- `fast_reply_spam_post` → `SpamHighRecall` post label, **30-day TTL**
  (`enforcement_post.yaml:53-58`)
- `llm_slop_post` → `RiskyHighVizReply` label, 30-day TTL (`enforcement_post.yaml:39-44`)
- `bdsm/` reads inter-action **timing** directly — burstiness and mechanical cadence
- `classifier_coordinated_spam.py` checks for coordination across accounts

A `SpamHighRecall` label on your account triggers `SPAM_HIGH_RECALL_USER_DROP`, which removes
**every** post you make from out-of-network recommendations for the label's duration — while your
followers keep seeing you normally, so the metrics look survivable.

→ **[Account Standing](account-standing.md)** · **[Visibility Filtering](visibility-filtering.md)**

## Social Proof via Following Network

The algorithm can show a "facepile" (profile pictures) of people the viewer follows who replied to
a post — but only for viewers who themselves have **≥ 1,000 followers**
(`home-mixer/candidate_hydrators/following_replied_users_hydrator.rs:13`).

Caveat: `EnableFollowingRepliedUsersFacepile` defaults to `false` (`param.rs:559-564`), so treat
this as a real mechanism with an unconfirmed rollout. The tactic below is worth doing regardless —
quality replies from engaged followers are valuable on their own — just don't count on the
facepile itself.

The loop when it is on:

```
Your post gets quality replies from engaged followers
→ Those followers have audiences of their own
→ When their followers see your post, they see familiar faces
→ Higher click-through and engagement
```

**Seed your posts with replies from genuinely engaged community members.** Ask questions that invite responses from people with their own following.
