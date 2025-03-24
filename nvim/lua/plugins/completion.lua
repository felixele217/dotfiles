return {
  'saghen/blink.cmp',
  dependencies = {
    'giuxtaposition/blink-cmp-copilot',
    'rafamadriz/friendly-snippets',
  },
  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- show function signature while filling arguments
    -- signature = { enabled = true },

    keymap = { preset = 'default' },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
      kind_icons = {
        Copilot = '',
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
      providers = {
        copilot = {
          name = 'copilot',
          module = 'blink-cmp-copilot',
          score_offset = 100,
          async = true,

          transform_items = function(_, items)
            local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = 'Copilot'
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },
      },
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = 'rounded' },
      },
      ghost_text = { enabled = true },
      menu = {
        draw = {
          align_to = 'label', -- or 'none' to disable, or 'cursor' to align to the cursor
          padding = 1,
        },
      },
    },
  },
}
