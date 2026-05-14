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

# Install plugins headlessly via a detached tmux session
echo "==> Installing tmux plugins..."
tmux new-session -d -s tpm_install 2>/dev/null || true
~/.tmux/plugins/tpm/bin/install_plugins
tmux kill-session -t tpm_install 2>/dev/null || true

echo "==> tmux setup complete."
