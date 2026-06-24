return {
  -- LSP server overrides.
  --
  -- PHP: we standardise on intelephense rather than phpactor. Intelephense gives
  -- noticeably better out-of-the-box completion, signature help, and cross-file
  -- type inference for typical Laravel / framework PHP, with low setup. phpactor
  -- is great for refactoring but needs more tuning to match. The lang.php extra is
  -- imported in config/lazy.lua; here we just tune intelephense for the team's
  -- Laravel workflow (php-cs-fixer formatting + Laravel IDE Helper files).
  --
  -- WHICH PHP server runs is decided by `vim.g.lazyvim_php_lsp` (set to "intelephense"
  -- in config/options.lua), NOT here. The lang.php extra reads that global at
  -- module-load time: `local lsp = vim.g.lazyvim_php_lsp or "phpactor"`, then enables
  -- `[lsp]` and disables the other. The default is "phpactor"; if the global is unset,
  -- intelephense stays `enabled = false` and NO PHP server attaches — which presents
  -- as "gd/gr/K do nothing" / "No results found" (there is no semantic server to
  -- answer). That was the real root cause behind earlier reports; everything below is
  -- inert unless intelephense is the enabled server.
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
      -- populated and jumpable). First index of a large project + vendor can take
      -- ~60-90s; intelephense caches it under stdpath("data"), so later starts are
      -- near-instant. Hover/def/refs return empty until that first index settles —
      -- that latency is not a config bug. (phpactor is disabled by the extra because
      -- vim.g.lazyvim_php_lsp = "intelephense"; no override needed here.)
      servers = {
        -- Laravel LSP (laravel-ls/laravel-ls). Complements intelephense rather than
        -- competing with it: intelephense provides PHP semantics (types, methods,
        -- cross-file nav), while laravel_ls adds Laravel string-context awareness
        -- intelephense lacks — route() names, view()/Blade, config()/env keys,
        -- translations, app bindings — with hover, go-to-def and completion on those.
        -- lspconfig ships the config (cmd `laravel-ls`, filetypes php+blade, root
        -- marker `artisan`), so it only attaches inside a real Laravel project and
        -- stays quiet elsewhere. We keep .blade.php files on the default `php`
        -- filetype (so PHP highlighting/treesitter still applies); laravel_ls attaches
        -- to `php` too, so Blade files are covered without a separate blade filetype.
        -- It is pre-1.0 (alpha) but the only maintained, purpose-built Laravel server.
        laravel_ls = {},
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

  -- Hover noise on multi-client buffers (e.g. Vue: vue_ls + vtsls + tailwindcss +
  -- eslint). LazyVim binds `K` to core `vim.lsp.buf.hover()`, which aggregates ALL
  -- attached clients in one pass and only says "No information available" when EVERY
  -- client is empty. noice (shipped on by LazyVim's ui spec) replaces that with its
  -- own `vim.lsp.buf.hover` that uses `vim.lsp.buf_request` — a PER-CLIENT handler:
  -- every client with no hover result fires its own `vim.notify("No information
  -- available")`, so on a Vue symbol the real hover shows AND each empty client (e.g.
  -- tailwindcss, eslint) pops a spurious notify (the "appears twice" report). We turn
  -- off noice's hover override so `K` falls back to core's aggregating hover. noice's
  -- markdown styling (convert_input_to_markdown_lines / stylize_markdown overrides)
  -- still applies to the core float, and a genuine no-hover spot still reports once.
  {
    "folke/noice.nvim",
    optional = true,
    opts = {
      lsp = {
        hover = { enabled = false },
      },
    },
  },

  -- Make sure the PHP + Laravel servers and php-cs-fixer are auto-installed via Mason.
  -- `laravel-ls` is the mason package name for the laravel_ls server enabled above.
  -- NOTE: the plugin moved orgs from williamboman/mason.nvim to mason-org/mason.nvim;
  -- using the old name causes a startup error.
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "intelephense", "laravel-ls", "php-cs-fixer" })
    end,
  },
}
