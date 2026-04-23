return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
        callback = function(event)
          local function has_method(method)
            return #vim.lsp.get_clients({ bufnr = event.buf, method = method }) > 0
          end

          local map = function(keys, method, func, desc)
            vim.keymap.set('n', keys, function()
              if not has_method(method) then
                vim.notify('No LSP client for ' .. method .. ' in this buffer', vim.log.levels.WARN)
                return
              end
              func()
            end, { buffer = event.buf, silent = true, desc = desc })
          end

          map('K', 'textDocument/hover', vim.lsp.buf.hover, 'LSP hover')
          map('gd', 'textDocument/definition', vim.lsp.buf.definition, 'LSP go to definition')
          map('gD', 'textDocument/declaration', vim.lsp.buf.declaration, 'LSP go to declaration')
          map('gi', 'textDocument/implementation', vim.lsp.buf.implementation, 'LSP go to implementation')
          map('gt', 'textDocument/typeDefinition', vim.lsp.buf.type_definition, 'LSP go to type definition')
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_blink, blink = pcall(require, 'blink.cmp')
      if ok_blink and blink.get_lsp_capabilities then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      local lspconfig = require('lspconfig')

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
        vtsls = {},
        vue = {},
      }

      require('mason-lspconfig').setup {}

      for server_name, server in pairs(servers) do
        if server_name ~= 'vue' then
          server.capabilities = capabilities
          lspconfig[server_name].setup(server)
        end
      end

      local vue_opts = vim.deepcopy(servers.vue)
      vue_opts.capabilities = capabilities

      -- `volar` and `vue_ls` naming differs across lspconfig versions.
      if not pcall(function()
        lspconfig.volar.setup(vue_opts)
      end) then
        pcall(function()
          lspconfig.vue_ls.setup(vue_opts)
        end)
      end
    end,
  },
}
