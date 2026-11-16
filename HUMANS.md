# HUMANS

How to add or change a default log-suppression list for Mortar.

## Quick start

Edit `lists/<game>.json`. Each file is `{"game": "...", "entries": [...]}`. Every entry needs `source` and `label`; `text` and `object` are optional. `source` is `Type::Method`, or `unity:<masked line>` for an engine line, or `mod:<name>` with `text` set for a mod's own log. Mask numbers in `text` as `#`.

The usual way to make entries is in Mortar: hide lines in the Console, then copy `hiddenLogSources` from Mortar's `settings.json` into the list.

Check the lists:

```bash
make gate
```

That runs a `jq` check over every file in `lists/`: `game` present, `entries` an array, and a non-empty `source` and `label` on each entry. It stops at the first bad file.

## Install

There is nothing to install from this repo. Mortar pulls the signed lists from the `lists` GitHub release. Merging a list change to `main` publishes `<game>.json`, `.sig`, and `.v2.sig` for every player.

## Environment

Publish on `main` uses the `MORTAR_UPDATE_KEY` GitHub Actions secret. Do not commit the update key or a signature.

## Verify

```bash
make gate
```

CI runs the same check via `.github/workflows/ci.yml` and `.gate.toml`.

## Uninstall

Remove the game's file from `lists/` and merge to `main`. Mortar will stop shipping that list on the next publish.
