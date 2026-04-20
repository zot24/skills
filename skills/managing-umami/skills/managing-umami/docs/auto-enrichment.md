<!-- Source: Implementation patterns from production Umami deployments -->

# Auto-Enrichment Pattern

Automatically add device, viewport, and geolocation context to every tracked event.

## Problem

Manually adding context to every event is repetitive, inconsistent, and error-prone.

## Solution

Create an enhanced `trackEvent()` function that wraps `window.umami.track()` with automatic context injection.

## Implementation

### Step 1: Geolocation Utility

```typescript
// lib/analytics/geolocation.ts

export interface GeolocationData {
  city: string | null
  region: string | null
  country: string | null
  country_code: string | null
  timezone: string | null
}

let cachedGeoData: GeolocationData | null = null
let fetchPromise: Promise<GeolocationData> | null = null

export async function getGeolocation(): Promise<GeolocationData> {
  if (cachedGeoData) return cachedGeoData
  if (fetchPromise) return fetchPromise

  fetchPromise = fetch('https://ipapi.co/json/')
    .then(res => {
      if (!res.ok) throw new Error(`Geo API returned ${res.status}`)
      return res.json()
    })
    .then(data => {
      const geoData: GeolocationData = {
        city: data.city || null,
        region: data.region || null,
        country: data.country_name || null,
        country_code: data.country_code || null,
        timezone: data.timezone || null,
      }
      cachedGeoData = geoData
      return geoData
    })
    .catch(() => {
      const empty: GeolocationData = {
        city: null, region: null, country: null,
        country_code: null, timezone: null,
      }
      cachedGeoData = empty
      return empty
    })
    .finally(() => { fetchPromise = null })

  return fetchPromise
}
```

### Step 2: Enhanced Umami Component (Next.js)

```typescript
// components/umami.tsx
'use client'

import Script from 'next/script'
import { getGeolocation } from '@/lib/analytics/geolocation'

declare global {
  interface Window {
    umami?: {
      track: (name: string, data?: Record<string, string | number | boolean>) => void
      identify: (id: string | object, data?: object) => void
    }
  }
}

export function Umami() {
  const websiteId = process.env.NEXT_PUBLIC_UMAMI_WEBSITE_ID
  const scriptUrl = process.env.NEXT_PUBLIC_UMAMI_SCRIPT_URL
  if (!websiteId || !scriptUrl) return null

  return (
    <Script src={scriptUrl} data-website-id={websiteId}
      strategy="afterInteractive" defer />
  )
}

function getDeviceType(): 'mobile' | 'tablet' | 'desktop' {
  if (typeof window === 'undefined') return 'desktop'
  const ua = navigator.userAgent.toLowerCase()
  const w = window.innerWidth
  if (/mobile|android|iphone|ipod/i.test(ua) || w < 768) return 'mobile'
  if (/ipad|tablet/i.test(ua) || (w >= 768 && w < 1024)) return 'tablet'
  return 'desktop'
}

async function getStandardContext(): Promise<Record<string, string | number | boolean>> {
  const ctx: Record<string, string | number | boolean> = {}
  if (typeof window === 'undefined') return ctx

  ctx.device_type = getDeviceType()
  ctx.viewport_width = window.innerWidth
  ctx.viewport_height = window.innerHeight
  ctx.browser_language = navigator.language

  try {
    const geo = await getGeolocation()
    if (geo.city) ctx.city = geo.city
    if (geo.region) ctx.region = geo.region
    if (geo.country) ctx.country = geo.country
    if (geo.country_code) ctx.country_code = geo.country_code
    if (geo.timezone) ctx.timezone = geo.timezone
  } catch {}

  return ctx
}

/** Enhanced trackEvent with auto-enrichment */
export async function trackEvent(
  eventName: string,
  eventData?: Record<string, string | number | boolean>,
  options?: { skipContext?: boolean }
) {
  if (typeof window === 'undefined' || !window.umami?.track) return
  if (options?.skipContext) {
    window.umami.track(eventName, eventData)
    return
  }
  const ctx = await getStandardContext()
  window.umami.track(eventName, { ...ctx, ...eventData })
}

/** Synchronous version (no geo, for immediate tracking) */
export function trackEventSync(
  eventName: string,
  eventData?: Record<string, string | number | boolean>
) {
  if (typeof window === 'undefined' || !window.umami?.track) return
  const ctx: Record<string, string | number | boolean> = {
    device_type: getDeviceType(),
    viewport_width: window.innerWidth,
    viewport_height: window.innerHeight,
    browser_language: navigator.language,
  }
  window.umami.track(eventName, { ...ctx, ...eventData })
}
```

## Auto-Added Properties

| Property | Type | Source |
|----------|------|--------|
| `device_type` | string | User agent + viewport |
| `viewport_width` | number | `window.innerWidth` |
| `viewport_height` | number | `window.innerHeight` |
| `browser_language` | string | `navigator.language` |
| `city` | string | ipapi.co (async, cached) |
| `region` | string | ipapi.co (async, cached) |
| `country` | string | ipapi.co (async, cached) |
| `country_code` | string | ipapi.co (async, cached) |
| `timezone` | string | ipapi.co (async, cached) |

Geo data is fetched once per session and cached. If the API fails, events still fire without location.

## Usage

```typescript
// Before (manual, repetitive)
window.umami.track('button_clicked', {
  button_id: 'apply',
  device_type: getDeviceType(),
  viewport_width: window.innerWidth,
  city: geo.city,
  // ... repeated everywhere
})

// After (auto-enriched)
await trackEvent('button_clicked', { button_id: 'apply' })
// device_type, viewport, city, region, country all auto-added!
```

## Integration with umami.identify()

```typescript
// 1. Identify session context on page load
useEffect(() => {
  window.umami?.identify({
    session_type: isReturningUser() ? 'returning' : 'new',
    landing_page: window.location.pathname,
  })
  trackEvent('page_landed', { landing_page: window.location.pathname })
}, [])

// 2. Identify after conversion
window.umami?.identify(`lead-${leadId}`, {
  source: 'contact_form',
  qualified: true,
})
await trackEvent('form_submitted_success', { form_type: 'contact' })
```
