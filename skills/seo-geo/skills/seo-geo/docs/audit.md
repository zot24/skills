<!-- Authored for this skill. Not synced from upstream. -->

# Audit

Run before launch (on the production build) and on any existing site the owner asks about. Each line
is a check with a command; report failures only, each with the page and the fix.

```bash
SITE=https://acmewidgets.com
```

## Crawlability

| Check | Command | Pass |
|---|---|---|
| robots.txt allows crawling | `curl -s $SITE/robots.txt` | no `Disallow: /` under `User-agent: *` |
| Sitemap listed and live | `curl -s -o /dev/null -w '%{http_code}' $SITE/sitemap-index.xml` | 200, listed in robots.txt |
| No stray noindex | `curl -s $SITE/ \| grep -i 'name="robots"'`; `curl -sI $SITE/ \| grep -i x-robots-tag` | nothing on indexable pages |
| www redirects | `curl -sI https://www.acmewidgets.com/ \| grep -i location` | 301 → apex |
| http redirects | `curl -sI http://acmewidgets.com/ \| head -1` | 301 |
| 404 is a 404 | `curl -s -o /dev/null -w '%{http_code}' $SITE/nope` | 404 |
| AI bots not blocked | see [ai-crawlers](ai-crawlers.md) → Verify | 200 for Search and Agent bots |

## Every page in the sitemap

```bash
curl -s $SITE/sitemap-0.xml | grep -o '<loc>[^<]*' | sed 's/<loc>//' > /tmp/urls.txt
while read -r u; do
  html=$(curl -s "$u")
  t=$(printf '%s' "$html" | grep -o '<title>[^<]*' | sed 's/<title>//')
  c=$(printf '%s' "$html" | grep -o '<link rel="canonical" href="[^"]*' | sed 's/.*href="//')
  h=$(printf '%s' "$html" | grep -c '<h1')
  j=$(printf '%s' "$html" | grep -c 'application/ld+json')
  printf '%s\t%s\t%s\th1=%s\tjsonld=%s\n' "$u" "${#t}" "$([ "$c" = "$u" ] && echo ok || echo "canon=$c")" "$h" "$j"
done < /tmp/urls.txt
```

Pass: title length 30–60, canonical equals the URL, exactly one `h1`, exactly one JSON-LD block.
Duplicate titles or descriptions across pages fail.

## Content and GEO

- `/llms.txt` exists, starts with `# `, has a `> ` summary ([llms-txt](llms-txt.md)).
- JSON-LD validates; `Organization.sameAs` lists the official profiles ([structured-data](structured-data.md)).
- Money pages answer their primary question in the first two sentences ([answer-first-content](answer-first-content.md)).
- OG image renders: paste the URL in a social card preview.

## Performance

```bash
npx lighthouse $SITE --only-categories=performance,seo,accessibility --form-factor=mobile \
  --output=json --quiet --chrome-flags="--headless" | jq '.categories | map_values(.score)'
```

Pass: SEO 1.0, Performance ≥ 0.9, Accessibility ≥ 0.9. The `sites` template CI runs this on every PR
against the preview URL.

## After launch

Indexing and query data live in the `search-engines` skill (monitoring). Traffic and behaviour live
in `umami`. This audit covers what the site itself serves.
