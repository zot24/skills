<!-- Source: https://github.com/xai-org/x-algorithm/blob/main/visibility-filtering/rules/registry.rs (cached at upstream/visibility-filtering-registry.md) -->
<!-- Snapshot: 28e414f, 2026-08-21 — Brazil filter is in home-mixer, not the VF registry -->

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

Rules are grouped into policies by `SafetyLevel` (`registry.rs:26-30`). Two matter here:

- `TimelineHome` → `timeline_home_policy()` (`registry.rs:134-136`)
- `TimelineHomeRecommendations` → `timeline_home_recommendations_policy()` (`registry.rs:138-170`)

Recommendations policy = **the same base rules plus an extra `oon_drops` list**
(`registry.rs:140-167`).

**This is the core asymmetry: a set of labels drops your post only when it is a recommendation to
someone who does not follow you. The identical post stays visible to your followers.** You can be
cut off from all new-audience reach while your timeline looks completely normal.

The OON-only drop list (`registry.rs:141-167`):

| Rule | What it keys on |
|---|---|
| `SPAM_HIGH_RECALL_DROP` | Post labelled spam at high recall |
| `SPAM_HIGH_RECALL_USER_DROP` | **Account** labelled spam at high recall |
| `DO_NOT_AMPLIFY_DROP` | Post marked do-not-amplify |
| `DO_NOT_AMPLIFY_NON_FOLLOWER_USER_DROP` | Account marked do-not-amplify to non-followers |
| `MALICIOUS_URL_DROP` | Post links to a flagged URL |
| `ABUSIVE_HIGH_RECALL_USER_DROP` | Account labelled abusive at high recall |
| `COMPROMISED_USER_DROP` | Account flagged compromised |
| `READ_ONLY_USER_DROP` | Account in read-only state |
| `IMPERSONATION_HIGH_PRECISION_USER_DROP` | Account flagged impersonation |
| `FOSNR_ABUSE_INSULTS_OON_DROP` | Insults/abuse, out-of-network only |
| `NSFW_*` / `GORE_AND_VIOLENCE_*` (post, user, avatar, banner, card, text) | Adult / graphic content labels |
| `DropTweetsWithDmcaMediaRule` | DMCA-flagged media |
| `DropTweetsWithGeoRestrictedMediaRule` | Geo-restricted media |

Note how many are **account-level**, not post-level. `SPAM_HIGH_RECALL_USER_DROP`,
`ABUSIVE_HIGH_RECALL_USER_DROP` and the NSFW avatar/banner rules suppress *everything you post*
out-of-network regardless of the individual post's quality.

The high-recall variants are deliberate: upstream notes some rules "drop a post only when it is a
recommendation from an account the viewer does not follow — spam caught at high recall, for
instance." High recall means the classifier is tuned to catch more and tolerate false positives —
acceptable because followers still see you.

→ How accounts pick up those labels: **[Account Standing](account-standing.md)**.

## Base rules (both in-network and OON)

`base_home_rules()` (`registry.rs:101-132`) — these drop or gate for everyone:

- Author state: suspended, deactivated, erased, offboarded, protected
- Viewer relationship: viewer blocks author, viewer mutes author, muted retweets
- Post labels: `PDNA_DROP`, `BOUNCE_DROP`, `SPAM_DROP`, `FOR_EMERGENCY_USE_ONLY_DROP`
- FOSNR policy drops: hateful conduct, violent speech, abuse, civic integrity
- `NullcastedTweetDropRule`, `DropStaleTweetsRule`
- Legal: `DropLegalTakendownPostRule`, `DropLocalLawsTakendownPostRule`
- Age gating for sensitive content: logged-out, underage, no stated age
- `DropExclusiveTweetContentRule` (subscriber-only)
- Interstitials: `NSFW_HIGH_PRECISION_INTERSTITIAL`, `GORE_AND_VIOLENCE_INTERSTITIAL`,
  `NSFW_CARD_IMAGE_INTERSTITIAL`, `NsfwAuthorInterstitialRule`

Note `DropStaleTweetsRule` — posts age out regardless of engagement. Old content does not
resurface. Separately, Phoenix can zero engagement-count features on ~14-day-old candidates when
`enable_stale_post` is on (ranking-side, not this VF rule).

## Brazil 2026 election filter (home-mixer, 2026-08-14)

Not part of the `visibility-filtering/` registry — it runs in the Phoenix candidate pipeline as
`Brazil2026ElectionFilter` (`home-mixer/filters/brazil_2026_election_filter.rs`).

- Hardcoded set of user IDs reported to Brazil's Electoral Court for the 2026 election (~665
  accounts in the open-source list; usernames included for transparency).
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

This is the only way to confirm a suppression hypothesis rather than guess at it. Check it before
concluding anything about your reach.

## Caveat

Upstream withholds some inputs by design (`README.md`, "What's not in this repo?"): the Grox `.j2`
prompt files and **some botmaker rules**. The rule *registry* is public; not every rule that
assigns a label is. Absence of a rule from this document is not proof it doesn't exist.
