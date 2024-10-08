return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                blade = { "blade-formatter" },
                vue = { "prettier" },
                lua = { "styleua " },
                php = { "phpcsfixer" },
            },
            notify_on_error = true,
            formatters = {
                phpcsfixer = {
                    command = "php-cs-fixer",
                    args = {
                        "fix",
                        "$FILENAME",
                        "--config=.php-cs-fixer.dist.php",
                        "-v",
                    },
                    stdin = false,
                },
            },
        },
        keys = {
            {
                "<leader>cf",
                ":lua require('conform').format()<CR>",
                desc = "Format Current File",
            },
        },
    },
    {
        -- Remove phpcs linter.
        "mfussenegger/nvim-lint",
        optional = true,
        opts = {
            linters_by_ft = {
                php = {},
            },
        },
    },
}
