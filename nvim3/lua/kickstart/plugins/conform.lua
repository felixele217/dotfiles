return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        blade = { "blade-formatter" },
        vue = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        php = { "phpcsfixer", 'pint' },
      },
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
  },
}
-- vim: ts=2 sts=2 sw=2 et
