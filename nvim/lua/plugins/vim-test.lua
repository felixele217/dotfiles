return {
    "vim-test/vim-test",
    dependencies = {
        "preservim/vimux"
    },
    config = function()
        vim.keymap.set("n", "<leader>tt", ":TestNearest<CR>", {})
        vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", {})
        -- vim.keymap.set("n", "<leader>a", ":TestSuite<CR>", {})
        vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", {})
        -- vim.keymap.set("n", "<leader>g", ":TestVisit<CR>", {})
        vim.cmd("let test#strategy = 'vimux'")
        vim.cmd("let test#php#phpunit#executable = 'php artisan test'")
    end,
}
