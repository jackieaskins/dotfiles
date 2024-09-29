return function()
  local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')

  local file_operation_capabilities = {
    workspace = {
      fileOperations = {
        willRename = true,
        didRename = true,
        willCreate = true,
        didCreate = true,
        willDelete = true,
        didDelete = true,
      },
    },
  }

  if ok then
    return vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      cmp_nvim_lsp.default_capabilities(),
      file_operation_capabilities
    )
  end

  return vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), file_operation_capabilities)
end
