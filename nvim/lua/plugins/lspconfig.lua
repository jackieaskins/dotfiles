return {
  'neovim/nvim-lspconfig',
  config = function()
    local servers = require('lsp.servers')

    require('lspconfig.ui.windows').default_options.border = vim.g.border_style

    if require('utils').file_exists('~/dotfiles/nvim/lua/custom/lspconfig.lua') then
      require('custom.lspconfig')
    end

    require('neodev').setup({
      library = {
        plugins = { 'catppuccin', 'nvim-treesitter', 'plenary.nvim' },
      },
    })

    for server_name, server in pairs(servers) do
      if server_name ~= 'tsserver' then
        local base_config = require('lsp.base_config')()
        local config = server.config and server.config(base_config) or base_config
        require('lspconfig')[server_name].setup(config)
      end
    end
  end,
  dependencies = { 'folke/neodev.nvim', 'hrsh7th/nvim-cmp' },
}
