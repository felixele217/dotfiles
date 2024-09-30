return {
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",

    opts = function(_, opts)
        local luasnip = require("luasnip")
        local cmp = require("cmp")

        opts.mapping = vim.tbl_extend("force", opts.mapping, {
            ["<Tab>"] = cmp.mapping.confirm({ select = true }),
            ["<CR>"] = function(fallback)
                cmp.abort()
                fallback()
            end,
        })
    end,
}
