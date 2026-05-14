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

# Install plugins headlessly
echo "==> Installing tmux plugins..."
tmux start-server
~/.tmux/plugins/tpm/bin/install_plugins
tmux kill-server 2>/dev/null || true

echo "==> tmux setup complete."
