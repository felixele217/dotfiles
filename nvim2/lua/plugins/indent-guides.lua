return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = {
        enabled = false,
      },
      whitespace = {
        remove_blankline_trail = false,
      },
    },
  },
}
