> Source: https://raw.githubusercontent.com/xai-org/x-algorithm/main/visibility-filtering/rules/registry.rs

use crate::hydration::{HydrationPlan, Hydrators};
use crate::models::{
    Decided, HydratedTweetCandidate, LimitedEngagement, Verdict, ViewerFeatures, Withholding,
};
use crate::params::CountryLists;
use crate::rules::rule_spec::{ActionSpec, RuleClause, RuleId, Truth};
use crate::rules::RuleContext;
use crate::rules::{author_rules, tweet_rules};
use std::cmp::Reverse;
use std::sync::Arc;
use strum::VariantArray;

#[derive(Clone, Copy, Debug, PartialEq, Eq, strum::IntoStaticStr, strum::VariantArray)]
#[strum(serialize_all = "snake_case")]
pub enum SafetyLevel {
    FilterAll,
    TimelineHome,
    TimelineHomeRecommendations,
    TimelineHomeHydration,
    ImmersiveExpandedRecommendations,
}

pub struct Evaluation {
    pub verdict: Verdict,
    pub rested_on: Hydrators,
}

pub(super) struct Policy {
    clauses: Vec<(&'static str, RuleClause)>,
    hydrators: Hydrators,
}

impl Policy {
    fn new(mut clauses: Vec<(&'static str, RuleClause)>) -> Self {
        clauses.sort_by_key(|(_, clause)| Reverse(clause.action.severity()));
        let mut runs: Vec<&'static str> = Vec::new();
        let mut run: Vec<&RuleClause> = Vec::new();
        for &(name, ref clause) in &clauses {
            if runs.last() != Some(&name) {
                assert!(!runs.contains(&name), "{name} is wired twice");
                runs.push(name);
                run.clear();
            }
            assert!(!run.contains(&clause), "{name} is wired twice");
            run.push(clause);
        }
        let hydrators = clauses
            .iter()
            .fold(Hydrators::empty(), |hydrators, (_, clause)| {
                hydrators.union(clause.hydrators())
            });
        Self { clauses, hydrators }
    }

    pub(super) fn evaluate(&self, context: &RuleContext<'_>) -> Evaluation {
        let mut media = None;
        let mut engagement = None;
        let mut withholding_rested_on = Hydrators::empty();
        let mut slot_rested_on = Hydrators::empty();

        for &(by, ref rule) in &self.clauses {
            let truth = rule.applies(context);
            let unknown_reads = match truth {
                Truth::Unknown { failed, .. } => failed,
                Truth::True | Truth::False => Hydrators::empty(),
            };
            match &rule.action {
                ActionSpec::Drop(reason) => {
                    withholding_rested_on = withholding_rested_on.union(unknown_reads);
                    if truth.resolves_true() {
                        return Evaluation {
                            verdict: Verdict::Withheld(Decided {
                                value: Withholding::Drop(reason.clone()),
                                by,
                            }),
                            rested_on: withholding_rested_on,
                        };
                    }
                }
                ActionSpec::Tombstone(reason) => {
                    withholding_rested_on = withholding_rested_on.union(unknown_reads);
                    if truth.resolves_true() {
                        return Evaluation {
                            verdict: Verdict::Withheld(Decided {
                                value: Withholding::Tombstone(*reason),
                                by,
                            }),
                            rested_on: withholding_rested_on,
                        };
                    }
                }
                ActionSpec::MediaRestriction(value) if media.is_none() => {
                    slot_rested_on = slot_rested_on.union(unknown_reads);
                    if truth.resolves_true() {
                        media = Some(Decided {
                            value: value.clone(),
                            by,
                        });
                    }
                }
                ActionSpec::LimitedEngagement(reason) => {
                    if engagement.is_none() {
                        slot_rested_on = slot_rested_on.union(unknown_reads);
                    }
                    if truth.resolves_true() {
                        match &mut engagement {
                            None => {
                                engagement = Some(Decided {
                                    value: LimitedEngagement::new(*reason),
                                    by,
                                });
                            }
                            Some(limit) => limit.value.add(*reason),
                        }
                    }
                }
                ActionSpec::MediaRestriction(_) => {}
            }
        }

        Evaluation {
            verdict: Verdict::Shown { media, engagement },
            rested_on: withholding_rested_on.union(slot_rested_on),
        }
    }

    fn rule_names(&self) -> impl Iterator<Item = &'static str> + '_ {
        let mut previous: Option<&'static str> = None;
        self.clauses.iter().filter_map(move |&(name, _)| {
            let repeat = previous == Some(name);
            previous = Some(name);
            (!repeat).then_some(name)
        })
    }

    fn len(&self) -> usize {
        self.rule_names().count()
    }
}

fn timeline_home_shared() -> Vec<RuleClause> {
    [
        author_rules::author_state_drops(),
        author_rules::socialgraph_drops(),
        tweet_rules::tweet_label_drops(),
        tweet_rules::fosnr_level_3_drops(),
        tweet_rules::nullcast_drop(),
        tweet_rules::stale_tweet_drop(),
        tweet_rules::takedown_drops(),
        tweet_rules::sensitive_viewer_drops(),
        tweet_rules::exclusive_tweet_drop(),
        tweet_rules::nsfw_media_interstitials(),
        tweet_rules::nsfw_author_interstitials(),
    ]
    .concat()
}

fn timeline_home_recommendation_only() -> Vec<RuleClause> {
    [
        tweet_rules::recs_media_drops(),
        author_rules::oon_nsfw_author_drops(),
        tweet_rules::oon_tweet_flag_drops(),
        tweet_rules::gore_and_violence_high_precision::oon_drop(),
        tweet_rules::oon_nsfw_media_label_drops(),
        tweet_rules::oon_low_quality_tweet_label_drops(),
        tweet_rules::oon_text_label_drops(),
        author_rules::oon_nsfw_user_label_drops(),
        author_rules::oon_user_label_drops(),
    ]
    .concat()
}

fn timeline_home_hydration() -> Vec<RuleClause> {
    [
        author_rules::home_hydration_author_state_drops(),
        tweet_rules::fosnr_level_3_drops(),
        tweet_rules::fosnr_level_1_non_follower_drop(),
        tweet_rules::fosnr_fallback_drop(),
        tweet_rules::creator_tweet_nsfw_drop(),
        tweet_rules::protected_community_tweet_drop(),
        tweet_rules::home_hydration_tweet_label_drops(),
        tweet_rules::exclusive_tweet_drop(),
        tweet_rules::takedown_drops(),
        tweet_rules::author_blocks_viewer_exclusive_content_drop(),
        tweet_rules::sensitive_viewer_drops(),
        tweet_rules::home_hydration_nsfw_rules(),
        tweet_rules::limited_engagement_rules(),
    ]
    .concat()
}

fn immersive_expanded_recommendations() -> Vec<RuleClause> {
    [
        author_rules::author_state_drops(),
        author_rules::socialgraph_drops(),
        tweet_rules::tweet_label_drops(),
        tweet_rules::fosnr_level_3_drops(),
        tweet_rules::stale_tweet_drop(),
        tweet_rules::takedown_drops(),
        tweet_rules::sensitive_viewer_drops(),
        tweet_rules::exclusive_tweet_drop(),
        tweet_rules::recs_media_drops(),
        tweet_rules::gore_and_violence_high_precision::oon_drop(),
        tweet_rules::oon_low_quality_tweet_label_drops(),
        author_rules::oon_user_label_drops(),
        tweet_rules::sensitive_media_opt_out_drops(),
    ]
    .concat()
}

struct Level {
    policy: Policy,
    plan: HydrationPlan,
}

pub struct RuleEngine {
    country_lists: Arc<CountryLists>,
    levels: Vec<Level>,
}

#[expect(
    clippy::panic,
    reason = "invalid authored rules fail startup, before the service takes traffic"
)]
fn interned_name(
    names: &mut Vec<(RuleId, ActionSpec, &'static str)>,
    clause: &RuleClause,
) -> &'static str {
    if let Some(&(_, _, name)) = names
        .iter()
        .find(|(id, action, _)| *id == clause.id && *action == clause.action)
    {
        return name;
    }
    let name: &'static str = clause.name().leak();
    if let Some((id, action, _)) = names.iter().find(|&&(_, _, other)| other == name) {
        panic!(
            "{id:?} {action:?} and {:?} {:?} derive {name}",
            clause.id, clause.action
        );
    }
    names.push((clause.id, clause.action.clone(), name));
    name
}

