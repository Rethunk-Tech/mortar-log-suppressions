<h1 align="center">Mortar log suppressions</h1>

<div align="center">

[![CI](https://github.com/Rethunk-Tech/mortar-log-suppressions/actions/workflows/ci.yml/badge.svg)](https://github.com/Rethunk-Tech/mortar-log-suppressions/actions/workflows/ci.yml)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)

</div>

---

Each game has one file in `lists/`. That file names the log lines Mortar hides by default. Mortar downloads the list for each game a player has set up, checks its signature, then leaves those lines out of the Console. The game's bridge stops writing them where it can. A player can show any of them again in that game's Console settings.

```json
{
  "game": "lethal-company",
  "entries": [
    {
      "source": "Type::Method",
      "text": "The line's first line, each number written as #",
      "object": "Its/Hierarchy/Path",
      "label": "One line it hides, as the game wrote it."
    }
  ]
}
```

- `source` is required: the method that logged the line (`Type::Method`, as the BepInEx bridge tags it); for a line the engine logs itself, `unity:` and that line with its numbers masked; or for a line a mod writes under its own name, as SMAPI logs them, `mod:` and that name (`mod:SMAPI`, `mod:game`), with `text` set.
- `text` is optional: only the method's lines whose first line, masked, reads this. Empty is every line it logs.
- `object` is optional: only lines about that object. Empty is every object.
- `label` is required: a line it hides, shown in Mortar's list of hidden messages.

The entries are easiest to make in Mortar: right-click lines in the Console to hide them, then copy the game's `hiddenLogSources` from Mortar's `settings.json`. A push to `main` that changes a list publishes it: CI stamps a serial, minifies and signs it, and uploads `<game>.json`, `<game>.json.sig`, and `<game>.json.v2.sig` (the v2 signature covers the list name too) to the `lists` release.

## Quick start

```bash
make gate
```

Install, field rules, and publish notes are in [HUMANS.md](HUMANS.md).

## Highlights

- One JSON list per game under `lists/`.
- Mortar downloads each list and checks its signature before hiding those Console lines.
- `make gate` runs a `jq` check: `game` present, `entries` an array, and a non-empty `source` and `label` on each entry.
- A list change on `main` publishes the signed files to the `lists` release.

## Documentation

| Doc | What |
| --- | --- |
| [HUMANS.md](HUMANS.md) | Add or change a list, run `make gate`, how publish works |
| [AGENTS.md](AGENTS.md) | Layout, entry invariants, CI |
| [LICENSE](LICENSE) | Apache License 2.0 |

## License

Apache License 2.0. See [LICENSE](LICENSE). Copyright 2026 Rethunk.Tech, LLC.
