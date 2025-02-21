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
          .. '\nWhen asked something about Vue, have in mind, that I am using the Vue Composition API and give me answers based on that knowledge https://vuejs.org/guide/extras/composition-api-faq.html#composition-api-faq'
          .. '\nWhen writing test classes, please extend TestCase from use Tests\\TestCases\\TestCase',

        model = 'claude-3.5-sonnet',
        auto_insert_mode = true,
      }
    end,
  },
}
