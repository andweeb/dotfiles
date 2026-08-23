---
name: vita3k-zip-prep
description: Rewraps PS Vita NoNpDrm dump ZIP files so RomM + Argosy Launcher + Vita3K ZX can install them — ensures the Title-ID folder sits at the ZIP root and the filename carries the Title ID in brackets. Use when preparing PS Vita ROM zips for a self-hosted RomM library.
argument-hint: "<zip-path> [zip-path-2 ...]"
---

# Vita3K ZIP Prep

Take one or more PS Vita NoNpDrm dump ZIPs and rewrap each so it's ready to drop into the psvita RomM library. Full background: `/Users/andrew/Vault/Personal/Games/Roms/Vita3K ZX Rom Setup Runbook.md`.

## Input

One or more ZIP file paths passed as arguments. Paths may be relative or absolute; expand `~` and resolve.

## What "ready" means

A ZIP is ready when:

1. The Title-ID folder (`PCSA…`, `PCSB…`, `PCSE…`, `PCSF…`, `PCSG…`, `PCSH…` + 5 digits) sits at the ZIP root — not nested under `app/` or any other outer folder.
2. `<TITLE_ID>/sce_sys/package/work.bin` is present inside the archive (the NoNpDrm license).
3. The filename matches `[<TITLE_ID>] <Game Name>.zip`.

If a file already meets all three, mark it done and move on. Do not repack unnecessarily.

## Processing

For each input ZIP:

### 1. Inspect

Use `unzip -l "<path>"` to list contents. Do NOT extract the full archive — these files are large (1–4 GB typical). Detect:

- **Title ID:** find the first path segment matching `^PCS[A-Z][0-9]{5}(/|$)` at any depth. If multiple, prompt the user to disambiguate.
- **Nesting depth:** how many path components precede the Title-ID folder. `0` means it's at root (good). `1` (e.g. `app/PCSE00899/…`) or more means needs repack.
- **License present:** confirm a `<TITLE_ID>/sce_sys/package/work.bin` entry exists. If not, warn loudly — the dump is unusable, don't repack, ask the user how to proceed.

### 2. Determine the game name

Priority order:

1. If the source filename already has `[<TITLE_ID>] <Name>.zip` shape, reuse the `<Name>`.
2. If the source filename is like `<Name> (USA).zip` or `<Name>.zip`, strip region tags and use that.
3. If neither yields a clean name, ask the user for the canonical game name (No-Intro style, e.g. `Odin Sphere Leifthrasir`).

Do NOT try to parse `param.sfo` — it's inside the encrypted PFS on some titles and unreliable to read from a zip listing.

### 3. Repack if nested (skip if already at root)

The `zip` CLI stores paths as given. To move the Title-ID folder to root, extract *only* that subtree, then re-zip from its parent:

```bash
# Example: input has app/PCSE00899/... nested
work_dir=$(mktemp -d)
unzip -q "<input.zip>" "app/PCSE00899/*" -d "$work_dir"
cd "$work_dir/app"
zip -qr "<output-path>" PCSE00899 -x "*.DS_Store"
rm -rf "$work_dir"
```

Adjust the `unzip` glob and the `cd` target to whatever the actual nesting is (could be `app/`, `dump/`, or bare Title-ID with just wrong filename).

If the Title-ID folder is already at root, don't touch the zip contents — just `cp` or `mv` to the new filename.

### 4. Name the output

`[<TITLE_ID>] <Game Name>.zip`

Write it into the same directory as the source unless the user specified otherwise. Do not overwrite the source zip unless the user confirmed; default is to write alongside with the new name and leave the original.

### 5. Verify

After each repack, run `unzip -l "<output>" | head -5` and confirm the first content entry starts with the Title-ID folder. Also grep for `work.bin`. Report both to the user as evidence the file is good.

### 6. Optional move to library

If the user has confirmed they want files moved to their psvita library, the standard destination is `/Volumes/Games/library/roms/psvita/`. Prompt for confirmation before moving. If declined, leave the file where it was written.

## Output to the user

For each input, print a compact status line:

```
✓ Rick Deckard's Odin.zip → [PCSE00899] Odin Sphere Leifthrasir.zip
  root: PCSE00899/  |  license: found  |  size: 1.9G
```

or a warning block if something needs the user's attention (missing license, ambiguous Title ID, unclear game name).

## Edge cases

- **Multiple Title-ID folders in one zip** (e.g. base game + update bundled): stop and ask which to package, or offer to produce multiple output files.
- **No Title-ID folder found:** the archive isn't a Vita dump. Report and skip.
- **Zip is actually a `.7z` or other format:** report and skip; this skill is `.zip` only.
- **Existing output filename already exists:** append a suffix or ask the user.
- **Source path has spaces:** quote everything.

## Related

- Runbook (manual process): `/Users/andrew/Vault/Personal/Games/Roms/Vita3K ZX Rom Setup Runbook.md`
- Argosy Launcher filename parsing: needs `[TITLE_ID]` or `TITLE_ID - ` in the name to launch by Title ID.
