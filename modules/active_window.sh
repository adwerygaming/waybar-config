#!/usr/bin/env bash
# Prints the focused window title (single-line) for Hyprland using hyprctl
# Exits silently if no focused window or hyprctl isn't available

set -euo pipefail

rewrite_title() {
  local title="$1"
  if [[ "$title" =~ ^(.*)" - Visual Studio Code"$ ]]; then
    echo "🐞 ${BASH_REMATCH[1]}"
  elif [[ "$title" =~ ^"Visual Studio Code"$ ]]; then
    echo "🐞 VS Code"
  elif [[ "$title" =~ ^(.*)" - Mozilla Firefox"$ ]]; then
    echo "🌎 ${BASH_REMATCH[1]}"
  elif [[ "$title" =~ ^"Mozilla Firefox"$ ]]; then
    echo "🌎 Firefox"
  else
    echo "$title"
  fi
}

# If hyprctl supports JSON output, use it
if hyprctl activewindow -j >/dev/null 2>&1; then
  title=$(hyprctl activewindow -j 2>/dev/null \
    | sed -n 's/.*"title"[[:space:]]*:[[:space:]]*"\(.*\)".*/\1/p' \
    | head -1 \
    | sed 's/\\n/ /g' \
    | sed 's/^"\|"$//g')
else
  # Fallback parse: find a line containing "title:" and print after it
  title=$(hyprctl activewindow 2>/dev/null \
    | awk -F'title:' '{ if ($2) { print $2; exit } }' \
    | sed 's/^ *//; s/ *$//')
fi

rewrite_title "$title"
