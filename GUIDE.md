# The Ship's Guide ⚓

A field manual for this dotfiles setup — "the ship." It teaches you your own
tools: every keybinding worth knowing across **Ghostty** (the terminal),
**tmux** (the deck), and **Neovim** (the helm), organised both by tool and by
the task you're actually trying to do.

Everything here reflects what's committed in this repo. Run `./install` to
symlink it all into place.

---

## Quick reference — "I just want to…"

| I want to… | Where | Keys |
| --- | --- | --- |
| Find a file by name | nvim | `<leader>ff` |
| Grep the whole project | nvim | `<leader>/` |
| Open the file explorer | nvim | `-` (or `<leader>e`) |
| Go to definition | nvim | `gd` |
| Rename a symbol | nvim | `<leader>cr` |
| Split the screen left/right | tmux | `prefix \|` |
| Split the screen top/bottom | tmux | `prefix -` |
| New "tab" (session) | tmux | `prefix C-c` |
| Jump between "tabs" | tmux | `prefix H` / `prefix L` |
| Pick a session from a list | tmux | `prefix s` |
| Move between splits | tmux/nvim | `Ctrl-h/j/k/l` |

> **`prefix`** is `Ctrl-Space`. Press and release it, then press the next key.
> **`<leader>`** (in nvim) is `Space`.

---

## tmux — the deck

tmux is where the workflow lives. Ghostty just hands keystrokes straight
through to it, so almost all of the "window management" happens here.

### The prefix

Every tmux command starts with the **prefix**: `Ctrl-Space`. Throughout this
guide, `prefix x` means "press `Ctrl-Space`, let go, then press `x`."

### Sessions are your tabs

This is the core idea of the setup. Instead of juggling tmux *windows*, **each
project (or task) gets its own tmux session**, and you flip between sessions
the way you'd flip between browser tabs. A session remembers its own panes,
working directories, and layout, so switching projects is instant and
lossless.

| Action | Keys | Notes |
| --- | --- | --- |
| New session (named) | `prefix C-c` | Prompts for a name — type the project name |
| Session picker | `prefix s` | A zoomed `choose-tree` list of all sessions; arrow/`j`/`k` + Enter |
| Next session | `prefix L` | Repeatable — hold and tap `L` to cycle forward |
| Previous session | `prefix H` | Repeatable — cycle backward |
| Last session (alt-tab) | `prefix Space` | Bounce between the two sessions you use most |
| Rename current session | `prefix R` | Pre-filled with the current name |

Because `detach-on-destroy` is **off**, closing the last pane of a session
drops you onto another session instead of kicking you out of tmux — closing a
"tab" just lands you on the next one.

Day to day: start a session per repo (`prefix C-c`, name it), build out panes
inside it, and use `prefix H`/`L` or `prefix s` to move between projects. Your
sessions survive restarts thanks to `resurrect` + `continuum` (below).

### Splits (panes)

Splits are at the tmux layer, so they work identically no matter what terminal
hosts tmux. Both open in the **current pane's directory**.

| Action | Keys | Mnemonic |
| --- | --- | --- |
| Vertical split (side by side) | `prefix \|` | `\|` looks like a vertical divider |
| Horizontal split (stacked) | `prefix -` | `-` looks like a horizontal divider |

### Moving between panes

Two ways, both work:

- **`Ctrl-h/j/k/l`** — seamless movement that also jumps in and out of Neovim
  splits (via `vim-tmux-navigator`). No prefix needed. This is the one to use.
- **`prefix h/j/k/l`** — the explicit tmux-only version.

### Other tmux bindings

| Action | Keys |
| --- | --- |
| Reload this config | `prefix r` |
| Toggle the status bar | `prefix _` |
| Mouse support | on (click panes, drag borders, scroll) |

### The status line

The status line lives at the **top** of the screen and is **transparent** — its
background is `default`, so ghostty's terminal background (and any window
transparency) shows straight through. Only the segment "pills" carry colour,
all drawn from the **rose-pine** palette so tmux, ghostty, and Neovim match.

- **Left — windows as tabs.** Each window is a tab. The active window is a
  rounded **gold pill** (`#I: #F #W` → index, flags, name) with dark text;
  inactive windows are dim and plain. A 󰊓 marks a zoomed pane.
- **Right — clock + session.** A subtle `YYYY-MM-DD HH:MM` clock, a 󰌌 that
  lights up (love/pink) while the **prefix** is held, then the current
  **session name** in its own rounded **iris pill**.

It's hand-rolled directly in `tmux/.tmux.conf` (no status-line plugin), so the
colours and layout are fully under the repo's control. `prefix _` still toggles
the whole bar off/on.

### Plugins (managed by tpm)

- `tpm` — the plugin manager. Install plugins with `prefix I`, update with `prefix U`.
- `tmux-resurrect` + `tmux-continuum` — auto-save and auto-restore sessions
  (including pane contents) across reboots.
- `vim-tmux-navigator` — the `Ctrl-h/j/k/l` seamless nav above.

