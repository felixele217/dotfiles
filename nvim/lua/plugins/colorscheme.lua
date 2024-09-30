return {
    {
        "Mofiqul/vscode.nvim",
        config = function()
            require('vscode').setup({
                -- here config
            })
        end,
    },

    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "vscode",
        },
    },
}
