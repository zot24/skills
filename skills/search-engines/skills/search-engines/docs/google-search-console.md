<!-- Authored for this skill. Not synced from upstream.
     Endpoints from the API discovery documents:
     https://searchconsole.googleapis.com/$discovery/rest?version=v1
     https://www.googleapis.com/discovery/v1/apis/siteVerification/v1/rest -->

# Google Search Console

Goal: a **Domain property** (`sc-domain:acmewidgets.com`) verified by DNS, the sitemap submitted, and
the owner's own Google account listed as an owner so the property shows up in their Search Console.

A Domain property covers `https`, `http`, `www` and every subdomain in one place. Prefer it over a
URL-prefix property.

## Auth

A Google Cloud service account does the work. One-time owner setup:

1. In a Google Cloud project, enable **Google Search Console API** and **Site Verification API**.
2. Create a service account and a JSON key. Put the key in the agents' vault (see [secrets](secrets.md)).

Get a token with the right scopes (plain `gcloud auth print-access-token` lacks them):

```bash
export GOOGLE_APPLICATION_CREDENTIALS=/path/to/sa.json   # from the vault, never committed
GTOKEN=$(gcloud auth application-default print-access-token \
  --scopes=https://www.googleapis.com/auth/webmasters,https://www.googleapis.com/auth/siteverification)
GAUTH=(-H "Authorization: Bearer $GTOKEN" -H "Content-Type: application/json")
SV=https://www.googleapis.com/siteVerification/v1
WM=https://www.googleapis.com/webmasters/v3
SC=https://searchconsole.googleapis.com/v1
```

## 1. Verify the domain (DNS TXT)

```bash
# token to publish
curl -s -X POST "$SV/token" "${GAUTH[@]}" -d '{
  "site": {"type": "INET_DOMAIN", "identifier": "acmewidgets.com"},
  "verificationMethod": "DNS_TXT"
}' | jq -r .token            # google-site-verification=...
```

Add it as a TXT record on the apex with the `cloudflare-domains` skill (`name: "@"`, `content`: the
whole token string). Then verify — this makes the service account a verified owner:

```bash
curl -s -X POST "$SV/webResource?verificationMethod=DNS_TXT" "${GAUTH[@]}" -d '{
  "site": {"type": "INET_DOMAIN", "identifier": "acmewidgets.com"}
}' | jq '{id, owners}'
```

A failure right after adding the record is usually DNS propagation; wait a minute and retry. Keep the
TXT record forever: removing it unverifies the property.

## 2. Add the owner

```bash
ID=$(jq -rn --arg d "dns://acmewidgets.com" '$d|@uri')   # the id from the verify answer, URL-encoded
curl -s "$SV/webResource/$ID" "${GAUTH[@]}" | jq .owners
curl -s -X PATCH "$SV/webResource/$ID" "${GAUTH[@]}" \
  -d "{\"owners\": [\"$SA_EMAIL\", \"$GSC_OWNER_EMAIL\"]}"
```

`SA_EMAIL` is the service account's `client_email`; `GSC_OWNER_EMAIL` is the owner's Google account.
Both come from the environment. Send the full list: `owners` is replaced, not appended.

## 3. Add the property and the sitemap

```bash
P=$(jq -rn --arg p "sc-domain:acmewidgets.com" '$p|@uri')
curl -s -X PUT "$WM/sites/$P" "${GAUTH[@]}"
curl -s "$WM/sites" "${GAUTH[@]}" | jq '.siteEntry'

SM=$(jq -rn --arg s "https://acmewidgets.com/sitemap-index.xml" '$s|@uri')
curl -s -X PUT "$WM/sites/$P/sitemaps/$SM" "${GAUTH[@]}"
curl -s "$WM/sites/$P/sitemaps" "${GAUTH[@]}" | jq '.sitemap[] | {path, lastDownloaded, errors, warnings}'
```

Astro's `@astrojs/sitemap` writes `sitemap-index.xml`. Submit only after the site is live: Google
fetches it straight away.

## Existing property

When the owner already verified the domain by hand, skip steps 1–2. They add the service account in
Search Console → Settings → Users and permissions → Add user, permission **Owner**. Then step 3.

## Checks

URL inspection (what Google knows about one page):

```bash
curl -s -X POST "$SC/urlInspection/index:inspect" "${GAUTH[@]}" -d '{
  "inspectionUrl": "https://acmewidgets.com/pricing",
  "siteUrl": "sc-domain:acmewidgets.com"
}' | jq '.inspectionResult.indexStatusResult | {verdict, coverageState, lastCrawlTime, googleCanonical}'
```

Search performance (last 28 days, top queries):

```bash
curl -s -X POST "$WM/sites/$P/searchAnalytics/query" "${GAUTH[@]}" -d "{
  \"startDate\": \"$(date -d '-28 days' +%F)\", \"endDate\": \"$(date +%F)\",
  \"dimensions\": [\"query\"], \"rowLimit\": 25
}" | jq '.rows[] | {q: .keys[0], clicks, impressions, ctr, position}'
```

Data lags two to three days. A new site shows nothing for a week or two; that is normal.

The API cannot request indexing for a normal page. Ask the owner to use **Request indexing** in the
URL Inspection tool for the few pages that matter at launch.
