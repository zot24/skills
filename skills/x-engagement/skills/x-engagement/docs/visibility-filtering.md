<!-- Source: https://github.com/xai-org/x-algorithm/blob/main/visibility-filtering/rules/registry.rs (cached at upstream/visibility-filtering-registry.md) -->
<!-- Snapshot: 8b258297, 2026-09-18 — Brazil filter is in home-mixer, not the VF registry -->

# Visibility Filtering

Published **2026-08-13**, with an additional For You candidate filter on **2026-08-14**
(`Brazil2026ElectionFilter`), and Following-timeline muted-keyword expansion on **2026-08-21**.
This is the system that decides whether a post can be shown at all — separately from, and after,
ranking.

**Ranking sets the order. Visibility filtering sets whether you're in the list.** Optimizing
scoring signals is pointless for a post that gets dropped here.

## Three verdicts

For each (post, viewer) pair, `visibility-filtering/` returns one of:

| Verdict | Effect |
|---|---|
| `ALLOW` | Show normally |
| `INTERSTITIAL` | Show behind a tap-through screen (adult / graphic media) |
| `DROP` | Do not show |

Applied after ranking by `VFFilter` and `AncillaryVFFilter` (`home-mixer/filters/`). A drop also
removes any post whose **thread ancestor, quoted post, or reposted post** was dropped — so being
dropped contaminates conversations built on you.

## The part that matters most: OON-only drops

Rules are grouped into policies by `SafetyLevel` (`registry.rs:10-14`). Two matter here:

- `TimelineHome` → `TIMELINE_HOME_POLICY` (`registry.rs:92`)
- `TimelineHomeRecommendations` → `TIMELINE_HOME_RECOMMENDATIONS_POLICY` (`registry.rs:93-96`)

Shared home rules live in `TIMELINE_HOME_SHARED_RULES` (`registry.rs:72-82`). Recommendations
policy = those plus `TIMELINE_HOME_RECOMMENDATION_ONLY_RULES` (`registry.rs:84-90`) — the
OON-only extra drops, now split across `author_rules::*` and `tweet_rules::*`.

**This is the core asymmetry: a set of labels drops your post only when it is a recommendation to
someone who does not follow you. The identical post stays visible to your followers.** You can be
cut off from all new-audience reach while your timeline looks completely normal.

The OON-only extra groups (`registry.rs:84-90`):

| Group | What it keys on |
|---|---|
| `tweet_rules::RECS_MEDIA_DROPS` | DMCA / geo-restricted media |
| `author_rules::OON_NSFW_AUTHOR_DROPS` | NSFW avatar/banner/author labels, out-of-network |
| `tweet_rules::OON_TWEET_FLAG_DROPS` | Do-not-amplify and similar tweet flags |
| `tweet_rules::OON_TWEET_LABEL_DROPS` | Spam-high-recall, malicious URL, and related post labels |
| `author_rules::OON_USER_LABEL_DROPS` | Account-level spam / abusive / compromised / read-only / impersonation |

Note how many are **account-level**, not post-level. `SPAM_HIGH_RECALL_USER_DROP`,
`ABUSIVE_HIGH_RECALL_USER_DROP` and the NSFW avatar/banner rules suppress *everything you post*
out-of-network regardless of the individual post's quality.

The high-recall variants are deliberate: upstream notes some rules "drop a post only when it is a
recommendation from an account the viewer does not follow — spam caught at high recall, for
instance." High recall means the classifier is tuned to catch more and tolerate false positives —
acceptable because followers still see you.

→ How accounts pick up those labels: **[Account Standing](account-standing.md)**.

## Base rules (both in-network and OON)

`TIMELINE_HOME_SHARED_RULES` (`registry.rs:72-82`) — these drop or gate for everyone:

- Author state: suspended, deactivated, erased, offboarded, protected (`AUTHOR_STATE_DROPS`)
- Viewer relationship: viewer blocks author, viewer mutes author, muted retweets (`SOCIALGRAPH_DROPS`)
- Post labels: `PDNA_DROP`, `BOUNCE_DROP`, `SPAM_DROP`, `FOR_EMERGENCY_USE_ONLY_DROP` (`TWEET_LABEL_DROPS`)
- TES / legal: `TES_HOME_DROPS` (includes legal takedown / local-law withhold)
- Age gating for sensitive content: logged-out, underage, no stated age (`SENSITIVE_VIEWER_DROPS`)
- `NULLCAST_DROP`, exclusive/subscriber-only (`EXCLUSIVE_TWEET_DROP`)
- Interstitials: NSFW media + NSFW author (`NSFW_MEDIA_INTERSTITIALS`, `NSFW_AUTHOR_INTERSTITIAL`)

Note `DropStaleTweetsRule` — posts age out regardless of engagement. Old content does not
resurface. Separately, Phoenix can zero engagement-count features on ~14-day-old candidates when
`enable_stale_post` is on (ranking-side, not this VF rule).

