---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  config = function()
    for server_name, server in pairs(require('lsp.utils').get_supported_servers()) do
      if not server.skip_lspconfig then
        vim.lsp.enable(server_name)
      end
    end
  end,
}
