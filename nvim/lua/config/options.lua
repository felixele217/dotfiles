-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Use oil.nvim as the default file explorer instead of netrw.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- PHP LSP: intelephense, not the lang.php extra's phpactor default. This MUST be set
-- here (options.lua loads before plugin specs are imported) because the extra reads
-- `vim.g.lazyvim_php_lsp or "phpactor"` at module-load time to decide which server to
-- enable. Setting it in a plugin spec is too late and leaves intelephense disabled.
vim.g.lazyvim_php_lsp = "intelephense"

local opt = vim.opt

opt.relativenumber = true -- relative line numbers for fast motions
opt.wrap = false -- no soft-wrap by default
opt.scrolloff = 8 -- keep cursor away from screen edges
opt.confirm = true -- ask to save instead of failing on :q
