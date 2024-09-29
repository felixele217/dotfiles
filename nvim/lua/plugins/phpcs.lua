-- Ensure this is part of your LazyVim configuration setup
local function setup_php_cs_fixer()
  -- Create an augroup to group related autocommands
  local augroup = vim.api.nvim_create_augroup("PHPFormatter", { clear = true })

  -- Define the autocommand to run php-cs-fixer on save
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup,
    pattern = "*.php",
    callback = function()
      local file = vim.fn.expand("%:p") -- Get the full path of the current file
      vim.cmd("silent! !./vendor/bin/php-cs-fixer fix --config=.php-cs-fixer.dist.php " .. file)
    end,
  })
end

-- Call the setup function during initialization
setup_php_cs_fixer()

return {}

