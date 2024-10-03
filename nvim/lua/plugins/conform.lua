return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                blade = { "blade-formatter" },
                vue = { "prettier" },
                lua = { "styleua " },
            },
            notify_on_error = true,
            formatters = {
                php = {
                    command = "php-cs-fixer",
                    args = {
                        "fix",
                        "$FILENAME",
                        "--config=./vendor/bin/php-cs-fixer fix.php --config=.php-cs-fixer.dist.php -v",
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
}
