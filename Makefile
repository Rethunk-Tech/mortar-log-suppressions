.PHONY: gate
gate:
	@for f in lists/*.json; do \
		jq -e '.game and (.entries | type == "array") and all(.entries[]; (.source | type == "string" and length > 0) and (.label | type == "string" and length > 0))' "$$f" >/dev/null || { echo "$$f: schema check failed" >&2; exit 1; }; \
	done
