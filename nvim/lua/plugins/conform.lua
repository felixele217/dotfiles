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
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
      notify_on_error = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        blade = { 'blade-formatter' },
        vue = { 'prettier' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        php = { 'phpcsfixer', 'pint' },
      },
      formatters = {
        phpcsfixer = {
          command = 'php-cs-fixer',
          args = {
            'fix',
            '$FILENAME',
            '--config=.php-cs-fixer.dist.php',
            '-v',
          },
          stdin = false,
        },
      },
    },
  },
}
