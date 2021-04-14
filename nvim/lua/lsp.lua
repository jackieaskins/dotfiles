local colors = require'colors'

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

local diagnostic_mappings = {
  Hint = {color = colors.fg, icon = ''},
  Information = {color = colors.cyan, icon = ''},
  Warning = {color = colors.orange, icon = ''},
  Error = {color = colors.red, icon = ''}
}

for level, mapping in pairs(diagnostic_mappings) do
  local highlight = 'LspDiagnosticsDefault' .. level
  vim.cmd(string.format('highlight %s guifg=%s', highlight, mapping.color))

  local sign = 'LspDiagnosticsSign' .. level
  vim.fn.sign_define(sign, {text = mapping.icon, texthl = sign})
end

require'lsp/configs'.add_configs()
require'lsp/servers'.setup_servers()

require'utils'.augroup('lsp_config', {
  {
    'BufReadCmd',
    'jdt://*',
    [[call luaeval('require"lsp/servers/jdtls".handle_jdt_uri(_A)', expand('<amatch>'))]]
  }
})