The status line is **hand-rolled** in `tmux/.tmux.conf` (see above), not a
plugin.

> First-time setup: press `prefix I` (capital I) once to fetch the plugins.

---

## Ghostty — the hull

Ghostty is the terminal that hosts everything. The config is deliberately
small; window/pane management is delegated to tmux.

- **Theme:** `Rose Pine` (Ghostty's built-in). This is the source of the soft
  rose/iris palette across the whole setup.
- **Font:** JetBrainsMono Nerd Font, size 16, with extra cell height and
  horizontal padding for breathing room.
- **Window state** is saved between launches.

Splitting is done in **tmux**, not Ghostty — so there's one mental model for
panes regardless of context (see the tmux splits above). Ghostty's own
defaults (e.g. `Cmd-T` tabs, `Cmd-N` new window) still work if you ever want a
bare terminal, but the day-to-day flow is tmux sessions + tmux splits.

---

## Neovim — the helm

A fresh [LazyVim](https://www.lazyvim.org/) setup. LazyVim gives you a curated
baseline; this repo layers on rose-pine, oil.nvim, and the PHP/Vue language
servers. The full reference for any default lives at lazyvim.org, but the
essentials are below.

> The **leader key** is `Space`. Most custom commands are `Space` followed by a
> letter or two. After pressing `Space`, **which-key** pops up a menu showing
> what's available — you can always discover bindings by waiting a beat.

### Finding things

| Action | Keys |
| --- | --- |
| **Find files** (by name, project root) | `<leader>ff` |
| Find files (current working dir) | `<leader>fF` |
| **Live grep** (search file contents project-wide) | `<leader>/` |
| Grep the word under the cursor | `<leader>sw` |
| Recent files | `<leader>fr` |
| Open buffers | `<leader>,` |
| Help tags | `<leader>sh` |
| Resume last picker | `<leader>sR` |

These use LazyVim's default fuzzy picker. Type to filter; `Enter` opens;
`Ctrl-j`/`Ctrl-k` move; `Esc` closes.

**Hidden & ignored files.** The file finder includes hidden dot-dirs
(`.claude`, `.github`, …) so dotfiles are searchable; it still respects
`.gitignore`, so `node_modules/`/`vendor/` stay out. Live grep goes further and
also searches **gitignored** files (so generated/local files are greppable),
excluding only the bulky `node_modules/`/`vendor/` dirs. `.git/` internals are
never shown in either.

### File explorer — oil.nvim

This setup replaces the tree-style explorer with **oil.nvim**: you edit your
filesystem like a normal buffer. Rename a file by editing its line, delete by
deleting the line, create by adding one — then write (`:w`) to apply.

| Action | Keys |
| --- | --- |
| Open parent directory in oil | `-` |
| Open oil (explorer) | `<leader>e` |
| Go up a directory | `-` (again, inside oil) |
| Open file / enter directory | `Enter` |
| Close oil | `q` |

Hidden files are shown by default.

### LSP — code intelligence

Language servers are auto-installed via **Mason** on first launch. These
bindings work in any file with an active LSP:

| Action | Keys |
| --- | --- |
| **Go to definition** | `gd` |
| Go to references | `gr` |
| Go to implementation | `gI` |
| Go to type definition | `gy` |
| **Hover docs** | `K` |
| Signature help | `gK` |
| **Code action** (quick fixes, imports) | `<leader>ca` |
| **Rename symbol** | `<leader>cr` |
| Line diagnostics | `<leader>cd` |
| Next / previous diagnostic | `]d` / `[d` |
| Format buffer | `<leader>cf` |

### How PHP & Vue are wired

- **PHP → intelephense.** Chosen over phpactor as the default: intelephense
  gives stronger out-of-the-box completion, signature help, and cross-file type
  inference for typical framework/Laravel code with essentially zero tuning.
  phpactor is excellent for heavy refactoring but needs more configuration to
  match day-to-day ergonomics. It's installed automatically via Mason.
  - **How the server is selected.** The active PHP server is chosen by
    `vim.g.lazyvim_php_lsp = "intelephense"` in `nvim/lua/config/options.lua`. The
    `lang.php` extra defaults this to `"phpactor"`, so this line is what actually
    enables intelephense (and disables phpactor). It must live in `options.lua`
    because the extra reads the global at load time, before plugin specs build.
    **This was the real bug behind earlier "gd/gr/K do nothing" reports:** the global
    was unset *and* phpactor was disabled, so no PHP server attached at all — there
    was simply nothing to answer hover/definition/references. To prefer phpactor
    instead, change this one global.
  - **Navigation:** `gd` → definition, `gr` → references, `K` → hover docs — the
    standard LazyVim/snacks-picker LSP keymaps (we don't override them in `lsp.lua`;
    overriding `gd`/`gr` back to the raw handlers is a *separate* footgun that also
    breaks them, so they stay unset). They jump into project classes *and* `vendor/`
    once intelephense has indexed the workspace — so the project needs a
    `composer.json` (or `.git`) root and a populated `vendor/` (`composer install`)
    for vendor definitions to resolve.
  - **Indexing caveat.** The first index of a large project + `vendor/` can take
    ~60–90s; until it settles, hover/definition/references return empty. That is
    indexing latency, not a misconfiguration. Intelephense caches the index under
    `stdpath("data")`, so subsequent starts are near-instant.
  - **Diagnostics posture (no docblock nagging).** The team doesn't enforce
    phpdoc — formatting is php-cs-fixer and types come from IDE Helper files, not
    docblocks. The `lang.php` extra turns on **phpcs** via nvim-lint, whose
    default standard spams `Missing doc comment for function ...`; that linter is
    disabled for PHP. Intelephense stays the diagnostics source and keeps the
    *actionable* errors on — undefined methods/types, type errors, argument
    counts — while the noisy `unusedSymbols` signal is off.
  - **Formatting → php-cs-fixer.** `<leader>cf` and format-on-save run
    php-cs-fixer for PHP buffers (via conform.nvim). It prefers a project-local
    `vendor/bin/php-cs-fixer` and runs at the `composer.json` root, so a project
    `.php-cs-fixer.php` / `.php-cs-fixer.dist.php` is picked up automatically.
    Installed via Mason (package `php-cs-fixer`).
  - **Laravel IDE Helper.** Intelephense indexes `_ide_helper.php`,
    `_ide_helper_models.php`, and `.phpstorm.meta.php` so model/facade completion
    works. The file-size cap is raised to 5 MB (`intelephense.files.maxSize`) so
    a large `_ide_helper_models.php` isn't silently skipped, and the helper files
    are not in the exclude list. Regenerate them with
    `php artisan ide-helper:generate` / `ide-helper:models`.
  - **Laravel awareness → laravel_ls.** Alongside intelephense we run
    [`laravel-ls`](https://github.com/laravel-ls/laravel-ls) (Mason package
    `laravel-ls`, lspconfig server `laravel_ls`). It adds the Laravel
    string-context intelephense can't see — `route()` names, `view()`/Blade,
    `config()`/`env()` keys, translations, app bindings — with hover, go-to-def
    and completion on those. lspconfig attaches it to `php` + `blade` filetypes
    with an `artisan` root marker, so it only activates inside a real Laravel
    project and stays quiet elsewhere; it does **not** displace intelephense (the
    two cover different ground and run together). `.blade.php` files stay on the
    default `php` filetype, so PHP highlighting still applies and laravel_ls still
    covers them. It is pre-1.0 (alpha) — expect occasional rough edges.
- **Vue → vue_ls (Volar) + vtsls.** Vue's language server needs a companion
  TypeScript server with the `@vue/typescript-plugin` so that `.vue` files and
  the surrounding TS/JS understand each other. This is handled by LazyVim's
  `lang.vue` + `lang.typescript` extras, imported in `nvim/lua/config/lazy.lua`.
  - **Hover noise fix.** Vue buffers attach several clients (vue_ls, vtsls,
    tailwindcss, eslint). noice (shipped on by LazyVim) replaces `K`'s hover with a
    *per-client* handler, so every client with no result popped its own
    `No information available` notify even while another showed the real hover
    (it appeared "twice"). We disable noice's hover override
    (`lsp.hover.enabled = false` in `nvim/lua/plugins/lsp.lua`) so `K` falls back to
    core `vim.lsp.buf.hover`, which aggregates all clients and only reports
    `No information available` when *every* client is empty. noice still styles the
    hover markdown, and a genuine no-hover spot still reports once. This applies to
    any multi-client buffer, not just Vue.

### Managing the setup

| Action | Command |
| --- | --- |
| Plugin manager UI | `<leader>l` or `:Lazy` |
| Install/update plugins | `:Lazy sync` |
| LSP/tool installer | `:Mason` |
| Toggle LazyVim extras | `:LazyExtras` |
| Health check | `:checkhealth` |

---

## Layout of the ship

```
nvim/        fresh LazyVim config (this is what's symlinked & used)
nvim2/       the previous custom Neovim config, kept as a reference/backup
ghostty/     Ghostty terminal config (Rose Pine)
tmux/        tmux config (sessions-as-tabs, splits, plugins)
zsh/         shell config & aliases
install      symlinks everything into place
```

`nvim2/` is **not** symlinked by `install` — it's purely an archive of the old
config in case you want to crib a setting from it. The live config is `nvim/`.

---

## Cheat sheet by task (full)

**Move around**
- Between splits/panes: `Ctrl-h/j/k/l` (works across tmux *and* nvim)
- Between sessions/"tabs": `prefix H` / `prefix L`, or `prefix s` to pick

**Open code**
- Find a file: `<leader>ff` · Grep the project: `<leader>/`
- Browse the filesystem: `-` (oil)

**Edit code**
- Definition: `gd` · Hover: `K` · Rename: `<leader>cr` · Code action: `<leader>ca`

**Arrange the screen**
- Vertical split: `prefix |` · Horizontal split: `prefix -`
- New session: `prefix C-c` · Rename session: `prefix R`

Fair winds. 🌊
