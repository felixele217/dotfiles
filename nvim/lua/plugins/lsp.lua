return {
  -- LSP server overrides.
  --
  -- PHP: we standardise on intelephense rather than phpactor. Intelephense gives
  -- noticeably better out-of-the-box completion, signature help, and cross-file
  -- type inference for typical Laravel / framework PHP, with low setup. phpactor
  -- is great for refactoring but needs more tuning to match. The lang.php extra is
  -- imported in config/lazy.lua; here we just pick the server.
  --
  -- Vue: the lang.vue + lang.typescript extras wire up vue_ls (Volar) together with
  -- vtsls and the @vue/typescript-plugin, which is the TS setup Vue's LSP needs.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {},
        phpactor = { enabled = false },
      },
    },
  },

  -- Make sure the PHP server is auto-installed via Mason.
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "intelephense" })
    end,
  },
}
