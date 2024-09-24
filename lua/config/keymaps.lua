vim.keymap.set("n", "<leader>tn", function()
  require("neotest").run.run()
end)
