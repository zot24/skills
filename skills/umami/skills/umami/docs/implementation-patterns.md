<!-- Source: Implementation patterns from production Umami deployments -->

# Implementation Patterns

Reusable tracking patterns for common UI interactions.

## Page/Section Tracking

### Landing page tracking
```typescript
useEffect(() => {
  trackEvent('page_landed', {
    landing_page: window.location.pathname,
    traffic_source: document.referrer ? new URL(document.referrer).hostname : 'direct',
  })
}, [])
```

### Section visibility (IntersectionObserver)
```typescript
useEffect(() => {
  const observer = new IntersectionObserver((entries) => {
    if (entries[0].isIntersecting) {
      trackEvent('section_viewed', { section: 'pricing' })
      observer.disconnect()
    }
  })
  observer.observe(sectionRef.current)
  return () => observer.disconnect()
}, [])
```

## Button & CTA Tracking

```typescript
<button onClick={() => {
  trackEvent('button_clicked', {
    button_id: 'cta_hero',
    location: 'hero_section',
  })
}}>
  Get Started
</button>
```

## Form Tracking (Full Lifecycle)

```typescript
// Form opened
trackEvent('form_opened', { form_type: 'contact', trigger: 'cta_button' })

// Field focused (track first interaction)
trackEvent('form_field_focused', { field: 'email' })

// Submission success
trackEvent('form_submitted_success', {
  form_type: 'contact',
  fields_count: 5,
  time_spent_seconds: Math.floor((Date.now() - formOpenTime) / 1000),
})

// Submission error
trackEvent('form_submitted_error', {
  form_type: 'contact',
  error_type: 'validation',
  error_fields: ['email', 'phone'],
})

// Abandonment (on unmount or navigation)
trackEvent('form_abandoned', {
  form_type: 'contact',
  fields_filled: 3,
  last_field: 'phone',
})
```

## Feature Interaction Tracking

```typescript
// Feature used
trackEvent('feature_interacted', {
  feature: 'pricing_calculator',
  action: 'calculate_clicked',
  tier: 'premium',
})
```

## User Identification Patterns

### Progressive identification
```typescript
// Step 1: Anonymous session context
window.umami?.identify({ session_type: 'anonymous', entry_point: 'landing' })

// Step 2: After engagement
window.umami?.identify({ session_type: 'engaged', feature_used: 'calculator' })

// Step 3: After conversion
window.umami?.identify(`lead-${leadId}`, {
  session_type: 'converted',
  conversion_point: 'inquiry_form',
})
```

### Privacy-safe IDs
```typescript
// ✅ Opaque identifiers
umami.identify('lead-a1b2c3d4')
umami.identify('user-xyz789')

// ❌ Never use PII
umami.identify('john@email.com')  // NO
umami.identify('John Smith')       // NO
```

## Links & Pixels (No-JS Tracking)

### Track document downloads
```html
<!-- Create tracked link in Umami dashboard, use in HTML -->
<a href="https://analytics.yoursite.com/links/guide-pdf">Download Guide</a>
```

### Track email opens
```html
<!-- Create pixel in Umami dashboard, embed in email -->
<img src="https://analytics.yoursite.com/pixel/campaign-jan"
     width="1" height="1" alt="" style="display:none" />
```

## Next.js Script Loading

```typescript
import Script from 'next/script'

<Script
  src={process.env.NEXT_PUBLIC_UMAMI_SCRIPT_URL}
  data-website-id={process.env.NEXT_PUBLIC_UMAMI_WEBSITE_ID}
  strategy="afterInteractive"
  defer
/>
```

**Performance impact:** Zero on FCP, LCP, and TTI. Script is ~2KB.

## Conversion Funnel Pattern

Design funnels as progressive stages:

```
Page View (baseline)
  ↓
Interest Signal (feature interaction)
  ↓
Intent Signal (pricing viewed)
  ↓
Action Signal (CTA clicked)
  ↓
Commitment Signal (form opened)
  ↓
Conversion (form submitted)
```

Map each stage to a tracked event. Measure drop-off between stages. Optimize the highest drop-off transitions first.

## Privacy & GDPR

**What Umami collects:** Page views, custom events, device info, country/city (anonymized IP), session data.

**What Umami does NOT collect:** PII, cookies, cross-site tracking, behavioral profiling.

**No consent banner required** — Umami is cookieless by design.

## Best Practices

✅ **Track:** User intent signals, conversion points, engagement metrics, error states
❌ **Don't track:** Every mouse movement, every scroll pixel, PII, excessive detail

## Troubleshooting

1. **Events not appearing:** Check `window.umami` exists, verify website ID, check ad blockers
2. **Missing geo context:** Ensure `trackEvent` is awaited, check ipapi.co not blocked
3. **Script not loading:** Verify env vars, check CSP headers, try `strategy="afterInteractive"`
