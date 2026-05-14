# dotfiles

Personal environment bootstrap managed by [chezmoi](https://chezmoi.io).

Targets: **macOS** (primary) and **Linux / OrbStack VM** (secondary).

## Quick start

### macOS
```sh
brew install chezmoi age
chezmoi init --apply git@github.com:zchrhzkl/dotfiles
```

> No SSH key? Use HTTPS instead:
> ```sh
> chezmoi init --apply https://github.com/zchrhzkl/dotfiles.git
> ```

### Linux
```sh
# Install rclone and configure OneDrive remote first (one-time)
curl https://rclone.org/install.sh | sudo bash
rclone config   # create a remote named "onedrive" using Microsoft OneDrive

# Bootstrap
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:zchrhzkl/dotfiles
```

> No SSH key? Use HTTPS instead:
> ```sh
> sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/zchrhzkl/dotfiles.git
> ```

## One-time setup (on existing machine)

Encrypt your SSH key and upload it to OneDrive:

```sh
mkdir -p ~/OneDrive/dotfiles-secrets
age -p ~/.ssh/id_ed25519_company_name > ~/OneDrive/dotfiles-secrets/id_ed25519_company_name.age
```

## What's managed

| File | Description |
|---|---|
| `~/.zshrc` | Shell config — macOS (antidote + p10k) vs Linux (oh-my-zsh) |
| `~/.zsh_plugins.txt` | antidote plugin list (macOS only) |
| `~/.p10k.zsh` | Powerlevel10k prompt config (macOS only) |
| `~/.gitconfig` | Git config — shared push settings + Linux user/SSH |
| `~/.gitconfigs/work.gitconfig` | Work-specific git identity + SSH key |
| `~/.config/tmux/tmux.conf` | tmux — Ctrl+a prefix, catppuccin, session persistence |
| `~/.config/nvim/` | Neovim / LazyVim config |
| `~/.config/gh/config.yml` | GitHub CLI config |
| `~/.config/helm/repositories.yaml` | Helm repos |

## On every `chezmoi apply`

- `run_once_01`: installs packages (`brew bundle` on macOS, `apt` + manual on Linux)
- `run_once_02`: installs oh-my-zsh + plugins (Linux only)
- `run_once_03`: installs TPM + tmux plugins
- `run_once_04`: fetches age-encrypted SSH key from OneDrive, decrypts, loads into agent

> `run_once_` scripts execute **once ever** per machine (chezmoi tracks by content hash).  
> They re-run only if the script content changes — all scripts are idempotent.

## Useful chezmoi commands

```sh
chezmoi diff                    # preview what would change
chezmoi apply                   # apply changes
chezmoi managed                 # list all managed files
chezmoi edit ~/.zshrc           # edit source file and apply
chezmoi update                  # pull latest from git + apply
```

## Changing companies

Edit `~/.config/chezmoi/chezmoi.toml` and update `company`, `workEmail`, `sshKey`.  
Then encrypt your new SSH key and upload it to OneDrive under `dotfiles-secrets/`.
