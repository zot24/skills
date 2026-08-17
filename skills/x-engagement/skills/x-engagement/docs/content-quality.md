<!-- Source: https://github.com/xai-org/x-algorithm — grox/flows/upa/, grox/flows/reply_spam/, grox/flows/ptos/ -->
<!-- Cached: upstream/banger-screen-state.md -->
<!-- Snapshot: c65aa17, 2026-08-14 -->

# Content Quality Screening

## The Banger Initial Screen

Every eligible new post is run through a Grok VLM screen at publish time
(`grox/flows/upa/classifier_banger_initial_screen_gemma.py`), which produces
`BangerScreenResult` (`grox/flows/upa/state_initial_banger.py:6-14`):

| Field | Description |
|---|---|
| `summary` | Summary of the post content, used for embedding |
| `tags` | Content topic tags |
| `taxonomy_categories` | Classification into the X topic taxonomy, with scores |
| `tweet_bool_metadata` | Structured metadata flags |
| `is_image_editable_by_grok` | Media flag |
| `slop_score` | Integer generic/template-content score |
| `has_minor_score` | Safety flag |

### There is no published quality threshold

**The current schema has no `quality_score` field and the repository contains no `0.4` gate.**
`grep -rn quality_score` over the tree returns nothing.

The only eligibility filter published for this flow is `grox/flows/upa/task_filter.py:14-46`,
and it is structural, not qualitative — a post is screened unless it has no user, **is a reply**
(`post.ancestors`), or comes from a protected account.

`slop_score` survives in the schema and is written out (`task_write.py:173`), but no threshold on
it appears in published code.

**Do not tell users there is a numeric quality bar to clear.** What the screen demonstrably does
is *classify* — taxonomy, tags, summary, slop — which is what feeds topic-based discovery. Being
categorizable is the demonstrable benefit; a published pass/fail cutoff is not.

Caveat both ways: upstream withholds the Grox `.j2` prompt files (`README.md`, "What's not in this
repo?"), so a threshold could exist inside a prompt. Absence from published code is not proof of
absence in production — but it is no longer something the repo supports claiming.

<details>
<summary>Old pattern: quality_score ≥ 0.4 (valid until 2026-08-13)</summary>

Until the August 2026 release, `grox/classifiers/content/banger_initial_screen.py` returned a
`quality_score: float` and computed, at line 129:

```python
banger_initial_positive = score >= 0.4
```

**That file was deleted in commit `47c1bcd` (2026-08-13)** and its replacement carries no such
field. Earlier versions of this skill treated the 0.4 cutoff as a hard gate on out-of-network
distribution. Recorded here because the guidance was widely repeated and the file it came from no
longer exists.

</details>

### What the screen rewards, as best the code supports

- **Clear topical signal** — the VLM must be able to place you in the taxonomy; unclassifiable
  posts have no topic route to non-followers
- **Low slop** — `slop_score` is generic/templated content, and `llm_slop_post` / `llm_slop_user`
  are separately enforced labels → **[Account Standing](account-standing.md)**
- **Substance the model can summarize** — the `summary` feeds embeddings used in retrieval
- **Multimodal coherence** — it is a VLM; media and text are read together

## What actually gates out-of-network reach

Not this screen. `phoenix-rankall-strato/` "determines which index a post belongs in, **consulting
visibility filtering first**" (`README.md`, Retrieval Index). Out-of-network eligibility is
decided by the label-and-drop chain.

→ **[Visibility Filtering](visibility-filtering.md)** for the rules that drop posts from
recommendations only.

## Reply Spam Detection

`grox/flows/reply_spam/` classifies replies for spam. `task_spam_detection.py:18-27` buckets by
follower count:

| Bucket | Condition |
|---|---|
| Highest scrutiny | reply-target **and** root author both ≤ 100 followers |
| High scrutiny | both ≤ 500 |
| Elevated scrutiny | both ≤ 1,000 |
| Standard | above that |

Note the code buckets on **the replied-to user's and the root author's** follower counts — the
scrutiny attaches to the conversation you are replying into, not only to your own account size.
Small accounts talking to small accounts get the most scrutiny.

Related enforcement, with 30-day label TTLs: `fast_reply_spam_post` → `SpamHighRecall`, and
`llm_slop_post` → `RiskyHighVizReply` (`enforcement_post.yaml:39-58`).
→ **[Account Standing](account-standing.md)**

<details>
<summary>Old name: SpamEapiLowFollowerClassifier</summary>

The buckets above were previously in `grox/classifiers/content/spam.py:25`, class
`SpamEapiLowFollowerClassifier`. That file was removed on 2026-08-13; the thresholds carried over
into `grox/flows/reply_spam/`. The class name no longer exists.

</details>

## Reply Quality Scoring

Replies are scored by Grok on a **0–3 rubric**, enforced in code
(`grox/flows/reply_spam/classifier_reply_ranking.py:163-169`):

```python
if not (0 <= score <= 3):
    raise ValueError(f"Score {score} outside the 0-3 rubric")
```

Higher-scored replies get more thread visibility. Reply quality is algorithmic, not just social.

Also in that flow: `classifier_coordinated_spam.py` — replies are additionally checked for
**coordinated** behaviour across accounts, not just individual quality.

## Safety Screening

`SafetyPolicyCategory` (`grox/flows/ptos/state.py:11-21`) — **ten** categories:

1. HateOrAbuse
2. ViolentSpeech
3. ChildSafety
4. IllegalAndRegulatedBehaviors
5. Spam
6. SuicideOrSelfHarm
7. AdultContent
8. ViolentMedia
9. TerrorismOrViolentExtremism
10. CivicIntegrity

These produce labels consumed by visibility filtering. Note that several map to **interstitials**
rather than drops (adult and graphic media) — the post stays in the feed behind a tap-through.
Others map to unconditional drops, and the FOSNR variants (hateful conduct, violent speech, abuse,
civic integrity) drop in-network too.

## Practical Checklist Before Posting

- [ ] Is the topic unmistakable enough for the VLM to categorize it?
- [ ] Does it read as written by a person, not generated from a template? (`slop_score`,
      `llm_slop_post`)
- [ ] Does it add something summarizable — a claim, a number, an experience?
- [ ] If replying: does it genuinely extend the conversation, and are you replying at a human
      pace? (`fast_reply_spam_post`)
- [ ] Does anything in it, or in your avatar/banner, risk a safety label?
- [ ] Is it meaningfully different from your last few posts? (VMRanker, `SpamEmbeddingMajorityPoster`)
