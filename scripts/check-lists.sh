#!/bin/sh
set -eu

check() {
	file=$1
	stem=$(basename "$file" .json)
	jq -e --arg game "$stem" '
		.game == $game
		and (.serial | type == "number" and . != 0)
		and (.entries | type == "array")
		and all(.entries[]; (.source | type == "string" and length > 0) and (.label | type == "string" and length > 0))
	' "$file" > /dev/null
}

for f in "$@"; do
	check "$f" || { echo "$f: schema check failed" >&2; exit 1; }
done
