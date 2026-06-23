return {
  -- oil.nvim is the primary file explorer: edit your filesystem like a buffer.
  {
    "stevearc/oil.nvim",
    lazy = false, -- needed so oil can hijack directory buffers on startup
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-h>"] = false, -- keep <C-h> for tmux/window navigation
        ["q"] = "actions.close",
      },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory (Oil)" },
      { "<leader>e", "<cmd>Oil<cr>", desc = "Explorer (Oil)" },
      { "<leader>E", "<cmd>Oil<cr>", desc = "Explorer (Oil)" },
    },
  },

  -- Disable neo-tree: oil.nvim replaces it as the file explorer.
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
}
