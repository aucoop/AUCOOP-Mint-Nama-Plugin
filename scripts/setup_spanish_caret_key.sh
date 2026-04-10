#!/usr/bin/env bash

set -euo pipefail

XMODMAP_FILE="${HOME}/.Xmodmap"
XPROFILE_FILE="${HOME}/.xprofile"
AUTOSTART_DIR="${HOME}/.config/autostart"
AUTOSTART_FILE="${AUTOSTART_DIR}/nama-xmodmap.desktop"

write_xmodmap() {
  cat > "${XMODMAP_FILE}" <<'EOF'
keycode 34 = asciicircum asciicircum asciicircum asciicircum bracketleft braceleft bracketleft dead_abovering
EOF
}

apply_live_remap() {
  if command -v xmodmap >/dev/null 2>&1 && [ -n "${DISPLAY:-}" ]; then
    xmodmap "${XMODMAP_FILE}" || true
  fi
}

write_xprofile() {
  cat > "${XPROFILE_FILE}" <<'EOF'
# Reapply the Nama keyboard remap on X session startup.
if [ -f "$HOME/.Xmodmap" ] && command -v xmodmap >/dev/null 2>&1; then
  xmodmap "$HOME/.Xmodmap"
fi
EOF
}

write_autostart() {
  mkdir -p "${AUTOSTART_DIR}"

  cat > "${AUTOSTART_FILE}" <<'EOF'
[Desktop Entry]
Type=Application
Name=Nama Xmodmap
Exec=sh -c 'xmodmap "$HOME/.Xmodmap"'
X-GNOME-Autostart-enabled=true
NoDisplay=false
EOF
}

main() {
  write_xmodmap
  write_xprofile
  write_autostart
  apply_live_remap
  echo "Spanish caret-key remap setup complete."
}

main "$@"
