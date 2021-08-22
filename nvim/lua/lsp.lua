local icons = require('lsp.icons')

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  { virtual_text = false, underline = true, update_in_insert = true, signs = true }
)
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })

for level, icon in pairs(icons) do
  local sign = 'LspDiagnosticsSign' .. level
  vim.fn.sign_define(sign, { text = icon })
end

function _G.GetServers()
  return table.concat(require('lsp.servers'), '\n')
end

vim.api.nvim_exec(
  [[
  command! LspLog vsplit ~/.cache/nvim/lsp.log
  command! LspUpdateAll lua require('lsp.update').update_all_servers()
  command! -nargs=1 -complete=custom,v:lua.GetServers LspUpdate lua require('lsp.update').update_servers(<f-args>)
]],
  true
)
