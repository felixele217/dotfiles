return {
  -- copilot
  {
    'zbirenbaum/copilot.lua',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    end,
  },

  -- CopilotChat
  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   dependencies = {
  --     { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
  --     { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
  --   },
  --   build = 'make tiktoken', -- Only on MacOS or Linux

  --   keys = {
  --     { '<leader>av', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle' },
  --   },

  --   config = function()
  --     require('CopilotChat').setup {
  --       prompts = {
  --         Inertia = {
  --           system_prompt = 'When asked something about inertia the user is likely to refer to the technology for building web applications with Laravel and Vue as a tech stack. This is the documentation https://inertiajs.com/',
  --         },
  --         Vue = {
  --           system_prompt = 'When asked something about Vue, have in mind, that I am using the Vue Composition API and give me answers based on that knowledge https://vuejs.org/guide/extras/composition-api-faq.html#composition-api-faq',
  --         },
  --         PHPUnitTestClasses = {
  --           system_prompt = 'When writing PHP Unit test classes, please extend TestCase from use Tests\\TestCases\\TestCase',
  --         },
  --       },

  --       model = 'claude-3.5-sonnet',
  --       auto_insert_mode = true,
  --     }
  --   end,
  -- },

  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    cmd = 'CopilotChat',
    opts = function()
      local user = vim.env.USER or 'User'
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        question_header = '  ' .. user .. ' ',
        answer_header = '  Copilot ',
        window = {
          width = 0.4,
        },
      }
    end,
    keys = {
      { '<c-s>', '<CR>', ft = 'copilot-chat', desc = 'Submit Prompt', remap = true },
      { '<leader>a', '', desc = '+ai', mode = { 'n', 'v' } },
      {
        '<leader>aa',
        function()
          return require('CopilotChat').toggle()
        end,
        desc = 'Toggle (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ax',
        function()
          return require('CopilotChat').reset()
        end,
        desc = 'Clear (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>aq',
        function()
          vim.ui.input({
            prompt = 'Quick Chat: ',
          }, function(input)
            if input ~= '' then
              require('CopilotChat').ask(input)
            end
          end)
        end,
        desc = 'Quick Chat (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ap',
        function()
          require('CopilotChat').select_prompt()
        end,
        desc = 'Prompt Actions (CopilotChat)',
        mode = { 'n', 'v' },
      },
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'

      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-chat',
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  },
}
