return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "onsails/lspkind.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "onsails/lspkind-nvim",
    },

    opts = function(_, opts)
        local cmp = require("cmp")
        local lspkind = require("lspkind")

        -- cmp.setup.filetype('sql', {
        --     sources = cmp.config.sources({
        --         { name = "vim-dadbod-completion" },
        --         { name = "buffer" },
        --     })
        -- })

        opts.mapping = vim.tbl_extend("force", opts.mapping, {
            -- ["<Tab>"] = cmp.mapping.confirm({ select = true }),
            ["<CR>"] = function(fallback)
                cmp.abort()
                fallback()
            end,
            -- ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            -- ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        })

        opts.experimental = {
            ghost_text = false,
        }

        opts.sources = {
            { name = "snippets" },
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
            snippets = "Snippet"
        }

        opts.formatting = {
            fields = { "kind", "abbr", "menu" },
            format = lspkind.cmp_format({
                mode = "symbol",
                maxwidth = 50,
                before = function(entry, vim_item)
                    local source_name = source_map[entry.source.name] or entry.source.name
                    local kind_display = vim_item.kind ~= source_name and vim_item.kind .. " " or ""
                    vim_item.menu = kind_display .. "[" .. source_name .. "]"

                    vim_item.menu_hl_group = "SpecialComment"

                    return vim_item
                end,
            }),
        }
    end,
}
