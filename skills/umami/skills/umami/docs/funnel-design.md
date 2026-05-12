<!-- Source: Implementation patterns from production Umami deployments -->

# Funnel Design Patterns

Reusable conversion funnel templates for Umami's funnel reports.

## Generic Funnel Stages

Every conversion funnel follows this progression:

```
Discovery    → User finds your product/service
  ↓
Research     → User explores details, requirements
  ↓
Intent       → User evaluates pricing, compares options
  ↓
Decision     → User selects tier/plan/package
  ↓
Commitment   → User initiates contact/signup
  ↓
Conversion   → User completes the action
  ↓
Verification → User confirms (email, payment, etc.)
```

Not every funnel needs all stages. Match stages to your actual user flow.

## B2C Lead Generation Funnel

**Purpose:** Track visitors from discovery to qualified lead.

```
Stage 1: service_page_viewed        — Entry (100%)
Stage 2: requirements_viewed        — Research (~60%)
Stage 3: pricing_calculator_used    — Intent (~40%)
Stage 4: tier_selected              — Decision (~30%)
Stage 5: form_opened                — Commitment (~25%)
Stage 6: form_submitted_success     — Conversion (~20%)
Stage 7: email_verified             — Verified lead (~18%)
```

**Key drop-off points:**
- Research → Intent (33% drop): Users don't find pricing or it's buried
- Commitment → Conversion (20% drop): Form friction, too many fields

**Optimization priorities:**
1. Bridge research-to-intent: Add calculator preview on requirements page
2. Reduce form friction: Fewer fields, multi-step, progress indicator
3. Improve verification: Reduce email friction, add alternatives

## B2B Partner/Enterprise Funnel

**Purpose:** Track businesses from program discovery to application.

```
Stage 1: program_page_viewed        — Discovery (100%)
Stage 2: calculator_viewed          — Interest (~70%)
Stage 3: pricing_customized         — Evaluation (~50%)
Stage 4: package_selected           — Decision (~35%)
Stage 5: application_opened         — Commitment (~30%)
Stage 6: application_submitted      — Conversion (~25%)
```

**Key characteristics:**
- Higher initial engagement (B2B visitors are more targeted)
- Multi-session: Expect 2-4 visits before conversion
- Multi-stakeholder: Decision involves multiple people

**Optimization priorities:**
1. Package comparison table (reduce decision drop-off)
2. Save calculator state across sessions
3. "Schedule a call" as alternative to form

## SaaS Signup Funnel

```
Stage 1: landing_page_viewed        — Awareness (100%)
Stage 2: features_explored          — Interest (~55%)
Stage 3: pricing_viewed             — Consideration (~35%)
Stage 4: signup_started             — Intent (~20%)
Stage 5: signup_completed           — Conversion (~15%)
Stage 6: onboarding_completed       — Activation (~8%)
```

## E-commerce Funnel

```
Stage 1: product_viewed             — Browse (100%)
Stage 2: product_added              — Interest (~25%)
Stage 3: cart_viewed                — Intent (~18%)
Stage 4: checkout_started           — Commitment (~12%)
Stage 5: purchase_completed         — Conversion (~8%)
```

## Onboarding Funnel

**Purpose:** Track new user/partner activation after signup.

```
Stage 1: account_created            — Entry (100%)
Stage 2: onboarding_started         — Engagement (~90%)
Stage 3: training_completed         — Understanding (~75%)
Stage 4: first_action_taken         — Activation (~50%)
Stage 5: first_value_delivered      — Success (~40%)
```

**Key insight:** The biggest drop is between understanding and action. Users know *how* but haven't *done* it yet.

**Optimization:**
- Guided first action (wizard, template, one-click setup)
- Incentives for first milestone
- Proactive support at day 3-5 if no action

## Content-to-Conversion Funnel

```
Stage 1: blog_post_viewed           — Discovery (100%)
Stage 2: related_content_viewed     — Engagement (~40%)
Stage 3: product_page_viewed        — Interest (~20%)
Stage 4: signup_started             — Intent (~8%)
Stage 5: signup_completed           — Conversion (~5%)
```

## Implementing in Umami

### Via API Client
```typescript
const { data } = await client.createReport({
  websiteId: 'your-id',
  type: 'funnel',
  parameters: {
    startDate: '2025-01-01T00:00:00Z',
    endDate: '2025-01-31T23:59:59Z',
    timezone: 'America/New_York',
    urls: ['/services', '/pricing', '/signup', '/dashboard'],
  },
  filters: {}
})
```

### Via Dashboard
1. Go to Reports → Create Report → Funnel
2. Add steps (URLs or events)
3. Set date range and time window
4. Analyze drop-off between steps

## Benchmarking by Segment

Track funnel performance across segments to find optimization opportunities:

### By Traffic Source
| Source | Typical Conversion | Optimize for |
|--------|-------------------|--------------|
| Organic search | Highest (~22%) | Minimal friction, fast path |
| Referrals | Very high (~30%) | Fast-track, VIP treatment |
| Email | High (~25%) | Personalization, urgency |
| Paid ads | Average (~15%) | Clear value prop, trust signals |
| Social media | Lowest (~8%) | Education, nurture sequence |

### By Device
| Device | Typical Conversion | Optimize for |
|--------|-------------------|--------------|
| Desktop | Highest (~22%) | Detailed info, comparison tools |
| Tablet | Middle (~16%) | Responsive, touch-friendly |
| Mobile | Lowest (~12%) | Simplified forms, click-to-call |

## Optimization Workflow

1. **Establish baseline** — Track all stages for 2-4 weeks
2. **Identify bottleneck** — Find the stage with the highest drop-off rate
3. **Hypothesize** — Why are users dropping off?
4. **Test** — A/B test one change at a time
5. **Measure** — Compare funnel performance before/after
6. **Iterate** — Move to next bottleneck

### Revenue Impact Formula

```
Current:  visitors × conversion_rate × avg_value = revenue
Improved: visitors × (conversion_rate + improvement) × avg_value = new_revenue
Delta:    new_revenue - revenue = monthly impact
```

Even a 2-5 percentage point improvement in one stage compounds through the entire funnel.
