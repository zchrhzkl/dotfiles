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
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:zchrhzkl/dotfiles
```

> No SSH key? Use HTTPS instead:
> ```sh
> sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/zchrhzkl/dotfiles.git
> ```

## What's managed

| File | Description |
|---|---|
| `~/.zshrc` | Shell config — shared; zsh plugins from Homebrew (macOS) or git clone (Linux) |
| `~/.config/starship.toml` | Starship prompt config (shared by both platforms) |
| `~/.gitconfig` | Git config — shared push settings |
| `~/.config/tmux/tmux.conf` | tmux — Ctrl+a prefix, catppuccin, session persistence |
| `~/.config/nvim/` | Neovim / LazyVim config |
| `~/.config/ghostty/config` | Ghostty — Nerd Font family (needed for starship's glyphs) |
| `~/.config/gh/config.yml` | GitHub CLI config |
| `~/.config/helm/repositories.yaml` | Helm repos |

## On every `chezmoi apply`

Bootstrap scripts live in `.chezmoiscripts/` — chezmoi runs them and writes no
corresponding file into `$HOME`.

- `run_once_01`: installs packages (`brew bundle` on macOS, `apt` + manual on Linux)
- `run_once_02`: clones zsh plugins to `~/.local/share/zsh/plugins` (Linux only — macOS gets them from Homebrew)
- `run_once_03`: installs TPM + tmux plugins

`Brewfile` and `README.md` are listed in `.chezmoiignore` — they are repo-only
and are never copied into `$HOME`.

> `run_once_` scripts execute **once ever** per machine (chezmoi tracks by content hash).  
> They re-run only if the script content changes — all scripts are idempotent.

## Useful chezmoi commands

The source directory is recorded in `~/.config/chezmoi/chezmoi.toml` at
`chezmoi init` time, so plain `chezmoi` commands work from anywhere —
no `--source` flag needed. Check it with `chezmoi source-path`.

```sh
chezmoi diff                    # preview what would change
chezmoi apply                   # apply changes
chezmoi managed                 # list all managed files
chezmoi edit ~/.zshrc           # edit source file and apply
chezmoi update                  # pull latest from git + apply
```
