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
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            -- variant = "moon",
        }
    },

    { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = { flavour = "macchiato", } },

    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "rose-pine",
        },
    },
}
