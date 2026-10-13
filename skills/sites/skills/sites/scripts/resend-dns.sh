#!/usr/bin/env bash
# Copy a Resend domain's DNS records into its Cloudflare zone, add DMARC if missing, then verify.
# Usage: resend-dns.sh <domain> [--dry-run]
# Needs: resend CLI, cf CLI (Cloudflare), jq; RESEND_API_KEY (full access), CLOUDFLARE_API_TOKEN (DNS edit).
# Prints record names and types only, never values or tokens.
set -euo pipefail

domain=${1:?usage: resend-dns.sh <domain> [--dry-run]}
dry=${2:-}

id=$(resend domains list -q --limit 100 | jq -r --arg d "$domain" '.data[] | select(.name == $d) | .id' | head -1)
[ -n "$id" ] || { echo "no Resend domain $domain: run resend domains create --name $domain first" >&2; exit 1; }

# Resend gives names relative to the domain ("send", "resend._domainkey"); Cloudflare wants FQDNs.
fqdn() { case $1 in "$domain"|*".$domain") echo "$1" ;; "@"|"") echo "$domain" ;; *) echo "$1.$domain" ;; esac; }

upsert() { # type name content [priority]
  local type=$1 name=$2 content=$3 prio=${4:-} body existing
  body=$(jq -nc --arg t "$type" --arg n "$name" --arg c "$content" --arg p "$prio" \
    '{type:$t, name:$n, content:$c, ttl:1, proxied:false} + (if $p == "" then {} else {priority:($p|tonumber)} end)')
  existing=$(cf dns records list -z "$domain" --type "$type" --name "$name" | jq -r '.[0].id // empty')
  if [ -n "$dry" ]; then echo "would ${existing:+update}${existing:-create} $type $name"; return; fi
  if [ -n "$existing" ]; then
    cf dns records edit "$existing" -z "$domain" --body "$body" >/dev/null && echo "updated $type $name"
  else
    cf dns records create -z "$domain" --body "$body" >/dev/null && echo "created $type $name"
  fi
}

resend domains get "$id" -q | jq -c '.records[]' | while read -r r; do
  upsert "$(jq -r .type <<<"$r")" "$(fqdn "$(jq -r .name <<<"$r")")" "$(jq -r .value <<<"$r")" "$(jq -r '.priority // empty' <<<"$r")"
done

# DMARC: start at p=none and never replace one the owner already has.
if [ "$(cf dns records list -z "$domain" --type TXT --name "_dmarc.$domain" | jq 'length')" = 0 ]; then
  upsert TXT "_dmarc.$domain" "v=DMARC1; p=none"
fi

[ -n "$dry" ] && exit 0
resend domains verify "$id" -q >/dev/null
for _ in $(seq 1 30); do
  status=$(resend domains get "$id" -q | jq -r .status)
  echo "status: $status"
  [ "$status" = verified ] && exit 0
  [ "$status" = failed ] && exit 1
  sleep 20
done
echo "still $status after 10 minutes: run resend domains get $id later" >&2
exit 2
