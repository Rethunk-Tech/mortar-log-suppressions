# AGENTS.md

Signed lists of game log lines Mortar hides in its Console by default, one file per game in `lists/` (`lethal-company.json`, `stardew.json`). The entry format is documented in `README.md`.

## Layout

- `lists/<game>.json`: `{"game": "...", "entries": [...]}`, each entry with `source` and `label` required and `text` and `object` optional.
- `Makefile`: `make gate` runs a `jq` check over every list: `game` present, `entries` an array, and a non-empty `source` and `label` on each entry. It stops at the first bad file.
- `.github/workflows/publish.yml`: on a push to `main` that changes a list, stamps a serial, minifies, signs with the `MORTAR_UPDATE_KEY` secret and uploads `<game>.json`, `.sig` and `.v2.sig` to the `lists` release. `ci.yml` runs the gate.

## Gate

`gate` runs `make gate` through `.gate.toml`.

## Invariants

- `source` names the logging method as `Type::Method`, or `unity:<masked line>` for an engine line, or `mod:<name>` with `text` set for a mod's own log. `text` has its numbers masked as `#`.
- Entries are best made in Mortar: hide lines in the Console, then copy `hiddenLogSources` from Mortar's `settings.json`.
- Merging to `main` publishes to every player; never commit the update key or a signature.
