local keymap = vim.keymap

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Close all open buffers
keymap.set("n", "<leader>Q", ":bufdo bdelete<CR>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Paste replace visual selection without copying it.
keymap.set("v", "p", '"_dP')

-- Reselect pasted text
keymap.set("n", "p", "p`[v`]")
keymap.set("n", "p", "p`[v`]")

keymap.set("n", "<leader>fp", ":let @+ = @%<CR>", { desc = "Copy current file path to clipboard" })
