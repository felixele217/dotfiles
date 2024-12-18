-- Fuzzy finder

return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'nvim-telescope/telescope-live-grep-args.nvim',
        'folke/trouble.nvim',
        'sharkdp/fd',
        {
            "isak102/telescope-git-file-history.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "tpope/vim-fugitive"
            }
        }
    },
    keys = {
        { '<leader>e', function() require("telescope.builtin").lsp_document_symbols({ symbols = { "method", "function" } }) end },
    },
    config = function()
        -- ignore regex while grep
        local conf = require('telescope.config').values
        table.insert(conf.vimgrep_arguments, '--fixed-strings')

        local open_with_trouble = require("trouble.sources.telescope").open

        require('telescope').setup({

            defaults = {
                mappings = {
                    i = { ["<c-t>"] = open_with_trouble },
                    n = { ["<c-t>"] = open_with_trouble },
                },
                path_display = { truncate = 1 },
                prompt_prefix = '   ',
                selection_caret = '  ',
                layout_config = {
                    prompt_position = 'top',
                },
                preview = {
                    treesitter = false,
                    timeout = 200,
                },
                sorting_strategy = 'ascending',
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                oldfiles = {
                    prompt_title = 'Search',
                },
                lsp_document_symbols = {
                    symbol_width = 55,
                },
            },
        })
        require("telescope").load_extension("git_file_history")
    end,
}
