<!-- Source: https://github.com/xai-org/x-algorithm (grox/classifiers/content/banger_initial_screen.py, grox/tasks/task_filters.py) -->

# Content Quality Gate

## The Banger Initial Screen

Every post entering the X recommendation pipeline passes through the **BangerInitialScreenClassifier** — a Grok VLM that evaluates content quality before any OON (out-of-network) distribution.

### What Gets Scored

The classifier runs on ALL new posts and produces:

| Output | Description | Threshold |
|--------|-------------|-----------|
| `quality_score` | 0.0–1.0 overall quality score | **≥ 0.4 required to pass** |
| `slop_score` | Measures generic / template-style content | Lower is better |
| `tags` | Content topic tags for taxonomy matching | Used for topic-based discovery |
| `taxonomy_categories` | Classification into X topic taxonomy | Determines which topic feeds you surface in |
| `description` | Summary of the post content | Used for embedding |
| `tweet_bool_metadata` | Structured metadata flags | Safety, media type, etc. |

### Passing the Screen

Posts that score **≥ 0.4** are marked `banger_initial_positive = True`. Only posts that pass this screen get distributed out-of-network via the For You feed.

Posts that fail are only served to your existing followers (in-network via Thunder). They don't enter the Phoenix OON retrieval pipeline.

### What Gets a Low Quality Score

Based on the classifier design:

- **Slop**: Generic, templated, or copied content — e.g., "5 tips for success 🧵" with no original insight
- **Engagement bait without substance**: "Like and RT if you agree" with minimal content
- **Decontextualized media**: Images or videos without meaningful text signal
- **Thin text**: Very short posts with no topical depth
- **Low-originality rephrasing**: Content that mimics patterns without adding insight

### What Gets a High Quality Score

- **Original insight** with specificity — concrete examples, numbers, personal experience
- **Clear topical signal** — the VLM can categorize it into taxonomy
- **Depth + hook combination** — strong opening AND substantive content that holds attention
- **Multimodal richness** — quality images/video with relevant text (the classifier is a VLM — it sees media too)

## Spam Detection for Replies

There is a separate **SpamEapiLowFollowerClassifier** that runs on replies specifically from accounts with lower follower counts. It uses Grok VLM to classify each reply as "spam" or "not spam" using follower buckets:

| Follower Bucket | Scrutiny Level |
|----------------|----------------|
| ≤ 100 followers | Highest scrutiny |
| ≤ 500 followers | High scrutiny |
| ≤ 1,000 followers | Elevated scrutiny |
| > 1,000 followers | Standard checks |

### Implications for Reply Strategy

- If you're under 1,000 followers, **aggressive reply marketing is risky** — Grok reviews your replies for spam patterns
- Replies that look like generic engagement bait, link promotion, or off-topic self-promotion are flagged
- **Genuine, substantive replies that add to the conversation** pass the spam check
- Build your follower count past 1,000 before using high-volume reply strategies

## Safety Screening

All content is also screened against seven policy categories via `SafetyPtosCategoryClassifier`:

1. ViolentMedia
2. AdultContent
3. Spam
4. IllegalAndRegulatedBehaviors
5. HateOrAbuse
6. ViolentSpeech
7. SuicideOrSelfHarm

Content triggering any of these gets suppressed regardless of engagement score. **Edgy or provocative content that flirts with these categories risks the safety pipeline suppressing it entirely.**

## Reply Quality Scoring

Replies (not just root posts) are quality-scored by Grok VLM on a **0–3 scale** with full reasoning. Signals fed into this scoring include engagement counts and contextual metadata. Higher-scored replies get more visibility in threads. **Reply quality matters more than reply frequency.**

## Practical Checklist Before Posting

- [ ] Does the post have a clear topical signal (passes taxonomy classification)?
- [ ] Is the opening hook specific and original — not generic?
- [ ] Does the post add original insight, not just restate common knowledge?
- [ ] Is there enough content to hold a reader for several seconds (dwell time)?
- [ ] If replying: does the reply genuinely extend the conversation?
- [ ] Does nothing in the post trigger safety categories?
