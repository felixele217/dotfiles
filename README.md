# dotfiles — "the ship" ⚓

Personal development setup: [Ghostty](https://ghostty.org/) terminal,
[tmux](https://github.com/tmux/tmux) (sessions-as-tabs), and a fresh
[LazyVim](https://www.lazyvim.org/) Neovim config — all themed with
[rose-pine](https://rosepinetheme.com/).

## 📖 Read the guide

**→ [GUIDE.md](./GUIDE.md)** — a complete, skimmable reference for every
keybinding and shortcut across Ghostty, tmux, and Neovim, organised by tool and
by task ("find a file", "grep the project", "split the screen", "new session").
Start here.

## Install

```sh
./install
```

This symlinks each tool's config into place (`~/.config/nvim`, `~/.tmux.conf`,
Ghostty's config, zsh, etc.). After the first launch:

- **Neovim** bootstraps LazyVim and installs plugins + language servers
  (intelephense for PHP, Volar/vtsls for Vue) automatically.
- **tmux** — press `prefix I` (`Ctrl-Space`, then `I`) once to install plugins.

## Layout

| Path | What |
| --- | --- |
| `nvim/` | Live Neovim config (LazyVim). |
| `nvim2/` | Archived previous Neovim config — reference only, not symlinked. |
| `ghostty/` | Ghostty terminal config (Rose Pine theme). |
| `tmux/` | tmux config (sessions-as-tabs, ergonomic splits, plugins). |
| `zsh/` | Shell config and aliases. |
| `alacritty/`, `kitty/`, `wezterm/`, `zellij/` | Legacy terminal configs, left as-is. |
| `install` | Symlink installer. |
