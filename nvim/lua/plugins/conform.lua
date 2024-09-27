return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        blade = { "blade-formatter" },
      },
    },
    keys = {
      {
        "<leader>cf",
        ":lua require('conform').format()<CR>",
        desc = "Format Current File",
      },
    },
  },
}
