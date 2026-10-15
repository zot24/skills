> Source: https://raw.githubusercontent.com/xai-org/x-algorithm/main/visibility-filtering/rules/registry.rs

use crate::hydration::{Hydration, HydrationPlan, Hydrators};
use crate::models::{
    Decided, Evaluation, LimitedEngagement, MediaRestriction, Notice, PostCandidate, TweetId,
    Verdict, ViewerFeatures,
};
use crate::params::CountryLists;
use crate::rules::rule_spec::inputs::EvaluateInputs;
use crate::rules::rule_spec::observed::{self, NoTrace, NodeObserver, NodeTrace, NodeTracer, Skip};
use crate::rules::rule_spec::rule::{self, Rule, RuleCond};
use crate::rules::rule_spec::{rule_name, ActionSpec, Contribution, RuleAction, RuleId, Truth};
use crate::rules::{RuleContext, SafetyLevel};
use std::borrow::Cow;
use std::cmp::Reverse;
use std::sync::Arc;
use strum::VariantArray;

pub(super) struct Policy {
    rules: Vec<(&'static str, Rule)>,
    hydrators: Hydrators,
}

impl Policy {
    #[expect(
        clippy::panic,
        reason = "invalid authored rules fail startup, before the service takes traffic"
    )]
    pub(super) fn new(mut rules: Vec<(&'static str, Rule)>) -> Self {
        if let Err(error) = rule::validate(rules.iter().map(|(_, rule)| rule)) {
            panic!("invalid rules: {error:?}");
        }
        rules.sort_by_key(|(_, rule)| Reverse(rule.action.spec().severity()));
        let mut runs: Vec<&'static str> = Vec::new();
        let mut run: Vec<&Rule> = Vec::new();
        for (name, rule) in &rules {
            if runs.last() != Some(name) {
                assert!(!runs.contains(name), "{name} is wired twice");
                runs.push(name);
                run.clear();
            }
            assert!(!run.contains(&rule), "{name} is wired twice");
            run.push(rule);
        }
        let hydrators = rules
            .iter()
            .fold(Hydrators::empty(), |hydrators, (_, rule)| {
                hydrators.union(rule.requirements())
            });
        Self { rules, hydrators }
    }

    pub(super) fn evaluate(&self, context: &RuleContext<'_>) -> Evaluation {
        fold(&self.rules, context, &mut NoTrace)
    }

    fn rule_names(&self) -> Vec<&'static str> {
        let mut names: Vec<&'static str> = self.rules.iter().map(|&(name, _)| name).collect();
        names.dedup();
        names
    }

    fn len(&self) -> usize {
        self.rule_names().len()
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Effect {
    DidNotApply,
    Decided,
    AfterTerminal,
    FilledMedia,
    KeptEarlierMedia,
    KeptEarlierMediaInsteadOfNotice,
    FilledEngagement,
    AddedEngagementReason,
    DuplicateEngagementReason,
}

type Completed = (Option<Contribution>, Hydrators);

#[derive(Clone, Copy)]
pub(super) enum Bucket {
    Withholding,
    Slot,
}

pub(super) trait PolicyObserver: NodeObserver {
    fn row(
        &mut self,
        by: &'static str,
        root: Self::Handle,
        truth: Truth,
        effect: Effect,
        defaults_admitted: (Bucket, Hydrators),
        completed: Option<Completed>,
    );

    fn retained(&mut self, withholding_defaults: Hydrators, slot_defaults: Hydrators);
}

impl PolicyObserver for NoTrace {
    #[inline]
    fn row(
        &mut self,
        _: &'static str,
        (): (),
        _: Truth,
        _: Effect,
        _: (Bucket, Hydrators),
        _: Option<Completed>,
    ) {
    }

    #[inline]
    fn retained(&mut self, _: Hydrators, _: Hydrators) {}
}

#[inline]
fn fold<O: PolicyObserver>(
    rules: &[(&'static str, Rule)],
    context: &RuleContext<'_>,
    observer: &mut O,
) -> Evaluation {
    let mut decision = Decision::default();
    let mut terminal: Option<(usize, Verdict)> = None;
    for (occurrence, (by, rule)) in rules.iter().enumerate() {
        let after = terminal.as_ref().map(|&(decided, ..)| decided);
        if after.is_some() && !O::TOTAL {
            break;
        }
        let (truth, root) = observed::evaluate_rule(rule, context, observer, after);
        if !O::TOTAL && truth == Truth::False {
            continue;
        }
        let action = rule.action.spec();
        let completed = (truth.resolves_true()
            && (O::TOTAL || (after.is_none() && decision.suppressed(action).is_none())))
        .then(|| action.interpret(&EvaluateInputs(context)));
        let diagnostic = if O::TOTAL {
            completed
                .as_ref()
                .map(|completed| (completed.value.clone(), completed.failed))
        } else {
            None
        };
        let (effect, defaults_admitted) = if after.is_some() {
            (
                Effect::AfterTerminal,
                (Bucket::Withholding, Hydrators::empty()),
            )
        } else {
            let contribution = completed.and_then(|completed| completed.value);
            let (selected, effect, admitted) = decision.step(by, action, truth, contribution);
            if let Some(verdict) = selected {
                terminal = Some((occurrence, verdict));
            }
            (effect, admitted)
        };
        observer.row(by, root, truth, effect, defaults_admitted, diagnostic);
    }
    observer.retained(decision.withholding_defaults, decision.slot_defaults);
    let fail_open_defaults = decision.withholding_defaults.union(decision.slot_defaults);
    let verdict = match terminal {
        Some((_, verdict)) => verdict,
        None => decision.finish(),
    };
    if context.failed().is_empty() {
        debug_assert!(
            fail_open_defaults.is_empty(),
            "a verdict over no failed node relies on no default"
        );
        Evaluation::Complete { verdict }
    } else {
        Evaluation::Partial {
            verdict,
            fail_open_defaults,
        }
    }
}

#[derive(Default)]
struct Decision {
    media: Option<Decided<MediaRestriction>>,
    engagement: Option<Decided<LimitedEngagement>>,
    withholding_defaults: Hydrators,
    slot_defaults: Hydrators,
}

impl Decision {
    fn suppressed(&self, action: &ActionSpec) -> Option<Effect> {
        self.media.as_ref()?;
        match action {
            ActionSpec::MediaRestriction(_) => Some(Effect::KeptEarlierMedia),
            ActionSpec::SoftIntervention { .. } => Some(Effect::KeptEarlierMediaInsteadOfNotice),
            ActionSpec::Appealable(_)
            | ActionSpec::Drop(_)
            | ActionSpec::Tombstone(_)
            | ActionSpec::LimitedEngagement(_) => None,
        }
    }

    #[inline]
    fn step(
        &mut self,
        by: &'static str,
        action: &ActionSpec,
        truth: Truth,
        contribution: Option<Contribution>,
    ) -> (Option<Verdict>, Effect, (Bucket, Hydrators)) {
        let unknown_reads = match truth {
            Truth::Unknown { failed, .. } => failed,
            Truth::True | Truth::False => Hydrators::empty(),
        };
        let admitted = match action {
            ActionSpec::Appealable(_) | ActionSpec::Drop(_) | ActionSpec::Tombstone(_) => {
                self.withholding_defaults = self.withholding_defaults.union(unknown_reads);
                (Bucket::Withholding, unknown_reads)
            }
            ActionSpec::MediaRestriction(_) | ActionSpec::SoftIntervention { .. }
                if self.suppressed(action).is_none() =>
            {
                self.slot_defaults = self.slot_defaults.union(unknown_reads);
                (Bucket::Slot, unknown_reads)
            }
            ActionSpec::LimitedEngagement(_) if self.engagement.is_none() => {
                self.slot_defaults = self.slot_defaults.union(unknown_reads);
                (Bucket::Slot, unknown_reads)
            }
            ActionSpec::MediaRestriction(_)
            | ActionSpec::SoftIntervention { .. }
            | ActionSpec::LimitedEngagement(_) => (Bucket::Slot, Hydrators::empty()),
        };
        if !truth.resolves_true() {
            return (None, Effect::DidNotApply, admitted);
        }
        if let Some(effect) = self.suppressed(action) {
            return (None, effect, admitted);
        }
        let (terminal, effect) = match contribution {
            None => (None, Effect::DidNotApply),
            Some(Contribution::Withholding(value)) => {
                self.slot_defaults = Hydrators::empty();
                (
                    Some(Verdict::Withheld(Decided { value, by })),
                    Effect::Decided,
                )
            }
            Some(Contribution::Media(value)) => {
                self.media = Some(Decided { value, by });
                (None, Effect::FilledMedia)
            }
            Some(Contribution::Engagement(reason)) => {
                let effect = match &mut self.engagement {
                    None => {
                        self.engagement = Some(Decided {
                            value: LimitedEngagement::new(reason),
                            by,
                        });
                        Effect::FilledEngagement
                    }
                    Some(limit) => {
                        if limit.value.add(reason) {
                            Effect::AddedEngagementReason
                        } else {
                            Effect::DuplicateEngagementReason
                        }
                    }
                };
                (None, effect)
            }
            Some(Contribution::Notice(notice)) => {
                match notice {
                    Notice::Appealable { .. } => self.slot_defaults = Hydrators::empty(),
                    Notice::SoftIntervention(_) => {}
                }
                (
                    Some(Verdict::Shown {
                        notice: Some(Decided { value: notice, by }),
                        media: None,
                        engagement: None,
                    }),
                    Effect::Decided,
                )
            }
        };
        (terminal, effect, admitted)
    }

    fn finish(self) -> Verdict {
        Verdict::Shown {
            notice: None,
            media: self.media,
            engagement: self.engagement,
        }
    }
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
    names: &mut Vec<(RuleId, RuleAction, &'static str)>,
    id: RuleId,
    action: &RuleAction,
) -> &'static str {
    if let Some(&(_, _, name)) = names
        .iter()
        .find(|(other_id, other_action, _)| *other_id == id && other_action == action)
    {
        return name;
    }
    let name: &'static str = rule_name(id, action).leak();
    if let Some((other_id, other_action, _)) = names.iter().find(|&&(_, _, other)| other == name) {
        panic!("{other_id:?} {other_action:?} and {id:?} {action:?} derive {name}");
    }
    names.push((id, action.clone(), name));
    name
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum AdmissionError {
    MissingInputs(Hydrators),
}

pub(super) struct Admitted<'a> {
    policy: &'a Policy,
    viewer: &'a ViewerFeatures,
    country_lists: &'a CountryLists,
}

impl Admitted<'_> {
    fn context<'c>(&'c self, candidate: &'c PostCandidate) -> RuleContext<'c> {
        let context = RuleContext::new(self.viewer, candidate, self.country_lists);
        #[cfg(test)]
        let context = context.hydrated_by(self.policy.hydrators);
        context
    }
}

pub(crate) struct AdmittedPosts<'a> {
    admitted: Admitted<'a>,
    hydration: &'a Hydration,
}

impl AdmittedPosts<'_> {
    pub(crate) fn post(&self, tweet_id: TweetId, copied: bool) -> Option<AdmittedPost<'_>> {
        Some(AdmittedPost {
            admitted: &self.admitted,
            candidate: self.hydration.candidate(tweet_id, copied)?,
        })
    }
}

