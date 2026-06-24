return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          -- File finder: surface dot-dirs (.claude, .github, ...).
          -- Still respects .gitignore, so node_modules/vendor stay out.
          -- .git/ is always excluded by snacks regardless of `hidden`.
          files = { hidden = true },
          -- Live grep: also search hidden dot-dirs AND gitignored files
          -- (`ignored = true` -> rg --no-ignore). Keep the big ignored
          -- dirs out so results aren't flooded; .git/ stays excluded.
          grep = {
            hidden = true,
            ignored = true,
            exclude = { "node_modules", "vendor" },
          },
        },
      },
    },
  },
}
