<!-- Source: https://github.com/xai-org/x-algorithm/blob/main/visibility-filtering/rules/registry.rs (cached at upstream/visibility-filtering-registry.md) -->
<!-- Snapshot: a389166, 2026-08-13 -->

# Visibility Filtering

Published **2026-08-13**. This is the system that decides whether a post can be shown at all —
separately from, and after, ranking.

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
resurface.

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
