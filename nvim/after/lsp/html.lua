---@type vim.lsp.Config
return {
  on_attach = function(client, bufnr)
    require('lsp.utils').setup_auto_close_tag(client, bufnr, 'html/autoInsert')
  end,
}