pub(crate) struct AdmittedPost<'a> {
    admitted: &'a Admitted<'a>,
    candidate: Cow<'a, PostCandidate>,
}

impl AdmittedPost<'_> {
    pub(crate) fn evaluate(&self) -> Evaluation {
        self.admitted
            .policy
            .evaluate(&self.admitted.context(&self.candidate))
    }

    pub(crate) fn trace(&self) -> PolicyTrace {
        self.admitted
            .policy
            .trace(&self.admitted.context(&self.candidate))
    }
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
                let policy = Policy::new(
                    level
                        .spec()
                        .rules
                        .iter()
                        .map(|&rule| {
                            (
                                interned_name(&mut names, rule.id, &rule.action),
                                rule.clone(),
                            )
                        })
                        .collect(),
                );
                let plan = HydrationPlan::new(level, policy.hydrators);
                Level { policy, plan }
            })
            .collect();
        Self {
            country_lists,
            levels,
        }
    }

    pub(crate) fn admit<'a>(
        &'a self,
        level: SafetyLevel,
        hydration: &'a Hydration,
    ) -> Result<AdmittedPosts<'a>, AdmissionError> {
        let policy = self.policy(level);
        let viewer = hydration.viewer();
        let logged_in = viewer.viewer.user_id().is_some();
        let required = policy
            .hydrators
            .iter()
            .filter(|&node| logged_in || !node.needs_viewer())
            .fold(Hydrators::empty(), Hydrators::with);
        let missing = required.difference(hydration.planned());
        if !missing.is_empty() {
            return Err(AdmissionError::MissingInputs(missing));
        }
        Ok(AdmittedPosts {
            admitted: Admitted {
                policy,
                viewer,
                country_lists: &self.country_lists,
            },
            hydration,
        })
    }

    #[cfg(test)]
    pub(crate) fn evaluate(
        &self,
        level: SafetyLevel,
        viewer: &ViewerFeatures,
        candidate: &PostCandidate,
    ) -> Evaluation {
        let policy = self.policy(level);
        let context =
            RuleContext::new(viewer, candidate, &self.country_lists).hydrated_by(policy.hydrators);
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
        self.policy(level).rule_names()
    }

    pub fn rule_counts(&self) -> (usize, usize) {
        (
            self.policy(SafetyLevel::TimelineHome).len(),
            self.policy(SafetyLevel::TimelineHomeRecommendations).len(),
        )
    }
}

#[derive(Clone, Debug, PartialEq)]
pub struct PolicyTrace {
    pub evaluation: Evaluation,
    pub nodes: Vec<NodeTrace>,
    pub rows: Vec<RowTrace>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct RowTrace {
    pub by: &'static str,
    pub root: usize,
    pub truth: Truth,
    pub effect: Effect,
    pub defaults_admitted: Hydrators,
    pub defaults_retained: Hydrators,
    pub completed: Option<Completed>,
}

#[derive(Default)]
struct Total {
    tracer: NodeTracer,
    rows: Vec<(Bucket, RowTrace)>,
}

impl NodeObserver for Total {
    const TOTAL: bool = true;
    type Handle = usize;

    fn enter(
        &mut self,
        node: Option<RuleCond>,
        parent: Option<usize>,
        skip: Option<Skip<usize>>,
    ) -> usize {
        self.tracer.enter(node, parent, skip)
    }

    fn finish(&mut self, handle: usize, truth: Truth) {
        self.tracer.finish(handle, truth);
    }
}

impl PolicyObserver for Total {
    fn row(
        &mut self,
        by: &'static str,
        root: usize,
        truth: Truth,
        effect: Effect,
        (bucket, defaults_admitted): (Bucket, Hydrators),
        completed: Option<Completed>,
    ) {
        self.rows.push((
            bucket,
            RowTrace {
                by,
                root,
                truth,
                effect,
                defaults_admitted,
                defaults_retained: Hydrators::empty(),
                completed,
            },
        ));
    }

    fn retained(&mut self, withholding_defaults: Hydrators, slot_defaults: Hydrators) {
        for (bucket, row) in &mut self.rows {
            let retained = match bucket {
                Bucket::Withholding => withholding_defaults,
                Bucket::Slot => slot_defaults,
            };
            row.defaults_retained = row.defaults_admitted.intersection(retained);
        }
    }
}

impl Policy {
    pub(super) fn trace(&self, context: &RuleContext<'_>) -> PolicyTrace {
        let mut total = Total::default();
        let evaluation = fold(&self.rules, context, &mut total);
        PolicyTrace {
            evaluation,
            nodes: total.tracer.nodes,
            rows: total.rows.into_iter().map(|(_, row)| row).collect(),
        }
    }
}

#[cfg(test)]
impl RuleEngine {
    pub(super) fn trace(
        &self,
        level: SafetyLevel,
        viewer: &ViewerFeatures,
        candidate: &PostCandidate,
    ) -> PolicyTrace {
        let policy = self.policy(level);
        policy.trace(
            &RuleContext::new(viewer, candidate, &self.country_lists).hydrated_by(policy.hydrators),
        )
    }

