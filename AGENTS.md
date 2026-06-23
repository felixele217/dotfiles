# Project agent memory

This file is the project's committed home for project-intrinsic agent knowledge: build, test, release, architecture, and sharp-edge notes that should travel with the code.

- Add durable project-specific notes here as they are discovered through real work.

## Layout & install
- `install` is a symlink installer. It symlinks `nvim/`, `tmux/.tmux.conf`, `ghostty/config`, `zsh/`, and the legacy terminals into place. Changing a config's location means updating `install`.
- `nvim/` is the **live** Neovim config (LazyVim). `nvim2/` is an **archived backup** of the previous custom config — it is NOT symlinked by `install` and should not be linked.
- Legacy terminal configs (`alacritty/`, `kitty/`, `wezterm/`, `zellij/`) are intentionally left untouched; don't refit them without being asked.

## Neovim (LazyVim)
- Standard LazyVim starter structure: `lua/config/` + `lua/plugins/`. Keep changes idiomatic LazyVim (plugin spec overrides), not bespoke structure.
- Colorscheme is **rose-pine** (set via `LazyVim` opts in `lua/plugins/colorscheme.lua`).
- File explorer is **oil.nvim**, not neo-tree (neo-tree is disabled). Open with `-` or `<leader>e`.
- PHP LSP is **intelephense** (chosen over phpactor); Vue uses `vue_ls`/Volar + vtsls via the `lang.vue` + `lang.typescript` extras. Extras are imported in `lua/config/lazy.lua` and tracked in `lazyvim.json`.
- `lazy-lock.json` is gitignored. Running a headless bootstrap with the real config symlinked writes `lazy-lock.json` into `nvim/` — harmless but stray; remove it.
- Syntax-check lua without plugins: `nvim --headless -u NONE -c "lua loadfile('<file>')" -c qa`.

## tmux
- Prefix is `C-Space`. Model: **sessions act as tabs** — `prefix C-c` new session, `prefix s` picker, `prefix H`/`L` cycle, `prefix Space` last. Splits: `prefix |` (vertical), `prefix -` (horizontal).
- `detach-on-destroy off` is intentional (closing a session hops to another, not detach).
- Validate config parse: `tmux -L <sock> -f tmux/.tmux.conf new-session -d` then `kill-server`.

## ghostty
- Theme is the built-in **`Rose Pine`** (note the exact name: capitalized, with a space — `theme = rose-pine` does NOT resolve).
- Validate: `ghostty +validate-config --config-file=ghostty/config`.

## The guide
- `GUIDE.md` (repo root, linked from `README.md`) is the user-facing keybinding reference across all three tools. Keep it in sync when bindings change.