impl RuleEngine {
    #[cfg(test)]
    pub(crate) fn for_tests() -> Self {
        Self::with_country_lists(Arc::new(CountryLists::starting_at_default()))
    }

    pub fn with_country_lists(country_lists: Arc<CountryLists>) -> Self {
        let mut names = Vec::new();
        let levels = SafetyLevel::VARIANTS
            .iter()
            .map(|&level| {
                let clauses = Self::clauses(level)
                    .into_iter()
                    .map(|clause| (interned_name(&mut names, &clause), clause))
                    .collect();
                let policy = Policy::new(clauses);
                let plan = HydrationPlan::new(level, policy.hydrators);
                Level { policy, plan }
            })
            .collect();
        Self {
            country_lists,
            levels,
        }
    }

    fn clauses(level: SafetyLevel) -> Vec<RuleClause> {
        match level {
            SafetyLevel::FilterAll => tweet_rules::filter_all(),
            SafetyLevel::TimelineHome => timeline_home_shared(),
            SafetyLevel::TimelineHomeRecommendations => {
                [timeline_home_shared(), timeline_home_recommendation_only()].concat()
            }
            SafetyLevel::TimelineHomeHydration => timeline_home_hydration(),
            SafetyLevel::ImmersiveExpandedRecommendations => immersive_expanded_recommendations(),
        }
    }

