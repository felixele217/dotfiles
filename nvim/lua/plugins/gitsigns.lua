return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        delete = { text = ' ' },
        changedelete = { text = ' ' },
      },
    },
  },
}
