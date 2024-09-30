local function run_php_cs_fixer_on_save()
    local augroup = vim.api.nvim_create_augroup("PHPFormatter", { clear = true })

    -- Define the autocommand to run php-cs-fixer on save
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = augroup,
        pattern = "*.php",
        callback = function()
            local file = vim.fn.expand("%:p") -- Get the full path of the current file
            vim.cmd("silent! !./vendor/bin/php-cs-fixer fix --config=.php-cs-fixer.dist.php " .. file)
        end,
    })
end

run_php_cs_fixer_on_save()

return {
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