    pub fn evaluate(
        &self,
        level: SafetyLevel,
        viewer: &ViewerFeatures,
        candidate: &HydratedTweetCandidate,
    ) -> Evaluation {
        let policy = self.policy(level);
        let context = RuleContext::new(viewer, candidate, &self.country_lists);
        #[cfg(test)]
        let context = context.hydrated_by(policy.hydrators);
        policy.evaluate(&context)
    }

    fn level(&self, level: SafetyLevel) -> &Level {
        #[expect(
            clippy::indexing_slicing,
            reason = "`levels` maps `SafetyLevel::VARIANTS`, which is in declaration order"
        )]
        let entry = &self.levels[level as usize];
        debug_assert_eq!(entry.plan.level(), level);
        entry
    }

    fn policy(&self, level: SafetyLevel) -> &Policy {
        &self.level(level).policy
    }

    pub(crate) fn plan(&self, level: SafetyLevel) -> &HydrationPlan {
        &self.level(level).plan
    }

    #[cfg(test)]
    pub(crate) fn wired_rule_names(&self, level: SafetyLevel) -> Vec<&'static str> {
        self.policy(level).rule_names().collect()
    }

    pub fn rule_counts(&self) -> (usize, usize) {
        (
            self.policy(SafetyLevel::TimelineHome).len(),
            self.policy(SafetyLevel::TimelineHomeRecommendations).len(),
        )
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::hydration::Hydrator;
    use crate::models::{
        AuthorFeatures, ClientCapability, DropReason, NsfwViewerDropReason, SafetyLabelType,
        VerifyBlurSupport, ViewerAge, ViewerProfile,
    };
    use crate::rules::fixtures::{
        candidate, viewer, viewer_with_profile, CandidateBuilder, VIEWER_ID,
    };
    use crate::rules::rule_spec::Condition;
    use crate::rules::{holds_narrowed, test_context};
    use std::slice;

    #[test]
    fn refreshed_config_country_reaches_the_wired_rule() {
        let country_lists = Arc::new(CountryLists::starting_at_default());
        let rule_engine = RuleEngine::with_country_lists(Arc::clone(&country_lists));
        let candidate = candidate()
            .with_label(crate::models::SafetyLabelType::NSFW_HIGH_PRECISION)
            .with_media()
            .build();
        let viewer = ViewerFeatures {
            country_code: Some("us".into()),
            ..viewer_with_profile(ViewerProfile {
                viewer_age: ViewerAge::NotStated,
                ..ViewerProfile::default()
            })
        };

        let verdict = rule_engine
            .evaluate(SafetyLevel::TimelineHome, &viewer, &candidate)
            .verdict;
        assert!(!matches!(verdict, Verdict::Withheld(_)));

        country_lists.refresh(
            &xai_feature_switches::FeatureSwitches::load_string(
                r#"
country_specific_nsfw_content_gating:
  parameters:
    country_specific_nsfw_content_gating_countries:
      type: array
      default:
      - "us"
"#,
            )
            .unwrap(),
        );
        let verdict = rule_engine
            .evaluate(SafetyLevel::TimelineHome, &viewer, &candidate)
            .verdict;
        assert!(matches!(
            verdict,
            Verdict::Withheld(Decided {
                value: Withholding::Drop(DropReason::NsfwViewer(
                    NsfwViewerDropReason::HasNoStatedAge
                )),
                by: "sensitive_viewer_no_stated_age/drop",
            })
        ));
    }

    #[test]
    fn age_verification_tombstones_read_their_family_country_list() {
        let country_lists = Arc::new(CountryLists::starting_at_default());
        country_lists.refresh(
            &xai_feature_switches::FeatureSwitches::load_string(
                r#"
country_specific_nsfw_content_gating:
  parameters:
    country_specific_nsfw_content_gating_tombstone_countries:
      type: array
      default:
      - "us"
"#,
            )
            .unwrap(),
        );
        let rule_engine = RuleEngine::with_country_lists(country_lists);
        let viewer = ViewerFeatures {
            country_code: Some("us".into()),
            client_capability: ClientCapability {
                verify_blur_support: Some(VerifyBlurSupport::IosNeedsUpdate),
                modern_blur: true,
                stale_tweet_limits: true,
                gore_blur_ignores_settings: true,
                fosnr_rules: true,
                fosnr_fallback_drops: false,
            },
            ..viewer(VIEWER_ID)
        };
        let nsfw_admin = AuthorFeatures {
            is_nsfw_admin: true,
            ..AuthorFeatures::default()
        };
        let withheld_by = |candidate: CandidateBuilder| match rule_engine
            .evaluate(
                SafetyLevel::TimelineHomeHydration,
                &viewer,
                &candidate.with_media().build(),
            )
            .verdict
        {
            Verdict::Withheld(Decided { by, .. }) => Some(by),
            Verdict::Shown { .. } => None,
        };
        let labeled = |label| candidate().with_label(label);
        assert_eq!(
            withheld_by(labeled(SafetyLabelType::NSFW_HIGH_PRECISION)),
            Some("nsfw_high_precision/tombstone/update_app_ios")
        );
        assert_eq!(
            withheld_by(labeled(SafetyLabelType::GORE_AND_VIOLENCE_HIGH_PRECISION)),
            Some("gore_and_violence_high_precision/tombstone/update_app_ios")
        );
        assert_eq!(
            withheld_by(candidate().with_author_features(nsfw_admin)),
            None
        );
        assert_eq!(
            withheld_by(labeled(SafetyLabelType::NSFW_REPORTED_HEURISTICS)),
            None
        );
        assert_eq!(withheld_by(labeled(SafetyLabelType::NSFW_CARD_IMAGE)), None);
    }

    #[test]
    fn wired_rule_order_is_pinned() {
        let rule_engine = RuleEngine::for_tests();
        assert_eq!(
            rule_engine.wired_rule_names(SafetyLevel::FilterAll),
            vec!["filter_all/drop/unspecified"]
        );
        let home = rule_engine.wired_rule_names(SafetyLevel::TimelineHome);
        assert_eq!(
            home,
            vec![
                "suspended_author/drop",
                "deactivated_author/drop",
                "erased_author/drop/inactive",
                "offboarded_author/drop/inactive",
                "protected_author/drop",
                "viewer_blocks_author/drop",
                "viewer_mutes_author/drop",
                "viewer_mutes_retweets/drop/unspecified",
                "pdna/drop/safety_result",
                "bounce/drop/bounced",
                "spam/drop/undesirable",
                "for_emergency_use_only/drop/unspecified",
                "fosnr_hateful_conduct/drop/undesirable",
                "fosnr_violent_speech/drop/undesirable",
                "fosnr_abuse/drop/undesirable",
                "fosnr_civic_integrity/drop/undesirable",
                "nullcasted_tweet/drop",
                "stale_tweet/drop/unspecified",
                "legal_takedown/drop/unspecified",
                "local_laws_takedown/drop/unspecified",
                "sensitive_viewer_logged_out/drop",
                "sensitive_viewer_underage/drop",
                "sensitive_viewer_no_stated_age/drop",
                "exclusive_tweet/drop",
                "nsfw_high_precision/blur/nudity",
                "nsfw_high_precision/blur/sensitive",
                "gore_and_violence_high_precision/blur",
                "nsfw_card_image/blur/sensitive",
                "nsfw_admin/blur/sensitive",
                "nsfw_user/blur/sensitive_user",
            ]
        );
        let (home_drops, home_blurs) = home.split_at(
            home.iter()
                .position(|&name| name == "nsfw_high_precision/blur/nudity")
                .unwrap(),
        );
        let mut recs = home_drops.to_vec();
        recs.extend([
            "dmca_media/drop/unspecified",
            "geo_restricted_media/drop/unspecified",
            "nsfw_user_author/drop/nsfw_media",
            "nsfw_admin_author/drop/nsfw_media",
            "nsfw_user_tweet_flag/drop/nsfw_media",
            "nsfw_admin_tweet_flag/drop/nsfw_media",
            "gore_and_violence_high_precision/drop/nsfw_media",
            "nsfw_high_recall/drop/nsfw_media",
            "nsfw_high_precision/drop/nsfw_media",
            "nsfw_card_image/drop/nsfw_media",
            "do_not_amplify/drop/undesirable",
            "malicious_url/drop/undesirable",
            "spam_high_recall/drop/undesirable",
            "brazil_election_legal/drop/undesirable",
            "fosnr_abuse_insults/drop/undesirable",
            "nsfw_high_recall_user_label/drop/unspecified",
            "nsfw_high_precision_user_label/drop/unspecified",
            "nsfw_avatar_image_user_label/drop/unspecified",
            "nsfw_banner_image_user_label/drop/unspecified",
            "nsfw_near_perfect_user_label/drop/unspecified",
            "spam_high_recall_user_label/drop/unspecified",
            "compromised_user_label/drop/unspecified",
            "read_only_user_label/drop/unspecified",
            "impersonation_high_precision_user_label/drop/unspecified",
            "abusive_high_recall_user_label/drop/unspecified",
            "do_not_amplify_user_label/drop/unspecified",
        ]);
        recs.extend(home_blurs);
        assert_eq!(
            rule_engine.wired_rule_names(SafetyLevel::TimelineHomeRecommendations),
            recs
        );
    }

    #[test]
    fn home_hydration_wires_only_its_ordered_baseline_rules() {
        assert_eq!(
            RuleEngine::for_tests().wired_rule_names(SafetyLevel::TimelineHomeHydration),
            vec![
                "erased_author/drop/inactive",
                "deactivated_author/drop",
                "suspended_author/drop",
                "offboarded_author/drop/inactive",
                "protected_author/drop",
                "fosnr_hateful_conduct/drop/undesirable",
                "fosnr_violent_speech/drop/undesirable",
                "fosnr_abuse/drop/undesirable",
                "fosnr_civic_integrity/drop/undesirable",
                "fosnr_abuse_insults_non_follower/drop/undesirable",
                "fosnr_fallback/drop/undesirable",
                "creator_tweet_nsfw/drop/nsfw_media",
                "protected_community_tweet/drop/unspecified",
                "spam/drop/undesirable",
                "pdna/drop/safety_result",
                "bounce/drop/bounced",
                "for_emergency_use_only/drop/unspecified",
                "exclusive_tweet/drop",
                "legal_takedown/drop/unspecified",
                "local_laws_takedown/drop/unspecified",
                "author_blocks_viewer_exclusive_content/drop/unspecified",
                "sensitive_viewer_logged_out/drop",
                "sensitive_viewer_underage/drop",
                "sensitive_viewer_no_stated_age/drop",
                "nsfw_high_precision/tombstone/local_regulations",
                "nsfw_high_precision/tombstone/age_verification",
                "nsfw_high_precision/tombstone/update_app_ios",
                "nsfw_high_precision/tombstone/update_app_android",
                "nsfw_account/tombstone/age_verification",
                "nsfw_account/tombstone/update_app_ios",
                "nsfw_account/tombstone/update_app_android",
                "nsfw_reported_heuristics/tombstone/age_verification",
                "nsfw_reported_heuristics/tombstone/update_app_ios",
                "nsfw_reported_heuristics/tombstone/update_app_android",
                "nsfw_card_image/tombstone/age_verification",
                "nsfw_card_image/tombstone/update_app_ios",
                "nsfw_card_image/tombstone/update_app_android",
                "gore_and_violence_high_precision/tombstone/update_app_ios",
                "gore_and_violence_high_precision/tombstone/update_app_android",
                "nsfw_high_precision/blur/sensitive/age_prompt",
                "nsfw_high_precision/blur/sensitive",
                "nsfw_high_precision/blur/nudity/age_prompt",
                "nsfw_high_precision/blur/nudity",
                "nsfw_high_precision/legacy_interstitial",
                "nsfw_admin/blur/sensitive/age_prompt",
                "nsfw_admin/blur/sensitive",
                "nsfw_user/blur/sensitive_user/age_prompt",
                "nsfw_user/blur/sensitive_user",
                "nsfw_account/legacy_interstitial",
                "gore_and_violence_high_precision/blur",
                "gore_and_violence_ignoring_settings/blur",
                "gore_and_violence_high_precision/legacy_interstitial",
                "nsfw_reported_heuristics/blur/sensitive/age_prompt",
                "nsfw_reported_heuristics/blur/sensitive",
                "nsfw_reported_heuristics/legacy_interstitial",
                "gore_and_violence_reported_heuristics/blur/sensitive",
                "gore_and_violence_reported_heuristics/legacy_interstitial",
                "nsfw_card_image/blur/sensitive/age_prompt",
                "nsfw_card_image/blur/sensitive",
                "nsfw_card_image/legacy_interstitial",
                "gore_and_violence_high_precision/blur/age_prompt",
                "blocked_viewer/limited_engagement",
                "blocked_viewer/limited_engagement/root_author_blocked_viewer",
                "stale_tweet/limited_engagement",
                "limit_replies_by_invitation/limited_engagement/conversation_control",
                "limit_replies_community/limited_engagement/conversation_control",
                "limit_replies_subscribers/limited_engagement/conversation_control",
                "limit_replies_verified/limited_engagement/conversation_control",
                "limit_replies_my_network/limited_engagement/conversation_control",
                "limit_replies_co/limited_engagement/conversation_control",
                "read_only_viewer/limited_engagement",
            ]
        );
    }

    #[test]
    fn immersive_expanded_recommendations_wires_only_its_ordered_rules() {
        assert_eq!(
            RuleEngine::for_tests().wired_rule_names(SafetyLevel::ImmersiveExpandedRecommendations),
            vec![
                "suspended_author/drop",
                "deactivated_author/drop",
                "erased_author/drop/inactive",
                "offboarded_author/drop/inactive",
                "protected_author/drop",
                "viewer_blocks_author/drop",
                "viewer_mutes_author/drop",
                "viewer_mutes_retweets/drop/unspecified",
                "pdna/drop/safety_result",
                "bounce/drop/bounced",
                "spam/drop/undesirable",
                "for_emergency_use_only/drop/unspecified",
                "fosnr_hateful_conduct/drop/undesirable",
                "fosnr_violent_speech/drop/undesirable",
                "fosnr_abuse/drop/undesirable",
                "fosnr_civic_integrity/drop/undesirable",
                "stale_tweet/drop/unspecified",
                "legal_takedown/drop/unspecified",
                "local_laws_takedown/drop/unspecified",
                "sensitive_viewer_logged_out/drop",
                "sensitive_viewer_underage/drop",
                "sensitive_viewer_no_stated_age/drop",
                "exclusive_tweet/drop",
                "dmca_media/drop/unspecified",
                "geo_restricted_media/drop/unspecified",
                "gore_and_violence_high_precision/drop/nsfw_media",
                "do_not_amplify/drop/undesirable",
                "malicious_url/drop/undesirable",
                "spam_high_recall/drop/undesirable",
                "brazil_election_legal/drop/undesirable",
                "spam_high_recall_user_label/drop/unspecified",
                "compromised_user_label/drop/unspecified",
                "read_only_user_label/drop/unspecified",
                "impersonation_high_precision_user_label/drop/unspecified",
                "abusive_high_recall_user_label/drop/unspecified",
                "do_not_amplify_user_label/drop/unspecified",
                "nsfw_sensitive_viewer_tweet/drop/nsfw_media",
                "nsfw_sensitive_viewer_user/drop/nsfw_media",
            ]
        );
    }

    #[test]
    #[should_panic(expected = "a rule reads Follows")]
    fn a_rule_reading_an_underived_hydrator_panics_in_tests() {
        let viewer = viewer(VIEWER_ID);
        let candidate = candidate().build();
        let context = test_context(&viewer, &candidate)
            .hydrated_by(Hydrators::all().without(Hydrator::Follows));
        context.edge(Hydrator::Follows);
    }

    #[test]
    fn every_leaf_reads_only_the_hydrators_it_declares() {
        let viewer = viewer(VIEWER_ID);
        let candidate = candidate().build();
        for &level in SafetyLevel::VARIANTS {
            for clause in RuleEngine::clauses(level) {
                for condition in &clause.when {
                    let leaves = match condition {
                        Condition::Holds(leaf) | Condition::Not(leaf) => slice::from_ref(leaf),
                        Condition::AnyOf(leaves) => leaves,
                    };
                    for &leaf in leaves {
                        holds_narrowed(leaf, &viewer, &candidate);
                    }
                }
            }
        }
    }

    mod engine {
        use super::super::*;
        use crate::hydration::Hydrator;
        use crate::models::{
            DropReason, HydratedTweetCandidate, LimitedEngagementReason, MediaInterstitial,
            MediaRestriction, TombstoneReason, ViewerFeatures,
        };
        use crate::rules::fixtures::{allow, blurred};
        use crate::rules::rule_spec::{
            ActionSpec, Audience, Condition, Predicate, RelationshipPredicate, TweetPredicate,
            ViewerPredicate,
        };
        use crate::rules::test_context;
        use xai_visibility_filtering::models::FilteredReason;
        use xai_x_thrift::action::InterstitialReason;

        fn clause(when: &[Condition], action: ActionSpec) -> RuleClause {
            RuleClause {
                id: RuleId::FilterAll,
                when: when.to_vec(),
                applies_to: Audience::Everyone,
                action,
            }
        }

        fn always(name: &'static str, action: ActionSpec) -> (&'static str, RuleClause) {
            (name, clause(&[], action))
        }

        const NEVER_LEAF: Predicate = Predicate::Tweet(TweetPredicate::CreatedAfter(u64::MAX));
        const NEVER: Condition = Condition::Holds(NEVER_LEAF);

        const FOLLOWS: Predicate =
            Predicate::Relationship(RelationshipPredicate::ViewerFollowsAuthor);
        const BLOCKS: Predicate =
            Predicate::Relationship(RelationshipPredicate::ViewerBlocksAuthor);
        const LOGGED_OUT: Predicate = Predicate::Viewer(ViewerPredicate::LoggedOut);

        const UNREACHABLE: Condition = Condition::Holds(FOLLOWS);

        const DROP_SUSPENDED: ActionSpec =
            ActionSpec::Drop(DropReason::Legacy(FilteredReason::AuthorIsSuspended));
        const TOMBSTONE: ActionSpec = ActionSpec::Tombstone(TombstoneReason::LocalRegulations);
        const INTERSTITIAL_NSFW: ActionSpec =
            ActionSpec::MediaRestriction(MediaRestriction::MediaInterstitial(MediaInterstitial {
                legacy: FilteredReason::ContainNsfwMedia,
                reason: InterstitialReason::Sensitive(true),
                prompt: None,
            }));
        const INTERSTITIAL_UNSPECIFIED: ActionSpec =
            ActionSpec::MediaRestriction(MediaRestriction::MediaInterstitial(MediaInterstitial {
                legacy: FilteredReason::UnspecifiedReason,
                reason: InterstitialReason::Nudity(true),
                prompt: None,
            }));
        const LIMIT: ActionSpec =
            ActionSpec::LimitedEngagement(LimitedEngagementReason::ConversationControl);

        fn context_inputs() -> (ViewerFeatures, HydratedTweetCandidate) {
            (ViewerFeatures::default(), HydratedTweetCandidate::default())
        }

        fn withheld(value: Withholding, by: &'static str) -> Verdict {
            Verdict::Withheld(Decided { value, by })
        }

        fn tombstone_first() -> Policy {
            Policy::new(vec![
                always("tombstone", TOMBSTONE),
                ("never", clause(&[NEVER], DROP_SUSPENDED)),
                always("drop", DROP_SUSPENDED),
                ("after_drop", clause(&[UNREACHABLE], DROP_SUSPENDED)),
            ])
        }

        fn restrictions() -> Policy {
            Policy::new(vec![
                always("first_interstitial", INTERSTITIAL_NSFW),
                always("first_limit", LIMIT),
                always("second_interstitial", INTERSTITIAL_UNSPECIFIED),
                always(
                    "second_limit",
                    ActionSpec::LimitedEngagement(LimitedEngagementReason::BlockedViewer),
                ),
                always("third_limit", LIMIT),
            ])
        }

        #[test]
        fn the_most_severe_terminal_returns_before_later_rules() {
            let (viewer, candidate) = context_inputs();
            let context = test_context(&viewer, &candidate)
                .hydrated_by(Hydrators::all().without(Hydrator::Follows));

            assert_eq!(
                tombstone_first().evaluate(&context).verdict,
                withheld(
                    Withholding::Drop(DropReason::Legacy(FilteredReason::AuthorIsSuspended)),
                    "drop"
                )
            );
        }

        #[test]
        #[should_panic(expected = "is wired twice")]
        fn an_identity_recurring_after_another_fails_construction() {
            Policy::new(vec![
                always("blur", INTERSTITIAL_NSFW),
                always("other_blur", INTERSTITIAL_UNSPECIFIED),
                always("blur", INTERSTITIAL_NSFW),
            ]);
        }

        #[test]
        #[should_panic(expected = "derive filter_all/blur/sensitive")]
        fn two_identities_deriving_one_name_fail_construction() {
            let blur = |legacy| {
                ActionSpec::MediaRestriction(MediaRestriction::MediaInterstitial(
                    MediaInterstitial {
                        legacy,
                        reason: InterstitialReason::Sensitive(true),
                        prompt: None,
                    },
                ))
            };
            let mut names = Vec::new();
            interned_name(
                &mut names,
                &clause(&[], blur(FilteredReason::ContainNsfwMedia)),
            );
            interned_name(
                &mut names,
                &clause(&[], blur(FilteredReason::UnspecifiedReason)),
            );
        }

        #[test]
        #[should_panic(expected = "is wired twice")]
        fn a_clause_repeated_within_its_run_fails_construction() {
            Policy::new(vec![
                always("blur", INTERSTITIAL_NSFW),
                always("blur", INTERSTITIAL_NSFW),
            ]);
        }

        #[test]
        fn the_media_slot_keeps_its_first_value_and_the_engagement_slot_each_reason_once() {
            let (viewer, candidate) = context_inputs();

            let Verdict::Shown {
                media,
                engagement: Some(limit),
            } = restrictions()
                .evaluate(&test_context(&viewer, &candidate))
                .verdict
            else {
                panic!("expected a limited verdict");
            };

            assert_eq!(
                media,
                Some(Decided {
                    value: MediaRestriction::MediaInterstitial(MediaInterstitial {
                        legacy: FilteredReason::ContainNsfwMedia,
                        reason: InterstitialReason::Sensitive(true),
                        prompt: None,
                    }),
                    by: "first_interstitial",
                })
            );
            assert_eq!(limit.by, "first_limit");
            assert_eq!(
                limit.value.reasons().collect::<Vec<_>>(),
                [
                    LimitedEngagementReason::ConversationControl,
                    LimitedEngagementReason::BlockedViewer,
                ]
            );
        }

        fn follows_and_blocks_failed() -> (ViewerFeatures, HydratedTweetCandidate) {
            let candidate = HydratedTweetCandidate {
                failed: Hydrators::of(Hydrator::Follows).with(Hydrator::Blocks),
                ..HydratedTweetCandidate::default()
            };
            (ViewerFeatures::default(), candidate)
        }

        #[test]
        fn clauses_combine_in_three_values_and_unknown_resolves_to_the_default() {
            let (viewer, candidate) = follows_and_blocks_failed();
            let follows = Hydrators::of(Hydrator::Follows);
            let dropped = withheld(
                Withholding::Drop(DropReason::Legacy(FilteredReason::AuthorIsSuspended)),
                "rule",
            );
            let rows: [(&[Condition], Verdict, Hydrators); 6] = [
                (&[Condition::Holds(FOLLOWS)], allow(), follows),
                (
                    &[Condition::Holds(FOLLOWS), NEVER],
                    allow(),
                    Hydrators::empty(),
                ),
                (&[Condition::Not(FOLLOWS)], dropped.clone(), follows),
                (
                    &[Condition::AnyOf(&[FOLLOWS, LOGGED_OUT])],
                    dropped,
                    Hydrators::empty(),
                ),
                (
                    &[Condition::AnyOf(&[FOLLOWS, NEVER_LEAF])],
                    allow(),
                    follows,
                ),
                (
                    &[
                        Condition::AnyOf(&[BLOCKS, LOGGED_OUT]),
                        Condition::Holds(FOLLOWS),
                    ],
                    allow(),
                    follows,
                ),
            ];
            for (index, (when, verdict, rested_on)) in rows.into_iter().enumerate() {
                let evaluation = Policy::new(vec![("rule", clause(when, DROP_SUSPENDED))])
                    .evaluate(&test_context(&viewer, &candidate));
                assert_eq!(
                    (evaluation.verdict, evaluation.rested_on),
                    (verdict, rested_on),
                    "row {index}"
                );
            }
        }

        #[test]
        fn a_verdict_rests_on_the_unknown_clauses_that_could_have_changed_it() {
            let (viewer, candidate) = follows_and_blocks_failed();
            let follows = Hydrators::of(Hydrator::Follows);
            let unknown = |action| ("unknown", clause(&[Condition::Holds(FOLLOWS)], action));
            let blur = blurred(InterstitialReason::Sensitive(true), "blur");
            let rows = [
                (
                    [unknown(DROP_SUSPENDED), always("drop", DROP_SUSPENDED)],
                    withheld(
                        Withholding::Drop(DropReason::Legacy(FilteredReason::AuthorIsSuspended)),
                        "drop",
                    ),
                    follows,
                ),
                (
                    [unknown(INTERSTITIAL_NSFW), always("drop", DROP_SUSPENDED)],
                    withheld(
                        Withholding::Drop(DropReason::Legacy(FilteredReason::AuthorIsSuspended)),
                        "drop",
                    ),
                    Hydrators::empty(),
                ),
                (
                    [
                        always("blur", INTERSTITIAL_NSFW),
                        unknown(INTERSTITIAL_UNSPECIFIED),
                    ],
                    blur.clone(),
                    Hydrators::empty(),
                ),
                (
                    [always("blur", INTERSTITIAL_NSFW), unknown(LIMIT)],
                    blur,
                    follows,
                ),
            ];
            for (index, (rules, verdict, rested_on)) in rows.into_iter().enumerate() {
                let evaluation =
                    Policy::new(rules.into()).evaluate(&test_context(&viewer, &candidate));
                assert_eq!(
                    (evaluation.verdict, evaluation.rested_on),
                    (verdict, rested_on),
                    "row {index}"
                );
            }
        }
    }
}
