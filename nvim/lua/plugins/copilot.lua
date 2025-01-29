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
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux

    keys = {
      { '<leader>av', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle' },
    },

    config = function()
      require('CopilotChat').setup {
        system_prompt = require('CopilotChat.prompts').COPILOT_INSTRUCTIONS
          .. 'When asked something about inertia the user is likely to refer to the technology for building web applications with Laravel and Vue as a tech stack. This is the documentation https://inertiajs.com/'
          .. '\n',

        auto_insert_mode = true,
      }
    end,
  },
}