## Brazil 2026 election filter (home-mixer, 2026-08-14)

Not part of the `visibility-filtering/` registry — it runs in the Phoenix candidate pipeline as
`Brazil2026ElectionFilter` (`home-mixer/filters/brazil_2026_election_filter.rs`).

- Hardcoded set of user IDs reported to Brazil's Electoral Court for the 2026 election
  (usernames included for transparency; README notes the **account list was updated 2026-08-27**,
  and the source list grew again by 2026-09-18 — ~2,779 IDs in `brazil_2026_election_filter.rs`).
- **Removes** from For You recommendations posts whose author is on the list **unless the viewer
  already follows that author**.
- Also removes retweets of listed authors, quotes of listed authors, and replies whose ancestor
  chain includes a listed author (same follow exception).
- Stated purpose: Brazilian electoral-law compliance for recommendation systems
  ([XBR announcement](https://x.com/XBR/status/2088341967864320507), TSE open data).

Practical: this is a **jurisdiction-specific OON-style drop with an explicit follow carve-out**.
It is not a general spam/safety label. Creators outside that list are unaffected. Open-source
makes the exact membership and logic auditable.

## Muted keywords — Following now matches quotes and ancestors (2026-08-21)

Home Mixer split the old `MutedKeywordFilter` into timeline-specific filters:

| Timeline | Filter | Text surfaces matched |
|---|---|---|
| For You (Phoenix pipeline) | `ViewerMutedKeywordFilter` | candidate `tweet_text` |
| Following (reverse-chron) | `FollowingViewerMutedKeywordFilter` | `tweet_text` **+** `quoted_tweet_text` **+** `ancestor_texts` |

Following also gained `QuotedPostTextHydrator` and richer ancestor text hydration so those fields
exist before the mute match runs
(`home-mixer/candidate_pipeline/reverse_chron_posts_pipeline.rs`,
`following_viewer_muted_keyword_filter.rs:55-64`).

Practical: if viewers mute a phrase that appears in a parent tweet or a quoted post, your reply
or quote-tweet can still be filtered out of *their Following timeline* even when your own body is
clean. Keyword hygiene is conversational now, not post-body-only.

## Following drops blocked quotes and retweets (2026-08-28)

The Following (reverse-chron) pipeline now hydrates blocked-by on **quoted and retweeted authors**
(`FollowingBlockedByHydrator`) and drops candidates via `AuthorSocialgraphFilter` when:

- the viewer muted or blocked the author
- the author blocks the viewer
- the quoted author blocks the viewer, or the viewer blocks the quoted author
- the viewer blocks the retweeted user

Practical: quoting or retweeting someone who has blocked a follower hides that quote/RT from
that follower's Following timeline. This is Following-path only, not For You ranking.

## Practical implications

1. **Reach loss is usually not a ranking problem.** If out-of-network reach vanishes while
   follower engagement holds, suspect an account-level OON drop label, not your hooks.
2. **Account standing gates everything.** No amount of per-post craft survives
   `SPAM_HIGH_RECALL_USER_DROP`. Protecting standing outranks optimizing any post.
3. **Profile media is scored.** `NSFW_AVATAR_IMAGE_USER_DROP` and `NSFW_BANNER_IMAGE_USER_DROP`
   mean your avatar and header can cost you all OON distribution.
4. **Links carry account risk.** `MALICIOUS_URL_DROP` keys on the link, so a shortener or a domain
   that later gets flagged can drop posts you already published.
5. **Being dropped damages others.** Quotes and replies built on a dropped post are dropped too —
   which is also why threads under a suppressed root go quiet.
6. **Interstitials are not drops.** Edgy-but-allowed media stays in the feed behind a tap. Nothing
   in the repo draws the interstitial; the post is still distributed.
7. **Geo/legal filters exist in code.** Election and local-law paths can remove eligible authors
   from recommendations even with clean spam standing — check Under the Hood and local rules if
   reach dies only for some audiences.

## Check your own labels

xAI shipped a transparency tool alongside this release — **Under the Hood** — which shows the
visibility-limiting labels applied to your account and posts, including whether a label was
applied manually rather than by an automated system (`README.md`, "Under the Hood Label
Transparency Tool").

As of **2026-09-18**, those reports also include **legal-compliance withholdings**: whether an
account or post had visibility limited because of required compliance with law, including
country-level takedowns (`README.md`, Notable Updates). A reach drop that is geo-specific is
more likely a legal withhold than a spam label — check UTH before rewriting hooks.

This is the only way to confirm a suppression hypothesis rather than guess at it. Check it before
concluding anything about your reach.

## Caveat

Upstream withholds some inputs by design (`README.md`, "What's not in this repo?"): the Grox `.j2`
prompt files and **some botmaker rules**. The rule *registry* is public; not every rule that
assigns a label is. Absence of a rule from this document is not proof it doesn't exist.
