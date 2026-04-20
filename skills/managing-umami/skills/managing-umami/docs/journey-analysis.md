<!-- Source: Implementation patterns from production Umami deployments -->

# Journey Analysis Patterns

User journey frameworks for Umami's journey reports. Understand how different user segments navigate your site across single and multi-session visits.

## Journey Archetypes

### 1. Discovery Journey (Research Phase)

**Path:** Homepage → About → Features → Pricing → Exit

| Metric | Typical |
|--------|---------|
| Duration | 5-10 minutes |
| Pages | 4-6 |
| Conversion | 5-10% |
| Intent | Information gathering |

**Optimization:** Capture email on exit intent, retargeting pixel, downloadable content offers.

### 2. Decision Journey (High Intent)

**Path:** Search → Pricing/Calculator → Signup → Conversion

| Metric | Typical |
|--------|---------|
| Duration | 3-5 minutes |
| Pages | 3-4 |
| Conversion | 25-35% |
| Intent | Ready to proceed |

**Optimization:** Remove friction, add trust signals, fast response promises.

### 3. Comparison Journey (Due Diligence)

**Path:** Homepage → Features → FAQ → Competitor → Return → Pricing → Signup

| Metric | Typical |
|--------|---------|
| Duration | Multiple sessions over days/weeks |
| Pages | 10-15 total |
| Conversion | 15-20% |
| Intent | Careful evaluation |

**Optimization:** Comparison content, email nurture, retargeting, social proof.

### 4. Referral Journey (Trusted Source)

**Path:** Referral Link → Product → Pricing → Signup

| Metric | Typical |
|--------|---------|
| Duration | 2-4 minutes |
| Pages | 3-4 |
| Conversion | 35-45% |
| Intent | Pre-qualified, high trust |

**Optimization:** Fast-track process, acknowledge referral source, VIP treatment.

## Multi-Visit Patterns

### 2-Visit Journey (Most Common)

**Visit 1:** Discovery and research (5-8 pages, 8-12 min)
**Visit 2:** Decision and conversion (2-4 pages, 3-5 min)
**Gap:** 3-7 days median

**Optimization:**
- Email reminder at day 5
- Retargeting ads days 2-10
- Save state across sessions (calculator, cart)
- Personalized return experience

### 3-4 Visit Journey (High-Value Users)

**Visit 1:** Initial research → **Visit 2:** Deep dive → **Visit 3:** Comparison → **Visit 4:** Conversion

**Gap:** 1-3 weeks total

**Optimization:**
- Extended nurture sequence
- Progressive profiling
- Sales outreach at visit 3

### 5+ Visit Journey (Complex Decisions)

Characteristics: Enterprise, family decisions, high-value purchases, complex requirements. Timeline: 4-12 weeks.

**Optimization:** Dedicated account manager, custom proposals, consultation calls.

## Geographic Journey Variations

Different regions have different browsing behaviors. Use Umami's country/region filters to segment.

### Direct/Efficiency-Oriented Markets (US, UK, Australia)

| Metric | Typical |
|--------|---------|
| Pages per session | 4-6 |
| Visits to convert | 2-3 |
| Conversion rate | ~20% |
| Behavior | Calculator-heavy, fast decisions |

**Optimize for:** Streamlined process, clear CTAs, minimal steps.

### Thorough/Detail-Oriented Markets (Germany, Japan, Nordics)

| Metric | Typical |
|--------|---------|
| Pages per session | 10-15 |
| Visits to convert | 4-5 |
| Conversion rate | ~12% |
| Behavior | Documentation-heavy, compliance-focused |

**Optimize for:** Comprehensive docs, certifications, guarantees, long nurture.

### Relationship-Oriented Markets (LATAM, Southern Europe, Middle East)

| Metric | Typical |
|--------|---------|
| Pages per session | 7-9 |
| Visits to convert | 3-4 |
| Conversion rate | ~16% |
| Behavior | More content consumption, FAQ engagement |

