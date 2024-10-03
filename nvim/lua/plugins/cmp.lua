return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    -- 'hrsh7th/cmp-copilot',
    "onsails/lspkind-nvim",
  },

  opts = function(_, opts)
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<Tab>"] = cmp.mapping.confirm({ select = true }),
      ["<CR>"] = function(fallback)
        cmp.abort()
        fallback()
      end,
    })

    opts.experimental = {
      ghost_text = false,
    }

    opts.sources = {
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "text" },
      { name = "nvim_lsp_signature_help" },
      { name = "path" },
    }

    local source_map = {
      nvim_lsp = "LSP",
      buffer = "Buf",
      nvim_lsp_signature_help = "Signature",
      nvim_lua = "Lua",
      path = "Path",
      copilot = "Copilot",
    }

    opts.formatting = {
      format = lspkind.cmp_format({
        mode = "symbol",
        maxwidth = 50,
        ellipsis_char = "...",
        before = function(entry, vim_item)
          vim_item.menu = vim_item.kind .. " (" .. (source_map[entry.source.name] or entry.source.name) .. ")"
          vim_item.menu_hl_group = "SpecialComment"

          if vim_item.kind == "Color" and entry.completion_item.documentation then
            local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
            if r then
              local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
              local group = "Tw_" .. color
              if vim.fn.hlID(group) < 1 then
                vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
              end
              vim_item.kind_hl_group = group
              return vim_item
            end
          end

          return vim_item
        end,
      }),
    }
  end,
}
