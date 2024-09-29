return {
    {
        "stevearc/conform.nvim",
        config = function()
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    php = { "php" },
                    blade = { "blade-formatter" },
                },
                format_on_save = {
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
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
            })
        end,
        keys = {
            {
                "<leader>cf",
                ":lua require('conform').format()<CR>",
                desc = "Format Current File",
            },
        },
    },
}
