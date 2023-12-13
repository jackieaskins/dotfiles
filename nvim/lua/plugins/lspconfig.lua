return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'folke/neodev.nvim',
    'hrsh7th/nvim-cmp',
    { 'yioneko/nvim-vtsls', enabled = require('lsp.utils').is_server_supported('vtsls') },
  },
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
      if not server.skip_lspconfig then
        local base_config = { capabilities = require('lsp.capabilities')() }
        local config = server.config and server.config(base_config) or base_config
        require('lspconfig')[server_name].setup(config)
      end
    end
  end,
}
