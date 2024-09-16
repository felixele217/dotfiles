return {
  { "catppuccin/nvim", name = "catppuccin" },
  { "navarasu/onedark.nvim" },
  { "folke/tokyonight.nvim" },

  -- Configure LazyVim to load One Dark
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
      style = "warm",
    },
  },
}
