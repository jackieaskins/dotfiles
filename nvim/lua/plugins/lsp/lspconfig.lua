---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  config = function()
    for server, config in pairs(require('lsp.servers')) do
      if not config.skip_lspconfig then
        vim.lsp.enable(server)
      end
    end
  end,
}
