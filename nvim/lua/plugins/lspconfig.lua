return {
  {
  "neovim/nvim-lspconfig",
  config = function()
    
  end
  },
{
    "mason-org/mason.nvim",
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }
  }
}
