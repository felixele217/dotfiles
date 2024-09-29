return {
    lazy = true,
    "nvim-neotest/neotest",
    "nvim-neotest/nvim-nio",
    dependencies = {
        -- "V13Axel/neotest-pest",
        "olimorris/neotest-phpunit",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                -- require("neotest-pest"),
                require("neotest-phpunit"),
            },
        })
    end,
}
