#!/bin/bash
# Install TPM and tmux plugins — runs once
set -e

if ! command -v tmux &>/dev/null; then
  echo "==> tmux not found, skipping plugin install (run chezmoi apply again after tmux is installed)."
  exit 0
fi

# Install TPM
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "==> Installing TPM (tmux plugin manager)..."
  git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Clone plugins directly from tmux.conf — avoids needing a live tmux server
echo "==> Installing tmux plugins..."
tmux_conf="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"
# This script is run_once_after_ so tmux.conf is already applied. Fail loudly
# rather than silently cloning nothing if that ordering ever changes.
if [ ! -f "$tmux_conf" ]; then
  echo "==> ERROR: $tmux_conf not found — cannot read plugin list." >&2
  exit 1
fi
grep -E 'set -g @plugin' "$tmux_conf" | sed "s/.*'\(.*\)'/\1/" | while read -r plugin; do
  dir="$HOME/.tmux/plugins/${plugin##*/}"
  if [ ! -d "$dir" ]; then
    echo "  Cloning $plugin..."
    git clone --depth=1 "https://github.com/$plugin" "$dir"
  fi
done

echo "==> tmux setup complete."
