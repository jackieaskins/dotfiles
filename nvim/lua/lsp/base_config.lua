return function()
  return {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    on_attach = require('lsp.attach'),
    flags = { debounce_text_changes = 150 },
  }
end
