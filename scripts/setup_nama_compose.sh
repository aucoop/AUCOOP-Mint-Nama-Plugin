#!/usr/bin/env bash

set -euo pipefail

COMPOSE_OPTION="compose:rctrl"
XCOMPOSE_FILE="${HOME}/.XCompose"

set_compose_key() {
  local applied=0

  if command -v gsettings >/dev/null 2>&1; then
    if gsettings writable org.cinnamon.desktop.input-sources xkb-options >/dev/null 2>&1; then
      gsettings set org.cinnamon.desktop.input-sources xkb-options "['${COMPOSE_OPTION}']" && applied=1 || true
    fi

    if gsettings writable org.mate.peripherals-keyboard-xkb.kbd options >/dev/null 2>&1; then
      gsettings set org.mate.peripherals-keyboard-xkb.kbd options "['${COMPOSE_OPTION}']" && applied=1 || true
    fi

    if gsettings writable org.gnome.desktop.input-sources xkb-options >/dev/null 2>&1; then
      gsettings set org.gnome.desktop.input-sources xkb-options "['${COMPOSE_OPTION}']" && applied=1 || true
    fi
  fi

  if command -v setxkbmap >/dev/null 2>&1 && [ -n "${DISPLAY:-}" ]; then
    setxkbmap -option "${COMPOSE_OPTION}" && applied=1 || true
  fi

  if command -v localectl >/dev/null 2>&1; then
    localectl set-x11-keymap "" "" "" "${COMPOSE_OPTION}" && applied=1 || true
  fi

  if [ "${applied}" -eq 0 ]; then
    echo "Warning: no Compose key command could be applied in the current environment." >&2
  fi
}

write_xcompose() {
  cat > "${XCOMPOSE_FILE}" <<'EOF'
include "%L"

<Multi_key> <c> <1> : "ǀ" U01C0 # Dental Click
<Multi_key> <c> <2> : "ǁ" U01C1 # Lateral Click
<Multi_key> <c> <3> : "ǃ" U01C3 # Alveolar Click
<Multi_key> <c> <4> : "ǂ" U01C2 # Palatal Click

<Multi_key> <asciicircum> <a> : "â" U00E2 # Circumflex a
<Multi_key> <asciicircum> <A> : "Â" U00C2 # Circumflex A
<Multi_key> <asciicircum> <i> : "î" U00EE # Circumflex i
<Multi_key> <asciicircum> <I> : "Î" U00CE # Circumflex I
<Multi_key> <asciicircum> <u> : "û" U00FB # Circumflex u
<Multi_key> <asciicircum> <U> : "Û" U00DB # Circumflex U

<Multi_key> <dead_circumflex> <a> : "â" U00E2 # Circumflex a fallback
<Multi_key> <dead_circumflex> <A> : "Â" U00C2 # Circumflex A fallback
<Multi_key> <dead_circumflex> <i> : "î" U00EE # Circumflex i fallback
<Multi_key> <dead_circumflex> <I> : "Î" U00CE # Circumflex I fallback
<Multi_key> <dead_circumflex> <u> : "û" U00FB # Circumflex u fallback
<Multi_key> <dead_circumflex> <U> : "Û" U00DB # Circumflex U fallback

<Multi_key> <minus> <a> : "ā" U0101 # Macron a
<Multi_key> <minus> <A> : "Ā" U0100 # Macron A
<Multi_key> <minus> <e> : "ē" U0113 # Macron e
<Multi_key> <minus> <E> : "Ē" U0112 # Macron E
<Multi_key> <minus> <i> : "ī" U012B # Macron i
<Multi_key> <minus> <I> : "Ī" U012A # Macron I
<Multi_key> <minus> <o> : "ō" U014D # Macron o
<Multi_key> <minus> <O> : "Ō" U014C # Macron O
<Multi_key> <minus> <u> : "ū" U016B # Macron u
<Multi_key> <minus> <U> : "Ū" U016A # Macron U
EOF
}

main() {
  set_compose_key
  write_xcompose
  echo "Compose key setup complete."
  echo "XCompose file written to ${XCOMPOSE_FILE}"
}

main "$@"
