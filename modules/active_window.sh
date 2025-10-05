#!/usr/bin/env bash
# Prints the focused window title (single-line) for Hyprland using hyprctl
# Exits silently if no focused window or hyprctl isn't available

set -euo pipefail

# If hyprctl supports JSON output, use it
if hyprctl activewindow -j >/dev/null 2>&1; then
  hyprctl activewindow -j 2>/dev/null \
    | sed -n 's/.*"title"[[:space:]]*:[[:space:]]*"\(.*\)".*/\1/p' \
    | sed 's/\\n/ /g' \
    | sed 's/^"\|"$//g'
else
  # Fallback parse: find a line containing "title:" and print after it
  hyprctl activewindow 2>/dev/null \
    | awk -F'title:' '{ if ($2) { print $2; exit } }' \
    | sed 's/^ *//; s/ *$//'
fi
