<!-- Source: Implementation patterns from production Umami deployments -->

# Event Taxonomy & Naming Conventions

## Naming Format

```
action_subject
```

Use `snake_case` — all lowercase with underscores.

## Good vs Bad Names

```
✅ button_clicked        ❌ view (too vague)
��� form_submitted        ❌ clickButton (camelCase)
✅ feature_enabled       ❌ click (missing subject)
✅ section_viewed        ❌ form (missing action)
✅ tier_selected         ❌ user_clicked_the_submit_button (too long)
```

## Event Categories

### Navigation
`page_viewed`, `page_loaded`, `link_clicked`, `menu_opened`, `menu_closed`, `back_button_clicked`

### Engagement
`button_clicked`, `section_viewed`, `video_played`, `video_paused`, `image_expanded`, `faq_expanded`, `tab_switched`

### Conversion
`form_opened`, `form_field_focused`, `form_submitted_success`, `form_submitted_error`, `form_abandoned`, `signup_started`, `signup_completed`

### Feature Usage
`feature_viewed`, `feature_interacted`, `feature_enabled`, `feature_disabled`, `calculator_used`, `filter_applied`, `search_performed`

### Commerce
`product_viewed`, `product_added`, `cart_viewed`, `checkout_started`, `purchase_completed`

### Error
`error_encountered`, `validation_failed`, `api_error`, `load_failed`

## Property Naming

Properties also use `snake_case`:

```typescript
trackEvent('button_clicked', {
  button_id: 'cta_apply',           // ✅ snake_case
  button_location: 'hero_section',  // ✅ snake_case
  buttonId: 'cta_apply',            // ❌ camelCase
  'button-id': 'cta_apply',         // ❌ kebab-case
})
```

### Property Best Practices

**Always include location** for multi-instance elements:
```typescript
trackEvent('button_clicked', {
  button_id: 'apply_now',
  location: 'hero' | 'footer' | 'sidebar'
})
```

**Use consistent types:**
- Booleans for toggles: `enabled: true`
- Strings for categorical: `tier: 'free' | 'pro' | 'enterprise'`
- Numbers for quantitative: `quantity: 5`, `price: 29.99`

**Keep properties actionable** — enable filtering, segmenting, and optimization.

## Central Event Registry

Maintain a single source of truth to prevent typos and enable auto-completion:

```typescript
// lib/analytics/events.ts
export const EVENTS = {
  // Navigation
  PAGE_VIEWED: 'page_viewed',
  LINK_CLICKED: 'link_clicked',
  
  // Engagement
  BUTTON_CLICKED: 'button_clicked',
  SECTION_VIEWED: 'section_viewed',
  
  // Conversion
  FORM_OPENED: 'form_opened',
  FORM_SUBMITTED_SUCCESS: 'form_submitted_success',
  FORM_SUBMITTED_ERROR: 'form_submitted_error',
  FORM_ABANDONED: 'form_abandoned',
  
  // Features
  FEATURE_VIEWED: 'feature_viewed',
  FEATURE_INTERACTED: 'feature_interacted',
} as const

// Usage
import { EVENTS } from '@/lib/analytics/events'
trackEvent(EVENTS.BUTTON_CLICKED, { button_id: 'cta_apply' })
```

## Naming Decision Tree

```
1. What action occurred?  → verb in past tense (clicked, viewed, submitted)
2. What was the subject?  → noun (button, form, feature, page)
3. Combine: action_subject
4. Add properties for context: what, where, how
```

## Event Data Constraints (Umami)

| Type | Limit |
|------|-------|
| Numbers | 4 decimal places |
| Strings | 500 characters max |
| Arrays | 500 chars (converted to string) |
| Objects | 50 properties max |

## Event Lifecycle

- **Stable** — Don't rename often (breaks historical analysis)
- **Versioned** — If renaming, keep old + new for transition period
- **Documented** — Track changes in taxonomy evolution log
