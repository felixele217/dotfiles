return {
  "nvim-neotest/neotest",
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
