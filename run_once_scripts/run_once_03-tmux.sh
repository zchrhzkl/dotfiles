#!/bin/bash
# Install TPM and tmux plugins — runs once
set -e

# Install TPM
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "==> Installing TPM (tmux plugin manager)..."
  git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install plugins headlessly
echo "==> Installing tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins

echo "==> tmux setup complete."
