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

Every reply in the system is quality-scored by Grok VLM on a **0–3 scale** with reasoning. Higher-scored replies get more thread visibility. The scoring uses contextual signals including the parent post and engagement data.

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

The algorithm specifically targets replies from lower-follower accounts with a **SpamEapiLowFollowerClassifier**. It runs Grok VLM on your replies if you're under 1,000 followers:

| Followers | Spam Scrutiny |
|-----------|--------------|
| ≤ 100 | Highest |
| ≤ 500 | High |
| ≤ 1,000 | Elevated |
| > 1,000 | Standard |

**If you're under 1,000 followers: quality > volume on replies.** Five excellent replies outperform fifty mediocre ones and avoid triggering spam detection.

## Social Proof via Following Network

The algorithm shows a "facepile" (profile pictures) of people the viewer follows who replied to a post — but only for viewers who themselves have ≥1,000 followers. This creates a social proof loop:

```
Your post gets quality replies from engaged followers
→ Those followers have audiences of their own
→ When their followers see your post, they see familiar faces
→ Higher click-through and engagement
```

**Seed your posts with replies from genuinely engaged community members.** Ask questions that invite responses from people with their own following.
