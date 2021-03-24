local function get_capabilities()
  local capabilities = require'lsp-status'.capabilities
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return capabilities
end

return get_capabilities()
