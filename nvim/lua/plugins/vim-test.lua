return {
    "vim-test/vim-test",
    dependencies = {
        "preservim/vimux"
    },
    config = function()
        vim.keymap.set("n", "<leader>tt", ":silent TestNearest<CR>", {})
        vim.keymap.set("n", "<leader>tf", ":silent TestFile<CR>", {})
        vim.keymap.set("n", "<leader>tl", ":silent TestLast<CR>", {})

        -- vim.keymap.set("n", "<leader>a", ":TestSuite<CR>", {})
        -- vim.keymap.set("n", "<leader>g", ":TestVisit<CR>", {})
        vim.cmd("let test#strategy = 'vimux'")
        vim.cmd("let test#php#phpunit#executable = './vendor/bin/phpunit'")
    end,
}
