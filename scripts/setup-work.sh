#!/bin/bash
# One-time work environment setup: SSH key, git identity, OneDrive
set -e

echo ""
echo "==> Work environment setup"
echo ""

read -r -p "Company directory name (e.g. paper): " COMPANY
read -r -p "Work email: " WORK_EMAIL
read -r -p "SSH key filename (e.g. id_ed25519_paper): " SSH_KEY

KEY_FILE="$HOME/.ssh/$SSH_KEY"

# ── Git config ──────────────────────────────────────────────────────────────
echo ""
echo "==> Configuring git..."
git config --global user.name "Zachariah Ezekial"
git config --global user.email "$WORK_EMAIL"
git config --global core.sshCommand "ssh -o IdentitiesOnly=yes -o IdentityAgent=none -i $KEY_FILE"
git config --global includeIf."gitdir:~/$COMPANY/".path "~/.gitconfigs/work.gitconfig"

mkdir -p "$HOME/.gitconfigs"
cat > "$HOME/.gitconfigs/work.gitconfig" <<EOF
[user]
	email = $WORK_EMAIL
[core]
	sshCommand = ssh -i $KEY_FILE -F /dev/null
EOF
echo "==> Git configured."

# ── SSH key ─────────────────────────────────────────────────────────────────
if [ -f "$KEY_FILE" ]; then
  echo "==> SSH key already exists at $KEY_FILE, skipping download."
else
  echo ""
  read -r -p "==> Fetch SSH key from OneDrive? [y/N] " answer
  case "$answer" in
    [yY][eE][sS]|[yY]) ;;
    *)
      echo "==> Skipping SSH key download. Re-run this script when ready."
      exit 0
      ;;
  esac

  ONEDRIVE_SECRETS="dotfiles-secrets"
  ENCRYPTED="/tmp/${SSH_KEY}.age"

  if [[ "$(uname)" == "Darwin" ]]; then
    ONEDRIVE="$HOME/OneDrive"
    if [ ! -d "$ONEDRIVE" ]; then
      echo "ERROR: ~/OneDrive not found. Install OneDrive for Mac and sign in first."
      exit 1
    fi
    cp "$ONEDRIVE/$ONEDRIVE_SECRETS/${SSH_KEY}.age" "$ENCRYPTED"
  else
    if ! command -v rclone &>/dev/null; then
      echo "ERROR: rclone not found."
      exit 1
    fi
    if ! rclone listremotes | grep -q "^onedrive:"; then
      echo "ERROR: rclone OneDrive remote not configured."
      echo "Run: rclone config  (create a remote named 'onedrive')"
      exit 1
    fi
    rclone copy "onedrive:$ONEDRIVE_SECRETS/${SSH_KEY}.age" /tmp/
  fi

  if ! command -v age &>/dev/null; then
    echo "ERROR: age not found. Install it first."
    exit 1
  fi

  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
  echo "==> Decrypting SSH key..."
  age -d "$ENCRYPTED" > "$KEY_FILE"
  rm -f "$ENCRYPTED"
  chmod 600 "$KEY_FILE"

  if [ ! -f "${KEY_FILE}.pub" ]; then
    ssh-keygen -y -f "$KEY_FILE" > "${KEY_FILE}.pub"
  fi

  if [[ "$(uname)" == "Darwin" ]]; then
    ssh-add --apple-use-keychain "$KEY_FILE"
  else
    ssh-add "$KEY_FILE" 2>/dev/null || true
  fi

  echo "==> SSH key installed at $KEY_FILE"
  echo ""
  echo "Public key (add to GitHub/GitLab if this is a new machine):"
  cat "${KEY_FILE}.pub"
fi
