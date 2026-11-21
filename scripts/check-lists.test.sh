#!/bin/sh
set -eu
cd "$(dirname "$0")/.."

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# Source lists omit serial (publish stamps it). Check the shape Mortar loads.
for f in lists/*.json; do
  name=$(basename "$f")
  jq -c --argjson serial 1 '. + {serial: $serial}' "$f" >"$tmp/$name"
  sh scripts/check-lists.sh "$tmp/$name"
done

printf '%s\n' '{"game":"stardew-valley","serial":1,"entries":[{"source":"T::M","label":"x"}]}' >"$tmp/stardew.json"
if sh scripts/check-lists.sh "$tmp/stardew.json"; then
  echo "expected game/stem mismatch to fail" >&2
  exit 1
fi

printf '%s\n' '{"game":"stardew","serial":1,"entries":[{"source":"T::M","label":"x","text":5}]}' >"$tmp/stardew.json"
if sh scripts/check-lists.sh "$tmp/stardew.json"; then
  echo "expected a non-string text to fail" >&2
  exit 1
fi