    pub(super) fn with_level_for_tests(
        level: SafetyLevel,
        rules: Vec<(&'static str, Rule)>,
    ) -> Self {
        let mut engine = Self::for_tests();
        let policy = Policy::new(rules);
        let plan = HydrationPlan::new(level, policy.hydrators);
        engine.levels[level as usize] = Level { policy, plan };
        engine
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::hydration::Hydrator;
    use crate::models::Withholding;
    use crate::models::{
        AuthorFeatures, ClientCapability, DropReason, NsfwViewerDropReason, SafetyLabelType,
        VerifyBlurSupport, ViewerAge, ViewerProfile,
    };
    use crate::rules::fixtures::{
        candidate, viewer, viewer_with_profile, CandidateBuilder, VIEWER_ID,
    };
    use crate::rules::legacy_table::legacy_table;
    use crate::rules::rule_spec::rule::RuleCond;
    use crate::rules::rule_spec::spelled_label;
    use crate::rules::{test_context, tweet_rules};

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
            .into_verdict();
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
            .into_verdict();
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
    fn a_failed_article_lookup_is_a_partial_drop() {
        use crate::models::TweetFeatures;
        use crate::rules::fixtures::dropped;
        use std::num::NonZeroU64;
        use xai_visibility_filtering::models::FilteredReason;

        let mut candidate = candidate()
            .with_tweet_features(TweetFeatures {
                article_id: NonZeroU64::new(1),
                ..TweetFeatures::default()
            })
            .build();
        candidate.failed = Hydrators::of(Hydrator::ArticleLifecycle);
        assert_eq!(
            RuleEngine::for_tests().evaluate(
                SafetyLevel::TimelineHomeHydration,
                &viewer(VIEWER_ID),
                &candidate,
            ),
            Evaluation::Partial {
                verdict: dropped(
                    FilteredReason::UnspecifiedReason,
                    "article_tweet_content/drop/unspecified",
                ),
                fail_open_defaults: Hydrators::of(Hydrator::ArticleLifecycle),
            }
        );
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
                community_viewer_removed_limits: true,
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
            .into_verdict()
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

    const PINNED_POLICIES: [(SafetyLevel, &str); 5] = [
        (
            SafetyLevel::FilterAll,
            include_str!("../../tests/fixtures/policy/filter_all.txt"),
        ),
        (
            SafetyLevel::TimelineHome,
            include_str!("../../tests/fixtures/policy/timeline_home.txt"),
        ),
        (
            SafetyLevel::TimelineHomeRecommendations,
            include_str!("../../tests/fixtures/policy/timeline_home_recommendations.txt"),
        ),
        (
            SafetyLevel::TimelineHomeHydration,
            include_str!("../../tests/fixtures/policy/timeline_home_hydration.txt"),
        ),
        (
            SafetyLevel::ImmersiveExpandedRecommendations,
            include_str!("../../tests/fixtures/policy/immersive_expanded_recommendations.txt"),
        ),
    ];

    #[test]
    fn each_level_evaluates_its_pinned_policy() {
        let rule_engine = RuleEngine::for_tests();
        let mut stale = Vec::new();
        for &level in SafetyLevel::VARIANTS {
            let file = format!("{}.txt", <&str>::from(level));
            let table = legacy_table(&rule_engine.policy(level).rules)
                .unwrap_or_else(|error| panic!("{level:?} has no legacy table: {error:?}"));
            let pinned = PINNED_POLICIES
                .iter()
                .find(|&&(pinned_level, _)| pinned_level == level)
                .map(|&(_, pinned)| pinned);
            if pinned != Some(table.as_str()) {
                if let Ok(dir) = std::env::var("TEST_UNDECLARED_OUTPUTS_DIR") {
                    std::fs::write(std::path::Path::new(&dir).join(&file), &table).unwrap();
                }
                stale.push(file);
            }
        }
        assert!(
            stale.is_empty(),
            "tests/fixtures/policy/{stale:?} differ from the evaluated policies: run scripts/bless-policy and review the diff"
        );
    }

    #[test]
    #[should_panic(expected = "a rule reads Follows")]
    fn a_rule_reading_an_underived_hydrator_panics_in_tests() {
        let viewer = viewer(VIEWER_ID);
        let candidate = candidate().build();
        let context = test_context(&viewer, &candidate)
            .hydrated_by(Hydrators::all().without(Hydrator::Follows));
        context.acquire_edge(Hydrator::Follows);
    }

    #[test]
    fn each_rule_name_wires_the_same_rules_at_every_level() {
        const WIRED_DIFFERENTLY: [&str; 6] = [
            "nsfw_high_precision/blur/nudity",
            "nsfw_high_precision/blur/sensitive",
            "gore_and_violence_high_precision/blur",
            "nsfw_card_image/blur/sensitive",
            "nsfw_admin/blur/sensitive",
            "nsfw_user/blur/sensitive_user",
        ];
        let rule_engine = RuleEngine::for_tests();
        let mut first: Vec<(&str, SafetyLevel, Vec<&Rule>)> = Vec::new();
        for &level in SafetyLevel::VARIANTS {
            for name in rule_engine.policy(level).rule_names() {
                let rules: Vec<&Rule> = rule_engine
                    .policy(level)
                    .rules
                    .iter()
                    .filter(|&&(other, _)| other == name)
                    .map(|(_, rule)| rule)
                    .collect();
                match first.iter().find(|(other, ..)| *other == name) {
                    None => first.push((name, level, rules)),
                    Some((_, first_level, wired)) => assert!(
                        *wired == rules || WIRED_DIFFERENTLY.contains(&name),
                        "{name} wires other rules at {level:?} than at {first_level:?}: \
                         wire the same rules at every level, or give the {level:?} \
                         rules their own RuleId"
                    ),
                }
            }
        }
    }

    #[test]
    fn each_rule_of_a_rule_id_names_the_same_labels() {
        let mut first: Vec<(RuleId, String, Vec<String>)> = Vec::new();
        for &level in SafetyLevel::VARIANTS {
            for rule in level.spec().rules {
                let mut labels: Vec<String> = rule
                    .when
                    .conjuncts()
                    .iter()
                    .filter_map(|condition| condition.own_tweet_label())
                    .collect();
                labels.sort_unstable();
                let name = rule.name();
                match first.iter().find(|(id, ..)| *id == rule.id) {
                    None => first.push((rule.id, name, labels)),
                    Some((_, other, read)) => assert!(
                        *read == labels,
                        "{name} names the labels {labels:?} but {other}, a rule of the same \
                         RuleId, names {read:?}: copy the label conditions of {other}, or give it \
                         its own RuleId"
                    ),
                }
            }
        }
    }

    #[test]
    fn each_fosnr_violation_has_a_label_drop_and_each_fosnr_label_drop_a_violation() {
        let rule_engine = RuleEngine::for_tests();
        let mut dropped = Vec::new();
        for &level in SafetyLevel::VARIANTS {
            for (name, rule) in &rule_engine.policy(level).rules {
                let id: &str = rule.id.into();
                let RuleCond::All([only]) = rule.when else {
                    continue;
                };
                let [label] = only.positive_tweet_labels()[..] else {
                    continue;
                };
                if !id.starts_with("fosnr") {
                    continue;
                }
                assert!(
                    tweet_rules::FOSNR_AUTHOR_VIOLATIONS
                        .iter()
                        .any(|violation| violation.label == label),
                    "{name} drops a FOSNR label FOSNR_AUTHOR_VIOLATIONS does not name: add its \
                     row to FOSNR_AUTHOR_VIOLATIONS in src/rules/tweet_rules.rs"
                );
                dropped.push(label);
            }
        }
        for violation in &tweet_rules::FOSNR_AUTHOR_VIOLATIONS {
            assert!(
                dropped.contains(&violation.label),
                "FOSNR_AUTHOR_VIOLATIONS names {:?} but no level drops it: add a `const \
                 FOSNR_<LABEL>_DROP_UNDESIRABLE: Rule` reading it and list it in the levels",
                xai_safety_label_store::types::label_meta(violation.label).map(|meta| meta.ident),
            );
        }
    }

    #[test]
    fn a_notice_reads_the_labels_it_names() {
        let rule_engine = RuleEngine::for_tests();
        for &level in SafetyLevel::VARIANTS {
            for (name, rule) in &rule_engine.policy(level).rules {
                let mut read = rule.when.positive_tweet_labels();
                let mut named: Vec<SafetyLabelType> = match rule.action.spec() {
                    ActionSpec::SoftIntervention { label, .. } => vec![*label],
                    ActionSpec::Appealable(violations) => {
                        violations.iter().map(|violation| violation.label).collect()
                    }
                    ActionSpec::Drop(_)
                    | ActionSpec::Tombstone(_)
                    | ActionSpec::MediaRestriction(_)
                    | ActionSpec::LimitedEngagement(_) => continue,
                };
                read.sort_by_key(|label| label.0);
                named.sort_by_key(|label| label.0);
                assert!(
                    read == named,
                    "{name} names {:?} but its conditions read {:?}: make `when` read exactly the \
                     labels its action names",
                    named.into_iter().map(spelled_label).collect::<Vec<_>>(),
                    read.into_iter().map(spelled_label).collect::<Vec<_>>(),
                );
            }
        }
    }

    mod engine {
        use super::super::*;
        use crate::hydration::Hydrator;
        use crate::models::Withholding;
        use crate::models::{
            DropReason, LimitedEngagementReason, MediaInterstitial, MediaRestriction,
            PostCandidate, TombstoneReason, ViewerFeatures,
        };
        use crate::rules::fixtures::{
            allow, author_viewer, blurred, candidate, logged_out_viewer, viewer, VIEWER_ID,
        };
        use crate::rules::rule_spec::leaves::*;
        use crate::rules::rule_spec::rule::Audience::{Everyone, NonFollowers};
        use crate::rules::rule_spec::rule::{all, any, RuleCond};
        use crate::rules::rule_spec::ActionSpec;
        use crate::rules::test_context;
        use xai_visibility_filtering::models::FilteredReason;
        use xai_x_thrift::action::InterstitialReason;

        fn rule(when: RuleCond, action: ActionSpec) -> Rule {
            Rule {
                id: RuleId::FilterAll,
                audience: Everyone,
                when,
                action: action.into(),
            }
        }

        fn always(name: &'static str, action: ActionSpec) -> (&'static str, Rule) {
            (name, rule(all![], action))
        }

        const NEVER: RuleCond = TweetCreatedAfter(u64::MAX).leaf();

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

        fn context_inputs() -> (ViewerFeatures, PostCandidate) {
            (ViewerFeatures::default(), PostCandidate::default())
        }

        fn withheld(value: Withholding, by: &'static str) -> Verdict {
            Verdict::Withheld(Decided { value, by })
        }

        fn tombstone_first() -> Policy {
            Policy::new(vec![
                always("tombstone", TOMBSTONE),
                ("never", rule(NEVER, DROP_SUSPENDED)),
                always("drop", DROP_SUSPENDED),
                (
                    "after_drop",
                    rule(ViewerFollowsAuthor.leaf(), DROP_SUSPENDED),
                ),
            ])
        }

        #[test]
        fn the_most_severe_terminal_returns_before_later_rules() {
            let (viewer, candidate) = context_inputs();
            let context = test_context(&viewer, &candidate)
                .hydrated_by(Hydrators::all().without(Hydrator::Follows));

            assert_eq!(
                tombstone_first().evaluate(&context).into_verdict(),
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
            for reason in [
                FilteredReason::ContainNsfwMedia,
                FilteredReason::UnspecifiedReason,
            ] {
                let rule = rule(all![], blur(reason));
                interned_name(&mut names, rule.id, &rule.action);
            }
        }

        #[test]
        #[should_panic(expected = "is wired twice")]
        fn a_rule_repeated_within_its_run_fails_construction() {
            Policy::new(vec![
                always("blur", INTERSTITIAL_NSFW),
                always("blur", INTERSTITIAL_NSFW),
            ]);
        }

        fn follows_and_blocks_failed() -> (ViewerFeatures, PostCandidate) {
            let candidate = PostCandidate {
                failed: Hydrators::of(Hydrator::Follows).with(Hydrator::Blocks),
                ..Default::default()
            };
            (ViewerFeatures::default(), candidate)
        }

        #[test]
        fn conditions_combine_in_three_values_and_unknown_resolves_to_the_default() {
            let (viewer, candidate) = follows_and_blocks_failed();
            let follows = Hydrators::of(Hydrator::Follows);
            let dropped = withheld(
                Withholding::Drop(DropReason::Legacy(FilteredReason::AuthorIsSuspended)),
                "rule",
            );
            let rows: [(RuleCond, Verdict, Hydrators); 6] = [
                (ViewerFollowsAuthor.leaf(), allow(), follows),
                (
                    const { all![ViewerFollowsAuthor, NEVER] },
                    allow(),
                    Hydrators::empty(),
                ),
                (
                    const { RuleCond::Not(&ViewerFollowsAuthor.leaf()) },
                    dropped.clone(),
                    follows,
                ),
                (
                    const { any![ViewerFollowsAuthor, ViewerLoggedOut] },
                    dropped,
                    Hydrators::empty(),
                ),
                (const { any![ViewerFollowsAuthor, NEVER] }, allow(), follows),
                (
                    const {
                        all![
                            any![ViewerBlocksAuthor, ViewerLoggedOut],
                            ViewerFollowsAuthor
                        ]
                    },
                    allow(),
                    follows,
                ),
            ];
            for (index, (when, verdict, fail_open_defaults)) in rows.into_iter().enumerate() {
                assert_eq!(
                    Policy::new(vec![("rule", rule(when, DROP_SUSPENDED))])
                        .evaluate(&test_context(&viewer, &candidate)),
                    Evaluation::Partial {
                        verdict,
                        fail_open_defaults
                    },
                    "row {index}"
                );
            }
        }

        #[test]
        fn fail_open_defaults_are_the_unknown_rules_that_could_have_changed_the_verdict() {
            let (viewer, candidate) = follows_and_blocks_failed();
            let follows = Hydrators::of(Hydrator::Follows);
            let unknown = |action| ("unknown", rule(ViewerFollowsAuthor.leaf(), action));
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
            for (index, (rules, verdict, fail_open_defaults)) in rows.into_iter().enumerate() {
                assert_eq!(
                    Policy::new(rules.into()).evaluate(&test_context(&viewer, &candidate)),
                    Evaluation::Partial {
                        verdict,
                        fail_open_defaults
                    },
                    "row {index}"
                );
            }
        }

        #[test]
        fn non_followers_spare_the_author_and_followers_and_fail_closed_on_follows() {
            let follows = Hydrators::of(Hydrator::Follows);
            let dropped = withheld(
                Withholding::Drop(DropReason::Legacy(FilteredReason::AuthorIsSuspended)),
                "rule",
            );
            let followed = candidate().with_edge(Hydrator::Follows).build();
            let mut follows_failed = candidate().build();
            follows_failed.failed = follows;
            let rows = [
                (
                    "author",
                    author_viewer(),
                    followed.clone(),
                    Evaluation::Complete { verdict: allow() },
                ),
                (
                    "follower",
                    viewer(VIEWER_ID),
                    followed,
                    Evaluation::Complete { verdict: allow() },
                ),
                (
                    "non-follower",
                    viewer(VIEWER_ID),
                    candidate().build(),
                    Evaluation::Complete {
                        verdict: dropped.clone(),
                    },
                ),
                (
                    "logged out",
                    logged_out_viewer(),
                    candidate().build(),
                    Evaluation::Complete {
                        verdict: dropped.clone(),
                    },
                ),
                (
                    "follows failed",
                    viewer(VIEWER_ID),
                    follows_failed,
                    Evaluation::Partial {
                        verdict: dropped,
                        fail_open_defaults: follows,
                    },
                ),
            ];
            let policy = Policy::new(vec![(
                "rule",
                Rule {
                    audience: NonFollowers,
                    ..rule(all![], DROP_SUSPENDED)
                },
            )]);
            for (who, viewer, candidate, evaluation) in rows {
                let context = test_context(&viewer, &candidate).hydrated_by(policy.hydrators);
                assert_eq!(policy.evaluate(&context), evaluation, "{who}");
            }
        }
    }

    mod uniform {
        use super::super::*;
        use crate::clients::socialgraph_client::{EdgeQuery, Graph};
        use crate::hydration::fallback_cache::FallbackCaches;
        use crate::hydration::plan::Source;
        use crate::hydration::sources::InMemorySources;
        use crate::hydration::{HydrationRequest, Hydrator};
        use crate::models::{ClientCapability, RawCandidate, SafetyLabelType, TweetId};
        use crate::models::{LimitedEngagementReason, Notice};
        use crate::rules::fixtures::{candidate, dropped, viewer, VIEWER_ID};
        use crate::rules::golden_corpus::pairs;
        use crate::rules::rule_spec::conditions::VIEWER_IS_NOT_AGE_VERIFIED_IN_AGE_VERIFICATION_COUNTRIES;
        use crate::rules::rule_spec::leaves::*;
        use crate::rules::rule_spec::observed::{NodeKind, NodeTrace, Skip, Witness};
        use crate::rules::rule_spec::rule::{
            all, any, Audience, DescriptionError, NamedCond, RuleCond,
        };
        use crate::rules::rule_spec::Predicate;
        use crate::rules::rule_spec::{
            appealable, blur, drop_post, limit, soft_intervention, DropAs,
        };
        use crate::rules::test_context;
        use crate::rules::tweet_rules;
        use crate::scenario::{raw, Scenario};
        use std::hash::{DefaultHasher, Hash, Hasher};
        use xai_core_entities::entities::{GizmoduckUser, Label, Labels};
        use xai_visibility_filtering::models::FilteredReason;
        use xai_x_thrift::action::{AppealablePolicy, InterstitialReason};
        use xai_x_thrift::user_labels::LabelValue;
        use Audience::{Everyone, NonAuthors, OnlyAuthor};

        fn rule(audience: Audience, when: RuleCond, action: RuleAction) -> Rule {
            Rule {
                id: RuleId::FilterAll,
                audience,
                when,
                action,
            }
        }

        fn children<'t>(trace: &'t PolicyTrace, parent: usize) -> Vec<&'t NodeTrace> {
            trace
                .nodes
                .iter()
                .filter(|node| node.parent == Some(parent))
                .collect()
        }

        fn witness(node: &NodeTrace, truth: Truth, negated: bool) -> Witness {
            Witness {
                node: node.node,
                truth,
                negated,
            }
        }

        #[test]
        fn total_observation_keeps_every_golden_evaluation_at_every_level() {
            let rule_engine = RuleEngine::for_tests();
            let mut seen = (0, 0);
            for (viewer, healthy) in pairs() {
                let mut failed = healthy.clone();
                failed.failed = Hydrators::all();
                for (candidate, &level) in [healthy, failed].iter().flat_map(|candidate| {
                    SafetyLevel::VARIANTS
                        .iter()
                        .map(move |level| (candidate, level))
                }) {
                    let served = rule_engine.evaluate(level, &viewer, candidate);
                    let observed = rule_engine.trace(level, &viewer, candidate);
                    assert_eq!(
                        observed.evaluation, served,
                        "{level:?} {viewer:?} {candidate:?}"
                    );
                    match served {
                        Evaluation::Partial {
                            fail_open_defaults, ..
                        } if !fail_open_defaults.is_empty() => {
                            seen.0 += 1;
                        }
                        Evaluation::Complete {
                            verdict: Verdict::Withheld(_) | Verdict::Shown { media: Some(_), .. },
                        } => seen.1 += 1,
                        Evaluation::Complete { .. }
                        | Evaluation::Partial { .. }
                        | Evaluation::NotFound(_)
                        | Evaluation::Failed(_) => {}
                    }
                }
            }
            assert!(seen.0 > 0 && seen.1 > 0, "{seen:?}");
        }

        #[test]
        fn a_nested_not_records_its_truths_witnesses_and_skip_causes() {
            static MUTED: NamedCond = NamedCond {
                name: "muted",
                condition: ViewerMutesAuthor.leaf(),
            };
            let nested = rule(
                NonAuthors,
                const {
                    RuleCond::Not(&any![
                        all![ViewerFollowsAuthor, ViewerBlocksAuthor],
                        RuleCond::Named(&MUTED)
                    ])
                },
                drop_post(DropAs::UnspecifiedReason),
            );
            let policy = Policy::new(vec![("nested", nested)]);
            let viewer = viewer(VIEWER_ID);
            let observe = |candidate: &PostCandidate| {
                let context = test_context(&viewer, candidate).hydrated_by(policy.hydrators);
                let trace = policy.trace(&context);
                assert_eq!(trace.evaluation, policy.evaluate(&context));
                trace
            };
            let shape = |trace: &PolicyTrace| {
                let root = trace.rows[0].root;
                let [audience, when] = children(trace, root)[..] else {
                    panic!("a rule observes its audience and its condition")
                };
                let [any] = children(trace, when.node)[..] else {
                    panic!("not has one child")
                };
                let [all, named] = children(trace, any.node)[..] else {
                    panic!("any has two children")
                };
                let [follows, blocks] = children(trace, all.node)[..] else {
                    panic!("all has two children")
                };
                let [mutes] = children(trace, named.node)[..] else {
                    panic!("a named use observes its definition")
                };
                assert_eq!(audience.truth, Truth::True);
                assert_eq!(
                    [when, any, all, named, follows, blocks, mutes].map(|node| node.kind),
                    [
                        NodeKind::Not,
                        NodeKind::Any,
                        NodeKind::All,
                        NodeKind::Named("muted"),
                        NodeKind::Leaf(Predicate::Edge(ViewerFollowsAuthor)),
                        NodeKind::Leaf(Predicate::Edge(ViewerBlocksAuthor)),
                        NodeKind::Leaf(Predicate::Edge(ViewerMutesAuthor)),
                    ]
                );
                [when, any, all, named, follows, blocks, mutes].map(Clone::clone)
            };

            let followed = candidate()
                .with_edge(Hydrator::Follows)
                .with_edge(Hydrator::Blocks)
                .build();
            let trace = observe(&followed);
            let [not, any, all, named, follows, blocks, mutes] = shape(&trace);
            assert_eq!(trace.rows[0].truth, Truth::False);
            assert_eq!(not.truth, Truth::False);
            assert_eq!(not.witnesses, [witness(&any, Truth::True, true)]);
            assert_eq!(any.witnesses, [witness(&all, Truth::True, false)]);
            assert_eq!(
                all.witnesses,
                [
                    witness(&follows, Truth::True, false),
                    witness(&blocks, Truth::True, false)
                ]
            );
            assert_eq!(named.skip, Some(Skip::TrueDisjunct(all.node)));
            assert_eq!(mutes.skip, Some(Skip::TrueDisjunct(all.node)));
            assert_eq!(mutes.truth, Truth::False);
            assert_eq!(
                trace.evaluation,
                Evaluation::Complete {
                    verdict: Verdict::Shown {
                        notice: None,
                        media: None,
                        engagement: None
                    }
                }
            );

            let unfollowed = candidate().build();
            let trace = observe(&unfollowed);
            let [not, any, all, named, follows, blocks, _] = shape(&trace);
            assert_eq!(not.truth, Truth::True);
            assert_eq!(not.witnesses, [witness(&any, Truth::False, true)]);
            assert_eq!(
                any.witnesses,
                [
                    witness(&all, Truth::False, false),
                    witness(&named, Truth::False, false)
                ]
            );
            assert_eq!(
                all.witnesses,
                [
                    witness(&follows, Truth::False, false),
                    witness(&blocks, Truth::False, false)
                ]
            );
            assert_eq!(follows.skip, None);
            assert_eq!(blocks.skip, Some(Skip::FalseConjunct(follows.node)));
            assert_eq!(named.skip, None);
            assert_eq!(trace.rows[0].effect, Effect::Decided);

            let mut unknown = candidate().with_edge(Hydrator::Blocks).build();
            unknown.failed = Hydrators::of(Hydrator::Follows);
            let follows_failed = |default| Truth::Unknown {
                default,
                failed: unknown.failed,
            };
            let trace = observe(&unknown);
            let [not, any, all, named, follows, blocks, _] = shape(&trace);
            assert_eq!(not.truth, follows_failed(true));
            assert_eq!(not.witnesses, [witness(&any, follows_failed(false), true)]);
            assert_eq!(not.default_witnesses, [witness(&any, Truth::False, true)]);
            assert_eq!(any.witnesses, [witness(&all, follows_failed(false), false)]);
            assert_eq!(
                any.default_witnesses,
                [
                    witness(&all, Truth::False, false),
                    witness(&named, Truth::False, false)
                ]
            );
            assert_eq!(
                all.witnesses,
                [witness(&follows, follows_failed(false), false)]
            );
            assert_eq!(
                all.default_witnesses,
                [witness(&follows, Truth::False, false)]
            );
            assert_eq!(blocks.truth, Truth::True);
            assert_eq!(blocks.skip, None);
            assert_eq!(named.skip, None);
            assert_eq!(trace.rows[0].defaults_retained, unknown.failed);
            assert_eq!(
                trace.evaluation,
                Evaluation::Partial {
                    verdict: dropped(FilteredReason::UnspecifiedReason, "nested"),
                    fail_open_defaults: unknown.failed,
                }
            );

            let double = rule(
                NonAuthors,
                const {
                    RuleCond::Not(&RuleCond::Not(&any![
                        all![ViewerMutesAuthor, ViewerBlocksAuthor],
                        ViewerFollowsAuthor
                    ]))
                },
                drop_post(DropAs::UnspecifiedReason),
            );
            let double = Policy::new(vec![("double", double)]);
            let context = test_context(&viewer, &unknown).hydrated_by(double.hydrators);
            let trace = double.trace(&context);
            assert_eq!(trace.evaluation, double.evaluate(&context));
            let [_, outer] = children(&trace, trace.rows[0].root)[..] else {
                panic!("a rule observes its audience and its condition")
            };
            let [inner] = children(&trace, outer.node)[..] else {
                panic!("not has one child")
            };
            let [any] = children(&trace, inner.node)[..] else {
                panic!("not has one child")
            };
            let [all, follows] = children(&trace, any.node)[..] else {
                panic!("any has two children")
            };
            let [mutes, blocks] = children(&trace, all.node)[..] else {
                panic!("all has two children")
            };
            assert_eq!(outer.truth, follows_failed(false));
            assert_eq!(
                outer.witnesses,
                [witness(inner, follows_failed(true), true)]
            );
            assert_eq!(outer.default_witnesses, [witness(inner, Truth::True, true)]);
            assert_eq!(inner.witnesses, [witness(any, follows_failed(false), true)]);
            assert_eq!(inner.default_witnesses, [witness(any, Truth::False, true)]);
            assert_eq!(
                any.witnesses,
                [witness(follows, follows_failed(false), false)]
            );
            assert_eq!(
                any.default_witnesses,
                [
                    witness(all, Truth::False, false),
                    witness(follows, Truth::False, false)
                ]
            );
            assert_eq!(all.witnesses, [witness(mutes, Truth::False, false)]);
            assert_eq!(
                [outer, inner, any, all, follows, mutes].map(|node| node.skip),
                [None; 6]
            );
            assert_eq!(blocks.skip, Some(Skip::FalseConjunct(mutes.node)));
            assert_eq!(trace.rows[0].effect, Effect::DidNotApply);
            assert_eq!(trace.rows[0].defaults_retained, unknown.failed);
        }

        #[tokio::test]
        async fn empty_identities_audiences_and_repeated_named_uses_run_through_filter_tweets() {
            static FOLLOWED: NamedCond = NamedCond {
                name: "followed",
                condition: ViewerFollowsAuthor.leaf(),
            };
            let rules = vec![
                (
                    "never",
                    rule(Everyone, any![], drop_post(DropAs::UnspecifiedReason)),
                ),
                (
                    "followed",
                    rule(
                        NonAuthors,
                        const {
                            all![
                                RuleCond::Named(&FOLLOWED),
                                RuleCond::Named(&FOLLOWED),
                                RuleCond::Not(&RuleCond::Not(&all![]))
                            ]
                        },
                        drop_post(DropAs::AuthorIsProtected),
                    ),
                ),
                (
                    "age_gated_author",
                    rule(
                        OnlyAuthor,
                        VIEWER_IS_NOT_AGE_VERIFIED_IN_AGE_VERIFICATION_COUNTRIES,
                        drop_post(DropAs::ExclusiveTweet),
                    ),
                ),
                (
                    "age_gated",
                    rule(
                        NonAuthors,
                        VIEWER_IS_NOT_AGE_VERIFIED_IN_AGE_VERIFICATION_COUNTRIES,
                        drop_post(DropAs::ContainNsfwMedia),
                    ),
                ),
                (
                    "always",
                    rule(Everyone, all![], drop_post(DropAs::ViewerBlocksAuthor)),
                ),
            ];
            let age_verified = GizmoduckUser {
                labels: Labels {
                    labels: vec![Label {
                        label_value: LabelValue::AGE_VERIFIED_18.0,
                        created_at_msec: 0,
                    }],
                },
                ..Default::default()
            };
            let sources = || {
                InMemorySources::default()
                    .tweet(1, 10)
                    .authors(&[10])
                    .edge(Graph::Follows, 50, 10)
                    .viewer(70, age_verified.clone())
            };
            for (viewer_id, decided) in [
                (50, ("followed", FilteredReason::AuthorIsProtected)),
                (60, ("age_gated", FilteredReason::ContainNsfwMedia)),
                (10, ("age_gated_author", FilteredReason::ExclusiveTweet)),
                (70, ("always", FilteredReason::ViewerBlocksAuthor)),
            ] {
                let scenario = Scenario::new(sources(), SafetyLevel::FilterAll)
                    .viewer(Some(viewer_id))
                    .country("fr");
                let engine =
                    RuleEngine::with_level_for_tests(SafetyLevel::FilterAll, rules.clone());
                assert_eq!(
                    scenario
                        .evaluate_with(engine, &[raw(1, None)])
                        .await
                        .evaluations(),
                    [Evaluation::Complete {
                        verdict: dropped(decided.1, decided.0)
                    }],
                    "viewer {viewer_id}"
                );
            }

            let policy = Policy::new(rules);
            let mut followed = candidate().with_edge(Hydrator::Follows).build();
            followed.author.id = 10;
            let viewer = viewer(VIEWER_ID);
            let trace =
                policy.trace(&test_context(&viewer, &followed).hydrated_by(policy.hydrators));
            let uses: Vec<&NodeTrace> = trace
                .nodes
                .iter()
                .filter(|node| node.kind == NodeKind::Named("followed"))
                .collect();
            assert_eq!(uses.len(), 2);
            assert_ne!(uses[0].node, uses[1].node);
            assert!(uses
                .iter()
                .all(|node| node.truth == Truth::True && node.skip.is_none()));
            assert_eq!(
                trace.rows.iter().map(|row| row.truth).collect::<Vec<_>>(),
                [
                    Truth::False,
                    Truth::True,
                    Truth::False,
                    Truth::False,
                    Truth::True
                ]
            );
        }

        #[tokio::test]
        async fn a_rule_input_adds_its_source_query_and_deleting_it_removes_the_query() {
            let run = |when: RuleCond, action: RuleAction| async move {
                let sources = InMemorySources::default().tweet(1, 10).authors(&[10]);
                let scenario = Scenario::new(sources, SafetyLevel::FilterAll).viewer(Some(50));
                let engine = RuleEngine::with_level_for_tests(
                    SafetyLevel::FilterAll,
                    vec![("rule", rule(Everyone, when, action))],
                );
                scenario.evaluate_with(engine, &[raw(1, None)]).await;
                scenario
            };
            let selects = |when: RuleCond| async move {
                run(when, drop_post(DropAs::UnspecifiedReason))
                    .await
                    .sources()
                    .selects()
            };
            let reads_labels = |action: RuleAction| async move {
                run(all![], action)
                    .await
                    .sources()
                    .calls()
                    .contains(&Source::SafetyLabels)
            };
            assert_eq!(
                selects(ViewerFollowsAuthor.leaf()).await,
                [vec![EdgeQuery::forward(Graph::Follows, vec![10])]]
            );
            assert_eq!(
                selects(const { all![ViewerFollowsAuthor, ViewerBlocksAuthor] }).await,
                [vec![
                    EdgeQuery::forward(Graph::Follows, vec![10]),
                    EdgeQuery::forward(Graph::Blocks, vec![10]),
                ]]
            );
            assert_eq!(selects(all![]).await, Vec::<Vec<EdgeQuery>>::new());
            assert!(
                reads_labels(soft_intervention(
                    SafetyLabelType::FOSNR_ABUSE,
                    AppealablePolicy::ABUSE,
                    1
                ))
                .await
            );
            assert!(!reads_labels(drop_post(DropAs::UnspecifiedReason)).await);
        }

        async fn hydrate(plan: &HydrationPlan) -> Hydration {
            let sources = InMemorySources::default().tweet(1, 10).authors(&[10]);
            let raw = [RawCandidate {
                tweet_id: TweetId(1),
                request_author_id: None,
            }];
            let caches = FallbackCaches::default();
            let request = HydrationRequest::new(
                Some(50),
                Some("us".into()),
                ClientCapability::default(),
                &raw,
                &caches,
            );
            plan.hydrate(&sources, request).await
        }

        #[tokio::test]
        async fn admission_rejects_a_hydration_without_a_required_provider_before_either_mode() {
            let rule_engine = RuleEngine::for_tests();
            let unplanned = hydrate(&HydrationPlan::new(
                SafetyLevel::TimelineHome,
                Hydrators::empty(),
            ))
            .await;
            assert!(unplanned
                .tweet(TweetId(1))
                .and_then(|tweet| tweet.candidate())
                .is_some());
            let Err(AdmissionError::MissingInputs(missing)) =
                rule_engine.admit(SafetyLevel::TimelineHome, &unplanned)
            else {
                panic!("an unplanned hydration is admitted");
            };
            assert!(
                missing.contains(Hydrator::Follows) && missing.contains(Hydrator::AuthorSafety),
                "{missing:?}"
            );

            let planned = hydrate(rule_engine.plan(SafetyLevel::TimelineHome)).await;
            assert!(rule_engine
                .admit(SafetyLevel::TimelineHome, &planned)
                .is_ok());
        }

        #[tokio::test]
        async fn admission_covers_the_inputs_of_rules_after_the_terminal_one() {
            let rules = vec![
                (
                    "terminal",
                    rule(Everyone, all![], drop_post(DropAs::UnspecifiedReason)),
                ),
                (
                    "later",
                    rule(
                        Everyone,
                        ViewerFollowsAuthor.leaf(),
                        drop_post(DropAs::AuthorIsProtected),
                    ),
                ),
            ];
            let rule_engine = RuleEngine::with_level_for_tests(SafetyLevel::FilterAll, rules);
            let unplanned = hydrate(&HydrationPlan::new(
                SafetyLevel::FilterAll,
                Hydrators::empty(),
            ))
            .await;
            assert_eq!(
                rule_engine.admit(SafetyLevel::FilterAll, &unplanned).err(),
                Some(AdmissionError::MissingInputs(Hydrators::of(
                    Hydrator::Follows
                )))
            );
            let planned = hydrate(rule_engine.plan(SafetyLevel::FilterAll)).await;
            assert!(rule_engine.admit(SafetyLevel::FilterAll, &planned).is_ok());
        }

        #[test]
        fn total_observation_completes_suppressed_restrictions_and_tells_engagement_reasons_apart()
        {
            let always = |name, action| (name, rule(Everyone, all![], action));
            let nudity = blur(InterstitialReason::Nudity(true));
            let notice =
                soft_intervention(SafetyLabelType::FOSNR_ABUSE, AppealablePolicy::ABUSE, 1);
            let policy = Policy::new(vec![
                always("first", blur(InterstitialReason::Sensitive(true))),
                always("suppressed", nudity.clone()),
                always("notice", notice.clone()),
                always(
                    "filled",
                    limit(LimitedEngagementReason::ConversationControl),
                ),
                always("added", limit(LimitedEngagementReason::BlockedViewer)),
                always(
                    "duplicate",
                    limit(LimitedEngagementReason::ConversationControl),
                ),
            ]);
            let viewer = viewer(VIEWER_ID);
            let candidate = candidate().build();
            let context = test_context(&viewer, &candidate).hydrated_by(policy.hydrators);
            let trace = policy.trace(&context);
            let served = policy.evaluate(&context);
            assert_eq!(trace.evaluation, served);
            assert_eq!(
                trace.rows.iter().map(|row| row.effect).collect::<Vec<_>>(),
                [
                    Effect::FilledMedia,
                    Effect::KeptEarlierMedia,
                    Effect::KeptEarlierMediaInsteadOfNotice,
                    Effect::FilledEngagement,
                    Effect::AddedEngagementReason,
                    Effect::DuplicateEngagementReason,
                ]
            );
            let completed = |action: &RuleAction| {
                Some((
                    action.spec().interpret(&EvaluateInputs(&context)).value,
                    Hydrators::empty(),
                ))
            };
            assert_eq!(trace.rows[1].completed, completed(&nudity));
            let Some((Some(Contribution::Notice(Notice::SoftIntervention(_))), _)) =
                trace.rows[2].completed
            else {
                panic!("a suppressed notice is completed: {:?}", trace.rows[2]);
            };
            let Verdict::Shown {
                notice: None,
                media: Some(media),
                engagement: Some(engagement),
            } = served.into_verdict()
            else {
                panic!("the blur and the limits are shown without the notice");
            };
            assert_eq!((media.by, engagement.by), ("first", "filled"));
            assert_eq!(
                engagement.value.reasons().collect::<Vec<_>>(),
                [
                    LimitedEngagementReason::ConversationControl,
                    LimitedEngagementReason::BlockedViewer,
                ]
            );
        }

        #[test]
        fn total_observation_admits_and_retains_the_defaults_each_opportunity_allows() {
            let viewer = viewer(VIEWER_ID);
            let mut unknown = candidate().build();
            unknown.failed = Hydrators::of(Hydrator::Follows);
            let follows = unknown.failed;
            let none = Hydrators::empty();
            let always = |name, action| (name, rule(Everyone, all![], action));
            let when_followed =
                |name, action| (name, rule(Everyone, ViewerFollowsAuthor.leaf(), action));
            let sensitive = || blur(InterstitialReason::Sensitive(true));
            let conversation = || limit(LimitedEngagementReason::ConversationControl);
            let notice =
                || soft_intervention(SafetyLabelType::FOSNR_ABUSE, AppealablePolicy::ABUSE, 1);
            let drop = || drop_post(DropAs::UnspecifiedReason);
            let unsorted = |rules: Vec<(&'static str, Rule)>| Policy {
                hydrators: Policy::new(rules.clone()).hydrators,
                rules,
            };
            for (case, policy, admitted, retained) in [
                (
                    "a withholding before the decision",
                    Policy::new(vec![
                        when_followed("unknown", drop()),
                        always("decides", drop()),
                    ]),
                    [follows, none],
                    [follows, none],
                ),
                (
                    "an empty slot in a shown verdict",
                    Policy::new(vec![
                        when_followed("unknown", sensitive()),
                        always("limit", conversation()),
                    ]),
                    [follows, none],
                    [follows, none],
                ),
                (
                    "an empty slot under a notice",
                    Policy::new(vec![
                        when_followed("unknown", sensitive()),
                        always("notice", notice()),
                    ]),
                    [follows, none],
                    [follows, none],
                ),
                (
                    "a filled media slot",
                    Policy::new(vec![
                        always("blur", sensitive()),
                        when_followed("unknown", sensitive()),
                    ]),
                    [none, none],
                    [none, none],
                ),
                (
                    "a filled media slot before a notice",
                    Policy::new(vec![
                        always("blur", sensitive()),
                        when_followed("unknown", notice()),
                    ]),
                    [none, none],
                    [none, none],
                ),
                (
                    "a filled engagement slot",
                    Policy::new(vec![
                        always("limit", conversation()),
                        when_followed("unknown", conversation()),
                    ]),
                    [none, none],
                    [none, none],
                ),
                (
                    "an empty slot ahead of a withholding",
                    unsorted(vec![
                        when_followed("unknown", sensitive()),
                        always("decides", drop()),
                    ]),
                    [follows, none],
                    [none, none],
                ),
            ] {
                let trace =
                    policy.trace(&test_context(&viewer, &unknown).hydrated_by(policy.hydrators));
                let by_row =
                    |row: &RowTrace| (row.by, row.defaults_admitted, row.defaults_retained);
                let mut rows: Vec<_> = trace.rows.iter().map(by_row).collect();
                rows.sort_by_key(|&(by, ..)| by != "unknown");
                assert_eq!(
                    rows.iter()
                        .map(|&(_, admitted, _)| admitted)
                        .collect::<Vec<_>>(),
                    admitted,
                    "{case}"
                );
                assert_eq!(
                    rows.iter()
                        .map(|&(.., retained)| retained)
                        .collect::<Vec<_>>(),
                    retained,
                    "{case}"
                );
                assert_eq!(trace.evaluation.fail_open_defaults(), retained[0], "{case}");
            }
        }

        #[test]
        fn total_observation_keeps_absorbed_unknowns_out_of_the_defaults() {
            let viewer = viewer(VIEWER_ID);
            let mut unknown = candidate().build();
            unknown.failed = Hydrators::of(Hydrator::Follows);
            let policy = Policy::new(vec![
                (
                    "absorbed_by_false",
                    rule(
                        Everyone,
                        const { all![any![], ViewerFollowsAuthor] },
                        drop_post(DropAs::AuthorIsProtected),
                    ),
                ),
                (
                    "absorbed_by_true",
                    rule(
                        Everyone,
                        const { any![all![], ViewerFollowsAuthor] },
                        blur(InterstitialReason::Sensitive(true)),
                    ),
                ),
            ]);
            let context = test_context(&viewer, &unknown).hydrated_by(policy.hydrators);
            let trace = policy.trace(&context);
            assert_eq!(trace.evaluation, policy.evaluate(&context));
            assert_eq!(
                trace
                    .rows
                    .iter()
                    .map(|row| (row.truth, row.defaults_admitted))
                    .collect::<Vec<_>>(),
                [
                    (Truth::False, Hydrators::empty()),
                    (Truth::True, Hydrators::empty())
                ]
            );
            let follows: Vec<&NodeTrace> = trace
                .nodes
                .iter()
                .filter(|node| node.kind == NodeKind::Leaf(Predicate::Edge(ViewerFollowsAuthor)))
                .collect();
            let [after_false, after_true] = follows[..] else {
                panic!("each rule observes its follows leaf");
            };
            for (leaf, skip) in [
                (after_false, Skip::FalseConjunct(after_false.node - 1)),
                (after_true, Skip::TrueDisjunct(after_true.node - 1)),
            ] {
                assert_eq!(
                    leaf.truth,
                    Truth::Unknown {
                        default: false,
                        failed: unknown.failed
                    }
                );
                assert_eq!(leaf.skip, Some(skip));
            }
            let Evaluation::Partial {
                fail_open_defaults, ..
            } = trace.evaluation
            else {
                panic!("a failed node makes the evaluation partial");
            };
            assert_eq!(fail_open_defaults, Hydrators::empty());
        }

        #[test]
        fn total_observation_marks_an_appeal_without_an_eligible_label() {
            let policy = Policy::new(vec![
                (
                    "appeal",
                    rule(
                        Everyone,
                        all![],
                        appealable(&tweet_rules::FOSNR_AUTHOR_VIOLATIONS),
                    ),
                ),
                (
                    "decides",
                    rule(Everyone, all![], drop_post(DropAs::UnspecifiedReason)),
                ),
            ]);
            let viewer = viewer(VIEWER_ID);
            let candidate = candidate().build();
            let context = test_context(&viewer, &candidate).hydrated_by(policy.hydrators);
            let trace = policy.trace(&context);
            assert_eq!(trace.evaluation, policy.evaluate(&context));
            let appeal = &trace.rows[0];
            assert_eq!(
                (appeal.truth, appeal.effect, appeal.completed.clone()),
                (
                    Truth::True,
                    Effect::DidNotApply,
                    Some((None, Hydrators::empty()))
                )
            );
            assert_eq!(trace.rows[1].effect, Effect::Decided);
            assert_eq!(
                trace.evaluation,
                Evaluation::Complete {
                    verdict: dropped(FilteredReason::UnspecifiedReason, "decides")
                }
            );
        }

        fn hashed(rule: &Rule) -> u64 {
            let mut hasher = DefaultHasher::new();
            rule.hash(&mut hasher);
            hasher.finish()
        }

        #[test]
        fn rules_compare_hash_and_print_their_structure_payload_and_names() {
            use crate::rules::rule_spec::leaves::TweetHasLabel;
            static FOLLOWED: NamedCond = NamedCond {
                name: "followed",
                condition: ViewerFollowsAuthor.leaf(),
            };
            static RENAMED: NamedCond = NamedCond {
                name: "renamed",
                condition: ViewerFollowsAuthor.leaf(),
            };
            let base = rule(
                NonAuthors,
                const {
                    all![
                        RuleCond::Named(&FOLLOWED),
                        TweetHasLabel(SafetyLabelType::SPAM)
                    ]
                },
                drop_post(DropAs::UnspecifiedReason),
            );
            assert_eq!(
                base.authored(),
                "filter_all/drop/unspecified | audience=NonAuthors \
                 | when=all[followed=viewer_follows_author & tweet_has_label(SPAM)] \
                 | Drop(Legacy(UnspecifiedReason))"
            );
            let changes = [
                (
                    "structure",
                    const {
                        any![
                            RuleCond::Named(&FOLLOWED),
                            TweetHasLabel(SafetyLabelType::SPAM)
                        ]
                    },
                ),
                (
                    "leaf kind",
                    const { all![RuleCond::Named(&FOLLOWED), ViewerMutesAuthor] },
                ),
                (
                    "payload",
                    const {
                        all![
                            RuleCond::Named(&FOLLOWED),
                            TweetHasLabel(SafetyLabelType::BOUNCE)
                        ]
                    },
                ),
                (
                    "name",
                    const {
                        all![
                            RuleCond::Named(&RENAMED),
                            TweetHasLabel(SafetyLabelType::SPAM)
                        ]
                    },
                ),
            ];
            assert_eq!(base, base.clone());
            assert_eq!(hashed(&base), hashed(&base.clone()));
            for (change, when) in changes {
                let changed = Rule {
                    when,
                    ..base.clone()
                };
                assert_ne!(changed, base, "{change}");
                assert_ne!(hashed(&changed), hashed(&base), "{change}");
                assert_ne!(format!("{changed:?}"), format!("{base:?}"), "{change}");
                assert_ne!(changed.authored(), base.authored(), "{change}");
            }
        }

        #[test]
        fn two_definitions_of_one_name_fail_validation_and_shared_uses_pass() {
            static SHARED_ALL: NamedCond = NamedCond {
                name: "shared",
                condition: all![],
            };
            static SHARED_ANY: NamedCond = NamedCond {
                name: "shared",
                condition: any![],
            };
            let conflicting = [
                rule(
                    Everyone,
                    RuleCond::Named(&SHARED_ALL),
                    drop_post(DropAs::UnspecifiedReason),
                ),
                rule(
                    Everyone,
                    RuleCond::Named(&SHARED_ANY),
                    drop_post(DropAs::AuthorIsProtected),
                ),
            ];
            assert_eq!(
                rule::validate(&conflicting),
                Err(DescriptionError::ConflictingName("shared"))
            );
            let shared = [
                rule(
                    Everyone,
                    RuleCond::Named(&SHARED_ALL),
                    drop_post(DropAs::UnspecifiedReason),
                ),
                rule(
                    Everyone,
                    const { RuleCond::Not(&RuleCond::Named(&SHARED_ALL)) },
                    drop_post(DropAs::AuthorIsProtected),
                ),
            ];
            assert_eq!(rule::validate(&shared), Ok(()));
        }

        #[test]
        #[should_panic(expected = "invalid rules: Cycle")]
        fn a_cyclic_policy_fails_construction() {
            static CYCLE: RuleCond = RuleCond::Not(&CYCLE);
            Policy::new(vec![(
                "cyclic",
                rule(Everyone, CYCLE, drop_post(DropAs::UnspecifiedReason)),
            )]);
        }
    }
}
