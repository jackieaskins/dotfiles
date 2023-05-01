local function has_vtsls()
  return vim.g.supported_servers and vim.tbl_contains(vim.g.supported_servers, 'vtsls')
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'folke/neodev.nvim',
    'hrsh7th/nvim-cmp',
    { 'yioneko/nvim-vtsls', enabled = has_vtsls() },
  },
  config = function()
    local servers = require('lsp.servers')

    require('lspconfig.ui.windows').default_options.border = vim.g.border_style

    if has_vtsls() then
      require('lspconfig.configs').vtsls = require('vtsls').lspconfig
    end

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
        local base_config = require('lsp.base_config')()
        local config = server.config and server.config(base_config) or base_config
        require('lspconfig')[server_name].setup(config)
      end
    end
  end,
}
