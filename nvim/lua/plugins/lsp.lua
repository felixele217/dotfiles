return {
  -- LSP server overrides.
  --
  -- PHP: we standardise on intelephense rather than phpactor. Intelephense gives
  -- noticeably better out-of-the-box completion, signature help, and cross-file
  -- type inference for typical Laravel / framework PHP, with low setup. phpactor
  -- is great for refactoring but needs more tuning to match. The lang.php extra is
  -- imported in config/lazy.lua; here we just pick the server and tune it for the
  -- team's Laravel workflow (php-cs-fixer formatting + Laravel IDE Helper files).
  --
  -- Vue: the lang.vue + lang.typescript extras wire up vue_ls (Volar) together with
  -- vtsls and the @vue/typescript-plugin, which is the TS setup Vue's LSP needs.
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- LSP nav keymaps (gd/gr/gI/K/...) are owned by LazyVim's global list and the
      -- snacks-picker extra (gd -> Snacks.picker.lsp_definitions, gr -> lsp_references).
      -- We deliberately do NOT override them here: this LazyVim version *extends*
      -- `servers["*"].keys` onto that global list (opts_extend = "servers.*.keys") and
      -- applies it last, so a manual `{ "gd", vim.lsp.buf.definition }` / `{ "gr",
      -- vim.lsp.buf.references }` actually WINS over the picker and reverts PHP nav to
      -- the raw quickfix-dumping handlers — which is exactly what reads as "gr does
      -- nothing". Leaving these unset keeps PHP on the same idiomatic picker nav as
      -- every other language; gd/gr/K then resolve into both project classes and
      -- vendor/ once intelephense has indexed a workspace root (composer.json or .git,
      -- always present in a Laravel project — run `composer install` so vendor/ is
      -- populated and jumpable).
      servers = {
        phpactor = { enabled = false },
        intelephense = {
          settings = {
            intelephense = {
              -- Diagnostics posture: the team does NOT enforce docblocks (they rely
              -- on php-cs-fixer + Laravel IDE Helper, not phpdoc). Intelephense itself
              -- does not emit "Missing doc comment" — that noise comes from phpcs (see
              -- the nvim-lint override below). Here we keep the genuinely useful,
              -- actionable diagnostics on (undefined methods/types, type errors,
              -- argument counts) so real bugs still surface.
              diagnostics = {
                enable = true,
                undefinedTypes = true,
                undefinedFunctions = true,
                undefinedConstants = true,
                undefinedClassConstants = true,
                undefinedMethods = true,
                undefinedProperties = true,
                undefinedVariables = true,
                undefinedSymbols = true,
                typeErrors = true,
                argumentCount = true,
                -- Quiet the noisier, non-actionable signals for app code where
                -- IDE-helper magic and framework patterns trip false positives.
                unusedSymbols = false,
                unexpectedTokens = true,
              },
              files = {
                -- Laravel IDE Helper compatibility: _ide_helper_models.php can grow
                -- well past intelephense's 1 MB default, after which the file is
                -- skipped and model/facade completion silently breaks. Raise the cap
                -- and make sure the helper files are NOT excluded from indexing.
                maxSize = 5000000,
                exclude = {
                  "**/.git/**",
                  "**/.svn/**",
                  "**/.hg/**",
                  "**/CVS/**",
                  "**/.DS_Store/**",
                  "**/node_modules/**",
                  "**/bower_components/**",
                  "**/vendor/**/{Tests,tests}/**",
                  "**/.history/**",
                  "**/vendor/**/vendor/**",
                },
              },
            },
          },
        },
      },
    },
  },

  -- Formatting: php-cs-fixer is the team standard (the lang.php extra already maps
  -- conform's php_cs_fixer formatter to php). We re-declare it explicitly so the
  -- intent is visible and so format-on-save / <leader>cf always use php-cs-fixer for
  -- PHP buffers. The conform php_cs_fixer formatter prefers the project-local
  -- vendor/bin/php-cs-fixer (then a global binary) and runs with cwd at the
  -- composer.json root, so a project .php-cs-fixer.php / .php-cs-fixer.dist.php is
  -- picked up automatically.
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "php_cs_fixer" },
      },
    },
  },

  -- Diagnostics noise: the lang.php extra turns on phpcs via nvim-lint, and phpcs's
  -- default standard emits "Missing doc comment for function ..." plus other style
  -- nags the team does not enforce (they use php-cs-fixer + IDE helpers). Disable
  -- phpcs linting for PHP so intelephense remains the diagnostics source for real
  -- errors without the docblock spam.
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        php = {},
      },
    },
  },

  -- Make sure the PHP server + php-cs-fixer are auto-installed via Mason.
  -- NOTE: the plugin moved orgs from williamboman/mason.nvim to mason-org/mason.nvim;
  -- using the old name causes a startup error.
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "intelephense", "php-cs-fixer" })
    end,
  },
}
