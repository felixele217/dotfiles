return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
    },
    config = function()
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'rounded',
        max_width = 100,
        max_height = 30,
      })

      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = 'rounded',
      })

      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1b1d2b' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#7dcfff', bg = '#1b1d2b' })
      vim.api.nvim_set_hl(0, 'FloatTitle', { fg = '#7dcfff', bold = true, bg = '#1b1d2b' })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, silent = true, desc = desc })
          end

          map('K', vim.lsp.buf.hover, 'LSP hover')
          map('gd', vim.lsp.buf.definition, 'LSP go to definition')
          map('gD', vim.lsp.buf.declaration, 'LSP go to declaration')
          map('gi', vim.lsp.buf.implementation, 'LSP go to implementation')
          map('gt', vim.lsp.buf.type_definition, 'LSP go to type definition')
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_blink, blink = pcall(require, 'blink.cmp')
      if ok_blink and blink.get_lsp_capabilities then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              },
            },
          },
        },
        intelephense = {
          settings = {
            intelephense = {
              environment = {
                includePaths = {
                  'vendor',
                  'vendor/laravel/framework/src',
                  'vendor/nesbot/carbon/src',
                },
              },
              files = {
                maxSize = 5000000,
              },
            },
          },
        },
        vue_ls = {},
      }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = capabilities
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
