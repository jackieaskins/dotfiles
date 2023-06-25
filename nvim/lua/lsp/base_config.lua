return function()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return { capabilities = capabilities }
end
