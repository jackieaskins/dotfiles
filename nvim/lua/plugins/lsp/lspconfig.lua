---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  config = function()
    local servers = require('lsp.servers')
    local lspconfig = require('lspconfig')
    local configs = require('lspconfig.configs')

    if not configs['ghostty-ls'] then
      configs['ghostty-ls'] = {
        default_config = {
          cmd = { vim.fn.stdpath('data') .. '/lsp-servers/ghostty/bin/ghostty-ls' },
          filetypes = { 'ghostty' },
          root_dir = lspconfig.util.root_pattern('.git'),
          settings = {},
        },
      }
    end

    for server_name, config in pairs(MY_CONFIG.additional_server_configs) do
      if not configs[server_name] then
        configs[server_name] = config
      end
    end

    require('lspconfig.ui.windows').default_options.border = MY_CONFIG.border_style

    for _, server_name in ipairs(require('lsp.utils').get_supported_servers()) do
      local server = servers[server_name] or {}

      if not server.skip_lspconfig then
        lspconfig[server_name].setup(
          vim.tbl_extend(
            'force',
            { capabilities = require('lsp.capabilities')() },
            server.config and server.config() or {}
          )
        )
      end
    end
  end,
}
