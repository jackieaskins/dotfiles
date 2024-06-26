return {
  'neovim/nvim-lspconfig',
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    local servers = require('lsp.servers')
    local lspconfig = require('lspconfig')
    local configs = require('lspconfig.configs')

    if not configs['tmux-language-server'] then
      configs['tmux-language-server'] = {
        default_config = {
          cmd = { 'tmux-language-server' },
          filetypes = { 'tmux' },
          root_dir = function(fname)
            return lspconfig.util.find_git_ancestor(fname)
          end,
        },
      }
    end

    for server_name, config in pairs(vim.g.additional_servers) do
      if not configs[server_name] then
        configs[server_name] = config.lspconfig
      end
    end

    require('lspconfig.ui.windows').default_options.border = vim.g.border_style

    for server_name, server in pairs(servers) do
      if not server.skip_lspconfig then
        local base_config = { capabilities = require('lsp.capabilities')() }
        local config = server.config and server.config(base_config) or base_config
        lspconfig[server_name].setup(config)
      end
    end
  end,
}
