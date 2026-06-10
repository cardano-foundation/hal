#!/usr/bin/env bash
#
# node-currency-check.sh — daily reminder that a running cardano-node is behind
# the latest IntersectMBO/cardano-node release.
#
# Why: preprod/preview hard-fork ahead of mainnet. A node pinned to an old
# version becomes an `ObsoleteNode` at the fork, freezes, and silently stalls
# everything downstream (ogmios -> yaci-store -> mpfs -> moog oracle). This warns
# via Telegram so the node gets bumped *before* the next fork. The gatus
# "Cardano node head" check is the reactive counterpart (fires once frozen).
#
# Idempotent: alerts only when the (latest release, set of behind nodes) changes,
# so a daily cron does not spam. Sends a one-off confirmation when all nodes are
# current again.
#
# Usage: node-currency-check.sh <telegram-env-file> [state-file]
#   <telegram-env-file> defines TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID.
#
# Needs: bash, curl, docker (read access), coreutils (sort -V). No jq.

set -euo pipefail

ENV_FILE="${1:?usage: node-currency-check.sh <telegram-env-file> [state-file]}"
STATE_FILE="${2:-${XDG_STATE_HOME:-$HOME/.local/state}/node-currency-check.state}"
REPO="IntersectMBO/cardano-node"
HOST="$(hostname -s 2>/dev/null || hostname)"

# shellcheck disable=SC1090
set -a; . "$ENV_FILE"; set +a
: "${TELEGRAM_BOT_TOKEN:?missing TELEGRAM_BOT_TOKEN in $ENV_FILE}"
: "${TELEGRAM_CHAT_ID:?missing TELEGRAM_CHAT_ID in $ENV_FILE}"

# Latest non-prerelease tag (jq-free parse of the GitHub API). Fetch into a
# variable first: piping straight into `grep -m1` closes the pipe early and
# curl exits 23 under `pipefail`.
release_json="$(curl -fsS "https://api.github.com/repos/$REPO/releases/latest")"
latest="$(printf '%s\n' "$release_json" \
  | grep -m1 '"tag_name"' | sed -E 's/.*"tag_name":[[:space:]]*"([^"]+)".*/\1/')"
[ -n "$latest" ] || { echo "could not resolve latest $REPO release" >&2; exit 1; }

# Running cardano-node containers -> flag any whose tag sorts before latest.
behind=""
while read -r name image; do
  case "$image" in
    *intersectmbo/cardano-node:*) ver="${image##*:}" ;;
    *) continue ;;
  esac
  if [ "$ver" != "$latest" ] \
     && [ "$(printf '%s\n%s\n' "$ver" "$latest" | sort -V | head -1)" = "$ver" ]; then
    behind="${behind}  - ${name}: ${ver}"$'\n'
  fi
done < <(docker ps --format '{{.Names}} {{.Image}}')

sig="latest=${latest}
${behind}"
prev="$(cat "$STATE_FILE" 2>/dev/null || true)"
[ "$sig" = "$prev" ] && exit 0   # nothing changed since last alert

if [ -z "${DRY_RUN:-}" ]; then
  mkdir -p "$(dirname "$STATE_FILE")"
  printf '%s' "$sig" > "$STATE_FILE"
fi

send() {
  if [ -n "${DRY_RUN:-}" ]; then
    printf '[DRY_RUN] would send to telegram:\n%s\n' "$1"
    return
  fi
  curl -fsS -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
    --data-urlencode "chat_id=${TELEGRAM_CHAT_ID}" \
    --data-urlencode "text=$1" -o /dev/null
}

if [ -n "$behind" ]; then
  send "$(printf '⚠️ cardano-node behind latest on %s\nlatest release: %s\n\n%s\nbump before the next preprod/preview hard fork.' \
    "$HOST" "$latest" "$behind")"
else
  send "$(printf '✅ cardano-node current on %s: all nodes at %s' "$HOST" "$latest")"
fi
