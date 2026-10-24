# Mortar log suppressions

One file per game in `lists/`, naming game log lines Mortar hides by default. Mortar downloads the list of each game a
player has set up and checks its signature. It then leaves those lines out of the Console, and the game's bridge
stops writing them where it can. A player can show any of them again in the game's Console settings.

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

- `source` is required: the method that logged the line (`Type::Method`, as the BepInEx bridge tags it), or for a line
  the engine logs itself, `unity:` and that line with its numbers masked.
- `text` is optional: only the method's lines whose first line, masked, reads this. Empty is every line it logs.
- `object` is optional: only lines about that object. Empty is every object.
- `label` is required: a line it hides, shown in Mortar's list of hidden messages.

The entries are easiest to make in Mortar: right-click lines in the Console to hide them, then copy the game's
`hiddenLogSources` from Mortar's `settings.json`.

A push to `main` that changes a list publishes it: CI stamps a serial, minifies and signs it, and uploads
`<game>.json` and `<game>.json.sig` to the `lists` release.
