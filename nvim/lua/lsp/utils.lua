local M = {}

---@class TypescriptInlayHintsSettings
---@field includeInlayEnumMemberValueHints boolean
---@field includeInlayFunctionLikeReturnTypeHints boolean
---@field includeInlayFunctionParameterTypeHints boolean
---@field includeInlayParameterNameHints string
---@field includeInlayParameterNameHintsWhenArgumentMatchesName boolean
---@field includeInlayPropertyDeclarationTypeHints boolean
---@field includeInlayVariableTypeHints boolean
---@field includeInlayVariableTypeHintsWhenTypeMatchesName boolean

---@type TypescriptInlayHintsSettings
M.typescript_inlay_hint_settings = {
  includeInlayEnumMemberValueHints = true,
  includeInlayFunctionLikeReturnTypeHints = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayParameterNameHints = 'all',
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayVariableTypeHints = false,
  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
}

---Return whether the provided lsp server is supported
---@param server string
---@return boolean
function M.is_server_supported(server)
  return not vim.g.supported_servers or vim.tbl_contains(vim.g.supported_servers, server)
end

---Return lsp server display name or default server name
---@param server_name string
---@return string
function M.get_server_display_name(server_name)
  return require('lsp.servers')[server_name].display or server_name
end

return M
