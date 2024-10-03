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
            buffer = "Buf",
            nvim_lsp = "LSP",
            nvim_lsp_signature_help = "Signature",
            nvim_lua = "Lua",
            path = "Path",
            copilot = "Copilot",
        }

        opts.formatting = {
            fields = { "kind", "abbr", "menu" },
            format = lspkind.cmp_format({
                mode = "symbol",
                maxwidth = 50,
                before = function(entry, vim_item)
                    vim_item.menu = "  " ..
                    vim_item.kind .. " (" .. (source_map[entry.source.name] or entry.source.name) .. ")"
                    vim_item.menu_hl_group = "SpecialComment"

                    return vim_item
                end,
            }),
        }
    end,
}