**Optimize for:** Personal touch, testimonials, trust signals, localized content.

### Research-Intensive Markets (Brazil, India, Southeast Asia)

| Metric | Typical |
|--------|---------|
| Pages per session | 6-8 |
| Visits to convert | 2-3 |
| Conversion rate | ~18% |
| Behavior | Document-focused, calculator engagement |

**Optimize for:** Detailed documentation, clear process, mobile-first.

## Language-Based Variations

If your site is multilingual, track journey differences by `browser_language`:

| Language group | Avg pages | Avg visits | Conversion | Key trait |
|---------------|-----------|------------|------------|-----------|
| English | 4-6 | 2-3 | ~20% | Direct, efficiency-focused |
| Spanish | 8-10 | 3-4 | ~15% | Relationship-focused |
| Portuguese | 6-8 | 2-3 | ~18% | Research-intensive |
| German | 10-15 | 4-5 | ~12% | Extremely thorough |
| French | 7-9 | 3-4 | ~16% | Detail-oriented |

Use these as starting hypotheses — validate with your own Umami data.

## Content Path Analysis

### High-Converting Paths

| Path | Conversion | Why |
|------|-----------|-----|
| Blog → Related post → Product → Signup | ~25% | Educated, engaged |
| Guide download → Email sequence → Pricing → Signup | ~30% | Nurtured lead |
| Webinar → Replay → Product → Signup | ~35% | High trust |
| Referral → Product → Pricing → Signup | ~40% | Pre-qualified |

### Low-Converting Paths (Fix These)

| Path | Conversion | Problem | Fix |
|------|-----------|---------|-----|
| Homepage → About → Exit | ~2% | Not finding relevance | Better homepage nav |
| Pricing → Exit | ~5% | Price shock | Value justification, payment options |
| Random page → Exit | ~1% | Wrong audience | Better targeting, landing pages |

## Implementing in Umami

### Journey Report (API)
```typescript
const { data } = await client.createReport({
  websiteId: 'your-id',
  type: 'journey',
  parameters: {
    startDate: '2025-01-01T00:00:00Z',
    endDate: '2025-01-31T23:59:59Z',
    steps: 5,  // 3-7 steps
  },
  filters: { country: 'US' }  // Segment by geography
})
```

### Journey Report (Dashboard)
1. Reports → Create Report → Journey
2. Set step count (3-7)
3. Apply filters (country, device, referrer)
4. Compare segments side by side

### Segments for Journey Analysis

Create saved segments in Umami for recurring analysis:
- "Mobile US Users" — Device = Mobile, Country = US
- "Organic Search Traffic" — Referrer contains google.com
- "High Intent" — Viewed pricing page + calculator
- "Returning Visitors" — Visits > 1

## Optimization Strategies

### 1. Reduce Path Length
**Current:** Homepage → About → Features → Pricing → FAQ → Signup (6 steps)
**Optimized:** Homepage → Pricing → Signup (3 steps)

Put key decision tools (calculator, pricing) earlier in the journey. Expected: +20% conversion.

### 2. Content-to-Conversion Shortcuts
Create direct paths: Blog → Related Product → Signup. Add strategic CTAs in content. Expected: +25% content-driven conversions.

### 3. Multi-Visit Recovery
Save state across sessions. Email at day 5 if no return. Personalized return experience. Expected: +15% multi-visit conversions.

### 4. Mobile Journey Optimization
Simplified navigation, fewer form fields, click-to-call, thumb-friendly CTAs. Expected: +30% mobile conversions.

## Metrics to Track

| Metric | Benchmark | Direction |
|--------|-----------|-----------|
| Pages per session | 5-7 | Lower = more efficient |
| Steps to conversion | 3-5 | Lower = better |
| Multi-visit rate | 60-70% | Context-dependent |
| Days between visits | 3-7 | Shorter = better |
| Bounce rate | <40% | Lower = better |
| Time on site | 8-12 min | Context-dependent |
