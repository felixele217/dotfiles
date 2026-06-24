return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "main", -- main | moon | dawn
      dark_variant = "main",
      styles = {
        italic = false,
        transparency = true,
      },
    },
  },

  -- Tell LazyVim to use rose-pine as the active colorscheme.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
