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
local base_compatabilities =
  vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), file_operation_capabilities)

local M = {}

function M.get_capabilities()
  if MY_CONFIG.completion_source == 'cmp' then
    return vim.tbl_deep_extend('force', base_compatabilities, require('cmp_nvim_lsp').default_capabilities())
  end

  if MY_CONFIG.completion_source == 'blink' then
    return require('blink.cmp').get_lsp_capabilities(base_compatabilities, true)
  end

  return vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), file_operation_capabilities)
end

return M
