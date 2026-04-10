# Nama Compose Linux

Small Linux Mint friendly tooling for typing Khoekhoegowab (Nama) characters with a Compose key setup.

This repository was created to keep the keyboard setup separate from AUCOOP-Mint while the integration shape is still undecided.

## What It Does

- sets `Right Ctrl` as the Compose key
- writes a `~/.XCompose` file with Nama click and vowel mappings
- optionally remaps the Spanish dead-accent key so it types `^` directly
- persists the `^` remap at graphical login with `~/.Xmodmap`, `.xprofile`, and a desktop autostart entry

## Current Character Support

Clicks:

- `ǀ`
- `ǁ`
- `ǃ`
- `ǂ`

Circumflex vowels:

- `â Â`
- `î Î`
- `û Û`

Macron vowels:

- `ā Ā`
- `ē Ē`
- `ī Ī`
- `ō Ō`
- `ū Ū`

## Files

- `scripts/setup_nama_compose.sh`: installs Compose key and `~/.XCompose`
- `scripts/setup_spanish_caret_key.sh`: remaps the Spanish accent key to `^`
- `docs/user-cheatsheet.md`: simple end-user guide

## Usage

Run the Compose setup:

```bash
bash scripts/setup_nama_compose.sh
```

Run the Spanish keyboard caret remap:

```bash
bash scripts/setup_spanish_caret_key.sh
```

## Notes

- The caret remap is intended for the remote Nama Linux Mint computers, not for Spanish-language machines.
- Some desktop changes only apply fully after logging out and back in.
- `localectl` support may be unavailable on Debian-based Mint systems. The user-level setup still works through `gsettings`, `XCompose`, and `Xmodmap`.

## Possible AUCOOP-Mint Integration

One likely path is:

1. keep this repository standalone
2. add it as a git submodule, plugin source, or downloaded asset in AUCOOP-Mint
3. expose a post-install option such as `Enable Nama keyboard support`

That keeps the language-specific setup isolated from the base post-install toolkit.
