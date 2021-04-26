local icons = require'my_lsp/icons'

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      spacing = 0
    },
    underline = true,
    signs = true,
  }
)
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'single'}
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = "single"}
)

for level, icon in pairs(icons) do
  local sign = 'LspDiagnosticsSign' .. level
  vim.fn.sign_define(sign, {text = icon})
end

require'my_lsp/configs'.add_configs()
require'my_lsp/servers'.setup_servers()

require'my_utils'.augroup('lsp_config', {
  {
    'BufReadCmd',
    'jdt://*',
    [[call luaeval('require"lsp/servers/jdtls".handle_jdt_uri(_A)', expand('<amatch>'))]]
  }
})
