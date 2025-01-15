-- [[ Basic Keymaps ]]
--  See `:help keymap.set()`
local keymap = vim.keymap

-- Clear highlights on search when pressing <Esc> in normal mode
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
keymap.set('n', '<leader>qq', '<cmd>:q<CR>', { desc = 'Move focus to the upper window' })

-- Paste replace visual selection without copying it.
keymap.set('v', 'p', '"_dP')

-- Keep cursor at yanked position
keymap.set('v', 'y', 'mxy`x')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Copy file path
keymap.set('n', '<leader>fp', ':let @+ = @%<CR>', { desc = 'Copy current file path to clipboard' })

-- Open diagnostic from current line
keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
